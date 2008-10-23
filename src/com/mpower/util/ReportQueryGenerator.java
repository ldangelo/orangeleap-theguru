package com.mpower.util;

import java.util.Iterator;
import java.util.List;

import com.mpower.domain.ReportAdvancedFilter;
import com.mpower.domain.ReportCrossTabFields;
import com.mpower.domain.ReportDatabaseType;
import com.mpower.domain.ReportField;
import com.mpower.domain.ReportFieldType;
import com.mpower.domain.ReportGroupByField;
import com.mpower.domain.ReportStandardFilter;
import com.mpower.domain.ReportWizard;
import com.mpower.service.ReportFieldService;

/**
 * <p>
 * Object to create queries for either mySql or SQL Server.
 */
public class ReportQueryGenerator {
	private ReportWizard reportWizard;
	private ReportFieldService reportFieldService;
	private List<ReportField> reportFieldsOrderedList;
	
    /**
     * Constructor for the <tt>QueryGenerator</tt>.
     * @param reportWizard ReportWizard that contains the various report options.
     * @param reportFieldService ReportFieldService the QueryGenerator will use to retrieve field information from the database.
     * @param reportFieldsOrderedList <tt>List&lt;ReportField&gt;</tt> of the report fields in the correct order.
     */
    public ReportQueryGenerator(ReportWizard reportWizard, ReportFieldService reportFieldService, List<ReportField> reportFieldsOrderedList) {
    	this.reportWizard = reportWizard;
    	this.setReportFieldService(reportFieldService);
    	this.reportFieldsOrderedList = reportFieldsOrderedList;
    }

	/**
	 * Sets the ReportWizard that contains the various report options.
	 * @param reportWizard
	 */
	public void setReportWizard(ReportWizard reportWizard) {
		this.reportWizard = reportWizard;
	}

	/**
	 * Returns the ReportWizard that contains the various report options.
	 * @return
	 */
	public ReportWizard getReportWizard() {
		return reportWizard;
	}

	/**
	 * Sets the ReportFieldService the QueryGenerator uses to retrieve field information.
	 * @param reportFieldService
	 */
	public void setReportFieldService(ReportFieldService reportFieldService) {
		this.reportFieldService = reportFieldService;
	}

	/** 
	 * Returns the ReportFieldService the QueryGenerator uses to retrieve field information.
	 * @return ReportFieldService
	 */
	public ReportFieldService getReportFieldService() {
		return reportFieldService;
	}
	
	/**
	 * Sets the reportFieldsOrderedList that contains the report fields in the specified order.
	 * @param reportFieldsOrderedList
	 */
	public void setReportFieldsOrderedList(List<ReportField> reportFieldsOrderedList) {
		this.reportFieldsOrderedList = reportFieldsOrderedList;
	}

	/**
	 * Returns the fields for the report in their specified order.
	 * @return <tt>List&lt;ReportField&gt;</tt>
	 */
	public List<ReportField> getReportFieldsOrderedList() {
		return reportFieldsOrderedList;
	}

	/**
	 * Builds and returns a mySql or SQL Server query.
	 * <P>
	 * {@code} String query = getQueryString();
	 * @return String
	 */			
	public String getQueryString() {
		String query = buildSelectClause();
		query += buildWhereClause();
		query += buildOrderByClause();
		if (getReportWizard().getDataSubSource().getDatabaseType() == ReportDatabaseType.MYSQL
				&& getReportWizard().getRowCount() > 0)
			query += " LIMIT 0," + getReportWizard().getRowCount(); 
		query += ";";
		return query;
	}

	/**
	 * Builds and returns a select clause based on the reportFieldsOrderedList.
	 * <P>
	 * {@code} String selectClause = buildSelectClause();
	 * @return String
	 */		
	private String buildSelectClause() {
		String selectClause = "SELECT";
		
		if (getReportWizard().getDataSubSource().getDatabaseType() == ReportDatabaseType.SQLSERVER
				&& getReportWizard().getRowCount() > 0)
			selectClause += " TOP " + getReportWizard().getRowCount(); 
		
		Iterator<ReportField> itReportFields = getReportFieldsOrderedList().iterator();
		boolean addComma = false;
		while (itReportFields.hasNext()) {
			ReportField selectedField = (ReportField) itReportFields.next();
			if (addComma)
				selectClause = selectClause + ",";
			else
				addComma = true;
			
			selectClause = selectClause + " " + selectedField.getColumnName();
		}
		
		selectClause = selectClause + " FROM " + getReportWizard().getDataSubSource().getViewName();		
		
		return selectClause;
	}

