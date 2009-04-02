package com.mpower.util;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ddlutils.Platform;
import org.apache.ddlutils.PlatformFactory;
import org.apache.ddlutils.io.DatabaseIO;
import org.apache.ddlutils.model.Column;
import org.apache.ddlutils.model.Database;
import org.apache.ddlutils.model.Table;

public class SchemaUtil {
	
	
		protected final Log logger = LogFactory.getLog(getClass());

	
		// This could be changed to take a jdbc drive and url string if needed
		public Database readDatabaseSchema(DataSource dataSource)
		{
		    Platform platform = PlatformFactory.createNewPlatformInstance(dataSource);

		    Database database =  platform.readModelFromDatabase("model");
		    
		    if (logger.isDebugEnabled()) 
		    {
		    	logger.debug("Found table list:");
		    	for (Table table :  database.getTables()) {
		    		logger.debug(table.getName());
			    	for (Column column :  table.getColumns()) {
			    		logger.debug("\t"+column.getName() + " " +column.getType());
			    	}
		    	}
		    	new DatabaseIO().write(database, "database-schema.xml");
		    }
		    
		    
		    return database;
		}
		
		public static void main(String[] args) {
			
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			DataSource ds = new DataSource() {

				@Override
				public Connection getConnection() throws SQLException {
					return DriverManager.getConnection("jdbc:mysql://localhost:3306/orangeleap?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF8", "orangeleap", "orangeleap");
				}

				@Override
				public Connection getConnection(String username, String password)
						throws SQLException {
					return null;
				}

				@Override
				public PrintWriter getLogWriter() throws SQLException {
					return null;
				}

				@Override
				public int getLoginTimeout() throws SQLException {
					return 0;
				}

				@Override
				public void setLogWriter(PrintWriter out) throws SQLException {
				}

				@Override
				public void setLoginTimeout(int seconds) throws SQLException {
				}

				@Override
				public boolean isWrapperFor(Class<?> iface) throws SQLException {
					return false;
				}

				@Override
				public <T> T unwrap(Class<T> iface) throws SQLException {
					return null;
				}
				
			};
			
			new SchemaUtil().readDatabaseSchema(ds);
		}
	

}
