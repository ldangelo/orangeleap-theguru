package com.mpower.service;

import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.mpower.dao.ReportSegmentationResultsDao;
import com.mpower.domain.ReportSegmentationResult;
import com.mpower.domain.ReportWizard;
import com.mpower.util.JasperDatasourceUtil;
import com.mpower.util.ReportQueryGenerator;
import com.mpower.util.ReportDatasourceSettings;
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
	private JasperDatasourceUtil jasperDatasourceUtil;

	public List<ReportSegmentationResult> readReportSegmentationResultsByReportId(Long reportId) throws Exception {
		ReportWizard wiz = reportWizardService.Find(reportId);
		ReportDatasourceSettings reportSegmentationDatasourceDestination = jasperDatasourceUtil.getJasperDatasourceSettings(wiz.getDataSubSource().getSegmentationResultsDatasourceName());

		return reportSegmentationResultsDao.readReportSegmentationResultsByReportId(reportId, reportSegmentationDatasourceDestination);
	}

	public int executeSegmentation(Long reportId) throws Exception {
		ReportWizard wiz = reportWizardService.Find(reportId);
		if (wiz.getSegmentationQuery() == null || wiz.getSegmentationQuery().length() == 0)
		{
			ReportQueryGenerator reportQueryGenerator = new ReportQueryGenerator(wiz, reportFieldService, reportCustomFilterDefinitionService);
			wiz.setSegmentationQuery(reportQueryGenerator.getSegmentationQueryString(reportSegmentationTypeService.find(wiz.getReportSegmentationTypeId()).getColumnName()));
		}

		ReportDatasourceSettings reportSegmentationDatasourceSource = jasperDatasourceUtil.getJasperDatasourceSettings(reportSubSourceService.find(wiz.getSubSourceId()).getJasperDatasourceName());

		ReportDatasourceSettings reportSegmentationDatasourceDestination = jasperDatasourceUtil.getJasperDatasourceSettings(reportSubSourceService.find(wiz.getSubSourceId()).getSegmentationResultsDatasourceName());

		reportSegmentationResultsDao.deleteReportSegmentationResultsByReportId(reportId, reportSegmentationDatasourceDestination);
		Date lastRunDate = new Date();
		long startTime = System.currentTimeMillis();
		int resultCount = reportSegmentationResultsDao.executeSegmentationQuery(wiz.getSegmentationQuery(), reportSegmentationDatasourceSource, reportSegmentationDatasourceDestination);
	    long endTime = System.currentTimeMillis();
		String lastRunByUserName = SessionHelper.getGuruSessionData().getUsername();
	    reportWizardService.updateSegmentationExecutionInformation(reportId, lastRunByUserName, lastRunDate, resultCount, endTime-startTime);
	    return resultCount;
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

	public void setReportSubSourceService(ReportSubSourceService reportSubSourceService) {
		this.reportSubSourceService = reportSubSourceService;
	}

	public ReportSubSourceService getReportSubSourceService() {
		return reportSubSourceService;
	}

	public JasperDatasourceUtil getJasperDatasourceUtil() {
		return jasperDatasourceUtil;
	}

	public void setJasperDatasourceUtil(JasperDatasourceUtil jasperDatasourceUtil) {
		this.jasperDatasourceUtil = jasperDatasourceUtil;
	}
}
