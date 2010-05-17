/**
 * 
 */
package com.mpower.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

import com.mpower.view.DynamicReportView;

/**
 * @author ldangelo
 * 
 */
public class DynamicReportController extends SimpleFormController {

	/**
	 * 
	 */
	public DynamicReportController() {
		// TODO Auto-generated constructor stub
	}

	private DynamicReportView dynamicView;

	public DynamicReportView getDynamicView() {
		return dynamicView;
	}

	public void setDynamicView(DynamicReportView dynamicView) {
		this.dynamicView = dynamicView;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		JRHtmlExporter exporter = new JRHtmlExporter();

		//map.put(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,Boolean.FALSE
		// );
		exporter.setParameter(JRHtmlExporterParameter.IS_OUTPUT_IMAGES_TO_DIR,
				Boolean.TRUE);
		String realPath = request.getRealPath("images/report/");
		exporter
				.setParameter(JRHtmlExporterParameter.IMAGES_DIR_NAME, realPath);
		exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI,
				"/clementine/images/report/");

		return new ModelAndView(dynamicView, exporter.getParameters());
	}
}
