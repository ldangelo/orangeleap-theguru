-- CLEMENTINE-363 - Change View_Name in ReportDataSubsource to 8000 characters
ALTER TABLE REPORTDATASUBSOURCE MODIFY COLUMN VIEW_NAME VARCHAR(8000) DEFAULT NULL;

-- TANGERINE-1066 - Correct Gift Status column definition
UPDATE REPORTFIELD SET COLUMN_NAME = 'GETPICKLISTDISPLAYVALUE(''giftStatus'', GIFT_GIFT_STATUS)' WHERE COLUMN_NAME = 'GETPICKLISTDISPLAYVALUE(''giftStatus'', GIFT_GIFT_STATUS),';

-- Segmentations
ALTER TABLE REPORTWIZARD
ADD COLUMN USE_REPORT_AS_SEGMENTATION BIT(1) DEFAULT b'0';

ALTER TABLE REPORTWIZARD
ADD COLUMN REPORTSEGMENTATIONTYPE_ID BIGINT;

ALTER TABLE REPORTWIZARD
ADD COLUMN SEGMENTATION_QUERY TEXT;

CREATE TABLE REPORTSEGMENTATIONTYPE
  (REPORTSEGMENTATIONTYPE_ID BIGINT NOT NULL AUTO_INCREMENT,
  COLUMN_NAME VARCHAR(255),
  SEGMENTATIONTYPE VARCHAR(255),
  PRIMARY KEY (REPORTSEGMENTATIONTYPE_ID))
ENGINE=InnoDB;

CREATE TABLE REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE
  (reportSegmentationTypes_REPORTSEGMENTATIONTYPE_ID BIGINT NOT NULL,
  reportDataSubSource_REPORTSUBSOURCE_ID BIGINT NOT NULL,
  REPORTSUBSOURCE_ID INTEGER NOT NULL,
  REPORTSEGMENTATIONTYPE_ID INTEGER NOT NULL,
  PRIMARY KEY (reportSegmentationTypes_REPORTSEGMENTATIONTYPE_ID, REPORTSUBSOURCE_ID))
ENGINE=InnoDB;

ALTER TABLE REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE ADD INDEX FKC3ABA16E53A8E03F (reportSegmentationTypes_REPORTSEGMENTATIONTYPE_ID), ADD CONSTRAINT FKC3ABA16E53A8E03F FOREIGN KEY (reportSegmentationTypes_REPORTSEGMENTATIONTYPE_ID) REFERENCES REPORTSEGMENTATIONTYPE (REPORTSEGMENTATIONTYPE_ID);
ALTER TABLE REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE ADD INDEX FKC3ABA16EA9997991 (reportDataSubSource_REPORTSUBSOURCE_ID), ADD CONSTRAINT FKC3ABA16EA9997991 FOREIGN KEY (reportDataSubSource_REPORTSUBSOURCE_ID) REFERENCES REPORTDATASUBSOURCE (REPORTSUBSOURCE_ID);

INSERT REPORTSEGMENTATIONTYPE
  (COLUMN_NAME, SEGMENTATIONTYPE)
SELECT
  'CONSTITUENT_CONSTITUENT_ID', 'Constituent Segmentation';

SET @REPORTSEGMENTATIONTYPEID = LAST_INSERT_ID();

INSERT REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE
  (reportSegmentationTypes_REPORTSEGMENTATIONTYPE_ID, reportDataSubSource_REPORTSUBSOURCE_ID, REPORTSUBSOURCE_ID, REPORTSEGMENTATIONTYPE_ID)
SELECT DISTINCT
  @REPORTSEGMENTATIONTYPEID, REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID, REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID, @REPORTSEGMENTATIONTYPEID
FROM REPORTDATASUBSOURCE
JOIN REPORTFIELDGROUP_REPORTDATASUBSOURCE ON REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID = REPORTFIELDGROUP_REPORTDATASUBSOURCE.reportDataSubSource_REPORTSUBSOURCE_ID
JOIN REPORTFIELD_REPORTFIELDGROUP ON REPORTFIELDGROUP_REPORTDATASUBSOURCE.REPORTFIELDGROUP_REPORTFIELDGROUP_ID = REPORTFIELD_REPORTFIELDGROUP.reportFieldGroup_REPORTFIELDGROUP_ID
JOIN REPORTFIELD ON REPORTFIELD_REPORTFIELDGROUP.fields_REPORTFIELD_ID = REPORTFIELD.REPORTFIELD_ID
WHERE COLUMN_NAME = 'CONSTITUENT_CONSTITUENT_ID' OR PRIMARY_KEYS LIKE '%CONSTITUENT_CONSTITUENT_ID';

INSERT REPORTSEGMENTATIONTYPE
  (COLUMN_NAME, SEGMENTATIONTYPE)
SELECT
  'GIFT_GIFT_ID', 'Gift Segmentation';

SET @REPORTSEGMENTATIONTYPEID = LAST_INSERT_ID();

INSERT REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE
  (reportSegmentationTypes_REPORTSEGMENTATIONTYPE_ID, reportDataSubSource_REPORTSUBSOURCE_ID, REPORTSUBSOURCE_ID, REPORTSEGMENTATIONTYPE_ID)
SELECT DISTINCT
  @REPORTSEGMENTATIONTYPEID, REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID, REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID, @REPORTSEGMENTATIONTYPEID
