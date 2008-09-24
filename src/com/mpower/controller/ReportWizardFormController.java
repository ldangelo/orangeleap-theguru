package com.mpower.controller;

import java.io.File;
import java.sql.Connection;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.util.Assert;
import org.springframework.validation.BindException;
import org.springframework.validation.Errors;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractWizardFormController;

import ar.com.fdvs.dj.core.DynamicJasperHelper;
import ar.com.fdvs.dj.core.layout.ClassicLayoutManager;
import ar.com.fdvs.dj.domain.DynamicReport;
import com.jaspersoft.jasperserver.api.metadata.xml.domain.impl.ResourceDescriptor;
import com.mpower.domain.ReportAdvancedFilter;
import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportDataSubSource;
import com.mpower.domain.ReportField;
import com.mpower.domain.ReportFieldGroup;
import com.mpower.domain.ReportGroupByField;
import com.mpower.domain.ReportWizard;
import com.mpower.service.ReportFieldGroupService;
import com.mpower.service.ReportFieldService;
import com.mpower.service.ReportSourceService;
import com.mpower.service.ReportSubSourceService;
import com.mpower.service.ReportWizardService;
//import com.mpower.service.ReportWizardService;
import com.mpower.service.SessionService;
import com.mpower.util.ReportGenerator;
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
	private DataSource jdbcDataSource;
	private String reportUnitDataSourceURI;
	private ReportGenerator	reportGenerator;
	
	public ReportWizardFormController() {
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

	public DataSource getJdbcDataSource() {
		return jdbcDataSource;
	}

	public ReportFieldGroupService getReportFieldGroupService() {
		return reportFieldGroupService;
	}

	public ReportFieldService getReportFieldService() {
		return reportFieldService;
	}

	public ReportGenerator getReportGenerator() {
		return reportGenerator;
	}

	public ReportSourceService getReportSourceService() {
		return reportSourceService;
	}

	public ReportSubSourceService getReportSubSourceService() {
		return reportSubSourceService;
	}
	public String getReportUnitDataSourceURI() {
		return reportUnitDataSourceURI;
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

	@Override
	protected void postProcessPage(HttpServletRequest request, Object command,
			Errors errors, int page) throws Exception {
		logger.info("**** in onSubmit()");
		Map<String, Object> params = new HashMap<String, Object>();
		ReportWizard wiz = (ReportWizard) command;

		Assert.notNull(request, "Request must not be null");

		if (request.getParameter("_target12") != null) {
			//
			// We are saving this report to jasperserver
			saveReport(wiz);

		}

	}

	@Override
	protected int getTargetPage(HttpServletRequest request,
            Object command,
            Errors errors,
            int currentPage) {
		ReportWizard reportWizard = (ReportWizard)command;
		int targetPage = super.getTargetPage(request, command, errors, currentPage);
		if (targetPage == 3 && reportWizard.getReportType().compareTo("summary") != 0) {
			if (currentPage == 4)
				targetPage = 2;
			else
				targetPage = 4;
		}
		if (targetPage == 8 && reportWizard.getReportType().compareTo("summary") != 0) {
			if (currentPage == 7)
				targetPage = 9;
			else
				targetPage = 7;			
		}		
		return targetPage;			
	}
	
	@Override
	protected ModelAndView processFinish(HttpServletRequest request,
			HttpServletResponse arg1, Object arg2, BindException arg3)
			throws Exception {

		
		return new ModelAndView(getSuccessView(),"reportsouce",wiz);
	
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
			reportGenerator.resetInputControls();
			wiz.setDataSource(reportSourceService.find(wiz.getSrcId()));
		}
		//
		// SubSources
		if (page == 1) {
			ReportDataSource rds = reportSourceService.find(wiz.getSrcId());
			List<ReportDataSubSource> rdss = reportSubSourceService.readSubSourcesByReportSourceId(rds.getId());
			wiz.setDataSource(rds);
			wiz.setDataSubSources(rdss);
			refData.put("reportDataSubSources", rdss);
		}

		//
		// Report Format
		if (page == 2) {
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
		// Report Group By Fields
		if (page == 3) {
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
		
		//
		// Report Columns
		if (page == 4) {
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
		
		if(page==5) {
		
			refData.put("fieldGroups", wiz.getFieldGroups());
		}
		
		if(page==6) {
			refData.put("fieldGroups", wiz.getFieldGroups());
			refData.put("fields", wiz.getSelectedReportFieldsInOrder());			
		}
		
		if(page==7) {
			refData.put("fieldGroups", wiz.getFieldGroups());
			
		}

		// chart options
		if(page==8) {
	  		List<ReportGroupByField> groupByFields = wiz.getReportGroupByFields();
	  		Iterator itGroupByFields = groupByFields.iterator();
	  		
	  		//get list of groupby fields in order
	  		List<ReportField> groupByFieldsList = new LinkedList<ReportField>();
	  		while (itGroupByFields.hasNext()){
	  			ReportGroupByField group = (ReportGroupByField) itGroupByFields.next();
				if (group == null) continue;
				ReportField f = reportFieldService.find(group.getFieldId());
				if (f == null || f.getId() == -1) continue;
				groupByFieldsList.add(f);
	  		}
			refData.put("reportGroupByFields", groupByFieldsList);
			
	  		List<ReportField> fields = wiz.getSelectedReportFieldsInOrder();
	  		Iterator itSummarizedByFields = fields.iterator();
	  		
	  		//get list of summarized fields
	  		List<ReportField> summarizedFieldsList = new LinkedList<ReportField>();
	  		while (itSummarizedByFields.hasNext()){
	  			ReportField field = (ReportField) itSummarizedByFields.next();
	  			if (field.getIsSummarized())
	  				summarizedFieldsList.add(field);
	  		}
			refData.put("reportSummarizedByFields", summarizedFieldsList);			
		}
		
		// run a saved report
		if (page==12) { 
			wiz.setReportPath("/Reports/Clementine/" + wiz.getReportName().replace(" ", "_"));
			refData.put("reportPath", wiz.getReportPath());
		}
		
		// running the report
		if (page==13) { 
			@SuppressWarnings("unused")

			



			DynamicReport dr = reportGenerator.Generate(wiz, jdbcDataSource, reportFieldService);
			String query = dr.getQuery().getText();
			
			//
			// execute the query and pass it to generateJasperPrint
			Connection connection = jdbcDataSource.getConnection();
			Statement statement = connection.createStatement();
			
			File tempFile = File.createTempFile("wiz", ".jrxml");
			DynamicJasperHelper.generateJRXML(dr,new ClassicLayoutManager(), reportGenerator.getParams(), null, tempFile.getPath());

			//
			// save the report to the server
			reportGenerator.put(ResourceDescriptor.TYPE_REPORTUNIT, tempFile.getName(), tempFile.getName(), tempFile.getName(), "/Reports/Clementine/Temp", tempFile,reportGenerator.getParams());

			wiz.setReportPath("/Reports/Clementine/Temp/" + tempFile.getName());
			refData.put("reportPath", wiz.getReportPath());

      tempFile.delete();
		}

		return refData;
	}

	protected void saveReport(ReportWizard wiz) throws Exception {

		//
		// First we must generate a jrxml file
		//

		DynamicReport dr = reportGenerator.Generate(wiz, jdbcDataSource, reportFieldService);
		
		File tempFile = File.createTempFile("wiz", ".jrxml");
		DynamicJasperHelper.generateJRXML(dr,new ClassicLayoutManager(), reportGenerator.getParams(), null, tempFile.getPath());

		String reportTitle = wiz.getDataSubSource().getDisplayName() + " Custom Report";
		if (wiz.getReportName() != null && wiz.getReportName().length() > 0)
			reportTitle = wiz.getReportName();

		String reportComment = wiz.getDataSubSource().getDisplayName() + " Custom Report";
		if (wiz.getReportComment() != null && wiz.getReportComment().length() > 0)
			reportComment = wiz.getReportComment();
		
		reportGenerator.put(ResourceDescriptor.TYPE_REPORTUNIT, reportTitle.replace(" ", "_"), reportTitle, reportComment, "/Reports/Clementine",tempFile, reportGenerator.getParams());

		
		//
		// now we need to save the report to the jasperserver
		//		ResourceDescriptor rd = new ResourceDescriptor();
		//		ResourceDescriptor tmpDataSourceDescriptor = new ResourceDescriptor();
		//		tmpDataSourceDescriptor.setWsType(ResourceDescriptor.TYPE_DATASOURCE);
		//		tmpDataSourceDescriptor.setReferenceUri(reportUnitDataSourceURI );
		//		tmpDataSourceDescriptor.setIsReference(true);
		//		rd.getChildren().add(tmpDataSourceDescriptor);

		//		ResourceDescriptor jrxmlDescriptor = new ResourceDescriptor();
		//		jrxmlDescriptor.setWsType(ResourceDescriptor.TYPE_JRXML);
		//		jrxmlDescriptor.setName(wiz.getReportName());
		//		jrxmlDescriptor.setLabel(wiz.getReportComment()); 
		//		jrxmlDescriptor.setDescription(wiz.getReportComment()); 
		//		jrxmlDescriptor.setIsNew(true);
		//		jrxmlDescriptor.setHasData(true);
		//		jrxmlDescriptor.setMainReport(true);
		
		//		rd.setWsType(ResourceDescriptor.TYPE_REPORTUNIT);
		//		rd.setParentFolder("/Reports/Clementine");
		//		rd.setIsNew(true);
		//		rd.setUriString(rd.getParentFolder() + "/" + wiz.getReportName());
		//		rd.setName(wiz.getReportName());
		//		rd.setLabel(wiz.getReportComment()); 
		//		rd.setDescription(wiz.getReportComment()); 
		//		rd.getChildren().add(jrxmlDescriptor);
		
		//		reportGenerator.addOrModifyResource(rd,tempFile);
		
//		server.getWSClient().addOrModifyResource(rd, tempFile);

		// delete the temporary file
		tempFile.delete();
	}

	public void setDynamicView(DynamicReportView dynamicView) {
		this.dynamicView = dynamicView;
	}

	public void setJdbcDataSource(DataSource jdbcDataSource) {
		this.jdbcDataSource = jdbcDataSource;
	}

	public void setReportFieldGroupService(
			ReportFieldGroupService reportFieldGroupService) {
		this.reportFieldGroupService = reportFieldGroupService;
	}

	public void setReportFieldService(ReportFieldService reportFieldService) {
		this.reportFieldService = reportFieldService;
	}

	public void setReportGenerator(ReportGenerator reportGenerator) {
		this.reportGenerator = reportGenerator;
	}

	public void setReportSourceService(ReportSourceService reportSourceService) {
		this.reportSourceService = reportSourceService;
	}

	public void setReportSubSourceService(
			ReportSubSourceService reportSubSourceService) {
		this.reportSubSourceService = reportSubSourceService;
	}

	public void setReportUnitDataSourceURI(String reportUnitDataSourceURI) {
		this.reportUnitDataSourceURI = reportUnitDataSourceURI;
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
}
