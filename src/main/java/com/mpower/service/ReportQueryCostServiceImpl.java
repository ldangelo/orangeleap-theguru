package com.mpower.service;

import java.sql.ResultSet;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.ApplicationContext;
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
	private TheGuruViewService theGuruViewService;
	private TheGuruViewJoinService theGuruViewJoinService;

	public long getReportQueryCostByReportId(ApplicationContext applicationContext, long reportId, String username, String password) throws Exception {
		long result = 0;
		ReportWizard wiz = reportWizardService.Find(reportId);
		ReportQueryGenerator reportQueryGenerator = new ReportQueryGenerator(wiz, reportFieldService, reportCustomFilterDefinitionService, applicationContext,
				theGuruViewService, theGuruViewJoinService);
		String query = reportQueryGenerator.getQueryString();

		ReportDatasourceSettings reportDatasourceSettings = jasperDatasourceUtil.getJasperDatasourceSettings(reportSubSourceService.find(wiz.getSubSourceId()).getJasperDatasourceName(), username, password);

		try {
			result = reportQueryCostDao.getQueryCost("EXPLAIN " + query, reportDatasourceSettings);
		} catch (Exception exception) {
			exception.printStackTrace();
		}
	    return result;
	}


	public long getReportQueryCostByQuery(String query, String jasperDatasourceName, String username, String password) throws Exception {
		long result = 0;
		ReportDatasourceSettings reportDatasourceSettings = jasperDatasourceUtil.getJasperDatasourceSettings(jasperDatasourceName, username, password);
		try {
			result = reportQueryCostDao.getQueryCost("EXPLAIN " + query, reportDatasourceSettings);
		} catch (Exception exception) {
			exception.printStackTrace();
		}
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
