DELIMITER $$

DROP PROCEDURE IF EXISTS GENERATE_FIELD_DEFINITIONS$$

CREATE PROCEDURE GENERATE_FIELD_DEFINITIONS(VIEWNAME VARCHAR(255))
BEGIN
	DECLARE CSR_END INT DEFAULT 0;
	DECLARE VAR_VIEW_DROP_TEXT VARCHAR(1000);
	DECLARE VAR_VIEW_SELECT_TEXT VARCHAR(8000);
	DECLARE VAR_VIEW_FROM_TEXT VARCHAR(8000);
	DECLARE VAR_TABLE_NAME VARCHAR(255);
	DECLARE VAR_FIRST_FIELD BIT;
	DECLARE VAR_NEW_LINE VARCHAR(10);
	DECLARE VAR_TAB VARCHAR(10);

	-- THEGURU_VIEW Variables
	DECLARE VAR_VIEW_ID INTEGER;
	DECLARE VAR_VIEW_NAME VARCHAR(255);
	DECLARE VAR_VIEW_DISPLAY_TEXT VARCHAR(255);
	DECLARE VAR_PRIMARY_TABLE VARCHAR(255);
	DECLARE VAR_PRIMARY_TABLE_IS_VIEW BIT;
	DECLARE VAR_PRIMARY_TABLE_ALIAS VARCHAR(255);
	DECLARE VAR_PRIMARY_TABLE_COLUMN_PREFIX VARCHAR(255);
	DECLARE VAR_PRIMARY_TABLE_FIELD_GROUP_PREFIX VARCHAR(255);
	DECLARE VAR_PRIMARY_TABLE_FIELD_GROUP_OVERRIDE VARCHAR(255);
	DECLARE VAR_PRIMARY_TABLE_PARENT_ENTITY_TYPE VARCHAR(255);
	DECLARE VAR_PRIMARY_TABLE_SUB_FIELD_NAME VARCHAR(255);
    DECLARE VAR_PRIMARY_TABLE_DEFAULT_PAGE_TYPE VARCHAR(255);

	-- INFORMATION_SCHEMA.COLUMNS Variables
	DECLARE VAR_FIELD_NAME VARCHAR(255);
	DECLARE VAR_FIELD_TYPE VARCHAR(255);

	-- DATASUBSOURCE Variables
	DECLARE VAR_REPORTSUBSOURCE_ID INT;
	DECLARE VAR_DATASUBSOURCE_VIEW_NAME VARCHAR(255);

	DECLARE CSR_VIEWS CURSOR FOR
		SELECT
			VIEW_ID, VIEW_NAME, VIEW_DISPLAY_TEXT, PRIMARY_TABLE, PRIMARY_TABLE_IS_VIEW, PRIMARY_TABLE_ALIAS, PRIMARY_TABLE_COLUMN_PREFIX, FIELD_GROUP_PREFIX, FIELD_GROUP_OVERRIDE, PARENT_ENTITY_TYPE, SUB_FIELD_NAME, DEFAULT_PAGE_TYPE
		FROM THEGURU_VIEW
		WHERE VIEW_NAME = VAR_DATASUBSOURCE_VIEW_NAME
		ORDER BY SORT_ORDER;

	DECLARE CSR_DATASUBSOURCES CURSOR FOR
		SELECT REPORTSUBSOURCE_ID, VIEW_NAME
		FROM REPORTDATASUBSOURCE
		WHERE LENGTH(VIEW_NAME) <= 255
    AND (VIEW_NAME = VIEWNAME OR VIEWNAME IS NULL)
