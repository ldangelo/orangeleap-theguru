START TRANSACTION;

UPDATE REPORTCUSTOMFILTERDEFINITION
SET SQL_TEXT = 'EXISTS (SELECT * FROM THEGURU_SEGMENTATION_RESULT SEGTABLE WHERE SEGTABLE.REPORT_ID = {0} AND SEGTABLE.ENTITY_ID = [VIEWNAME].DISTRO_LINE_DISTRO_LINE_ID)'
WHERE DISPLAY_TEXT = 'Segmentation - Gift Distribution is in segmentation / report'
AND SQL_TEXT = 'EXISTS (SELECT * FROM THEGURU_SEGMENTATION_RESULT SEGTABLE WHERE SEGTABLE.REPORT_ID = {0} AND SEGTABLE.ENTITY_ID = [VIEWNAME].GIFT_GIFT_ID)';

COMMIT;