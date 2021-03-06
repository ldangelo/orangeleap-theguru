package com.mpower.util;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;

import com.orangeleap.common.security.OrangeLeapUsernamePasswordLocal;

public class TheGuruDataSource implements DataSource {

    protected final Log logger = LogFactory.getLog(getClass());


	// The default schema should have no tables. Change to this first so in case something goes wrong, we don't want to still be pointing to the old database.
	private static final String THEGURU_DEFAULT_SCHEMA = "theguru";
	private static final String USE_SQL = "USE ";

	private boolean splitDatabases = true;
	private DataSource dataSource;
	double count;

	@Override
	public Connection getConnection() throws SQLException {

		Connection conn = dataSource.getConnection();
		if (logger.isDebugEnabled()) {
			count++;
			logger.debug("getConnection() called, count = " + (int)count);
			//new Exception().fillInStackTrace().printStackTrace();
		}

		if (!splitDatabases) {

			// We have split databases turned off - use default schema.
			return conn;

		} else {
			String siteName = getSiteName();
			boolean hasSite = siteName != null && siteName.trim().length() > 0;
			if (hasSite) {
				//logger.debug("getConnection() called for site " + siteName);
			}

			// We have split databases turned on - use site schema if one applies.

			// This default schema must exist, and should have no tables in it.
			// Want to remain here if error occurs setting schema to site schema.
			changeSchema(conn, THEGURU_DEFAULT_SCHEMA);

			if (!hasSite) {
				// This path is used by container when initializing a pool connection outside of a site context.
				return conn;
			}

			logger.debug("Setting schema for site = " + siteName + "...");
			try  {
	            changeSchema(conn, siteName);
            } catch (RuntimeException e) {
            	try { conn.close(); } catch (Exception ee) {}
            	throw e;
            }
			//logger.debug("Set schema for site = "+siteName + ".");

			return conn;

		}
	}

	private String getSiteName() {
		try {
			Map<String, Object> info = (Map<String, Object>)SecurityContextHolder.getContext().getAuthentication().getDetails();

			String site = (String) info.get(OrangeLeapUsernamePasswordLocal.SITE);

			if (site != null)
				return site + "theguru";
			else
				return THEGURU_DEFAULT_SCHEMA;
		} catch (Exception exception) {
			logger.error(exception);
			return THEGURU_DEFAULT_SCHEMA;
		}
	}

	private void changeSchema(Connection conn, String schema) throws SQLException {
		logger.debug("Setting schema = " + schema + "...");
		if (schema == null || schema.length() == 0 || !StringUtils.isAlphanumeric(schema)) {
			throw new RuntimeException("Invalid schema name.");
		}

		// Mysql appears to prefer a Statement to a PreparedStatement in order to execute non-standard SQL commands.
		// Must therefore validate parameter for non-alphanumeric characters.
		Statement s = conn.createStatement();
		try {
			s.execute(USE_SQL + schema);
		} catch (Throwable e) {
			e.printStackTrace();
			throw new RuntimeException("Unable to change databases to "+schema, e);
		} finally {
			s.close();
		}

	}

	@Override
	public Connection getConnection(String username, String password)
			throws SQLException {
		throw new RuntimeException("getConnection(username, password) is not supported by TangerineDataSource.");
	}

	@Override
	public PrintWriter getLogWriter() throws SQLException {
		return dataSource.getLogWriter();
	}

	@Override
	public int getLoginTimeout() throws SQLException {
		return dataSource.getLoginTimeout();
	}

	@Override
	public void setLogWriter(PrintWriter out) throws SQLException {
		dataSource.setLogWriter(out);
	}

	@Override
	public void setLoginTimeout(int seconds) throws SQLException {
		dataSource.setLoginTimeout(seconds);
	}

	@Override
	public boolean isWrapperFor(Class<?> iface) throws SQLException {
		return dataSource.isWrapperFor(iface);
	}

	@Override
	public <T> T unwrap(Class<T> iface) throws SQLException {
		return dataSource.unwrap(iface);
	}

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public DataSource getDataSource() {
		return dataSource;
	}

    public void setSplitDatabases(boolean splitDatabases) {
		this.splitDatabases = splitDatabases;
	}

	public boolean isSplitDatabases() {
		return splitDatabases;
	}

}
