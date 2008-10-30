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
@Table(name = "REPORTADVANCEDFILTER")
public class ReportAdvancedFilter implements java.io.Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTADVANCEDFILTER_ID")
	private long id;

	@Column(name = "REPORTFIELD_ID")
	Long        fieldId;
	
	@Enumerated
	@Column(name = "FILTER_OPERATOR")
	Integer operator;
	String value;

	@Transient
	private boolean promptForCriteria;

	@Transient
	private String criteria;
	
	public ReportAdvancedFilter() {
		fieldId = 0L;
		value = "";
		operator = 0;
	}

	public Integer getOperator() {
		return operator;
	}

	public String getValue() {
		return value;
	}

	public void setFieldId(Long l)
	{
		this.fieldId = l;
	}
	
	public Long getFieldId()
	{
		return fieldId;
	}
	
	public void setOperator(Integer o)
	{
	
		this.operator = o;
	}
	
	public void setValue(String value) {
		this.value = value;
	}
	
	public boolean getPromptForCriteria() {
		return promptForCriteria;
	}

	public void setPromptForCriteria(boolean promptForCriteria) {
		this.promptForCriteria = promptForCriteria;
	}

	public void setCriteria(String criteria) {
		this.criteria = criteria;
	}

	public String getCriteria() {
		return criteria;
	}
}