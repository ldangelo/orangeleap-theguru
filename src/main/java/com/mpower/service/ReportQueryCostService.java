package com.mpower.service;

import org.springframework.context.ApplicationContext;

public interface ReportQueryCostService {
	public long getReportQueryCostByReportId(ApplicationContext applicationContext, long reportId, String username, String password) throws Exception;
	public long getReportQueryCostByQuery(String query, String jasperDatasourceName, String username, String password) throws Exception;
}
