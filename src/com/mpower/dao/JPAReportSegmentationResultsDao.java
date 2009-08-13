package com.mpower.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.stereotype.Repository;
import com.mpower.domain.ReportSegmentationResult;

@Repository("reportSegmentationResultsDao")
public class JPAReportSegmentationResultsDao implements ReportSegmentationResultsDao {
	private BasicDataSource segmentationDataSource;

	private void updateSegmentationDataSource(String driverClassName, String connectionUrl, String username, String password) throws SQLException {
		segmentationDataSource.close();
		segmentationDataSource.setUrl(connectionUrl);
		segmentationDataSource.setDriverClassName(driverClassName);
		segmentationDataSource.setUsername(username);
		segmentationDataSource.setPassword(password);
	}

	@Override
	public List<ReportSegmentationResult> readReportSegmentationResultsByReportId(Long reportId, String driverClassName, String connectionUrl, String username, String password) throws SQLException {
		LinkedList<ReportSegmentationResult> result = new LinkedList<ReportSegmentationResult>();
		updateSegmentationDataSource(driverClassName, connectionUrl, username, password);
		Connection connection = segmentationDataSource.getConnection();
		Statement statement = connection.createStatement();
		try {
			ResultSet segmentationResults = statement.executeQuery("SELECT * FROM THEGURU_SEGMENTATION_RESULT WHERE REPORT_ID = " + reportId.toString() + " ORDER BY ENTITY_ID");
			while (segmentationResults.next()) {
				ReportSegmentationResult reportSegmentationResult = new ReportSegmentationResult();
				reportSegmentationResult.setId(segmentationResults.getLong("THEGURU_SEGMENTATION_RESULT_ID"));
				reportSegmentationResult.setReportId(segmentationResults.getLong("REPORT_ID"));
				reportSegmentationResult.setEntityId(segmentationResults.getLong("ENTITY_ID"));
				result.add(reportSegmentationResult);
			}
		} catch (SQLException exception) {
			exception.printStackTrace();
			throw new SQLException("Error retrieving segmentation results report ID " + reportId.toString() + System.getProperty("line.separator") + exception.getMessage());
		} finally {
			statement.close();
			connection.close();
		}
		return result;
	}

	@Override
	public int deleteReportSegmentationResultsByReportId(Long reportId, String driverClassName, String connectionUrl, String username, String password) throws SQLException {
		int result = 0;
		updateSegmentationDataSource(driverClassName, connectionUrl, username, password);
		Connection connection = segmentationDataSource.getConnection();
		Statement statement = connection.createStatement();
		try {
			result = statement.executeUpdate("DELETE FROM THEGURU_SEGMENTATION_RESULT WHERE REPORT_ID = " + reportId.toString());
		} catch (SQLException exception) {
			exception.printStackTrace();
			throw new SQLException("Error deleting segmentation results for report ID " + reportId.toString() + System.getProperty("line.separator") + exception.getMessage());
		} finally {
			statement.close();
			connection.close();
		}
		return result;
	}

	@Override
	public int executeSegmentationQuery(String query, String driverClassName, String connectionUrl, String username, String password) throws SQLException {
		int result = 0;
		updateSegmentationDataSource(driverClassName, connectionUrl, username, password);
		Connection connection = segmentationDataSource.getConnection();
		Statement statement = connection.createStatement();
		try {
			result = statement.executeUpdate(query);
		} catch (SQLException exception) {
			exception.printStackTrace();
			throw new SQLException("Error excuting segmentation query." + System.getProperty("line.separator") + exception.getMessage() + "Query : " + System.getProperty("line.separator") + query);
		} finally {
			statement.close();
			connection.close();
		}
		return result;
	}

	public BasicDataSource getSegmentationDataSource() {
		return segmentationDataSource;
	}

	public void setSegmentationDataSource(BasicDataSource segmentationDataSource) {
		this.segmentationDataSource = segmentationDataSource;
	}
}
