package com.mpower.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.stereotype.Repository;
import com.mpower.domain.ReportSegmentationResult;
import com.mpower.util.ReportDatasourceSettings;

@Repository("reportQueryCostDao")
public class JPAReportQueryCostDao implements ReportQueryCostDao {

	private static Connection getConnection(ReportDatasourceSettings reportDatasourceSettings) throws SQLException {
		try {Class.forName(reportDatasourceSettings.getDriver());} catch(Throwable t) {}
		return DriverManager.getConnection(reportDatasourceSettings.getConnectionUrl(), reportDatasourceSettings.getUsername(), reportDatasourceSettings.getPassword());
	}

	public long getQueryCost(String query, ReportDatasourceSettings reportDatasourceSettings) throws SQLException {
		long result = 1;
		Connection connection = JPAReportQueryCostDao.getConnection(reportDatasourceSettings);
		Statement statement = connection.createStatement();
		try {
			ResultSet resultSet = statement.executeQuery(query);
			while (resultSet.next()) {
				long rows = resultSet.getLong("rows");
				if (rows != 0)
					result *= rows;
			}
		} catch (SQLException exception) {
			exception.printStackTrace();
			throw new SQLException("Error calculating query cost :" + System.getProperty("line.separator") + query + System.getProperty("line.separator") + exception.getMessage());
		} finally {
			statement.close();
			connection.close();
		}
		return result;
	}
}
