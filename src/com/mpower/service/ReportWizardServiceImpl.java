package com.mpower.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mpower.dao.ReportFieldGroupDao;
import com.mpower.dao.ReportWizardDao;
import com.mpower.domain.ReportWizard;

@Service("reportWizardService")
public class ReportWizardServiceImpl implements ReportWizardService {
	@Resource(name = "reportWizardDao")
	private ReportWizardDao reportWizardDAO;

	@Override
	public ReportWizard Find(Long id) {
		return reportWizardDAO.find(id);
	}

	@Override
	public List<ReportWizard> getAll() {

		return reportWizardDAO.getAll();
	}

	@Override
    @Transactional(propagation = Propagation.SUPPORTS)
	public void save(ReportWizard wiz) {
		reportWizardDAO.save(wiz);
	}

}
