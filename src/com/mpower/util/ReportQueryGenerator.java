package com.mpower.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import com.mpower.domain.ReportAdvancedFilter;
import com.mpower.domain.ReportCrossTabFields;
import com.mpower.domain.ReportCustomFilter;
import com.mpower.domain.ReportCustomFilterDefinition;
import com.mpower.domain.ReportDatabaseType;
import com.mpower.domain.ReportField;
import com.mpower.domain.ReportFieldType;
import com.mpower.domain.ReportGroupByField;
import com.mpower.domain.ReportStandardFilter;
import com.mpower.domain.ReportWizard;
import com.mpower.service.ReportCustomFilterDefinitionService;
import com.mpower.service.ReportFieldService;

/**
 * <p>
 * Object to create queries for either mySql or SQL Server.
 */
public class ReportQueryGenerator {
	private ReportWizard reportWizard;
	private ReportFieldService reportFieldService;
	private ReportCustomFilterDefinitionService reportCustomFilterDefinitionService;
	private List<ReportField> reportFieldsOrderedList;
		
    /**
     * Constructor for the <tt>QueryGenerator</tt>.
     * @param reportWizard ReportWizard that contains the various report options.
     * @param reportFieldService ReportFieldService the QueryGenerator will use to retrieve field information from the database.
     * @param reportFieldsOrderedList <tt>List&lt;ReportField&gt;</tt> of the report fields in the correct order.
     */
    public ReportQueryGenerator(ReportWizard reportWizard, ReportFieldService reportFieldService, 
    		ReportCustomFilterDefinitionService reportCustomFilterDefinitionService, List<ReportField> reportFieldsOrderedList) {
    	this.setReportWizard(reportWizard);
    	this.setReportFieldService(reportFieldService);
    	this.setReportCustomFilterDefinitionService(reportCustomFilterDefinitionService);
    	this.setReportFieldsOrderedList(reportFieldsOrderedList);
    }
   
    public enum DatePart {
        YEAR ("YEAR", "yy"),
        QUARTER   ("QUARTER", "qq"),
        MONTH   ("MONTH", "mm"),
        WEEK    ("WEEK", "wk");

        private final String mySQL;   
        private final String SQL; 
        DatePart(String mySQL, String SQL) {
            this.mySQL = mySQL;
            this.SQL = SQL;
        }
        public String mySQL()   { return mySQL; }
        public String SQL() { return SQL; }

    }

   /*
    public class DatePart{
    	
    	   public class SQLConstants {

    	    	static final String YEAR = "yy";
    	    	static final String QUARTER = "qq";
    	    	static final String MONTH = "mm";
    	    	static final String WEEK = "wk";

    	    } 
    	    
    	    public class mySQLConstants {

    	    	static final String YEAR = "YEAR";
    	    	static final String QUARTER = "QUARTER";
    	    	static final String MONTH = "MONTH";
    	    	static final String WEEK = "WEEK";

    	    } 
    	String YEAR;
  }
   
    
    public class SQLConstants {

    	static final String YEAR = "yy";
    	static final String QUARTER = "qq";
    	static final String MONTH = "mm";
    	static final String WEEK = "wk";

    } 
    
    public class mySQLConstants {

    	static final String YEAR = "YEAR";
    	static final String QUARTER = "QUARTER";
    	static final String MONTH = "MONTH";
    	static final String WEEK = "WEEK";

    } 
*/
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
	 * Sets the ReportCustomFilterDefinitionService the QueryGenerator uses to retrieve custom filter definition information.
	 * @param getReportCustomFilterDefinitionService
	 */
	public ReportCustomFilterDefinitionService getReportCustomFilterDefinitionService() {
		return reportCustomFilterDefinitionService;
	}

