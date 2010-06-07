package com.mpower.service;

public interface ReportQueryCostService {
	public long getReportQueryCostByReportId(long reportId, String username, String password) throws Exception;
	public long getReportQueryCostByQuery(String query, String jasperDatasourceName, String username, String password) throws Exception;
}
