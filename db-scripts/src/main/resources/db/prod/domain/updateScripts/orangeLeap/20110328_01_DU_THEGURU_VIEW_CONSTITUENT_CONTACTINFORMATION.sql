START TRANSACTION;

UPDATE THEGURU_VIEW
SET PRIMARY_TABLE_COLUMN_PREFIX = ''
WHERE VIEW_NAME = 'VW_V2_CONSTITUENTS_CONTACTINFORMATION';

COMMIT;