	/**
	 * Builds and returns a where clause based on the standard and advanced filters.
	 * <P>
	 * {@code} String whereClause = buildWhereClause();
	 * @return String
	 */	
	private String buildWhereClause() {
		// Add any 'filters'
		String whereClause = "";
		
		Boolean includeWhere = whereClause.length() == 0;		
		whereClause += buildStandardFilterWhereClause(includeWhere);

		includeWhere = whereClause.length() == 0;		
		whereClause = buildAdvancedFilterWhereClause(includeWhere);
		
		return whereClause;
	}

	/**
	 * Builds and returns a portion of a where clause for the standard filters.
	 * <P>
	 * {@code} whereClause += buildStandardFilterWhereClause(false);
	 * @param includeWhere Specifies whether the returned string should begin with a WHERE if true, or with an AND if false.
	 * @return String
	 */	
	private String buildStandardFilterWhereClause(boolean includeWhere) {
		String whereClause = ""; 
		Iterator<ReportStandardFilter> itStandardFilters = getReportWizard().getStandardFilters().iterator();
		while (itStandardFilters.hasNext()) {
			ReportStandardFilter filter = (ReportStandardFilter) itStandardFilters.next();
			if (filter.getFieldId() == -1) break; // this is an empty filter
			ReportField rf = reportFieldService.find(filter.getFieldId());
			if (includeWhere) {
				includeWhere = true;
				whereClause += " WHERE ";
			} else {
				whereClause += " AND ";
			}			
		
			whereClause += " " + rf.getColumnName();
			
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
				whereClause += " = " ;
				break;
			case 22: // Yesterday
				whereClause += " = " + getSqlCriteriaDaysFromCurrentDate(-1);
				break;
			case 23: // Last 30
				whereClause += " > " + getSqlCriteriaDaysFromCurrentDate(-30);
				break;
			case 24: // Last 60
				whereClause += " > " + getSqlCriteriaDaysFromCurrentDate(-60);
				break;
			case 25: // Last 90
				whereClause += " > " + getSqlCriteriaDaysFromCurrentDate(-90);
				break;
			case 26: // Last 120
				whereClause += " > " + getSqlCriteriaDaysFromCurrentDate(-120);
				break;
			case 27: // Last 7
				whereClause += " > " + getSqlCriteriaDaysFromCurrentDate(-7);
				break;				
			}
		}
		return whereClause;
	}
	
	/**
	 * Builds and returns a portion of a where clause for the advanced filters.
	 * <P>
	 * {@code} whereClause += buildAdvancedFilterWhereClause(false);
	 * @param includeWhere Specifies whether the returned string should begin with a WHERE if true, or with an AND if false.
	 * @return String
	 */
	private String buildAdvancedFilterWhereClause(Boolean includeWhere) {
		String whereClause = ""; 
		Iterator<ReportAdvancedFilter> itFilter = getReportWizard().getAdvancedFilters().iterator();
		int index = 0;
		while (itFilter.hasNext()) {
			ReportAdvancedFilter filter = (ReportAdvancedFilter) itFilter
					.next();
			
			if (filter == null || filter.getFieldId() == -1) continue; // this is an empty filter
			ReportField rf = reportFieldService.find(filter.getFieldId());

			if (includeWhere) {
				includeWhere = false;
				whereClause += " WHERE ";
			} else {
				whereClause += " AND ";
			}
			
			whereClause += " " + rf.getColumnName();
			switch (filter.getOperator()) {
			case 1:	whereClause += " = ";		break;
			case 2:	whereClause += " != ";	break;
			case 3:	whereClause += " < ";		break;
			case 4:	whereClause += " >"; break;
			case 5:	whereClause += " <="; break;
			case 6:	whereClause += " >="; break;
			case 7: break; // contains ; break;
			case 8: break; // startswith ; break;			
			case 9: break; // includes ; break;			
			case 10: break; // excludes ; break;
			case 11: whereClause += " LIKE "; break; // like ; break;						
		
			}
			
			String controlName = rf.getColumnName() + Integer.toString(index);
			index++;
			
			if ( rf.getFieldType() == ReportFieldType.DATE) {
				whereClause += " $P{" + controlName + "} ";
			} else	if(rf.getFieldType() == ReportFieldType.STRING) {
				whereClause += " $P{" + controlName + "} ";
			} else if(rf.getFieldType() == ReportFieldType.DOUBLE) {
				whereClause += " $P{" + controlName + "} ";
			} else if(rf.getFieldType() == ReportFieldType.INTEGER) {
				whereClause += " $P{" + controlName + "} ";
			} else if(rf.getFieldType() == ReportFieldType.MONEY) {
				whereClause += " $P{" + controlName + "} ";
			} else if(rf.getFieldType() == ReportFieldType.BOOLEAN) {
				whereClause += " $P{" + controlName + "} ";
			} 
		}
		return whereClause;
	}
	
	/**
	 * Builds and returns a string for either mySql or SQL Server that subtracts the specified number of days from the current date.
	 * <P>
	 * {@code} whereClause += "AND" + fieldName + " > " + getSqlCriteriaDaysFromCurrentDate(-7);
	 * @param days Number of days from the current date
	 * @return String
	 */
	private String getSqlCriteriaDaysFromCurrentDate(int days) {
		String result = "";
		if (getReportWizard().getDataSubSource().getDatabaseType() == ReportDatabaseType.MYSQL) {
			result = "DATE_ADD(CURDATE(),INTERVAL " + Integer.toString(days) + " DAY)";
		}
		else if (getReportWizard().getDataSubSource().getDatabaseType() == ReportDatabaseType.SQLSERVER) {
			result = "DATEADD(DD, GETDATE(), " + Integer.toString(days) + ")";
		}
		return result;
	}

	/**
	 * Builds and returns the order by clause for a summary or matrix report.
	 * <P>
	 * {@code}String orderBy = buildOrderByClause();
	 * @return String orderBy
	 */
	private String buildOrderByClause() {
		//Add the order by clause
		String orderBy = "";
		//Summary Reports
		if (getReportWizard().getReportType().compareTo("summary") == 0) {
			orderBy = getOrderByClauseForSummary();
		}
		//Matrix Reports
		else if (getReportWizard().getReportType().compareTo("matrix") == 0) {
			orderBy = getOrderByClauseForMatrix();
		}
		return orderBy;			
	}

	/**
	 * Builds and returns the order by clause for a matrix report.
	 * <P>
	 * {@code} String orderBy = getOrderByClauseForMatrix();
	 * @return String
	 */
	private String getOrderByClauseForMatrix() {
		String orderBy = "";
		Boolean addComma = false;
		ReportCrossTabFields rptCTList = getReportWizard().getReportCrossTabFields();
		List<ReportGroupByField> ctRows = rptCTList.getReportCrossTabRows();
		addComma = false;
		//order by rows first
		Iterator<ReportGroupByField> itCtRows = ctRows.iterator();
		while (itCtRows.hasNext()){
			ReportGroupByField rowField = (ReportGroupByField) itCtRows.next();
			if (rowField != null) {						
				if (rowField.getFieldId() != -1){
					if (!addComma) {
						orderBy += " ORDER BY";
						addComma = true;
					}
					else
						orderBy += ","; 
					ReportField rg = reportFieldService.find(rowField.getFieldId());
					orderBy += " " + rg.getColumnName();
					orderBy += " " + rowField.getSortOrder();	
				}
			}
		}
		
		//order by Columns last
		List<ReportGroupByField> ctCols = rptCTList.getReportCrossTabColumns();
		Iterator<ReportGroupByField> itCtCols = ctCols.iterator();
		while (itCtCols.hasNext()){
			ReportGroupByField colField = (ReportGroupByField) itCtCols.next();
			if (colField != null) {						
				if (colField.getFieldId() != -1){
					if (!addComma) {
						orderBy += " ORDER BY";
						addComma = true;
					}
					else
						orderBy += ","; 
					ReportField rg = reportFieldService.find(colField.getFieldId());
					orderBy += " " + rg.getColumnName();
					orderBy += " " + colField.getSortOrder();	
				}
			}
		}
		return orderBy;
	}

	/**
	 * Builds and returns the order by clause for a summary report.
	 * <P>
	 * {@code} String orderBy = getOrderByClauseForSummary();
	 * @return String
	 */
	private String getOrderByClauseForSummary() {
		String orderBy = "";
		Boolean addComma = false;
		List<ReportGroupByField> rptGroupByFields = getReportWizard().getReportGroupByFields();
		Iterator<ReportGroupByField> itRptGroupByFields = rptGroupByFields.iterator();
		
		if (itRptGroupByFields != null){
			addComma = false;
			while (itRptGroupByFields.hasNext()){
				ReportGroupByField groupByField = (ReportGroupByField) itRptGroupByFields.next();
				if (groupByField != null) {						
					if (groupByField.getFieldId() != -1){
						if (!addComma) {
							orderBy += " ORDER BY";
							addComma = true;
						}
						else
							orderBy += ","; 
						ReportField rg = reportFieldService.find(groupByField.getFieldId());
						orderBy += " " + rg.getColumnName();
						orderBy += " " + groupByField.getSortOrder();	
					}
				}
			}
		}
		return orderBy;
	}
}
