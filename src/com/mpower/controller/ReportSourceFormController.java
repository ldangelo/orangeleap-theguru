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
import org.springframework.web.servlet.mvc.AbstractWizardFormController;
import javax.servlet.http.HttpServletResponse;
import org.springframework.validation.BindException;
import com.mpower.service.*;
import com.mpower.domain.ReportWizard;

public class ReportSourceFormController extends AbstractWizardFormController {
	   /** Logger for this class and subclasses */
    protected final Log logger = LogFactory.getLog(getClass());

    private ReportSourceService reportSourceService;
    
    public void setReportSourceService(ReportSourceService reportSourceService) {
        this.reportSourceService = reportSourceService;
    }
    
    @Override
    protected Object formBackingObject(HttpServletRequest request) throws ServletException {
        logger.info("**** in formBackingObject");
        ReportWizard wiz = new ReportWizard();
        

        
        wiz.setDataSources(reportSourceService.readSources());

        logger.info("Count " + wiz.getDataSources().size());
        return wiz;
    }


    protected void postProcessPage(HttpServletRequest request, Object command, Errors errors, int page) throws Exception {
    	ReportWizard wiz = (ReportWizard) command;
    	logger.info("**** in postProcessPage");

    	if (wiz == null) logger.info("**** null wizard ****");
    	else {
    		if (wiz.getSrcId() != 0) {
    			wiz.setDataSource(reportSourceService.find(wiz.getSrcId()));
    		}

        if (wiz.getSubSourceId() != 0) {
          logger.info("*** getSubSourceId() != 0");

          ReportDataSource rds = wiz.getDataSource();
          List<ReportDataSubSource> lrdss = rds.getSubSources();

          wiz.setDataSubSource(lrdss.get((int) wiz.getSubSourceId()-1));
        }
    	}
    }

    @Override
    public ModelAndView processFinish(HttpServletRequest request,HttpServletResponse response, Object command,BindException errors) throws Exception
    {
    
        Map<String, String> params = new HashMap<String, String>();
        ReportWizard     wiz = (ReportWizard) command;

		logger.info("**** in processFinish");
		
		ModelAndView mav = new ModelAndView(getSuccessView(), "reportsource", wiz);
        return mav;
    }
    
    private String getSuccessView() {
    	logger.info("**** in getSuccessView");
    	
    	return getPages()[getPages().length-1];
    }
}
