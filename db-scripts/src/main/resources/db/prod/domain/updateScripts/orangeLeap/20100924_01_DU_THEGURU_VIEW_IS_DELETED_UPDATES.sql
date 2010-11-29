UPDATE THEGURU_VIEW
SET WHERE_CLAUSE =
  CASE
    WHEN IFNULL(WHERE_CLAUSE, '') = '' THEN CONCAT(PRIMARY_TABLE_ALIAS, '.IS_DELETED = 0')
    ELSE CONCAT(WHERE_CLAUSE, ' AND ', PRIMARY_TABLE_ALIAS, '.IS_DELETED = 0')
  END
WHERE PRIMARY_TABLE IN
('COMMUNICATION_HISTORY',
'GIFT',
'GIFT_IN_KIND',
'PLEDGE',
'RECURRING_GIFT')
AND IFNULL(WHERE_CLAUSE, '') NOT LIKE '%IS_DELETED = 0%';

UPDATE THEGURU_VIEW_JOIN
SET JOIN_CRITERIA = 
  CASE
    WHEN IFNULL(JOIN_CRITERIA, '') = '' THEN CONCAT(JOIN_TABLE_ALIAS, '.IS_DELETED = 0')
    ELSE CONCAT(JOIN_CRITERIA, ' AND ', JOIN_TABLE_ALIAS, '.IS_DELETED = 0')
  END
WHERE JOIN_TABLE IN
('COMMUNICATION_HISTORY',
'GIFT',
'GIFT_IN_KIND',
'PLEDGE',
'RECURRING_GIFT')
AND IFNULL(JOIN_CRITERIA, '') NOT LIKE '%IS_DELETED = 0%';

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

UNION

-- Hard Gift - First Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Hard Gifts'' AS CATEGORY, ''First Gift'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    DONATION_DATE AS START_DATE, DONATION_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, ADJUSTED_AMOUNT AS SUM_VALUE,
    ADJUSTED_AMOUNT AS AVERAGE_VALUE, ADJUSTED_AMOUNT AS MIN_VALUE, ADJUSTED_AMOUNT AS MAX_VALUE, NULL AS GROUP_BY_VALUE_2
FROM GIFT
WHERE GIFT_ID = (SELECT GIFT_ID FROM GIFT B WHERE B.CONSTITUENT_ID = GIFT.CONSTITUENT_ID AND B.IS_DELETED = 0 ORDER BY DONATION_DATE ASC, TRANSACTION_DATE ASC LIMIT 1)
AND GIFT.IS_DELETED = 0

UNION

-- Hard Gift - Last Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Hard Gifts'' AS CATEGORY, ''Last Gift'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    DONATION_DATE AS START_DATE, DONATION_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, ADJUSTED_AMOUNT AS SUM_VALUE,
    ADJUSTED_AMOUNT AS AVERAGE_VALUE, ADJUSTED_AMOUNT AS MIN_VALUE, ADJUSTED_AMOUNT AS MAX_VALUE, NULL AS GROUP_BY_VALUE_2
FROM GIFT
WHERE GIFT_ID = (SELECT GIFT_ID FROM GIFT B WHERE B.CONSTITUENT_ID = GIFT.CONSTITUENT_ID AND B.IS_DELETED = 0 ORDER BY DONATION_DATE DESC, TRANSACTION_DATE DESC LIMIT 1)
AND GIFT.IS_DELETED = 0

UNION

-- Hard Gift - Largest Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Hard Gifts'' AS CATEGORY, ''Largest Gift'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    DONATION_DATE AS START_DATE, DONATION_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, ADJUSTED_AMOUNT AS SUM_VALUE,
    ADJUSTED_AMOUNT AS AVERAGE_VALUE, ADJUSTED_AMOUNT AS MIN_VALUE, ADJUSTED_AMOUNT AS MAX_VALUE, NULL AS GROUP_BY_VALUE_2
FROM GIFT
WHERE GIFT_ID = (SELECT GIFT_ID FROM GIFT B WHERE B.CONSTITUENT_ID = GIFT.CONSTITUENT_ID AND B.IS_DELETED = 0 ORDER BY ADJUSTED_AMOUNT DESC, TRANSACTION_DATE ASC LIMIT 1)
AND GIFT.IS_DELETED = 0

UNION

