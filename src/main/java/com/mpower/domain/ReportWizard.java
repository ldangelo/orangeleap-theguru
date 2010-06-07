package com.mpower.domain;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.ArrayList;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.annotations.IndexColumn;

import com.mpower.util.ReportGenerator;

@Entity
@Table(name = "REPORTWIZARD")
public class ReportWizard implements java.io.Serializable{

	/**
	 *
	 */
	private static final long serialVersionUID = -8234358850416908612L;

	@Transient
	protected final Log logger = LogFactory.getLog(getClass());

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTWIZARD_ID")
	private Long id;

	@Column(name = "REPORT_NAME")
	private String reportName;

	@Column(name = "REPORT_SAVEASNAME")
	private String reportSaveAsName;

	@Column(name = "REPORT_COMMENT")
	private String reportComment;

	@Column(name="ROW_COUNT")
	private Integer rowCount;

	@Column(name="UNIQUE_RECORDS")
	private Boolean uniqueRecords;

	@Transient
	private Boolean executeSegmentation = false;

	@Column(name="USE_REPORT_AS_SEGMENTATION")
	private Boolean useReportAsSegmentation;

	@Column(name="SEGMENTATION_QUERY")
	private String segmentationQuery;

	@Column(name = "REPORTSEGMENTATIONTYPE_ID")
	private long reportSegmentationTypeId;

	@Column(name = "LAST_RUN_BY_USERNAME")
	private String lastRunByUserName;

	@Column(name = "LAST_RUN_DATETIME")
	private Date lastRunDateTime;

	@Column(name = "EXECUTION_TIME")
	private long executionTime;

	@Column(name = "RESULT_COUNT")
	private int resultCount;

	@Column(name="REPORTDATASOURCE_ID")
	private long srcId;

	@Column(name = "REPORTSUBSOURCEGROUP_ID")
	private long subSourceGroupId;

	@Column(name = "REPORTSUBSOURCE_ID")
	private long subSourceId;

	@OneToOne()
	@IndexColumn(name="REPORTSOURCE_ID")
	private ReportDataSource src;

	@OneToOne()
	@IndexColumn(name="REPORTSUBSOURCEGROUP_ID")
	private ReportDataSubSourceGroup subsourcegroup;

	@OneToOne()
	@IndexColumn(name="REPORTSUBSOURCE_ID")
	private ReportDataSubSource subsource;

	@Transient
	private List<ReportDataSource> sources;

	@Transient
	private List<ReportDataSubSourceGroup> subsourcegroups;

	@Transient
	private List<ReportDataSubSource> subsources;

	@Transient
	private List<ReportField> fields;

	@Transient
	private List<ReportFieldGroup> fieldGroups;

	@OneToMany(cascade = CascadeType.ALL)
	@IndexColumn(name="REPORTFILTER_ID")
	private List<ReportFilter> reportFilters;

	@ManyToMany(cascade = CascadeType.ALL)
	@IndexColumn(name="REPORTCHARTSETTINGS_ID")
	private List<ReportChartSettings> reportChartSettings;

	@OneToOne(cascade = CascadeType.ALL)
	@IndexColumn(name="REPORTCROSSTABFIELDS_ID")
	private ReportCrossTabFields reportCrossTabFields;

	@OneToMany(cascade = CascadeType.ALL)
	@IndexColumn(name="REPORTSELECTEDFIELD_ID")
	private List<ReportSelectedField> reportSelectedFields;

    @Transient
    private String currentWizardStep;

    @Transient
    private List  reportWizardSteps;

	@Column(name = "REPORT_TYPE")
	private String reportType;

	@Column(name = "REPORT_LAYOUT")
	private ReportLayout reportLayout;

	@Column(name = "RECORDCOUNT")
	private Boolean recordCount;

	@Column(name = "REPORT_PATH")
	private String reportPath;

	@Column(name = "REPORT_TEMPLATE_PATH")
	private String reportTemplatePath;

