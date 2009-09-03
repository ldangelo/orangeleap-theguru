package com.mpower.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mpower.dao.ReportWizardDao;
import com.mpower.domain.ReportWizard;

@Service("reportWizardService")
public class ReportWizardServiceImpl implements ReportWizardService {
	@Resource(name = "reportWizardDao")
	private ReportWizardDao reportWizardDAO;

	public ReportWizard Find(Long id) {
		return reportWizardDAO.find(id);
	}

	public ReportWizard FindByUri(String reportPath, String reportName) {
		return reportWizardDAO.findByUri(reportPath, reportName);
	}

	public List<ReportWizard> getAll() {

		return reportWizardDAO.getAll();
	}


    @Transactional(propagation = Propagation.SUPPORTS)
	public void save(ReportWizard wiz) {
		reportWizardDAO.save(wiz);
	}

	@Override
	public List<ReportWizard> findSegmentationsByReportDataSourceId(
			Long reportDataSourceId) {
		return reportWizardDAO.findSegmentationsByReportDataSourceId(reportDataSourceId);
	}

	@Override
	public void updateSegmentationExecutionInformation(Long reportId, String lastRunByUserName,
			Date lastRunDate, int resultCount, long executionTime) {
		reportWizardDAO.updateSegmentationExecutionInformation(reportId, lastRunByUserName, lastRunDate, resultCount, executionTime);
	}
}
