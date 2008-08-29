package com.mpower.dao;

import java.util.List;

import com.mpower.domain.ReportWizard;

public interface ReportWizardDao {
	void                save(ReportWizard wiz);
	ReportWizard        find(Long id);
	List<ReportWizard>  getAll();
}
