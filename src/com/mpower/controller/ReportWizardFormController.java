package com.mpower.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.validation.BindException;
import org.springframework.validation.Errors;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractWizardFormController;

import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportDataSubSource;
import com.mpower.domain.ReportField;
import com.mpower.domain.ReportFieldGroup;
import com.mpower.domain.ReportWizard;
import com.mpower.service.ReportFieldGroupService;
import com.mpower.service.ReportFieldService;
import com.mpower.service.ReportSourceService;
import com.mpower.service.ReportSubSourceService;
//import com.mpower.service.ReportWizardService;
import com.mpower.service.SessionService;
import com.mpower.view.DynamicReportView;

public class ReportWizardFormController extends AbstractWizardFormController {
	private ReportSubSourceService  reportSubSourceService;

	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	private DynamicReportView       dynamicView;
	private ReportSourceService     reportSourceService;
	private ReportWizard            wiz;
	
	public ReportSubSourceService getReportSubSourceService() {
		return reportSubSourceService;
	}

	public void setReportSubSourceService(
			ReportSubSourceService reportSubSourceService) {
		this.reportSubSourceService = reportSubSourceService;
	}

	public ReportFieldGroupService getReportFieldGroupService() {
		return reportFieldGroupService;
	}

	public void setReportFieldGroupService(
			ReportFieldGroupService reportFieldGroupService) {
		this.reportFieldGroupService = reportFieldGroupService;
	}

	public ReportFieldService getReportFieldService() {
		return reportFieldService;
	}

	public void setReportFieldService(ReportFieldService reportFieldService) {
		this.reportFieldService = reportFieldService;
	}

	public SessionService getSessionService() {
		return sessionService;
	}

	public void setSessionService(SessionService sessionService) {
		this.sessionService = sessionService;
	}

	public ReportSourceService getReportSourceService() {
		return reportSourceService;
	}

	private ReportFieldGroupService reportFieldGroupService;
	private ReportFieldService      reportFieldService;
	private SessionService          sessionService;
	
	public ReportWizardFormController() {
		
	}

	public DynamicReportView getDynamicView() {
		return dynamicView;
	}

	public void setDynamicView(DynamicReportView dynamicView) {
		this.dynamicView = dynamicView;
	}

	public void setReportSourceService(ReportSourceService reportSourceService) {
		this.reportSourceService = reportSourceService;
	}

	@Override
	protected ModelAndView showForm(HttpServletRequest request,
			HttpServletResponse response, BindException errors)
			throws Exception {

		return showPage(request, errors, getInitialPage(request, errors
				.getTarget()));
	}

	@SuppressWarnings("unchecked")
	@Override
	protected Map referenceData(HttpServletRequest request, Object command,
			Errors errors, int page) throws Exception {
		ReportWizard wiz = (ReportWizard) command;
		Map refData = new HashMap();

    refData.put("page",page);
    refData.put("maxpages", getPages().length-1);
		//
		// Report Source
		if (page == 0) {
			wiz.setDataSource(reportSourceService.find(wiz.getSrcId()));
		}
		//
		// SubSources
		if (page == 1 && request.getParameter("_target1") != null) {
			ReportDataSource rds = reportSourceService.find(wiz.getSrcId());
			List<ReportDataSubSource> rdss = reportSubSourceService.readSubSourcesByReportSourceId(rds.getId());
			wiz.setDataSource(rds);
			wiz.setDataSubSources(rdss);
			refData.put("reportDataSubSources", rdss);
		}

		//
		// Report Format
		if (page == 2 && request.getParameter("_target2") != null) {
			ReportDataSource rds = wiz.getReportDataSource();
			List<ReportDataSubSource> rdss = reportSubSourceService.readSubSourcesByReportSourceId(rds.getId());
			wiz.setDataSubSources(rdss);
			wiz.setDataSubSource(reportSubSourceService.find( wiz.getSubSourceId()));
		}

		//
		// Report Columns
		if (page == 3 && request.getParameter("_target3") != null) {
			ReportDataSubSource rdss = reportSubSourceService.find(wiz.getSubSourceId());
			List<ReportFieldGroup>    lrfg = reportFieldGroupService.readFieldGroupBySubSourceId(rdss.getId());
			
			wiz.setFieldGroups(lrfg);
			refData.put("fieldGroups", lrfg);

			List<ReportField> fields = new LinkedList<ReportField>();

			
			// Iterate across the field groups in the

			Iterator itGroup = lrfg.iterator();
			while (itGroup.hasNext()) {
				ReportFieldGroup rfg = (ReportFieldGroup) itGroup.next();
				fields.addAll(reportFieldService.readFieldByGroupId(rfg.getId()));
			}
			wiz.setFields(fields);
			refData.put("fields", fields);

		}
		
		if(page==4) {
		
			refData.put("fieldGroups", wiz.getFieldGroups());
		}
		
		if(page==5) {
			refData.put("fieldGroups", wiz.getFieldGroups());
			
		}
		
		if(page==6) {
			refData.put("fieldGroups", wiz.getFieldGroups());
			
		}

		return refData;
	}

	@Override
	protected Object formBackingObject(HttpServletRequest request)
			throws ServletException {
		logger.info("**** in formBackingObject");
		wiz = new ReportWizard();
		wiz.setDataSources(reportSourceService.readSources());

		logger.info("Count " + wiz.getDataSources().size());
		return wiz;
		}

	@Override
	protected void postProcessPage(HttpServletRequest request, Object command,
			Errors errors, int page) throws Exception {
		logger.info("**** in onSubmit()");
		Map<String, Object> params = new HashMap<String, Object>();
		ReportWizard wiz = (ReportWizard) command;

		params.put("ReportDataSourceId", wiz.getSrcId());
		ReportDataSource rds = reportSourceService.find(wiz.getSrcId());

		switch (page) {
		case 0:
			List<ReportDataSubSource> subsources = reportSubSourceService.readSubSourcesByReportSourceId(rds.getId());
			break;
		}

	}

	@Override
	protected ModelAndView processFinish(HttpServletRequest request,
			HttpServletResponse arg1, Object arg2, BindException arg3)
			throws Exception {

		Map map = new HashMap();

		// map.put(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,Boolean.
		// FALSE
		// );
		map.put(JRHtmlExporterParameter.IS_OUTPUT_IMAGES_TO_DIR, Boolean.TRUE);
		String realPath = request.getRealPath("images/report/");
		map.put(JRHtmlExporterParameter.IMAGES_DIR_NAME, realPath);
		map.put(JRHtmlExporterParameter.IMAGES_URI,"/clementine/images/report/");

		dynamicView.setReportWizard(wiz);
		
		return new ModelAndView(dynamicView, map);
	}

	// returns the last page as the success view
	private String getSuccessView() {
		return getPages()[getPages().length - 1];
	}
}
