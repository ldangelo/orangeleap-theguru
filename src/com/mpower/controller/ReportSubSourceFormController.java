package com.mpower.controller;


import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportDataSubSource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.validation.BindException;
import org.springframework.validation.Errors;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import javax.servlet.http.HttpServletResponse;
import org.springframework.validation.BindException;
import com.mpower.service.*;
import com.mpower.domain.ReportWizard;

public class ReportSubSourceFormController extends SimpleFormController {
	   /** Logger for this class and subclasses */
    protected final Log logger = LogFactory.getLog(getClass());

    private ReportSourceService reportSourceService;
    
    public void setReportSourceService(ReportSourceService reportSourceService) {
        this.reportSourceService = reportSourceService;
    }
    
    @Override
    protected Object formBackingObject(HttpServletRequest request) throws Exception {
        logger.info("**** in formBackingObject");
        ReportWizard wiz = (ReportWizard) super.formBackingObject(request);
        
        if (wiz == null)
          logger.error("*** null ReportWizard in formBackingObject");

        
        wiz.setDataSources(reportSourceService.readSources());

        logger.info("Count " + wiz.getDataSources().size());
        return wiz;
    }


  @Override
  public ModelAndView onSubmit(Object command, BindException errors) throws ServletException {
    logger.info("**** in onSubmit()");

    ModelAndView mav = new ModelAndView(getSuccessView(), errors.getModel());

    return mav;
  }

}
