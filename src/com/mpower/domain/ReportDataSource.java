package com.mpower.domain;

import java.util.SortedSet;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Transient;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.annotations.Sort;
import org.hibernate.annotations.SortType;

@Entity
public class ReportDataSource implements java.io.Serializable,
		Comparable<ReportDataSource> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTSOURCE_ID")
	private long id;

	private String Name;

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	@Sort(type = SortType.NATURAL)
	private SortedSet<com.mpower.domain.ReportDataSubSource> subSource;
	@Transient
	protected final Log logger = LogFactory.getLog(getClass());

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name = "DISPLAY_NAME")
	public String getName() {
		return Name;
	}

	public void setName(String displayName) {
		Name = displayName;
	}

	public void setSubSources(SortedSet<ReportDataSubSource> ss) {
		subSource = ss;
	}

	public SortedSet<ReportDataSubSource> getSubSources() {
		logger.info("**** getSubSources");

		return subSource;
	}

	@Override
	public int compareTo(ReportDataSource o) {
		if (this.id > o.getId())
			return 1;
		if (this.id < o.getId())
			return -1;

		return 0;
	}
}