-- Soft Gift - First Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Soft Gifts'' AS CATEGORY, ''First Gift'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    START_DATE, END_DATE, CURRENCY_CODE, COUNT_VALUE, SUM_VALUE, SUM_VALUE AS AVERAGE_VALUE, SUM_VALUE AS MIN_VALUE, SUM_VALUE AS MAX_VALUE, NULL AS GROUP_BY_VALUE_2
FROM VW_V2_GIFTSUMMARIES_SOFTGIFTS AS SOFT_GIFTS
WHERE SOFT_GIFTS.GIFT_ID =
    (SELECT GA.GIFT_ID
    FROM GIFT GA
    JOIN DISTRO_LINE DLA ON DLA.GIFT_ID = GA.GIFT_ID
    JOIN CUSTOM_FIELD CFA ON CFA.ENTITY_ID = DLA.DISTRO_LINE_ID AND CFA.ENTITY_TYPE = ''distributionline'' AND CFA.FIELD_NAME = ''onBehalfOf''
    WHERE CFA.FIELD_VALUE = SOFT_GIFTS.CONSTITUENT_ID
    AND GA.IS_DELETED = 0
    ORDER BY GA.DONATION_DATE ASC, GA.TRANSACTION_DATE ASC LIMIT 1)

UNION

-- Soft Gift - Last Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Soft Gifts'' AS CATEGORY, ''Last Gift'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    START_DATE, END_DATE, CURRENCY_CODE, COUNT_VALUE, SUM_VALUE, SUM_VALUE AS AVERAGE_VALUE, SUM_VALUE AS MIN_VALUE, SUM_VALUE AS MAX_VALUE, NULL AS GROUP_BY_VALUE_2
FROM VW_V2_GIFTSUMMARIES_SOFTGIFTS AS SOFT_GIFTS
WHERE SOFT_GIFTS.GIFT_ID =
    (SELECT GA.GIFT_ID
    FROM GIFT GA
    JOIN DISTRO_LINE DLA ON DLA.GIFT_ID = GA.GIFT_ID
    JOIN CUSTOM_FIELD CFA ON CFA.ENTITY_ID = DLA.DISTRO_LINE_ID AND CFA.ENTITY_TYPE = ''distributionline'' AND CFA.FIELD_NAME = ''onBehalfOf''
    WHERE CFA.FIELD_VALUE = SOFT_GIFTS.CONSTITUENT_ID
    AND GA.IS_DELETED = 0
    ORDER BY GA.DONATION_DATE DESC, GA.TRANSACTION_DATE DESC LIMIT 1)

UNION

-- Soft Gift - Largest Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Soft Gifts'' AS CATEGORY, ''Largest Gift'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    START_DATE, END_DATE, CURRENCY_CODE, COUNT_VALUE, SUM_VALUE, SUM_VALUE AS AVERAGE_VALUE, SUM_VALUE AS MIN_VALUE, SUM_VALUE AS MAX_VALUE, NULL AS GROUP_BY_VALUE_2
FROM VW_V2_GIFTSUMMARIES_SOFTGIFTS AS SOFT_GIFTS
WHERE SOFT_GIFTS.GIFT_ID =
    (SELECT GA.GIFT_ID
    FROM GIFT GA
    JOIN DISTRO_LINE DLA ON DLA.GIFT_ID = GA.GIFT_ID
    JOIN CUSTOM_FIELD CFA ON CFA.ENTITY_ID = DLA.DISTRO_LINE_ID AND CFA.ENTITY_TYPE = ''distributionline'' AND CFA.FIELD_NAME = ''onBehalfOf''
    WHERE CFA.FIELD_VALUE = SOFT_GIFTS.CONSTITUENT_ID
    AND GA.IS_DELETED = 0
    ORDER BY
        DLA.AMOUNT +
            IFNULL((SELECT SUM(B.AMOUNT) FROM ADJUSTED_GIFT
            JOIN DISTRO_LINE B ON B.ADJUSTED_GIFT_ID = ADJUSTED_GIFT.ADJUSTED_GIFT_ID
            JOIN CUSTOM_FIELD C ON C.ENTITY_ID = B.DISTRO_LINE_ID AND C.ENTITY_TYPE = ''distributionline'' AND C.FIELD_NAME = ''onBehalfOf''
            WHERE ADJUSTED_GIFT.GIFT_ID = GA.GIFT_ID
            AND C.FIELD_VALUE = CFA.FIELD_VALUE), 0) DESC LIMIT 1)

UNION

