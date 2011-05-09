package com.mpower.view;

import java.io.File;
import java.sql.Connection;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import net.sf.jasperreports.engine.fill.JRFileVirtualizer;

import org.springframework.web.servlet.view.AbstractView;

import ar.com.fdvs.dj.core.DynamicJasperHelper;
import ar.com.fdvs.dj.core.layout.ClassicLayoutManager;
import ar.com.fdvs.dj.domain.DynamicReport;

import com.jaspersoft.jasperserver.api.metadata.xml.domain.impl.ResourceDescriptor;
import com.mpower.controller.TempFileUtil;
import com.mpower.domain.ReportWizard;
import com.mpower.service.ReportCustomFilterDefinitionService;
import com.mpower.service.ReportFieldService;
import com.mpower.service.TheGuruViewJoinService;
import com.mpower.service.TheGuruViewService;
import com.mpower.util.ReportGenerator;



//import com.mpower.service.ReportWizardService;

public class DynamicReportView extends AbstractView {
	private DataSource jdbcDataSource;
	private static final int OUTPUT_BYTE_ARRAY_INITIAL_SIZE = 4096;
	private ReportWizard wiz;
	ReportGenerator reportGenerator;
	
	private JRFileVirtualizer virtualizer;

	private ReportFieldService reportFieldService;
	private ReportCustomFilterDefinitionService reportCustomFilterDefinitionService;
	private TheGuruViewService theGuruViewService;
	private TheGuruViewJoinService theGuruViewJoinService;
	
	public DynamicReportView() {
		// TODO Auto-generated constructor stub
	}

	private JRExporter createExporter(HttpServletRequest request) {
		JRHtmlExporter exporter = new JRHtmlExporter();

		exporter.setParameter(JRHtmlExporterParameter.IS_OUTPUT_IMAGES_TO_DIR,
				Boolean.TRUE);
		String realPath = request.getRealPath("images/report/");
		exporter
				.setParameter(JRHtmlExporterParameter.IMAGES_DIR_NAME, realPath);
		exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI,
				"/clementine/images/report/");
		return exporter;
	}

	public DataSource getJdbcDataSource() {
		return jdbcDataSource;
	}

	public ReportFieldService getReportFieldService() {
		return reportFieldService;
	}

	public ReportWizard getReportWizard() {
		return wiz;
	}

	@SuppressWarnings( { "deprecation", "unchecked" })
	@Override
	protected void renderMergedOutputModel(Map model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		//
		// Render the jasper report
		//
		@SuppressWarnings("unused")
		Map params = new HashMap();
		



		DynamicReport dr = reportGenerator.Generate(wiz, reportFieldService, reportCustomFilterDefinitionService, false, null, theGuruViewService, theGuruViewJoinService);
		String query = dr.getQuery().getText();
		
		//
		// execute the query and pass it to generateJasperPrint
		Connection connection = jdbcDataSource.getConnection();
		Statement statement = connection.createStatement();
		
		File tempFile = TempFileUtil.createTempFile("wiz", ".jrxml");
		params.put(JRParameter.REPORT_VIRTUALIZER, virtualizer);
		DynamicJasperHelper.generateJRXML(dr,new ClassicLayoutManager(), params, null, tempFile.getPath());

		//
		// save the report to the server
		reportGenerator.put(ResourceDescriptor.TYPE_REPORTUNIT, tempFile.getName(), tempFile.getName(), tempFile.getName(), "/Reports/Clementine/Temp", tempFile,reportGenerator.getParams(), "");

		//
		// redirect the user to the report on the jasper server
		
//		JasperPrint jp = reportGenerator.runReport("/Reports/Clementine/Temp/" + tempFile.getName(), new HashMap());
//		JasperPrint jp = DynamicJasperHelper.generateJasperPrint(dr,
//new ClassicLayoutManager(),  resultset);
		tempFile.delete();
		
//		JRExporter exporter = createExporter(request);

		// Apply the content type as specified - we don't need an encoding here.
//		response.setContentType(getContentType());

		// Render report into local OutputStream.
		// IE workaround: write into byte array first.
//		ByteArrayOutputStream baos = new ByteArrayOutputStream(
//				OUTPUT_BYTE_ARRAY_INITIAL_SIZE);
//		JasperReportsUtils.render(exporter, jp, baos);

		// Write content length (determined via byte array).
//		response.setContentLength(baos.size());

		// Flush byte array to servlet output stream.
//		ServletOutputStream out = response.getOutputStream();
//		baos.writeTo(out);
//		out.flush();

	}
	
	private void initStyles() {

	}

	public void setJdbcDataSource(DataSource jdbcDataSource) {
		this.jdbcDataSource = jdbcDataSource;
	}

	public void setReportFieldService(ReportFieldService reportFieldService) {
		this.reportFieldService = reportFieldService;
	}

	public void setReportCustomFilterDefinitionService(
			ReportCustomFilterDefinitionService reportCustomFilterDefinitionService) {
		this.reportCustomFilterDefinitionService = reportCustomFilterDefinitionService;
	}
	
	public void setReportWizard(ReportWizard wiz) {
		this.wiz = wiz;
	}

	public ReportGenerator getReportGenerator() {
		return reportGenerator;
	}

	public void setReportGenerator(ReportGenerator reportGenerator) {
		this.reportGenerator = reportGenerator;
	}

	public JRFileVirtualizer getVirtualizer() {
		return virtualizer;
	}

	public void setVirtualizer(JRFileVirtualizer virtualizer) {
		this.virtualizer = virtualizer;
	}

	public void setTheGuruViewService(TheGuruViewService theGuruViewService) {
		this.theGuruViewService = theGuruViewService;
	}

	public TheGuruViewService getTheGuruViewService() {
		return theGuruViewService;
	}

	public void setTheGuruViewJoinService(TheGuruViewJoinService theGuruViewJoinService) {
		this.theGuruViewJoinService = theGuruViewJoinService;
	}

	public TheGuruViewJoinService getTheGuruViewJoinService() {
		return theGuruViewJoinService;
	}


}
