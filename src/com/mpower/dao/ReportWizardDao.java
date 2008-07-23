package com.mpower.dao;

import java.util.List;

import com.mpower.domain.ReportWizard;

public interface ReportWizardDao {
    public ReportWizard findById(long Id);
    
    public List<ReportWizard> getAll();

    public void Save(ReportWizard wizard);

    public ReportWizard update(ReportWizard wizard);

    public void delete(ReportWizard wizard);
}