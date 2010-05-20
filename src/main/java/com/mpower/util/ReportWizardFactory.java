package com.mpower.util;

import com.mpower.domain.ReportWizard;

public class ReportWizardFactory {

	private ReportGeneratorFactory reportGeneratorFactory;
	private String reportType;
	private long srcId;
	private long dataSubSourceGroupId;
	private long subSourceId;
	private Integer rowCount;
	private Boolean uniqueRecords;
	
	public ReportWizard getReportWizard() {
		ReportWizard reportWizard = new ReportWizard();
		reportWizard.setReportType(reportType);
		reportWizard.setSrcId(srcId);
		reportWizard.setDataSubSourceGroupId(dataSubSourceGroupId);
		reportWizard.setSubSourceId(subSourceId);
		reportWizard.setRowCount(rowCount);
		reportWizard.setUniqueRecords(uniqueRecords);
		reportWizard.setReportGenerator(reportGeneratorFactory.getReportGenerator());
		return reportWizard;
	}

	public void setReportGeneratorFactory(ReportGeneratorFactory reportGeneratorFactory) {
		this.reportGeneratorFactory = reportGeneratorFactory;
	}

	public ReportGeneratorFactory getReportGeneratorFactory() {
		return reportGeneratorFactory;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	public String getReportType() {
		return reportType;
	}

	public void setSrcId(long srcId) {
		this.srcId = srcId;
	}

	public long getSrcId() {
		return srcId;
	}

	public void setDataSubSourceGroupId(long dataSubSourceGroupId) {
		this.dataSubSourceGroupId = dataSubSourceGroupId;
	}

	public long getDataSubSourceGroupId() {
		return dataSubSourceGroupId;
	}

	public void setSubSourceId(long subSourceId) {
		this.subSourceId = subSourceId;
	}

	public long getSubSourceId() {
		return subSourceId;
	}

	public void setRowCount(Integer rowCount) {
		this.rowCount = rowCount;
	}

	public Integer getRowCount() {
		return rowCount;
	}

	public void setUniqueRecords(Boolean uniqueRecords) {
		this.uniqueRecords = uniqueRecords;
	}

	public Boolean getUniqueRecords() {
		return uniqueRecords;
	}

}
