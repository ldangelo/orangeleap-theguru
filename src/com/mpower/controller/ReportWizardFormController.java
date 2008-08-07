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
import com.mpower.service.ReportSourceService;
//import com.mpower.service.ReportWizardService;
import com.mpower.service.SessionService;
import com.mpower.view.DynamicReportView;

public class ReportWizardFormController extends AbstractWizardFormController {
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	private DynamicReportView dynamicView;
	private ReportSourceService reportSourceService;
//	private ReportWizardService reportWizardService;
	private SessionService      sessionService;
	
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

	@Override
	protected Map referenceData(HttpServletRequest request, Object command,
			Errors errors, int page) throws Exception {
		//ReportWizard wiz = (ReportWizard) command;
		Map refData = new HashMap();

/*		//
		// Report Source
		if (page == 0) {
			wiz.setDataSource(reportSourceService.find(wiz.getSrcId()));
		}
		//
		// SubSources
		if (page == 1 && request.getParameter("_target1") != null) {
			ReportDataSource rds = reportSourceService.find(wiz.getSrcId());
			wiz.setDataSource(rds);
			wiz.setDataSubSources(rds.getSubSources());
			refData.put("reportDataSubSources", rds.getSubSources());
		}

		//
		// Report Format
		if (page == 2 && request.getParameter("_target2") != null) {
			ReportDataSource rds = wiz.getReportDataSource();
			List<ReportDataSubSource> rdss = rds.getSubSources();
			wiz.setDataSubSources(rdss);
			wiz.setDataSubSource(rdss.get((int) wiz.getSubSourceId()));

		}

		//
		// Report Columns
		if (page == 3 && request.getParameter("_target3") != null) {
			ReportDataSubSource rdss = wiz.getDataSubSource();

			refData.put("fieldGroups", rdss.getFieldGroups());

			List<ReportField> fields = new LinkedList<ReportField>();

			List<ReportFieldGroup> group = rdss.getFieldGroups();
			// Iterate across the field groups in the

			Iterator itGroup = group.iterator();
			while (itGroup.hasNext()) {
				ReportFieldGroup rfg = (ReportFieldGroup) itGroup.next();
				fields.addAll(rfg.getFields());

			}
			wiz.setFields(fields);
			refData.put("fields", fields);

		}

		return refData;
*/ return null;	}

	@Override
	protected Object formBackingObject(HttpServletRequest request)
			throws ServletException {
		logger.info("**** in formBackingObject");

/*		wiz.setDataSources(reportSourceService.readSources());

		logger.info("Count " + wiz.getDataSources().size());
		return wiz;*/
		return null;
	}

	@Override
	protected void postProcessPage(HttpServletRequest request, Object command,
			Errors errors, int page) throws Exception {
		logger.info("**** in onSubmit()");
		Map<String, Object> params = new HashMap<String, Object>();
/*		ReportWizard wiz = (ReportWizard) command;

		params.put("ReportDataSourceId", wiz.getSrcId());
		ReportDataSource rds = reportSourceService.find(wiz.getSrcId());

		switch (page) {
		case 0:
			List<ReportDataSubSource> subsources = rds.getSubSources();
			break;
		}
*/
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

//		dynamicView.setReportWizard(wiz);
		return new ModelAndView(dynamicView, map);
	}

	// returns the last page as the success view
	private String getSuccessView() {
		return getPages()[getPages().length - 1];
	}
}
