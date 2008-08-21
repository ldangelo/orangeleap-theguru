package com.mpower.domain;

import java.util.List;
import java.util.SortedSet;
import java.util.ArrayList;

import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ReportWizard {

	protected final Log logger = LogFactory.getLog(getClass());
	private String reportName;
	private Integer rowCount;
	private long srcId;

	private long subSourceId;

	private ReportDataSource src;
	private ReportDataSubSource subsource;
	private List<ReportDataSource> sources;
	private List<ReportDataSubSource> subsources;
	private List<ReportField> fields;
	private List<ReportFieldGroup> fieldGroups;
	private List<ReportAdvancedFilter> advancedFilters;
	private String reportType;
	
	public ReportWizard() {
		reportType = "tabular";
		srcId = 0;
		subSourceId = 0;
		rowCount = -1;

		//
		// create an advanced filter list decorated as a LazyList
		//advancedFilters = LazyList.decorate(new ArrayList<ReportAdvancedFilter>(),FactoryUtils.instantiateFactory(ReportAdvancedFilter.class, new Class[]{ReportAdvancedFilter.class},new Object[]{}));
		advancedFilters = LazyList.decorate(new ArrayList<ReportAdvancedFilter>(),FactoryUtils.instantiateFactory(ReportAdvancedFilter.class));
	}
	
	public List<ReportAdvancedFilter> getAdvancedFilters() {
		return advancedFilters;
	}

	public ReportDataSource getDataSource() {
		logger.info("**** in getSrc()");
		return src;
	}

	public List<ReportDataSource> getDataSources() {
		return sources;
	}

	public ReportDataSubSource getDataSubSource() {
		logger.info("**** in getDatasubSource");
		return subsource;
	}

	public List<ReportDataSubSource> getDataSubSources() {
		return subsources;
	}

	public List<ReportFieldGroup> getFieldGroups() {
		return fieldGroups;
	}

	public List<ReportField> getFields() {
		return fields;
	}

	public ReportDataSource getReportDataSource() {
		return src;
	}

	public String getReportName() {
		return reportName;
	}

	public String getReportType() {
		logger.info("**** getReportType");
		return reportType;
	}

	public Integer getRowCount() {
		return rowCount;
	}

	public long getSrcId() {
		return srcId;
	}

	public long getSubSourceId() {
		return subSourceId;
	}

	public void setAdvancedFilters(List<ReportAdvancedFilter> advancedFilters) {
		this.advancedFilters = advancedFilters;
	}

	public void setDataSource(ReportDataSource src) {
		logger.info("**** in setSrc()");
		this.src = src;
	}

	public void setDataSources(List<ReportDataSource> sources) {
		this.sources = sources;
	}

	public void setDataSubSource(ReportDataSubSource subsource) {
		logger.info("**** in setDatasubSource");
		this.subsource = subsource;
	}

	public void setDataSubSources(List<ReportDataSubSource> subsource) {
		this.subsources = subsource;
	}

	public void setFieldGroups(List<ReportFieldGroup> fieldGroups) {
		this.fieldGroups = fieldGroups;
	}

	public void setFields(List<ReportField> fields) {
		this.fields = fields;
	}

	public void setReportDataSource(ReportDataSource src) {
		this.src = src;
	}

	public void setReportName(String name) {
		reportName = name;
	}

	public void setReportType(String type) {
		logger.info("**** setReportType");
		reportType = type;
	}

	public void setRowCount(Integer rowCount) {
		this.rowCount = rowCount;
	}

	public void setSrcId(long srcId) {
		this.srcId = srcId;
	}

	public void setSubSourceId(long srcId) {
		this.subSourceId = srcId;
	}
}