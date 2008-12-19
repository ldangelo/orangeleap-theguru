package com.mpower.domain;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

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
	
	@Transient
	private int filterType;	

	@Transient
	private Integer operator;	

	@Transient
	private Integer operatorNot;	
	
	@Transient
	private ReportStandardFilter reportStandardFilter;
	
	@Transient
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