
-- ******************* Un-comment out the below line when running this script in mySql Query Browser ***************************************
-- DELIMITER $$

-- Drop old functions
DROP FUNCTION IF EXISTS GETCONSTITUENTCUSTOMFIELD$$
DROP FUNCTION IF EXISTS GETGIFTCUSTOMFIELD$$
DROP FUNCTION IF EXISTS GETDISTROLINECUSTOMFIELD$$
DROP FUNCTION IF EXISTS GETCOMMITMENTCUSTOMFIELD$$

-- Create function to retrieve custom fields
DROP FUNCTION IF EXISTS GETCUSTOMFIELD$$

CREATE FUNCTION `GETCUSTOMFIELD`(ENTITYID INT, ENTITYTYPE VARCHAR(255), FIELDNAME VARCHAR(255))
	RETURNS VARCHAR(255)
BEGIN
	DECLARE FIELDVALUE VARCHAR(255);

	SELECT FIELD_VALUE INTO FIELDVALUE
		FROM CUSTOM_FIELD
		WHERE ENTITY_ID = ENTITYID
    AND ENTITY_TYPE = ENTITYTYPE
		AND FIELD_NAME = FIELDNAME;

	RETURN FIELDVALUE;
END$$


DROP FUNCTION IF EXISTS `GETCUSTOMFIELDCONCATENATED` $$
CREATE FUNCTION `GETCUSTOMFIELDCONCATENATED`(ENTITYID INT, ENTITYTYPE VARCHAR(255), FIELDNAME VARCHAR(255))
	RETURNS VARCHAR(255)
BEGIN
	DECLARE FIELDVALUE VARCHAR(255);

  SELECT GROUP_CONCAT(DISTINCT FIELD_VALUE SEPARATOR ', ')
  INTO FIELDVALUE
  FROM CUSTOM_FIELD
	WHERE ENTITY_ID = ENTITYID
  AND ENTITY_TYPE = ENTITYTYPE
	AND FIELD_NAME = FIELDNAME
  GROUP BY FIELD_NAME
  ORDER BY FIELD_VALUE;

  RETURN FIELDVALUE;
END$$


DROP FUNCTION IF EXISTS `GETCUSTOMFIELDDISPLAYVALUECONCATENATED` $$
CREATE FUNCTION `GETCUSTOMFIELDDISPLAYVALUECONCATENATED`(ENTITYID INT, ENTITYTYPE VARCHAR(255), FIELDNAME VARCHAR(255), PICKLISTITEMNAME VARCHAR(255))
	RETURNS VARCHAR(8000)
BEGIN
	DECLARE FIELDVALUE VARCHAR(8000);

  SELECT GROUP_CONCAT(DISTINCT GETPICKLISTDISPLAYVALUE(PICKLISTITEMNAME, FIELD_VALUE) SEPARATOR ', ')
  INTO FIELDVALUE
  FROM CUSTOM_FIELD
	WHERE ENTITY_ID = ENTITYID
  AND ENTITY_TYPE = ENTITYTYPE
	AND FIELD_NAME = FIELDNAME
  GROUP BY FIELD_NAME
  ORDER BY GETPICKLISTDISPLAYVALUE(PICKLISTITEMNAME, FIELD_VALUE);

	RETURN FIELDVALUE;
END$$


DROP FUNCTION IF EXISTS `GETCONSTITUENTDISPLAYNAME` $$
CREATE FUNCTION GETCONSTITUENTDISPLAYNAME(CONSTITUENTID BIGINT)
RETURNS VARCHAR(510)
DETERMINISTIC
BEGIN
	DECLARE RESULT VARCHAR(510);

	SELECT CASE WHEN CONSTITUENT_TYPE = 'individual' THEN CONCAT_WS(', ', LAST_NAME, FIRST_NAME) WHEN CONSTITUENT_TYPE = 'organization' THEN ORGANIZATION_NAME ELSE CONSTITUENT_ID END
	INTO RESULT
	FROM CONSTITUENT
	WHERE CONSTITUENT_ID = CONSTITUENTID;

	RETURN(RESULT);	-- return
