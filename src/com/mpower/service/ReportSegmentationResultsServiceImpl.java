package com.mpower.service;

import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.jaspersoft.jasperserver.api.metadata.xml.domain.impl.ResourceDescriptor;
import com.jaspersoft.jasperserver.api.metadata.xml.domain.impl.ResourceProperty;
import com.mpower.dao.ReportSegmentationResultsDao;
import com.mpower.domain.ReportSegmentationResult;
import com.mpower.domain.ReportWizard;
import com.mpower.util.ReportQueryGenerator;
import com.mpower.util.ReportSegmentationDatasourceSettings;
import com.mpower.util.SessionHelper;

@Service("reportSegmentationResultsService")
public class ReportSegmentationResultsServiceImpl implements ReportSegmentationResultsService {
	@Resource(name = "reportSegmentationResultsDao")
	private ReportSegmentationResultsDao reportSegmentationResultsDao;

	private ReportWizardService reportWizardService;
	private ReportFieldService reportFieldService;
	private ReportCustomFilterDefinitionService reportCustomFilterDefinitionService;
	private ReportSegmentationTypeService reportSegmentationTypeService;
	private ReportSubSourceService  reportSubSourceService;
	private JasperServerService jasperServerService;

	public List<ReportSegmentationResult> readReportSegmentationResultsByReportId(Long reportId) throws Exception {
		ReportWizard wiz = reportWizardService.Find(reportId);
		ResourceDescriptor resource = jasperServerService.getDatasource(wiz.getDataSubSource().getJasperDatasourceName());
		ReportSegmentationDatasourceSettings reportSegmentationDatasourceDestination = getReportSegmentationDatasourceSettings(resource);

		return reportSegmentationResultsDao.readReportSegmentationResultsByReportId(reportId, reportSegmentationDatasourceDestination);
	}

	public int executeSegmentation(Long reportId) throws Exception {
		ReportWizard wiz = reportWizardService.Find(reportId);
		if (wiz.getSegmentationQuery() == null || wiz.getSegmentationQuery().length() == 0)
		{
			ReportQueryGenerator reportQueryGenerator = new ReportQueryGenerator(wiz, reportFieldService, reportCustomFilterDefinitionService);
			wiz.setSegmentationQuery(reportQueryGenerator.getSegmentationQueryString(reportSegmentationTypeService.find(wiz.getReportSegmentationTypeId()).getColumnName()));
		}

		ResourceDescriptor resource = jasperServerService.getDatasource(reportSubSourceService.find(wiz.getSubSourceId()).getJasperDatasourceName());
		ReportSegmentationDatasourceSettings reportSegmentationDatasourceSource = getReportSegmentationDatasourceSettings(resource);

		resource = jasperServerService.getDatasource(reportSubSourceService.find(wiz.getSubSourceId()).getSegmentationResultsDatasourceName());
		ReportSegmentationDatasourceSettings reportSegmentationDatasourceDestination = getReportSegmentationDatasourceSettings(resource);

		reportSegmentationResultsDao.deleteReportSegmentationResultsByReportId(reportId, reportSegmentationDatasourceDestination);
		Date lastRunDate = new Date();
		long startTime = System.currentTimeMillis();
		int resultCount = reportSegmentationResultsDao.executeSegmentationQuery(wiz.getSegmentationQuery(), reportSegmentationDatasourceSource, reportSegmentationDatasourceDestination);
	    long endTime = System.currentTimeMillis();
		String lastRunByUserName = SessionHelper.getGuruSessionData().getUsername();
	    reportWizardService.updateSegmentationExecutionInformation(reportId, lastRunByUserName, lastRunDate, resultCount, endTime-startTime);
	    return resultCount;
	}

	private ReportSegmentationDatasourceSettings getReportSegmentationDatasourceSettings(
			ResourceDescriptor resource) {
		ReportSegmentationDatasourceSettings reportSegmentationDatasourceSource = new ReportSegmentationDatasourceSettings();
		Iterator itProperties = resource.getProperties().iterator();
		while (itProperties.hasNext()) {
			ResourceProperty property = (ResourceProperty)itProperties.next();
			if (property.getName().equals(ResourceDescriptor.PROP_DATASOURCE_CONNECTION_URL))
				reportSegmentationDatasourceSource.setConnectionUrl(property.getValue());
			else if (property.getName().equals(ResourceDescriptor.PROP_DATASOURCE_DRIVER_CLASS))
				reportSegmentationDatasourceSource.setDriver(property.getValue());
			else if (property.getName().equals(ResourceDescriptor.PROP_DATASOURCE_USERNAME))
				reportSegmentationDatasourceSource.setUsername(property.getValue());
			else if (property.getName().equals(ResourceDescriptor.PROP_DATASOURCE_PASSWORD))
				reportSegmentationDatasourceSource.setPassword(property.getValue());
		}
		return reportSegmentationDatasourceSource;
	}

	public void setReportWizardService(ReportWizardService reportWizardService) {
		this.reportWizardService = reportWizardService;
	}

	public ReportWizardService getReportWizardService() {
		return reportWizardService;
	}

	public ReportSegmentationResultsDao getReportSegmentationResultsDao() {
		return reportSegmentationResultsDao;
	}

	public void setReportSegmentationResultsDao(
			ReportSegmentationResultsDao reportSegmentationResultsDao) {
		this.reportSegmentationResultsDao = reportSegmentationResultsDao;
	}

	public ReportFieldService getReportFieldService() {
		return reportFieldService;
	}

	public void setReportFieldService(ReportFieldService reportFieldService) {
		this.reportFieldService = reportFieldService;
	}

	public ReportCustomFilterDefinitionService getReportCustomFilterDefinitionService() {
		return reportCustomFilterDefinitionService;
	}

	public void setReportCustomFilterDefinitionService(
			ReportCustomFilterDefinitionService reportCustomFilterDefinitionService) {
		this.reportCustomFilterDefinitionService = reportCustomFilterDefinitionService;
	}

	public ReportSegmentationTypeService getReportSegmentationTypeService() {
		return reportSegmentationTypeService;
	}

	public void setReportSegmentationTypeService(
			ReportSegmentationTypeService reportSegmentationTypeService) {
		this.reportSegmentationTypeService = reportSegmentationTypeService;
	}

	public JasperServerService getJasperServerService() {
		return jasperServerService;
	}

	public void setJasperServerService(JasperServerService jasperServerService) {
		this.jasperServerService = jasperServerService;
	}

	public void setReportSubSourceService(ReportSubSourceService reportSubSourceService) {
		this.reportSubSourceService = reportSubSourceService;
	}

	public ReportSubSourceService getReportSubSourceService() {
		return reportSubSourceService;
	}
}
