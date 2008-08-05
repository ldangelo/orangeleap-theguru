package com.mpower.domain;

import javax.persistence.Entity;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class ReportField implements java.io.Serializable,
		Comparable<ReportField> {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;

	// private ReportFieldGroup group;
	private String displayName;
	private String columnName;

	@Enumerated
	private ReportFieldType type;
	private Boolean isDefault;
	private Boolean canBeSummarized;
	private Boolean isSummarized;
	private Boolean selected;

	public ReportField() {

	}

	public Boolean getSelected() {
		return selected;
	}

	public void setSelected(Boolean selected) {
		this.selected = selected;
	}

	public long getId() {
		return id;
	}

	public Boolean getIsSummarized() {
		return isSummarized;
	}

	public void setIsSummarized(Boolean isSummarized) {
		this.isSummarized = isSummarized;
	}

	public void setDisplayName(String name) {
		displayName = name;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setColumnName(String cName) {
		columnName = cName;
	}

	public String getColumnName() {
		return columnName;
	}

	public void setFieldType(ReportFieldType t) {
		type = t;
	}

	public ReportFieldType getFieldType() {
		return type;
	}

	public void setIsDefault(Boolean d) {
		isDefault = d;
	}

	public Boolean getIsDefault() {
		return isDefault;
	}

	public void setCanBeSummarized(Boolean cbs) {
		canBeSummarized = cbs;
	}

	public Boolean getCanBeSummarized() {
		return canBeSummarized;
	}

	@Override
	public int compareTo(ReportField o) {
		if (this.id > o.id)
			return 1;
		if (this.id < o.id)
			return -1;

		return 0;
	}

}