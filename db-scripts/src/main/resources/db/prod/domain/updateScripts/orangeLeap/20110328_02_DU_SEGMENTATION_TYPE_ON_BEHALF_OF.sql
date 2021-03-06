START TRANSACTION;

INSERT REPORTSEGMENTATIONTYPE
(COLUMN_NAME, SEGMENTATIONTYPE)
SELECT DISTINCT COLUMN_NAME, CONCAT('Constituent Segmentation - ', REPORTFIELDGROUP.Name, ' - On Behalf Of')
FROM REPORTFIELD
JOIN REPORTFIELD_REPORTFIELDGROUP ON REPORTFIELD_REPORTFIELDGROUP.fields_REPORTFIELD_ID = REPORTFIELD.REPORTFIELD_ID
JOIN REPORTFIELDGROUP ON REPORTFIELD_REPORTFIELDGROUP.reportFieldGroup_REPORTFIELDGROUP_ID = REPORTFIELDGROUP.REPORTFIELDGROUP_ID
JOIN REPORTFIELDGROUP_REPORTDATASUBSOURCE ON REPORTFIELDGROUP_REPORTDATASUBSOURCE.REPORTFIELDGROUP_REPORTFIELDGROUP_ID = REPORTFIELDGROUP.REPORTFIELDGROUP_ID
JOIN REPORTDATASUBSOURCE ON REPORTFIELDGROUP_REPORTDATASUBSOURCE.reportDataSubSource_REPORTSUBSOURCE_ID = REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID
WHERE COLUMN_NAME LIKE 'GETCONSTITUENTACCOUNTNUMBER%onBehalfOf%'
AND NOT EXISTS
(SELECT * FROM REPORTSEGMENTATIONTYPE B
WHERE B.COLUMN_NAME = REPORTFIELD.COLUMN_NAME
AND B.SEGMENTATIONTYPE = CONCAT('Constituent Segmentation - ', REPORTFIELDGROUP.Name, ' - On Behalf Of'));

INSERT REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE
(reportSegmentationTypes_REPORTSEGMENTATIONTYPE_ID,
reportDataSubSource_REPORTSUBSOURCE_ID,
REPORTSUBSOURCE_ID,
REPORTSEGMENTATIONTYPE_ID)
SELECT DISTINCT REPORTSEGMENTATIONTYPE_ID, REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID, REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID, REPORTSEGMENTATIONTYPE_ID
FROM REPORTFIELD
JOIN REPORTFIELD_REPORTFIELDGROUP ON REPORTFIELD_REPORTFIELDGROUP.fields_REPORTFIELD_ID = REPORTFIELD.REPORTFIELD_ID
JOIN REPORTFIELDGROUP ON REPORTFIELD_REPORTFIELDGROUP.reportFieldGroup_REPORTFIELDGROUP_ID = REPORTFIELDGROUP.REPORTFIELDGROUP_ID
JOIN REPORTFIELDGROUP_REPORTDATASUBSOURCE ON REPORTFIELDGROUP_REPORTDATASUBSOURCE.REPORTFIELDGROUP_REPORTFIELDGROUP_ID = REPORTFIELDGROUP.REPORTFIELDGROUP_ID
JOIN REPORTDATASUBSOURCE ON REPORTFIELDGROUP_REPORTDATASUBSOURCE.reportDataSubSource_REPORTSUBSOURCE_ID = REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID
JOIN REPORTSEGMENTATIONTYPE ON REPORTSEGMENTATIONTYPE.COLUMN_NAME = REPORTFIELD.COLUMN_NAME AND REPORTSEGMENTATIONTYPE.SEGMENTATIONTYPE = CONCAT('Constituent Segmentation - ', REPORTFIELDGROUP.Name, ' - On Behalf Of')
WHERE REPORTFIELD.COLUMN_NAME LIKE 'GETCONSTITUENTACCOUNTNUMBER%onBehalfOf%'
AND NOT EXISTS
(SELECT * FROM REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE B
WHERE B.reportSegmentationTypes_REPORTSEGMENTATIONTYPE_ID = REPORTSEGMENTATIONTYPE.REPORTSEGMENTATIONTYPE_ID
AND B.reportDataSubSource_REPORTSUBSOURCE_ID = REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID
AND B.REPORTSUBSOURCE_ID = REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID
AND B.REPORTSEGMENTATIONTYPE_ID = REPORTSEGMENTATIONTYPE.REPORTSEGMENTATIONTYPE_ID);

COMMIT;