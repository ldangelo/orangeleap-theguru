SET @REPORTDATASUBSOURCEGROUP_ID =
    (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP
    JOIN REPORTDATASOURCE ON REPORTSOURCE_ID = reportDataSource_REPORTSOURCE_ID
    WHERE REPORT_NAME = 'Orange Leap - V2'
    AND DISPLAY_NAME = 'Constituents');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME, SEGMENTATION_RESULTS_DATASOURCE_NAME)
VALUES
	('Constituents & Email Addresses', 0, 'VW_V2_CONSTITUENTS_EMAILS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS', '/datasources/ReportWizardJdbcDSSegmentationResults');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


INSERT THEGURU_VIEW
	(VIEW_NAME, VIEW_DISPLAY_TEXT, PRIMARY_TABLE, PRIMARY_TABLE_IS_VIEW, PRIMARY_TABLE_ALIAS, PRIMARY_TABLE_COLUMN_PREFIX, INCLUDE_ALL_FIELDS, SORT_ORDER)
SELECT
	'VW_V2_CONSTITUENTS_EMAILS', 'Constituents & Email Numbers', 'VW_V2_CONSTITUENTS', TRUE, 'VW_V2_CONSTITUENTS', '', TRUE, 60;

SET @VIEW_ID = LAST_INSERT_ID();


INSERT THEGURU_VIEW_JOIN
	(VIEW_ID, JOIN_TYPE, JOIN_TABLE, JOIN_TABLE_IS_VIEW, JOIN_TABLE_ALIAS, JOIN_TABLE_COLUMN_PREFIX, JOIN_CRITERIA, INCLUDE_ALL_FIELDS, SORT_ORDER, FIELD_GROUP_PREFIX)
SELECT
	@VIEW_ID, 'LEFT', 'EMAIL', FALSE, 'EMAIL', 'EMAIL_', 'VW_V2_CONSTITUENTS.CONSTITUENT_CONSTITUENT_ID = EMAIL.CONSTITUENT_ID', TRUE, 1, '';

INSERT THEGURU_VIEW_JOIN
	(VIEW_ID, JOIN_TYPE, JOIN_TABLE, JOIN_TABLE_IS_VIEW, JOIN_TABLE_ALIAS, JOIN_TABLE_COLUMN_PREFIX, JOIN_CRITERIA, INCLUDE_ALL_FIELDS, SORT_ORDER)
SELECT
	@VIEW_ID, 'LEFT', 'CUSTOM_FIELD', FALSE, 'EMAIL_TYPE', 'EMAIL_', 'EMAIL_TYPE.ENTITY_TYPE = ''email'' AND EMAIL_TYPE.ENTITY_ID = EMAIL.EMAIL_ID AND EMAIL_TYPE.FIELD_NAME = ''emailType''', FALSE, 2;

-- Add additional field definitions
INSERT THEGURU_TABLE_ADDITIONAL_FIELD
	(TABLE_NAME, FIELD_TEXT, FIELD_ALIAS)
SELECT
	'EMAIL', 'EMAIL_TYPE.FIELD_VALUE', 'EMAIL_TYPE';


INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'EMAIL', 'Email Information', 'Email ID', '${COLUMN_PREFIX}EMAIL_ID', 'EMAIL_ID', 1;

INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'EMAIL', 'Email Information', 'Email Type', 'GETPICKLISTDISPLAYVALUE(''customFieldMap[emailType]'', ${COLUMN_PREFIX}EMAIL_TYPE)', 'EMAIL_TYPE', 1;


INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'EMAIL', 'Email Information', 'Seasonal Start Date', 'CONCAT(MONTHNAME(${COLUMN_PREFIX}SEASONAL_START_DATE), ''-'', DAY(${COLUMN_PREFIX}SEASONAL_START_DATE))', 'SEASONAL_START_DATE_DISPLAY', 1;

INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'EMAIL', 'Email Information', 'Seasonal End Date', 'CONCAT(MONTHNAME(${COLUMN_PREFIX}SEASONAL_END_DATE), ''-'', DAY(${COLUMN_PREFIX}SEASONAL_END_DATE))', 'SEASONAL_END_DATE_DISPLAY', 1;

INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'EMAIL', 'Email Information', 'Comments', '${COLUMN_PREFIX}COMMENT', 'COMMENT', 1;

INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'EMAIL', 'Email Information', 'Email Create Date', '${COLUMN_PREFIX}CREATE_DATE', 'CREATE_DATE', 4;

INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'EMAIL', 'Email Information', 'Email Update Date', '${COLUMN_PREFIX}UPDATE_DATE', 'UPDATE_DATE', 4;

INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'EMAIL', 'Email Information', 'Primary Email', '${COLUMN_PREFIX}IS_PRIMARY', 'IS_PRIMARY', 6;


INSERT THEGURU_TABLE_FIELD_EXCLUSIONS
	(TABLE_NAME, FIELD_NAME)
SELECT
	'EMAIL', 'customFieldMap[emailType]';

INSERT THEGURU_TABLE_FIELD_EXCLUSIONS
	(TABLE_NAME, FIELD_NAME)
SELECT
	'EMAIL', 'seasonalStartDate';

INSERT THEGURU_TABLE_FIELD_EXCLUSIONS
	(TABLE_NAME, FIELD_NAME)
SELECT
	'EMAIL', 'seasonalEndDate';