END$$


DROP FUNCTION IF EXISTS `GETCONSTITUENTACCOUNTNUMBER` $$
CREATE FUNCTION GETCONSTITUENTACCOUNTNUMBER(CONSTITUENTID BIGINT)
RETURNS BIGINT
DETERMINISTIC
BEGIN
	DECLARE RESULT BIGINT;

	SELECT ACCOUNT_NUMBER
	INTO RESULT
	FROM CONSTITUENT
	WHERE CONSTITUENT_ID = CONSTITUENTID;

	RETURN(RESULT);	-- return
END$$

DROP FUNCTION IF EXISTS `GETCONSTITUENTDISPLAYNAMES`$$
CREATE FUNCTION GETCONSTITUENTDISPLAYNAMES(str TEXT, delim VARCHAR(124))
RETURNS TEXT
DETERMINISTIC
BEGIN
	DECLARE i INT DEFAULT 0;	-- total number of delimiters
	DECLARE ctr INT DEFAULT 0;	-- counter for the loop
	DECLARE str_len INT;		-- string length,self explanatory
	DECLARE out_str text DEFAULT '';	-- return string holder
	DECLARE temp_str text DEFAULT '';	-- temporary string holder
	DECLARE temp_val VARCHAR(255) DEFAULT '';	-- temporary string holder for query

	-- get length
	SET str_len=LENGTH(str);

	IF (str_len > 0) THEN
		SET i = (LENGTH(str)-LENGTH(REPLACE(str, delim, '')))/LENGTH(delim) + 1;
		-- get total number delimeters and add 1
		-- add 1 since total separated values are 1 more than the number of delimiters

		-- start of while loop
		WHILE(ctr<i) DO
			-- add 1 to the counter, which will also be used to get the value of the string
			SET ctr=ctr+1;

			-- get value separated by delimiter using ctr as the index
			SET temp_str = REPLACE(SUBSTRING(SUBSTRING_INDEX(str, delim, ctr), LENGTH(SUBSTRING_INDEX(str, delim,ctr - 1)) + 1), delim, '');

			-- query real value and insert into temporary value holder, temp_str contains the exploded ID
			SELECT GETCONSTITUENTDISPLAYNAME(temp_str) INTO temp_val;

			-- concat real value into output string separated by delimiter
			SET out_str=CONCAT(out_str, temp_val, '; ');
		END WHILE;
		-- end of while loop
	END IF;

	-- trim delimiter from end of string
	SET out_str=TRIM(TRAILING delim FROM out_str);
	RETURN(out_str);	-- return

END$$


DROP FUNCTION IF EXISTS `GETCUSTOMRELATIONSHIPNAMESCONCATENATED` $$
CREATE FUNCTION `GETCUSTOMRELATIONSHIPNAMESCONCATENATED`(ENTITYID INT, ENTITYTYPE VARCHAR(255), FIELDNAME VARCHAR(255))
	RETURNS VARCHAR(8000)
BEGIN
	DECLARE FIELDVALUE VARCHAR(8000);

  SELECT GROUP_CONCAT(DISTINCT GETCONSTITUENTDISPLAYNAME(FIELD_VALUE) SEPARATOR '; ')
  INTO FIELDVALUE
  FROM CUSTOM_FIELD
	WHERE ENTITY_ID = ENTITYID
  AND ENTITY_TYPE = ENTITYTYPE
	AND FIELD_NAME = FIELDNAME
  GROUP BY FIELD_NAME
  ORDER BY GETCONSTITUENTDISPLAYNAME(FIELD_VALUE);

	RETURN FIELDVALUE;
END$$


DROP FUNCTION IF EXISTS `COUNTOFVALUES` $$
CREATE FUNCTION COUNTOFVALUES(FIELDVALUE TEXT, DELIM VARCHAR(124))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE i INT DEFAULT 0;	-- total number of delimiters
	IF LENGTH(FIELDVALUE) <> 0 THEN
		SET i = (LENGTH(FIELDVALUE)-LENGTH(REPLACE(FIELDVALUE, DELIM, '')))/LENGTH(DELIM) + 1;
	END IF;
	RETURN(i);	-- return