;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET CSR_END = 1;

	SET max_sp_recursion_depth=50;
	SET VAR_FIRST_FIELD = TRUE;
	SET VAR_NEW_LINE = '\r\n';
	SET VAR_TAB = '\t';


	DROP TABLE IF EXISTS TEMP_OL_FIELD_DEFINITIONS;
	SET @execString = CONCAT('CREATE TABLE TEMP_OL_FIELD_DEFINITIONS', VAR_NEW_LINE,
		'SELECT', VAR_NEW_LINE,
		'  FIELD_ORDER, FIELD_DEFINITION.FIELD_DEFINITION_ID, SECONDARY_FIELD_DEFINITION_ID, SECTION_DEFINITION.DEFAULT_LABEL AS SECTION_LABEL,', VAR_NEW_LINE,
		'  PAGE_TYPE, SECTION_ORDER, FIELD_DEFINITION.DEFAULT_LABEL AS FIELD_LABEL, ENTITY_TYPE, FIELD_NAME, FIELD_TYPE, REFERENCE_TYPE, VALIDATION_FIELD_TYPE', VAR_NEW_LINE,
		'FROM ', REPLACE(DATABASE(), 'theguru', '.'), 'SECTION_FIELD', VAR_NEW_LINE,
		'JOIN ', REPLACE(DATABASE(), 'theguru', '.'), 'SECTION_DEFINITION ON SECTION_DEFINITION.SECTION_DEFINITION_ID = SECTION_FIELD.SECTION_DEFINITION_ID', VAR_NEW_LINE,
		'JOIN ', REPLACE(DATABASE(), 'theguru', '.'), 'FIELD_DEFINITION ON FIELD_DEFINITION.FIELD_DEFINITION_ID = SECTION_FIELD.FIELD_DEFINITION_ID', VAR_NEW_LINE,
		'LEFT JOIN (SELECT DISTINCT FIELD_DEFINITION_ID, CASE WHEN VALIDATION_REGEX = ''^[0-9]*(\\\\.[0-9][0-9])?$'' THEN ''MONEY'' WHEN VALIDATION_REGEX = ''^[0-9]*$'' THEN ''NUMBER'' ELSE NULL END AS VALIDATION_FIELD_TYPE', VAR_NEW_LINE,
		'FROM ', REPLACE(DATABASE(), 'theguru', '.'), 'FIELD_VALIDATION WHERE VALIDATION_REGEX IN (''^[0-9]*$'', ''^[0-9]*(\\\\.[0-9][0-9])?$'')) AS FIELD_VALIDATION ON FIELD_VALIDATION.FIELD_DEFINITION_ID = FIELD_DEFINITION.FIELD_DEFINITION_ID;');
	PREPARE statement FROM @execString;
	EXECUTE statement;
	DEALLOCATE PREPARE statement;

	DELETE FROM THEGURU_FIELD_DEFINITIONS;

	-- Iterate through the data sub sources
	OPEN CSR_DATASUBSOURCES;
	DATASUBSOURCES_LOOP: LOOP
		FETCH CSR_DATASUBSOURCES INTO
			VAR_REPORTSUBSOURCE_ID, VAR_DATASUBSOURCE_VIEW_NAME;

		IF CSR_END THEN
			LEAVE DATASUBSOURCES_LOOP;
		END IF;

		-- Iterate through the views (should only be 1)
		OPEN CSR_VIEWS;

		VIEWS_LOOP: LOOP
			FETCH CSR_VIEWS INTO
				VAR_VIEW_ID, VAR_VIEW_NAME, VAR_VIEW_DISPLAY_TEXT, VAR_PRIMARY_TABLE, VAR_PRIMARY_TABLE_IS_VIEW, VAR_PRIMARY_TABLE_ALIAS, VAR_PRIMARY_TABLE_COLUMN_PREFIX, VAR_PRIMARY_TABLE_FIELD_GROUP_PREFIX, VAR_PRIMARY_TABLE_FIELD_GROUP_OVERRIDE, VAR_PRIMARY_TABLE_PARENT_ENTITY_TYPE, VAR_PRIMARY_TABLE_SUB_FIELD_NAME, VAR_PRIMARY_TABLE_DEFAULT_PAGE_TYPE;

			IF CSR_END THEN
				LEAVE VIEWS_LOOP;
			END IF;

			CALL GENERATE_FIELD_DEFINITIONS_PROCESS_TABLE(VAR_VIEW_NAME, VAR_VIEW_NAME, TRUE, VAR_PRIMARY_TABLE_COLUMN_PREFIX, VAR_PRIMARY_TABLE_FIELD_GROUP_PREFIX, VAR_PRIMARY_TABLE_FIELD_GROUP_OVERRIDE, VAR_PRIMARY_TABLE_PARENT_ENTITY_TYPE, VAR_PRIMARY_TABLE_SUB_FIELD_NAME, VAR_PRIMARY_TABLE_DEFAULT_PAGE_TYPE, FALSE);

		END LOOP;
		CLOSE CSR_VIEWS;
		SET CSR_END = 0;

	END LOOP;
	CLOSE CSR_DATASUBSOURCES;
	SET CSR_END = 0;

    CALL UPDATE_REPORTFIELD_FIELD_DEFINITIONS();

 	DROP TABLE IF EXISTS TEMP_OL_FIELD_DEFINITIONS;

END;$$