package com.mpower.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "REPORTGROUPBYFIELD")
public class ReportGroupByField implements java.io.Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTGROUPBYFIELD_ID")
	private long id;

	@Column(name = "REPORTFIELD_ID")	
	Long fieldId;

	@Column(name = "SORTORDER")
	String sortOrder;
	
	@Enumerated
	@Column(name = "GROUPDATEBYOPTION")
	Integer groupDateByOption;

	public ReportGroupByField() {
		fieldId = 0L;
		sortOrder = "";
		groupDateByOption = 0;
	}

	public Long getFieldId()
	{
		return fieldId;
	}

	public void setFieldId(Long value)
	{
		this.fieldId = value;
	}	
	
	public String getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(String value) {
		this.sortOrder = value;
	}
	
	public Integer getGroupDateByOption() {
		return groupDateByOption;
	}
	
	public void setGroupDateByOption(Integer value)
	{	
		this.groupDateByOption = value;
	}
}	
