package com.mpower.domain;

import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.annotations.IndexColumn;
import com.mpower.domain.ReportFormatType;

@Entity
@Table(name = "REPORTDATASUBSOURCE")
public class ReportDataSubSource implements java.io.Serializable,
		Comparable<ReportDataSubSource> {
	/**
	 *
	 */
	@Transient
	protected final Log logger = LogFactory.getLog(getClass());
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTSUBSOURCE_ID")
	private long id;

	@Column(name = "DISPLAY_NAME")
	private String displayName;

	@Column(name = "VIEW_NAME", length = 8000)
	private String viewName;

	@ManyToOne( cascade=CascadeType.ALL)
	@IndexColumn(name="REPORTDATASUBSOURCEGROUP_ID")
	private ReportDataSubSourceGroup reportDataSubSourceGroup;

	@Enumerated
	@Column(name = "REPORT_FORMAT_TYPE")
	private ReportFormatType reportType;
	// private ReportStandardFilter standardFilter;
	// private ReportAdvancedFilter advancedFilter;
	// private Integer rowCount;

	@Column(name = "DATABASE_TYPE")
	private ReportDatabaseType databaseType;

	@Column(name = "JASPER_DATASOURCE_NAME")
	private String jasperDatasourceName;

	@Column(name = "SEGMENTATION_RESULTS_DATASOURCE_NAME")
	private String segmentationResultsDatasourceName;

	@Column(name = "DESCRIPTION")
	private String description;

	@ManyToMany(mappedBy="reportDataSubSource")
	@IndexColumn(name="REPORTCUSTOMFILTERDEFINITION_ID")
	@Column(name = " REPORTDATASUBSOURCE_REPORTCUSTOMFILTERDEFINITION_ID")
	private List<ReportCustomFilterDefinition> reportCustomFilterDefinitions;

	@ManyToMany(mappedBy="reportDataSubSource",cascade=CascadeType.ALL)
	@IndexColumn(name="REPORTSEGMENTATIONTYPE_ID")
	@Column(name = " REPORTDATASUBSOURCE_REPORTSEGMENTATIONTYPE_ID")
	private List<ReportSegmentationType> reportSegmentationTypes;

	@Column(name = "ALLOW_DYNAMIC_SQL_GENERATION")
	private Boolean allowDynamicSqlGeneration;
	
	public ReportDataSubSource(ReportDataSubSource reportDataSubSource) {
		displayName      = reportDataSubSource.displayName;
		viewName         = reportDataSubSource.viewName;
		reportDataSubSourceGroup = new ReportDataSubSourceGroup(reportDataSubSource.reportDataSubSourceGroup);
		description = reportDataSubSource.description;
		databaseType = reportDataSubSource.databaseType;
		jasperDatasourceName = reportDataSubSource.jasperDatasourceName;
		segmentationResultsDatasourceName = reportDataSubSource.segmentationResultsDatasourceName;
		reportCustomFilterDefinitions = reportDataSubSource.reportCustomFilterDefinitions;
		reportType = reportDataSubSource.reportType;
	}

	public ReportDataSubSource() {

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name = "DISPLAY_NAME")
	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	@Column(name = "VIEW_NAME")
	public String getViewName() {
		return viewName;
	}

	public void setViewName(String viewName) {
		this.viewName = viewName;
	}


	public int compareTo(ReportDataSubSource o) {
		if (this.id > o.id)
			return 1;
		if (this.id < o.id)
			return -1;

		return 0;
	}

	public ReportDataSubSourceGroup getReportDataSubSourceGroup() {
		return reportDataSubSourceGroup;
	}

	public void setReportDataSubSourceGroup(ReportDataSubSourceGroup reportDataSubSourceGroup) {
		this.reportDataSubSourceGroup = reportDataSubSourceGroup;
	}

	public void setDatabaseType(ReportDatabaseType databaseType) {
		this.databaseType = databaseType;
	}

	public ReportDatabaseType getDatabaseType() {
		return databaseType;
	}

	public void setJasperDatasourceName(String jasperDatasourceName) {
		this.jasperDatasourceName = jasperDatasourceName;
	}

	public String getJasperDatasourceName() {
		return jasperDatasourceName;
	}

	public void setReportCustomFilterDefinitions(List<ReportCustomFilterDefinition> reportCustomFilterDefinitions) {
		this.reportCustomFilterDefinitions = reportCustomFilterDefinitions;
	}

	public List<ReportCustomFilterDefinition> getReportCustomFilterDefinitions() {
		return reportCustomFilterDefinitions;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}

	public void setReportSegmentationTypes(List<ReportSegmentationType> reportSegmentationTypes) {
		this.reportSegmentationTypes = reportSegmentationTypes;
	}

	public List<ReportSegmentationType> getReportSegmentationTypes() {
		return reportSegmentationTypes;
	}

	public void setSegmentationResultsDatasourceName(
			String segmentationResultsDatasourceName) {
		this.segmentationResultsDatasourceName = segmentationResultsDatasourceName;
	}

	public String getSegmentationResultsDatasourceName() {
		return segmentationResultsDatasourceName;
	}

	public void setAllowDynamicSqlGeneration(Boolean allowDynamicSqlGeneration) {
		this.allowDynamicSqlGeneration = allowDynamicSqlGeneration;
	}

	public Boolean getAllowDynamicSqlGeneration() {
		return allowDynamicSqlGeneration;
	}
}
