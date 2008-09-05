package com.mpower.controller;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractFormController;
import org.springframework.web.servlet.mvc.SimpleFormController;

import com.mpower.domain.ReportManager;
import com.mpower.domain.ReportWizard;
import com.mpower.service.ReportWizardService;

public class ReportManagerFormController extends SimpleFormController {
	ReportWizardService reportWizardService;
	ReportManager       reportManager;
	
	   /** Logger for this class and subclasses */
    protected final Log logger = LogFactory.getLog(getClass());

	public ReportWizardService getReportWizardService() {
		return reportWizardService;
	}

	public void setReportWizardService(ReportWizardService reportWizardService) {
		this.reportWizardService = reportWizardService;
	}

	 @Override
    protected Object formBackingObject(HttpServletRequest request) throws ServletException {
		 reportManager = new ReportManager();
		 
		 //
		 // populate the reportManager
		 List<ReportWizard> reportWizards = reportWizardService.getAll();
		 reportManager.setReportWizards(reportWizards);
		 return reportManager;
	 }
 }