-- Pledges - First Pledge
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Pledges'' AS CATEGORY, ''First Pledge'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    PLEDGE_DATE AS START_DATE, PLEDGE_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, AMOUNT_TOTAL AS SUM_VALUE,
    AMOUNT_TOTAL AS AVERAGE_VALUE, AMOUNT_TOTAL AS MIN_VALUE, AMOUNT_TOTAL AS MAX_VALUE, NULL AS GROUP_BY_VALUE_2
FROM PLEDGE
WHERE PLEDGE_ID = (SELECT B.PLEDGE_ID FROM PLEDGE B WHERE B.CONSTITUENT_ID = PLEDGE.CONSTITUENT_ID AND B.IS_DELETED = 0 ORDER BY B.PLEDGE_DATE ASC, B.CREATE_DATE ASC LIMIT 1)
AND PLEDGE.IS_DELETED = 0

UNION

-- Pledges - Last Pledge
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Pledges'' AS CATEGORY, ''Last Pledge'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    PLEDGE_DATE AS START_DATE, PLEDGE_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, AMOUNT_TOTAL AS SUM_VALUE,
    AMOUNT_TOTAL AS AVERAGE_VALUE, AMOUNT_TOTAL AS MIN_VALUE, AMOUNT_TOTAL AS MAX_VALUE, NULL AS GROUP_BY_VALUE_2
FROM PLEDGE
WHERE PLEDGE_ID = (SELECT B.PLEDGE_ID FROM PLEDGE B WHERE B.CONSTITUENT_ID = PLEDGE.CONSTITUENT_ID AND B.IS_DELETED = 0 ORDER BY B.PLEDGE_DATE DESC, B.CREATE_DATE DESC LIMIT 1)
AND PLEDGE.IS_DELETED = 0

UNION

-- Pledges - Largest Pledge
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Pledges'' AS CATEGORY, ''Largest Pledge'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    PLEDGE_DATE AS START_DATE, PLEDGE_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, GREATEST(PLEDGE.AMOUNT_PAID, PLEDGE.AMOUNT_TOTAL) AS SUM_VALUE,
    GREATEST(PLEDGE.AMOUNT_PAID, PLEDGE.AMOUNT_TOTAL) AS AVERAGE_VALUE, GREATEST(PLEDGE.AMOUNT_PAID, PLEDGE.AMOUNT_TOTAL) AS MIN_VALUE, GREATEST(PLEDGE.AMOUNT_PAID, PLEDGE.AMOUNT_TOTAL) AS MAX_VALUE, NULL AS GROUP_BY_VALUE_2
FROM PLEDGE
WHERE PLEDGE_ID = (SELECT B.PLEDGE_ID FROM PLEDGE B WHERE B.CONSTITUENT_ID = PLEDGE.CONSTITUENT_ID AND B.IS_DELETED = 0 ORDER BY GREATEST(B.AMOUNT_PAID, B.AMOUNT_TOTAL) DESC LIMIT 1)
AND PLEDGE.IS_DELETED = 0

UNION

-- Recurring Gifts - First Recurring Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Recurring Gifts'' AS CATEGORY, ''First Recurring Gift'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    START_DATE AS START_DATE, END_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, AMOUNT_TOTAL AS SUM_VALUE,
    AMOUNT_TOTAL AS AVERAGE_VALUE, AMOUNT_TOTAL AS MIN_VALUE, AMOUNT_TOTAL AS MAX_VALUE, NULL AS GROUP_BY_VALUE_2
FROM RECURRING_GIFT
WHERE RECURRING_GIFT_ID = (SELECT B.RECURRING_GIFT_ID FROM RECURRING_GIFT B WHERE B.CONSTITUENT_ID = RECURRING_GIFT.CONSTITUENT_ID AND B.IS_DELETED = 0 ORDER BY B.START_DATE ASC, B.CREATE_DATE ASC LIMIT 1)
AND RECURRING_GIFT.IS_DELETED = 0

UNION

-- Recurring Gifts - Last Recurring Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Recurring Gifts'' AS CATEGORY, ''Last Recurring Gift'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    START_DATE AS START_DATE, END_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, AMOUNT_TOTAL AS SUM_VALUE,
    AMOUNT_TOTAL AS AVERAGE_VALUE, AMOUNT_TOTAL AS MIN_VALUE, AMOUNT_TOTAL AS MAX_VALUE, NULL AS GROUP_BY_VALUE_2
