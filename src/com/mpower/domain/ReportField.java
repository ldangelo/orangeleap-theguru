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

import org.hibernate.annotations.IndexColumn;

@Entity
public class ReportField implements java.io.Serializable,
		Comparable<ReportField> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2871208732277362753L;


	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTFIELD_ID")
	private long id;


	private String displayName;
	private String columnName;

	@Enumerated
	private ReportFieldType type;
	private Boolean canBeSummarized;
	private Boolean isSummarized;
	private Boolean selected;
	private Boolean isDefault;
	private Boolean sum;
	private Boolean average;
	private Boolean largestValue;
	private Boolean smallestValue;
	
	public Boolean getSum() {
		return sum;
	}

	public void setSum(Boolean sum) {
		this.sum = sum;
	}

	public Boolean getAverage() {
		return average;
	}

	public void setAverage(Boolean average) {
		this.average = average;
	}

	public Boolean getLargestValue() {
		return largestValue;
	}

	public void setLargestValue(Boolean largestValue) {
		this.largestValue = largestValue;
	}

	public Boolean getSmallestValue() {
		return smallestValue;
	}

	public void setSmallestValue(Boolean smallestValue) {
		this.smallestValue = smallestValue;
	}

	@ManyToMany(cascade=CascadeType.ALL)
	@IndexColumn(name="REPORTFIELDGROUP_ID")
	private List<ReportFieldGroup> reportFieldGroup;

	public ReportField() {

	}

	public ReportField(ReportField f) {
		displayName = f.displayName;
		columnName  = f.columnName;
		type        = f.type;
		canBeSummarized = f.canBeSummarized;
		isSummarized = f.isSummarized;
		selected    = f.selected;
//		reportFieldGroup = new ArrayList<ReportFieldGroup>(f.reportFieldGroup);
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

	public String getColumnName() {
		return columnName;
	}

	public String getDisplayName() {
		return displayName;
	}

	public ReportFieldType getFieldType() {
		return type;
	}

	public long getId() {
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

}