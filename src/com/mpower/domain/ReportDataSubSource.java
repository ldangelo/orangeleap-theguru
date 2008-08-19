package com.mpower.domain;

import java.util.List;
import java.util.Map;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Transient;
import javax.persistence.JoinColumn;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.annotations.IndexColumn;
import org.hibernate.annotations.Sort;
import org.hibernate.annotations.SortType;
import com.mpower.domain.ReportFormatType;

@Entity
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

	private String displayName;
	private String viewName;
	
	@ManyToOne( cascade=CascadeType.ALL)
	@IndexColumn(name="REPORTSOURCE_ID")
	private ReportDataSource reportDataSource;
	
//	@ManyToMany(mappedBy="reportDataSubSource",cascade=CascadeType.ALL)
//	@IndexColumn(name="REPORTFIELDGROUP_ID")
//	private List<ReportFieldGroup> fieldGroups;
	
//	public List<ReportFieldGroup> getFieldGroups() {
//		return fieldGroups;
//	}
//
//	public void setFieldGroups(List<ReportFieldGroup> fieldGroups) {
//		this.fieldGroups = fieldGroups;
//	}

	@Enumerated
	private ReportFormatType reportType;
	// private ReportStandardFilter standardFilter;
	// private ReportAdvancedFilter advancedFilter;
	// private Integer rowCount;


	public ReportDataSubSource(ReportDataSubSource reportDataSubSource) {
		displayName      = reportDataSubSource.displayName;
		viewName         = reportDataSubSource.viewName;
		reportDataSource = new ReportDataSource(reportDataSubSource.reportDataSource);
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

	public ReportDataSource getReportDataSource() {
		return reportDataSource;
	}

	public void setReportDataSource(ReportDataSource reportDataSouce) {
		this.reportDataSource = reportDataSouce;
	}
}