	/** 
	 * Returns the ReportCustomFilterDefinitionService the QueryGenerator uses to retrieve custom filter definition information.
	 * @return ReportFieldService
	 */
	public void setReportCustomFilterDefinitionService(
			ReportCustomFilterDefinitionService reportCustomFilterDefinitionService) {
		this.reportCustomFilterDefinitionService = reportCustomFilterDefinitionService;
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
	 * @throws ParseException 
	 */			
	public String getQueryString() throws ParseException {
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
		
		selectClause += " DISTINCT";

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
	 * @throws ParseException 
	 */	
	private String buildWhereClause() throws ParseException {
		// Add any 'filters'
		String whereClause = "";
		
		Boolean includeWhere = whereClause.length() == 0;		
		whereClause += buildStandardFilterWhereClause(includeWhere);

		includeWhere = whereClause.length() == 0;		
		whereClause += buildAdvancedFilterWhereClause(includeWhere);

		includeWhere = whereClause.length() == 0;		
		whereClause += buildCustomFilterWhereClause(includeWhere);

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
			if (filter == null || filter.getFieldId() == -1) break; // this is an empty filter
			ReportField rf = reportFieldService.find(filter.getFieldId());
			if (includeWhere) {
				includeWhere = true;
				whereClause += " WHERE ";
			} else {
				whereClause += " AND ";
			}			
		
			//whereClause += " " + rf.getColumnName();
			
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
			case 11: // Current Calendar Year
				whereClause += getSqlCalendarDurationCriteriaFromCurrentDate(DatePart.YEAR, rf.getColumnName(), 0);
				break;
			case 12: // Previous Calendar Year
				whereClause += getSqlCalendarDurationCriteriaFromCurrentDate(DatePart.YEAR, rf.getColumnName(), -1);
				break;
			case 13: // Current and Previous Calendar Year
				whereClause += "( " + getSqlCalendarDurationCriteriaFromCurrentDate(DatePart.YEAR, rf.getColumnName(), -1) +
							   " OR " + 
							   getSqlCalendarDurationCriteriaFromCurrentDate(DatePart.YEAR, rf.getColumnName(), 0) + " )";
				break;
			case 14: // Current Calendar Month
				whereClause += getSqlCalendarDurationCriteriaFromCurrentDate(DatePart.MONTH, rf.getColumnName(), 0);
				break;
			case 15: // Previous Calendar Month
				whereClause += getSqlCalendarDurationCriteriaFromCurrentDate(DatePart.MONTH, rf.getColumnName(), -1);
				break;
			case 16: // Current and Previous Calendar Month
				whereClause += "( " + getSqlCalendarDurationCriteriaFromCurrentDate(DatePart.MONTH, rf.getColumnName(), -1) +
				   			   " OR " + 
				   			   getSqlCalendarDurationCriteriaFromCurrentDate(DatePart.MONTH, rf.getColumnName(), 0) + " )";
				break;
			case 17: // Current Calendar Week
				whereClause += getSqlCalendarDurationCriteriaFromCurrentDate(DatePart.WEEK, rf.getColumnName(), 0);
				break;
			case 18: // Previous Calendar Week
				whereClause += getSqlCalendarDurationCriteriaFromCurrentDate(DatePart.WEEK, rf.getColumnName(), -1);
				break;
			case 19: // Current and Previous Calendar Week
				whereClause += "( " + getSqlCalendarDurationCriteriaFromCurrentDate(DatePart.WEEK, rf.getColumnName(), -1) +
				   			   " OR " + 
				   			   getSqlCalendarDurationCriteriaFromCurrentDate(DatePart.WEEK, rf.getColumnName(), 0) + " )";
				break; 
			case 20: // Today
				whereClause += rf.getColumnName() + " = " + getSqlCriteriaDaysFromCurrentDate(0);
				break;
			case 21: // Yesterday
				whereClause += rf.getColumnName() + " = " + getSqlCriteriaDaysFromCurrentDate(-1);
				break;
			case 22: // Last 7
				whereClause += rf.getColumnName() + " > " + getSqlCriteriaDaysFromCurrentDate(-7);
				break;		
			case 23: // Last 30
				whereClause += rf.getColumnName() + " > " + getSqlCriteriaDaysFromCurrentDate(-30);
				break;
			case 24: // Last 60
				whereClause += rf.getColumnName() + " > " + getSqlCriteriaDaysFromCurrentDate(-60);
				break;
			case 25: // Last 90
				whereClause += rf.getColumnName() + " > " + getSqlCriteriaDaysFromCurrentDate(-90);
				break;
			case 26: // Last 120
				whereClause += rf.getColumnName() + " > " + getSqlCriteriaDaysFromCurrentDate(-120);
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
	 * @throws ParseException 
	 */
	private String buildAdvancedFilterWhereClause(Boolean includeWhere) throws ParseException {
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
				if (filter.getLogicalOperator() == 2)
					whereClause += " OR ";
				else
					whereClause += " AND ";
			}
			
			whereClause += " " + getFieldNameForWhereClause(rf);
			switch (filter.getOperator()) {
				case 1:	whereClause += " = ";		break;
				case 2:	whereClause += " != ";		break;
				case 3:	whereClause += " < ";		break;
				case 4:	whereClause += " >"; 		break;
				case 5:	whereClause += " <="; 		break;
				case 6:	whereClause += " >="; 		break;
				case 7: whereClause += " LIKE ";	break; // starts with 
				case 8: whereClause += " LIKE ";	break; // ends with		
				case 9: whereClause += " LIKE ";	break; // contains		
				case 10:whereClause += " NOT LIKE ";break; // does not contain 
			}
			
			String controlName = rf.getColumnName() + Integer.toString(index);
			index++;
			
			//comparison filter operators
			if (filter.getOperator() >= 7 && filter.getOperator() <= 10)
			{
				if (getReportWizard().getDataSubSource().getDatabaseType() == ReportDatabaseType.MYSQL) {
					switch (filter.getOperator()) {
					case 7: whereClause += " CONCAT( ";	break; // starts with 
					case 8: whereClause += " CONCAT( '%',";	break; // ends with		
					case 9: whereClause += " CONCAT( '%',";	break; // contains		
					case 10:whereClause += " CONCAT( '%',";break; // does not contain 
					}
				}
				else if (getReportWizard().getDataSubSource().getDatabaseType() == ReportDatabaseType.SQLSERVER) {
					switch (filter.getOperator()) {
					case 7: whereClause += "";	break; // starts with 
					case 8: whereClause += " '%' + ";	break; // ends with		
					case 9: whereClause += " '%' + ";	break; // contains		
					case 10:whereClause += " '%' + ";break; // does not contain 
					}	
				}
			}
			
			if ( rf.getFieldType() == ReportFieldType.DATE) {
				if (filter.getPromptForCriteria()) {
					whereClause += " $P{" + controlName + "} ";
				} else {
					whereClause += getFormattedDateString(filter.getCriteria()); 
				}
			} else	if(rf.getFieldType() == ReportFieldType.STRING) {
				if (filter.getPromptForCriteria()) {
					whereClause += " $P{" + controlName + "} ";
				} else {
					whereClause += " '" + filter.getCriteria() + "'";
				}
			} else if(rf.getFieldType() == ReportFieldType.DOUBLE) {
				if (filter.getPromptForCriteria()) {
					whereClause += " $P{" + controlName + "} ";
				} else {
					whereClause += " " + filter.getCriteria();
				}
			} else if(rf.getFieldType() == ReportFieldType.INTEGER) {
				if (filter.getPromptForCriteria()) {
					whereClause += " $P{" + controlName + "} ";
				} else {
					whereClause += " " + filter.getCriteria();
				}
			} else if(rf.getFieldType() == ReportFieldType.MONEY) {
				if (filter.getPromptForCriteria()) {
					whereClause += " $P{" + controlName + "} ";
				} else {
					whereClause += " " + filter.getCriteria();
				}
			} else if(rf.getFieldType() == ReportFieldType.BOOLEAN) {
				if (filter.getPromptForCriteria()) {
					whereClause += " $P{" + controlName + "} ";
				} else {
					whereClause += " " + filter.getCriteria();
				}
			}
			
			//comparison filter operators
			if (filter.getOperator() >= 7 && filter.getOperator() <= 10){
				if (getReportWizard().getDataSubSource().getDatabaseType() == ReportDatabaseType.MYSQL) {	
					switch (filter.getOperator()) {
					case 7: whereClause += " , '%')";	break; // starts with 
					case 8: whereClause += " ) ";		break; // ends with		
					case 9: whereClause += "  , '%') ";	break; // contains		
					case 10:whereClause += "  , '%')";	break; // does not contain
					}
				}
				else if (getReportWizard().getDataSubSource().getDatabaseType() == ReportDatabaseType.SQLSERVER) {
					switch (filter.getOperator()) {
					case 7: whereClause += " + '%' ";	break; // starts with 
					case 8: whereClause += "";			break; // ends with		
					case 9: whereClause += " + '%' ";	break; // contains		
					case 10:whereClause += " + '%' ";	break; // does not contain
					}	
				}
			}
		}
		return whereClause;
	}
	
	/**
	 * Builds and returns a portion of a where clause for the custom filters.
	 * <P>
	 * {@code} whereClause += buildCustomFilterWhereClause(false);
	 * @param includeWhere Specifies whether the returned string should begin with a WHERE if true, or with an AND if false.
	 * @return String
	 * @throws ParseException 
	 */
	private String buildCustomFilterWhereClause(Boolean includeWhere) throws ParseException {
		String whereClause = ""; 
		Iterator<ReportCustomFilter> itFilter = getReportWizard().getReportCustomFilters().iterator();
		while (itFilter.hasNext()) {
			ReportCustomFilter filter = (ReportCustomFilter) itFilter.next();
			
			if (filter == null || filter.getCustomFilterId() <= 0) continue; // this is an empty filter
			ReportCustomFilterDefinition reportCustomFilterDefinition = getReportCustomFilterDefinitionService().find(filter.getCustomFilterId());
			if (reportCustomFilterDefinition == null) continue;
			String filterString = reportCustomFilterDefinition.getSqlText();
			if (filterString.length() == 0) continue;
			if (includeWhere) {
				includeWhere = false;
				whereClause += " WHERE ";
			} else {
				whereClause += " AND ";
			}
			filterString = filterString.replace("[VIEWNAME]", getReportWizard().getDataSubSource().getViewName());
			int criteriaSize = filter.getReportCustomFilterCriteria().size();
			for (int index = 0; index < criteriaSize; index++) {
				filterString = filterString.replace("{" + Integer.toString(index) + "}", filter.getReportCustomFilterCriteria().get(index));
			}
			whereClause += filterString;
		}
		return whereClause;
	}

	/**
	 * Attempts to parse the incoming date string using the default locale first, and then various
	 * other date formats.  If it is able to parse the date, it will then return a string with the
	 * date formatted for mySql and SQL Server. 
	 * <P>
	 * {@code} whereClause += getFormattedDateString(filter.getCriteria());
	 * @param dateString The string containing the date to be parsed and formatted.
	 * @return String Date string formatted for mySql and SQL Server
	 * @throws ParseException The exception to be thrown if the dateString is unable to be parsed.
	 */
	private String getFormattedDateString(String dateString) throws ParseException {
		String result = "";
		ParseException lastException = null;
		Date whereDate = null;
		SimpleDateFormat resultDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		// First attempt to use the default locale to attempt to parse the date 
		try {
			whereDate = DateFormat.getDateInstance(DateFormat.SHORT).parse(dateString);
			result = " '" +  resultDateFormat.format(whereDate) + "'";
			return result;
		}
		catch (ParseException exception) {
			lastException = exception;
		}
			
		ArrayList<String> dateFormatStrings = new ArrayList<String>();
		// Add various date formats
		dateFormatStrings.add("yyyy-MM-dd");
		dateFormatStrings.add("yyyy/MM/dd");
		dateFormatStrings.add("yyyy MM dd");
		dateFormatStrings.add("yyyy.MM.dd");
	 
		dateFormatStrings.add("yyyy-MMM-dd");
		dateFormatStrings.add("yyyy/MMM/dd");
		dateFormatStrings.add("yyyy MMM dd");
		dateFormatStrings.add("yyyy.MMM.dd");

		dateFormatStrings.add("MM-dd-yyyy");
		dateFormatStrings.add("MM/dd/yyyy");
		dateFormatStrings.add("MM dd yyyy");
		dateFormatStrings.add("MM.dd.yyyy");
		
		dateFormatStrings.add("dd-MM-yyyy");
		dateFormatStrings.add("dd/MM/yyyy");
		dateFormatStrings.add("dd MM yyyy");
		dateFormatStrings.add("dd.MM.yyyy");
	 
		dateFormatStrings.add("dd-MMM-yy");
		dateFormatStrings.add("dd MMM yy");
		dateFormatStrings.add("dd.MMM.yy");
		dateFormatStrings.add("dd/MMM/yy");
		
		dateFormatStrings.add("yyyy-MM-dd hh:mm:ss");
		dateFormatStrings.add("yyyy MM dd hh:mm:ss");
		dateFormatStrings.add("yyyy.MM.dd hh:mm:ss");
		dateFormatStrings.add("yyyy/MM/dd hh:mm:ss");
	 
		dateFormatStrings.add("yyyy-MMM-dd hh:mm:ss");
		dateFormatStrings.add("yyyy MMM dd hh:mm:ss");
		dateFormatStrings.add("yyyy.MMM.dd hh:mm:ss");
		dateFormatStrings.add("yyyy/MMM/dd hh:mm:ss");
		
		dateFormatStrings.add("dd-MM-yyyy hh:mm:ss");
		dateFormatStrings.add("dd MM yyyy hh:mm:ss");
		dateFormatStrings.add("dd.MM.yyyy hh:mm:ss");
		dateFormatStrings.add("dd/MM/yyyy hh:mm:ss");
		
		dateFormatStrings.add("dd-MMM-yyyy hh:mm:ss");
		dateFormatStrings.add("dd/MMM/yyyy hh:mm:ss");
		dateFormatStrings.add("dd MMM yyyy hh:mm:ss");
		dateFormatStrings.add("dd.MMM.yyyy hh:mm:ss");
		
		for (String dateFormatString : dateFormatStrings) {
	    	try {
	    		SimpleDateFormat dateFormat = new SimpleDateFormat(dateFormatString);
	    		dateFormat.setLenient(false);
	    		whereDate = dateFormat.parse(dateString);
				result = " '" +  resultDateFormat.format(whereDate) + "'";
				return result;
	    	}
	  		catch (ParseException exception) {
	  			lastException = exception;
	  		}
		}
		
		// If no date was parsed, throw the last parse exception
		if (result.length() == 0 && lastException != null)
			throw lastException;
		
		return result;
	}
	
	/**
	 * Returns a value for the field that will be used in the where clause.  For DateTime fields
	 * this will return a string that will cause the time to be removed from the DateTime.  Other
	 * field types may be returned with just the column name.
	 * <P>
	 * {@code} whereClause += " " + getFieldNameForWhereClause(reportField);
	 * @param reportField The report field for which the function will generate a string to be used in the where clause.
	 * @return String
	 */
	private String getFieldNameForWhereClause(ReportField reportField) {
		String result = ""; 
		if (reportField.getFieldType() == ReportFieldType.DATE) {
			if (getReportWizard().getDataSubSource().getDatabaseType() == ReportDatabaseType.MYSQL) {
				result = "CAST(" + reportField.getColumnName() + " AS DATE)";	
			}
			else if (getReportWizard().getDataSubSource().getDatabaseType() == ReportDatabaseType.SQLSERVER) {
				result = "DATEADD(DAY, DATEDIFF(DAY, 0, " + reportField.getColumnName() + "), 0)";
			}
		}
		else {
			result = reportField.getColumnName();
		}
		return result;
	}
	
	/**
	 * Builds and returns a string for either mySql or SQL Server that subtracts the specified number of days from the current date.
	 * <P>
	 * {@code} whereClause += rf.getColumnName() + " = " + getSqlCriteriaDaysFromCurrentDate(-1);
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
	 * Builds and returns a string for either mySql or SQL Server that adds/subtracts the specified number of weeks, months, etc. from the current date.
	 * <P>
	 * {@code} whereClause += getSqlCalendarDurationCriteriaFromCurrentDate(DatePart.YEAR, rf.getColumnName(), 0);
	 * @param DatePart datePart (YEAR, MONTH, QUARTER, WEEK)
	 * @param String columnName Name of column
	 * @param int duration Number of weeks, months, etc. from the current date. 
	 * @return String
	 */
	private String getSqlCalendarDurationCriteriaFromCurrentDate(DatePart datePart, String columnName, int duration) {
		String result = "";
		if (getReportWizard().getDataSubSource().getDatabaseType() == ReportDatabaseType.MYSQL) {
			result = "( " + datePart.mySQL() + "(" + columnName + ") = " + datePart.mySQL() + "(CURDATE()) + " + Integer.toString(duration); 
			if (datePart == DatePart.YEAR){
				result += " AND YEAR(" + columnName + ") = (YEAR(CURDATE()) + " + Integer.toString(duration) + " ))";
			}else{
				result += " AND YEAR(" + columnName + ") = YEAR(CURDATE()) )";
			}	
		}
		else if (getReportWizard().getDataSubSource().getDatabaseType() == ReportDatabaseType.SQLSERVER) {
			result = "( DATEPART(" + datePart.SQL() + ", " + columnName + ") = (DATEPART(" + datePart.SQL() + ", GETDATE()) + " + Integer.toString(duration) + ")";
			if (datePart == DatePart.YEAR){
				result += " AND YEAR(" + columnName + ") = (YEAR(GETDATE()) + " + Integer.toString(duration) + " )) " ;
			}else{
				result += " AND YEAR(" + columnName + ") = YEAR(GETDATE()) ) " ;
			}
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
