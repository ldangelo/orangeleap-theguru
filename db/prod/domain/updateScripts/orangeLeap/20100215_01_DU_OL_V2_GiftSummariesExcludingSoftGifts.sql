UPDATE THEGURU_VIEW_JOIN
SET JOIN_TYPE = 'INNER'
WHERE JOIN_TABLE = 'VW_V2_GIFTSUMMARIES'
AND JOIN_TYPE = 'LEFT';



SET @REPORTDATASUBSOURCEGROUP_ID =
    (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP
    JOIN REPORTDATASOURCE ON REPORTSOURCE_ID = reportDataSource_REPORTSOURCE_ID
    WHERE REPORT_NAME = 'Orange Leap - V2'
    AND DISPLAY_NAME = 'Constituents & Transactions');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME, SEGMENTATION_RESULTS_DATASOURCE_NAME)
VALUES
	('Constituents & Gift Summaries (Excluding Soft Gifts)', 0, 'VW_V2_CONSTITUENTS_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS', '/datasources/ReportWizardJdbcDSSegmentationResults');

SET @VIEW_ID = LAST_INSERT_ID();

-- Tie Constituents & Gift Summaries to the appropriate segmentation type and custom filters
INSERT REPORTCUSTOMFILTERDEFINITION_REPORTDATASUBSOURCE
SELECT REPORTCUSTOMFILTERDEFINITION_ID, @VIEW_ID, @VIEW_ID, REPORTCUSTOMFILTERDEFINITION_ID + @VIEW_ID
FROM REPORTCUSTOMFILTERDEFINITION WHERE SQL_TEXT LIKE '%[VIEWNAME].CONSTITUENT_CONSTITUENT_ID%';

INSERT REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE
SELECT REPORTSEGMENTATIONTYPE_ID, @VIEW_ID, @VIEW_ID, REPORTSEGMENTATIONTYPE_ID
FROM REPORTSEGMENTATIONTYPE WHERE COLUMN_NAME = 'CONSTITUENT_CONSTITUENT_ID';


INSERT THEGURU_VIEW
	(VIEW_NAME, VIEW_DISPLAY_TEXT, PRIMARY_TABLE, PRIMARY_TABLE_IS_VIEW, PRIMARY_TABLE_ALIAS, PRIMARY_TABLE_COLUMN_PREFIX, INCLUDE_ALL_FIELDS, SORT_ORDER, DEFAULT_PAGE_TYPE, SQL_OVERRIDE)
SELECT
	'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', 'Gift Summaries', 'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', FALSE, 'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', '', TRUE, 358, '',
'SELECT
    GROUP_BY_VALUE,
    CASE
        WHEN ATTRIBUTE_NAME_ID IN (''First Gift'', ''Last Gift'', ''Largest Gift'', ''Gift Amount'') THEN ''Hard Gifts''
        WHEN ATTRIBUTE_NAME_ID IN (''First Soft Gift'', ''Last Soft Gift'', ''Largest Soft Gift'', ''Soft Gift Amount'') THEN ''Soft Gifts''
        WHEN ATTRIBUTE_NAME_ID IN (''First Pledge'', ''Last Pledge'', ''Largest Pledge'', ''Projected Pledge Amount'') THEN ''Pledges''
        WHEN ATTRIBUTE_NAME_ID IN (''First Recurring Gift'', ''Last Recurring Gift'', ''Largest Recurring Gift'', ''Projected Recurring Gift Amount'') THEN ''Recurring Gifts''
        WHEN ATTRIBUTE_NAME_ID IN (''First Gift In Kind'', ''Last Gift In Kind'', ''Largest Gift In Kind'', ''Gift In Kind Amount'') THEN ''Gifts In Kind''
        WHEN ATTRIBUTE_NAME_ID IN (''All Actuals'', ''All Projected'') THEN ''Overall''
    END AS CATEGORY,
    ATTRIBUTE_DESC,
    SERIES_DESC,
    START_DATE,
    END_DATE,
    CURRENCY_CODE,
    COUNT_VALUE,
    SUM_VALUE,
    ROUND(SUM_VALUE / COUNT_VALUE, 2) AS AVERAGE_VALUE,
    MIN_VALUE,
    MAX_VALUE
FROM ROLLUP_VALUE
JOIN ROLLUP_SERIES ON ROLLUP_SERIES.ROLLUP_SERIES_ID = ROLLUP_VALUE.ROLLUP_SERIES_ID
JOIN ROLLUP_ATTRIBUTE ON ROLLUP_ATTRIBUTE.ROLLUP_ATTRIBUTE_ID = ROLLUP_VALUE.ROLLUP_ATTRIBUTE_ID

