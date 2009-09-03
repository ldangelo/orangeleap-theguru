package com.mpower.service;

import java.util.Date;
import java.util.List;

import com.mpower.domain.ReportWizard;

public interface ReportWizardService {
	ReportWizard Find(Long id);
	ReportWizard FindByUri(String reportPath, String reportName);
	List<ReportWizard> findSegmentationsByReportDataSourceId(Long reportDataSourceId);
	List<ReportWizard> getAll();
	void save(ReportWizard wiz);
	void updateSegmentationExecutionInformation(Long reportId, String lastRunByUserName, Date lastRunDate, int resultCount, long executionTime);
}
