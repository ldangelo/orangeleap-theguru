package com.mpower.domain;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.hibernate.annotations.IndexColumn;

@Entity
@Table(name = "REPORTCUSTOMFILTERCRITERIA")
public class ReportCustomFilterCriteria implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 9209023329751419977L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTCUSTOMFILTERCRITERIA_ID")
	private long customFilterCriteriaId;

	@ManyToOne(cascade=CascadeType.ALL)
	@IndexColumn(name="REPORTCUSTOMFILTER_ID")
	private ReportCustomFilter reportCustomFilter;
	
	@Column(name = "CRITERIA")
	private String criteria;

	public ReportCustomFilterCriteria() {
	}

	public void setCustomFilterCriteriaId(long customFilterCriteriaId) {
		this.customFilterCriteriaId = customFilterCriteriaId;
	}

	public long getCustomFilterCriteriaId() {
		return customFilterCriteriaId;
	}

	public void setCriteria(String criteria) {
		this.criteria = criteria;
	}

	public String getCriteria() {
		return criteria;
	}
}