UNION

-- Hard Gift - First Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Hard Gifts'' AS CATEGORY, ''First Gift'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    DONATION_DATE AS START_DATE, DONATION_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, ADJUSTED_AMOUNT AS SUM_VALUE,
    ADJUSTED_AMOUNT AS AVERAGE_VALUE, ADJUSTED_AMOUNT AS MIN_VALUE, ADJUSTED_AMOUNT AS MAX_VALUE
FROM GIFT
WHERE GIFT_ID = (SELECT GIFT_ID FROM GIFT B WHERE B.CONSTITUENT_ID = GIFT.CONSTITUENT_ID ORDER BY DONATION_DATE ASC, TRANSACTION_DATE ASC LIMIT 1)

UNION

-- Hard Gift - Last Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Hard Gifts'' AS CATEGORY, ''Last Gift'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    DONATION_DATE AS START_DATE, DONATION_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, ADJUSTED_AMOUNT AS SUM_VALUE,
    ADJUSTED_AMOUNT AS AVERAGE_VALUE, ADJUSTED_AMOUNT AS MIN_VALUE, ADJUSTED_AMOUNT AS MAX_VALUE
FROM GIFT
WHERE GIFT_ID = (SELECT GIFT_ID FROM GIFT B WHERE B.CONSTITUENT_ID = GIFT.CONSTITUENT_ID ORDER BY DONATION_DATE DESC, TRANSACTION_DATE DESC LIMIT 1)

UNION

-- Hard Gift - Largest Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Hard Gifts'' AS CATEGORY, ''Largest Gift'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    DONATION_DATE AS START_DATE, DONATION_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, ADJUSTED_AMOUNT AS SUM_VALUE,
    ADJUSTED_AMOUNT AS AVERAGE_VALUE, ADJUSTED_AMOUNT AS MIN_VALUE, ADJUSTED_AMOUNT AS MAX_VALUE
FROM GIFT
WHERE GIFT_ID = (SELECT GIFT_ID FROM GIFT B WHERE B.CONSTITUENT_ID = GIFT.CONSTITUENT_ID ORDER BY ADJUSTED_AMOUNT DESC, TRANSACTION_DATE ASC LIMIT 1)

UNION

-- Pledges - First Pledge
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Pledges'' AS CATEGORY, ''First Pledge'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    PLEDGE_DATE AS START_DATE, PLEDGE_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, AMOUNT_TOTAL AS SUM_VALUE,
    AMOUNT_TOTAL AS AVERAGE_VALUE, AMOUNT_TOTAL AS MIN_VALUE, AMOUNT_TOTAL AS MAX_VALUE
FROM PLEDGE
WHERE PLEDGE_ID = (SELECT B.PLEDGE_ID FROM PLEDGE B WHERE B.CONSTITUENT_ID = PLEDGE.CONSTITUENT_ID ORDER BY B.PLEDGE_DATE ASC, B.CREATE_DATE ASC LIMIT 1)

UNION

-- Pledges - Last Pledge
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Pledges'' AS CATEGORY, ''Last Pledge'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    PLEDGE_DATE AS START_DATE, PLEDGE_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, AMOUNT_TOTAL AS SUM_VALUE,
    AMOUNT_TOTAL AS AVERAGE_VALUE, AMOUNT_TOTAL AS MIN_VALUE, AMOUNT_TOTAL AS MAX_VALUE
FROM PLEDGE
WHERE PLEDGE_ID = (SELECT B.PLEDGE_ID FROM PLEDGE B WHERE B.CONSTITUENT_ID = PLEDGE.CONSTITUENT_ID ORDER BY B.PLEDGE_DATE DESC, B.CREATE_DATE DESC LIMIT 1)

UNION

-- Pledges - Largest Pledge
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Pledges'' AS CATEGORY, ''Largest Pledge'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    PLEDGE_DATE AS START_DATE, PLEDGE_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, GREATEST(PLEDGE.AMOUNT_PAID, PLEDGE.AMOUNT_TOTAL) AS SUM_VALUE,
    GREATEST(PLEDGE.AMOUNT_PAID, PLEDGE.AMOUNT_TOTAL) AS AVERAGE_VALUE, GREATEST(PLEDGE.AMOUNT_PAID, PLEDGE.AMOUNT_TOTAL) AS MIN_VALUE, GREATEST(PLEDGE.AMOUNT_PAID, PLEDGE.AMOUNT_TOTAL) AS MAX_VALUE
