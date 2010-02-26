package com.mpower.dao;

import java.sql.SQLException;
import java.util.List;

import com.mpower.domain.ReportSegmentationResult;
import com.mpower.util.ReportDatasourceSettings;

public interface ReportSegmentationResultsDao {
	public List<ReportSegmentationResult> readReportSegmentationResultsByReportId(Long reportId, ReportDatasourceSettings reportSegmentationDatasourceDestination) throws SQLException;
	public int deleteReportSegmentationResultsByReportId(Long reportId, ReportDatasourceSettings reportSegmentationDatasourceDestination) throws SQLException;
	public int executeSegmentationQuery(String query, ReportDatasourceSettings reportSegmentationDatasourceSource, ReportDatasourceSettings reportSegmentationDatasourceDestination) throws SQLException;
}
