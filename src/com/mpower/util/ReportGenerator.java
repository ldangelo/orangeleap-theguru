package com.mpower.util;

import java.awt.Color;
import java.io.File;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.activation.DataSource;

import net.sf.jasperreports.engine.JasperPrint;

import com.jaspersoft.jasperserver.api.metadata.xml.domain.impl.ResourceDescriptor;
import com.jaspersoft.jasperserver.irplugin.JServer;
import com.mpower.domain.ReportAdvancedFilter;
import com.mpower.domain.ReportField;
import com.mpower.domain.ReportFieldType;
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
import ar.com.fdvs.dj.domain.constants.Border;
import ar.com.fdvs.dj.domain.constants.Font;
import ar.com.fdvs.dj.domain.constants.HorizontalAlign;
import ar.com.fdvs.dj.domain.constants.Transparency;
import ar.com.fdvs.dj.domain.constants.VerticalAlign;
import ar.com.fdvs.dj.domain.entities.columns.AbstractColumn;

public class ReportGenerator {
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
	
	private void startServer()
	{
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

	private File getTemplateFile() throws Exception
	{
		startServer();
		
		//
		// get the report template file from the server
		File templateFile = File.createTempFile("template", ".jrxml");
		ResourceDescriptor templateRD = new ResourceDescriptor();
//		templateRD.setWsType(ResourceDescriptor.TYPE_JRXML);
//		templateRD.setParentFolder("/templates");
		templateRD.setUriString("/templates/mpower_template_files/mpower_template_jrxml");
		ResourceDescriptor rd = server.getWSClient().get(templateRD, templateFile);

		return templateFile;
	}

	public DynamicReport Generate(ReportWizard wiz,javax.sql.DataSource jdbcDataSource, ReportFieldService reportFieldService) throws Exception {
		File templateFile = getTemplateFile();
		
		initStyles();

		
		FastReportBuilder drb = new FastReportBuilder();
  		Integer margin = new Integer(20);
  		drb.setTemplateFile(templateFile.getAbsolutePath())
  			.setTitleStyle(titleStyle)
  			.setTitle(wiz.getDataSubSource().getDisplayName() + " Custom Report")					//defines the title of the report
 			.setDetailHeight(new Integer(15))
 			.setLeftMargin(margin).setRightMargin(margin).setTopMargin(margin).setBottomMargin(margin)
  			.setPrintBackgroundOnOddRows(true)
  			.setGrandTotalLegendStyle(headerVariables)
  			.setOddRowBackgroundStyle(oddRowStyle)
;//   			.addFirstPageImageBanner("images/mpowerlogo.gif", new Integer(225), new Integer(75), ImageBanner.ALIGN_RIGHT);
  
  		List<ReportField> fields = wiz.getSelectedReportFieldsInOrder();
		Iterator it = fields.iterator();
		
		//columnCount used to display record count 
		Integer columnCount = new Integer(0);
		//temp fix for summary record count -- basically if you pick record count it will
		//not display any of the other summary info until alt solution is put in place
		Boolean globalFooterVariableDefined = false;
		 
		while(it.hasNext()) {
			ReportField f = (ReportField) it.next();
			
			if (f.getSelected()) {
				String valueClassName = null;
				String pattern = null;
				columnCount += 1;
				
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
				 				.setStyle(detailStyle)
				 				.setPattern(pattern)
				 				.setHeaderStyle(headerStyle)
				 				.build();
				column.setName(f.getColumnName());
				
				//Add Summary/Grand Total footers **Can Add Only one Global Footer Variable per Column**
				if (f.getPerformSummary()){
					drb.addGlobalFooterVariable(column, ColumnsGroupVariableOperation.SUM,headerVariables).setGrandTotalLegend("Total");
					globalFooterVariableDefined = true;
				}
				if (f.getAverage()){
					drb.addGlobalFooterVariable(column, ColumnsGroupVariableOperation.AVERAGE,headerVariables).setGrandTotalLegend("Average");
					globalFooterVariableDefined = true;
				}
				if (f.getSmallestValue()){
					drb.addGlobalFooterVariable(column, ColumnsGroupVariableOperation.LOWEST,headerVariables).setGrandTotalLegend("Min");
					globalFooterVariableDefined = true;
				}
				if (f.getLargestValue()){
					drb.addGlobalFooterVariable(column, ColumnsGroupVariableOperation.HIGHEST,headerVariables).setGrandTotalLegend("Max");
					globalFooterVariableDefined = true;
				}
				drb.addColumn(column);
				column.getInitialExpression(ColumnsGroupVariableOperation.COUNT);	
				
			}
		}
		//Temp Fix - Record Count will not be displayed if any other summary fields were selected
		if (wiz.getRecordCount()&& !globalFooterVariableDefined)
			drb.addGlobalFooterVariable(columnCount, ColumnsGroupVariableOperation.COUNT,headerVariables).setGrandTotalLegend("Total Records");
	
		drb.setIgnorePagination(true);
		drb.setUseFullPageWidth(true);


		@SuppressWarnings("unused")
		Map params = new HashMap();
		String query = "SELECT * FROM " + wiz.getDataSubSource().getViewName();
		
		if (wiz.getRowCount() != -1)
			query += " LIMIT 0," + wiz.getRowCount().toString(); 

		//
		// Add any 'filters'
		List<ReportAdvancedFilter> filters = wiz.getAdvancedFilters();
		Iterator itFilter = filters.iterator();

		
		Boolean bWhere = false;
		while (itFilter.hasNext()) {
			ReportAdvancedFilter filter = (ReportAdvancedFilter) itFilter.next();
			ReportField rf = reportFieldService.find(filter.getFieldId());

			if (filter.getValue() == "") break; // this is an empty filter
			
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
			case 4:	query += " >";
			}
			
			if (rf.getFieldType() == ReportFieldType.STRING || rf.getFieldType() == ReportFieldType.DATE) {
				query += " '" + filter.getValue() + "'";
			} else {
				query += " " + filter.getValue() + " ";
			}

			drb.addParameter(rf.getColumnName(), filter.getValue());

		}


		query += ";";

		drb.setQuery(query,DJConstants.QUERY_LANGUAGE_SQL);
		DynamicReport dr = drb.build();

		return dr;
	}

    private ResourceDescriptor putReportUnit(ResourceDescriptor rd,String name, String label, String desc, File report) throws Exception 
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
		
		return server.getWSClient().addOrModifyResource(rd, report);
		
    }   


    public ResourceDescriptor put(String type, String name, String label, String desc, String parentFolder,File report) throws Exception 
    {
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
		}
		else if (type.equalsIgnoreCase(ResourceDescriptor.TYPE_REPORTUNIT)) {
			return putReportUnit(rd,name,label,desc,report);
		}
		
		//shouldn't reach here
		return null;

	}
     
	public JasperPrint runReport(String reportUnit, java.util.Map parameters) throws Exception
	{
		ResourceDescriptor rd = new ResourceDescriptor();
		rd.setWsType(ResourceDescriptor.TYPE_REPORTUNIT);

		return server.getWSClient().runReport(rd, parameters);
	}
	
	public void addOrModifyResource(ResourceDescriptor rd, File tempFile) throws Exception {
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
}
