package com.mpower.domain;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import org.hibernate.annotations.IndexColumn;

@Entity
@Table(name = "REPORTSEGMENTATIONTYPE")
public class ReportSegmentationType implements java.io.Serializable,
		Comparable<ReportSegmentationType> {
	/**
	 *
	 */
	private static final long serialVersionUID = -2138347360965441828L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTSEGMENTATIONTYPE_ID")
	private Long id;

	@Column(name = "SEGMENTATIONTYPE")
	private String segmentationType;

	@Column(name = "COLUMN_NAME")
	private String columnName;

	@ManyToMany(cascade=CascadeType.ALL)
	@IndexColumn(name="REPORTSUBSOURCE_ID")
	@Column(name = "REPORTSUBSOURCE_ID")
	private List<ReportDataSubSource> reportDataSubSource;

	public ReportSegmentationType() {
		id = null;
	}

	public ReportSegmentationType(ReportSegmentationType reportSegmentationType) {
		id = null;
		segmentationType = reportSegmentationType.segmentationType;
		columnName = reportSegmentationType.columnName;
		reportDataSubSource = reportSegmentationType.reportDataSubSource;
	}

	public int compareTo(ReportSegmentationType o) {
		if (this.id > o.id)
			return 1;
		if (this.id < o.id)
			return -1;

		return 0;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long value) {
		id = value;
	}

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String cName) {
		columnName = cName;
	}

	public void setSegmentationType(String segmentationType) {
		this.segmentationType = segmentationType;
	}

	public String getSegmentationType() {
		return segmentationType;
	}

	public void setReportDataSubSource(List<ReportDataSubSource> reportDataSubSource) {
		this.reportDataSubSource = reportDataSubSource;
	}

	public List<ReportDataSubSource> getReportDataSubSource() {
		return reportDataSubSource;
	}
}