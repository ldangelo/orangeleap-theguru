package com.mpower.service;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.mpower.service.ReportWizardService;
import com.mpower.dao.ReportWizardDao;
import com.mpower.domain.ReportWizard;

@Service("reportWizardService")
public class ReportWizardImpl implements ReportWizardService {
	@Resource(name = "reportWizardDao")
	private ReportWizardDao reportWizardDAO;
	
	@Override
	public List<ReportWizard> getAll()
	{
		return reportWizardDAO.getAll();
	}
	
}
