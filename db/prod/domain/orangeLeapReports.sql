-- UTILITY QUERIES
--
-- -- Get the fields for a table in the format used in the select statement
-- SELECT CONCAT(CHAR(9), UCASE(TABLE_NAME), '.', COLUMN_NAME, ' AS ', UCASE(TABLE_NAME), '_', COLUMN_NAME, ',')
-- FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'PHONE';
--
-- -- Get the insert report field procedure calls (display name and is default may need to be updated)
-- SELECT CONCAT('CALL INSERTREPORTFIELD(''', COLUMN_NAME, ''', ''', COLUMN_NAME, ''', b''0'', ',
-- CASE
-- 	WHEN DATA_TYPE = 'int' THEN 2
-- 	WHEN DATA_TYPE = 'smallint' THEN 2
-- 	WHEN DATA_TYPE = 'bigint' THEN 3
-- 	WHEN DATA_TYPE = 'datetime' THEN 4
-- 	WHEN DATA_TYPE = 'decimal' THEN 5
-- 	WHEN DATA_TYPE = 'bit' THEN 6
-- 	ELSE 1
-- 	END,
-- ', @REPORTFIELDGROUP_ID);') FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'VW_GIFTS';

CALL NUMBERBUILDER();

-- Create Report Data Sources
INSERT INTO REPORTDATASOURCE
	(REPORT_NAME)
VALUES
	('Orange Leap');

SET @REPORTDATASOURCE_ID = LAST_INSERT_ID();

INSERT INTO REPORTDATASUBSOURCEGROUP
	(DESCRIPTION, DISPLAY_NAME, reportDataSource_REPORTSOURCE_ID)
VALUES
	('Administrative', 'Administrative', @REPORTDATASOURCE_ID);

INSERT INTO REPORTDATASUBSOURCEGROUP
	(DESCRIPTION, DISPLAY_NAME, reportDataSource_REPORTSOURCE_ID)
VALUES
	('Audit History', 'Audit History', @REPORTDATASOURCE_ID);

INSERT INTO REPORTDATASUBSOURCEGROUP
	(DESCRIPTION, DISPLAY_NAME, reportDataSource_REPORTSOURCE_ID)
VALUES
	('Constituents', 'Constituents', @REPORTDATASOURCE_ID);

INSERT INTO REPORTDATASUBSOURCEGROUP
	(DESCRIPTION, DISPLAY_NAME, reportDataSource_REPORTSOURCE_ID)
VALUES
	('Constituents & Relationship Details', 'Constituents & Relationship Details', @REPORTDATASOURCE_ID);

INSERT INTO REPORTDATASUBSOURCEGROUP
	(DESCRIPTION, DISPLAY_NAME, reportDataSource_REPORTSOURCE_ID)
VALUES
	('Constituents & Transactions', 'Constituents & Transactions', @REPORTDATASOURCE_ID);

INSERT INTO REPORTDATASUBSOURCEGROUP
	(DESCRIPTION, DISPLAY_NAME, reportDataSource_REPORTSOURCE_ID)
VALUES
	('Journals', 'Journals', @REPORTDATASOURCE_ID);

INSERT INTO REPORTDATASUBSOURCEGROUP
	(DESCRIPTION, DISPLAY_NAME, reportDataSource_REPORTSOURCE_ID)
VALUES
	('Transactions', 'Transactions', @REPORTDATASOURCE_ID);



-- *********************************************************************************************************************
--
-- Picklists Field Definitions
--
-- *********************************************************************************************************************

SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Administrative');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Picklists', 0, 'VW_PICKLISTS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Picklist Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Picklist Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Picklist Name
CALL INSERTREPORTFIELD('PICKLIST_PICKLIST_NAME', 'Picklist Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('PICKLIST_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Picklist Item Name
CALL INSERTREPORTFIELD('PICKLIST_ITEM_ITEM_NAME', 'Picklist Item Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Picklist Item Description
CALL INSERTREPORTFIELD('PICKLIST_ITEM_DEFAULT_DISPLAY_VALUE', 'Picklist Item Description', b'1', 1, @REPORTFIELDGROUP_ID);

-- Picklist Item Inactive
CALL INSERTREPORTFIELD('PICKLIST_ITEM_INACTIVE', 'Picklist Item Inactive', b'1', 6, @REPORTFIELDGROUP_ID);

-- Picklist Item Order
CALL INSERTREPORTFIELD('PICKLIST_ITEM_ITEM_ORDER', 'Picklist Item Order', b'0', 2, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituents Field Definitions
--
-- *********************************************************************************************************************

SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents', 0, 'VW_CONSTITUENTS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Distributions Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituents & Addresses Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Addresses', 0, 'VW_CONSTITUENTS_ADDRESSES', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Address Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Address Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Address ID
CALL INSERTREPORTFIELD('ADDRESS_ADDRESS_ID', 'Address ID', b'0', 3, @REPORTFIELDGROUP_ID);

-- Address Type
CALL INSERTREPORTFIELD('ADDRESS_ADDRESS_TYPE', 'Address Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Status
CALL INSERTREPORTFIELD('ADDRESS_ACTIVATION_STATUS', 'Address Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Effective Date
CALL INSERTREPORTFIELD('ADDRESS_EFFECTIVE_DATE', 'Address Effective Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Seasonal Start Date
CALL INSERTREPORTFIELD('ADDRESS_SEASONAL_START_DATE', 'Seasonal Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Seasonal End Date
CALL INSERTREPORTFIELD('ADDRESS_SEASONAL_END_DATE', 'Seasonal End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Temporary Start Date
CALL INSERTREPORTFIELD('ADDRESS_TEMPORARY_START_DATE', 'Temporary Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Temporary End Date
CALL INSERTREPORTFIELD('ADDRESS_TEMPORARY_END_DATE', 'Temporary End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Address Line 1
CALL INSERTREPORTFIELD('ADDRESS_ADDRESS_LINE_1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 2
CALL INSERTREPORTFIELD('ADDRESS_ADDRESS_LINE_2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 3
CALL INSERTREPORTFIELD('ADDRESS_ADDRESS_LINE_3', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- City
CALL INSERTREPORTFIELD('ADDRESS_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- State/Province
CALL INSERTREPORTFIELD('ADDRESS_STATE_PROVINCE', 'State/Province', b'0', 1, @REPORTFIELDGROUP_ID);

-- Country
CALL INSERTREPORTFIELD('ADDRESS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Zip/Postal Code
CALL INSERTREPORTFIELD('ADDRESS_POSTAL_CODE', 'Zip/Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Receive Correspondence
CALL INSERTREPORTFIELD('ADDRESS_RECEIVE_CORRESPONDENCE', 'Receive Correspondence', b'0', 6, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('ADDRESS_COMMENT', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Create Date
CALL INSERTREPORTFIELD('ADDRESS_CREATE_DATE', 'Address Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Address Update Date
CALL INSERTREPORTFIELD('ADDRESS_UPDATE_DATE', 'Address Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Address Inactive
CALL INSERTREPORTFIELD('ADDRESS_INACTIVE', 'Address Inactive', b'0', 6, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituents & Email Addresses Field Definitions
--
-- *********************************************************************************************************************

SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Email Addresses', 0, 'VW_CONSTITUENTS_EMAILS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Email Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Email Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Email Address ID
CALL INSERTREPORTFIELD('EMAIL_EMAIL_ID', 'Email Address ID', b'0', 3, @REPORTFIELDGROUP_ID);

-- Email Type
CALL INSERTREPORTFIELD('EMAIL_EMAIL_TYPE', 'Email Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Status
CALL INSERTREPORTFIELD('EMAIL_ACTIVATION_STATUS', 'Email Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Effective Date
CALL INSERTREPORTFIELD('EMAIL_EFFECTIVE_DATE', 'Effective Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Seasonal Start Date
CALL INSERTREPORTFIELD('EMAIL_SEASONAL_START_DATE', 'Seasonal Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Seasonal End Date
CALL INSERTREPORTFIELD('EMAIL_SEASONAL_END_DATE', 'Seasonal End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Temporary Start Date
CALL INSERTREPORTFIELD('EMAIL_TEMPORARY_START_DATE', 'Temporary Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Temporary End Date
CALL INSERTREPORTFIELD('EMAIL_TEMPORARY_END_DATE', 'Temporary End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Email Address
CALL INSERTREPORTFIELD('EMAIL_EMAIL_ADDRESS', 'Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Display
CALL INSERTREPORTFIELD('EMAIL_EMAIL_DISPLAY', 'Email Display', b'0', 1, @REPORTFIELDGROUP_ID);

-- Receive Correspondence
CALL INSERTREPORTFIELD('EMAIL_RECEIVE_CORRESPONDENCE', 'Receive Correspondence', b'0', 6, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('EMAIL_COMMENT', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Address Create Date
CALL INSERTREPORTFIELD('EMAIL_CREATE_DATE', 'Email Address Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Email Address Update Date
CALL INSERTREPORTFIELD('EMAIL_UPDATE_DATE', 'Email Address Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Email Address Inactive
CALL INSERTREPORTFIELD('EMAIL_INACTIVE', 'Email Address Inactive', b'0', 6, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituents & Phone Numbers Field Definitions
--
-- *********************************************************************************************************************

SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Phone Numbers', 0, 'VW_CONSTITUENTS_PHONENUMBERS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Phone Number Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Phone Number Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Phone Number ID
CALL INSERTREPORTFIELD('PHONE_PHONE_ID', 'Phone Number ID', b'0', 3, @REPORTFIELDGROUP_ID);

-- Phone Type
CALL INSERTREPORTFIELD('PHONE_PHONE_TYPE', 'Phone Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Status
CALL INSERTREPORTFIELD('PHONE_ACTIVATION_STATUS', 'Phone Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Effective Date
CALL INSERTREPORTFIELD('PHONE_EFFECTIVE_DATE', 'Effective Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Seasonal Start Date
CALL INSERTREPORTFIELD('PHONE_SEASONAL_START_DATE', 'Seasonal Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Seasonal End Date
CALL INSERTREPORTFIELD('PHONE_SEASONAL_END_DATE', 'Seasonal End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Temporary Start Date
CALL INSERTREPORTFIELD('PHONE_TEMPORARY_START_DATE', 'Temporary Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Temporary End Date
CALL INSERTREPORTFIELD('PHONE_TEMPORARY_END_DATE', 'Temporary End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Phone Number
CALL INSERTREPORTFIELD('PHONE_NUMBER', 'Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Provider
CALL INSERTREPORTFIELD('PHONE_PROVIDER', 'Provider', b'0', 1, @REPORTFIELDGROUP_ID);

-- SMS
CALL INSERTREPORTFIELD('PHONE_SMS', 'SMS', b'0', 1, @REPORTFIELDGROUP_ID);

-- Receive Correspondence
CALL INSERTREPORTFIELD('PHONE_RECEIVE_CORRESPONDENCE', 'Receive Correspondence', b'0', 6, @REPORTFIELDGROUP_ID);

-- Phone Comments
CALL INSERTREPORTFIELD('PHONE_COMMENT', 'Phone Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Create Date
CALL INSERTREPORTFIELD('PHONE_CREATE_DATE', 'Phone Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Phone Update Date
CALL INSERTREPORTFIELD('PHONE_UPDATE_DATE', 'Phone Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Phone Inactive Status
CALL INSERTREPORTFIELD('PHONE_INACTIVE', 'Phone Inactive Status', b'0', 6, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituent & Relationships Field Definitions
--
-- *********************************************************************************************************************

SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Relationships', 0, 'VW_CONSTITUENTS_RELATIONSHIPS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Relationship Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Relationship Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Employers' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_EMPLOYERS', 'Employers'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Employers' Names
CALL INSERTREPORTFIELDWITHALIAS('EMPLOYER_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_EMPLOYERS, '','')', 'Employers'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Employment Title
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_EMPLOYMENTTITLE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.employmentTitle'')', 'Employment Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Head of Household Account Number
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_HEADOFHOUSEHOLD_ACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.headOfHousehold'')', 'Head of Household Account Number', b'0', 3, @REPORTFIELDGROUP_ID);
-- Head of Household Name
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_HEADOFHOUSEHOLD_NAME', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.headOfHousehold''))', 'Head of Household Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Household Members' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_HOUSEHOLDMEMBERS', 'Household Members'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Household Members' Names
CALL INSERTREPORTFIELDWITHALIAS('HOUSEHOLDMEMBERNAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_HOUSEHOLDMEMBERS, '','')', 'Household Members'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Parents' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_PARENTS', 'Parents'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Parents'' Names
CALL INSERTREPORTFIELDWITHALIAS('PARENTS_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_PARENTS, '','')', 'Parents'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Children's Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_CHILDREN', 'Children''s Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Children's Names
CALL INSERTREPORTFIELDWITHALIAS('CHILDREN_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_CHILDREN, '','')', 'Children''s Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Siblings' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_SIBLINGS', 'Siblings'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Siblings' Names
CALL INSERTREPORTFIELDWITHALIAS('SIBLING_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_SIBLINGS, '','')', 'Siblings'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Friends' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_FRIENDS', 'Friends'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Friends' Names
CALL INSERTREPORTFIELDWITHALIAS('FRIENDS_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_FRIENDS, '','')', 'Friends'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Employees' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_EMPLOYEES', 'Employees'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Employees Names
CALL INSERTREPORTFIELDWITHALIAS('EMPLOYEES_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_EMPLOYEES, '','')', 'Employees'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Parent Organization
CALL INSERTREPORTFIELDWITHALIAS('PARENT_ORGANIZATION', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.parent''))', 'Parent Organization', b'0', 1, @REPORTFIELDGROUP_ID);

-- Subsidiary List Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_SUBSIDIARYLIST', 'Subsidiary List Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Subsidiary List Names
CALL INSERTREPORTFIELDWITHALIAS('SUBSIDIARY_LIST_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_SUBSIDIARYLIST, '','')', 'Subsidiary List Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Primary Contacts' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_PRIMARYCONTACTS', 'Primary Contacts'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Primary Contacts' Names
CALL INSERTREPORTFIELDWITHALIAS('PRIMARY_CONTACT_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_PRIMARYCONTACTS, '','')', 'Primary Contacts'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Billing Contacts' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_BILLINGCONTACTS', 'Billing Contacts'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Billing Contacts' Names
CALL INSERTREPORTFIELDWITHALIAS('BILLING_CONTACT_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_BILLINGCONTACTS, '','')', 'Billing Contacts'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Sales Contacts' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_SALESCONTACTS', 'Sales Contacts'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Sales Contacts' Names
CALL INSERTREPORTFIELDWITHALIAS('SALES_CONTACT_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_SALESCONTACTS, '','')', 'Sales Contacts'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Public Relations Contacts' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_PUBLICRELATIONSCONTACTS', 'Public Relations Contacts'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Public Relations Contacts
CALL INSERTREPORTFIELDWITHALIAS('PUBLIC_RELATION_CONTACT_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_PUBLICRELATIONSCONTACTS, '','')', 'Public Relations Contacts'' Names', b'0', 1, @REPORTFIELDGROUP_ID);


-- *********************************************************************************************************************
--
-- Constituent & Employers Field Definitions
--
-- *********************************************************************************************************************



SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Relationship Details');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Employers', 0, 'VW_CONSTITUENTS_EMPLOYERS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Employer Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Employer Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Employers' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_EMPLOYERS', 'Employers'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Employers' Names
CALL INSERTREPORTFIELDWITHALIAS('EMPLOYER_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_EMPLOYERS, '','')', 'Employers'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Employer's Account Number
CALL INSERTREPORTFIELDWITHALIAS('EMPLOYER_ACCOUNTNUMBER', 'GETVALUE(CONSTITUENT_EMPLOYERS, '','', CONSTITUENT_EMPLOYERS_NUMBERS_NUMBER)', 'Employer''s Account Number', b'0', 3, @REPORTFIELDGROUP_ID);
-- Employer's Name
CALL INSERTREPORTFIELDWITHALIAS('EMPLOYER_NAME', 'GETCONSTITUENTDISPLAYNAME(GETVALUE(CONSTITUENT_EMPLOYERS, '','', CONSTITUENT_EMPLOYERS_NUMBERS_NUMBER))', 'Employer''s Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Employment Title
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_EMPLOYMENTTITLE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.employmentTitle'')', 'Employment Title', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituent & Household Members Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Relationship Details');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Household Members', 0, 'VW_CONSTITUENTS_HOUSEHOLDMEMBERS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Household Members Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Household Members Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Head of Household Account Number
CALL INSERTREPORTFIELDWITHALIAS('HEADOFHOUSEHOLD_ACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.headOfHousehold'')', 'Head of Household Account Number', b'0', 3, @REPORTFIELDGROUP_ID);
-- Head of Household Name
CALL INSERTREPORTFIELDWITHALIAS('HEADOFOHOUSEHOLD_NAME', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.headOfHousehold''))', 'Head of Household Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Household Members' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_HOUSEHOLDMEMBERS', 'Household Members'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Household Members' Names
CALL INSERTREPORTFIELDWITHALIAS('HOUSEHOLD_MEMBERS_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_HOUSEHOLDMEMBERS, '','')', 'Household Members'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Household Member's Account Number
CALL INSERTREPORTFIELDWITHALIAS('HOUSEHOLD_MEMBER_ACCOUNTNUMBER', 'GETVALUE(CONSTITUENT_HOUSEHOLDMEMBERS, '','', CONSTITUENT_HOUSEHOLDMEMBERS_NUMBERS_NUMBER)', 'Household Member''s Account Number', b'0', 3, @REPORTFIELDGROUP_ID);
-- Household Member's Name
CALL INSERTREPORTFIELDWITHALIAS('HOUSEHOLD_MEMBER_NAME', 'GETCONSTITUENTDISPLAYNAME(GETVALUE(CONSTITUENT_HOUSEHOLDMEMBERS, '','', CONSTITUENT_HOUSEHOLDMEMBERS_NUMBERS_NUMBER))', 'Household Member''s Name', b'0', 1, @REPORTFIELDGROUP_ID);


-- *********************************************************************************************************************
--
-- Constituent & Parents Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Relationship Details');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Parents', 0, 'VW_CONSTITUENTS_PARENTS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Parents Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Parents Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Parents' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_PARENTS', 'Parents'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Parents' Names
CALL INSERTREPORTFIELDWITHALIAS('PARENTS_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_PARENTS, '','')', 'Parents'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Parent's Account Number
CALL INSERTREPORTFIELDWITHALIAS('PARENT_ACCOUNTNUMBER', 'GETVALUE(CONSTITUENT_PARENTS, '','', CONSTITUENT_PARENTS_NUMBERS_NUMBER)', 'Parents''s Account Number', b'0', 3, @REPORTFIELDGROUP_ID);
-- Parent's Member's Name
CALL INSERTREPORTFIELDWITHALIAS('PARENT_NAME', 'GETCONSTITUENTDISPLAYNAME(GETVALUE(CONSTITUENT_PARENTS, '','', CONSTITUENT_PARENTS_NUMBERS_NUMBER))', 'Parents''s Name', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituent & Children Field Definitions
--
-- *********************************************************************************************************************



SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Relationship Details');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Children', 0, 'VW_CONSTITUENTS_CHILDREN', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Children Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Children Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Children's Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_CHILDREN', 'Children''s Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Children's Names
CALL INSERTREPORTFIELDWITHALIAS('CHILDREN_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_CHILDREN, '','')', 'Children''s Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Child's Account Number
CALL INSERTREPORTFIELDWITHALIAS('CHILD_ACCOUNTNUMBER', 'GETVALUE(CONSTITUENT_CHILDREN, '','', CONSTITUENT_CHILDREN_NUMBERS_NUMBER)', 'Child''s Account Number', b'0', 3, @REPORTFIELDGROUP_ID);
-- Child's Name
CALL INSERTREPORTFIELDWITHALIAS('CHILD_NAME', 'GETCONSTITUENTDISPLAYNAME(GETVALUE(CONSTITUENT_CHILDREN, '','', CONSTITUENT_CHILDREN_NUMBERS_NUMBER))', 'Child''s Name', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituent & Siblings Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Relationship Details');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Siblings', 0, 'VW_CONSTITUENTS_SIBLINGS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Siblings Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Siblings Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Siblings' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_SIBLINGS', 'Siblings'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Siblings' Names
CALL INSERTREPORTFIELDWITHALIAS('SIBLINGS_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_SIBLINGS, '','')', 'Siblings'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Sibling's Account Number
CALL INSERTREPORTFIELDWITHALIAS('SIBLING_ACCOUNTNUMBER', 'GETVALUE(CONSTITUENT_SIBLINGS, '','', CONSTITUENT_SIBLINGS_NUMBERS_NUMBER)', 'Sibling''s Account Number', b'0', 3, @REPORTFIELDGROUP_ID);
-- Sibling's Name
CALL INSERTREPORTFIELDWITHALIAS('SIBLING_NAME', 'GETCONSTITUENTDISPLAYNAME(GETVALUE(CONSTITUENT_SIBLINGS, '','', CONSTITUENT_SIBLINGS_NUMBERS_NUMBER))', 'Sibling''s Name', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituent & Friends Field Definitions
--
-- *********************************************************************************************************************



SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Relationship Details');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Friends', 0, 'VW_CONSTITUENTS_FRIENDS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Birth Date', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Friends Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Friends Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Friends' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_FRIENDS', 'Friends'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Friends' Names
CALL INSERTREPORTFIELDWITHALIAS('FRIENDS_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_FRIENDS, '','')', 'Friends'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Friend's Account Number
CALL INSERTREPORTFIELDWITHALIAS('FRIEND_ACCOUNTNUMBER', 'GETVALUE(CONSTITUENT_FRIENDS, '','', CONSTITUENT_FRIENDS_NUMBERS_NUMBER)', 'Friend''s Account Number', b'0', 3, @REPORTFIELDGROUP_ID);
-- Friend's Name
CALL INSERTREPORTFIELDWITHALIAS('FRIEND_NAME', 'GETCONSTITUENTDISPLAYNAME(GETVALUE(CONSTITUENT_FRIENDS, '','', CONSTITUENT_FRIENDS_NUMBERS_NUMBER))', 'Friend''s Name', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituent & Employees Field Definitions
--
-- *********************************************************************************************************************

SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Relationship Details');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Employees', 0, 'VW_CONSTITUENTS_EMPLOYEES', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Birth Date', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Employees Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Employees Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Employees' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_EMPLOYEES', 'Employees'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Employees' Names
CALL INSERTREPORTFIELDWITHALIAS('EMPLOYEES_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_EMPLOYEES, '','')', 'Employees'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Employee's Account Number
CALL INSERTREPORTFIELDWITHALIAS('EMPLOYEE_ACCOUNTNUMBER', 'GETVALUE(CONSTITUENT_EMPLOYEES, '','', CONSTITUENT_EMPLOYEES_NUMBERS_NUMBER)', 'Employee''s Account Number', b'0', 3, @REPORTFIELDGROUP_ID);
-- Parent's Member's Name
CALL INSERTREPORTFIELDWITHALIAS('EMPLOYEE_NAME', 'GETCONSTITUENTDISPLAYNAME(GETVALUE(CONSTITUENT_EMPLOYEES, '','', CONSTITUENT_EMPLOYEES_NUMBERS_NUMBER))', 'Employee''s Name', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituent & Organizations Field Definitions (Parent Organization and Subsidiary List)
--
-- *********************************************************************************************************************



SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Relationship Details');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Organizations', 0, 'VW_CONSTITUENTS_ORGANIZATIONS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Birth Date', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Organizations Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Organizations Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Parent Organization's Account Number
CALL INSERTREPORTFIELDWITHALIAS('PARENTORGANIZATION_ACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.parent'')', 'Parent Organization''s Account Number', b'0', 3, @REPORTFIELDGROUP_ID);
-- Parent Organization's Names
CALL INSERTREPORTFIELDWITHALIAS('PARENTORGANIZATION_NAME', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.parent''))', 'Parent Organization''s Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Subsidiary List's Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_SUBSIDIARYLIST', 'Subsidiary List''s Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Subsidiary List's Names
CALL INSERTREPORTFIELDWITHALIAS('SUBSIDIARYLIST_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_SUBSIDIARYLIST, '','')', 'Subsidiary List''s Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Subsidiary's Account Numbers
CALL INSERTREPORTFIELDWITHALIAS('SUBSIDIARY_ACCOUNTNUMBER', 'GETVALUE(CONSTITUENT_SUBSIDIARYLIST, '','', CONSTITUENT_SUBSIDIARYLIST_NUMBERS_NUMBER)', 'Subsidiary''s Account Number', b'0', 3, @REPORTFIELDGROUP_ID);
-- Subsidiary's Names
CALL INSERTREPORTFIELDWITHALIAS('SUBSIDIARY_NAME', 'GETCONSTITUENTDISPLAYNAME(GETVALUE(CONSTITUENT_SUBSIDIARYLIST, '','', CONSTITUENT_SUBSIDIARYLIST_NUMBERS_NUMBER))', 'Subsidiary''s Name', b'0', 1, @REPORTFIELDGROUP_ID);


-- *********************************************************************************************************************
--
-- Constituent & Primary Contacts Field Definitions
--
-- *********************************************************************************************************************



SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Relationship Details');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Primary Contacts', 0, 'VW_CONSTITUENTS_PRIMARYCONTACTS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Birth Date', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Primary Contacts Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Primary Contacts Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Primary Contacts' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_PRIMARYCONTACTS', 'Primary Contacts'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Primary Contacts' Names
CALL INSERTREPORTFIELDWITHALIAS('PRIMARYCONTACTS_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_PRIMARYCONTACTS, '','')', 'Primary Contacts'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Primary Contact's Account Number
CALL INSERTREPORTFIELDWITHALIAS('PRIMARYCONTACT_ACCOUNTNUMBER', 'GETVALUE(CONSTITUENT_PRIMARYCONTACTS, '','', CONSTITUENT_PRIMARYCONTACTS_NUMBERS_NUMBER)', 'Primary Contact''s Account Number', b'0', 3, @REPORTFIELDGROUP_ID);
-- Primary Contact's Member's Name
CALL INSERTREPORTFIELDWITHALIAS('PRIMARYCONTACT_NAME', 'GETCONSTITUENTDISPLAYNAME(GETVALUE(CONSTITUENT_PRIMARYCONTACTS, '','', CONSTITUENT_PRIMARYCONTACTS_NUMBERS_NUMBER))', 'Primary Contact''s Name', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituent & Billing Contacts Field Definitions
--
-- *********************************************************************************************************************

SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Relationship Details');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Billing Contacts', 0, 'VW_CONSTITUENTS_BILLINGCONTACTS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Birth Date', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Billing Contacts Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Billing Contacts Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Billing Contacts' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_BILLINGCONTACTS', 'Billing Contacts'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Billing Contacts' Names
CALL INSERTREPORTFIELDWITHALIAS('BILLINGCONTACTS_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_BILLINGCONTACTS, '','')', 'Billing Contacts'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Billing Contact's Account Number
CALL INSERTREPORTFIELDWITHALIAS('BILLINGCONTACT_ACCOUNTNUMBER', 'GETVALUE(CONSTITUENT_BILLINGCONTACTS, '','', CONSTITUENT_BILLINGCONTACTS_NUMBERS_NUMBER)', 'Billing Contact''s Account Number', b'0', 3, @REPORTFIELDGROUP_ID);
-- Billing Conatact's Member's Name
CALL INSERTREPORTFIELDWITHALIAS('BILLINGCONTACT_NAME', 'GETCONSTITUENTDISPLAYNAME(GETVALUE(CONSTITUENT_BILLINGCONTACTS, '','', CONSTITUENT_BILLINGCONTACTS_NUMBERS_NUMBER))', 'Billing Contact''s Name', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituent & Sales Contacts Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Relationship Details');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Sales Contacts', 0, 'VW_CONSTITUENTS_SALESCONTACTS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Birth Date', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Sales Contacts Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Sales Contacts Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Sales Contacts' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_SALESCONTACTS', 'Sales Contacts'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Sales Contacts' Names
CALL INSERTREPORTFIELDWITHALIAS('SALESCONTACTS_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_SALESCONTACTS, '','')', 'Sales Contacts'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Sales Contact's Account Number
CALL INSERTREPORTFIELDWITHALIAS('SALESCONTACT_ACCOUNTNUMBER', 'GETVALUE(CONSTITUENT_SALESCONTACTS, '','', CONSTITUENT_SALESCONTACTS_NUMBERS_NUMBER)', 'Sales Contact''s Account Number', b'0', 3, @REPORTFIELDGROUP_ID);
-- Sales Conatact's Member's Name
CALL INSERTREPORTFIELDWITHALIAS('SALESCONTACT_NAME', 'GETCONSTITUENTDISPLAYNAME(GETVALUE(CONSTITUENT_SALESCONTACTS, '','', CONSTITUENT_SALESCONTACTS_NUMBERS_NUMBER))', 'Sales Contact''s Name', b'0', 1, @REPORTFIELDGROUP_ID);


-- *********************************************************************************************************************
--
-- Constituent & Public Relations Contacts Field Definitions
--
-- *********************************************************************************************************************



SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Relationship Details');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Public Relations Contacts', 0, 'VW_CONSTITUENTS_PUBLICRELATIONSCONTACTS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Birth Date', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Public Relations Contacts Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Public Relations Contacts Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Public Relations Contacts' Account Numbers
CALL INSERTREPORTFIELD('CONSTITUENT_PUBLICRELATIONSCONTACTS', 'Public Relations Contacts'' Account Numbers', b'0', 1, @REPORTFIELDGROUP_ID);
-- Public Relations Contacts' Names
CALL INSERTREPORTFIELDWITHALIAS('PUBLICRELATIONSCONTACTS_NAMES', 'GETCONSTITUENTDISPLAYNAMES(CONSTITUENT_PUBLICRELATIONSCONTACTS, '','')', 'Public Relations Contacts'' Names', b'0', 1, @REPORTFIELDGROUP_ID);

-- Public Relations Contact's Account Number
CALL INSERTREPORTFIELDWITHALIAS('PUBLICRELATIONSCONTACT_ACCOUNTNUMBER', 'GETVALUE(CONSTITUENT_PUBLICRELATIONSCONTACTS, '','', CONSTITUENT_PUBLICRELATIONSCONTACTS_NUMBERS_NUMBER)', 'Public Relations Contact''s Account Number', b'0', 3, @REPORTFIELDGROUP_ID);
-- Public Relations Conatact's Member's Name
CALL INSERTREPORTFIELDWITHALIAS('PUBLICRELATIONSCONTACT_NAME', 'GETCONSTITUENTDISPLAYNAME(GETVALUE(CONSTITUENT_PUBLICRELATIONSCONTACTS, '','', CONSTITUENT_PUBLICRELATIONSCONTACTS_NUMBERS_NUMBER))', 'Public Relations Contact''s Name', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Gifts Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Transactions');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Gifts', 0, 'VW_GIFTS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Gift Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Gift Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('GIFT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTNAME', 'GETCONSTITUENTDISPLAYNAME(GIFT_CONSTITUENT_ID)', 'Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Gift Reference Number
CALL INSERTREPORTFIELD('GIFT_GIFT_ID', 'Gift Reference Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Gift Amount
CALL INSERTREPORTFIELD('GIFT_AMOUNT', 'Gift Amount', b'1', 5, @REPORTFIELDGROUP_ID);

-- Currency Code
CALL INSERTREPORTFIELD('GIFT_CURRENCY_CODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Donation Date
CALL INSERTREPORTFIELD('GIFT_DONATION_DATE', 'Donation Date', b'1', 4, @REPORTFIELDGROUP_ID);

-- Postmark Date
CALL INSERTREPORTFIELD('GIFT_POSTMARK_DATE', 'Postmark Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Reference Account Number
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NUMBER', 'GETCUSTOMFIELD(GIFT_GIFT_ID, ''gift'', ''reference'')', 'Reference Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Reference Account Name
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(GIFT_GIFT_ID, ''gift'', ''reference''))', 'Reference Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('GIFT_COMMENTS', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Transaction Date
CALL INSERTREPORTFIELD('GIFT_TRANSACTIONDATE', 'Transaction Date', b'0', 4, @REPORTFIELDGROUP_ID);


-- ***********************************************************************
-- Payment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Payment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Payment Profile Description
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_PAYMENT_PROFILE_DESCRIPTION', 'Payment Profile Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Payment Method
CALL INSERTREPORTFIELD('GIFT_PAYMENT_TYPE', 'Payment Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Type
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_TYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Holder Name
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_HOLDER_NAME', 'Credit Card Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION', 'Credit Card Expiration', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration (Date / Time)
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION_DATE', 'Credit Card Expiration (Date / Time)', b'0', 4, @REPORTFIELDGROUP_ID);

-- ACH Holder Name
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_ACH_HOLDER_NAME', 'ACH Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ACH Routing Number
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_ACH_ROUTING_NUMBER', 'ACH Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Check Number
CALL INSERTREPORTFIELD('GIFT_CHECK_NUMBER', 'Check Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Authorization Code
CALL INSERTREPORTFIELD('GIFT_AUTH_CODE', 'Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 1
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 2
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 3
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_3', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- City
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- State/Province
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_STATE_PROVINCE', 'State/Province', b'0', 1, @REPORTFIELDGROUP_ID);

-- Zip/Postal Code
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_POSTAL_CODE', 'Zip/Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Country
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Number
CALL INSERTREPORTFIELD('GIFT_PAYMENT_PHONE_NUMBER', 'Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Acknowledgment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Acknowledgment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('GIFT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('GIFT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('GIFT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Gifts & Gift Distributions Field Definitions
--
-- *********************************************************************************************************************

SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Transactions');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Gifts & Gift Distributions', 0, 'VW_GIFTS_DISTRIBUTIONS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Gift Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Gift Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('GIFT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(GIFT_CONSTITUENT_ID)', 'Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Gift Reference Number
CALL INSERTREPORTFIELD('GIFT_GIFT_ID', 'Gift Reference Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Gift Amount
CALL INSERTREPORTFIELD('GIFT_AMOUNT', 'Gift Amount', b'1', 5, @REPORTFIELDGROUP_ID);

-- Currency Code
CALL INSERTREPORTFIELD('GIFT_CURRENCY_CODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Donation Date
CALL INSERTREPORTFIELD('GIFT_DONATION_DATE', 'Donation Date', b'1', 4, @REPORTFIELDGROUP_ID);

-- Postmark Date
CALL INSERTREPORTFIELD('GIFT_POSTMARK_DATE', 'Postmark Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Reference Account Number
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NUMBER', 'GETCUSTOMFIELD(GIFT_GIFT_ID, ''gift'', ''reference'')', 'Reference Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Reference Account Name
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(GIFT_GIFT_ID, ''gift'', ''reference''))', 'Reference Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('GIFT_COMMENTS', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Transaction Date
CALL INSERTREPORTFIELD('GIFT_TRANSACTIONDATE', 'Transaction Date', b'0', 4, @REPORTFIELDGROUP_ID);


-- ***********************************************************************
-- Payment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Payment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Payment Profile Description
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_PAYMENT_PROFILE_DESCRIPTION', 'Payment Profile Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Payment Method
CALL INSERTREPORTFIELD('GIFT_PAYMENT_TYPE', 'Payment Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Type
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_TYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Holder Name
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_HOLDER_NAME', 'Credit Card Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION', 'Credit Card Expiration', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration (Date / Time)
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION_DATE', 'Credit Card Expiration (Date / Time)', b'0', 4, @REPORTFIELDGROUP_ID);

-- ACH Holder Name
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_ACH_HOLDER_NAME', 'ACH Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ACH Routing Number
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_ACH_ROUTING_NUMBER', 'ACH Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Check Number
CALL INSERTREPORTFIELD('GIFT_CHECK_NUMBER', 'Check Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Authorization Code
CALL INSERTREPORTFIELD('GIFT_AUTH_CODE', 'Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 1
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 2
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 3
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_3', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- City
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- State/Province
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_STATE_PROVINCE', 'State/Province', b'0', 1, @REPORTFIELDGROUP_ID);

-- Zip/Postal Code
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_POSTAL_CODE', 'Zip/Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Country
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Number
CALL INSERTREPORTFIELD('GIFT_PAYMENT_PHONE_NUMBER', 'Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Acknowledgment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Acknowledgment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('GIFT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('GIFT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('GIFT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Gift Distribution Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Gift Distribution', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Gift Distribution Reference Number
CALL INSERTREPORTFIELD('DISTRO_LINE_DISTRO_LINE_ID', 'Gift Distribution Reference Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Gift Distribution Amount
CALL INSERTREPORTFIELD('DISTRO_LINE_AMOUNT', 'Gift Distribution Amount', b'1', 5, @REPORTFIELDGROUP_ID);

-- Percentage
CALL INSERTREPORTFIELD('DISTRO_LINE_PERCENTAGE', 'Percentage', b'0', 3, @REPORTFIELDGROUP_ID);

-- Designation
CALL INSERTREPORTFIELD('DISTRO_LINE_PROJECT_CODE', 'Designation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Designation Description
CALL INSERTREPORTFIELD('DISTRO_LINE_PROJECT_CODE_DESCRIPTION', 'Designation Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Motivation
CALL INSERTREPORTFIELD('DISTRO_LINE_MOTIVATION_CODE', 'Motivation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Motivation Description
CALL INSERTREPORTFIELD('DISTRO_LINE_MOTIVATION_CODE_DESCRIPTION', 'Motivation Description', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Payment History Field Definitions
--
-- *********************************************************************************************************************

SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Transactions');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Payment History', 0, 'VW_PAYMENTHISTORY', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Payment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Payment History', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Payment History ID
CALL INSERTREPORTFIELD('PAYMENT_HISTORY_PAYMENT_HISTORY_ID', 'Payment History ID', b'0', 3, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('PAYMENT_HISTORY_CONSTITUENT_ID', 'Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Account Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(PAYMENT_HISTORY_CONSTITUENT_ID)', 'Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Payment History Type
CALL INSERTREPORTFIELD('PAYMENT_HISTORY_PAYMENT_HISTORY_TYPE', 'Payment History Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Gift ID
CALL INSERTREPORTFIELD('PAYMENT_HISTORY_GIFT_ID', 'Gift ID', b'0', 3, @REPORTFIELDGROUP_ID);

-- Transaction Date
CALL INSERTREPORTFIELD('PAYMENT_HISTORY_TRANSACTION_DATE', 'Transaction Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Payment Method
CALL INSERTREPORTFIELD('PAYMENT_HISTORY_PAYMENT_TYPE', 'Payment Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Amount
CALL INSERTREPORTFIELD('PAYMENT_HISTORY_AMOUNT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Currency Code
CALL INSERTREPORTFIELD('PAYMENT_HISTORY_CURRENCY_CODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Description
CALL INSERTREPORTFIELD('PAYMENT_HISTORY_PAYMENT_DESC', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Payment Methods Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Transactions');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Payment Methods', 0, 'VW_PAYMENTMETHODS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Payment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Payment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Payment Method ID
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_PAYMENT_SOURCE_ID', 'Payment Method ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(PAYMENT_SOURCE_CONSTITUENT_ID)', 'Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Payment Profile Description
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_PAYMENT_PROFILE_DESCRIPTION', 'Payment Profile Description', b'1', 1, @REPORTFIELDGROUP_ID);

-- Payment Method
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_PAYMENT_TYPE', 'Payment Method', b'1', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Holder Name
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_CREDIT_CARD_HOLDER_NAME', 'Credit Card Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Type
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_CREDIT_CARD_TYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION', 'Credit Card Expiration', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration (Date / Time)
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION_DATE', 'Credit Card Expiration (Date / Time)', b'0', 4, @REPORTFIELDGROUP_ID);

-- ACH Holder Name
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ACH_HOLDER_NAME', 'ACH Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ACH Routing Number
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ACH_ROUTING_NUMBER', 'ACH Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Default Address/Phone Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Default Address/Phone Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Address Line 1
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ADDRESS_ADDRESS_LINE_1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 2
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ADDRESS_ADDRESS_LINE_2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 3
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ADDRESS_ADDRESS_LINE_3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- City
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ADDRESS_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- State/Province
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ADDRESS_STATE_PROVINCE', 'State/Province', b'0', 1, @REPORTFIELDGROUP_ID);

-- Zip/Postal Code
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ADDRESS_POSTAL_CODE', 'Zip/Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Country
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ADDRESS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Number
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_PHONE_NUMBER', 'Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Pledges Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Transactions');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Pledges', 0, 'VW_PLEDGES', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Pledge Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Pledge Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account
CALL INSERTREPORTFIELD('COMMITMENT_COMMITMENT_ID', 'Pledge ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('COMMITMENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(COMMITMENT_CONSTITUENT_ID)', 'Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recurring
CALL INSERTREPORTFIELD('COMMITMENT_RECURRING', 'Recurring', b'0', 6, @REPORTFIELDGROUP_ID);

-- Amount Per Gift
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_PER_GIFT', 'Amount Per Gift', b'0', 5, @REPORTFIELDGROUP_ID);

-- Amount Total
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_TOTAL', 'Amount Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Currency Code
CALL INSERTREPORTFIELD('COMMITMENT_CURRENCY_CODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Status
CALL INSERTREPORTFIELD('COMMITMENT_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Frequency
CALL INSERTREPORTFIELD('COMMITMENT_FREQUENCY', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Pledge Date
CALL INSERTREPORTFIELD('COMMITMENT_PLEDGE_DATE', 'Pledge Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Projected Date
CALL INSERTREPORTFIELD('COMMITMENT_PROJECTED_DATE', 'Projected Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Start Date
CALL INSERTREPORTFIELD('COMMITMENT_START_DATE', 'Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- End Date
CALL INSERTREPORTFIELD('COMMITMENT_END_DATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('COMMITMENT_COMMENTS', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('COMMITMENT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Acknowledgment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Acknowledgment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('COMMITMENT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Pledges & Distributions Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Transactions');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Pledges & Distributions', 0, 'VW_PLEDGES_DISTRIBUTIONS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Pledge Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Pledge Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account
CALL INSERTREPORTFIELD('COMMITMENT_COMMITMENT_ID', 'Pledge ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('COMMITMENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Recurring
CALL INSERTREPORTFIELD('COMMITMENT_RECURRING', 'Recurring', b'0', 6, @REPORTFIELDGROUP_ID);

-- Amount Per Gift
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_PER_GIFT', 'Amount Per Gift', b'0', 5, @REPORTFIELDGROUP_ID);

-- Amount Total
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_TOTAL', 'Amount Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Currency Code
CALL INSERTREPORTFIELD('COMMITMENT_CURRENCY_CODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Status
CALL INSERTREPORTFIELD('COMMITMENT_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Frequency
CALL INSERTREPORTFIELD('COMMITMENT_FREQUENCY', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Pledge Date
CALL INSERTREPORTFIELD('COMMITMENT_PLEDGE_DATE', 'Pledge Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Projected Date
CALL INSERTREPORTFIELD('COMMITMENT_PROJECTED_DATE', 'Projected Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Start Date
CALL INSERTREPORTFIELD('COMMITMENT_START_DATE', 'Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- End Date
CALL INSERTREPORTFIELD('COMMITMENT_END_DATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('COMMITMENT_COMMENTS', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('COMMITMENT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Acknowledgment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Acknowledgment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('COMMITMENT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Pledge Distribution Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Pledge Distribution', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Plege Distribution Reference Number
CALL INSERTREPORTFIELD('DISTRO_LINE_DISTRO_LINE_ID', 'Pledge Distribution Reference Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Pledge Distribution Amount
CALL INSERTREPORTFIELD('DISTRO_LINE_AMOUNT', 'Pledge Distribution Amount', b'1', 5, @REPORTFIELDGROUP_ID);

-- Percentage
CALL INSERTREPORTFIELD('DISTRO_LINE_PERCENTAGE', 'Percentage', b'0', 3, @REPORTFIELDGROUP_ID);

-- Designation
CALL INSERTREPORTFIELD('DISTRO_LINE_PROJECT_CODE', 'Designation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Designation Description
CALL INSERTREPORTFIELD('DISTRO_LINE_PROJECT_CODE_DESCRIPTION', 'Designation Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Motivation
CALL INSERTREPORTFIELD('DISTRO_LINE_MOTIVATION_CODE', 'Motivation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Motivation Description
CALL INSERTREPORTFIELD('DISTRO_LINE_MOTIVATION_CODE_DESCRIPTION', 'Motivation Description', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Recurring Gifts Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Transactions');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Recurring Gifts', 0, 'VW_RECURRINGGIFTS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Recurring Gift Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Recurring Gift Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Recurring Gift ID
CALL INSERTREPORTFIELD('COMMITMENT_COMMITMENT_ID', 'Recurring Gift ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('COMMITMENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(COMMITMENT_CONSTITUENT_ID)', 'Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Auto Pay
CALL INSERTREPORTFIELD('COMMITMENT_AUTO_PAY', 'Auto Pay', b'0', 6, @REPORTFIELDGROUP_ID);

-- Amount Per Gift
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_PER_GIFT', 'Amount Per Gift', b'1', 5, @REPORTFIELDGROUP_ID);

-- Amount Total
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_TOTAL', 'Amount Total', b'1', 5, @REPORTFIELDGROUP_ID);

-- Currency Code
CALL INSERTREPORTFIELD('COMMITMENT_CURRENCY_CODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Frequency
CALL INSERTREPORTFIELD('COMMITMENT_FREQUENCY', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Start Date
CALL INSERTREPORTFIELD('COMMITMENT_START_DATE', 'Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- End Date
CALL INSERTREPORTFIELD('COMMITMENT_END_DATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Status
CALL INSERTREPORTFIELD('COMMITMENT_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Reference Account Number
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NUMBER', 'GETCUSTOMFIELD(COMMITMENT_COMMITMENT_ID, ''commitment'', ''reference'')', 'Reference Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Reference Account Name
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(COMMITMENT_COMMITMENT_ID, ''commitment'', ''reference''))', 'Reference Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('COMMITMENT_COMMENTS', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Entry Date
CALL INSERTREPORTFIELD('COMMITMENT_LAST_ENTRY_DATE', 'Last Entry Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Recurring Gift Create Date
CALL INSERTREPORTFIELD('COMMITMENT_CREATE_DATE', 'Recurring Gift Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Recurring Gift Update Date
CALL INSERTREPORTFIELD('COMMITMENT_UPDATE_DATE', 'Recurring Gift Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Payment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Payment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Payment Profile Description
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_PAYMENT_PROFILE_DESCRIPTION', 'Payment Profile Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Payment Method
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_TYPE', 'Payment Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Type
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_TYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Holder Name
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_HOLDER_NAME', 'Credit Card Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION', 'Credit Card Expiration', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration (Date / Time)
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION_DATE', 'Credit Card Expiration (Date / Time)', b'0', 4, @REPORTFIELDGROUP_ID);

-- ACH Holder Name
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_ACH_HOLDER_NAME', 'ACH Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ACH Routing Number
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_ACH_ROUTING_NUMBER', 'ACH Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Check Number
CALL INSERTREPORTFIELD('COMMITMENT_CHECK_NUMBER', 'Check Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Address Line 1
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_ADDRESS_LINE_1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 2
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_ADDRESS_LINE_2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 3
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_ADDRESS_LINE_3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- City
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- State/Province
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_STATE_PROVINCE', 'State/Province', b'0', 1, @REPORTFIELDGROUP_ID);

-- Zip/Postal Code
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_POSTAL_CODE', 'Zip/Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Country
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Number
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_PHONE_NUMBER', 'Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Acknowledgment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Acknowledgment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('COMMITMENT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Recurring Gifts & Distributions Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Transactions');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Recurring Gifts & Distributions', 0, 'VW_RECURRINGGIFTS_DISTRIBUTIONS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Recurring Gift Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Recurring Gift Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Recurring Gift ID
CALL INSERTREPORTFIELD('COMMITMENT_COMMITMENT_ID', 'Recurring Gift ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('COMMITMENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(COMMITMENT_CONSTITUENT_ID)', 'Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Auto Pay
CALL INSERTREPORTFIELD('COMMITMENT_AUTO_PAY', 'Auto Pay', b'0', 6, @REPORTFIELDGROUP_ID);

-- Amount Per Gift
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_PER_GIFT', 'Amount Per Gift', b'1', 5, @REPORTFIELDGROUP_ID);

-- Amount Total
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_TOTAL', 'Amount Total', b'1', 5, @REPORTFIELDGROUP_ID);

-- Currency Code
CALL INSERTREPORTFIELD('COMMITMENT_CURRENCY_CODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Frequency
CALL INSERTREPORTFIELD('COMMITMENT_FREQUENCY', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Start Date
CALL INSERTREPORTFIELD('COMMITMENT_START_DATE', 'Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- End Date
CALL INSERTREPORTFIELD('COMMITMENT_END_DATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Status
CALL INSERTREPORTFIELD('COMMITMENT_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Reference Account Number
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NUMBER', 'GETCUSTOMFIELD(COMMITMENT_COMMITMENT_ID, ''commitment'', ''reference'')', 'Reference Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Reference Account Name
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(COMMITMENT_COMMITMENT_ID, ''commitment'', ''reference''))', 'Reference Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('COMMITMENT_COMMENTS', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Entry Date
CALL INSERTREPORTFIELD('COMMITMENT_LAST_ENTRY_DATE', 'Last Entry Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Recurring Gift Create Date
CALL INSERTREPORTFIELD('COMMITMENT_CREATE_DATE', 'Recurring Gift Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Recurring Gift Update Date
CALL INSERTREPORTFIELD('COMMITMENT_UPDATE_DATE', 'Recurring Gift Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Payment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Payment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Payment Profile Description
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_PAYMENT_PROFILE_DESCRIPTION', 'Payment Profile Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Payment Method
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_TYPE', 'Payment Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Type
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_TYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Holder Name
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_HOLDER_NAME', 'Credit Card Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION', 'Credit Card Expiration', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration (Date / Time)
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION_DATE', 'Credit Card Expiration (Date / Time)', b'0', 4, @REPORTFIELDGROUP_ID);

-- ACH Holder Name
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_ACH_HOLDER_NAME', 'ACH Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ACH Routing Number
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_ACH_ROUTING_NUMBER', 'ACH Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Check Number
CALL INSERTREPORTFIELD('COMMITMENT_CHECK_NUMBER', 'Check Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Address Line 1
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_ADDRESS_LINE_1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 2
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_ADDRESS_LINE_2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 3
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_ADDRESS_LINE_3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- City
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- State/Province
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_STATE_PROVINCE', 'State/Province', b'0', 1, @REPORTFIELDGROUP_ID);

-- Zip/Postal Code
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_POSTAL_CODE', 'Zip/Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Country
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Number
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_PHONE_NUMBER', 'Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Acknowledgment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Acknowledgment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('COMMITMENT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Gift Distribution Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Recurring Gift Distribution', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Gift Distribution Reference Number
CALL INSERTREPORTFIELD('DISTRO_LINE_DISTRO_LINE_ID', 'Gift Distribution Reference Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Gift Distribution Amount
CALL INSERTREPORTFIELD('DISTRO_LINE_AMOUNT', 'Gift Distribution Amount', b'1', 5, @REPORTFIELDGROUP_ID);

-- Percentage
CALL INSERTREPORTFIELD('DISTRO_LINE_PERCENTAGE', 'Percentage', b'0', 3, @REPORTFIELDGROUP_ID);

-- Designation
CALL INSERTREPORTFIELD('DISTRO_LINE_PROJECT_CODE', 'Designation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Designation Description
CALL INSERTREPORTFIELD('DISTRO_LINE_PROJECT_CODE_DESCRIPTION', 'Designation Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Motivation
CALL INSERTREPORTFIELD('DISTRO_LINE_MOTIVATION_CODE', 'Motivation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Motivation Description
CALL INSERTREPORTFIELD('DISTRO_LINE_MOTIVATION_CODE_DESCRIPTION', 'Motivation Description', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituents & Gifts Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Transactions');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Gifts', 0, 'VW_CONSTITUENTS_GIFTS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Gift Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Gift Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Gift Reference Number
CALL INSERTREPORTFIELD('GIFT_GIFT_ID', 'Gift Reference Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Gift Amount
CALL INSERTREPORTFIELD('GIFT_AMOUNT', 'Gift Amount', b'1', 5, @REPORTFIELDGROUP_ID);

-- Currency Code
CALL INSERTREPORTFIELD('GIFT_CURRENCY_CODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Donation Date
CALL INSERTREPORTFIELD('GIFT_DONATION_DATE', 'Donation Date', b'1', 4, @REPORTFIELDGROUP_ID);

-- Postmark Date
CALL INSERTREPORTFIELD('GIFT_POSTMARK_DATE', 'Postmark Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Reference Account Number
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NUMBER', 'GETCUSTOMFIELD(GIFT_GIFT_ID, ''gift'', ''reference'')', 'Reference Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Reference Account Name
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(GIFT_GIFT_ID, ''gift'', ''reference''))', 'Reference Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('GIFT_COMMENTS', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Transaction Date
CALL INSERTREPORTFIELD('GIFT_TRANSACTIONDATE', 'Transaction Date', b'0', 4, @REPORTFIELDGROUP_ID);


-- ***********************************************************************
-- Payment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Payment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Payment Profile Description
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_PAYMENT_PROFILE_DESCRIPTION', 'Payment Profile Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Payment Method
CALL INSERTREPORTFIELD('GIFT_PAYMENT_TYPE', 'Payment Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Type
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_TYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Holder Name
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_HOLDER_NAME', 'Credit Card Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION', 'Credit Card Expiration', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration (Date / Time)
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION_DATE', 'Credit Card Expiration (Date / Time)', b'0', 4, @REPORTFIELDGROUP_ID);

-- ACH Holder Name
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_ACH_HOLDER_NAME', 'ACH Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ACH Routing Number
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_ACH_ROUTING_NUMBER', 'ACH Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Check Number
CALL INSERTREPORTFIELD('GIFT_CHECK_NUMBER', 'Check Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Authorization Code
CALL INSERTREPORTFIELD('GIFT_AUTH_CODE', 'Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 1
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 2
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 3
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_3', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- City
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- State/Province
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_STATE_PROVINCE', 'State/Province', b'0', 1, @REPORTFIELDGROUP_ID);

-- Zip/Postal Code
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_POSTAL_CODE', 'Zip/Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Country
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Number
CALL INSERTREPORTFIELD('GIFT_PAYMENT_PHONE_NUMBER', 'Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Acknowledgment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Acknowledgment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('GIFT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('GIFT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('GIFT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituents & Gift Distributions Field Definitions
--
-- *********************************************************************************************************************

SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Transactions');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Gift Distributions', 0, 'VW_CONSTITUENTS_GIFTDISTRIBUTIONS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);


-- ***********************************************************************
-- Gift Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Gift Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Gift Reference Number
CALL INSERTREPORTFIELD('GIFT_GIFT_ID', 'Gift Reference Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Gift Amount
CALL INSERTREPORTFIELD('GIFT_AMOUNT', 'Gift Amount', b'1', 5, @REPORTFIELDGROUP_ID);

-- Currency Code
CALL INSERTREPORTFIELD('GIFT_CURRENCY_CODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Donation Date
CALL INSERTREPORTFIELD('GIFT_DONATION_DATE', 'Donation Date', b'1', 4, @REPORTFIELDGROUP_ID);

-- Postmark Date
CALL INSERTREPORTFIELD('GIFT_POSTMARK_DATE', 'Postmark Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Reference Account Number
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NUMBER', 'GETCUSTOMFIELD(GIFT_GIFT_ID, ''gift'', ''reference'')', 'Reference Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Reference Account Name
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(GIFT_GIFT_ID, ''gift'', ''reference''))', 'Reference Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('GIFT_COMMENTS', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Transaction Date
CALL INSERTREPORTFIELD('GIFT_TRANSACTIONDATE', 'Transaction Date', b'0', 4, @REPORTFIELDGROUP_ID);


-- ***********************************************************************
-- Payment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Payment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Payment Profile Description
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_PAYMENT_PROFILE_DESCRIPTION', 'Payment Profile Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Payment Method
CALL INSERTREPORTFIELD('GIFT_PAYMENT_TYPE', 'Payment Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Type
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_TYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Holder Name
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_HOLDER_NAME', 'Credit Card Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION', 'Credit Card Expiration', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration (Date / Time)
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION_DATE', 'Credit Card Expiration (Date / Time)', b'0', 4, @REPORTFIELDGROUP_ID);

-- ACH Holder Name
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_ACH_HOLDER_NAME', 'ACH Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ACH Routing Number
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_ACH_ROUTING_NUMBER', 'ACH Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Check Number
CALL INSERTREPORTFIELD('GIFT_CHECK_NUMBER', 'Check Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Authorization Code
CALL INSERTREPORTFIELD('GIFT_AUTH_CODE', 'Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 1
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 2
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 3
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_3', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- City
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- State/Province
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_STATE_PROVINCE', 'State/Province', b'0', 1, @REPORTFIELDGROUP_ID);

-- Zip/Postal Code
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_POSTAL_CODE', 'Zip/Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Country
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Number
CALL INSERTREPORTFIELD('GIFT_PAYMENT_PHONE_NUMBER', 'Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Acknowledgment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Acknowledgment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('GIFT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('GIFT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('GIFT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Gift Distribution Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Gift Distribution', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Gift Distribution Reference Number
CALL INSERTREPORTFIELD('DISTRO_LINE_DISTRO_LINE_ID', 'Gift Distribution Reference Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Gift Distribution Amount
CALL INSERTREPORTFIELD('DISTRO_LINE_AMOUNT', 'Gift Distribution Amount', b'1', 5, @REPORTFIELDGROUP_ID);

-- Percentage
CALL INSERTREPORTFIELD('DISTRO_LINE_PERCENTAGE', 'Percentage', b'0', 3, @REPORTFIELDGROUP_ID);

-- Designation
CALL INSERTREPORTFIELD('DISTRO_LINE_PROJECT_CODE', 'Designation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Designation Description
CALL INSERTREPORTFIELD('DISTRO_LINE_PROJECT_CODE_DESCRIPTION', 'Designation Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Motivation
CALL INSERTREPORTFIELD('DISTRO_LINE_MOTIVATION_CODE', 'Motivation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Motivation Description
CALL INSERTREPORTFIELD('DISTRO_LINE_MOTIVATION_CODE_DESCRIPTION', 'Motivation Description', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituents & Payment History Field Definitions
--
-- *********************************************************************************************************************

SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Transactions');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Payment History', 0, 'VW_CONSTITUENTS_PAYMENTHISTORY', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Payment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Payment History', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Payment History ID
CALL INSERTREPORTFIELD('PAYMENT_HISTORY_PAYMENT_HISTORY_ID', 'Payment History ID', b'0', 3, @REPORTFIELDGROUP_ID);

-- Payment History Type
CALL INSERTREPORTFIELD('PAYMENT_HISTORY_PAYMENT_HISTORY_TYPE', 'Payment History Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Gift ID
CALL INSERTREPORTFIELD('PAYMENT_HISTORY_GIFT_ID', 'Gift ID', b'0', 3, @REPORTFIELDGROUP_ID);

-- Transaction Date
CALL INSERTREPORTFIELD('PAYMENT_HISTORY_TRANSACTION_DATE', 'Transaction Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Payment Method
CALL INSERTREPORTFIELD('PAYMENT_HISTORY_PAYMENT_TYPE', 'Payment Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Amount
CALL INSERTREPORTFIELD('PAYMENT_HISTORY_AMOUNT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Currency Code
CALL INSERTREPORTFIELD('PAYMENT_HISTORY_CURRENCY_CODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Description
CALL INSERTREPORTFIELD('PAYMENT_HISTORY_PAYMENT_DESC', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituents & Payment Methods Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Transactions');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Payment Methods', 0, 'VW_CONSTITUENTS_PAYMENTMETHODS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Payment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Payment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Payment Method ID
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_PAYMENT_SOURCE_ID', 'Payment Method ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Payment Profile Description
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_PAYMENT_PROFILE_DESCRIPTION', 'Payment Profile Description', b'1', 1, @REPORTFIELDGROUP_ID);

-- Payment Method
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_PAYMENT_TYPE', 'Payment Method', b'1', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Holder Name
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_HOLDER_NAME', 'Credit Card Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Type
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_TYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION', 'Credit Card Expiration', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration (Date / Time)
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION_DATE', 'Credit Card Expiration (Date / Time)', b'0', 4, @REPORTFIELDGROUP_ID);

-- ACH Holder Name
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_ACH_HOLDER_NAME', 'ACH Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ACH Routing Number
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_ACH_ROUTING_NUMBER', 'ACH Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Default Address/Phone Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Default Address/Phone Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Address Line 1
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 2
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 3
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- City
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- State/Province
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_STATE_PROVINCE', 'State/Province', b'0', 1, @REPORTFIELDGROUP_ID);

-- Zip/Postal Code
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_POSTAL_CODE', 'Zip/Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Country
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Number
CALL INSERTREPORTFIELD('GIFT_PAYMENT_PHONE_NUMBER', 'Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituents & Pledges Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Transactions');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Pledges', 0, 'VW_CONSTITUENTS_PLEDGES', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Pledge Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Pledge Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account
CALL INSERTREPORTFIELD('COMMITMENT_COMMITMENT_ID', 'Pledge ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Recurring
CALL INSERTREPORTFIELD('COMMITMENT_RECURRING', 'Recurring', b'0', 6, @REPORTFIELDGROUP_ID);

-- Amount Per Gift
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_PER_GIFT', 'Amount Per Gift', b'0', 5, @REPORTFIELDGROUP_ID);

-- Amount Total
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_TOTAL', 'Amount Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Currency Code
CALL INSERTREPORTFIELD('COMMITMENT_CURRENCY_CODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Status
CALL INSERTREPORTFIELD('COMMITMENT_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Frequency
CALL INSERTREPORTFIELD('COMMITMENT_FREQUENCY', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Pledge Date
CALL INSERTREPORTFIELD('COMMITMENT_PLEDGE_DATE', 'Pledge Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Projected Date
CALL INSERTREPORTFIELD('COMMITMENT_PROJECTED_DATE', 'Projected Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Start Date
CALL INSERTREPORTFIELD('COMMITMENT_START_DATE', 'Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- End Date
CALL INSERTREPORTFIELD('COMMITMENT_END_DATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('COMMITMENT_COMMENTS', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('COMMITMENT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Acknowledgment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Acknowledgment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('COMMITMENT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituents & Pledges & Distributions Field Definitions
--
-- *********************************************************************************************************************

SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Transactions');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Pledges & Distributions', 0, 'VW_CONSTITUENTS_PLEDGES_DISTRIBUTIONS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Pledge Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Pledge Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account
CALL INSERTREPORTFIELD('COMMITMENT_COMMITMENT_ID', 'Pledge ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('COMMITMENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Recurring
CALL INSERTREPORTFIELD('COMMITMENT_RECURRING', 'Recurring', b'0', 6, @REPORTFIELDGROUP_ID);

-- Amount Per Gift
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_PER_GIFT', 'Amount Per Gift', b'0', 5, @REPORTFIELDGROUP_ID);

-- Amount Total
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_TOTAL', 'Amount Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Currency Code
CALL INSERTREPORTFIELD('COMMITMENT_CURRENCY_CODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Status
CALL INSERTREPORTFIELD('COMMITMENT_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Frequency
CALL INSERTREPORTFIELD('COMMITMENT_FREQUENCY', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Pledge Date
CALL INSERTREPORTFIELD('COMMITMENT_PLEDGE_DATE', 'Pledge Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Projected Date
CALL INSERTREPORTFIELD('COMMITMENT_PROJECTED_DATE', 'Projected Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Start Date
CALL INSERTREPORTFIELD('COMMITMENT_START_DATE', 'Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- End Date
CALL INSERTREPORTFIELD('COMMITMENT_END_DATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('COMMITMENT_COMMENTS', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('COMMITMENT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Acknowledgment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Acknowledgment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('COMMITMENT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Pledge Distribution Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Pledge Distribution', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Plege Distribution Reference Number
CALL INSERTREPORTFIELD('DISTRO_LINE_DISTRO_LINE_ID', 'Pledge Distribution Reference Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Pledge Distribution Amount
CALL INSERTREPORTFIELD('DISTRO_LINE_AMOUNT', 'Pledge Distribution Amount', b'1', 5, @REPORTFIELDGROUP_ID);

-- Percentage
CALL INSERTREPORTFIELD('DISTRO_LINE_PERCENTAGE', 'Percentage', b'0', 3, @REPORTFIELDGROUP_ID);

-- Designation
CALL INSERTREPORTFIELD('DISTRO_LINE_PROJECT_CODE', 'Designation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Designation Description
CALL INSERTREPORTFIELD('DISTRO_LINE_PROJECT_CODE_DESCRIPTION', 'Designation Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Motivation
CALL INSERTREPORTFIELD('DISTRO_LINE_MOTIVATION_CODE', 'Motivation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Motivation Description
CALL INSERTREPORTFIELD('DISTRO_LINE_MOTIVATION_CODE_DESCRIPTION', 'Motivation Description', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituents & Recurring Gifts Field Definitions
--
-- *********************************************************************************************************************

SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Transactions');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Recurring Gifts', 0, 'VW_CONSTITUENTS_RECURRINGGIFTS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Recurring Gift Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Recurring Gift Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Recurring Gift ID
CALL INSERTREPORTFIELD('COMMITMENT_COMMITMENT_ID', 'Recurring Gift ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Auto Pay
CALL INSERTREPORTFIELD('COMMITMENT_AUTO_PAY', 'Auto Pay', b'0', 6, @REPORTFIELDGROUP_ID);

-- Amount Per Gift
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_PER_GIFT', 'Amount Per Gift', b'1', 5, @REPORTFIELDGROUP_ID);

-- Amount Total
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_TOTAL', 'Amount Total', b'1', 5, @REPORTFIELDGROUP_ID);

-- Currency Code
CALL INSERTREPORTFIELD('COMMITMENT_CURRENCY_CODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Frequency
CALL INSERTREPORTFIELD('COMMITMENT_FREQUENCY', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Start Date
CALL INSERTREPORTFIELD('COMMITMENT_START_DATE', 'Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- End Date
CALL INSERTREPORTFIELD('COMMITMENT_END_DATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Status
CALL INSERTREPORTFIELD('COMMITMENT_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Reference Account Number
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NUMBER', 'GETCUSTOMFIELD(COMMITMENT_COMMITMENT_ID, ''commitment'', ''reference'')', 'Reference Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Reference Account Name
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(COMMITMENT_COMMITMENT_ID, ''commitment'', ''reference''))', 'Reference Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('COMMITMENT_COMMENTS', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Entry Date
CALL INSERTREPORTFIELD('COMMITMENT_LAST_ENTRY_DATE', 'Last Entry Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Recurring Gift Create Date
CALL INSERTREPORTFIELD('COMMITMENT_CREATE_DATE', 'Recurring Gift Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Recurring Gift Update Date
CALL INSERTREPORTFIELD('COMMITMENT_UPDATE_DATE', 'Recurring Gift Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Payment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Payment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Payment Profile Description
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_PAYMENT_PROFILE_DESCRIPTION', 'Payment Profile Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Payment Method
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_TYPE', 'Payment Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Type
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_TYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Holder Name
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_HOLDER_NAME', 'Credit Card Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION', 'Credit Card Expiration', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration (Date / Time)
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION_DATE', 'Credit Card Expiration (Date / Time)', b'0', 4, @REPORTFIELDGROUP_ID);

-- ACH Holder Name
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_ACH_HOLDER_NAME', 'ACH Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ACH Routing Number
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_ACH_ROUTING_NUMBER', 'ACH Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Check Number
CALL INSERTREPORTFIELD('COMMITMENT_CHECK_NUMBER', 'Check Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Address Line 1
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_ADDRESS_LINE_1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 2
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_ADDRESS_LINE_2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 3
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_ADDRESS_LINE_3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- City
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- State/Province
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_STATE_PROVINCE', 'State/Province', b'0', 1, @REPORTFIELDGROUP_ID);

-- Zip/Postal Code
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_POSTAL_CODE', 'Zip/Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Country
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Number
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_PHONE_NUMBER', 'Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Acknowledgment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Acknowledgment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('COMMITMENT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituents & Recurring Gifts & Distributions Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Constituents & Transactions');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituents & Recurring Gifts & Distributions', 0, 'VW_CONSTITUENTS_RECURRINGGIFTS_DISTRIBUTIONS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'1', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Recurring Gift Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Recurring Gift Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Recurring Gift ID
CALL INSERTREPORTFIELD('COMMITMENT_COMMITMENT_ID', 'Recurring Gift ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Auto Pay
CALL INSERTREPORTFIELD('COMMITMENT_AUTO_PAY', 'Auto Pay', b'0', 6, @REPORTFIELDGROUP_ID);

-- Amount Per Gift
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_PER_GIFT', 'Amount Per Gift', b'1', 5, @REPORTFIELDGROUP_ID);

-- Amount Total
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_TOTAL', 'Amount Total', b'1', 5, @REPORTFIELDGROUP_ID);

-- Currency Code
CALL INSERTREPORTFIELD('COMMITMENT_CURRENCY_CODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Frequency
CALL INSERTREPORTFIELD('COMMITMENT_FREQUENCY', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Start Date
CALL INSERTREPORTFIELD('COMMITMENT_START_DATE', 'Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- End Date
CALL INSERTREPORTFIELD('COMMITMENT_END_DATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Status
CALL INSERTREPORTFIELD('COMMITMENT_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Reference Account Number
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NUMBER', 'GETCUSTOMFIELD(COMMITMENT_COMMITMENT_ID, ''commitment'', ''reference'')', 'Reference Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Reference Account Name
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(COMMITMENT_COMMITMENT_ID, ''commitment'', ''reference''))', 'Reference Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('COMMITMENT_COMMENTS', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Entry Date
CALL INSERTREPORTFIELD('COMMITMENT_LAST_ENTRY_DATE', 'Last Entry Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Recurring Gift Create Date
CALL INSERTREPORTFIELD('COMMITMENT_CREATE_DATE', 'Recurring Gift Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Recurring Gift Update Date
CALL INSERTREPORTFIELD('COMMITMENT_UPDATE_DATE', 'Recurring Gift Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Payment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Payment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Payment Profile Description
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_PAYMENT_PROFILE_DESCRIPTION', 'Payment Profile Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Payment Method
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_TYPE', 'Payment Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Type
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_TYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Holder Name
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_HOLDER_NAME', 'Credit Card Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION', 'Credit Card Expiration', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration (Date / Time)
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION_DATE', 'Credit Card Expiration (Date / Time)', b'0', 4, @REPORTFIELDGROUP_ID);

-- ACH Holder Name
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_ACH_HOLDER_NAME', 'ACH Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ACH Routing Number
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_ACH_ROUTING_NUMBER', 'ACH Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Check Number
CALL INSERTREPORTFIELD('COMMITMENT_CHECK_NUMBER', 'Check Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Address Line 1
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_ADDRESS_LINE_1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 2
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_ADDRESS_LINE_2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 3
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_ADDRESS_LINE_3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- City
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- State/Province
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_STATE_PROVINCE', 'State/Province', b'0', 1, @REPORTFIELDGROUP_ID);

-- Zip/Postal Code
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_POSTAL_CODE', 'Zip/Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Country
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Number
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_PHONE_NUMBER', 'Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Acknowledgment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Acknowledgment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('COMMITMENT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Gift Distribution Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Recurring Gift Distribution Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Gift Distribution Reference Number
CALL INSERTREPORTFIELD('DISTRO_LINE_DISTRO_LINE_ID', 'Gift Distribution Reference Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Gift Distribution Amount
CALL INSERTREPORTFIELD('DISTRO_LINE_AMOUNT', 'Gift Distribution Amount', b'1', 5, @REPORTFIELDGROUP_ID);

-- Percentage
CALL INSERTREPORTFIELD('DISTRO_LINE_PERCENTAGE', 'Percentage', b'0', 3, @REPORTFIELDGROUP_ID);

-- Designation
CALL INSERTREPORTFIELD('DISTRO_LINE_PROJECT_CODE', 'Designation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Designation Description
CALL INSERTREPORTFIELD('DISTRO_LINE_PROJECT_CODE_DESCRIPTION', 'Designation Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Motivation
CALL INSERTREPORTFIELD('DISTRO_LINE_MOTIVATION_CODE', 'Motivation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Motivation Description
CALL INSERTREPORTFIELD('DISTRO_LINE_MOTIVATION_CODE_DESCRIPTION', 'Motivation Description', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Audit History Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Audit History');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Audit History', 0, 'VW_AUDITHISTORY', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Audit History Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Audit History Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Audit History ID
CALL INSERTREPORTFIELD('AUDIT_AUDIT_ID', 'Audit History ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Date
CALL INSERTREPORTFIELD('AUDIT_DATE', 'Date', b'1', 4, @REPORTFIELDGROUP_ID);

-- User
CALL INSERTREPORTFIELD('AUDIT_USER', 'User', b'1', 1, @REPORTFIELDGROUP_ID);

-- Type
CALL INSERTREPORTFIELD('AUDIT_AUDIT_TYPE', 'Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Description
CALL INSERTREPORTFIELD('AUDIT_DESCRIPTION', 'Description', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object Type
CALL INSERTREPORTFIELD('AUDIT_ENTITY_TYPE', 'Object Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object ID
CALL INSERTREPORTFIELD('AUDIT_OBJECT_ID', 'Object ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('AUDIT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Address Audit History Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Audit History');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Address Audit History', 0, 'VW_AUDITHISTORY_ADDRESSES', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Audit History Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Audit History Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Audit History ID
CALL INSERTREPORTFIELD('AUDIT_AUDIT_ID', 'Audit History ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Date
CALL INSERTREPORTFIELD('AUDIT_DATE', 'Date', b'1', 4, @REPORTFIELDGROUP_ID);

-- User
CALL INSERTREPORTFIELD('AUDIT_USER', 'User', b'1', 1, @REPORTFIELDGROUP_ID);

-- Type
CALL INSERTREPORTFIELD('AUDIT_AUDIT_TYPE', 'Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Description
CALL INSERTREPORTFIELD('AUDIT_DESCRIPTION', 'Description', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object Type
CALL INSERTREPORTFIELD('AUDIT_ENTITY_TYPE', 'Object Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object ID
CALL INSERTREPORTFIELD('AUDIT_OBJECT_ID', 'Object ID', b'0', 3, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('AUDIT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Address Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Address Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('ADDRESS_CONSTITUENT_ID', 'Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Account Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(ADDRESS_CONSTITUENT_ID)', 'Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address ID
CALL INSERTREPORTFIELD('ADDRESS_ADDRESS_ID', 'Address ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Address Type
CALL INSERTREPORTFIELD('ADDRESS_ADDRESS_TYPE', 'Address Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Status
CALL INSERTREPORTFIELD('ADDRESS_ACTIVATION_STATUS', 'Address Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Effective Date
CALL INSERTREPORTFIELD('ADDRESS_EFFECTIVE_DATE', 'Address Effective Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Seasonal Start Date
CALL INSERTREPORTFIELD('ADDRESS_SEASONAL_START_DATE', 'Seasonal Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Seasonal End Date
CALL INSERTREPORTFIELD('ADDRESS_SEASONAL_END_DATE', 'Seasonal End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Temporary Start Date
CALL INSERTREPORTFIELD('ADDRESS_TEMPORARY_START_DATE', 'Temporary Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Temporary End Date
CALL INSERTREPORTFIELD('ADDRESS_TEMPORARY_END_DATE', 'Temporary End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Address Line 1
CALL INSERTREPORTFIELD('ADDRESS_ADDRESS_LINE_1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 2
CALL INSERTREPORTFIELD('ADDRESS_ADDRESS_LINE_2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 3
CALL INSERTREPORTFIELD('ADDRESS_ADDRESS_LINE_3', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- City
CALL INSERTREPORTFIELD('ADDRESS_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- State/Province
CALL INSERTREPORTFIELD('ADDRESS_STATE_PROVINCE', 'State/Province', b'0', 1, @REPORTFIELDGROUP_ID);

-- Country
CALL INSERTREPORTFIELD('ADDRESS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Zip/Postal Code
CALL INSERTREPORTFIELD('ADDRESS_POSTAL_CODE', 'Zip/Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Receive Correspondence
CALL INSERTREPORTFIELD('ADDRESS_RECEIVE_CORRESPONDENCE', 'Receive Correspondence', b'0', 6, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('ADDRESS_COMMENT', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Create Date
CALL INSERTREPORTFIELD('ADDRESS_CREATE_DATE', 'Address Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Address Update Date
CALL INSERTREPORTFIELD('ADDRESS_UPDATE_DATE', 'Address Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Address Inactive
CALL INSERTREPORTFIELD('ADDRESS_INACTIVE', 'Address Inactive', b'0', 6, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Constituents Audit History Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Audit History');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Constituent Audit History', 0, 'VW_AUDITHISTORY_CONSTITUENTS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Audit History Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Audit History Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Audit History ID
CALL INSERTREPORTFIELD('AUDIT_AUDIT_ID', 'Audit History ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Date
CALL INSERTREPORTFIELD('AUDIT_DATE', 'Date', b'1', 4, @REPORTFIELDGROUP_ID);

-- User
CALL INSERTREPORTFIELD('AUDIT_USER', 'User', b'1', 1, @REPORTFIELDGROUP_ID);

-- Type
CALL INSERTREPORTFIELD('AUDIT_AUDIT_TYPE', 'Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Description
CALL INSERTREPORTFIELD('AUDIT_DESCRIPTION', 'Description', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object Type
CALL INSERTREPORTFIELD('AUDIT_ENTITY_TYPE', 'Object Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object ID
CALL INSERTREPORTFIELD('AUDIT_OBJECT_ID', 'Object ID', b'0', 3, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('AUDIT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Email Addresses Audit History Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Audit History');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Email Address Audit History', 0, 'VW_AUDITHISTORY_EMAILADDRESSES', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Audit History Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Audit History Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Audit History ID
CALL INSERTREPORTFIELD('AUDIT_AUDIT_ID', 'Audit History ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Date
CALL INSERTREPORTFIELD('AUDIT_DATE', 'Date', b'1', 4, @REPORTFIELDGROUP_ID);

-- User
CALL INSERTREPORTFIELD('AUDIT_USER', 'User', b'1', 1, @REPORTFIELDGROUP_ID);

-- Type
CALL INSERTREPORTFIELD('AUDIT_AUDIT_TYPE', 'Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Description
CALL INSERTREPORTFIELD('AUDIT_DESCRIPTION', 'Description', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object Type
CALL INSERTREPORTFIELD('AUDIT_ENTITY_TYPE', 'Object Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object ID
CALL INSERTREPORTFIELD('AUDIT_OBJECT_ID', 'Object ID', b'0', 3, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('AUDIT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Email Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Email Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Email Address ID
CALL INSERTREPORTFIELD('EMAIL_EMAIL_ID', 'Email Address ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('EMAIL_CONSTITUENT_ID', 'Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Account Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(EMAIL_CONSTITUENT_ID)', 'Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Type
CALL INSERTREPORTFIELD('EMAIL_EMAIL_TYPE', 'Email Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Status
CALL INSERTREPORTFIELD('EMAIL_ACTIVATION_STATUS', 'Email Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Effective Date
CALL INSERTREPORTFIELD('EMAIL_EFFECTIVE_DATE', 'Effective Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Seasonal Start Date
CALL INSERTREPORTFIELD('EMAIL_SEASONAL_START_DATE', 'Seasonal Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Seasonal End Date
CALL INSERTREPORTFIELD('EMAIL_SEASONAL_END_DATE', 'Seasonal End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Temporary Start Date
CALL INSERTREPORTFIELD('EMAIL_TEMPORARY_START_DATE', 'Temporary Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Temporary End Date
CALL INSERTREPORTFIELD('EMAIL_TEMPORARY_END_DATE', 'Temporary End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Email Address
CALL INSERTREPORTFIELD('EMAIL_EMAIL_ADDRESS', 'Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Display
CALL INSERTREPORTFIELD('EMAIL_EMAIL_DISPLAY', 'Email Display', b'0', 1, @REPORTFIELDGROUP_ID);

-- Receive Correspondence
CALL INSERTREPORTFIELD('EMAIL_RECEIVE_CORRESPONDENCE', 'Receive Correspondence', b'0', 6, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('EMAIL_COMMENT', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Address Create Date
CALL INSERTREPORTFIELD('EMAIL_CREATE_DATE', 'Email Address Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Email Address Update Date
CALL INSERTREPORTFIELD('EMAIL_UPDATE_DATE', 'Email Address Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Email Address Inactive
CALL INSERTREPORTFIELD('EMAIL_INACTIVE', 'Email Address Inactive', b'0', 6, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Gift Audit History Field Definitions
--
-- *********************************************************************************************************************

SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Audit History');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Gift Audit History', 0, 'VW_AUDITHISTORY_GIFTS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Audit History Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Audit History Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Audit History ID
CALL INSERTREPORTFIELD('AUDIT_AUDIT_ID', 'Audit History ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Date
CALL INSERTREPORTFIELD('AUDIT_DATE', 'Date', b'1', 4, @REPORTFIELDGROUP_ID);

-- User
CALL INSERTREPORTFIELD('AUDIT_USER', 'User', b'1', 1, @REPORTFIELDGROUP_ID);

-- Type
CALL INSERTREPORTFIELD('AUDIT_AUDIT_TYPE', 'Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Description
CALL INSERTREPORTFIELD('AUDIT_DESCRIPTION', 'Description', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object Type
CALL INSERTREPORTFIELD('AUDIT_ENTITY_TYPE', 'Object Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object ID
CALL INSERTREPORTFIELD('AUDIT_OBJECT_ID', 'Object ID', b'0', 3, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('AUDIT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Gift Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Gift Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Gift Reference Number
CALL INSERTREPORTFIELD('GIFT_GIFT_ID', 'Gift Reference Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('GIFT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(GIFT_CONSTITUENT_ID)', 'Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Gift Amount
CALL INSERTREPORTFIELD('GIFT_AMOUNT', 'Gift Amount', b'1', 5, @REPORTFIELDGROUP_ID);

-- Currency Code
CALL INSERTREPORTFIELD('GIFT_CURRENCY_CODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Donation Date
CALL INSERTREPORTFIELD('GIFT_DONATION_DATE', 'Donation Date', b'1', 4, @REPORTFIELDGROUP_ID);

-- Postmark Date
CALL INSERTREPORTFIELD('GIFT_POSTMARK_DATE', 'Postmark Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Reference Account Number
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NUMBER', 'GETCUSTOMFIELD(GIFT_GIFT_ID, ''gift'', ''reference'')', 'Reference Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Reference Account Name
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(GIFT_GIFT_ID, ''gift'', ''reference''))', 'Reference Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('GIFT_COMMENTS', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Transaction Date
CALL INSERTREPORTFIELD('GIFT_TRANSACTIONDATE', 'Transaction Date', b'0', 4, @REPORTFIELDGROUP_ID);


-- ***********************************************************************
-- Payment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Payment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Payment Profile Description
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_PAYMENT_PROFILE_DESCRIPTION', 'Payment Profile Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Payment Method
CALL INSERTREPORTFIELD('GIFT_PAYMENT_TYPE', 'Payment Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Type
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_TYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Holder Name
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_HOLDER_NAME', 'Credit Card Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION', 'Credit Card Expiration', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration (Date / Time)
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION_DATE', 'Credit Card Expiration (Date / Time)', b'0', 4, @REPORTFIELDGROUP_ID);

-- ACH Holder Name
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_ACH_HOLDER_NAME', 'ACH Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ACH Routing Number
CALL INSERTREPORTFIELD('GIFT_PAYMENT_SOURCE_ACH_ROUTING_NUMBER', 'ACH Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Check Number
CALL INSERTREPORTFIELD('GIFT_CHECK_NUMBER', 'Check Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Authorization Code
CALL INSERTREPORTFIELD('GIFT_AUTH_CODE', 'Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 1
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 2
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 3
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_ADDRESS_LINE_3', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- City
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- State/Province
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_STATE_PROVINCE', 'State/Province', b'0', 1, @REPORTFIELDGROUP_ID);

-- Zip/Postal Code
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_POSTAL_CODE', 'Zip/Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Country
CALL INSERTREPORTFIELD('GIFT_PAYMENT_ADDRESS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Number
CALL INSERTREPORTFIELD('GIFT_PAYMENT_PHONE_NUMBER', 'Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Acknowledgment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Acknowledgment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('GIFT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('GIFT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('GIFT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Payment Method Audit History Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Audit History');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Payment Method Audit History', 0, 'VW_AUDITHISTORY_PAYMENTMETHODS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Audit History Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Audit History Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Audit History ID
CALL INSERTREPORTFIELD('AUDIT_AUDIT_ID', 'Audit History ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Date
CALL INSERTREPORTFIELD('AUDIT_DATE', 'Date', b'1', 4, @REPORTFIELDGROUP_ID);

-- User
CALL INSERTREPORTFIELD('AUDIT_USER', 'User', b'1', 1, @REPORTFIELDGROUP_ID);

-- Type
CALL INSERTREPORTFIELD('AUDIT_AUDIT_TYPE', 'Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Description
CALL INSERTREPORTFIELD('AUDIT_DESCRIPTION', 'Description', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object Type
CALL INSERTREPORTFIELD('AUDIT_ENTITY_TYPE', 'Object Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object ID
CALL INSERTREPORTFIELD('AUDIT_OBJECT_ID', 'Object ID', b'0', 3, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('AUDIT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Payment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Payment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Payment Method ID
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_PAYMENT_SOURCE_ID', 'Payment Method ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_CONSTITUENT_ID', 'Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Account Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(PAYMENT_SOURCE_CONSTITUENT_ID)', 'Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Payment Profile Description
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_PAYMENT_PROFILE_DESCRIPTION', 'Payment Profile Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Payment Method
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_PAYMENT_TYPE', 'Payment Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Holder Name
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_CREDIT_CARD_HOLDER_NAME', 'Credit Card Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Type
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_CREDIT_CARD_TYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION', 'Credit Card Expiration', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration (Date / Time)
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION_DATE', 'Credit Card Expiration (Date / Time)', b'0', 4, @REPORTFIELDGROUP_ID);

-- ACH Holder Name
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ACH_HOLDER_NAME', 'ACH Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ACH Routing Number
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ACH_ROUTING_NUMBER', 'ACH Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Default Address/Phone Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Default Address/Phone Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Address Line 1
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ADDRESS_ADDRESS_LINE_1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 2
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ADDRESS_ADDRESS_LINE_2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 3
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ADDRESS_ADDRESS_LINE_3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- City
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ADDRESS_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- State/Province
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ADDRESS_STATE_PROVINCE', 'State/Province', b'0', 1, @REPORTFIELDGROUP_ID);

-- Zip/Postal Code
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ADDRESS_POSTAL_CODE', 'Zip/Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Country
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_ADDRESS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Number
CALL INSERTREPORTFIELD('PAYMENT_SOURCE_PHONE_NUMBER', 'Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Phone Number Audit History Field Definitions
--
-- *********************************************************************************************************************

SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Audit History');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Phone Number Audit History', 0, 'VW_AUDITHISTORY_PHONENUMBERS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Audit History Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Audit History Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Audit History ID
CALL INSERTREPORTFIELD('AUDIT_AUDIT_ID', 'Audit History ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Date
CALL INSERTREPORTFIELD('AUDIT_DATE', 'Date', b'1', 4, @REPORTFIELDGROUP_ID);

-- User
CALL INSERTREPORTFIELD('AUDIT_USER', 'User', b'1', 1, @REPORTFIELDGROUP_ID);

-- Type
CALL INSERTREPORTFIELD('AUDIT_AUDIT_TYPE', 'Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Description
CALL INSERTREPORTFIELD('AUDIT_DESCRIPTION', 'Description', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object Type
CALL INSERTREPORTFIELD('AUDIT_ENTITY_TYPE', 'Object Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object ID
CALL INSERTREPORTFIELD('AUDIT_OBJECT_ID', 'Object ID', b'0', 3, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('AUDIT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Phone Number Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Phone Number Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Phone Number ID
CALL INSERTREPORTFIELD('PHONE_PHONE_ID', 'Phone Number ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('PHONE_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(PHONE_CONSTITUENT_ID)', 'Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Type
CALL INSERTREPORTFIELD('PHONE_PHONE_TYPE', 'Phone Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Status
CALL INSERTREPORTFIELD('PHONE_ACTIVATION_STATUS', 'Phone Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Effective Date
CALL INSERTREPORTFIELD('PHONE_EFFECTIVE_DATE', 'Effective Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Seasonal Start Date
CALL INSERTREPORTFIELD('PHONE_SEASONAL_START_DATE', 'Seasonal Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Seasonal End Date
CALL INSERTREPORTFIELD('PHONE_SEASONAL_END_DATE', 'Seasonal End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Temporary Start Date
CALL INSERTREPORTFIELD('PHONE_TEMPORARY_START_DATE', 'Temporary Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Temporary End Date
CALL INSERTREPORTFIELD('PHONE_TEMPORARY_END_DATE', 'Temporary End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Phone Number
CALL INSERTREPORTFIELD('PHONE_NUMBER', 'Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Provider
CALL INSERTREPORTFIELD('PHONE_PROVIDER', 'Provider', b'0', 1, @REPORTFIELDGROUP_ID);

-- SMS
CALL INSERTREPORTFIELD('PHONE_SMS', 'SMS', b'0', 1, @REPORTFIELDGROUP_ID);

-- Receive Correspondence
CALL INSERTREPORTFIELD('PHONE_RECEIVE_CORRESPONDENCE', 'Receive Correspondence', b'0', 6, @REPORTFIELDGROUP_ID);

-- Phone Comments
CALL INSERTREPORTFIELD('PHONE_COMMENT', 'Phone Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Create Date
CALL INSERTREPORTFIELD('PHONE_CREATE_DATE', 'Phone Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Phone Update Date
CALL INSERTREPORTFIELD('PHONE_UPDATE_DATE', 'Phone Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Phone Inactive Status
CALL INSERTREPORTFIELD('PHONE_INACTIVE', 'Phone Inactive Status', b'0', 6, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Pledge Audit History Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Audit History');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Pledge Audit History', 0, 'VW_AUDITHISTORY_PLEDGES', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Audit History Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Audit History Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Audit History ID
CALL INSERTREPORTFIELD('AUDIT_AUDIT_ID', 'Audit History ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Date
CALL INSERTREPORTFIELD('AUDIT_DATE', 'Date', b'1', 4, @REPORTFIELDGROUP_ID);

-- User
CALL INSERTREPORTFIELD('AUDIT_USER', 'User', b'1', 1, @REPORTFIELDGROUP_ID);

-- Type
CALL INSERTREPORTFIELD('AUDIT_AUDIT_TYPE', 'Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Description
CALL INSERTREPORTFIELD('AUDIT_DESCRIPTION', 'Description', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object Type
CALL INSERTREPORTFIELD('AUDIT_ENTITY_TYPE', 'Object Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object ID
CALL INSERTREPORTFIELD('AUDIT_OBJECT_ID', 'Object ID', b'0', 3, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('AUDIT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Pledge Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Pledge Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account
CALL INSERTREPORTFIELD('COMMITMENT_COMMITMENT_ID', 'Pledge ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('COMMITMENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(COMMITMENT_CONSTITUENT_ID)', 'Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recurring
CALL INSERTREPORTFIELD('COMMITMENT_RECURRING', 'Recurring', b'0', 6, @REPORTFIELDGROUP_ID);

-- Amount Per Gift
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_PER_GIFT', 'Amount Per Gift', b'0', 5, @REPORTFIELDGROUP_ID);

-- Amount Total
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_TOTAL', 'Amount Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Currency Code
CALL INSERTREPORTFIELD('COMMITMENT_CURRENCY_CODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Status
CALL INSERTREPORTFIELD('COMMITMENT_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Frequency
CALL INSERTREPORTFIELD('COMMITMENT_FREQUENCY', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Pledge Date
CALL INSERTREPORTFIELD('COMMITMENT_PLEDGE_DATE', 'Pledge Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Projected Date
CALL INSERTREPORTFIELD('COMMITMENT_PROJECTED_DATE', 'Projected Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Start Date
CALL INSERTREPORTFIELD('COMMITMENT_START_DATE', 'Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- End Date
CALL INSERTREPORTFIELD('COMMITMENT_END_DATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('COMMITMENT_COMMENTS', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('COMMITMENT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Acknowledgment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Acknowledgment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('COMMITMENT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Recurring Gift Audit History Field Definitions
--
-- *********************************************************************************************************************


SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Audit History');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Recurring Gift Audit History', 0, 'VW_AUDITHISTORY_RECURRINGGIFTS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- ***********************************************************************
-- Audit History Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Audit History Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Audit History ID
CALL INSERTREPORTFIELD('AUDIT_AUDIT_ID', 'Audit History ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Date
CALL INSERTREPORTFIELD('AUDIT_DATE', 'Date', b'1', 4, @REPORTFIELDGROUP_ID);

-- User
CALL INSERTREPORTFIELD('AUDIT_USER', 'User', b'1', 1, @REPORTFIELDGROUP_ID);

-- Type
CALL INSERTREPORTFIELD('AUDIT_AUDIT_TYPE', 'Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Description
CALL INSERTREPORTFIELD('AUDIT_DESCRIPTION', 'Description', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object Type
CALL INSERTREPORTFIELD('AUDIT_ENTITY_TYPE', 'Object Type', b'1', 1, @REPORTFIELDGROUP_ID);

-- Object ID
CALL INSERTREPORTFIELD('AUDIT_OBJECT_ID', 'Object ID', b'0', 3, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('AUDIT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Recurring Gift Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Recurring Gift Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Recurring Gift ID
CALL INSERTREPORTFIELD('COMMITMENT_COMMITMENT_ID', 'Recurring Gift ID', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('COMMITMENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(COMMITMENT_CONSTITUENT_ID)', 'Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Auto Pay
CALL INSERTREPORTFIELD('COMMITMENT_AUTO_PAY', 'Auto Pay', b'0', 6, @REPORTFIELDGROUP_ID);

-- Amount Per Gift
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_PER_GIFT', 'Amount Per Gift', b'1', 5, @REPORTFIELDGROUP_ID);

-- Amount Total
CALL INSERTREPORTFIELD('COMMITMENT_AMOUNT_TOTAL', 'Amount Total', b'1', 5, @REPORTFIELDGROUP_ID);

-- Currency Code
CALL INSERTREPORTFIELD('COMMITMENT_CURRENCY_CODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Frequency
CALL INSERTREPORTFIELD('COMMITMENT_FREQUENCY', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Start Date
CALL INSERTREPORTFIELD('COMMITMENT_START_DATE', 'Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- End Date
CALL INSERTREPORTFIELD('COMMITMENT_END_DATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Status
CALL INSERTREPORTFIELD('COMMITMENT_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Reference Account Number
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NUMBER', 'GETCUSTOMFIELD(COMMITMENT_COMMITMENT_ID, ''commitment'', ''reference'')', 'Reference Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Reference Account Name
CALL INSERTREPORTFIELDWITHALIAS('REFERENCE_ACCOUNT_NAME', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(COMMITMENT_COMMITMENT_ID, ''commitment'', ''reference''))', 'Reference Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('COMMITMENT_COMMENTS', 'Comments', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Entry Date
CALL INSERTREPORTFIELD('COMMITMENT_LAST_ENTRY_DATE', 'Last Entry Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Recurring Gift Create Date
CALL INSERTREPORTFIELD('COMMITMENT_CREATE_DATE', 'Recurring Gift Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Recurring Gift Update Date
CALL INSERTREPORTFIELD('COMMITMENT_UPDATE_DATE', 'Recurring Gift Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Payment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Payment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Payment Profile Description
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_PAYMENT_PROFILE_DESCRIPTION', 'Payment Profile Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Payment Method
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_TYPE', 'Payment Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Type
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_TYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Holder Name
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_HOLDER_NAME', 'Credit Card Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION', 'Credit Card Expiration', b'0', 1, @REPORTFIELDGROUP_ID);

-- Credit Card Expiration (Date / Time)
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_CREDIT_CARD_EXPIRATION_DATE', 'Credit Card Expiration (Date / Time)', b'0', 4, @REPORTFIELDGROUP_ID);

-- ACH Holder Name
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_ACH_HOLDER_NAME', 'ACH Holder Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ACH Routing Number
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_SOURCE_ACH_ROUTING_NUMBER', 'ACH Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Check Number
CALL INSERTREPORTFIELD('COMMITMENT_CHECK_NUMBER', 'Check Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Address Line 1
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_ADDRESS_LINE_1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 2
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_ADDRESS_LINE_2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Address Line 3
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_ADDRESS_LINE_3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- City
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- State/Province
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_STATE_PROVINCE', 'State/Province', b'0', 1, @REPORTFIELDGROUP_ID);

-- Zip/Postal Code
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_POSTAL_CODE', 'Zip/Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Country
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_ADDRESS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Phone Number
CALL INSERTREPORTFIELD('COMMITMENT_PAYMENT_PHONE_NUMBER', 'Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Acknowledgment Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Acknowledgment Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Receipt Email
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGEMENT_EMAIL_EMAIL_ADDRESS', 'Receipt Email', b'0', 1, @REPORTFIELDGROUP_ID);

-- Send Acknowledgment
CALL INSERTREPORTFIELD('COMMITMENT_SEND_ACKNOWLEDGMENT', 'Send Acknowledgment', b'0', 6, @REPORTFIELDGROUP_ID);

-- Acknowledgment Date
CALL INSERTREPORTFIELD('COMMITMENT_ACKNOWLEDGMENT_DATE', 'Acknowledgment Date', b'0', 4, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Journals Field Definitions
--
-- *********************************************************************************************************************

SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Journals');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Journals', 0, 'VW_JOURNALS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Journal Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Journal Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Journal Reference Number
CALL INSERTREPORTFIELD('COMMUNICATION_HISTORY_COMMUNICATION_HISTORY_ID', 'Journal Reference Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Entry Type
CALL INSERTREPORTFIELD('COMMUNICATION_HISTORY_COMMUNICATION_TYPE', 'Entry Type', b'1', 2, @REPORTFIELDGROUP_ID);

-- Journal Entry Date
CALL INSERTREPORTFIELD('COMMUNICATION_HISTORY_RECORD_DATE', 'Journal Entry Date', b'1', 4, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('COMMUNICATION_HISTORY_COMMENTS', 'Comments', b'1', 1, @REPORTFIELDGROUP_ID);

-- System Generated
CALL INSERTREPORTFIELD('COMMUNICATION_HISTORY_SYSTEM_GENERATED', 'System Generated', b'0', 6, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('COMMUNICATION_HISTORY_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('COMMUNICATION_HISTORY_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('COMMUNICATION_CONSTITUENT_ID', 'Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Recorded By
CALL INSERTREPORTFIELD('COMMUNICATION_HISTORY_RECORDED_BY', 'Recorded By', b'0', 3, @REPORTFIELDGROUP_ID);



-- *********************************************************************************************************************
--
-- Journals & Constituents Field Definitions
--
-- *********************************************************************************************************************

SET @REPORTDATASUBSOURCEGROUP_ID = (SELECT REPORTSUBSOURCEGROUP_ID FROM REPORTDATASUBSOURCEGROUP WHERE DISPLAY_NAME = 'Journals');

INSERT INTO REPORTDATASUBSOURCE
	(DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
VALUES
	('Journals & Constituents', 0, 'VW_JOURNALS_CONSTITUENTS', @REPORTDATASUBSOURCEGROUP_ID, 0, '/datasources/ReportWizardJdbcDS');

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();


-- ***********************************************************************
-- Journal Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Journal Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Journal Reference Number
CALL INSERTREPORTFIELD('COMMUNICATION_HISTORY_COMMUNICATION_HISTORY_ID', 'Journal Reference Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Entry Type
CALL INSERTREPORTFIELD('COMMUNICATION_HISTORY_COMMUNICATION_TYPE', 'Entry Type', b'1', 2, @REPORTFIELDGROUP_ID);

-- Journal Entry Date
CALL INSERTREPORTFIELD('COMMUNICATION_HISTORY_RECORD_DATE', 'Journal Entry Date', b'1', 4, @REPORTFIELDGROUP_ID);

-- Comments
CALL INSERTREPORTFIELD('COMMUNICATION_HISTORY_COMMENTS', 'Comments', b'1', 1, @REPORTFIELDGROUP_ID);

-- System Generated
CALL INSERTREPORTFIELD('COMMUNICATION_HISTORY_SYSTEM_GENERATED', 'System Generated', b'0', 6, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('COMMUNICATION_HISTORY_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('COMMUNICATION_HISTORY_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('COMMUNICATION_HISTORY_CONSTITUENT_ID', 'Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Recorded By
CALL INSERTREPORTFIELD('COMMUNICATION_HISTORY_RECORDED_BY', 'Recorded By', b'0', 3, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Contact Details Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Contact Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Account Number
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ID', 'Account Number', b'1', 3, @REPORTFIELDGROUP_ID);

-- Account Manager Name
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGER', 'GETCONSTITUENTDISPLAYNAME(GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager''))', 'Account Manager Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Account Manager Account Number
CALL INSERTREPORTFIELDWITHALIAS('ACCOUNTMANAGERACCOUNTNUMBER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''accountManager'')', 'Account Manager Account Number', b'0', 3, @REPORTFIELDGROUP_ID);

-- Constituent Type
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_TYPE', 'Constituent Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLES', 'Profile Types', b'0', 1, @REPORTFIELDGROUP_ID);

-- Profile Types
CALL INSERTREPORTFIELD('CONSTITUENT_CONSTITUENT_ROLE', 'Profile Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Title
CALL INSERTREPORTFIELD('CONSTITUENT_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- First Name
CALL INSERTREPORTFIELD('CONSTITUENT_FIRST_NAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Middle Name
CALL INSERTREPORTFIELD('CONSTITUENT_MIDDLE_NAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Last Name
CALL INSERTREPORTFIELD('CONSTITUENT_LAST_NAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Suffix
CALL INSERTREPORTFIELD('CONSTITUENT_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Recognition Name
CALL INSERTREPORTFIELD('CONSTITUENT_RECOGNITION_NAME', 'Recognition Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Organization Name
CALL INSERTREPORTFIELD('CONSTITUENT_ORGANIZATION_NAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Legal Name
CALL INSERTREPORTFIELD('CONSTITUENT_LEGAL_NAME', 'Legal Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MATCHING', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.matching'')', 'Matching', b'0', 1, @REPORTFIELDGROUP_ID);

-- Percent Matching
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_PERCENTMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.percentMatch'')', 'Percent Matching', b'0', 3, @REPORTFIELDGROUP_ID);

-- Maximum Match
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_MAXIMUMMATCH', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.maximumMatch'')', 'Maximum Match', b'0', 5, @REPORTFIELDGROUP_ID);

-- Website
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_WEBSITE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.website'')', 'Website', b'0', 1, @REPORTFIELDGROUP_ID);

-- Tax ID
CALL INSERTREPORTFIELDWITHALIAS('ORGANIZATION_TAXID', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''organization.taxid'')', 'Tax ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- NCAIS Code
CALL INSERTREPORTFIELD('CONSTITUENT_NCAIS_CODE', 'NCAIS Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Communication Preferences
CALL INSERTREPORTFIELDWITHALIAS('COMMUNICATIONPREFERENCES', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''communicationPreferences'')', 'Communication Preferences', b'0', 1, @REPORTFIELDGROUP_ID);

-- Email Format
CALL INSERTREPORTFIELDWITHALIAS('EMAILFORMAT', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''emailFormat'')', 'Email Format', b'0', 1, @REPORTFIELDGROUP_ID);

-- Create Date
CALL INSERTREPORTFIELD('CONSTITUENT_CREATE_DATE', 'Create Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Update Date
CALL INSERTREPORTFIELD('CONSTITUENT_UPDATE_DATE', 'Update Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Demographic Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Demographic Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Marital Status
CALL INSERTREPORTFIELD('CONSTITUENT_MARITAL_STATUS', 'Marital Status', b'0', 3, @REPORTFIELDGROUP_ID);

-- Birth Date
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_BIRTHDATE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.birthDate'')', 'Birth Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Deceased
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_DECEASED', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.deceased'')', 'Deceased', b'0', 6, @REPORTFIELDGROUP_ID);

-- Gender
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_GENDER', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.gender'')', 'Gender', b'0', 1, @REPORTFIELDGROUP_ID);

-- Race
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_RACE', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.race'')', 'Race', b'0', 1, @REPORTFIELDGROUP_ID);

-- Military
CALL INSERTREPORTFIELDWITHALIAS('INDIVIDUAL_MILITARY', 'GETCUSTOMFIELD(CONSTITUENT_CONSTITUENT_ID, ''person'', ''individual.military'')', 'Military', b'0', 1, @REPORTFIELDGROUP_ID);

-- ***********************************************************************
-- Miscellaneous Information Field Group
-- ***********************************************************************
CALL INSERTREPORTFIELDGROUP('Miscellaneous Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Major Donor
CALL INSERTREPORTFIELD('CONSTITUENT_MAJOR_DONOR', 'Major Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Lapsed Donor
CALL INSERTREPORTFIELD('CONSTITUENT_LAPSED_DONOR', 'Lapsed Donor', b'0', 6, @REPORTFIELDGROUP_ID);

-- Site Name
CALL INSERTREPORTFIELD('CONSTITUENT_SITE_NAME', 'Site Name', b'0', 1, @REPORTFIELDGROUP_ID);



-- Custom Filters

-- Major Donor - tied to ADDRESS_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 300000, 'Account - Account is marked as a major donor',
'((SELECT MAJOR_DONOR FROM CONSTITUENT CONSTITUENTLOOKUP WHERE CONSTITUENTLOOKUP.CONSTITUENT_ID = [VIEWNAME].ADDRESS_CONSTITUENT_ID) = true)',
'Account - Account is marked as a major donor';

-- Major Donor - tied to AUDIT_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 310000, 'Account - Account is marked as a major donor',
'((SELECT MAJOR_DONOR FROM CONSTITUENT CONSTITUENTLOOKUP WHERE CONSTITUENTLOOKUP.CONSTITUENT_ID = [VIEWNAME].AUDIT_CONSTITUENT_ID) = true)',
'Account - Account is marked as a major donor';

-- Major Donor - tied to COMMITMENT_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 320000, 'Account - Account is marked as a major donor',
'((SELECT MAJOR_DONOR FROM CONSTITUENT CONSTITUENTLOOKUP WHERE CONSTITUENTLOOKUP.CONSTITUENT_ID = [VIEWNAME].COMMITMENT_CONSTITUENT_ID) = true)',
'Account - Account is marked as a major donor';

-- Major Donor - tied to COMMUNICATION_HISTORY_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 330000, 'Account - Account is marked as a major donor',
'((SELECT MAJOR_DONOR FROM CONSTITUENT CONSTITUENTLOOKUP WHERE CONSTITUENTLOOKUP.CONSTITUENT_ID = [VIEWNAME].COMMUNICATION_HISTORY_CONSTITUENT_ID) = true)',
'Account - Account is marked as a major donor';

-- Major Donor - tied to EMAIL_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 340000, 'Account - Account is marked as a major donor',
'((SELECT MAJOR_DONOR FROM CONSTITUENT CONSTITUENTLOOKUP WHERE CONSTITUENTLOOKUP.CONSTITUENT_ID = [VIEWNAME].EMAIL_CONSTITUENT_ID) = true)',
'Account - Account is marked as a major donor';

-- Major Donor - tied to GIFT_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 350000, 'Account - Account is marked as a major donor',
'((SELECT MAJOR_DONOR FROM CONSTITUENT CONSTITUENTLOOKUP WHERE CONSTITUENTLOOKUP.CONSTITUENT_ID = [VIEWNAME].GIFT_CONSTITUENT_ID) = true)',
'Account - Account is marked as a major donor';

-- Major Donor - tied to PAYMENT_HISTORY_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 360000, 'Account - Account is marked as a major donor',
'((SELECT MAJOR_DONOR FROM CONSTITUENT CONSTITUENTLOOKUP WHERE CONSTITUENTLOOKUP.CONSTITUENT_ID = [VIEWNAME].PAYMENT_HISTORY_CONSTITUENT_ID) = true)',
'Account - Account is marked as a major donor';

-- Major Donor - tied to PAYMENT_SOURCE_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 370000, 'Account - Account is marked as a major donor',
'((SELECT MAJOR_DONOR FROM CONSTITUENT CONSTITUENTLOOKUP WHERE CONSTITUENTLOOKUP.CONSTITUENT_ID = [VIEWNAME].PAYMENT_SOURCE_CONSTITUENT_ID) = true)',
'Account - Account is marked as a major donor';

-- Major Donor - tied to CONSTITUENT_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 380000, 'Account - Account is marked as a major donor',
'((SELECT MAJOR_DONOR FROM CONSTITUENT CONSTITUENTLOOKUP WHERE CONSTITUENTLOOKUP.CONSTITUENT_ID = [VIEWNAME].CONSTITUENT_CONSTITUENT_ID) = true)',
'Account - Account is marked as a major donor';

-- Major Donor - tied to PHONE_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 390000, 'Account - Account is marked as a major donor',
'((SELECT MAJOR_DONOR FROM CONSTITUENT CONSTITUENTLOOKUP WHERE CONSTITUENTLOOKUP.CONSTITUENT_ID = [VIEWNAME].PHONE_CONSTITUENT_ID) = true)',
'Account - Account is marked as a major donor';


-- Address effective as of date
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 395000, 'Address - Address is effective as of [AS OF DATE]',
'(STR_TO_DATE(''{0}'', ''%m/%d/%Y'') BETWEEN
CASE
  WHEN ADDRESS_ACTIVATION_STATUS = ''temporary'' THEN ADDRESS_TEMPORARY_START_DATE
  WHEN ADDRESS_ACTIVATION_STATUS = ''seasonal'' THEN ADDRESS_SEASONAL_START_DATE
  WHEN ADDRESS_ACTIVATION_STATUS = ''permanent'' AND ADDRESS_EFFECTIVE_DATE IS NOT NULL THEN ADDRESS_EFFECTIVE_DATE
  ELSE STR_TO_DATE(''{0}'', ''%m/%d/%Y'')
END
AND
CASE
  WHEN ADDRESS_ACTIVATION_STATUS = ''temporary'' THEN ADDRESS_TEMPORARY_END_DATE
  WHEN ADDRESS_ACTIVATION_STATUS = ''seasonal'' THEN ADDRESS_SEASONAL_END_DATE
  ELSE STR_TO_DATE(''{0}'', ''%m/%d/%Y'')
END)',
'Address - Address is effective as of <span class="criteriaWrapper"><input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" fieldtype="DATE" value="{0}" style="width:110px"/></span>';

-- Email Address effective as of date
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 396000, 'Email Address - Email Address is effective as of [AS OF DATE]',
'(STR_TO_DATE(''{0}'', ''%m/%d/%Y'') BETWEEN
CASE
  WHEN EMAIL_ACTIVATION_STATUS = ''temporary'' THEN EMAIL_TEMPORARY_START_DATE
  WHEN EMAIL_ACTIVATION_STATUS = ''seasonal'' THEN EMAIL_SEASONAL_START_DATE
  WHEN EMAIL_ACTIVATION_STATUS = ''permanent'' AND EMAIL_EFFECTIVE_DATE IS NOT NULL THEN EMAIL_EFFECTIVE_DATE
  ELSE STR_TO_DATE(''{0}'', ''%m/%d/%Y'')
END
AND
CASE
  WHEN EMAIL_ACTIVATION_STATUS = ''temporary'' THEN EMAIL_TEMPORARY_END_DATE
  WHEN EMAIL_ACTIVATION_STATUS = ''seasonal'' THEN EMAIL_SEASONAL_END_DATE
  ELSE STR_TO_DATE(''{0}'', ''%m/%d/%Y'')
END)',
'Email Address - Email Address is effective as of <span class="criteriaWrapper"><input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" fieldtype="DATE" value="{0}" style="width:110px"/></span>';


INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 397000, 'Phone Number - Phone Number is effective as of [AS OF DATE]',
'(STR_TO_DATE(''{0}'', ''%m/%d/%Y'') BETWEEN
CASE
  WHEN PHONE_ACTIVATION_STATUS = ''temporary'' THEN PHONE_TEMPORARY_START_DATE
  WHEN PHONE_ACTIVATION_STATUS = ''seasonal'' THEN PHONE_SEASONAL_START_DATE
  WHEN PHONE_ACTIVATION_STATUS = ''permanent'' AND PHONE_EFFECTIVE_DATE IS NOT NULL THEN PHONE_EFFECTIVE_DATE
  ELSE STR_TO_DATE(''{0}'', ''%m/%d/%Y'')
END
AND
CASE
  WHEN PHONE_ACTIVATION_STATUS = ''temporary'' THEN PHONE_TEMPORARY_END_DATE
  WHEN PHONE_ACTIVATION_STATUS = ''seasonal'' THEN PHONE_SEASONAL_END_DATE
  ELSE STR_TO_DATE(''{0}'', ''%m/%d/%Y'')
END)',
'Phone Number - Phone Number is effective as of <span class="criteriaWrapper"><input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" fieldtype="DATE" value="{0}" style="width:110px"/></span>';


-- Account Gift Total - tied to ADDRESS_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 400000, 'Gift Totals - Account has given at least $[GIFTAMOUNT] in year [GIFTYEAR]',
'((SELECT SUM(AMOUNT) FROM GIFT GIFTLOOKUP WHERE GIFTLOOKUP.CONSTITUENT_ID = [VIEWNAME].ADDRESS_CONSTITUENT_ID AND YEAR(TRANSACTION_DATE) = {1}) >= {0})',
'Gift Totals - Account has given at least $<input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" value="{0}"/> in year <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1]" value="{1}"/>';

-- Account Gift Total - tied to AUDIT_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 410000, 'Gift Totals - Account has given at least $[GIFTAMOUNT] in year [GIFTYEAR]',
'((SELECT SUM(AMOUNT) FROM GIFT GIFTLOOKUP WHERE GIFTLOOKUP.CONSTITUENT_ID = [VIEWNAME].AUDIT_CONSTITUENT_ID AND YEAR(TRANSACTION_DATE) = {1}) >= {0})',
'Gift Totals - Account has given at least $<input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" value="{0}"/> in year <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1]" value="{1}"/>';

-- Account Gift Total - tied to COMMITMENT_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 420000, 'Gift Totals - Account has given at least $[GIFTAMOUNT] in year [GIFTYEAR]',
'((SELECT SUM(AMOUNT) FROM GIFT GIFTLOOKUP WHERE GIFTLOOKUP.CONSTITUENT_ID = [VIEWNAME].COMMITMENT_CONSTITUENT_ID AND YEAR(TRANSACTION_DATE) = {1}) >= {0})',
'Gift Totals - Account has given at least $<input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" value="{0}"/> in year <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1]" value="{1}"/>';

-- Account Gift Total - tied to COMMUNICATION_HISTORY_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 430000, 'Gift Totals - Account has given at least $[GIFTAMOUNT] in year [GIFTYEAR]',
'((SELECT SUM(AMOUNT) FROM GIFT GIFTLOOKUP WHERE GIFTLOOKUP.CONSTITUENT_ID = [VIEWNAME].COMMUNICATION_HISTORY_CONSTITUENT_ID AND YEAR(TRANSACTION_DATE) = {1}) >= {0})',
'Gift Totals - Account has given at least $<input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" value="{0}"/> in year <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1]" value="{1}"/>';

-- Account Gift Total - tied to EMAIL_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 440000, 'Gift Totals - Account has given at least $[GIFTAMOUNT] in year [GIFTYEAR]',
'((SELECT SUM(AMOUNT) FROM GIFT GIFTLOOKUP WHERE GIFTLOOKUP.CONSTITUENT_ID = [VIEWNAME].EMAIL_CONSTITUENT_ID AND YEAR(TRANSACTION_DATE) = {1}) >= {0})',
'Gift Totals - Account has given at least $<input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" value="{0}"/> in year <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1]" value="{1}"/>';

-- Account Gift Total - tied to GIFT_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 450000, 'Gift Totals - Account has given at least $[GIFTAMOUNT] in year [GIFTYEAR]',
'((SELECT SUM(AMOUNT) FROM GIFT GIFTLOOKUP WHERE GIFTLOOKUP.CONSTITUENT_ID = [VIEWNAME].GIFT_CONSTITUENT_ID AND YEAR(TRANSACTION_DATE) = {1}) >= {0})',
'Gift Totals - Account has given at least $<input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" value="{0}"/> in year <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1]" value="{1}"/>';

-- Account Gift Total - tied to PAYMENT_HISTORY_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 460000, 'Gift Totals - Account has given at least $[GIFTAMOUNT] in year [GIFTYEAR]',
'((SELECT SUM(AMOUNT) FROM GIFT GIFTLOOKUP WHERE GIFTLOOKUP.CONSTITUENT_ID = [VIEWNAME].PAYMENT_HISTORY_CONSTITUENT_ID AND YEAR(TRANSACTION_DATE) = {1}) >= {0})',
'Gift Totals - Account has given at least $<input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" value="{0}"/> in year <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1]" value="{1}"/>';

-- Account Gift Total - tied to PAYMENT_SOURCE_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 470000, 'Gift Totals - Account has given at least $[GIFTAMOUNT] in year [GIFTYEAR]',
'((SELECT SUM(AMOUNT) FROM GIFT GIFTLOOKUP WHERE GIFTLOOKUP.CONSTITUENT_ID = [VIEWNAME].PAYMENT_SOURCE_CONSTITUENT_ID AND YEAR(TRANSACTION_DATE) = {1}) >= {0})',
'Gift Totals - Account has given at least $<input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" value="{0}"/> in year <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1]" value="{1}"/>';

-- Account Gift Total - tied to CONSTITUENT_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 480000, 'Gift Totals - Account has given at least $[GIFTAMOUNT] in year [GIFTYEAR]',
'((SELECT SUM(AMOUNT) FROM GIFT GIFTLOOKUP WHERE GIFTLOOKUP.CONSTITUENT_ID = [VIEWNAME].CONSTITUENT_CONSTITUENT_ID AND YEAR(TRANSACTION_DATE) = {1}) >= {0})',
'Gift Totals - Account has given at least $<input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" value="{0}"/> in year <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1]" value="{1}"/>';

-- Account Gift Total - tied to PHONE_CONSTITUENT_ID
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 490000, 'Gift Totals - Account has given at least $[GIFTAMOUNT] in year [GIFTYEAR]',
'((SELECT SUM(AMOUNT) FROM GIFT GIFTLOOKUP WHERE GIFTLOOKUP.CONSTITUENT_ID = [VIEWNAME].PHONE_CONSTITUENT_ID AND YEAR(TRANSACTION_DATE) = {1}) >= {0})',
'Gift Totals - Account has given at least $<input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" value="{0}"/> in year <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1]" value="{1}"/>';



-- ID for table, subsource ID, another subsource ID, and filter ID
CALL ASSOCIATECUSTOMFILTERSWITHDATASUBSOURCES;