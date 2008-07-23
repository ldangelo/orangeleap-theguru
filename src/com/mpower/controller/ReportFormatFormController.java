package com.mpower.controller;


import com.mpower.domain.ReportDataSource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import com.mpower.service.*;

public class ReportFormatFormController extends SimpleFormController {
	   /** Logger for this class and subclasses */
    protected final Log logger = LogFactory.getLog(getClass());

    private ReportSourceService reportSourceService;
    
    public void setReportSourceService(ReportSourceService reportSourceService) {
        this.reportSourceService = reportSourceService;
    }
    
    @Override
    protected Object formBackingObject(HttpServletRequest request) throws ServletException {
        logger.info("**** in formBackingObject");

        ReportDataSource rs = new ReportDataSource();

        return rs;
    }

    @Override
    public ModelAndView onSubmit(Object command, BindException errors) throws ServletException {
        logger.info("**** in onSubmit()");
        Map<String, String> params = new HashMap<String, String>();
        ReportDataSource rs = (ReportDataSource) command;
        

		List<ReportDataSource> reportSourceList = reportSourceService.readSources();
        
        // TODO: Adding errors.getModel() to our ModelAndView is a "hack" to allow our
        // form to post results back to the same page. We need to get the
        // command from errors and then add our search results to the model.
        ModelAndView mav = new ModelAndView(getSuccessView(), errors.getModel());
        mav.addObject("reportSource", reportSourceList);
        mav.addObject("reportSourceListSize", reportSourceList.size());
        return mav;
    }
}
