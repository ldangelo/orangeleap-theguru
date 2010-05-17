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
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.JoinColumn;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.annotations.IndexColumn;
import org.hibernate.annotations.Sort;
import org.hibernate.annotations.SortType;
import com.mpower.domain.ReportFormatType;

@Entity
@Table(name = "REPORTDATASUBSOURCEGROUP")
public class ReportDataSubSourceGroup implements java.io.Serializable,
		Comparable<ReportDataSubSourceGroup> {
	/**
	 * 
	 */
	@Transient
	protected final Log logger = LogFactory.getLog(getClass());
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTSUBSOURCEGROUP_ID")
	private long id;

	@Column(name = "DISPLAY_NAME")
	private String displayName;

	@Column(name = "DESCRIPTION")
	private String description;
	
	@ManyToOne( cascade=CascadeType.ALL)
	@IndexColumn(name="REPORTSOURCE_ID")
	private ReportDataSource reportDataSource;
	
	public ReportDataSubSourceGroup(ReportDataSubSourceGroup reportDataSubSourceGroup) {
		displayName      = reportDataSubSourceGroup.displayName;
		description         = reportDataSubSourceGroup.description;
		reportDataSource = new ReportDataSource(reportDataSubSourceGroup.reportDataSource);
	}

	public ReportDataSubSourceGroup() {

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

	public int compareTo(ReportDataSubSourceGroup o) {
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

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}
}