END$$


DROP FUNCTION IF EXISTS `GETVALUE` $$
CREATE FUNCTION GETVALUE(FIELDVALUE TEXT, DELIM VARCHAR(124), VALUEINDEX INT)
RETURNS TEXT
DETERMINISTIC
BEGIN
	DECLARE TEMP_STR text DEFAULT '';	-- temporary string holder
	-- get value separated by delimiter
	SET TEMP_STR = REPLACE(SUBSTRING(SUBSTRING_INDEX(FIELDVALUE, DELIM, VALUEINDEX), LENGTH(SUBSTRING_INDEX(FIELDVALUE, DELIM, VALUEINDEX - 1)) + 1), DELIM, '');
	RETURN(TEMP_STR);	-- return
END$$


DROP FUNCTION IF EXISTS `SPLITCAMELCASEDSTRING`$$
CREATE FUNCTION SPLITCAMELCASEDSTRING(STRING TEXT)
RETURNS TEXT
DETERMINISTIC
BEGIN
	DECLARE COUNTER INT DEFAULT 0;	-- counter for the loop
	DECLARE STRING_LENGTH INT;		-- string length,self explanatory
	DECLARE RESULT TEXT DEFAULT '';	-- return string holder
	DECLARE TEMP_STRING text DEFAULT '';	-- temporary string holder
	DECLARE NEXT_CHARACTER_UPPER_CASE BIT DEFAULT FALSE;

	-- if the string contains brackets, pull the value from inside them.  Otherwise, pull the string.
	SET STRING = REPLACE(SUBSTRING_INDEX(STRING, '[', -1), ']', '');
	-- get length of string
	SET STRING_LENGTH = LENGTH(STRING);

	-- start of while loop
	WHILE (COUNTER < STRING_LENGTH) DO
		-- add 1 to the counter, which will also be used to get the value of the string
		SET COUNTER = COUNTER + 1;
		SET TEMP_STRING = SUBSTRING(STRING, COUNTER, 1);
	-- upper case the first character
	IF (COUNTER = 1 OR NEXT_CHARACTER_UPPER_CASE) THEN
		SET RESULT = CONCAT(RESULT, UCASE(TEMP_STRING));
		SET NEXT_CHARACTER_UPPER_CASE = FALSE;
	ELSE
		IF ASCII(TEMP_STRING) BETWEEN 65 AND 90 THEN
				-- if the character is upper case then add a space before it
				SET RESULT = CONCAT(RESULT, ' ', TEMP_STRING);
		ELSE
			IF TEMP_STRING = '.' THEN
				SET RESULT = CONCAT(RESULT, ' ');
				SET NEXT_CHARACTER_UPPER_CASE = TRUE;
			ELSE
				-- otherwise just add it to the result
				SET RESULT = CONCAT(RESULT, TEMP_STRING);
			END IF;
		END IF;
	END IF;
	END WHILE;
	-- end of while loop

	RETURN(RESULT);	-- return
END$$


DROP PROCEDURE IF EXISTS `INSERTREPORTFIELD`$$
CREATE PROCEDURE INSERTREPORTFIELD(PRIMARYKEYS VARCHAR(255), COLUMNNAME VARCHAR(255), DISPLAYNAME VARCHAR(255), ISDEFAULT BIT, FIELDTYPE INT, FIELDGROUPID LONG)
BEGIN
	INSERT INTO REPORTFIELD
		(AVERAGE, CAN_BE_SUMMARIZED, COLUMN_NAME, ALIAS_NAME, DISPLAY_NAME, IS_DEFAULT, IS_SUMMARIZED, LARGEST_VALUE, PERFORMSUMMARY, IS_SELECTED, SMALLEST_VALUE, FIELD_TYPE, RECORD_COUNT, PRIMARY_KEYS)
	VALUES
		(b'0', b'0', COLUMNNAME, COLUMNNAME, DISPLAYNAME, ISDEFAULT, b'0', b'0', b'0', b'0', b'0', FIELDTYPE, b'0', PRIMARYKEYS);

	SET @REPORTFIELD_ID = LAST_INSERT_ID();

	INSERT REPORTFIELD_REPORTFIELDGROUP
		(FIELDS_REPORTFIELD_ID, REPORTFIELDGROUP_ID, REPORTFIELDGROUP_REPORTFIELDGROUP_ID, REPORTFIELD_ID)
	VALUES
		(@REPORTFIELD_ID, FIELDGROUPID, FIELDGROUPID ,@REPORTFIELD_ID);
