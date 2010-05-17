package com.mpower.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class QueryCostUtil {

	// Returns approximate number of rows query will access.
	public static long getQueryCost(String query, Connection connection) throws SQLException {
		
		long result = 1;
		
		Statement stat = connection.createStatement();
		try {
			ResultSet rs = stat.executeQuery("EXPLAIN "+query);
			while (rs.next()) {
				long rows = rs.getLong("rows");
				result *= rows;
			}
		} finally {
			stat.close();
		}
		
		return result;
		
	}

	public static void main(String[] args) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String host = "localhost";
			String port = "3306";
			String schema = "company1";
			Connection conn = DriverManager.getConnection("jdbc:mysql://"+host+":"+port+"/"+schema+"?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF8", "orangeleap", "orangeleap");
			try {
				long cost = QueryCostUtil.getQueryCost("select * from FIELD_DEFINITION",conn);
				System.out.println(""+cost);
			} finally {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
