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
@Table(name = "REPORTSTANDARDFILTER")
public class ReportStandardFilter implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6653013193305909307L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTSTANDARDFILTER_ID")
	private long id;

	@Column(name = "REPORTFIELD_ID")
	Long        fieldId;
	
	@Enumerated
	@Column(name = "FILTER_COMPARISON")
	Integer comparison;

	@Column(name = "PROMPT_FOR_CRITERIA")
	private boolean promptForCriteria;

	@Column(name = "CRITERIA")
	private String criteria;
	
	public ReportStandardFilter() {
		fieldId = 0L;
		criteria = "";
		comparison = 0;
		promptForCriteria = false;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getId() {
		return id;
	}	
	
	public Long getFieldId()
	{
		return fieldId;
	}
	
	public void setFieldId(Long l)
	{
		this.fieldId = l;
	}
	
	public Integer getComparison() {
		return comparison;
	}

	public void setComparison(Integer o)
	{	
		this.comparison = o;
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
