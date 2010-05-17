UPDATE REPORTFIELD
SET COLUMN_NAME =
REPLACE(REPLACE(COLUMN_NAME, 'GETCUSTOMFIELDDISPLAYVALUECONCATENATED', 'GETCUSTOMFIELDVALUESANDDISPLAYVALUESCONCATENATED'), '''distributionline'', ''tributeOccasion''', '''distributionline'', ''additional_tributeOccasion'', ''tributeOccasion''')
WHERE DISPLAY_NAME = 'Tribute Occasion';