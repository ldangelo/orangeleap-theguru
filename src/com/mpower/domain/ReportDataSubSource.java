package com.mpower.domain;

import java.util.SortedSet;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Enumerated;
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
public class ReportDataSubSource implements java.io.Serializable,
		Comparable<ReportDataSubSource> {
	/**
	 * 
	 */
	@Transient
	protected final Log logger = LogFactory.getLog(getClass());
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTSOURCE_ID")
	private long id;

	private String displayName;
	private String viewName;

	@Enumerated
	private ReportFormatType reportType;
	// private ReportStandardFilter standardFilter;
	// private ReportAdvancedFilter advancedFilter;
	// private Integer rowCount;

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	@Sort(type = SortType.NATURAL)
	private SortedSet<com.mpower.domain.ReportFieldGroup> fieldGroups;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name = "DISPLAY_NAME")
	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	@Column(name = "VIEW_NAME")
	public String getViewName() {
		return viewName;
	}

	public void setViewName(String viewName) {
		this.viewName = viewName;
	}

	public void setFieldGroups(SortedSet<ReportFieldGroup> fg) {
		logger.info("**** setFieldGroups");
		fieldGroups = fg;
	}

	public SortedSet<ReportFieldGroup> getFieldGroups() {
		logger.info("**** getFieldGroups");
		// Hibernate.initialize(fieldGroups);

		return fieldGroups;
	}

	@Override
	public int compareTo(ReportDataSubSource o) {
		if (this.id > o.id)
			return 1;
		if (this.id < o.id)
			return -1;

		return 0;
	}
}