END$$


DROP PROCEDURE IF EXISTS `INSERTREPORTFIELDWITHALIAS`$$
CREATE PROCEDURE INSERTREPORTFIELDWITHALIAS(PRIMARYKEYS VARCHAR(255), ALIASNAME VARCHAR(255), COLUMNNAME VARCHAR(255), DISPLAYNAME VARCHAR(255), ISDEFAULT BIT, FIELDTYPE INT, FIELDGROUPID LONG)
BEGIN
	INSERT INTO REPORTFIELD
		(AVERAGE, CAN_BE_SUMMARIZED, COLUMN_NAME, ALIAS_NAME, DISPLAY_NAME, IS_DEFAULT, IS_SUMMARIZED, LARGEST_VALUE, PERFORMSUMMARY, IS_SELECTED, SMALLEST_VALUE, FIELD_TYPE, RECORD_COUNT, PRIMARY_KEYS)
	VALUES
		(b'0', b'0', COLUMNNAME, ALIASNAME, DISPLAYNAME, ISDEFAULT, b'0', b'0', b'0', b'0', b'0', FIELDTYPE, b'0', PRIMARYKEYS);

	SET @REPORTFIELD_ID = LAST_INSERT_ID();

	INSERT REPORTFIELD_REPORTFIELDGROUP
		(FIELDS_REPORTFIELD_ID, REPORTFIELDGROUP_ID, REPORTFIELDGROUP_REPORTFIELDGROUP_ID, REPORTFIELD_ID)
	VALUES
		(@REPORTFIELD_ID, FIELDGROUPID, FIELDGROUPID ,@REPORTFIELD_ID);
END$$


DROP PROCEDURE IF EXISTS `INSERTREPORTFIELDGROUP`$$
CREATE PROCEDURE INSERTREPORTFIELDGROUP(REPORTFIELDGROUPNAME VARCHAR(255), REPORTSUBSOURCE_ID LONG, OUT REPORTFIELDGROUP_ID LONG)
BEGIN
	INSERT INTO REPORTFIELDGROUP
		(NAME)
	VALUES
		(REPORTFIELDGROUPNAME);

	SET @REPORTFIELDGROUP_ID = LAST_INSERT_ID();

	SET @MAXREPORTSUBSOURCE_ID = (SELECT IFNULL(MAX(REPORTSUBSOURCE_ID),0) + 1 FROM REPORTFIELDGROUP_REPORTDATASUBSOURCE);

	INSERT REPORTFIELDGROUP_REPORTDATASUBSOURCE
		(REPORTFIELDGROUP_REPORTFIELDGROUP_ID, REPORTDATASUBSOURCE_REPORTSUBSOURCE_ID, REPORTSUBSOURCE_ID)
	VALUES
		(@REPORTFIELDGROUP_ID, REPORTSUBSOURCE_ID, @MAXREPORTSUBSOURCE_ID);

	SET REPORTFIELDGROUP_ID = @REPORTFIELDGROUP_ID;
END$$

