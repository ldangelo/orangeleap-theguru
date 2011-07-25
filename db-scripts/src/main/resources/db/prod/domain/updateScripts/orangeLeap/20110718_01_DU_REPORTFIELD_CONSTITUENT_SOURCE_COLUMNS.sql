UPDATE REPORTFIELD
SET SOURCE_COLUMN_NAME = 'CASE WHEN ${CONSTITUENT_TABLE}.CONSTITUENT_TYPE = ''individual'' THEN CONCAT_WS('', '', ${CONSTITUENT_TABLE}.LAST_NAME, ${CONSTITUENT_TABLE}.FIRST_NAME) WHEN ${CONSTITUENT_TABLE}.CONSTITUENT_TYPE = ''organization'' THEN ${CONSTITUENT_TABLE}.ORGANIZATION_NAME ELSE CAST(${CONSTITUENT_TABLE}.CONSTITUENT_ID AS CHAR(20)) END'
WHERE SOURCE_COLUMN_NAME = 'CASE WHEN ${CONSTITUENT_TABLE}.CONSTITUENT_TYPE = ''individual'' THEN CONCAT_WS('', '', ${CONSTITUENT_TABLE}.LAST_NAME, ${CONSTITUENT_TABLE}.FIRST_NAME) WHEN ${CONSTITUENT_TABLE}.CONSTITUENT_TYPE = ''organization'' THEN ${CONSTITUENT_TABLE}.ORGANIZATION_NAME ELSE ${CONSTITUENT_TABLE}.CONSTITUENT_ID END';