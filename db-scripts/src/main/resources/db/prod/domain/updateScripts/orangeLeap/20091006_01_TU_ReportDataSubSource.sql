DELIMITER $$

DROP PROCEDURE IF EXISTS ADDCOLUMN_UPDATESCRIPT$$

CREATE PROCEDURE ADDCOLUMN_UPDATESCRIPT() BEGIN
	IF NOT EXISTS
		(SELECT * FROM INFORMATION_SCHEMA.COLUMNS
		WHERE COLUMN_NAME='SEGMENTATION_RESULTS_DATASOURCE_NAME' AND TABLE_NAME='REPORTDATASUBSOURCE' AND TABLE_SCHEMA = DATABASE())
	THEN
		ALTER TABLE REPORTDATASUBSOURCE
		ADD COLUMN SEGMENTATION_RESULTS_DATASOURCE_NAME VARCHAR(255);
	END IF;
END;
$$

DELIMITER ;

CALL ADDCOLUMN_UPDATESCRIPT();

DROP PROCEDURE ADDCOLUMN_UPDATESCRIPT;

INSERT JIResource
  (version, name, parent_folder, childrenFolder, label, description, creation_date)
SELECT
  version,
  CONCAT(name, 'SegmentationResults'),
  parent_folder,
  childrenFolder,
  CONCAT(label, ' For Segmentation Results'),
  description,
  creation_date
FROM JIResource
WHERE NAME = 'ReportWizardJdbcDS'
AND NOT EXISTS (SELECT * FROM JIResource WHERE name = 'ReportWizardJdbcDSSegmentationResults');

INSERT JIJdbcDatasource
  (id, driver, password, connectionURL, username, timezone)
SELECT
  (SELECT ID FROM JIResource WHERE NAME = 'ReportWizardJdbcDSSegmentationResults'),
  driver,
  password,
  REPLACE(connectionURL, '172.22.250.46', '172.22.250.44'),
  username,
  timezone
FROM JIJdbcDatasource
WHERE ID = (SELECT ID FROM JIResource WHERE NAME = 'ReportWizardJdbcDS')
AND NOT EXISTS (SELECT * FROM JIJdbcDatasource WHERE ID = (SELECT ID FROM JIResource WHERE NAME = 'ReportWizardJdbcDSSegmentationResults'));

UPDATE REPORTDATASUBSOURCE
SET SEGMENTATION_RESULTS_DATASOURCE_NAME = '/datasources/ReportWizardJdbcDSSegmentationResults'
WHERE SEGMENTATION_RESULTS_DATASOURCE_NAME IS NULL;

