package com.mpower.util;

import net.sf.jasperreports.engine.JRParameter;

public class ReportGeneratorFactory {

	private String reportBaseURI;
	private String reportServicesPath;
	private JRFileVirtualizerFactory virtualizerFactory;  
	
	public ReportGenerator getReportGenerator() {
		ReportGenerator reportGenerator = new ReportGenerator();
		reportGenerator.setReportBaseURI(reportBaseURI);
		reportGenerator.setReportServicesPath(reportServicesPath);
		reportGenerator.getParams().put(JRParameter.REPORT_VIRTUALIZER, virtualizerFactory.getJRFileVirtualizer());
		return reportGenerator;
	}

	public void setReportBaseURI(String reportBaseURI) {
		this.reportBaseURI = reportBaseURI;
	}

	public String getReportBaseURI() {
		return reportBaseURI;
	}

	public void setReportServicesPath(String reportServicesPath) {
		this.reportServicesPath = reportServicesPath;
	}

	public String getReportServicesPath() {
		return reportServicesPath;
	}

	public void setVirtualizerFactory(JRFileVirtualizerFactory virtualizerFactory) {
		this.virtualizerFactory = virtualizerFactory;
	}

	public JRFileVirtualizerFactory getVirtualizerFactory() {
		return virtualizerFactory;
	}

}
