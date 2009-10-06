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
import com.mpower.util.ReportSegmentationDatasourceSettings;

@Repository("reportSegmentationResultsDao")
public class JPAReportSegmentationResultsDao implements ReportSegmentationResultsDao {
	private BasicDataSource segmentationDataSourceDestination;
	private BasicDataSource segmentationDataSourceSource;
	private int resultSetFetchSize;

	private void updateSegmentationDataSource(BasicDataSource segmentationDataSource, ReportSegmentationDatasourceSettings reportSegmentationDatasourceSettings) throws SQLException {
		segmentationDataSource.close();
		segmentationDataSource.setUrl(reportSegmentationDatasourceSettings.getConnectionUrl());
		segmentationDataSource.setDriverClassName(reportSegmentationDatasourceSettings.getDriver());
		segmentationDataSource.setUsername(reportSegmentationDatasourceSettings.getUsername());
		segmentationDataSource.setPassword(reportSegmentationDatasourceSettings.getPassword());
	}

	@Override
	public List<ReportSegmentationResult> readReportSegmentationResultsByReportId(Long reportId, ReportSegmentationDatasourceSettings reportSegmentationDatasourceDestination) throws SQLException {
		LinkedList<ReportSegmentationResult> result = new LinkedList<ReportSegmentationResult>();
		updateSegmentationDataSource(segmentationDataSourceDestination, reportSegmentationDatasourceDestination);
		Connection connection = segmentationDataSourceDestination.getConnection();
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
	public int deleteReportSegmentationResultsByReportId(Long reportId, ReportSegmentationDatasourceSettings reportSegmentationDatasourceDestination) throws SQLException {
		int result = 0;
		updateSegmentationDataSource(segmentationDataSourceDestination, reportSegmentationDatasourceDestination);
		Connection connection = segmentationDataSourceDestination.getConnection();
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
	public int executeSegmentationQuery(String query, ReportSegmentationDatasourceSettings reportSegmentationDatasourceSource, ReportSegmentationDatasourceSettings reportSegmentationDatasourceDestination) throws SQLException {
		int result = 0;
		updateSegmentationDataSource(segmentationDataSourceSource, reportSegmentationDatasourceSource);
		updateSegmentationDataSource(segmentationDataSourceDestination, reportSegmentationDatasourceDestination);

		Connection connection = segmentationDataSourceSource.getConnection();
		Statement statement = connection.createStatement();

		Connection connectionDestination = segmentationDataSourceDestination.getConnection();
		Statement statementDestination = connectionDestination.createStatement();
		String insertStatement = "INSERT THEGURU_SEGMENTATION_RESULT " + System.getProperty("line.separator") +
			"(REPORT_ID, ENTITY_ID)" + System.getProperty("line.separator");
		try {
			ResultSet resultSet = statement.executeQuery(query);
			resultSet.setFetchSize(resultSetFetchSize);
			Boolean addUnion = false;
			String values = "";
			int recordCount = 0;
			while (resultSet.next()) {
				result++;
				recordCount++;
				if (addUnion)
					values += System.getProperty("line.separator") + "UNION" + System.getProperty("line.separator");
				else
					addUnion = true;
				values += "SELECT " + resultSet.getLong("REPORT_ID") + ", " + resultSet.getLong("ENTITY_ID");

				if (recordCount > resultSetFetchSize) {
					statementDestination.execute(insertStatement + values);
					recordCount = 0;
					addUnion = false;
					values = "";
				}
			}

			if (recordCount > 0) {
				statementDestination.execute(insertStatement + values);
				recordCount = 0;
				addUnion = false;
				values = "";
			}
		} catch (SQLException exception) {
			exception.printStackTrace();
			throw new SQLException("Error excuting segmentation query." + System.getProperty("line.separator") + exception.getMessage() + "Query : " + System.getProperty("line.separator") + query);
		} finally {
			statement.close();
			connection.close();
		}
		return result;
	}

	public void setSegmentationDataSourceSource(
			BasicDataSource segmentationDataSourceSource) {
		this.segmentationDataSourceSource = segmentationDataSourceSource;
	}

	public BasicDataSource getSegmentationDataSourceSource() {
		return segmentationDataSourceSource;
	}

	public void setSegmentationDataSourceDestination(
			BasicDataSource segmentationDataSourceDestination) {
		this.segmentationDataSourceDestination = segmentationDataSourceDestination;
	}

	public BasicDataSource getSegmentationDataSourceDestination() {
		return segmentationDataSourceDestination;
	}

	public void setResultSetFetchSize(int resultSetFetchSize) {
		this.resultSetFetchSize = resultSetFetchSize;
	}

	public int getResultSetFetchSize() {
		return resultSetFetchSize;
	}
}
