DELIMITER $$

DROP PROCEDURE IF EXISTS ADDREPORTFIELDS$$

CREATE PROCEDURE ADDREPORTFIELDS(COLUMNNAMEVAR VARCHAR(100), SEGMENTATIONTYPEVAR (VARCHAR(100)))
BEGIN
	IF NOT EXISTS
		(SELECT * FROM REPORTSEGMENTATIONTYPE
		WHERE COLUMN_NAME = COLUMNNAMEVAR
		AND SEGMENTATIONTYPE = SEGMENTATIONTYPEVAR))
	THEN
		INSERT REPORTSEGMENTATIONTYPE
		  (COLUMN_NAME, SEGMENTATIONTYPE)
		SELECT
		  COLUMNNAMEVAR, SEGMENTATIONTYPEVAR;

		SET @REPORTSEGMENTATIONTYPEID = LAST_INSERT_ID();

		INSERT REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE
		  (reportSegmentationTypes_REPORTSEGMENTATIONTYPE_ID, reportDataSubSource_REPORTSUBSOURCE_ID, REPORTSUBSOURCE_ID, REPORTSEGMENTATIONTYPE_ID)
		SELECT DISTINCT
		  @REPORTSEGMENTATIONTYPEID, REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID, REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID, @REPORTSEGMENTATIONTYPEID
		FROM REPORTDATASUBSOURCE
		JOIN REPORTFIELDGROUP_REPORTDATASUBSOURCE ON REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID = REPORTFIELDGROUP_REPORTDATASUBSOURCE.reportDataSubSource_REPORTSUBSOURCE_ID
		JOIN REPORTFIELD_REPORTFIELDGROUP ON REPORTFIELDGROUP_REPORTDATASUBSOURCE.REPORTFIELDGROUP_REPORTFIELDGROUP_ID = REPORTFIELD_REPORTFIELDGROUP.reportFieldGroup_REPORTFIELDGROUP_ID
		JOIN REPORTFIELD ON REPORTFIELD_REPORTFIELDGROUP.fields_REPORTFIELD_ID = REPORTFIELD.REPORTFIELD_ID
		WHERE COLUMN_NAME = COLUMNNAMEVAR OR PRIMARY_KEYS LIKE CONCAT('%', COLUMNNAMEVAR, '&');
	END IF;
END;
$$

DELIMITER ;

CALL ADDREPORTFIELDS('CONSTITUENT_CONSTITUENT_ID', 'Constituent Segmentation');
CALL ADDREPORTFIELDS('GIFT_GIFT_ID', 'Gift Segmentation');

DROP PROCEDURE ADDREPORTFIELDS;