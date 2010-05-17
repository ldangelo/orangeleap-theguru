package com.mpower.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.mpower.domain.ReportSegmentationResult;
import com.mpower.util.ReportDatasourceSettings;

public interface ReportQueryCostDao {
	public long getQueryCost(String query, ReportDatasourceSettings reportDatasourceSettings) throws SQLException;
}
