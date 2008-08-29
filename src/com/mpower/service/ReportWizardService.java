package com.mpower.service;

import java.util.List;

import com.mpower.domain.ReportWizard;

public interface ReportWizardService {
	ReportWizard Find(Long id);
	List<ReportWizard> getAll();
	void save(ReportWizard wiz);
}