DROP PROCEDURE IF EXISTS `ASSOCIATECUSTOMFILTERSWITHDATASUBSOURCES`$$
CREATE PROCEDURE ASSOCIATECUSTOMFILTERSWITHDATASUBSOURCES()
BEGIN
	DECLARE CSR_END INT DEFAULT 0;
	DECLARE FIELDNAME VARCHAR(100) DEFAULT '';
	DECLARE CUSTOMFILTERID BIGINT DEFAULT 0;
	DECLARE CUSTOMFILTERDISPLAYTEXT LONGTEXT DEFAULT 0;
	DECLARE SUBSOURCEID BIGINT DEFAULT 0;
	DECLARE MAXCUSTOMFILTERSUBSOURCEID BIGINT DEFAULT 0;

	DECLARE CSR_FIELDNAMES CURSOR FOR
		SELECT DISTINCT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME LIKE 'VW%'
		AND (COLUMN_NAME LIKE '%CONSTITUENT_ID'
			OR COLUMN_NAME = 'GIFT_GIFT_ID'
			OR COLUMN_NAME = 'ADDRESS_TEMPORARY_START_DATE'
			OR COLUMN_NAME = 'EMAIL_TEMPORARY_START_DATE'
			OR COLUMN_NAME = 'PHONE_TEMPORARY_START_DATE');

	DECLARE CSR_CUSTOMFILTERS CURSOR FOR
		SELECT REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT FROM REPORTCUSTOMFILTERDEFINITION
		WHERE SQL_TEXT LIKE CONCAT('%', FIELDNAME, '%');

	DECLARE CSR_SUBSOURCES CURSOR FOR
		SELECT REPORTSUBSOURCE_ID FROM REPORTDATASUBSOURCE
		WHERE VIEW_NAME IN
			(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME LIKE 'VW%' AND COLUMN_NAME = FIELDNAME)
		AND REPORTSUBSOURCE_ID NOT IN
			(SELECT reportDataSubSource_REPORTSUBSOURCE_ID FROM REPORTCUSTOMFILTERDEFINITION_REPORTDATASUBSOURCE
			WHERE reportCustomFilterDefinitions_REPORTCUSTOMFILTERDEFINITION_ID = CUSTOMFILTERID
			OR (SELECT DISPLAY_TEXT FROM REPORTCUSTOMFILTERDEFINITION WHERE REPORTCUSTOMFILTERDEFINITION.REPORTCUSTOMFILTERDEFINITION_ID = reportCustomFilterDefinitions_REPORTCUSTOMFILTERDEFINITION_ID) = CUSTOMFILTERDISPLAYTEXT);

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET CSR_END = 1;

	OPEN CSR_FIELDNAMES;

	FIELDNAMES_LOOP: LOOP
		FETCH CSR_FIELDNAMES INTO FIELDNAME;

		IF CSR_END THEN
			LEAVE FIELDNAMES_LOOP;
		END IF;

		OPEN CSR_CUSTOMFILTERS;
		CUSTOMFILTERS_LOOP: LOOP
			FETCH CSR_CUSTOMFILTERS INTO CUSTOMFILTERID, CUSTOMFILTERDISPLAYTEXT;

			IF CSR_END THEN
				LEAVE CUSTOMFILTERS_LOOP;
			END IF;

			OPEN CSR_SUBSOURCES;

			SUBSOURCES_LOOP: LOOP
				FETCH CSR_SUBSOURCES INTO SUBSOURCEID;

				IF CSR_END THEN
					LEAVE SUBSOURCES_LOOP;
				END IF;

				SET MAXCUSTOMFILTERSUBSOURCEID = (SELECT IFNULL(MAX(REPORTCUSTOMFILTERDEFINITION_ID),0) + 1 FROM REPORTCUSTOMFILTERDEFINITION_REPORTDATASUBSOURCE);
				INSERT REPORTCUSTOMFILTERDEFINITION_REPORTDATASUBSOURCE (reportCustomFilterDefinitions_REPORTCUSTOMFILTERDEFINITION_ID, reportDataSubSource_REPORTSUBSOURCE_ID, REPORTSUBSOURCE_ID, REPORTCUSTOMFILTERDEFINITION_ID) VALUES (CUSTOMFILTERID, SUBSOURCEID, SUBSOURCEID, MAXCUSTOMFILTERSUBSOURCEID);
			END LOOP;
			SET CSR_END = 0;
			CLOSE CSR_SUBSOURCES;
		END LOOP;
		SET CSR_END = 0;
		CLOSE CSR_CUSTOMFILTERS;
	END LOOP;
	SET CSR_END = 0;
	CLOSE CSR_FIELDNAMES;
