package com.mpower.domain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.IndexColumn;

@Entity
@Table(name = "REPORTFIELD")
public class ReportField implements java.io.Serializable,
		Comparable<ReportField> {
	/**
	 * 
	 */
	@Transient
	private static final long serialVersionUID = -2871208732277362753L;

	@Transient
	long controlCount;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTFIELD_ID")
	private Long id;

	@Column(name = "DISPLAY_NAME")
	private String displayName;

	@Column(name = "COLUMN_NAME")
	private String columnName;

	@Enumerated
	@Column(name = "FIELD_TYPE")
	private ReportFieldType type;

	@Column(name = "CAN_BE_SUMMARIZED")
	private Boolean canBeSummarized;

	@Column(name = "IS_SUMMARIZED")
	private Boolean isSummarized;

	@Column(name = "IS_SELECTED")
	private Boolean selected;

	@Column(name = "IS_DEFAULT")
	private Boolean isDefault;

	@Column(name = "PERFORMSUMMARY")
	private Boolean performSummary;

	@Column(name = "AVERAGE")
	private Boolean average;

	@Column(name = "LARGEST_VALUE")
	private Boolean largestValue;

	@Column(name = "SMALLEST_VALUE")
	private Boolean smallestValue;
	
	@Column(name = "RECORD_COUNT")
	private Boolean recordCount;

	public Boolean getPerformSummary() {
		return performSummary;
	}

	public void setPerformSummary(Boolean performSummary) {
		this.performSummary = performSummary;
		determineIsSummarized();
	}

	public Boolean getAverage() {
		return average;
	}

	public void setAverage(Boolean average) {
		this.average = average;
		determineIsSummarized();
	}

	public Boolean getLargestValue() {
		return largestValue;
	}

	public void setLargestValue(Boolean largestValue) {
		this.largestValue = largestValue;
		determineIsSummarized();
	}

	public Boolean getSmallestValue() {
		return smallestValue;
	}

	public void setSmallestValue(Boolean smallestValue) {
		this.smallestValue = smallestValue;
		determineIsSummarized();
	}
	
	public Boolean getRecordCount() {
		return recordCount;
	}

	public void setRecordCount(Boolean recordCount) {
		this.recordCount = recordCount;
		determineIsSummarized();
	}

	@ManyToMany(cascade = CascadeType.ALL)
	@IndexColumn(name = "REPORTFIELDGROUP_ID")
	private List<ReportFieldGroup> reportFieldGroup;

	public ReportField() {
		id = null;

	}

	public ReportField(ReportField f) {
		id = null;
		displayName = f.displayName;
		columnName = f.columnName;
		type = f.type;
		canBeSummarized = f.canBeSummarized;
		isSummarized = f.isSummarized;
		selected = f.selected;
		recordCount = f.recordCount;
		// reportFieldGroup = new
		// ArrayList<ReportFieldGroup>(f.reportFieldGroup);
	}

	public int compareTo(ReportField o) {
		if (this.id > o.id)
			return 1;
		if (this.id < o.id)
			return -1;

		return 0;
	}

	public Boolean getCanBeSummarized() {
		return canBeSummarized;
	}

	public String getControlName() {
		return columnName + controlCount++;
	}
	
	public String getColumnName() {
		return columnName;
	}

	public String getDisplayName() {
		return displayName;
	}

	public ReportFieldType getFieldType() {
		return type;
	}

	public Long getId() {
		return id;
	}

	public Boolean getIsDefault() {
		return isDefault;
	}

	public Boolean getIsSummarized() {
		return isSummarized;
	}

	public Boolean getSelected() {
		return selected;
	}

	public void setCanBeSummarized(Boolean cbs) {
		canBeSummarized = cbs;
	}

	public void setColumnName(String cName) {
		columnName = cName;
	}

	public void setDisplayName(String name) {
		displayName = name;
	}

	public void setFieldType(ReportFieldType t) {
		type = t;
	}

	public void setIsDefault(Boolean isDefault) {
		this.isDefault = isDefault;
	}

	public void setIsSummarized(Boolean isSummarized) {
		this.isSummarized = isSummarized;
	}

	public void setSelected(Boolean selected) {
		this.selected = selected;
	}

	public List<ReportFieldGroup> getReportFieldGroup() {
		return reportFieldGroup;
	}

	public void setReportFieldGroup(List<ReportFieldGroup> reportFieldGroup) {
		this.reportFieldGroup = reportFieldGroup;
	}

	public void determineIsSummarized() {
		if (average || performSummary || largestValue || smallestValue || (recordCount != null && recordCount))
			setIsSummarized(true);
		else
			setIsSummarized(false);
	}
	
}