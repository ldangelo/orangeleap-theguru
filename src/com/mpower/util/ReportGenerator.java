package com.mpower.util;

import java.awt.Color;
import java.io.File;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
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
import com.mpower.domain.ReportAdvancedFilter;
import com.mpower.domain.ReportField;
import com.mpower.domain.ReportFieldType;
import com.mpower.domain.ReportGroupByField;
import com.mpower.domain.ReportStandardFilter;
import com.mpower.domain.ReportWizard;
import com.mpower.service.ReportFieldService;

import ar.com.fdvs.dj.core.DJConstants;
import ar.com.fdvs.dj.domain.AutoText;
import ar.com.fdvs.dj.domain.ColumnsGroupVariableOperation;
import ar.com.fdvs.dj.domain.DynamicReport;
import ar.com.fdvs.dj.domain.ImageBanner;
import ar.com.fdvs.dj.domain.Style;
import ar.com.fdvs.dj.domain.builders.ColumnBuilder;
import ar.com.fdvs.dj.domain.builders.ColumnBuilderException;
import ar.com.fdvs.dj.domain.builders.FastReportBuilder;
import ar.com.fdvs.dj.domain.builders.GroupBuilder;
import ar.com.fdvs.dj.domain.constants.Border;
import ar.com.fdvs.dj.domain.constants.Font;
import ar.com.fdvs.dj.domain.constants.GroupLayout;
import ar.com.fdvs.dj.domain.constants.HorizontalAlign;
import ar.com.fdvs.dj.domain.constants.Transparency;
import ar.com.fdvs.dj.domain.constants.VerticalAlign;
import ar.com.fdvs.dj.domain.entities.ColumnsGroup;
import ar.com.fdvs.dj.domain.entities.ColumnsGroupVariable;
import ar.com.fdvs.dj.domain.entities.columns.AbstractColumn;
import ar.com.fdvs.dj.domain.entities.columns.PropertyColumn;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ReportGenerator {
	protected final Log logger = LogFactory.getLog(getClass());

	private Style detailStyle;
	private Style headerStyle;
	private Style headerVariables;
	private Style titleStyle;
	private Style importeStyle;
	private Style oddRowStyle;
	private String reportServicesURI;
	private String reportUserName;
	private String reportPassword;

	private JServer server = null;
	private String reportUnitDataSourceURI;
	private Map params;
	private Map inputControls;

	public ReportGenerator() {
		params = new HashMap();
		inputControls = new HashMap();
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
		detailStyle = new Style("detail");

		headerStyle = new Style("header");

		headerVariables = new Style("headerVariables");

		titleStyle = new Style("titleStyle");

		importeStyle = new Style();

		oddRowStyle = new Style();
	}

	private File getTemplateFile() throws Exception {
		startServer();

		//
		// get the report template file from the server
		File templateFile = File.createTempFile("template", ".jrxml");
		ResourceDescriptor templateRD = new ResourceDescriptor();
		// templateRD.setWsType(ResourceDescriptor.TYPE_JRXML);
		// templateRD.setParentFolder("/templates");
		templateRD
				.setUriString("/templates/mpower_template_files/mpower_template_jrxml");
		ResourceDescriptor rd = server.getWSClient().get(templateRD,
				templateFile);

		return templateFile;
	}

	public DynamicReport Generate(ReportWizard wiz,javax.sql.DataSource jdbcDataSource, ReportFieldService reportFieldService) throws Exception {
		File templateFile = getTemplateFile();

		initStyles();

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
//  			.setPrintBackgroundOnOddRows(true)
  			.setGrandTotalLegendStyle(headerVariables)
  			.setOddRowBackgroundStyle(oddRowStyle);
	
  		//create iterators
  		List<ReportField> fields = wiz.getSelectedReportFieldsInOrder();
  		Iterator itFields = fields.iterator();
  		List<ReportGroupByField> groupByFields = wiz.getReportGroupByFields();
  		Iterator itGroupByFields = groupByFields.iterator();
  		
  		//get list of groupby fields in order
  		List<ReportField> groupByFieldsList = new LinkedList<ReportField>();
  		while (itGroupByFields.hasNext()){
  			ReportGroupByField group = (ReportGroupByField) itGroupByFields.next();
			if (group == null) continue;
			ReportField f = reportFieldService.find(group.getFieldId());
			if (f == null || f.getId() == -1) continue;
			groupByFieldsList.add(f);
  		}
  		
  		//get a list of all remaining columns selected fields(excluding groupby columns)
  		List<ReportField> columnFieldsList = new LinkedList<ReportField>();
  		while (itFields.hasNext()){
  			ReportField f = (ReportField) itFields.next();
			if (f == null || f.getId() == -1 || wiz.IsFieldGroupByField(f.getId())) continue;
			columnFieldsList.add(f);
  		}
  		
  		//Build columns 
  		//Build group columns first then build all remaining columns
  		List<AbstractColumn> groupByColumns = 	buildColumns(groupByFieldsList);
  		List<AbstractColumn> columnsOnly = buildColumns(columnFieldsList);
  		List<AbstractColumn> allColumns = new LinkedList<AbstractColumn>();
  		allColumns.addAll(groupByColumns);
  		allColumns.addAll(columnsOnly);
  		
  		//Build Groups
  		List<ColumnsGroup> groupBy = buildGroups(groupByColumns, columnsOnly, columnFieldsList);
  		
  		//Add Global footer variables to columns
  		drb = AddGlobalFooterVariables(fields, columnsOnly,drb);
  		
  		//Add All Columns
  		Iterator itColumnsBuilt = allColumns.iterator();
  		while (itColumnsBuilt.hasNext()){
  			AbstractColumn column = (AbstractColumn) itColumnsBuilt.next();
  			drb.addColumn(column);
  		}
  		
  		//Add Groups
  		if (wiz.getReportType().compareTo("summary") == 0) {
			Iterator itGroupsBuilt = groupBy.iterator();
			while (itGroupsBuilt.hasNext()){
				ColumnsGroup group = (ColumnsGroup) itGroupsBuilt.next();
				drb.addGroup(group);
			}
  		}
  		drb.setIgnorePagination(true);
		drb.setUseFullPageWidth(true);


		//Build query
		@SuppressWarnings("unused")
		String query = "SELECT * FROM " + wiz.getDataSubSource().getViewName();
		
		if (wiz.getRowCount() != -1)
			query += " LIMIT 0," + wiz.getRowCount().toString();

		Boolean bWhere = false;
		
		//
		// Add any 'filters'
		List<ReportStandardFilter> standardFilters = wiz.getStandardFilters();
		Iterator itStandardFilters = standardFilters.iterator();
		
		List<ReportAdvancedFilter> filters = wiz.getAdvancedFilters();
		Iterator itFilter = filters.iterator();
		while (itStandardFilters.hasNext()) {
			ReportStandardFilter filter = (ReportStandardFilter) itStandardFilters.next();
			if (filter.getFieldId() == -1) break; // this is an empty filter
			ReportField rf = reportFieldService.find(filter.getFieldId());
			if (!bWhere) {
				bWhere = true;
				query += " WHERE ";
			} else {
				query += " AND ";
			}
			
			

			query += " " + rf.getColumnName();

			
			switch(filter.getDuration()) {
			case 1: // Current FY
				break;
			case 2: // Previous FY
				break;
			case 3: // Current FY
				break;
			case 4: // Current FY
				break;
			case 5: // Current FY
				break;
			case 6: // Current FY
				break;
			case 7: // Current FY
				break;
			case 8: // Current FY
				break;
			case 9: // Current FY
				break;
			case 10: // Current FY
				break;
			case 11: // Current FY
				break;
			case 12: // Current FY
				break;
			case 13: // Current FY
				break;
			case 14: // Current FY
				break;
			case 15: // Current FY
				break;
			case 16: // Current FY
				break;
			case 17: // Current FY
				break;
			case 18: // Current FY
				break;
			case 19: // Current FY
				break;
			case 20: // Current FY
				break;
			case 21: // Today
				query += " = CURDATE()";
				break;
			case 22: // Yesterday
				query += " = Date_Add(CURDATE(),INTERVAL -1 DAY)";
				break;
			case 23: // Last 30
				query += " > Date_Add(CURDATE(),INTERVAL -30 DAY)";
				break;
			case 24: // Last 60
				query += " > Date_Add(CURDATE(),INTERVAL -60 DAY)";
				break;
			case 25: // Last 90
				query += " > Date_Add(CURDATE(),INTERVAL -90 DAY)";
				break;
			case 26: // Last 120
				query += " > Date_Add(CURDATE(),INTERVAL -120 DAY)";
				break;
			case 27: // Last 7
				query += " > Date_Add(CURDATE(),INTERVAL -7 DAY)";
				break;
				
			}
		}
		

		while (itFilter.hasNext()) {
			ReportAdvancedFilter filter = (ReportAdvancedFilter) itFilter
					.next();
			
			if (filter.getFieldId() == -1) break; // this is an empty filter
			ReportField rf = reportFieldService.find(filter.getFieldId());



			
			if (!bWhere) {
				bWhere = true;
				query += " WHERE ";
			} else {
				query += " AND ";
			}

			
			query += " " + rf.getColumnName();
			switch (filter.getOperator()) {
			case 1:	query += " = ";		break;
			case 2:	query += " != ";	break;
			case 3:	query += " < ";		break;
			case 4:	query += " >"; break;
			case 5:	query += " <="; break;
			case 6:	query += " >="; break;
			case 7: break; // contains ; break;
			case 8: break; // startswith ; break;			
			case 9: break; // includes ; break;			
			case 10: break; // excludes ; break;
			case 11: query += " LIKE "; break; // like ; break;						
		
			}
			
			InputControlParameters ic = new InputControlParameters();
			ic.setLabel(rf.getDisplayName());
			ic.setType(rf.getFieldType());
			ic.setFilter(filter.getOperator());
			String controlName = rf.getControlName();
			
			inputControls.put(controlName, ic);
			
			if ( rf.getFieldType() == ReportFieldType.DATE) {
				query += " $P{" + controlName + "} ";
				params.put(controlName, "java.util.Date");
				drb.addParameter(controlName, "java.util.Date");				
			} else	if(rf.getFieldType() == ReportFieldType.STRING) {
				query += " $P{" + controlName + "} ";
				drb.addParameter(controlName, "java.lang.String");
				params.put(controlName, "java.lang.String");
			} else if(rf.getFieldType() == ReportFieldType.DOUBLE) {
				query += " $P{" + controlName + "} ";
				drb.addParameter(controlName, "java.lang.Double");
				params.put(controlName, "java.lang.Double");
			} else if(rf.getFieldType() == ReportFieldType.INTEGER) {
				query += " $P{" + controlName + "} ";
				drb.addParameter(controlName, "java.lang.Integer");
				params.put(controlName, "java.lang.Integer");
			} else if(rf.getFieldType() == ReportFieldType.MONEY) {
				query += " $P{" + controlName + "} ";
				drb.addParameter(controlName, "java.lang.Double");
				params.put(controlName, "java.lang.Double");
			} else if(rf.getFieldType() == ReportFieldType.BOOLEAN) {
				query += " $P{" + controlName + "} ";
				drb.addParameter(controlName, "java.lang.Boolean");
				params.put(controlName, "java.lang.Boolean");
			} 
		}
		
		if (wiz.getReportType().compareTo("summary") == 0) {
			//
			//Add the order by clause for grouping
			List<ReportGroupByField> rptGroupByFields = wiz.getReportGroupByFields();
			Iterator itRptGroupByFields = rptGroupByFields.iterator();
			
			if (itRptGroupByFields != null){
				boolean addComma = false;
				while (itRptGroupByFields.hasNext()){
					ReportGroupByField groupByField = (ReportGroupByField) itRptGroupByFields.next();
					if (groupByField != null) {						
						if (groupByField.getFieldId() != -1){
							if (!addComma) {
								query += " ORDER BY";
								addComma = true;
							}
							else
								query += ","; 
							ReportField rg = reportFieldService.find(groupByField.getFieldId());
							query += " " + rg.getColumnName();
							query += " " + groupByField.getSortOrder();	
						}
					}
				}
			}
		}

		query += ";";

		logger.info(query);

		drb.setQuery(query, DJConstants.QUERY_LANGUAGE_SQL);
		drb.setTemplateFile(templateFile.getAbsolutePath());
		DynamicReport dr = drb.build();

		return dr;
	}
	
	private List<AbstractColumn> buildColumns(List<ReportField> fields)throws ColumnBuilderException{
		List<AbstractColumn> columnsBuilt = new LinkedList<AbstractColumn>();
		Iterator itFields = fields.iterator();
		String valueClassName = null;
		String pattern = null;
		while (itFields.hasNext()){
			ReportField f = (ReportField) itFields.next();
	    	switch (f.getFieldType()) {
		        case NONE:   	valueClassName = String.class.getName(); pattern ="";	 		break;
		        case STRING:   	valueClassName = String.class.getName(); pattern ="";			break;
		        case INTEGER:   valueClassName = Long.class.getName(); 	 pattern ="";	 		break;
		        case DOUBLE:   	valueClassName = String.class.getName(); pattern ="";	 		break;
		        case DATE:   	valueClassName = Date.class.getName();   pattern ="MM/dd/yyyy";	break;
		        case MONEY:   	valueClassName = Float.class.getName();  pattern ="$ 0.00";		break;
		        case BOOLEAN:   valueClassName = Boolean.class.getName();pattern ="";	
			}
			AbstractColumn column = ColumnBuilder.getInstance()
			 				.setColumnProperty(f.getColumnName(), valueClassName )
			 				.setTitle(f.getDisplayName())
			 				//.setStyle(detailStyle)
			 				.setPattern(pattern)
			 				.setHeaderStyle(headerStyle)
			 				.build();
			column.setName(f.getColumnName());
			columnsBuilt.add(column);
		}
		return columnsBuilt;
	}
	
	private List<ColumnsGroup> buildGroups(List<AbstractColumn> groupByColumnsBuilt, List<AbstractColumn> columnsOnly,List<ReportField> columnFieldsList){
		List<ColumnsGroup> groupsBuilt = new LinkedList<ColumnsGroup>();
		//Iterate thru the group by fields
		Iterator itGroupByColumns = groupByColumnsBuilt.iterator();
		while (itGroupByColumns.hasNext()){
			AbstractColumn column = (AbstractColumn) itGroupByColumns.next();
			GroupBuilder groupBuilder = new GroupBuilder();
			ColumnsGroup group = new ColumnsGroup();
			group.setColumnToGroupBy((PropertyColumn) column);
			group.setLayout(GroupLayout.DEFAULT);
			
			ArrayList cgvList = new ArrayList();
			group.setFooterVariables(getColumnGroupVariables(cgvList, columnsOnly,columnFieldsList));
			
			//add the group
			groupsBuilt.add(group);
		}
		return groupsBuilt;
	}	
	
	private ArrayList getColumnGroupVariables(ArrayList cgvList, List<AbstractColumn> columnsOnly,List<ReportField> columnFieldsList) {
		//set the summary info for the groups
		for(int index=0; index < columnFieldsList.size(); index++) {
		    if (((ReportField)columnFieldsList.get(index)).getAverage()) {
		    	AbstractColumn col = ((AbstractColumn)columnsOnly.get(index));
		    	ColumnsGroupVariable cgv = new ColumnsGroupVariable(col, ColumnsGroupVariableOperation.AVERAGE);
		    	cgvList.add(cgv);
		     }//end if
		    if (((ReportField)columnFieldsList.get(index)).getPerformSummary()) {
		    	AbstractColumn col = ((AbstractColumn)columnsOnly.get(index));
		    	ColumnsGroupVariable cgv = new ColumnsGroupVariable(col, ColumnsGroupVariableOperation.SUM);
		    	cgvList.add(cgv);
		     }//end if
		    if (((ReportField)columnFieldsList.get(index)).getLargestValue()) {
		    	AbstractColumn col = ((AbstractColumn)columnsOnly.get(index));
		    	ColumnsGroupVariable cgv = new ColumnsGroupVariable(col, ColumnsGroupVariableOperation.HIGHEST);
		    	cgvList.add(cgv);
		     }//end if
		    if (((ReportField)columnFieldsList.get(index)).getSmallestValue()) {
		    	AbstractColumn col = ((AbstractColumn)columnsOnly.get(index));
		    	ColumnsGroupVariable cgv = new ColumnsGroupVariable(col, ColumnsGroupVariableOperation.LOWEST);
		    	cgvList.add(cgv);
		     }//end if
		}//end for
		return cgvList;
	}
	
	private FastReportBuilder AddGlobalFooterVariables(List<ReportField> fields, List<AbstractColumn> columnsBuilt, FastReportBuilder drb){
	
		//Iterate thru each of the fields to see if it is summarized  
		Iterator itFields = fields.iterator();
		while (itFields.hasNext()){
			ReportField f = (ReportField) itFields.next();
			Iterator itColumnsBuilt = columnsBuilt.iterator();
			while (itColumnsBuilt.hasNext()){
				AbstractColumn column = (AbstractColumn) itColumnsBuilt.next();
				if (f.getColumnName() == column.getName()){
					if (f.getPerformSummary()){
						drb.addGlobalFooterVariable(column, ColumnsGroupVariableOperation.SUM,headerVariables).setGrandTotalLegend("Total");
						break;
					}
					if (f.getAverage()){
						drb.addGlobalFooterVariable(column, ColumnsGroupVariableOperation.AVERAGE,headerVariables).setGrandTotalLegend("Average");
						break;
					}
					if (f.getSmallestValue()){
						drb.addGlobalFooterVariable(column, ColumnsGroupVariableOperation.LOWEST,headerVariables).setGrandTotalLegend("Min");
						break;
					}
					if (f.getLargestValue()){
						drb.addGlobalFooterVariable(column, ColumnsGroupVariableOperation.HIGHEST,headerVariables).setGrandTotalLegend("Max");
						break;
					}
				}//end if column name = field name
			}//end while itColumnsBuilt
		}//end while itFields
		return drb;
	}

	private ResourceDescriptor putReportUnit(ResourceDescriptor rd,String name, String label, String desc, File report, Map params2) throws Exception 
    {
		File resourceFile = null;

		ResourceDescriptor tmpDataSourceDescriptor = new ResourceDescriptor();
		tmpDataSourceDescriptor.setWsType(ResourceDescriptor.TYPE_DATASOURCE);
		tmpDataSourceDescriptor.setReferenceUri(reportUnitDataSourceURI);
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
		ResourceDescriptor reportDescriptor = server.getWSClient()
				.addOrModifyResource(rd, report);

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
			String desc, String parentFolder, File report, Map params)
			throws Exception {
		ResourceDescriptor rd = new ResourceDescriptor();
		rd.setName(name);
		rd.setLabel(label);
		rd.setDescription(desc);
		rd.setParentFolder(parentFolder);
		rd.setUriString(rd.getParentFolder() + "/" + rd.getName());
		rd.setWsType(type);
		rd.setIsNew(true);

		if (type.equalsIgnoreCase(ResourceDescriptor.TYPE_FOLDER)) {
			return server.getWSClient().addOrModifyResource(rd, null);
		} else if (type.equalsIgnoreCase(ResourceDescriptor.TYPE_REPORTUNIT)) {
			return putReportUnit(rd, name, label, desc, report, params);
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

	public void setReportUserName(String reportUserName) {
		this.reportUserName = reportUserName;
	}

	public String getReportPassword() {
		return reportPassword;
	}

	public void setReportPassword(String reportPassword) {
		this.reportPassword = reportPassword;
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
