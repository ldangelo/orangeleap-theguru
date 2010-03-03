UPDATE REPORTFIELD
SET COLUMN_NAME = REPLACE(COLUMN_NAME, 'ATTRIBUTE_DESC', 'SERIES_DESC')
WHERE COLUMN_NAME LIKE '%ATTRIBUTE_DESC'
AND ALIAS_NAME LIKE '%SERIES_DESC'
AND DISPLAY_NAME = 'Time Period';

UPDATE THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS
SET COLUMN_NAME = REPLACE(COLUMN_NAME, 'ATTRIBUTE_DESC', 'SERIES_DESC')
WHERE COLUMN_NAME LIKE '%ATTRIBUTE_DESC'
AND ALIAS_NAME LIKE '%SERIES_DESC'
AND DISPLAY_NAME = 'Time Period';
