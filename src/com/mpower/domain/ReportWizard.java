package com.mpower.domain;

import java.util.SortedSet;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ReportWizard {

	protected final Log logger = LogFactory.getLog(getClass());
	private String reportName;
	private final Integer rowCount;
	private long srcId;
	private long subSourceId;
	private ReportDataSource src;
	private ReportDataSubSource subsource;
	private SortedSet<ReportDataSource> sources;
	private SortedSet<ReportDataSubSource> subsources;
	private String reportType;

	public ReportWizard() {
		reportType = "tabular";
		srcId = 0;
		subSourceId = 0;
		rowCount = -1;
	}

	public String getReportType() {
		logger.info("**** getReportType");
		return reportType;
	}

	public void setReportType(String type) {
		logger.info("**** setReportType");
		reportType = type;
	}

	public long getSrcId() {
		return srcId;
	}

	public void setSrcId(long srcId) {
		this.srcId = srcId;
	}

	public long getSubSourceId() {
		return subSourceId;
	}

	public void setSubSourceId(long srcId) {
		this.subSourceId = srcId;
	}

	public ReportDataSource getDataSource() {
		logger.info("**** in getSrc()");
		return src;
	}

	public void setDataSource(ReportDataSource src) {
		logger.info("**** in setSrc()");
		this.src = src;
	}

	public ReportDataSubSource getDataSubSource() {
		logger.info("**** in getDatasubSource");
		return subsource;
	}

	public void setDataSubSource(ReportDataSubSource subsource) {
		logger.info("**** in setDatasubSource");
		this.subsource = subsource;
	}

	public SortedSet<ReportDataSubSource> getDataSubSources() {
		return subsources;
	}

	public void setDataSubSources(SortedSet<ReportDataSubSource> subsource) {
		this.subsources = subsource;
	}

	public SortedSet<ReportDataSource> getDataSources() {
		return sources;
	}

	public void setDataSources(SortedSet<ReportDataSource> sources) {
		this.sources = sources;
	}

	public ReportDataSource getReportDataSource() {
		return src;
	}

	public void setReportDataSource(ReportDataSource src) {
		this.src = src;
	}

	public String getReportName() {
		return reportName;
	}

	public void setReportName(String name) {
		reportName = name;
	}
}