package com.mpower.dao;

import java.util.Date;
import java.util.List;

import com.mpower.domain.ReportWizard;

public interface ReportWizardDao {
	void                save(ReportWizard wiz);
	ReportWizard        find(Long id);
	ReportWizard		findByUri(String reportPath, String reportName);
	List<ReportWizard>  getAll();
	List<ReportWizard>  findSegmentationsByReportDataSourceId(Long reportDataSourceId);
	void updateSegmentationExecutionInformation(Long reportId, String lastRunByUserName, Date lastRunDate, int resultCount, long executionTime);
}
