START TRANSACTION;

INSERT REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE
SELECT
reportSegmentationTypes_REPORTSEGMENTATIONTYPE_ID,
(SELECT REPORTSUBSOURCE_ID FROM REPORTDATASUBSOURCE WHERE VIEW_NAME LIKE '%V2_%'
    AND REPLACE(VIEW_NAME, 'V2_', '') IN
    (SELECT VIEW_NAME FROM REPORTDATASUBSOURCE WHERE REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID = REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE.reportDataSubSource_REPORTSUBSOURCE_ID)),
(SELECT REPORTSUBSOURCE_ID FROM REPORTDATASUBSOURCE WHERE VIEW_NAME LIKE '%V2_%'
    AND REPLACE(VIEW_NAME, 'V2_', '') IN
    (SELECT VIEW_NAME FROM REPORTDATASUBSOURCE WHERE REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID = REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE.reportDataSubSource_REPORTSUBSOURCE_ID)),
REPORTSEGMENTATIONTYPE_ID
FROM REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE
WHERE (SELECT REPORTSUBSOURCE_ID FROM REPORTDATASUBSOURCE WHERE VIEW_NAME LIKE '%V2_%'
    AND REPLACE(VIEW_NAME, 'V2_', '') IN
    (SELECT VIEW_NAME FROM REPORTDATASUBSOURCE WHERE REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID = REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE.reportDataSubSource_REPORTSUBSOURCE_ID)) IS NOT NULL
AND NOT EXISTS
    (SELECT * FROM REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE B
    WHERE B.reportSegmentationTypes_REPORTSEGMENTATIONTYPE_ID = REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE.reportSegmentationTypes_REPORTSEGMENTATIONTYPE_ID
    AND B.reportDataSubSource_REPORTSUBSOURCE_ID =
    (SELECT REPORTSUBSOURCE_ID FROM REPORTDATASUBSOURCE WHERE VIEW_NAME LIKE '%V2_%'
    AND REPLACE(VIEW_NAME, 'V2_', '') IN
    (SELECT VIEW_NAME FROM REPORTDATASUBSOURCE WHERE REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID = REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE.reportDataSubSource_REPORTSUBSOURCE_ID)));
    
INSERT REPORTCUSTOMFILTERDEFINITION_REPORTDATASUBSOURCE
SELECT reportCustomFilterDefinitions_REPORTCUSTOMFILTERDEFINITION_ID,
(SELECT REPORTSUBSOURCE_ID FROM REPORTDATASUBSOURCE WHERE VIEW_NAME LIKE '%V2_%'
    AND REPLACE(VIEW_NAME, 'V2_', '') IN
    (SELECT VIEW_NAME FROM REPORTDATASUBSOURCE WHERE REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID = REPORTCUSTOMFILTERDEFINITION_REPORTDATASUBSOURCE.reportDataSubSource_REPORTSUBSOURCE_ID)),
(SELECT REPORTSUBSOURCE_ID FROM REPORTDATASUBSOURCE WHERE VIEW_NAME LIKE '%V2_%'
    AND REPLACE(VIEW_NAME, 'V2_', '') IN
    (SELECT VIEW_NAME FROM REPORTDATASUBSOURCE WHERE REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID = REPORTCUSTOMFILTERDEFINITION_REPORTDATASUBSOURCE.reportDataSubSource_REPORTSUBSOURCE_ID)),
reportCustomFilterDefinitions_REPORTCUSTOMFILTERDEFINITION_ID + (SELECT REPORTSUBSOURCE_ID FROM REPORTDATASUBSOURCE WHERE VIEW_NAME LIKE '%V2_%'
    AND REPLACE(VIEW_NAME, 'V2_', '') IN
    (SELECT VIEW_NAME FROM REPORTDATASUBSOURCE WHERE REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID = REPORTCUSTOMFILTERDEFINITION_REPORTDATASUBSOURCE.reportDataSubSource_REPORTSUBSOURCE_ID))
FROM REPORTCUSTOMFILTERDEFINITION_REPORTDATASUBSOURCE
WHERE (SELECT REPORTSUBSOURCE_ID FROM REPORTDATASUBSOURCE WHERE VIEW_NAME LIKE '%V2_%'
    AND REPLACE(VIEW_NAME, 'V2_', '') IN
    (SELECT VIEW_NAME FROM REPORTDATASUBSOURCE WHERE REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID = REPORTCUSTOMFILTERDEFINITION_REPORTDATASUBSOURCE.reportDataSubSource_REPORTSUBSOURCE_ID)) IS NOT NULL
AND NOT EXISTS
    (SELECT * FROM REPORTCUSTOMFILTERDEFINITION_REPORTDATASUBSOURCE B
    WHERE B.reportCustomFilterDefinitions_REPORTCUSTOMFILTERDEFINITION_ID = REPORTCUSTOMFILTERDEFINITION_REPORTDATASUBSOURCE.reportCustomFilterDefinitions_REPORTCUSTOMFILTERDEFINITION_ID
    AND B.reportDataSubSource_REPORTSUBSOURCE_ID =
    (SELECT REPORTSUBSOURCE_ID FROM REPORTDATASUBSOURCE WHERE VIEW_NAME LIKE '%V2_%'
        AND REPLACE(VIEW_NAME, 'V2_', '') IN
        (SELECT VIEW_NAME FROM REPORTDATASUBSOURCE WHERE REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID = REPORTCUSTOMFILTERDEFINITION_REPORTDATASUBSOURCE.reportDataSubSource_REPORTSUBSOURCE_ID)));
        
COMMIT;