END$$

DROP FUNCTION IF EXISTS `GETPICKLISTDISPLAYVALUE` $$
CREATE FUNCTION `GETPICKLISTDISPLAYVALUE`(PICKLISTNAME VARCHAR(255), PICKLISTITEMNAME VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
	DECLARE RESULT VARCHAR(255);

  SELECT DEFAULT_DISPLAY_VALUE
  INTO RESULT
  FROM PICKLIST PROJECTCODE_PICKLIST
  LEFT JOIN PICKLIST_ITEM PROJECTCODE_PICKLIST_ITEM ON PROJECTCODE_PICKLIST.PICKLIST_ID = PROJECTCODE_PICKLIST_ITEM.PICKLIST_ID
  WHERE PROJECTCODE_PICKLIST.PICKLIST_NAME = PICKLISTNAME
  AND PROJECTCODE_PICKLIST_ITEM.ITEM_NAME = PICKLISTITEMNAME
  ORDER BY IFNULL(SITE_NAME, '0') DESC LIMIT 0,1;

	RETURN(RESULT);	-- return
END$$

DROP FUNCTION IF EXISTS `GETPICKLISTLONGDESCRIPTION` $$
CREATE FUNCTION `GETPICKLISTLONGDESCRIPTION`(PICKLISTNAME VARCHAR(255), PICKLISTITEMDEFAULTDISPLAYVALUE VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
	DECLARE RESULT VARCHAR(255);

  SELECT LONG_DESCRIPTION
  INTO RESULT
  FROM PICKLIST PROJECTCODE_PICKLIST
  LEFT JOIN PICKLIST_ITEM PROJECTCODE_PICKLIST_ITEM ON PROJECTCODE_PICKLIST.PICKLIST_ID = PROJECTCODE_PICKLIST_ITEM.PICKLIST_ID
  WHERE PROJECTCODE_PICKLIST.PICKLIST_NAME = PICKLISTNAME
  AND PROJECTCODE_PICKLIST_ITEM.DEFAULT_DISPLAY_VALUE = PICKLISTITEMDEFAULTDISPLAYVALUE
  ORDER BY IFNULL(SITE_NAME, '0') DESC LIMIT 0,1;

	RETURN(RESULT);	-- return
END$$

DROP FUNCTION IF EXISTS `GETPICKLISTITEMIDBYDEFAULTDISPLAYVALUE` $$
CREATE FUNCTION `GETPICKLISTITEMIDBYDEFAULTDISPLAYVALUE`(PICKLISTNAME VARCHAR(255), PICKLISTITEMNAME VARCHAR(255))
RETURNS BIGINT
DETERMINISTIC
BEGIN
	DECLARE RESULT BIGINT;

  SELECT PICKLIST_ITEM_ID
  INTO RESULT
  FROM PICKLIST PROJECTCODE_PICKLIST
  LEFT JOIN PICKLIST_ITEM PROJECTCODE_PICKLIST_ITEM ON PROJECTCODE_PICKLIST.PICKLIST_ID = PROJECTCODE_PICKLIST_ITEM.PICKLIST_ID
  WHERE PROJECTCODE_PICKLIST.PICKLIST_NAME = PICKLISTNAME
  AND PROJECTCODE_PICKLIST_ITEM.DEFAULT_DISPLAY_VALUE = PICKLISTITEMNAME
  ORDER BY IFNULL(SITE_NAME, '0') DESC LIMIT 0,1;

	RETURN(RESULT);	-- return
END$$

DROP PROCEDURE IF EXISTS `RENAMEPICKLISTITEMCUSTOMFIELD`$$
CREATE PROCEDURE `RENAMEPICKLISTITEMCUSTOMFIELD`(PICKLISTNAMEID VARCHAR(255), OLDPICKLISTITEMNAME VARCHAR(255), NEWPICKLISTITEMNAME VARCHAR(255))
BEGIN
  UPDATE REPORTFIELD
  SET COLUMN_NAME = REPLACE(COLUMN_NAME, CONCAT('''', OLDPICKLISTITEMNAME, ''''), CONCAT('''', NEWPICKLISTITEMNAME, '''')),
  DISPLAY_NAME = NEWPICKLISTITEMNAME
  WHERE COLUMN_NAME LIKE CONCAT('%GETCUSTOMFIELD(GETPICKLISTITEMIDBYDEFAULTDISPLAYVALUE(''', PICKLISTNAMEID, '''%''picklistItem'',%''', OLDPICKLISTITEMNAME, '''%');
END$$

DROP PROCEDURE IF EXISTS `INSERTCUSTOMFIELDDEFINITION`$$
CREATE PROCEDURE INSERTCUSTOMFIELDDEFINITION(REPORTFIELDGROUPNAME VARCHAR(255), PRIMARYKEY VARCHAR(255), ALIASNAME VARCHAR(255), PICKLISTNAMEID VARCHAR(255), PICKLISTVIEWFIELDNAME VARCHAR(255), CUSTOMFIELDNAME VARCHAR(255), DISPLAYNAME VARCHAR(255))
BEGIN
	DECLARE CSR_END INT DEFAULT 0;
	DECLARE REPORTFIELDGROUPID BIGINT DEFAULT 0;

	DECLARE CSR_FIELDGROUPS CURSOR FOR
    SELECT REPORTFIELDGROUP_ID FROM REPORTFIELDGROUP WHERE NAME = REPORTFIELDGROUPNAME;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET CSR_END = 1;

	OPEN CSR_FIELDGROUPS;

	FIELDGROUPS_LOOP: LOOP
		FETCH CSR_FIELDGROUPS INTO REPORTFIELDGROUPID;

		IF CSR_END THEN
			LEAVE FIELDGROUPS_LOOP;
		END IF;
    CALL INSERTREPORTFIELDWITHALIAS(PRIMARYKEY, ALIASNAME,
      CONCAT('GETCUSTOMFIELD(GETPICKLISTITEMIDBYDEFAULTDISPLAYVALUE(''', PICKLISTNAMEID, ''', ',
             PICKLISTVIEWFIELDNAME, '), ''picklistItem'', ''', CUSTOMFIELDNAME, ''')'),
      DISPLAYNAME, b'0', 1, REPORTFIELDGROUPID);
  END LOOP;
	SET CSR_END = 0;
	CLOSE CSR_FIELDGROUPS;

END$$


DROP PROCEDURE IF EXISTS `INSERTPROJECTCODECUSTOMFIELDDEFINITION`$$
CREATE PROCEDURE INSERTPROJECTCODECUSTOMFIELDDEFINITION(CUSTOMFIELDNAME VARCHAR(255))
BEGIN
  CALL INSERTCUSTOMFIELDDEFINITION('Gift Distribution', 'DISTRO_LINE_DISTRO_LINE_ID', CONCAT('DISTRO_LINE_PROJECT_CODE_', REPLACE(CUSTOMFIELDNAME, ' ', '_')), 'projectCode', 'DISTRO_LINE_PROJECT_CODE', CUSTOMFIELDNAME, CONCAT('Designation ', CUSTOMFIELDNAME));
  CALL INSERTCUSTOMFIELDDEFINITION('Gift In Kind Details', 'GIFT_IN_KIND_DETAIL_GIK_DETAIL_ID', CONCAT('GIFT_IN_KIND_DETAIL_PROJECT_CODE_', REPLACE(CUSTOMFIELDNAME, ' ', '_')), 'projectCode', 'GIFT_IN_KIND_DETAIL_PROJECT_CODE', CUSTOMFIELDNAME, CONCAT('Designation ', CUSTOMFIELDNAME));
END$$
