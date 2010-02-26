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

@Repository("reportSegmentationResultsDao")
public class JPAReportSegmentationResultsDao implements ReportSegmentationResultsDao {
	private int resultSetFetchSize;

	private static Connection getConnection(ReportDatasourceSettings reportSegmentationDatasourceSettings) throws SQLException {
		try {Class.forName(reportSegmentationDatasourceSettings.getDriver());} catch(Throwable t) {}
		return DriverManager.getConnection(reportSegmentationDatasourceSettings.getConnectionUrl(), reportSegmentationDatasourceSettings.getUsername(), reportSegmentationDatasourceSettings.getPassword());
	}

	@Override
	public List<ReportSegmentationResult> readReportSegmentationResultsByReportId(Long reportId, ReportDatasourceSettings reportSegmentationDatasourceDestination) throws SQLException {
		LinkedList<ReportSegmentationResult> result = new LinkedList<ReportSegmentationResult>();
		Connection connection = JPAReportSegmentationResultsDao.getConnection(reportSegmentationDatasourceDestination);
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
	public int deleteReportSegmentationResultsByReportId(Long reportId, ReportDatasourceSettings reportSegmentationDatasourceDestination) throws SQLException {
		int result = 0;
		Connection connection = JPAReportSegmentationResultsDao.getConnection(reportSegmentationDatasourceDestination);
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
	public int executeSegmentationQuery(String query, ReportDatasourceSettings reportSegmentationDatasourceSource, ReportDatasourceSettings reportSegmentationDatasourceDestination) throws SQLException {

		int result = 0;

		Connection connection = JPAReportSegmentationResultsDao.getConnection(reportSegmentationDatasourceSource);
		Statement statement = connection.createStatement();
		try {

			Connection connectionDestination = JPAReportSegmentationResultsDao.getConnection(reportSegmentationDatasourceDestination);
			Statement statementDestination = connectionDestination.createStatement();
			try {

				String insertStatement = "INSERT THEGURU_SEGMENTATION_RESULT " + System.getProperty("line.separator") +
				"(REPORT_ID, ENTITY_ID)" + System.getProperty("line.separator");
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

			} finally {
				statementDestination.close();
				connectionDestination.close();
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

	public void setResultSetFetchSize(int resultSetFetchSize) {
		this.resultSetFetchSize = resultSetFetchSize;
	}

	public int getResultSetFetchSize() {
		return resultSetFetchSize;
	}
}