	@Column(name = "REPORT_TEMPLATE_JRXML")
	private String reportTemplateJRXML;

	@Transient
	private List   reportTemplateList;

	@Transient
	private String username;

	@Transient
	private String password;

	@Column(name = "SITE_NAME")
	private String company;

	@Transient
	private Integer previousPage;

	@Column(name="SHOWSQLQUERY")
	private boolean showSqlQuery;

	@Transient
	private long previousDataSubSourceGroupId = -1;

	@Transient
	private long previousDataSubSourceId = -1;

	@Transient
	private ReportGenerator	reportGenerator;

	public ReportWizard() {
		reportLayout = ReportLayout.PORTRAIT;
		company = "Default";
		showSqlQuery = false;
		recordCount = false;
		previousPage = 0;
		useReportAsSegmentation = false;
		segmentationQuery = "";
		reportSegmentationTypeId = 0;

/*		reportType = "tabular";
		srcId = 0;
		subSourceGroupId = 0;
		subSourceId = 0;
		rowCount = 100;
		uniqueRecords = false;
*/
		//
		// create a filter list decorated as a LazyList
		reportFilters = LazyList.decorate(new ArrayList<ReportFilter>(),FactoryUtils.instantiateFactory(ReportFilter.class));
		reportChartSettings = LazyList.decorate(new ArrayList<ReportChartSettings>(),FactoryUtils.instantiateFactory(ReportChartSettings.class));
		reportCrossTabFields = new ReportCrossTabFields();
		reportSelectedFields = LazyList.decorate(new ArrayList<ReportSelectedField>(),FactoryUtils.instantiateFactory(ReportSelectedField.class));
	}

	public List<ReportChartSettings> getReportChartSettings() {
		return reportChartSettings;
	}

	public ReportCrossTabFields getReportCrossTabFields() {
		return reportCrossTabFields;
	}

	public ReportDataSource getDataSource() {
		logger.info("**** in getSrc()");
		return src;
	}

	public List<ReportDataSource> getDataSources() {
		return sources;
	}

	public ReportDataSubSource getDataSubSource() {
		logger.info("**** in getDatasubSource");
		return subsource;
	}

	public List<ReportDataSubSource> getDataSubSources() {
		return subsources;
	}

	public List<ReportFieldGroup> getFieldGroups() {
		return fieldGroups;
	}

	public List<ReportField> getFields() {
		return fields;
	}

	public Boolean getRecordCount() {
		return recordCount;
	}

	public String getReportComment() {
		return reportComment;
	}

	public ReportDataSource getReportDataSource() {
		return src;
	}

	public ReportLayout getReportLayout() {
		return reportLayout;
	}

	public String getReportName() {
		return reportName;
	}

	public String getReportType() {
		logger.info("**** getReportType");
		if (reportType.compareTo("tabular") == 0 || reportType.compareTo("summary") == 0) {
		    if (hasGroupByFields()) {
		    	reportType = "summary";
		    } else {
		    	reportType = "tabular";
		    }
		}
		return reportType;
	}

	public Integer getRowCount() {
		return rowCount;
	}

	public Boolean getUniqueRecords() {
		return uniqueRecords;
	}

	public long getSrcId() {
		return srcId;
	}

	public long getSubSourceId() {
		return subSourceId;
	}

	public void setReportChartSettings(List<ReportChartSettings> reportChartSettings) {
		this.reportChartSettings = reportChartSettings;
	}

	public void setReportCrossTabFields(ReportCrossTabFields reportCrossTabFields) {
		this.reportCrossTabFields = reportCrossTabFields;
	}

	public void setDataSource(ReportDataSource src) {
		logger.info("**** in setSrc()");
		this.src = src;
	}

	public void setDataSources(List<ReportDataSource> sources) {
		this.sources = sources;
	}

	public void setDataSubSource(ReportDataSubSource subsource) {
		logger.info("**** in setDatasubSource");
		this.subsource = subsource;
	}

