-- Insert datasource for MPX database
INSERT JIResource (version, name, parent_folder, label, description, creation_date) SELECT 0, 'ReportWizardJdbcDSForMPX', parent_folder, 'Report Wizard JDBC Data Source For MPX', description, CURDATE() FROM JIResource WHERE name = 'ReportWizardJdbcDS';
INSERT JIJdbcDatasource (id, driver, password, connectionUrl, username) SELECT id, 'com.microsoft.sqlserver.jdbc.SQLServerDriver', 'mpx', 'jdbc:sqlserver://Puddy:2968;databaseName=MPX_OLI_UnitTest_Baseline', 'sa' FROM JIResource WHERE name = 'ReportWizardJdbcDSForMPX';
