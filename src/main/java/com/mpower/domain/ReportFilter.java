package com.mpower.domain;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.IndexColumn;

@Entity
@Table(name = "REPORTFILTER")
public class ReportFilter implements java.io.Serializable {
  /**
	 * 
	 */
	private static final long serialVersionUID = 42499766871980738L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTFILTER_ID")
	private long id;
	
	@Column(name = "FILTER_TYPE")
	private int filterType;	

	@Column(name = "OPERATOR")
	private Integer operator;	

	@Column(name = "OPERATOR_NOT")
	private Integer operatorNot;	
	
	@OneToOne(cascade = CascadeType.ALL)
	@IndexColumn(name="REPORTSTANDARDFILTER_ID")
	private ReportStandardFilter reportStandardFilter;
	
	@OneToOne(cascade = CascadeType.ALL)
	@IndexColumn(name="REPORTCUSTOMFILTER_ID")
	private ReportCustomFilter reportCustomFilter;
  
	public ReportFilter() {
		filterType = 0;
		operator = 0;
		operatorNot = 0;
		reportStandardFilter = new ReportStandardFilter();
		reportCustomFilter = new ReportCustomFilter();
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getId() {
		return id;
	}

	public void setFilterType(int filterType) {
		this.filterType = filterType;
	}

	public int getFilterType() {
		return filterType;
	}

	public void setOperator(Integer operator) {
		this.operator = operator;
	}

	public Integer getOperator() {
		return operator;
	}

	public void setOperatorNot(Integer operatorNot) {
		this.operatorNot = operatorNot;
	}

	public Integer getOperatorNot() {
		return operatorNot;
	}

	public void setReportStandardFilter(ReportStandardFilter reportStandardFilter) {
		this.reportStandardFilter = reportStandardFilter;
	}

	public ReportStandardFilter getReportStandardFilter() {
		return reportStandardFilter;
	}

	public void setReportCustomFilter(ReportCustomFilter reportCustomFilter) {
		this.reportCustomFilter = reportCustomFilter;
	}

	public ReportCustomFilter getReportCustomFilter() {
		return reportCustomFilter;
	}
}