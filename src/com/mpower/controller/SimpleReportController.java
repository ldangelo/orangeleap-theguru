package com.mpower.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.servlet.view.jasperreports.JasperReportsHtmlView;

public class SimpleReportController extends SimpleFormController {
	private JasperReportsHtmlView htmlView;

	public void setHtmlView(final JasperReportsHtmlView htmlView) {
		this.htmlView = htmlView;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map map = new HashMap();

		//map.put(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,Boolean.FALSE
		// );
		map.put(JRHtmlExporterParameter.IS_OUTPUT_IMAGES_TO_DIR, Boolean.TRUE);
		String realPath = request.getRealPath("images/report/");
		map.put(JRHtmlExporterParameter.IMAGES_DIR_NAME, realPath);
		map.put(JRHtmlExporterParameter.IMAGES_URI,
				"/clementine/images/report/");

		return new ModelAndView(htmlView, map);
	}
}
