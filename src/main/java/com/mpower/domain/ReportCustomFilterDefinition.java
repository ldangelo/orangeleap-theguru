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
@Table(name = "REPORTCUSTOMFILTERDEFINITION")
public class ReportCustomFilterDefinition implements java.io.Serializable,
		Comparable<ReportCustomFilterDefinition> {
	/**
	 *
	 */
	@Transient
	private static final long serialVersionUID = 1452667860074343989L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTCUSTOMFILTERDEFINITION_ID")
	private Long id;

	@Column(name = "DISPLAY_TEXT", length = 8000)
	private String displayText;

	@Column(name = "DISPLAY_HTML", length = 8000)
	private String displayHtml;

	@Column(name = "SQL_TEXT", length = 8000)
	private String sqlText;

	@ManyToMany(cascade=CascadeType.ALL)
	@IndexColumn(name="REPORTSUBSOURCE_ID")
	@Column(name = "REPORTSUBSOURCE_ID")
	private List<ReportDataSubSource> reportDataSubSource;

	public ReportCustomFilterDefinition() {
		id = null;
	}

	public ReportCustomFilterDefinition(ReportCustomFilterDefinition reportCustomFilterDefinition) {
		id = null;
		this.setDisplayText(reportCustomFilterDefinition.getDisplayText());
		this.setSqlText(reportCustomFilterDefinition.getSqlText());
		this.setDisplayHtml(reportCustomFilterDefinition.getDisplayHtml());
		this.setReportDataSubSource(reportCustomFilterDefinition.getReportDataSubSource());
	}

	public int compareTo(ReportCustomFilterDefinition o) {
		if (this.id > o.id)
			return 1;
		if (this.id < o.id)
			return -1;

		return 0;
	}

	public void setDisplayText(String displayText) {
		this.displayText = displayText;
	}

	public String getDisplayText() {
		return displayText;
	}

	public void setSqlText(String sqlText) {
		this.sqlText = sqlText;
	}

	public String getSqlText() {
		return sqlText;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getId() {
		return id;
	}

	public void setReportDataSubSource(List<ReportDataSubSource> reportDataSubSource) {
		this.reportDataSubSource = reportDataSubSource;
	}

	public List<ReportDataSubSource> getReportDataSubSource() {
		return reportDataSubSource;
	}

	public void setDisplayHtml(String displayHtml) {
		this.displayHtml = displayHtml;
	}

	public String getDisplayHtml() {
		String result = displayHtml;
		result = result.replace("\"", "&quot;");
		result = result.replace(">", "&gt;");
		result = result.replace("<", "&lt;");
		return result;
	}
}