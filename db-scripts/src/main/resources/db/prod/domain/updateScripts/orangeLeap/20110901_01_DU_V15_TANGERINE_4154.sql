START TRANSACTION;

UPDATE THEGURU_VIEW
SET SQL_OVERRIDE =
'SELECT
    GROUP_BY_VALUE,
    CASE
        WHEN ATTRIBUTE_NAME_ID IN (''First Gift'', ''Last Gift'', ''Largest Gift'', ''Gift Amount'') THEN ''Hard Gifts''
        WHEN ATTRIBUTE_NAME_ID IN (''First Soft Gift'', ''Last Soft Gift'', ''Largest Soft Gift'', ''Soft Gift Amount'') THEN ''Soft Gifts''
        WHEN ATTRIBUTE_NAME_ID IN (''First Pledge'', ''Last Pledge'', ''Largest Pledge'', ''Projected Pledge Amount'') THEN ''Pledges''
        WHEN ATTRIBUTE_NAME_ID IN (''First Recurring Gift'', ''Last Recurring Gift'', ''Largest Recurring Gift'', ''Projected Recurring Gift Amount'') THEN ''Recurring Gifts''
        WHEN ATTRIBUTE_NAME_ID IN (''First Gift In Kind'', ''Last Gift In Kind'', ''Largest Gift In Kind'', ''Gift In Kind Amount'') THEN ''Gifts In Kind''
        WHEN ATTRIBUTE_NAME_ID IN (''Gift Designation'') THEN ''Designation''
        WHEN ATTRIBUTE_NAME_ID IN (''Gift Motivation'') THEN ''Motivation''
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
    MAX_VALUE,
    GROUP_BY_VALUE_2
FROM ROLLUP_VALUE
JOIN ROLLUP_SERIES ON ROLLUP_SERIES.ROLLUP_SERIES_ID = ROLLUP_VALUE.ROLLUP_SERIES_ID
JOIN ROLLUP_ATTRIBUTE ON ROLLUP_ATTRIBUTE.ROLLUP_ATTRIBUTE_ID = ROLLUP_VALUE.ROLLUP_ATTRIBUTE_ID
;'
WHERE VIEW_NAME = 'VW_V2_GIFTSUMMARIES';

UPDATE THEGURU_VIEW
SET SQL_OVERRIDE =
'SELECT
    GROUP_BY_VALUE,
    CASE
        WHEN ATTRIBUTE_NAME_ID IN (''First Gift'', ''Last Gift'', ''Largest Gift'', ''Gift Amount'') THEN ''Hard Gifts''
        WHEN ATTRIBUTE_NAME_ID IN (''First Soft Gift'', ''Last Soft Gift'', ''Largest Soft Gift'', ''Soft Gift Amount'') THEN ''Soft Gifts''
        WHEN ATTRIBUTE_NAME_ID IN (''First Pledge'', ''Last Pledge'', ''Largest Pledge'', ''Projected Pledge Amount'') THEN ''Pledges''
        WHEN ATTRIBUTE_NAME_ID IN (''First Recurring Gift'', ''Last Recurring Gift'', ''Largest Recurring Gift'', ''Projected Recurring Gift Amount'') THEN ''Recurring Gifts''
        WHEN ATTRIBUTE_NAME_ID IN (''First Gift In Kind'', ''Last Gift In Kind'', ''Largest Gift In Kind'', ''Gift In Kind Amount'') THEN ''Gifts In Kind''
        WHEN ATTRIBUTE_NAME_ID IN (''Gift Designation'') THEN ''Designation''
        WHEN ATTRIBUTE_NAME_ID IN (''Gift Motivation'') THEN ''Motivation''
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
    MAX_VALUE,
    GROUP_BY_VALUE_2
FROM ROLLUP_VALUE
JOIN ROLLUP_SERIES ON ROLLUP_SERIES.ROLLUP_SERIES_ID = ROLLUP_VALUE.ROLLUP_SERIES_ID
JOIN ROLLUP_ATTRIBUTE ON ROLLUP_ATTRIBUTE.ROLLUP_ATTRIBUTE_ID = ROLLUP_VALUE.ROLLUP_ATTRIBUTE_ID
WHERE ATTRIBUTE_NAME_ID NOT IN (''First Soft Gift'', ''Last Soft Gift'', ''Largest Soft Gift'', ''Soft Gift Amount'')
;'
WHERE VIEW_NAME = 'VW_V2_GIFTSUMMARIES_EXCLUDINGSOFTGIFTS';

COMMIT;