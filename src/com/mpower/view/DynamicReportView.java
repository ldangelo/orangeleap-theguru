package com.mpower.view;

import java.io.ByteArrayOutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;

import org.springframework.ui.jasperreports.JasperReportsUtils;
import org.springframework.web.servlet.view.AbstractView;

import ar.com.fdvs.dj.core.DynamicJasperHelper;
import ar.com.fdvs.dj.core.layout.ClassicLayoutManager;
import ar.com.fdvs.dj.domain.DynamicReport;
import ar.com.fdvs.dj.domain.builders.FastReportBuilder;


//import com.mpower.service.ReportWizardService;

public class DynamicReportView extends AbstractView {
	private DataSource jdbcDataSource;
	private static final int OUTPUT_BYTE_ARRAY_INITIAL_SIZE = 4096;
//	private ReportWizardService reportWizard;

	public DataSource getJdbcDataSource() {
		return jdbcDataSource;
	}

	public void setJdbcDataSource(DataSource jdbcDataSource) {
		this.jdbcDataSource = jdbcDataSource;
	}

	public DynamicReportView() {
		// TODO Auto-generated constructor stub
	}

	@SuppressWarnings( { "deprecation", "unchecked" })
	@Override
	protected void renderMergedOutputModel(Map model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		//
		// Render the jasper report
		FastReportBuilder drb = new FastReportBuilder();
		DynamicReport dr = drb.addColumn("First Name", "FIRST_NAME",
				String.class.getName(), 20).addColumn("Last Name", "LAST_NAME",
				String.class.getName(), 20).addTitle("Dynamic Report")
				.addSubtitle("Testing dynamic report creation")
				.addUseFullPageWidth(true).build();

		@SuppressWarnings("unused")
		Map params = new HashMap();
		Connection connection = jdbcDataSource.getConnection();
		Statement statement = connection.createStatement();
		ResultSet resultset = null;

		String query = "SELECT *,FIRST_NAME,LAST_NAME FROM PERSON";
		resultset = statement.executeQuery(query);

		JasperPrint jp = DynamicJasperHelper.generateJasperPrint(dr,
				new ClassicLayoutManager(), resultset);

		JRExporter exporter = createExporter(request);

		// Apply the content type as specified - we don't need an encoding here.
		response.setContentType(getContentType());

		// Render report into local OutputStream.
		// IE workaround: write into byte array first.
		ByteArrayOutputStream baos = new ByteArrayOutputStream(
				OUTPUT_BYTE_ARRAY_INITIAL_SIZE);
		JasperReportsUtils.render(exporter, jp, baos);

		// Write content length (determined via byte array).
		response.setContentLength(baos.size());

		// Flush byte array to servlet output stream.
		ServletOutputStream out = response.getOutputStream();
		baos.writeTo(out);
		out.flush();

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


}
