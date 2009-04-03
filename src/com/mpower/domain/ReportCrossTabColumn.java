package com.mpower.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "REPORTCROSSTABCOLUMN")
public class ReportCrossTabColumn implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 5128089352333892931L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTCROSSTABCOLUMN_ID")
	private long id;

	
	@Column(name = "REPORTFIELD_ID")	
	Long fieldId;

	@Column(name = "SORTORDER")
	String sortOrder;
	
	@Enumerated
	@Column(name = "GROUPDATEBYOPTION")
	Integer groupDateByOption;
	
	@Column(name = "CALCULATION")
	String calculation;

	public ReportCrossTabColumn() {
		fieldId = -1L;
		sortOrder = "";
		groupDateByOption = 0;
		calculation = "";
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
	
	public String getCalculation() {
		return calculation;
	}

	public void setCalculation(String value) {
		this.calculation = value;
	}
}	
