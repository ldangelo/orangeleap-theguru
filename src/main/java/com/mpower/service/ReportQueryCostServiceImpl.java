package com.mpower.service;

import java.sql.ResultSet;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mpower.dao.ReportQueryCostDao;
import com.mpower.dao.ReportSegmentationResultsDao;
import com.mpower.domain.ReportSegmentationResult;
import com.mpower.domain.ReportWizard;
import com.mpower.util.JasperDatasourceUtil;
import com.mpower.util.ReportQueryGenerator;
import com.mpower.util.ReportDatasourceSettings;

@Service("reportQueryCostService")
public class ReportQueryCostServiceImpl implements ReportQueryCostService {
	@Resource(name = "reportQueryCostDao")
	private ReportQueryCostDao reportQueryCostDao;

	private ReportWizardService reportWizardService;
	private ReportFieldService reportFieldService;
	private ReportCustomFilterDefinitionService reportCustomFilterDefinitionService;
	private ReportSubSourceService  reportSubSourceService;
	private JasperDatasourceUtil jasperDatasourceUtil;

	public long getReportQueryCostByReportId(long reportId, String username, String password) throws Exception {
		long result = 0;
		ReportWizard wiz = reportWizardService.Find(reportId);
		ReportQueryGenerator reportQueryGenerator = new ReportQueryGenerator(wiz, reportFieldService, reportCustomFilterDefinitionService);
		String query = reportQueryGenerator.getQueryString();

		ReportDatasourceSettings reportDatasourceSettings = jasperDatasourceUtil.getJasperDatasourceSettings(reportSubSourceService.find(wiz.getSubSourceId()).getJasperDatasourceName(), username, password);

		result = reportQueryCostDao.getQueryCost("EXPLAIN " + query, reportDatasourceSettings);
	    return result;
	}


	public long getReportQueryCostByQuery(String query, String jasperDatasourceName, String username, String password) throws Exception {
		long result = 0;
		ReportDatasourceSettings reportDatasourceSettings = jasperDatasourceUtil.getJasperDatasourceSettings(jasperDatasourceName, username, password);
		result = reportQueryCostDao.getQueryCost("EXPLAIN " + query, reportDatasourceSettings);
	    return result;
	}

	public void setReportWizardService(ReportWizardService reportWizardService) {
		this.reportWizardService = reportWizardService;
	}

	public ReportWizardService getReportWizardService() {
		return reportWizardService;
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

	public ReportQueryCostDao getReportQueryCostDao() {
		return reportQueryCostDao;
	}

	public void setReportQueryCostDao(
			ReportQueryCostDao reportQueryCostDao) {
		this.reportQueryCostDao = reportQueryCostDao;
	}
}
