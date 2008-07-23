package com.mpower.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

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
