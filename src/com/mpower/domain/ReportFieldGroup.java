package com.mpower.domain;

import java.util.List;
import java.util.Map;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.Sort;
import org.hibernate.annotations.SortType;

@Entity
public class ReportFieldGroup implements java.io.Serializable,
		Comparable<ReportFieldGroup> {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;

	@ManyToOne
	@JoinColumn(name="REPORTSUBSOURCE_ID")
	private ReportDataSubSource reportDataSubSource;
	public ReportFieldGroup(ReportFieldGroup group) {
		reportDataSubSource = new ReportDataSubSource(reportDataSubSource);
	}

	public ReportFieldGroup() {

	}

	public ReportDataSubSource getReportDataSubSource() {
		return reportDataSubSource;
	}

	public void setReportDataSubSource(ReportDataSubSource reportDataSubSource) {
		this.reportDataSubSource = reportDataSubSource;
	}


	private String Name;


	public void setName(String n) {
		Name = n;
	}

	public String getName() {
		return Name;
	}


	public int compareTo(ReportFieldGroup o) {
		if (this.id > o.id)
			return 1;
		if (this.id < o.id)
			return -1;

		return 0;
	}
}