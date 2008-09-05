package com.mpower.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;


import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.ui.jasperreports.JasperReportsUtils;
import org.springframework.util.Assert;
import org.springframework.validation.BindException;
import org.springframework.validation.Errors;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractWizardFormController;

import ar.com.fdvs.dj.core.DJConstants;
import ar.com.fdvs.dj.core.DynamicJasperHelper;
import ar.com.fdvs.dj.core.layout.ClassicLayoutManager;
import ar.com.fdvs.dj.domain.DynamicReport;
import ar.com.fdvs.dj.domain.builders.ColumnBuilderException;
import ar.com.fdvs.dj.domain.builders.FastReportBuilder;

import com.jaspersoft.jasperserver.api.metadata.xml.domain.impl.ResourceDescriptor;
import com.jaspersoft.jasperserver.irplugin.JServer;
import com.mpower.domain.ReportAdvancedFilter;
import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportDataSubSource;
import com.mpower.domain.ReportField;
import com.mpower.domain.ReportFieldGroup;
import com.mpower.domain.ReportFieldType;
import com.mpower.domain.ReportWizard;
import com.mpower.service.ReportFieldGroupService;
import com.mpower.service.ReportFieldService;
import com.mpower.service.ReportSourceService;
import com.mpower.service.ReportSubSourceService;
import com.mpower.service.ReportWizardService;
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
	private ReportWizardService     reportWizardService;
	
	private ReportFieldGroupService reportFieldGroupService;

	private ReportFieldService      reportFieldService;

	private SessionService          sessionService;

	private String reportServicesURI;
	private String reportUnitDataSourceURI;
	private String reportUserName;
	private String reportPassword;
	
    private JServer server = null;
	public ReportWizardFormController() {
   	}

	private void startServer()
	{
		if (server == null) {
			server = new JServer();
	        server.setUsername(reportUserName);
	        server.setPassword(reportPassword);
	        server.setUrl(reportServicesURI);
		}
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

	public DynamicReportView getDynamicView() {
		return dynamicView;
	}

	public ReportFieldGroupService getReportFieldGroupService() {
		return reportFieldGroupService;
	}

	public ReportFieldService getReportFieldService() {
		return reportFieldService;
	}

	public ReportSourceService getReportSourceService() {
		return reportSourceService;
	}

	public ReportSubSourceService getReportSubSourceService() {
		return reportSubSourceService;
	}

	public ReportWizardService getReportWizardService() {
		return reportWizardService;
	}

	public SessionService getSessionService() {
		return sessionService;
	}
	// returns the last page as the success view
	private String getSuccessView() {
		return getPages()[getPages().length - 1];
	}
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Assert.notNull(request, "Request must not be null");


		return super.handleRequest(request, response);
	}

	protected void saveReport(ReportWizard wiz) throws Exception {
		//
		// First we must generate a jrxml file
		//
		// Render the jasper report
		FastReportBuilder drb = new FastReportBuilder();
		List<ReportField> fields = wiz.getFields();
		Iterator it = fields.iterator();
		
		while(it.hasNext()) {
			ReportField f = (ReportField) it.next();
			
			if (f.getSelected())
				drb.addColumn(f.getDisplayName(),f.getColumnName(),String.class.getName(),20);
		}

		@SuppressWarnings("unused")
		Map params = new HashMap();


		String query = "SELECT * FROM " + wiz.getDataSubSource().getViewName();
		
		if (wiz.getRowCount() != -1)
			query += " LIMIT 0," + wiz.getRowCount().toString(); 

		//
		// Add any 'filters'
		List<ReportAdvancedFilter> filters = wiz.getAdvancedFilters();
		Iterator itFilter = filters.iterator();

		
		Boolean bWhere = false;
		while (itFilter.hasNext()) {
			ReportAdvancedFilter filter = (ReportAdvancedFilter) itFilter.next();
			ReportField rf = reportFieldService.find(filter.getFieldId());

			if (filter.getValue() == "") break; // this is an empty filter
			
			if (!bWhere) {
				bWhere = true;
				query += " WHERE ";
			} else {
				query += " AND ";
			}

			
			query += " " + rf.getColumnName();
			switch (filter.getOperator()) {
			case 1:
				query += " = ";
				break;
			case 2:
				query += " != ";
				break;
			case 3:
				query += " < ";
				break;
			case 4:
				query += " >";
			}
			
			if (rf.getFieldType() == ReportFieldType.STRING || rf.getFieldType() == ReportFieldType.DATE) {
				query += " '" + filter.getValue() + "'";
			} else {
				query += " " + filter.getValue() + " ";
			}
		}


		query += ";";
		

		DynamicReport dr = drb.addTitle("")
		.addSubtitle("")
		.addUseFullPageWidth(true)
		.setQuery(query,DJConstants.QUERY_LANGUAGE_SQL).build();
		
		
		File tempFile = File.createTempFile("wiz", ".jrxml");
		DynamicJasperHelper.generateJRXML(dr,new ClassicLayoutManager(), params, null, tempFile.getPath());

		
		//
		// now we need to save the report to the jasperserver
		ResourceDescriptor rd = new ResourceDescriptor();
		ResourceDescriptor tmpDataSourceDescriptor = new ResourceDescriptor();
		tmpDataSourceDescriptor.setWsType(ResourceDescriptor.TYPE_DATASOURCE);
		tmpDataSourceDescriptor.setReferenceUri(reportUnitDataSourceURI );
		tmpDataSourceDescriptor.setIsReference(true);
		rd.getChildren().add(tmpDataSourceDescriptor);

		ResourceDescriptor jrxmlDescriptor = new ResourceDescriptor();
		jrxmlDescriptor.setWsType(ResourceDescriptor.TYPE_JRXML);
		jrxmlDescriptor.setName(wiz.getReportName());
		jrxmlDescriptor.setLabel(wiz.getReportComment()); 
		jrxmlDescriptor.setDescription(wiz.getReportComment()); 
		jrxmlDescriptor.setIsNew(true);
		jrxmlDescriptor.setHasData(true);
		jrxmlDescriptor.setMainReport(true);
		
		rd.setWsType(ResourceDescriptor.TYPE_REPORTUNIT);
		rd.setParentFolder("/Reports/Clementine");
		rd.setIsNew(true);
		rd.setUriString(rd.getParentFolder() + "/" + wiz.getReportName());
		rd.setName(wiz.getReportName());
		rd.setLabel(wiz.getReportComment()); 
		rd.setDescription(wiz.getReportComment()); 
		rd.getChildren().add(jrxmlDescriptor);
		
		startServer();
		
		server.getWSClient().addOrModifyResource(rd, tempFile);
	}
	
	@Override
	protected void postProcessPage(HttpServletRequest request, Object command,
			Errors errors, int page) throws Exception {
		logger.info("**** in onSubmit()");
		Map<String, Object> params = new HashMap<String, Object>();
		ReportWizard wiz = (ReportWizard) command;


		Assert.notNull(request, "Request must not be null");

		if (request.getParameter("_target10") != null) {
			//
			// We are saving this report to jasperserver
			saveReport(wiz);

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
			List<ReportDataSubSource> lrdss = reportSubSourceService.readSubSourcesByReportSourceId(rds.getId());
			ReportDataSubSource       rdss = reportSubSourceService.find( wiz.getSubSourceId());
			wiz.setDataSubSources(lrdss);
			wiz.setDataSubSource(rdss);
			
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
			refData.put("fields", wiz.getSelectedReportFieldsInOrder());			
		}
		
		if(page==6) {
			refData.put("fieldGroups", wiz.getFieldGroups());
			
		}

		return refData;
	}

	public void setDynamicView(DynamicReportView dynamicView) {
		this.dynamicView = dynamicView;
	}

	public void setReportFieldGroupService(
			ReportFieldGroupService reportFieldGroupService) {
		this.reportFieldGroupService = reportFieldGroupService;
	}

	public void setReportFieldService(ReportFieldService reportFieldService) {
		this.reportFieldService = reportFieldService;
	}

	public void setReportSourceService(ReportSourceService reportSourceService) {
		this.reportSourceService = reportSourceService;
	}

	public void setReportSubSourceService(
			ReportSubSourceService reportSubSourceService) {
		this.reportSubSourceService = reportSubSourceService;
	}

	public void setReportWizardService(ReportWizardService reportWizardService) {
		this.reportWizardService = reportWizardService;
	}

	public void setSessionService(SessionService sessionService) {
		this.sessionService = sessionService;
	}

	@Override
	protected ModelAndView showForm(HttpServletRequest request,
			HttpServletResponse response, BindException errors)
			throws Exception {

		return showPage(request, errors, getInitialPage(request, errors
				.getTarget()));
	}

	public String getReportUnitDataSourceURI() {
		return reportUnitDataSourceURI;
	}

	public void setReportUnitDataSourceURI(String reportUnitDataSourceURI) {
		this.reportUnitDataSourceURI = reportUnitDataSourceURI;
	}

	public String getReportUserName() {
		return reportUserName;
	}

	public void setReportUserName(String reportUserName) {
		this.reportUserName = reportUserName;
	}

	public String getReportPassword() {
		return reportPassword;
	}

	public void setReportPassword(String reportPassword) {
		this.reportPassword = reportPassword;
	}

	public String getReportServicesURI() {
		return reportServicesURI;
	}

	public void setReportServicesURI(String reportServicesURI) {
		this.reportServicesURI = reportServicesURI;
	}
}
