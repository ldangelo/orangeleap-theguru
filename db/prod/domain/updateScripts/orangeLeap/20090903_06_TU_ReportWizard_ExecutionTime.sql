DELIMITER $$

DROP PROCEDURE IF EXISTS ADDCOLUMN_UPDATESCRIPT$$

CREATE PROCEDURE ADDCOLUMN_UPDATESCRIPT() BEGIN
	IF NOT EXISTS
		(SELECT * FROM INFORMATION_SCHEMA.COLUMNS
		WHERE COLUMN_NAME='EXECUTION_TIME' AND TABLE_NAME='REPORTWIZARD' AND TABLE_SCHEMA = DATABASE())
	THEN
		ALTER TABLE REPORTWIZARD
		ADD COLUMN EXECUTION_TIME BIGINT;
	END IF;
END;
$$

DELIMITER ;

CALL ADDCOLUMN_UPDATESCRIPT();

DROP PROCEDURE ADDCOLUMN_UPDATESCRIPT;

UPDATE REPORTWIZARD SET EXECUTION_TIME = 0 WHERE EXECUTION_TIME IS NULL;