FROM RECURRING_GIFT
WHERE RECURRING_GIFT_ID = (SELECT B.RECURRING_GIFT_ID FROM RECURRING_GIFT B WHERE B.CONSTITUENT_ID = RECURRING_GIFT.CONSTITUENT_ID AND B.IS_DELETED = 0 ORDER BY B.START_DATE DESC, B.CREATE_DATE DESC LIMIT 1)
AND RECURRING_GIFT.IS_DELETED = 0

UNION

-- Recurring Gifts - Largest Recurring Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Recurring Gifts'' AS CATEGORY, ''Largest Recurring Gift'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    START_DATE AS START_DATE, END_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, AMOUNT_TOTAL AS SUM_VALUE,
    AMOUNT_TOTAL AS AVERAGE_VALUE, AMOUNT_TOTAL AS MIN_VALUE, AMOUNT_TOTAL AS MAX_VALUE, NULL AS GROUP_BY_VALUE_2
FROM RECURRING_GIFT
WHERE RECURRING_GIFT_ID = (SELECT B.RECURRING_GIFT_ID FROM RECURRING_GIFT B WHERE B.CONSTITUENT_ID = RECURRING_GIFT.CONSTITUENT_ID AND B.IS_DELETED = 0 ORDER BY AMOUNT_TOTAL DESC LIMIT 1)
AND RECURRING_GIFT.IS_DELETED = 0

UNION

-- Gift In Kind - First Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Gifts In Kind'' AS CATEGORY, ''First Gift In Kind'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    DONATION_DATE AS START_DATE, DONATION_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, FAIR_MARKET_VALUE AS SUM_VALUE,
    FAIR_MARKET_VALUE AS AVERAGE_VALUE, FAIR_MARKET_VALUE AS MIN_VALUE, FAIR_MARKET_VALUE AS MAX_VALUE, NULL AS GROUP_BY_VALUE_2
FROM GIFT_IN_KIND
WHERE GIFT_ID = (SELECT GIFT_ID FROM GIFT_IN_KIND B WHERE B.CONSTITUENT_ID = GIFT_IN_KIND.CONSTITUENT_ID AND B.IS_DELETED = 0 ORDER BY DONATION_DATE ASC, TRANSACTION_DATE ASC LIMIT 1)
AND GIFT_IN_KIND.IS_DELETED = 0

UNION

-- Gift In Kind - Last Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Gifts In Kind'' AS CATEGORY, ''Last Gift In Kind'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    DONATION_DATE AS START_DATE, DONATION_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, FAIR_MARKET_VALUE AS SUM_VALUE,
    FAIR_MARKET_VALUE AS AVERAGE_VALUE, FAIR_MARKET_VALUE AS MIN_VALUE, FAIR_MARKET_VALUE AS MAX_VALUE, NULL AS GROUP_BY_VALUE_2
FROM GIFT_IN_KIND
WHERE GIFT_ID = (SELECT GIFT_ID FROM GIFT_IN_KIND B WHERE B.CONSTITUENT_ID = GIFT_IN_KIND.CONSTITUENT_ID AND B.IS_DELETED = 0 ORDER BY DONATION_DATE DESC, TRANSACTION_DATE DESC LIMIT 1)
AND GIFT_IN_KIND.IS_DELETED = 0

UNION

-- Gift In Kind - Large Gift
SELECT
    CONSTITUENT_ID AS GROUP_BY_VALUE, ''Gifts In Kind'' AS CATEGORY, ''Large Gift In Kind'' AS ATTRIBUTE_DESC, ''Lifetime'' AS SERIES_DESC,
    DONATION_DATE AS START_DATE, DONATION_DATE AS END_DATE, CURRENCY_CODE, 1 AS COUNT_VALUE, FAIR_MARKET_VALUE AS SUM_VALUE,
    FAIR_MARKET_VALUE AS AVERAGE_VALUE, FAIR_MARKET_VALUE AS MIN_VALUE, FAIR_MARKET_VALUE AS MAX_VALUE, NULL AS GROUP_BY_VALUE_2
FROM GIFT_IN_KIND
WHERE GIFT_ID = (SELECT GIFT_ID FROM GIFT_IN_KIND B WHERE B.CONSTITUENT_ID = GIFT_IN_KIND.CONSTITUENT_ID AND B.IS_DELETED = 0 ORDER BY FAIR_MARKET_VALUE DESC, TRANSACTION_DATE ASC LIMIT 1)
AND GIFT_IN_KIND.IS_DELETED = 0
;'
WHERE VIEW_NAME = 'VW_V2_GIFTSUMMARIES';