	public void setDataSubSources(List<ReportDataSubSource> subsource) {
		this.subsources = subsource;
	}

	public void setFieldGroups(List<ReportFieldGroup> fieldGroups) {
		this.fieldGroups = fieldGroups;
	}

	public void setFields(List<ReportField> fields) {
		this.fields = fields;
	}

	public void setRecordCount(Boolean count) {
		recordCount = count;
	}

	public void setReportComment(String reportComment) {
		this.reportComment = reportComment;
	}

	public void setReportDataSource(ReportDataSource src) {
		this.src = src;
	}

	public void setReportLayout(ReportLayout value) {
		reportLayout = value;
	}

	public void setReportName(String name) {
		reportName = name;
	}

	public void setReportType(String type) {
		logger.info("**** setReportType");
		if (type.compareTo("tabular") == 0 || type.compareTo("summary") == 0) {
		    if (hasGroupByFields()) {
		    	reportType = "summary";
		    } else {
		    	reportType = "tabular";
		    }
		} else {
			reportType = type;
		}
	}

	public boolean hasGroupByFields() {
		boolean result = false;
		List<ReportSelectedField> reportSelectedFields = getReportSelectedFields();
		Iterator<ReportSelectedField> itReportSelectedFields = reportSelectedFields.iterator();

		if (itReportSelectedFields != null){
			while (itReportSelectedFields.hasNext()) {
				ReportSelectedField reportSelectedField = (ReportSelectedField) itReportSelectedFields.next();
				if (reportSelectedField != null
					&& reportSelectedField.getFieldId() != -1
					&& reportSelectedField.getGroupBy()) {
					result = true;
					break;
				}
			}
		}
		return result;
	}

	public void setRowCount(Integer rowCount) {
		this.rowCount = rowCount;
	}

	public void setUniqueRecords(Boolean uniqueRecords) {
		this.uniqueRecords = uniqueRecords;
	}

	public void setSrcId(long srcId) {
		this.srcId = srcId;
	}

	public void setSubSourceId(long srcId) {
		this.subSourceId = srcId;
	}


	public void populateDefaultReportFields() {
		reportSelectedFields.clear();
		Iterator<ReportField> iteratorFields = fields.iterator();
		while(iteratorFields.hasNext()) {
			ReportField reportField = iteratorFields.next();
			if (reportField.getIsDefault()) {
				ReportSelectedField reportSelectedField = new ReportSelectedField();
				reportSelectedField.setAverage(reportField.getAverage());
				reportSelectedField.setFieldId(reportField.getId());
				reportSelectedField.setMax(reportField.getLargestValue());
				reportSelectedField.setMin(reportField.getSmallestValue());
				reportSelectedField.setSum(reportField.getPerformSummary());
				reportSelectedField.setCount(reportField.getRecordCount());
				reportSelectedField.setSortOrder("");
				reportSelectedFields.add(reportSelectedField);
			}
		}

		// Add default blank matrix columns, rows & measure
		// to avoid persistent issues when a report is saved, and then changed
		// from tabular/summary to matrix
		if (this.getReportCrossTabFields().getReportCrossTabColumns().size() == 0) {
			ReportCrossTabColumn column = new ReportCrossTabColumn();
			column.fieldId = -1l;
			column.sortOrder = "ASC";
			reportCrossTabFields.getReportCrossTabColumns().add(column);
		}

		if (this.getReportCrossTabFields().getReportCrossTabRows().size() == 0) {
			ReportCrossTabRow row = new ReportCrossTabRow();
			row.fieldId = -1l;
			row.sortOrder = "ASC";
			reportCrossTabFields.getReportCrossTabRows().add(row);
		}

		if (this.getReportCrossTabFields().getReportCrossTabMeasure().size() == 0) {
		    ReportCrossTabMeasure measure = new ReportCrossTabMeasure();
		    measure.fieldId = -1l;
		    measure.calculation = "SUM";
			reportCrossTabFields.getReportCrossTabMeasure().add(measure);
		}
	}

