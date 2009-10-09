UPDATE REPORTFIELD
SET COLUMN_NAME = CONCAT('GETCUSTOMFIELDDISPLAYVALUECONCATENATED(', PRIMARY_KEYS, ', ''distributionline'', ''tributeOccasion'', ''customFieldMap[tributeOccasion]'')')
WHERE DISPLAY_NAME = 'Tribute Occasion'
AND COLUMN_NAME = CONCAT('GETPICKLISTDISPLAYVALUE(''customFieldMap[tributeOccasion]'', GETCUSTOMFIELD(', PRIMARY_KEYS, ', ''distributionline'', ''tributeOccasion''))');