FROM REPORTDATASUBSOURCE
JOIN REPORTFIELDGROUP_REPORTDATASUBSOURCE ON REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID = REPORTFIELDGROUP_REPORTDATASUBSOURCE.reportDataSubSource_REPORTSUBSOURCE_ID
JOIN REPORTFIELD_REPORTFIELDGROUP ON REPORTFIELDGROUP_REPORTDATASUBSOURCE.REPORTFIELDGROUP_REPORTFIELDGROUP_ID = REPORTFIELD_REPORTFIELDGROUP.reportFieldGroup_REPORTFIELDGROUP_ID
JOIN REPORTFIELD ON REPORTFIELD_REPORTFIELDGROUP.fields_REPORTFIELD_ID = REPORTFIELD.REPORTFIELD_ID
WHERE COLUMN_NAME = 'GIFT_GIFT_ID' OR PRIMARY_KEYS LIKE '%GIFT_GIFT_ID';



INSERT REPORTSEGMENTATIONTYPE
  (COLUMN_NAME, SEGMENTATIONTYPE)
SELECT
  'ENTITY_ENTITYID', 'Account Segmentation';

SET @REPORTSEGMENTATIONTYPEID = LAST_INSERT_ID();

INSERT REPORTSEGMENTATIONTYPE_REPORTDATASUBSOURCE
  (reportSegmentationTypes_REPORTSEGMENTATIONTYPE_ID, reportDataSubSource_REPORTSUBSOURCE_ID, REPORTSUBSOURCE_ID, REPORTSEGMENTATIONTYPE_ID)
SELECT DISTINCT
  @REPORTSEGMENTATIONTYPEID, REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID, REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID, @REPORTSEGMENTATIONTYPEID
FROM REPORTDATASUBSOURCE
JOIN REPORTFIELDGROUP_REPORTDATASUBSOURCE ON REPORTDATASUBSOURCE.REPORTSUBSOURCE_ID = REPORTFIELDGROUP_REPORTDATASUBSOURCE.reportDataSubSource_REPORTSUBSOURCE_ID
JOIN REPORTFIELD_REPORTFIELDGROUP ON REPORTFIELDGROUP_REPORTDATASUBSOURCE.REPORTFIELDGROUP_REPORTFIELDGROUP_ID = REPORTFIELD_REPORTFIELDGROUP.reportFieldGroup_REPORTFIELDGROUP_ID
JOIN REPORTFIELD ON REPORTFIELD_REPORTFIELDGROUP.fields_REPORTFIELD_ID = REPORTFIELD.REPORTFIELD_ID
WHERE COLUMN_NAME = 'ENTITY_ENTITYID' OR PRIMARY_KEYS LIKE '%ENTITY_ENTITYID';




-- Account is in the Guru segmentation
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 550, 'The Guru Segmentation - Account is in the Guru segmentation / report',
'EXISTS (SELECT * FROM THEGURU_SEGMENTATION_RESULT SEGTABLE WHERE SEGTABLE.REPORT_ID = {0} AND SEGTABLE.ENTITY_ID = [VIEWNAME].ENTITY_ENTITYID)',
'The Guru Segmentation - Account is in segmentation / report <br> {lookupReferenceBean:mpxAccountSegmentationList}';

INSERT REPORTCUSTOMFILTERDEFINITION_REPORTDATASUBSOURCE
SELECT REPORTCUSTOMFILTERDEFINITION_ID, REPORTDATASUBSOURCE_REPORTSUBSOURCE_ID, REPORTDATASUBSOURCE_REPORTSUBSOURCE_ID, REPORTSUBSOURCE_ID + REPORTCUSTOMFILTERDEFINITION_ID
FROM REPORTFIELDGROUP_REPORTDATASUBSOURCE
JOIN REPORTCUSTOMFILTERDEFINITION ON 1 = 1
WHERE REPORTCUSTOMFILTERDEFINITION_ID = 550
AND REPORTFIELDGROUP_REPORTFIELDGROUP_ID IN
  (SELECT REPORTFIELDGROUP_ID FROM REPORTFIELD_REPORTFIELDGROUP
  WHERE REPORTFIELD_ID IN
    (SELECT REPORTFIELD_ID FROM REPORTFIELD
    WHERE COLUMN_NAME = 'ENTITY_ENTITYID'));


-- Create table for THEGURU_SEGMENTATION_RESULT table in Orange Leap or MPX schema

-- Orange Leap
CREATE TABLE `THEGURU_SEGMENTATION_RESULT` (
  `THEGURU_SEGMENTATION_RESULT_ID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `REPORT_ID` BIGINT UNSIGNED NOT NULL,
  `ENTITY_ID` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`THEGURU_SEGMENTATION_RESULT_ID`),
  INDEX `IDX_REPORT_ID`(`REPORT_ID`)
)
ENGINE = InnoDB;


-- MPX

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'THEGURU_SEGMENTATION_RESULT')
	DROP TABLE dbo.THEGURU_SEGMENTATION_RESULT
go
CREATE TABLE dbo.THEGURU_SEGMENTATION_RESULT
	(
	THEGURU_SEGMENTATION_RESULT_ID bigint NOT NULL IDENTITY (1, 1),
	REPORT_ID bigint NOT NULL,
	ENTITY_ID bigint NOT NULL
	) ON [PRIMARY]

go
ALTER TABLE dbo.THEGURU_SEGMENTATION_RESULT ADD CONSTRAINT
	PK_THEGURU_SEGMENTATION_RESULT PRIMARY KEY CLUSTERED
	(
	THEGURU_SEGMENTATION_RESULT_ID
	) ON [PRIMARY]


go
CREATE NONCLUSTERED INDEX IDX_THEGURU_SEGMENTATION_RESULT_REPORT_ID ON dbo.THEGURU_SEGMENTATION_RESULT
	(
	THEGURU_SEGMENTATION_RESULT_ID
	) ON [PRIMARY]

go

