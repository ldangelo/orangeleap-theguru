UPDATE REPORTCUSTOMFILTERDEFINITION
SET SQL_TEXT = REPLACE(SQL_TEXT, 'SUM(AMOUNT) FROM GIFT', 'SUM(ADJUSTED_AMOUNT) FROM GIFT')
WHERE SQL_TEXT LIKE '%SUM(AMOUNT) FROM GIFT%';