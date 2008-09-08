package com.mpower.util;

import java.awt.Color;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.activation.DataSource;

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
	
	private void initStyles() {
		//Set up the styles used in the report
		detailStyle = new Style("detail");
		detailStyle.setFont(Font.ARIAL_MEDIUM);
		detailStyle.setHorizontalAlign(HorizontalAlign.LEFT);
		detailStyle.setStretchWithOverflow(true);
		
		headerStyle = new Style("header");
  		headerStyle.setFont(Font.ARIAL_MEDIUM_BOLD);
  		headerStyle.setBorderBottom(Border.PEN_1_POINT);
  		headerStyle.setBackgroundColor(Color.LIGHT_GRAY);
  		headerStyle.setTextColor(Color.white);
  		headerStyle.setHorizontalAlign(HorizontalAlign.LEFT);
  		headerStyle.setVerticalAlign(VerticalAlign.MIDDLE);
  		headerStyle.setTransparency(Transparency.OPAQUE);
  
  		headerVariables = new Style("headerVariables");
  		headerVariables.setFont(Font.ARIAL_MEDIUM_BOLD);
  		headerVariables.setBorderBottom(Border.THIN);
  		headerVariables.setHorizontalAlign(HorizontalAlign.LEFT);
  		headerVariables.setVerticalAlign(VerticalAlign.MIDDLE);
  
  		titleStyle = new Style("titleStyle");
  		titleStyle.setFont(new Font(18, Font._FONT_VERDANA, true));
  		
  		importeStyle = new Style();
  		importeStyle.setHorizontalAlign(HorizontalAlign.RIGHT);
  		
  		oddRowStyle = new Style();
  		oddRowStyle.setBorder(Border.NO_BORDER);
  		oddRowStyle.setBackgroundColor(Color.lightGray);
  		oddRowStyle.setTransparency(Transparency.OPAQUE);
	}

	public DynamicReport Generate(ReportWizard wiz,javax.sql.DataSource jdbcDataSource, ReportFieldService reportFieldService) throws ColumnBuilderException {
		initStyles();

		FastReportBuilder drb = new FastReportBuilder();
  		Integer margin = new Integer(20);
  		drb
  			.setTitleStyle(titleStyle)
  			.setTitle(wiz.getDataSubSource().getDisplayName() + " Custom Report")					//defines the title of the report
  			.setSubtitle("This report was generated at " + new Date().toString())
 			.setDetailHeight(new Integer(15))
 			.setLeftMargin(margin).setRightMargin(margin).setTopMargin(margin).setBottomMargin(margin)
  			.setPrintBackgroundOnOddRows(true)
  			.setGrandTotalLegendStyle(headerVariables)
  			.setOddRowBackgroundStyle(oddRowStyle)
  			.addFirstPageImageBanner(System.getProperty("user.dir") +"/war/images/mpowerlogo.gif", new Integer(225), new Integer(75), ImageBanner.ALIGN_RIGHT);
  		
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
		drb.addAutoText("Confidential Information - Do Not Distribute", AutoText.POSITION_FOOTER, AutoText.ALIGMENT_CENTER);


		@SuppressWarnings("unused")
		Map params = new HashMap();
//		Connection connection = jdbcDataSource.getConnection();
//		Statement statement = connection.createStatement();
//		ResultSet resultset = null;
		
		//Build query to get dataset
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
		}


		query += ";";

		drb.setQuery(query,DJConstants.QUERY_LANGUAGE_SQL);
		DynamicReport dr = drb.build();

		return dr;
	}
}