FROM PLEDGE
WHERE PLEDGE_ID = (SELECT B.PLEDGE_ID FROM PLEDGE B WHERE B.CONSTITUENT_ID = PLEDGE.CONSTITUENT_ID ORDER BY GREATEST(B.AMOUNT_PAID, B.AMOUNT_TOTAL) DESC LIMIT 1)

UNION

-- Recurring Gifts - First Recurring Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Recurring Gifts'' AS CATEGORY, ''First Recurring Gift'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    START_DATE AS START_DATE, END_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, AMOUNT_TOTAL AS SUM_VALUE,
    AMOUNT_TOTAL AS AVERAGE_VALUE, AMOUNT_TOTAL AS MIN_VALUE, AMOUNT_TOTAL AS MAX_VALUE
FROM RECURRING_GIFT
WHERE RECURRING_GIFT_ID = (SELECT B.RECURRING_GIFT_ID FROM RECURRING_GIFT B WHERE B.CONSTITUENT_ID = RECURRING_GIFT.CONSTITUENT_ID ORDER BY B.START_DATE ASC, B.CREATE_DATE ASC LIMIT 1)

UNION

-- Recurring Gifts - Last Recurring Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Recurring Gifts'' AS CATEGORY, ''Last Recurring Gift'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    START_DATE AS START_DATE, END_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, AMOUNT_TOTAL AS SUM_VALUE,
    AMOUNT_TOTAL AS AVERAGE_VALUE, AMOUNT_TOTAL AS MIN_VALUE, AMOUNT_TOTAL AS MAX_VALUE
FROM RECURRING_GIFT
WHERE RECURRING_GIFT_ID = (SELECT B.RECURRING_GIFT_ID FROM RECURRING_GIFT B WHERE B.CONSTITUENT_ID = RECURRING_GIFT.CONSTITUENT_ID ORDER BY B.START_DATE DESC, B.CREATE_DATE DESC LIMIT 1)

UNION

-- Recurring Gifts - Largest Recurring Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Recurring Gifts'' AS CATEGORY, ''Largest Recurring Gift'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    START_DATE AS START_DATE, END_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, AMOUNT_TOTAL AS SUM_VALUE,
    AMOUNT_TOTAL AS AVERAGE_VALUE, AMOUNT_TOTAL AS MIN_VALUE, AMOUNT_TOTAL AS MAX_VALUE
FROM RECURRING_GIFT
WHERE RECURRING_GIFT_ID = (SELECT B.RECURRING_GIFT_ID FROM RECURRING_GIFT B WHERE B.CONSTITUENT_ID = RECURRING_GIFT.CONSTITUENT_ID ORDER BY AMOUNT_TOTAL DESC LIMIT 1)

UNION

-- Gift In Kind - First Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Gifts In Kind'' AS CATEGORY, ''First Gift In Kind'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    DONATION_DATE AS START_DATE, DONATION_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, FAIR_MARKET_VALUE AS SUM_VALUE,
    FAIR_MARKET_VALUE AS AVERAGE_VALUE, FAIR_MARKET_VALUE AS MIN_VALUE, FAIR_MARKET_VALUE AS MAX_VALUE
FROM GIFT_IN_KIND
WHERE GIFT_ID = (SELECT GIFT_ID FROM GIFT_IN_KIND B WHERE B.CONSTITUENT_ID = GIFT_IN_KIND.CONSTITUENT_ID ORDER BY DONATION_DATE ASC, TRANSACTION_DATE ASC LIMIT 1)

UNION

-- Gift In Kind - Last Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Gifts In Kind'' AS CATEGORY, ''Last Gift In Kind'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    DONATION_DATE AS START_DATE, DONATION_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, FAIR_MARKET_VALUE AS SUM_VALUE,
    FAIR_MARKET_VALUE AS AVERAGE_VALUE, FAIR_MARKET_VALUE AS MIN_VALUE, FAIR_MARKET_VALUE AS MAX_VALUE
FROM GIFT_IN_KIND
WHERE GIFT_ID = (SELECT GIFT_ID FROM GIFT_IN_KIND B WHERE B.CONSTITUENT_ID = GIFT_IN_KIND.CONSTITUENT_ID ORDER BY DONATION_DATE DESC, TRANSACTION_DATE DESC LIMIT 1)

UNION