	public Boolean IsFieldGroupByField(long fieldId) {
		Boolean result = false;
		if (reportSelectedFields != null)
		{
			Iterator<ReportSelectedField> iteratorReportSelectedFields = reportSelectedFields.iterator();
			while(iteratorReportSelectedFields.hasNext()) {
				ReportSelectedField reportSelectedField = (ReportSelectedField) iteratorReportSelectedFields.next();
				if (reportSelectedField != null && reportSelectedField.getFieldId() == fieldId && reportSelectedField.getGroupBy()) {
					result = true;
					break;
				}
			}
		}
		return result;
	}

    public Boolean HasSummaryFields() {
    	Boolean result = false;
    	if (reportSelectedFields != null)
    	{
    	    Iterator<ReportSelectedField> itFields = reportSelectedFields.iterator();
    	    while(itFields.hasNext()) {
    	    	ReportSelectedField rptField = (ReportSelectedField) itFields.next();
	    		if (rptField.getIsSummarized() == true) {
	    		    result = true;
	    		    break;
	    		}
    	    }
    	}
    	return result;
    }

	public String getReportPath() {
		return reportPath;
	}

	public void setReportPath(String reportPath) {
		this.reportPath = reportPath;
	}

	public ReportField getReportFieldByColumnName(String columnName) {
		ReportField result = new ReportField();
		if (fields != null)
		{
			Iterator<ReportField> iteratorReportFields = fields.iterator();
			while(iteratorReportFields.hasNext()) {
				ReportField  reportField = iteratorReportFields.next();
				if (reportField != null && reportField.getColumnName().compareToIgnoreCase(columnName) == 0) {
					result = reportField;
					break;
				}
			}
		}
		return result;
	}

	public void setReportFilters(List<ReportFilter> reportFilters) {
		this.reportFilters = reportFilters;
	}

	public List<ReportFilter> getReportFilters() {
		return reportFilters;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String u) {
		int index = u.indexOf("@");

		if (index != -1) {
			company = u.substring(index + 1);
		} else {
			company = "Default";
		}
		username = u;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String p) {
		password = p;
	}

	public String getTempFolderPath() {
		return "/Reports/" + company + "/Temp";
	}

	public void setReportTemplateJRXML(String reportTemplateJRXML) {
		this.reportTemplateJRXML = reportTemplateJRXML;
	}

	public String getReportTemplateJRXML() {
		return reportTemplateJRXML;
	}

	public String getReportTemplatePath() {
		return reportTemplatePath;
	}

	public void setReportTemplatePath(String path) {
		reportTemplatePath = path;
		int index = path.lastIndexOf('/');
		setReportTemplateJRXML(path + "_files/" + path.substring(index + 1) + "_jrxml");
		//		reportTemplatePath = path;
	}

	public List getReportTemplateList() {
		return reportTemplateList;
	}

	public void setReportTemplateList(List l) {
		if (reportTemplateList == null)
			reportTemplateList = l;
		else
			reportTemplateList.addAll(l);
	}

	public String getCompany() {
		return company;
	}

	public void setReportSelectedFields(List<ReportSelectedField> reportSelectedFields) {
		this.reportSelectedFields = reportSelectedFields;
	}

	public List<ReportSelectedField> getReportSelectedFields() {
		return reportSelectedFields;
	}
	public String getCurrentWizardStep() {
		return currentWizardStep;
	}

	public void setCurrentWizardStep(String wizardStep) {
		this.currentWizardStep = wizardStep;
	}

	public List getReportWizardSteps() {
		return reportWizardSteps;
	}

	public void setReportWizardSteps(List reportWizardSteps) {
		this.reportWizardSteps = reportWizardSteps;
	}

	public Integer getPreviousPage() {
		return previousPage;
	}

