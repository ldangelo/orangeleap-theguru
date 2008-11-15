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
import javax.persistence.Transient;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
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
	private Long id;

	@ManyToMany(cascade=CascadeType.ALL)
	@IndexColumn(name="REPORTSUBSOURCE_ID")
	@Column(name = "REPORTFIELDGROUP_REPORTSUBSOURCE_ID")
	private List<ReportDataSubSource> reportDataSubSource;
	
	@ManyToMany(mappedBy="reportFieldGroup",cascade=CascadeType.ALL)
	@IndexColumn(name="REPORTFIELD_ID")
	@Column(name = " REPORTFIELDGROUP_REPORTFIELD_ID")
	private List<ReportField>   fields;
	
	@Transient
	protected final Log logger = LogFactory.getLog(getClass());

  public long getFieldCount() {
    int size = fields.size();

    logger.info("getFieldCount() returns " + size);

    return fields.size();
  }

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
		id = null;
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

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
}