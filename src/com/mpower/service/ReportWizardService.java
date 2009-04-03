package com.mpower.service;

import java.util.List;

import com.mpower.domain.ReportWizard;

public interface ReportWizardService {
	ReportWizard Find(Long id);
	ReportWizard FindByUri(String reportPath, String reportName);
	List<ReportWizard> getAll();
	void save(ReportWizard wiz);
}
