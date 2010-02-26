package com.mpower.service;

public interface ReportQueryCostService {
	public long getReportQueryCostByReportId(long reportId) throws Exception;
	public long getReportQueryCostByQuery(String query, String jasperDatasourceName) throws Exception;
}
