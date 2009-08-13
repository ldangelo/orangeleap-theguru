package com.mpower.dao;

import java.sql.SQLException;
import java.util.List;

import com.mpower.domain.ReportSegmentationResult;

public interface ReportSegmentationResultsDao {
	public List<ReportSegmentationResult> readReportSegmentationResultsByReportId(Long reportId, String driverClassName, String connectionUrl, String username, String password) throws SQLException;
	public int deleteReportSegmentationResultsByReportId(Long reportId, String driverClassName, String connectionUrl, String username, String password) throws SQLException;
	public int executeSegmentationQuery(String query, String driverClassName, String connectionUrl, String username, String password) throws SQLException;
}