-- Gift In Kind - Large Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Gifts In Kind'' AS CATEGORY, ''Large Gift In Kind'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    DONATION_DATE AS START_DATE, DONATION_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, FAIR_MARKET_VALUE AS SUM_VALUE,
    FAIR_MARKET_VALUE AS AVERAGE_VALUE, FAIR_MARKET_VALUE AS MIN_VALUE, FAIR_MARKET_VALUE AS MAX_VALUE
FROM GIFT_IN_KIND
WHERE GIFT_ID = (SELECT GIFT_ID FROM GIFT_IN_KIND B WHERE B.CONSTITUENT_ID = GIFT_IN_KIND.CONSTITUENT_ID ORDER BY FAIR_MARKET_VALUE DESC, TRANSACTION_DATE ASC LIMIT 1)';



INSERT THEGURU_VIEW
	(VIEW_NAME, VIEW_DISPLAY_TEXT, PRIMARY_TABLE, PRIMARY_TABLE_IS_VIEW, PRIMARY_TABLE_ALIAS, PRIMARY_TABLE_COLUMN_PREFIX, INCLUDE_ALL_FIELDS, SORT_ORDER, DEFAULT_PAGE_TYPE)
SELECT
	'VW_V2_CONSTITUENTS_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', 'Constituents & Gift Summaries', 'VW_V2_CONSTITUENTS', TRUE, 'VW_V2_CONSTITUENTS', '', TRUE, 359, '';

SET @VIEW_ID = LAST_INSERT_ID();

INSERT THEGURU_VIEW_JOIN
    (VIEW_ID, JOIN_TYPE, JOIN_TABLE, JOIN_TABLE_IS_VIEW, JOIN_TABLE_ALIAS, JOIN_TABLE_COLUMN_PREFIX, JOIN_CRITERIA, INCLUDE_ALL_FIELDS, SORT_ORDER, FIELD_GROUP_PREFIX, FIELD_GROUP_OVERRIDE, PARENT_ENTITY_TYPE, SUB_FIELD_NAME)
SELECT
	@VIEW_ID, 'INNER', 'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', TRUE, 'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', 'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS_', 'VW_V2_CONSTITUENTS.CONSTITUENT_CONSTITUENT_ID = VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS.GROUP_BY_VALUE', TRUE, 1, '', '', '', '';


INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', 'Gift Summary Information', 'Account Number', 'GETCONSTITUENTACCOUNTNUMBER(${COLUMN_PREFIX}GROUP_BY_VALUE)', 'ACCOUNT_NUMBER', 2;

INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', 'Gift Summary Information', 'Account Name', 'GETCONSTITUENTDISPLAYNAME(${COLUMN_PREFIX}GROUP_BY_VALUE)', 'ACCOUNT_NAME', 1;


INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', 'Gift Summary Information', 'Category', '${COLUMN_PREFIX}CATEGORY', 'CATEGORY', 1;

INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', 'Gift Summary Information', 'Statistic', '${COLUMN_PREFIX}ATTRIBUTE_DESC', 'ATTRIBUTE_DESC', 1;

INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', 'Gift Summary Information', 'Time Period', '${COLUMN_PREFIX}ATTRIBUTE_DESC', 'SERIES_DESC', 1;

INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', 'Gift Summary Information', 'Start Date', '${COLUMN_PREFIX}START_DATE', 'START_DATE', 4;

INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', 'Gift Summary Information', 'End Date', '${COLUMN_PREFIX}END_DATE', 'END_DATE', 4;

INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', 'Gift Summary Information', 'Currency', '${COLUMN_PREFIX}CURRENCY_CODE', 'CURRENCY_CODE', 1;

INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', 'Gift Summary Information', 'Count', '${COLUMN_PREFIX}COUNT_VALUE', 'COUNT_VALUE', 2;

INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', 'Gift Summary Information', 'Total', '${COLUMN_PREFIX}SUM_VALUE', 'SUM_VALUE', 5;

INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', 'Gift Summary Information', 'Average', '${COLUMN_PREFIX}AVERAGE_VALUE', 'AVERAGE_VALUE', 5;

INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', 'Gift Summary Information', 'Minimum', '${COLUMN_PREFIX}MIN_VALUE', 'MIN_VALUE', 5;

INSERT THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
    (TABLE_NAME, FIELD_GROUP, DISPLAY_NAME, COLUMN_NAME, ALIAS_NAME, FIELD_TYPE)
SELECT
    'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS', 'Gift Summary Information', 'Maximum', '${COLUMN_PREFIX}MAX_VALUE', 'MAX_VALUE', 5;
