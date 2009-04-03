package com.mpower.util;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import net.sf.jasperreports.engine.JasperPrint;

import com.jaspersoft.jasperserver.api.metadata.xml.domain.impl.ResourceDescriptor;
import com.jaspersoft.jasperserver.irplugin.JServer;
import com.jaspersoft.jasperserver.irplugin.wsclient.WSClient;
import com.mpower.domain.ReportChartSettings;
import com.mpower.domain.ReportCrossTabColumn;
import com.mpower.domain.ReportCrossTabFields;
import com.mpower.domain.ReportCrossTabMeasure;
import com.mpower.domain.ReportCrossTabRow;
import com.mpower.domain.ReportField;
import com.mpower.domain.ReportFieldType;
import com.mpower.domain.ReportFilter;
import com.mpower.domain.ReportSelectedField;
import com.mpower.domain.ReportWizard;
import com.mpower.service.ReportCustomFilterDefinitionService;
import com.mpower.service.ReportFieldService;

import ar.com.fdvs.dj.core.DJConstants;
import ar.com.fdvs.dj.domain.ColumnProperty;
import ar.com.fdvs.dj.domain.DJCalculation;
import ar.com.fdvs.dj.domain.DJChart;
import ar.com.fdvs.dj.domain.DJChartOptions;
import ar.com.fdvs.dj.domain.DJCrosstab;
import ar.com.fdvs.dj.domain.DJCrosstabColumn;
import ar.com.fdvs.dj.domain.DJCrosstabRow;
import ar.com.fdvs.dj.domain.DynamicReport;
import ar.com.fdvs.dj.domain.Style;
import ar.com.fdvs.dj.domain.builders.ChartBuilderException;
import ar.com.fdvs.dj.domain.builders.ColumnBuilder;
import ar.com.fdvs.dj.domain.builders.ColumnBuilderException;
import ar.com.fdvs.dj.domain.builders.CrosstabBuilder;
import ar.com.fdvs.dj.domain.builders.CrosstabColumnBuilder;
import ar.com.fdvs.dj.domain.builders.CrosstabRowBuilder;
import ar.com.fdvs.dj.domain.builders.FastReportBuilder;
import ar.com.fdvs.dj.domain.constants.Border;
import ar.com.fdvs.dj.domain.constants.Font;
import ar.com.fdvs.dj.domain.constants.GroupLayout;
import ar.com.fdvs.dj.domain.constants.VerticalAlign;
import ar.com.fdvs.dj.domain.entities.DJGroup;
import ar.com.fdvs.dj.domain.entities.columns.AbstractColumn;
import ar.com.fdvs.dj.domain.entities.columns.PropertyColumn;
import ar.com.fdvs.dj.domain.entities.columns.SimpleColumn;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ReportGenerator {
	protected final Log logger = LogFactory.getLog(getClass());

	//private Style headerStyle;**
	//private Style headerVariables;
	private Style titleStyle;
	private Style defaultDetailStyle;
	private String reportServicesURI;
	private String reportUserName;
	private String reportPassword;
	private String reportCompany;
	private JServer server = null;
	private String reportUnitDataSourceURI;
	private Map params;
	private Map inputControls;
	private Integer columnIndex;

	public ReportGenerator() {
		params = new HashMap();
		inputControls = new HashMap();
		reportCompany = "Default";
	}

	public Map getInputControls() {
		return inputControls;
	}

	public Map getParams() {
		return params;
	}

	private void startServer() {
		if (server == null) {
			server = new JServer();
			server.setUsername(reportUserName);
			server.setPassword(reportPassword);
			server.setUrl(reportServicesURI);
		}
	}

	private void initStyles() {
		//headerStyle = new Style("header");

		//headerVariables = new Style("headerVariables");

		titleStyle = new Style("titleStyle");
		
		
	}

	private File getTemplateFile(ReportWizard wiz) throws Exception {
		startServer();

		//
		// get the report template file from the server
		File templateFile = File.createTempFile("template", ".jrxml");
		ResourceDescriptor templateRD = new ResourceDescriptor();

		templateRD.setWsType(ResourceDescriptor.TYPE_REPORTUNIT);
		templateRD.setUriString(wiz.getReportTemplateJRXML());
		ResourceDescriptor rd = server.getWSClient().get(templateRD, templateFile);

		return templateFile;
	}

	public DynamicReport Generate(ReportWizard wiz,javax.sql.DataSource jdbcDataSource, ReportFieldService reportFieldService, 
			ReportCustomFilterDefinitionService reportCustomFilterDefinitionService) throws Exception {
		resetInputControls();
		File templateFile = getTemplateFile(wiz);
		columnIndex = 0;
		initStyles();

		
		
		//
		//Build the main report
		//
		String reportTitle = wiz.getDataSubSource().getDisplayName() + " Custom Report";
		if (wiz.getReportName() != null && wiz.getReportName().length() > 0)
			reportTitle = wiz.getReportName();
		
		FastReportBuilder drb = new FastReportBuilder();
		Integer margin = new Integer(20);

		drb
		.setTitleStyle(titleStyle)
		.setTitle(reportTitle)					//defines the title of the report
		.setDetailHeight(new Integer(15))
		.setLeftMargin(margin).setRightMargin(margin).setTopMargin(margin).setBottomMargin(margin)
		.setAllowDetailSplit(false)
		.setIgnorePagination(true)
		.setUseFullPageWidth(true)
		.setWhenNoDataShowNoDataSection();
		
		//
		//Tabular and Summary Reports
		//
		if (wiz.getReportType().compareToIgnoreCase("matrix") != 0){
			List<ReportField> reportFieldsOrderedList = getSelectedReportFields(wiz, reportFieldService);
			drb = addColumnsAndGroups(reportFieldsOrderedList, wiz, drb, reportFieldService);
		}

		//
		//Matrix Reports
		//		
		if (wiz.getReportType().compareToIgnoreCase("matrix") == 0){
			DJCrosstab djcross = createCrosstab(wiz, reportFieldService, drb);
			drb.addFooterCrosstab(djcross);
		}

		//
		//Build query
		//
		ReportQueryGenerator reportQueryGenerator = new ReportQueryGenerator(wiz, 
				reportFieldService, reportCustomFilterDefinitionService);
		String query = reportQueryGenerator.getQueryString(); 

		List<ReportFilter> filters = wiz.getReportFilters();
		Iterator<ReportFilter> itFilter = filters.iterator();
		int index = 0;
		while (itFilter.hasNext()) {
			index++;
			ReportFilter filter = (ReportFilter)itFilter.next();

			if (filter == null || filter.getFilterType() != 1 || filter.getReportStandardFilter().getFieldId() == -1) continue; // this is an empty filter

			ReportField rf = reportFieldService.find(filter.getReportStandardFilter().getFieldId());

			String controlName = rf.getColumnName() + Integer.toString(index);

			if (filter.getReportStandardFilter().getPromptForCriteria()) {
				String operatorDisplayName = new String();
				switch (filter.getReportStandardFilter().getComparison()) {
				case 1:   	operatorDisplayName = " equals ";					break;
				case 3:   	operatorDisplayName = " less than ";				break;
				case 5:   	operatorDisplayName = " less than or equal to ";	break;
				case 4:   	operatorDisplayName = " greater than ";				break;
				case 6:   	operatorDisplayName = " greater than or equal to "; break;
				case 7:   	operatorDisplayName = " starts with "; 				break;
				case 8:   	operatorDisplayName = " ends with ";				break;
				case 9:   	operatorDisplayName = " contains ";
				}
				
				InputControlParameters ic = new InputControlParameters();
				ic.setLabel(rf.getDisplayName() + operatorDisplayName);
				ic.setType(rf.getFieldType());
				ic.setFilter(filter.getOperator());
				inputControls.put(controlName, ic);
			}

			if ( rf.getFieldType() == ReportFieldType.DATE) {
				if (filter.getReportStandardFilter().getPromptForCriteria()) {
					params.put(controlName, "java.util.Date");
					drb.addParameter(controlName, "java.util.Date");
				}								
			} else	if(rf.getFieldType() == ReportFieldType.STRING) {
				if (filter.getReportStandardFilter().getPromptForCriteria()) {
					params.put(controlName, "java.lang.String");
					drb.addParameter(controlName, "java.lang.String");
				}								
			} else if(rf.getFieldType() == ReportFieldType.DOUBLE) {
				if (filter.getReportStandardFilter().getPromptForCriteria()) {
					params.put(controlName, "java.lang.Double");
					drb.addParameter(controlName, "java.lang.Double");
				}								
			} else if(rf.getFieldType() == ReportFieldType.INTEGER) {
				if (filter.getReportStandardFilter().getPromptForCriteria()) {
					params.put(controlName, "java.lang.Integer");
					drb.addParameter(controlName, "java.lang.Integer");
				}								
			} else if(rf.getFieldType() == ReportFieldType.MONEY) {
				if (filter.getReportStandardFilter().getPromptForCriteria()) {					
					params.put(controlName, "java.lang.Double");
					drb.addParameter(controlName, "java.lang.Double");
				}							
			} else if(rf.getFieldType() == ReportFieldType.BOOLEAN) {
				if (filter.getReportStandardFilter().getPromptForCriteria()) {
					params.put(controlName, "java.lang.Boolean");
					drb.addParameter(controlName, "java.lang.Boolean");
				}								
			} 
		}

		logger.info(query);

		drb.setQuery(query, DJConstants.QUERY_LANGUAGE_SQL);
		drb.setTemplateFile(templateFile.getAbsolutePath());
		DynamicReport dr = drb.build();

		return dr;
	}

	/**
	 * Creates a crosstab Report using DynamicJasper.
	 * <P>
	 * The data must be sorted with the following criteria: row(1) , ..., row(n) , column(1) , ..., column(m)
	 * where row(1) is the outer-most row, row(n)is the inner-most row 
	 * and column(1) is the outer-most column, column(m) is the inner-most column 
	 * <P>
	 * {@code}DJCrosstab djcross = createCrosstab(wiz, reportFieldService);
	 * @param ReportWizard wiz
	 * @param ReportFieldService reportFieldService
	 * @return CrosstabBuilder cb
	 */
	private DJCrosstab createCrosstab(ReportWizard wiz, ReportFieldService reportFieldService, FastReportBuilder drb) throws ColumnBuilderException {

		//get the settings for the crosstab report
		ReportCrossTabFields reportCrossTabFields = wiz.getReportCrossTabFields();

		//Set up styling for matrix report
		
		Style CrossTabColRowHeaderStyle = Style.createBlankStyle("CrossTabColRowHeaderStyle");
		CrossTabColRowHeaderStyle.setFont(Font.ARIAL_MEDIUM_BOLD);
		CrossTabColRowHeaderStyle.setPaddingLeft(2);
		CrossTabColRowHeaderStyle.setVerticalAlign(VerticalAlign.MIDDLE);
		
		Style CrossTabColRowHeaderTotalStyle = Style.createBlankStyle("CrossTabColRowHeaderTotalStyle");
		CrossTabColRowHeaderTotalStyle.setFont(Font.ARIAL_MEDIUM_BOLD);
		CrossTabColRowHeaderTotalStyle.setPaddingLeft(2);
		CrossTabColRowHeaderTotalStyle.setVerticalAlign(VerticalAlign.MIDDLE);
		
		Style CrossTabTotalStyle = Style.createBlankStyle("CrossTabTotalStyle");
		CrossTabTotalStyle.setFont(Font.ARIAL_MEDIUM);
		CrossTabTotalStyle.setPaddingLeft(2);
		CrossTabTotalStyle.setVerticalAlign(VerticalAlign.MIDDLE);
		
		//
		//Create the crosstab builder
		CrosstabBuilder cb = new CrosstabBuilder();
		cb.setHeight(200)
		.setWidth(500)
		//The .setDatasource is not working correctly with JasperServer. We remove this generated code 
		//manually from the jrxml file before saving. (See the ReportFormWizardController removeCrossTabDataSubset.)
		.setDatasource(null,DJConstants.DATA_SOURCE_ORIGIN_USE_REPORT_CONNECTION, DJConstants.DATA_SOURCE_TYPE_SQL_CONNECTION)
		.setUseFullWidth(true)
		.setColorScheme(DJConstants.COLOR_SCHEMA_GRAY)
		.setAutomaticTitle(true)
		.setHeaderStyle(CrossTabColRowHeaderStyle)
		.setCellBorder(Border.THIN);
			
		String valueClassName = null;
		
		//These must be added in the same order as the ReportQueryGenerator.buildSelectFieldsForMatrix() method
		//
		//Add a Measure to the builder(can only have one)
		String operation = reportCrossTabFields.getReportCrossTabOperation();
		DJCalculation cgvo = null;
		
		
		List<ReportCrossTabMeasure> reportCrossTabMeasure = reportCrossTabFields.getReportCrossTabMeasure();
		Iterator itCTMeasure  = reportCrossTabMeasure.iterator();
		Integer columnIndex = 0;
		while (itCTMeasure.hasNext()){
			ReportCrossTabMeasure ctMeasure = (ReportCrossTabMeasure) itCTMeasure.next();
			if (ctMeasure != null && ctMeasure.getFieldId() != -1){
				ReportField fMeasure = reportFieldService.find(ctMeasure.getFieldId());
				valueClassName = getValueClassName(fMeasure);
				if (ctMeasure.getCalculation().compareToIgnoreCase("AVERAGE") == 0) cgvo = DJCalculation.AVERAGE;
				if (ctMeasure.getCalculation().compareToIgnoreCase("SUM") == 0) cgvo = DJCalculation.SUM;
				if (ctMeasure.getCalculation().compareToIgnoreCase("HIGHEST") == 0) cgvo = DJCalculation.HIGHEST;
				if (ctMeasure.getCalculation().compareToIgnoreCase("LOWEST") ==0) cgvo = DJCalculation.LOWEST;
				if (ctMeasure.getCalculation().compareToIgnoreCase("COUNT") ==0) cgvo = DJCalculation.COUNT;
				if (cgvo == null) cgvo = DJCalculation.COUNT;
				
				//set up style for measure to add the pattern/format for the different data types - money, dates, etc...
				String pattern = null;
				if ((cgvo == DJCalculation.AVERAGE || cgvo == DJCalculation.SUM) && fMeasure.getFieldType().toString().compareToIgnoreCase("MONEY") == 0){
					pattern = getPattern(fMeasure);
					CrossTabTotalStyle.setPattern(pattern);
					CrossTabColRowHeaderTotalStyle.setPattern(pattern);
				}
				if ((cgvo == DJCalculation.HIGHEST || cgvo == DJCalculation.LOWEST) && fMeasure.getFieldType().toString().compareToIgnoreCase("DATE") == 0){
					pattern = getPattern(fMeasure);
					CrossTabTotalStyle.setPattern(pattern);
					CrossTabColRowHeaderTotalStyle.setPattern(pattern);
				}
				
				//add the measure column to the dynamic report builder 
				AbstractColumn column = null;
				column = buildColumn(fMeasure, columnIndex);
				drb.addColumn(column);
				
				//now add the measure to the crosstab builder
				cb.addMeasure(column.getName(), valueClassName, cgvo, fMeasure.getDisplayName(), CrossTabTotalStyle );	
			}
			columnIndex++;
		}

		//
		//Add rows to the builder
		List<ReportCrossTabRow> reportCrossTabRows =	reportCrossTabFields.getReportCrossTabRows();
		Iterator itCTRows  = reportCrossTabRows.iterator();
		while (itCTRows.hasNext()){
			ReportCrossTabRow ctRow = (ReportCrossTabRow) itCTRows.next();
			if (ctRow != null && ctRow.getFieldId() != -1){
				ReportField fRow = reportFieldService.find(ctRow.getFieldId());
				valueClassName = getValueClassName(fRow);
				//add the row column to the dynamic report builder 
				AbstractColumn column = null;
				column = buildColumn(fRow, columnIndex);
				drb.addColumn(column);
				columnIndex++;
				
				//now add the row to the crosstab builder
				DJCrosstabRow row = new CrosstabRowBuilder().setProperty(column.getName(),valueClassName)
				.setHeaderWidth(100).setHeight(20).setTitle(fRow.getDisplayName()).setShowTotals(true)
				.setTotalStyle(CrossTabTotalStyle).setHeaderStyle(CrossTabColRowHeaderStyle).setTotalHeaderStyle(CrossTabColRowHeaderStyle)
				.setTotalStyle(CrossTabColRowHeaderTotalStyle).build();
				cb.addRow(row);	
			}
		}

		//
		//Add the columns to the builder
		List<ReportCrossTabColumn> reportCrossTabColumns =	reportCrossTabFields.getReportCrossTabColumns();
		Iterator itCTCols  = reportCrossTabColumns.iterator();
		while (itCTCols.hasNext()){
			ReportCrossTabColumn ctCol = (ReportCrossTabColumn) itCTCols.next();
			if (ctCol != null && ctCol.getFieldId() != -1){
				ReportField fCol = reportFieldService.find(ctCol.getFieldId());
				valueClassName = getValueClassName(fCol);
				//add the  column to the dynamic report builder 
				AbstractColumn column = null;
				column = buildColumn(fCol, columnIndex);
				drb.addColumn(column);
				columnIndex++;
				
				//now add the column to the crosstab builder
				DJCrosstabColumn col = new CrosstabColumnBuilder().setProperty(column.getName(),valueClassName)
				.setHeaderHeight(60).setWidth(80).setTitle(fCol.getDisplayName()).setShowTotals(true)
				.setTotalStyle(CrossTabTotalStyle).setHeaderStyle(CrossTabColRowHeaderStyle).setTotalHeaderStyle(CrossTabColRowHeaderStyle)
				.setTotalStyle(CrossTabColRowHeaderTotalStyle).build();
				cb.addColumn(col);	
			}
		}
		return cb.build();
	}
	
	public String getValueClassName(ReportField reportField) {
		String valueClassName = new String();
		switch (reportField.getFieldType()) {
		case NONE:   	valueClassName = String.class.getName();	break;
		case STRING:   	valueClassName = String.class.getName();	break;
		case INTEGER:   valueClassName = Long.class.getName(); 		break;
		case DOUBLE:   	valueClassName = String.class.getName();	break;
		case DATE:   	valueClassName = Date.class.getName();  	break;
		case MONEY:   	valueClassName = Float.class.getName(); 	break;
		case BOOLEAN:   valueClassName = Boolean.class.getName();	
		}
		return valueClassName;
	}
	
	public String getPattern(ReportField reportField) {
		String pattern = new String();
		switch (reportField.getFieldType()) {
		case NONE:   	pattern ="";	 		break;
		case STRING:   	pattern ="";			break;
		case INTEGER:   pattern ="";	 		break;
		case DOUBLE:   	pattern ="";	 		break;
		case DATE:   	pattern ="MM/dd/yyyy";	break;
		case MONEY:   	pattern ="$ #,##0.00";	break;
		case BOOLEAN:   pattern ="";	
		}
		return pattern;
	}
	
	private List<ReportField> getSelectedReportFields(ReportWizard wiz, ReportFieldService reportFieldService) {
		Iterator<ReportSelectedField> itReportSelectedFields = wiz.getReportSelectedFields().iterator();

		List<ReportField> selectedReportFieldsList = new LinkedList<ReportField>();
		Integer columnIndex = 0;
		while (itReportSelectedFields.hasNext()){
			ReportSelectedField reportSelectedField = (ReportSelectedField) itReportSelectedFields.next();
			if (reportSelectedField == null) continue;
			ReportField f = reportFieldService.find(reportSelectedField.getFieldId());
			if (f == null || f.getId() == -1) continue;
			f.setAverage(reportSelectedField.getAverage());
			f.setIsSummarized(reportSelectedField.getIsSummarized());
			f.setLargestValue(reportSelectedField.getMax());
			f.setSmallestValue(reportSelectedField.getMin());
			f.setPerformSummary(reportSelectedField.getSum());
			f.setRecordCount(reportSelectedField.getCount());
			f.setSelected(true);
			//f.setDynamicColumnName(f.getColumnName() + "_" + columnIndex.toString());
			//columnIndex++;
			selectedReportFieldsList.add(f);
		}
		
		return selectedReportFieldsList; 
	}
	
	private FastReportBuilder addColumnsAndGroups(List<ReportField> reportFieldsOrderedList, ReportWizard wiz, FastReportBuilder drb, ReportFieldService reportFieldService)throws ColumnBuilderException{
		List<AbstractColumn> columnsBuilt = new LinkedList<AbstractColumn>();
		Iterator itFields = reportFieldsOrderedList.iterator();
		DJChart chart = null;
		Boolean chartExists = false;
		Integer columnIndex = 0;
		
		while (itFields.hasNext()){
			ReportField f = (ReportField) itFields.next();
			//Build and add the column
			AbstractColumn column = buildColumn(f, columnIndex);
			drb.addColumn(column);
			//Build and add the group if it is a groupby field
			DJGroup group = null;
			if  ( wiz.IsFieldGroupByField(f.getId())){
				group = buildGroup(column);
				//groupsBuilt.add(group);
				drb.addGroup(group);
			}
			//Set the chart criteria (don't build at this point as all criteria may not be set)
			//is the column used in a chart?
			Boolean chartColumn = isChartColumn(f, wiz, reportFieldService);
			if (chartColumn){
				if (!chartExists)
					chart = new DJChart();
				chart = setChartColumns(chart, column, group, f, reportFieldService, wiz);
				chartExists = true;
			}
			columnIndex++;
		}
		
		//add the chart if it exists
		if (chartExists){
			chart = setChartCriteria(chart, wiz);
			drb.addChart(chart);
		}
		return drb;
	}
	
	private DJChart setChartCriteria(DJChart chart, ReportWizard wiz) {
		List<ReportChartSettings> chartSettings = wiz.getReportChartSettings();
		Iterator itChartSettings = chartSettings.iterator();
		while (itChartSettings.hasNext()){
			ReportChartSettings rcs = (ReportChartSettings) itChartSettings.next();
			if (rcs.getChartType().compareTo("-1") == 0) continue; 
			DJChartOptions options = new DJChartOptions();
			options.setPosition(DJChartOptions.POSITION_HEADER);
			options.setShowLabels(true);
			chart.setOptions(options);
			//set chart type
			if (rcs.getChartType().compareTo("Bar") == 0) chart.setType(DJChart.BAR_CHART);	
			if (rcs.getChartType().compareTo("Pie") == 0) chart.setType(DJChart.PIE_CHART);

			//set chart operation
			if (rcs.getOperation().compareTo("RecordCount") == 0) chart.setOperation(DJChart.CALCULATION_COUNT);
			if (rcs.getOperation().compareTo("Sum") == 0) chart.setOperation(DJChart.CALCULATION_SUM);
		}
		return chart;
	}

	private DJChart setChartColumns(DJChart chart, AbstractColumn column, DJGroup group, ReportField f, ReportFieldService reportFieldService, ReportWizard wiz) {
		//DJChart chart;
		List<ReportChartSettings> chartSettings = wiz.getReportChartSettings();
		Iterator itChartSettings = chartSettings.iterator();
		while (itChartSettings.hasNext()){
			ReportChartSettings rcs = (ReportChartSettings) itChartSettings.next();
			if (rcs.getChartType().compareTo("-1") == 0) continue; 
			ReportField rfx = reportFieldService.find(rcs.getFieldIdx());
			ReportField rfy = reportFieldService.find(rcs.getFieldIdy());
			if (rfx.getId() == f.getId()){
				chart.setColumnsGroup(group);
			}
			if (rfy.getId() == f.getId()){
				List<AbstractColumn> columns = new LinkedList();
				columns.add(column);
				chart.setColumns(columns);	
			}
		}
		return chart;
	}

	private Boolean isChartColumn(ReportField f, ReportWizard wiz, ReportFieldService reportFieldService) {
		Boolean chartColumn = false;
		//iterate thru the chart settings to see if this report
		//field is a chart field
		List<ReportChartSettings> chartSettings = wiz.getReportChartSettings();
		Iterator itChartSettings = chartSettings.iterator();
		while (itChartSettings.hasNext()){
			ReportChartSettings rcs = (ReportChartSettings) itChartSettings.next();
			if (rcs.getChartType().compareTo("-1") == 0) continue; 
			ReportField rfx = reportFieldService.find(rcs.getFieldIdx());
			ReportField rfy = reportFieldService.find(rcs.getFieldIdy());
			if (rfx.getId() == f.getId() || rfy.getId() == f.getId())
				chartColumn = true;
		}
		return chartColumn;
	}

	private DJGroup buildGroup(AbstractColumn column) {
		DJGroup group = new DJGroup();
		group.setColumnToGroupBy((PropertyColumn) column);
		group.setLayout(GroupLayout.DEFAULT);
		return group;
	}

	private AbstractColumn buildColumn(ReportField f, Integer columnIndex) {
		String valueClassName = null;
		String pattern = null;
		valueClassName = getValueClassName(f);
		pattern = getPattern(f);
		String columnName = null;

		if (f.getAliasName() == null || f.getAliasName().length() == 0)
			columnName = f.getColumnName() + "_" + columnIndex;
		else
			columnName = f.getAliasName() + "_" + columnIndex;
		
		AbstractColumn column = null;
		try {
			column = ColumnBuilder.getInstance()
			.setColumnProperty(columnName, valueClassName)
			.setTitle(f.getDisplayName()).setPattern(pattern)
			.build();
			column.setName(columnName);
		} catch (ColumnBuilderException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return column;
	}
/*
	private List<DJGroup> buildGroups(List<AbstractColumn> builtColumns, List<ReportField> reportFieldsOrderedList, ){
		List<DJGroup> groupsBuilt = new LinkedList<DJGroup>();
		Integer columnIndex = 0;
		String columnName = null;
		//Iterate thru the list of columns and if isgroupbyfield add group
		Iterator itbuiltColumns = builtColumns.iterator();
		while (itbuiltColumns.hasNext()){
			AbstractColumn column = (AbstractColumn) itbuiltColumns.next();

			ReportField reportField = wiz.getReportFieldByColumnName(column.getName().toString());
			columnName = reportField.getColumnName() + "_" + columnIndex;
			if  ( wiz.IsFieldGroupByField(reportField.getId())){
				DJGroup group = new DJGroup();
				group.setColumnToGroupBy((PropertyColumn) column);
				group.setLayout(GroupLayout.DEFAULT);

				//ArrayList cgvList = new ArrayList();
				//group.setFooterVariables(getColumnGroupVariables(cgvList, builtColumns, reportFieldsOrderedList, wiz));
				
				//add the group
				groupsBuilt.add(group);
			}
		}
		return groupsBuilt;
	}	
*/
/*	
	private List<DJChart> buildCharts(List<DJGroup> groupByColumnsBuilt, List<AbstractColumn> allColumns, ReportWizard wiz,ReportFieldService reportFieldService) throws ChartBuilderException{
		List<DJChart> chartsBuilt = new LinkedList<DJChart>();
		List<ReportChartSettings> chartSettings = wiz.getReportChartSettings();
		Iterator itChartSettings = chartSettings.iterator();
		while (itChartSettings.hasNext()){
			ReportChartSettings rcs = (ReportChartSettings) itChartSettings.next();
			if (rcs.getChartType().compareTo("-1") == 0) continue; 
			ReportField rfx = reportFieldService.find(rcs.getFieldIdx());
			DJGroup cg = getReportDJGroup(rfx, groupByColumnsBuilt);
			ReportField rfy = reportFieldService.find(rcs.getFieldIdy());
			List<AbstractColumn> columns = getReportAbstractColumn(rfy, allColumns);

			//DJChartBuilder cb = new DJChartBuilder(); 
			DJChart chart = new DJChart();
			DJChartOptions options = new DJChartOptions();
			
			options.setPosition(DJChartOptions.POSITION_HEADER);
			options.setShowLabels(true);
			chart.setOptions(options);
			chart.setColumnsGroup(cg);
			chart.setColumns(columns);
			

			//set chart type
			if (rcs.getChartType().compareTo("Bar") == 0) chart.setType(DJChart.BAR_CHART);	
			if (rcs.getChartType().compareTo("Pie") == 0) chart.setType(DJChart.PIE_CHART);

			//set chart operation
			if (rcs.getOperation().compareTo("RecordCount") == 0) chart.setOperation(DJChart.CALCULATION_COUNT);
			if (rcs.getOperation().compareTo("Sum") == 0) chart.setOperation(DJChart.CALCULATION_SUM);

			chartsBuilt.add(chart);	
		}//end while itChartSettings
		return chartsBuilt;
	}		
*/
	private List<AbstractColumn> getReportAbstractColumn(ReportField rfy, List<AbstractColumn> allColumns) {
		List<AbstractColumn> columns = new LinkedList<AbstractColumn>();
		Iterator itCol = allColumns.iterator();
		while (itCol.hasNext()){
			AbstractColumn column = (AbstractColumn) itCol.next();
			if (rfy.getColumnName().compareToIgnoreCase(column.getName()) == 0){
				columns.add(column);	
			}
		}
		return columns;
	}

	private DJGroup getReportDJGroup(ReportField rfx, List<DJGroup> groupByColumnsBuilt) {
		Iterator itGroupBy = groupByColumnsBuilt.iterator();
		while (itGroupBy.hasNext()){
			DJGroup cg = (DJGroup) itGroupBy.next();
			if (rfx.getColumnName().compareToIgnoreCase(cg.getColumnToGroupBy().getName()) == 0){
				return cg;	
			}
		}
		return null;
	}

	/*
	private FastReportBuilder AddGlobalFooterVariables(List<ReportField> fields, List<AbstractColumn> columnsBuilt, FastReportBuilder drb){

		//Iterate thru each of the fields to see if it is summarized  
		Iterator itFields = fields.iterator();
		while (itFields.hasNext()){
			ReportField f = (ReportField) itFields.next();
			Iterator itColumnsBuilt = columnsBuilt.iterator();
			//if the report field issummarized = true get the abstract column
			if (f.getIsSummarized()){
				while (itColumnsBuilt.hasNext()){
					AbstractColumn column = (AbstractColumn) itColumnsBuilt.next();
					if (f.getColumnName() == column.getName()){
						if (f.getPerformSummary()){
							drb.addGlobalFooterVariable(column, DJCalculation.SUM).setGrandTotalLegend("Total");
							//break;
						}
						if (f.getAverage()){
							drb.addGlobalFooterVariable(column, DJCalculation.AVERAGE).setGrandTotalLegend("Average");
							//break;
						}
						if (f.getSmallestValue()){
							drb.addGlobalFooterVariable(column, DJCalculation.LOWEST).setGrandTotalLegend("Min");
							//break;
						}
						if (f.getLargestValue()){
							drb.addGlobalFooterVariable(column, DJCalculation.HIGHEST).setGrandTotalLegend("Max");
							//break;
						}
					}//end if column name = field name
				}//end while itColumnsBuilt
			}//end if isSummarized
		}//end while itFields
		return drb;
	}
	*/
	
	private ResourceDescriptor putReportUnit(ResourceDescriptor rd,String name, String label, String desc, File report, Map params2, String jasperDatasourceName) throws Exception 
	{
		File resourceFile = null;

		ResourceDescriptor tmpDataSourceDescriptor = new ResourceDescriptor();
		tmpDataSourceDescriptor.setWsType(ResourceDescriptor.TYPE_DATASOURCE);
		//tmpDataSourceDescriptor.setReferenceUri(reportUnitDataSourceURI);
		tmpDataSourceDescriptor.setReferenceUri(jasperDatasourceName);
		tmpDataSourceDescriptor.setIsReference(true);
		rd.getChildren().add(tmpDataSourceDescriptor);

		ResourceDescriptor jrxmlDescriptor = new ResourceDescriptor();
		jrxmlDescriptor.setWsType(ResourceDescriptor.TYPE_JRXML);
		jrxmlDescriptor.setName(name);
		jrxmlDescriptor.setLabel(label);
		jrxmlDescriptor.setDescription(desc);
		jrxmlDescriptor.setIsNew(true);
		jrxmlDescriptor.setHasData(true);
		jrxmlDescriptor.setMainReport(true);

		rd.getChildren().add(jrxmlDescriptor);
		rd.setResourceProperty(
				ResourceDescriptor.PROP_RU_ALWAYS_PROPMT_CONTROLS, true);
		// Check if the report already exists and delete it if it does
		WSClient wsClient = server.getWSClient();
		boolean reportExists = false;
		
		// wsClient.list(rd) throws an exception if the report does not exist
		try {
			List reportList = wsClient.list(rd);
			reportExists = reportList.size() > 0;
		} catch (Exception e) {
			reportExists = false;
		}
		if (reportExists)
			wsClient.delete(rd);
		ResourceDescriptor reportDescriptor = wsClient.addOrModifyResource(rd, report);

		//
		// if there are parameters for this report then add the input controls
		Iterator it = inputControls.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry entrySet = (Entry) it.next();
			String key = (String) entrySet.getKey();
			InputControlParameters ic = (InputControlParameters) entrySet
			.getValue();

			//
			// add an input control for every key
			ResourceDescriptor jrxmlControl = new ResourceDescriptor();

			jrxmlControl.setWsType(ResourceDescriptor.TYPE_INPUT_CONTROL);
			// jrxmlControl.setDataType(ResourceDescriptor.DT_TYPE_TEXT);

			jrxmlControl
			.setControlType(ResourceDescriptor.IC_TYPE_SINGLE_VALUE);
			jrxmlControl.setName(key);

			jrxmlControl.setLabel(ic.getLabel());
			jrxmlControl.setDescription(ic.getLabel());

			jrxmlControl.setVersion(2);
			jrxmlControl.setHasData(false);
			jrxmlControl.setMandatory(false);
			jrxmlControl.setIsNew(true);
			jrxmlControl.setIsReference(false);
			jrxmlControl.setStrictMax(false);
			jrxmlControl.setStrictMin(false);
			jrxmlControl.setReadOnly(false);
			jrxmlControl.setMainReport(false);
			jrxmlControl.setParentFolder(rd.getUriString() + "_files");
			// jrxmlControl.setReferenceUri(rd.getUriString() + "_files/" +
			// key);
			jrxmlControl.setUriString(rd.getUriString() + "_files/" + key);
			jrxmlControl
			.setResourceType("com.jaspersoft.jasperserver.api.metadata.common.domain.InputControl");
			ResourceDescriptor dataTypeDescriptor = new ResourceDescriptor();
			// dataTypeDescriptor.setWsType(ResourceDescriptor.TYPE_DATA_TYPE);
			// dataTypeDescriptor.setDataType(ResourceDescriptor.DT_TYPE_TEXT);
			// dataTypeDescriptor.setName("String");
			// dataTypeDescriptor.setLabel("String");
			dataTypeDescriptor.setWsType(ResourceDescriptor.TYPE_REFERENCE);
			dataTypeDescriptor.setIsReference(true);

			if (ic.getType() == ReportFieldType.STRING)
				dataTypeDescriptor.setReferenceUri("/datatypes/String");
			else if (ic.getType() == ReportFieldType.DATE)
				dataTypeDescriptor.setReferenceUri("/datatypes/Date");
			else
				dataTypeDescriptor.setReferenceUri("/datatypes/Number");

			jrxmlControl.getChildren().add(dataTypeDescriptor);

			// server.getWSClient().addOrModifyResource(jrxmlControl, null);
			server.getWSClient().modifyReportUnitResource(rd.getUriString(),
					jrxmlControl, null);

		}
		return reportDescriptor;
	}

	public ResourceDescriptor put(String type, String name, String label,
			String desc, String parentFolder, File report, Map params, String jasperDatasourceName)
	throws Exception {

		logger.info("put(" + type + "," + name + "," + label + "," + desc + "," + parentFolder + "," + report + "," + params + "," + jasperDatasourceName +")");

		ResourceDescriptor rd = new ResourceDescriptor();
		rd.setName(name);
		rd.setLabel(label);
		rd.setDescription(desc);
		rd.setParentFolder(parentFolder);
		rd.setUriString(parentFolder + "/" + rd.getName());
		rd.setWsType(type);
		rd.setIsNew(true);

		if (type.equalsIgnoreCase(ResourceDescriptor.TYPE_FOLDER)) {
			return server.getWSClient().addOrModifyResource(rd, null);
		} else if (type.equalsIgnoreCase(ResourceDescriptor.TYPE_REPORTUNIT)) {
			return putReportUnit(rd, name, label, desc, report, params, jasperDatasourceName);
		}

		// shouldn't reach here
		return null;

	}

	public JasperPrint runReport(String reportUnit, java.util.Map parameters)
	throws Exception {
		ResourceDescriptor rd = new ResourceDescriptor();
		rd.setWsType(ResourceDescriptor.TYPE_REPORTUNIT);

		return server.getWSClient().runReport(rd, parameters);
	}

	public void addOrModifyResource(ResourceDescriptor rd, File tempFile)
	throws Exception {
		server.getWSClient().addOrModifyResource(rd, tempFile);

	}

	public String getReportServicesURI() {
		return reportServicesURI;
	}

	public void setReportServicesURI(String reportServicesURI) {
		this.reportServicesURI = reportServicesURI;
	}

	public String getReportUserName() {
		return reportUserName;
	}

	public void setReportUserName(String reportUserName) throws Exception {
		if (reportUserName == null) {
			throw new Exception("username can not be null");
		}


		int index = reportUserName.indexOf("@");

		if (index != -1) {
			setReportCompany(reportUserName.substring(index + 1));
		} else {
			setReportCompany("Default");
		}


		this.reportUserName = reportUserName;
	}

	public String getReportPassword() {
		return reportPassword;
	}

	public void setReportPassword(String reportPassword) throws Exception {
		if (reportPassword == null) {
			throw new Exception("password can not be null!");
		}

		this.reportPassword = reportPassword;
	}

	public String getReportCompany() {
		return reportCompany;
	}

	public void setReportCompany(String company) {
		logger.info("setReportCompany(" + company + ")");
		reportCompany = company;
	}

	public String getReportUnitDataSourceURI() {
		return reportUnitDataSourceURI;
	}

	public void setReportUnitDataSourceURI(String reportUnitDataSourceURI) {
		this.reportUnitDataSourceURI = reportUnitDataSourceURI;
	}

	public void resetInputControls() {
		params = new HashMap();
		inputControls = new HashMap();

	}
}
