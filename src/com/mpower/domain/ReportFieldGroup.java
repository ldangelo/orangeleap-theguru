package com.mpower.domain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.IndexColumn;
import org.hibernate.annotations.Sort;
import org.hibernate.annotations.SortType;

@Entity
@Table(name = "REPORTFIELDGROUP")
public class ReportFieldGroup implements java.io.Serializable,
		Comparable<ReportFieldGroup> {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTFIELDGROUP_ID")
	private long id;

	@ManyToMany(cascade=CascadeType.ALL)
	@IndexColumn(name="REPORTSUBSOURCE_ID")
	private List<ReportDataSubSource> reportDataSubSource;
	
	@ManyToMany(mappedBy="reportFieldGroup",cascade=CascadeType.ALL)
	@IndexColumn(name="REPORTFIELD_ID")
	private List<ReportField>   fields;
	

	public List<ReportField> getFields() {
		return fields;
	}

	public void setFields(List<ReportField> fields) {
		this.fields = fields;
	}

	public ReportFieldGroup(ReportFieldGroup group) {
		this.reportDataSubSource = group.reportDataSubSource;
	}

	public ReportFieldGroup() {

	}

	public List<ReportDataSubSource> getReportDataSubSource() {
		return reportDataSubSource;
	}

	public void setReportDataSubSource(List<ReportDataSubSource> reportDataSubSource) {
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

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
}