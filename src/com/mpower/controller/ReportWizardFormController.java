package com.mpower.controller;

import java.io.File;
import java.io.IOException;
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
import javax.xml.parsers.*;

import net.sf.jasperreports.crosstabs.JRCrosstab;
import net.sf.jasperreports.engine.JRChild;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.xml.JRXmlWriter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.util.Assert;
import org.springframework.validation.BindException;
import org.springframework.validation.Errors;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractWizardFormController;
import org.w3c.dom.*;
import org.xml.sax.SAXException;

import ar.com.fdvs.dj.core.DynamicJasperHelper;
import ar.com.fdvs.dj.core.layout.ClassicLayoutManager;
import ar.com.fdvs.dj.domain.DynamicReport;
import com.jaspersoft.jasperserver.api.metadata.xml.domain.impl.ResourceDescriptor;
import com.mpower.domain.ReportCustomFilterDefinition;
import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportDataSubSource;
import com.mpower.domain.ReportField;
import com.mpower.domain.ReportFieldGroup;
import com.mpower.domain.ReportGroupByField;
import com.mpower.domain.ReportWizard;
import com.mpower.service.ReportCustomFilterDefinitionService;
import com.mpower.service.ReportFieldGroupService;
import com.mpower.service.ReportFieldService;
import com.mpower.service.ReportSourceService;
import com.mpower.service.ReportSubSourceService;
import com.mpower.service.ReportWizardService;
//import com.mpower.service.ReportWizardService;
import com.mpower.service.SessionService;
import com.mpower.service.JasperServerService;
import com.mpower.util.ReportGenerator;
import com.mpower.view.DynamicReportView;
import com.sun.org.apache.xml.internal.serialize.XMLSerializer;

public class ReportWizardFormController extends AbstractWizardFormController {
    private ReportSubSourceService  reportSubSourceService;

    /** Logger for this class and subclasses */
    protected final Log logger = LogFactory.getLog(getClass());

    private DynamicReportView       dynamicView;
    private ReportSourceService     reportSourceService;
    private ReportWizard            wiz;
    private ReportWizardService     reportWizardService;
    private JasperServerService     jasperServerService;
    private ReportFieldGroupService reportFieldGroupService;

    private ReportFieldService      reportFieldService;
    private ReportCustomFilterDefinitionService      reportCustomFilterDefinitionService;
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

