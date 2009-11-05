DELIMITER $$

DROP PROCEDURE IF EXISTS `INSERTPICKLISTITEMMISSINGDESCRIPTIONFIELDS_UPDATESCRIPT`$$

CREATE PROCEDURE INSERTPICKLISTITEMMISSINGDESCRIPTIONFIELDS_UPDATESCRIPT()
BEGIN
  DECLARE CSR_END INT DEFAULT 0;
  DECLARE VAR_REPORTFIELDGROUPID BIGINT DEFAULT 0;
  DECLARE VAR_REPORTFIELDID VARCHAR(255) DEFAULT '';

  DECLARE CSR_FIELDGROUPS CURSOR FOR
    SELECT DISTINCT REPORTFIELDGROUP_REPORTFIELDGROUP_ID, REPORTFIELD.REPORTFIELD_ID FROM REPORTFIELD_REPORTFIELDGROUP
    JOIN REPORTFIELD ON REPORTFIELD_REPORTFIELDGROUP.REPORTFIELD_ID = REPORTFIELD.REPORTFIELD_ID
    WHERE COLUMN_NAME LIKE 'GETPICKLISTDISPLAYVALUE%';

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET CSR_END = 1;

  IF NOT EXISTS
    (SELECT * FROM VERSIONLOG
    WHERE SCRIPT = 'NAME OF UPDATE SCRIPT')
  THEN
    OPEN CSR_FIELDGROUPS;

    FIELDGROUPS_LOOP: LOOP
      FETCH CSR_FIELDGROUPS INTO VAR_REPORTFIELDGROUPID, VAR_REPORTFIELDID;

      IF CSR_END THEN
        LEAVE FIELDGROUPS_LOOP;
      END IF;

      -- FIX THE DISPLAY_NAME AND ALIAS_NAME TO ADD SHORT DISPLAY NAME
      UPDATE REPORTFIELD
      SET DISPLAY_NAME =  CONCAT(DISPLAY_NAME, ' Short Display Name'),
      ALIAS_NAME = CONCAT(ALIAS_NAME, '_SHORT_DISPLAY_NAME')
      WHERE REPORTFIELD_ID = VAR_REPORTFIELDID
      AND DISPLAY_NAME NOT LIKE '%Short Display Name'
      AND ALIAS_NAME NOT LIKE '%_SHORT_DISPLAY_NAME';

      -- INSERT NEW PICKLISTITEM LONG DISPLAY NAME IF IT DOES NOT EXIST
      IF NOT EXISTS (SELECT * FROM REPORTFIELD
                      WHERE REPORTFIELD_ID IN (SELECT FIELDS_REPORTFIELD_ID FROM REPORTFIELD_REPORTFIELDGROUP
                                                WHERE REPORTFIELD_REPORTFIELDGROUP.REPORTFIELDGROUP_REPORTFIELDGROUP_ID = 59)
                      AND COLUMN_NAME LIKE '%GETPICKLISTLONGDESCRIPTION%'
                      AND COLUMN_NAME LIKE CONCAT('%',(SELECT SUBSTRING(REPLACE(COLUMN_NAME, 'GETPICKLISTDISPLAYVALUE(''', ''), 1, LOCATE('''', REPLACE(COLUMN_NAME, 'GETPICKLISTDISPLAYVALUE(''', '')) - 1) FROM REPORTFIELD WHERE REPORTFIELD_ID = VAR_REPORTFIELDID), '%')
                    )
      THEN
        INSERT INTO REPORTFIELD (AVERAGE, CAN_BE_SUMMARIZED, COLUMN_NAME, ALIAS_NAME, DISPLAY_NAME, IS_DEFAULT, IS_SUMMARIZED, LARGEST_VALUE, PERFORMSUMMARY, IS_SELECTED, SMALLEST_VALUE, FIELD_TYPE, RECORD_COUNT, PRIMARY_KEYS)
        SELECT AVERAGE, CAN_BE_SUMMARIZED, REPLACE(COLUMN_NAME, 'GETPICKLISTDISPLAYVALUE', 'GETPICKLISTLONGDESCRIPTION'), REPLACE(ALIAS_NAME, '_SHORT_DISPLAY_NAME', '_LONG_DISPLAY_NAME'), REPLACE(DISPLAY_NAME, 'Short Display Name', 'Long Display Name'), IS_DEFAULT, IS_SUMMARIZED, LARGEST_VALUE, PERFORMSUMMARY, IS_SELECTED, SMALLEST_VALUE, FIELD_TYPE, RECORD_COUNT, PRIMARY_KEYS
        FROM REPORTFIELD
        WHERE REPORTFIELD_ID = VAR_REPORTFIELDID;
        -- GET INSERTED REPORTFIELDID
        SET @REPORTFIELD_ID = LAST_INSERT_ID();
        -- INSERT INTO REPORTFIELD_REPORTFIELDGROUP
        INSERT REPORTFIELD_REPORTFIELDGROUP (FIELDS_REPORTFIELD_ID, REPORTFIELDGROUP_ID, REPORTFIELDGROUP_REPORTFIELDGROUP_ID, REPORTFIELD_ID) VALUES (@REPORTFIELD_ID, VAR_REPORTFIELDGROUPID, VAR_REPORTFIELDGROUPID ,@REPORTFIELD_ID);


      END IF;


      -- INSERT NEW PICKLISTITEM DETAIL/DESCRIPTION IF IT DOES NOT EXIST

      IF NOT EXISTS (SELECT * FROM REPORTFIELD
                      WHERE REPORTFIELD_ID IN (SELECT FIELDS_REPORTFIELD_ID FROM REPORTFIELD_REPORTFIELDGROUP
                                                WHERE REPORTFIELD_REPORTFIELDGROUP.REPORTFIELDGROUP_REPORTFIELDGROUP_ID = 59)
                      AND COLUMN_NAME LIKE '%GETPICKLISTDETAIL%'
                      AND COLUMN_NAME LIKE CONCAT('%',(SELECT SUBSTRING(REPLACE(COLUMN_NAME, 'GETPICKLISTDISPLAYVALUE(''', ''), 1, LOCATE('''', REPLACE(COLUMN_NAME, 'GETPICKLISTDISPLAYVALUE(''', '')) - 1) FROM REPORTFIELD WHERE REPORTFIELD_ID = VAR_REPORTFIELDID), '%')
                    )
      THEN
        INSERT INTO REPORTFIELD (AVERAGE, CAN_BE_SUMMARIZED, COLUMN_NAME, ALIAS_NAME, DISPLAY_NAME, IS_DEFAULT, IS_SUMMARIZED, LARGEST_VALUE, PERFORMSUMMARY, IS_SELECTED, SMALLEST_VALUE, FIELD_TYPE, RECORD_COUNT, PRIMARY_KEYS)
        SELECT AVERAGE, CAN_BE_SUMMARIZED, REPLACE(COLUMN_NAME, 'GETPICKLISTDISPLAYVALUE', 'GETPICKLISTDETAIL'), REPLACE(ALIAS_NAME, '_SHORT_DISPLAY_NAME', '_DESCRIPTION'), REPLACE(DISPLAY_NAME, 'Short Display Name', 'Description'), IS_DEFAULT, IS_SUMMARIZED, LARGEST_VALUE, PERFORMSUMMARY, IS_SELECTED, SMALLEST_VALUE, FIELD_TYPE, RECORD_COUNT, PRIMARY_KEYS
        FROM REPORTFIELD
        WHERE REPORTFIELD_ID = VAR_REPORTFIELDID;
        -- GET INSERTED REPORTFIELDID
        SET @REPORTFIELD_ID = LAST_INSERT_ID();
        -- INSERT INTO REPORTFIELD_REPORTFIELDGROUP
        INSERT REPORTFIELD_REPORTFIELDGROUP (FIELDS_REPORTFIELD_ID, REPORTFIELDGROUP_ID, REPORTFIELDGROUP_REPORTFIELDGROUP_ID, REPORTFIELD_ID) VALUES (@REPORTFIELD_ID, VAR_REPORTFIELDGROUPID, VAR_REPORTFIELDGROUPID ,@REPORTFIELD_ID);

      END IF;

      END LOOP;
    SET CSR_END = 0;
    CLOSE CSR_FIELDGROUPS;
  END IF;
END$$

DELIMITER ;

CALL INSERTPICKLISTITEMMISSINGDESCRIPTIONFIELDS_UPDATESCRIPT();