	public void setPreviousPage(Integer previousPage) {
		this.previousPage = previousPage;
	}

	public void setShowSqlQuery(boolean showSqlQuery) {
		this.showSqlQuery = showSqlQuery;
	}

	public boolean getShowSqlQuery() {
		return showSqlQuery;
	}

	public void setDataSubSourceGroupId(long subSourceGroupId) {
		this.subSourceGroupId = subSourceGroupId;
	}

	public long getDataSubSourceGroupId() {
		return subSourceGroupId;
	}

	public void setDataSubSourceGroup(ReportDataSubSourceGroup subsourcegroup) {
		this.subsourcegroup = subsourcegroup;
	}

	public ReportDataSubSourceGroup getDataSubSourceGroup() {
		return subsourcegroup;
	}

	public void setDataSubSourceGroups(List<ReportDataSubSourceGroup> subsourcegroups) {
		this.subsourcegroups = subsourcegroups;
	}

	public List<ReportDataSubSourceGroup> getDataSubSourceGroups() {
		return subsourcegroups;
	}

	public void setPreviousDataSubSourceGroupId(long previousDataSubSourceGroupId) {
		this.previousDataSubSourceGroupId = previousDataSubSourceGroupId;
	}

	public long getPreviousDataSubSourceGroupId() {
		return previousDataSubSourceGroupId;
	}

	public void setPreviousDataSubSourceId(long previousDataSubSourceId) {
		this.previousDataSubSourceId = previousDataSubSourceId;
	}

	public long getPreviousDataSubSourceId() {
		return previousDataSubSourceId;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getId() {
		return id;
	}

	public String getReportSaveAsName() {
		if (getId() != null) {
			reportSaveAsName = "THEGURU_" + getId().toString();
		} else {
			reportSaveAsName = getDataSubSource().getDisplayName() + " Custom Report";
			if (getReportName() != null && getReportName().length() > 0)
				reportSaveAsName = getReportName();
			reportSaveAsName = reportSaveAsName.replace(" ", "_").replace("'", "").replace("\"", "");
		}
		return reportSaveAsName;
	}

	public void setReportGenerator(ReportGenerator reportGenerator) {
		this.reportGenerator = reportGenerator;
	}

	public ReportGenerator getReportGenerator() {
		return reportGenerator;
	}

	public Boolean getExecuteSegmentation() {
		return executeSegmentation;
	}

	public void setExecuteSegmentation(Boolean executeSegmentation) {
		this.executeSegmentation = executeSegmentation;
	}

	public void setUseReportAsSegmentation(Boolean useReportAsSegmentation) {
		this.useReportAsSegmentation = useReportAsSegmentation;
	}

	public Boolean getUseReportAsSegmentation() {
		return useReportAsSegmentation;
	}

	public void setSegmentationQuery(String segmentationQuery) {
		this.segmentationQuery = segmentationQuery;
	}

	public String getSegmentationQuery() {
		return segmentationQuery;
	}

	public void setReportSegmentationTypeId(long reportSegmentationTypeId) {
		this.reportSegmentationTypeId = reportSegmentationTypeId;
	}

	public long getReportSegmentationTypeId() {
		return reportSegmentationTypeId;
	}

	public void setLastRunDateTime(Date lastRunDateTime) {
		this.lastRunDateTime = lastRunDateTime;
	}

	public Date getLastRunDateTime() {
		return lastRunDateTime;
	}

	public void setExecutionTime(long executionTime) {
		this.executionTime = executionTime;
	}

	public long getExecutionTime() {
		return executionTime;
	}

	public void setResultCount(int resultCount) {
		this.resultCount = resultCount;
	}

	public int getResultCount() {
		return resultCount;
	}

	public void setLastRunByUserName(String lastRunByUserName) {
		this.lastRunByUserName = lastRunByUserName;
	}

	public String getLastRunByUserName() {
		return lastRunByUserName;
	}
}