	if (request.getParameter("_target9") != null) {
	    //
	    // We are saving this report to jasperserver
	    try {
		saveReport(wiz);
	    } catch (Exception e) {
		logger.error(e.getLocalizedMessage());
		errors.reject(e.getLocalizedMessage());
	    }
	}
    }

    @Override
    protected int getTargetPage(HttpServletRequest request,
	Object command,
	Errors errors,
	int currentPage) {
	ReportWizard reportWizard = (ReportWizard)command;


	int targetPage = super.getTargetPage(request, command, errors, currentPage);
	if (targetPage == 2 && reportWizard.getReportType().compareTo("summary") != 0 && reportWizard.getReportType().compareTo("matrix") != 0) {
	    if (currentPage == 3)
		targetPage = 1;
	    else
		targetPage = 3;
	}

	//
	//Matrix Report Navigation
	//skip to filters
	if (targetPage == 3 && reportWizard.getReportType().compareTo("matrix") == 0) {
	    if (currentPage == 2)
		targetPage = 6;
	}
	//go back from filters to Matrix Settings
	if (targetPage == 5 && reportWizard.getReportType().compareTo("matrix") == 0) {
	    if (currentPage == 6)
		targetPage = 2;
	}

	//skip chart settings for tabular and matrix reports
	if (targetPage == 7 && reportWizard.getReportType().compareTo("summary") != 0 ) {
	    if (currentPage == 6)
		targetPage = 8;
	    else
		targetPage = 6;			
	}

	//skip summarized fields if no summary fields available
	if (targetPage == 4) {
	    boolean fieldsToSummarize = false;
	    Iterator<ReportField> itFields = wiz.getSelectedReportFieldsInOrder().iterator();
	    while (itFields.hasNext()) {
		ReportField field = (ReportField)itFields.next();
		if (field.getCanBeSummarized()) {
		    fieldsToSummarize = true;
		    break;
		}
	    }
	    if (!fieldsToSummarize) {
		if (currentPage < 4)
		    targetPage = 5;
		else
		    targetPage = 4;
	    }
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

	    wiz.setUsername(request.getParameter("username"));
	    wiz.setPassword(request.getParameter("password"));
	    
	    reportGenerator.setReportUserName(wiz.getUsername());
	    reportGenerator.setReportPassword(wiz.getPassword());

	    jasperServerService.setUserName(wiz.getUsername());
	    jasperServerService.setPassword(wiz.getPassword());
	    wiz.setReportTemplateList(jasperServerService.list("/Reports/" + wiz.getCompany() + "/templates"));
	}
	    
	//
	// Report Format
	if (page == 1) {
	    wiz.setDataSource(reportSourceService.find(wiz.getSrcId()));
		
	    ReportDataSource rds = reportSourceService.find(wiz.getSrcId());
	    List<ReportDataSubSource> lrdss = reportSubSourceService.readSubSourcesByReportSourceId(rds.getId());
	    wiz.setDataSource(rds);
	    wiz.setDataSubSources(lrdss);
	    refData.put("reportDataSubSources", lrdss);
		
		
	    ReportDataSubSource       rdss = reportSubSourceService.find( wiz.getSubSourceId());
		
	    List<ReportFieldGroup>    lrfg = reportFieldGroupService.readFieldGroupBySubSourceId(rdss.getId());
	    wiz.setFieldGroups(lrfg);
	    refData.put("fieldGroups", lrfg);
		
	    wiz.setDataSubSource(rdss);
		
	    wiz.getDataSubSource().setReportCustomFilterDefinitions(reportCustomFilterDefinitionService.readReportCustomFilterDefinitionBySubSourceId(rdss.getId()));
		
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
	// Report Group By Fields and Matrix Report
	if (page == 2) {
	    String reportType = wiz.getReportType();
	    refData.put("reportType", reportType);
		
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
	    
	if(page==4) {
		
	    refData.put("fieldGroups", wiz.getFieldGroups());
	}
	    
	if(page==5) {
	    refData.put("fieldGroups", wiz.getFieldGroups());
	    refData.put("fields", wiz.getSelectedReportFieldsInOrder());
	}
	    
	if(page==6) {
	    refData.put("fieldGroups", wiz.getFieldGroups());
	    refData.put("customFilters", wiz.getDataSubSource().getReportCustomFilterDefinitions());
	}
	    
	// chart options
	if(page==7) {
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
	if (page==11) {
	    //			wiz.setReportPath("/Reports/Clementine/" + wiz.getReportName().replace(" ", "_"));
	    refData.put("reportPath", wiz.getReportPath());
	}
	    
	// running the report
	if (page==12) {
	    @SuppressWarnings("unused")
		
		DynamicReport dr = reportGenerator.Generate(wiz, jdbcDataSource, reportFieldService, reportCustomFilterDefinitionService);
	    String query = dr.getQuery().getText();
		
	    //
	    // execute the query and pass it to generateJasperPrint
	    Connection connection = jdbcDataSource.getConnection();
	    Statement statement = connection.createStatement();
		
	    File tempFile = File.createTempFile("wiz", ".jrxml");
	    DynamicJasperHelper.generateJRXML(dr,new ClassicLayoutManager(), reportGenerator.getParams(), null, tempFile.getPath());
		
	    if (wiz.getReportType().compareToIgnoreCase("matrix") == 0)
		removeCrossTabDataSubset(tempFile.getPath());
		
	    //
	    // save the report to the server
	    reportGenerator.put(ResourceDescriptor.TYPE_REPORTUNIT, tempFile.getName(), tempFile.getName(), tempFile.getName(), wiz.getTempFolderPath(), tempFile,reportGenerator.getParams(), wiz.getDataSubSource().getJasperDatasourceName());
		
	    wiz.setReportPath(wiz.getTempFolderPath() + "/" + tempFile.getName());
	    refData.put("reportPath", wiz.getReportPath());
		
	    tempFile.delete();
	}
	    
	return refData;
    }
    
    protected void saveReport(ReportWizard wiz) throws Exception {

	//
	// First we must generate a jrxml file
	//

	DynamicReport dr = reportGenerator.Generate(wiz, jdbcDataSource, reportFieldService, reportCustomFilterDefinitionService);

	File tempFile = File.createTempFile("wiz", ".jrxml");
	DynamicJasperHelper.generateJRXML(dr,new ClassicLayoutManager(), reportGenerator.getParams(), null, tempFile.getPath());

	// TODO - only need to remove the cross tab data subset on matrix reports
	if (wiz.getReportType().compareToIgnoreCase("matrix") == 0)
	    removeCrossTabDataSubset(tempFile.getPath());
		
	String reportTitle = wiz.getDataSubSource().getDisplayName() + " Custom Report";
	if (wiz.getReportName() != null && wiz.getReportName().length() > 0)
	    reportTitle = wiz.getReportName();

	String reportComment = wiz.getDataSubSource().getDisplayName() + " Custom Report";
	if (wiz.getReportComment() != null && wiz.getReportComment().length() > 0)
	    reportComment = wiz.getReportComment();
		
	reportGenerator.put(ResourceDescriptor.TYPE_REPORTUNIT, reportTitle.replace(" ", "_"), reportTitle, reportComment,wiz.getReportPath(),tempFile, reportGenerator.getParams(), wiz.getDataSubSource().getJasperDatasourceName());

        //    		reportGenerator.put(ResourceDescriptor.TYPE_REPORTUNIT, reportTitle.replace(" ", "_"), reportTitle, reportComment, wiz.getReportPath(),tempFile, reportGenerator.getParams());


	// delete the temporary file
	tempFile.delete();
    }

    public void removeCrossTabDataSubset(String fileName) throws ParserConfigurationException, SAXException, IOException {
	// Load the report xml document
	DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
	DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
	Document document = documentBuilder.parse(new File(fileName));
	// Remove datasetRun element from the report xml
	removeAll(document, Node.ELEMENT_NODE, "datasetRun");
	// Remove detail element from the report xml
	removeAll(document, Node.ELEMENT_NODE, "detail");
	// Remove detail element from the report xml
	removeAll(document, Node.ELEMENT_NODE, "columnHeader");
	document.normalize();
	// Save the xml back to the temp file
	XMLSerializer serializer = new XMLSerializer();
	serializer.setOutputCharStream(new java.io.FileWriter(fileName));
	serializer.serialize(document);	     
    }

    public static void removeAll(Node node, short nodeType, String name) {
        if (node.getNodeType() == nodeType &&
	    (name == null || node.getNodeName().equals(name))) {
            node.getParentNode().removeChild(node);
        } else {
            // Visit the children
            NodeList list = node.getChildNodes();
            for (int i=0; i<list.getLength(); i++) {
                removeAll(list.item(i), nodeType, name);
            }
        }
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

    public void setReportCustomFilterDefinitionService(
	ReportCustomFilterDefinitionService reportCustomFilterDefinitionService) {
	this.reportCustomFilterDefinitionService = reportCustomFilterDefinitionService;
    }

    public ReportCustomFilterDefinitionService getReportCustomFilterDefinitionService() {
	return reportCustomFilterDefinitionService;
    }

    public void setJasperServerService(JasperServerService jss) {
	jasperServerService = jss;
    }
}
