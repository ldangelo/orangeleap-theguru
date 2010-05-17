package com.mpower.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "THEGURU_SEGMENTATION_RESULT")
public class ReportSegmentationResult implements java.io.Serializable,
		Comparable<ReportSegmentationResult> {

	/**
	 *
	 */
	private static final long serialVersionUID = -1721178539408594854L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "THEGURU_SEGMENTATION_RESULT_ID")
	private Long id;

	@Column(name = "REPORT_ID")
	private long reportId;

	@Column(name = "ENTITY_ID")
	private long entityId;

	public ReportSegmentationResult() {
		id = null;
	}

	public ReportSegmentationResult(ReportSegmentationResult reportSegmentationResult) {
		id = null;
		reportId = reportSegmentationResult.reportId;
		entityId = reportSegmentationResult.entityId;
	}

	public int compareTo(ReportSegmentationResult o) {
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

	public void setReportId(long reportId) {
		this.reportId = reportId;
	}

	public long getReportId() {
		return reportId;
	}

	public void setEntityId(long entityId) {
		this.entityId = entityId;
	}

	public long getEntityId() {
		return entityId;
	}
}