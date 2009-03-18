
-- Account has the specified code type
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 100, 'Codes - Account has a code type of [CODETYPE] with any code value',
'EXISTS (SELECT * FROM ENTITYCODES WHERE ENTITYCODES.ENTITYID = [VIEWNAME].ENTITY_ENTITYID AND CODETYPE = ''{0}'')',
'Codes - Account has a code type of <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" value="{0}" /> with any code value';

-- Account has one of the specified codes
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 200, 'Codes - Account has a code type of [CODETYPE] <br>with any of the following code values : [CODEVALUE], [CODEVALUE], [CODEVALUE], [CODEVALUE], or [CODEVALUE]',
'EXISTS (SELECT * FROM ENTITYCODES WHERE ENTITYCODES.ENTITYID = [VIEWNAME].ENTITY_ENTITYID AND CODETYPE = ''{0}'' AND CODEVALUE IN (''{1}'', ''{2}'', ''{3}'', ''{4}'', ''{5}''))',
'Codes - Account has a code type of <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" value="{0}" /> with any of the following code values : <br/> <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1]" value="{1}" /> <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[2]" value="{2}" /> <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[3]" value="{3}" /> <BR> <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[4]" value="{4}" /> <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[5]"  value="{5}" > <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[6]" value="{6}" />';

-- Gift total in a particular year
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 300, 'Gift Totals - Account gave at least $[GIFTAMOUNT] in hard gifts in calendar year [GIFTYEAR]',
'((SELECT SUM(AMT) FROM GIFTHEADER WHERE GIFTHEADER.ENTITYID = [VIEWNAME].ENTITY_ENTITYID AND YEAR(GDATE) = {1}) >= {0})',
'Gift Totals - Account gave at least $<span class="criteriaWrapper"><input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" value="{0}"style="width:75px" fieldtype="MONEY" /></span> in hard gifts in calendar year <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1]" value="{1}" style="width:75px" />';

-- Gift total in date range
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 350, 'Gift Totals - Account gave at least $[GIFTAMOUNT] in hard gifts between [GIFTDATE] and [GIFTDATE]',
'((SELECT SUM(AMT) FROM GIFTHEADER WHERE GIFTHEADER.ENTITYID = [VIEWNAME].ENTITY_ENTITYID AND GDATE BETWEEN {1} AND {2}) >= {0})',
'Gift Totals - Account gave at least <span class="criteriaWrapper">$<input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" value="{0}" style="width:100px" fieldtype="MONEY" /></span> in hard gifts <br>between <span class="criteriaWrapper"><input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1]" fieldtype="DATE" value="{1}" style="width:110px"/></span> and <span class="criteriaWrapper"><input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[2]" fieldtype="DATE" value="{2}" style="width:110px"/></span>';

INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 390, 'Pledge Codes - Account has an active or fulfilled pledge code of [PLEDGECODE]',
'EXISTS (SELECT * FROM GIFTPLEDGE WHERE GIFTPLEDGE.ENTITYID = [VIEWNAME].ENTITY_ENTITYID AND PLDGCODE = ''{0}'' AND STATUS IN (''A'',''F''))',
'Pledge Codes - Account has an active or fulfilled pledge code of <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" value="{0}" />';

-- Account is in a segmentation
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 400, 'Segmentation - Account is in segmenation job number [JOBNUMBER] and group number [GROUPNUMBER]',
'EXISTS (SELECT * FROM S{0}G{1} SEGTABLE WHERE SEGTABLE.ENTITYID = [VIEWNAME].ENTITY_ENTITYID)',
'Segmentation - Account is in segmenation job number <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" value="{0}" /> <br> and group number <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1]" value="{1}" />';

-- Account is in a merge job
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 500, 'Segmentation - Account is in merge job number [JOBNUMBER]',
'EXISTS (SELECT * FROM M{0} SEGTABLE WHERE SEGTABLE.ENTITYID = [VIEWNAME].ENTITY_ENTITYID)',
'Segmentation - Account is in merge job number <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" value="{0}" />';

-- Zip Radius
INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)
SELECT 600, 'Zip Radius - Account is within [ZIPRADIUS] miles of zip code [ZIPCODE]',
'(CONVERT(VARCHAR(5), [VIEWNAME].ENTITY_POSTALCODE) IN (SELECT TOZIP.ZIPLOW AS POSTALCODE FROM ZIPCODES TOZIP CROSS JOIN (SELECT * FROM ZIPCODES FROMZIP WHERE FROMZIP.ZIPLOW = ''{1}'') FROMZIP WHERE SQRT(((69.1 * (TOZIP.LATITUDE - FROMZIP.LATITUDE)) * (69.1 * (TOZIP.LATITUDE - FROMZIP.LATITUDE))) + ((53 * (TOZIP.LONGITUDE - FROMZIP.LONGITUDE)) * (53 * (TOZIP.LONGITUDE - FROMZIP.LONGITUDE)))) <= {0}))',
'Zip Radius - Account is within <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0]" style="width:75px" value="{0}" /> miles of zip code <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1]" style="width:100px" value="{1}" />';





-- INSERT INTO REPORTDATASOURCE
INSERT INTO REPORTDATASOURCE
	(REPORT_NAME)
VALUES
	('MPX');
 
SET @REPORTDATASOURCE_ID = LAST_INSERT_ID();
 
INSERT INTO REPORTDATASUBSOURCEGROUP
	(DESCRIPTION, DISPLAY_NAME, reportDataSource_REPORTSOURCE_ID)
VALUES
	('Account Information', 'Account Information', @REPORTDATASOURCE_ID);
 
SET @REPORTDATASUBSOURCEGROUP_ID = LAST_INSERT_ID();
 
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts', 'Account information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Addresses', 'Accounts and address information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_ADDRESSES', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Addresses', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Address ID
CALL INSERTREPORTFIELD('ENTITYADDRESSES_ENTITYADDRESSID', 'Address ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Address Type
CALL INSERTREPORTFIELD('ENTITYADDRESSES_ADDRESSTYPE', 'Address Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 1
CALL INSERTREPORTFIELD('ENTITYADDRESSES_ADDRESS1', 'Address 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 2
CALL INSERTREPORTFIELD('ENTITYADDRESSES_ADDRESS2', 'Address 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 3
CALL INSERTREPORTFIELD('ENTITYADDRESSES_ADDRESS3', 'Address 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITYADDRESSES_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITYADDRESSES_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Zip Code
CALL INSERTREPORTFIELD('ENTITYADDRESSES_POSTALCODE', 'Zip Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITYADDRESSES_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Active Date
CALL INSERTREPORTFIELD('ENTITYADDRESSES_ACTIVEDATE', 'Active Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Inactive Date
CALL INSERTREPORTFIELD('ENTITYADDRESSES_INACTIVEDATE', 'Inactive Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Primary Address
CALL INSERTREPORTFIELD('ENTITYADDRESSES_PRIMARYADDRESS', 'Primary Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Recurrance
CALL INSERTREPORTFIELD('ENTITYADDRESSES_RECURRANCE', 'Recurrance', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITYADDRESSES_CREATEUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITYADDRESSES_MODIFIEDUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITYADDRESSES_CREATEDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITYADDRESSES_MODIFIEDDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name in Address
CALL INSERTREPORTFIELD('ENTITYADDRESSES_INCLUDEORGNAME', 'Include Organization Name in Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Use Alternate Name
CALL INSERTREPORTFIELD('ENTITYADDRESSES_ALTERNATENAME', 'Use Alternate Name', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITYADDRESSES_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITYADDRESSES_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITYADDRESSES_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITYADDRESSES_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Date Activated
CALL INSERTREPORTFIELD('ENTITYADDRESSES_DATEACTIVATED', 'Date Activated', b'0', 2, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Codes', 'Accounts and code information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_CODES', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Codes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Code Type
CALL INSERTREPORTFIELD('ENTITYCODES_CODETYPE', 'Code Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Code Value
CALL INSERTREPORTFIELD('ENTITYCODES_CODEVALUE', 'Code Value', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITYCODES_MODIFIEDUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITYCODES_MODIFIEDDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Code ID
CALL INSERTREPORTFIELD('ENTITYCODES_ENTITYCODEID', 'Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITYCODES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITYCODES_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Correspondence', 'Accounts and correspondence information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_CORRESPOND', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Correspondence', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Correspondence ID
CALL INSERTREPORTFIELD('ENTITYCORRESPOND_CORRESPONDID', 'Correspondence ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Type
CALL INSERTREPORTFIELD('ENTITYCORRESPOND_TYPE', 'Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Letter Code
CALL INSERTREPORTFIELD('ENTITYCORRESPOND_LTRCODE', 'Letter Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Correspondence Date
CALL INSERTREPORTFIELD('ENTITYCORRESPOND_LDATE', 'Correspondence Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Source
CALL INSERTREPORTFIELD('ENTITYCORRESPOND_SRC', 'Source', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Reference Number
CALL INSERTREPORTFIELD('ENTITYCORRESPOND_REF', 'Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITYCORRESPOND_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Print Group
CALL INSERTREPORTFIELD('ENTITYCORRESPOND_PRTGRP', 'Print Group', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Print Date
CALL INSERTREPORTFIELD('ENTITYCORRESPOND_PRTDATE', 'Print Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 1
CALL INSERTREPORTFIELD('ENTITYCORRESPOND_PARACODE1', 'Paragraph Code 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 2
CALL INSERTREPORTFIELD('ENTITYCORRESPOND_PARACODE2', 'Paragraph Code 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 3
CALL INSERTREPORTFIELD('ENTITYCORRESPOND_PARACODE3', 'Paragraph Code 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 4
CALL INSERTREPORTFIELD('ENTITYCORRESPOND_PARACODE4', 'Paragraph Code 4', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Print Job
CALL INSERTREPORTFIELD('ENTITYCORRESPOND_PRTJOB', 'Print Job', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Dates', 'Accounts and date information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_DATES', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Dates', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Date ID
CALL INSERTREPORTFIELD('ENTITYDATES_ENTITYDATESID', 'Date ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Date Type
CALL INSERTREPORTFIELD('ENTITYDATES_DATETYPE', 'Date Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Date Value
CALL INSERTREPORTFIELD('ENTITYDATES_DATEVALUE', 'Date Value', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('ENTITYDATES_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('ENTITYDATES_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITYDATES_MODIFIEDUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITYDATES_MODIFIEDDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITYDATES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITYDATES_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Email Addresses', 'Accounts and email address information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_EMAIL', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Email Addresses', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Email ID
CALL INSERTREPORTFIELD('ENTITYEMAIL_ENTITYEMAILID', 'Email ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Email Address
CALL INSERTREPORTFIELD('ENTITYEMAIL_EMAILADDRESS', 'Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Is Default Email
CALL INSERTREPORTFIELD('ENTITYEMAIL_DEFAULTEMAIL', 'Is Default Email', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('ENTITYEMAIL_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITYEMAIL_CREATEUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITYEMAIL_MODIFIEDUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITYEMAIL_CREATEDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITYEMAIL_MODIFIEDDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Financial Profile Information', 'Accounts and financial profile information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_ENTITYFINANCIALS', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Financial Profile', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Financial Profile ID
CALL INSERTREPORTFIELD('ENTITYFINANCIALS_FINANCIALID', 'Financial Profile ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Projected Future Giving
CALL INSERTREPORTFIELD('ENTITYFINANCIALS_PROJECTED', 'Projected Future Giving', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Projected Future Giving Description
CALL INSERTREPORTFIELD('ENTITYFINANCIALS_PROJECTEDNOTE', 'Projected Future Giving Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Capacity to Give
CALL INSERTREPORTFIELD('ENTITYFINANCIALS_CAPACITY', 'Capacity to Give', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Capacity to Give Description
CALL INSERTREPORTFIELD('ENTITYFINANCIALS_CAPACITYNOTE', 'Capacity to Give Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Propensity to Gift
CALL INSERTREPORTFIELD('ENTITYFINANCIALS_PROPENSITY', 'Propensity to Gift', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Philanthropic Interests
CALL INSERTREPORTFIELD('ENTITYFINANCIALS_PHILANTHROPIC', 'Philanthropic Interests', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('ENTITYFINANCIALS_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Notes', 'Accounts and note information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_NOTES', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Notes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Next Action Date
CALL INSERTREPORTFIELD('ENTITYNOTES_NEXTDATE', 'Next Action Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITYNOTES_MODIFIEDUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITYNOTES_MODIFIEDDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Note ID
CALL INSERTREPORTFIELD('ENTITYNOTES_ENTITYNOTEID', 'Note ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Next Action Note
CALL INSERTREPORTFIELD('ENTITYNOTES_NEXTACTIONNOTE', 'Next Action Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITYNOTES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITYNOTES_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Phone Numbers', 'Accounts and phone numbers', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_PHONE', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Phone Numbers', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Phone Number ID
CALL INSERTREPORTFIELD('ENTITYPHONE_ENTITYPHONEID', 'Phone Number ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Phone Type
CALL INSERTREPORTFIELD('ENTITYPHONE_PHONETYPE', 'Phone Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Phone Number
CALL INSERTREPORTFIELD('ENTITYPHONE_PHONENUMBER', 'Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Active Date
CALL INSERTREPORTFIELD('ENTITYPHONE_ACTIVEDATE', 'Active Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Inactive Date
CALL INSERTREPORTFIELD('ENTITYPHONE_INACTIVEDATE', 'Inactive Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Is Default Phone Number
CALL INSERTREPORTFIELD('ENTITYPHONE_DEFAULTPHONE', 'Is Default Phone Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITYPHONE_CREATEUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITYPHONE_MODIFIEDUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITYPHONE_CREATEDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITYPHONE_MODIFIEDDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Relationships', 'Accounts and relationship information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_ENTITYRELATIONSHIPS', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Relationships', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITYRELATIONSHIPS_RELATEDENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Relationship Type
CALL INSERTREPORTFIELD('ENTITYRELATIONSHIPS_TYPE', 'Relationship Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Related Account Name
CALL INSERTREPORTFIELD('ENTITYRELATIONSHIPS_NAMEKEY', 'Related Account Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('ENTITYRELATIONSHIPS_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Relationship ID
CALL INSERTREPORTFIELD('ENTITYRELATIONSHIPS_ENTITYRELATIONSHIPSID', 'Relationship ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Company Short Name
CALL INSERTREPORTFIELD('ENTITYRELATIONSHIPS_COMPANY_SHORT_NAME', 'Company Short Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Salutations', 'Accounts and salutation information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_ENTITYSALUTATION', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Salutations', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Salutation ID
CALL INSERTREPORTFIELD('ENTITYSALUTATION_ENTITYSALUTATIONID', 'Salutation ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Salutation
CALL INSERTREPORTFIELD('ENTITYSALUTATION_SALUTATION', 'Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Salutation Type
CALL INSERTREPORTFIELD('ENTITYSALUTATION_SALUTATIONTYPE', 'Salutation Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Is Default Salutation
CALL INSERTREPORTFIELD('ENTITYSALUTATION_DEFAULTSALUTATION', 'Is Default Salutation', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITYSALUTATION_CREATEUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITYSALUTATION_CREATEDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
INSERT INTO REPORTDATASUBSOURCEGROUP
	(DESCRIPTION, DISPLAY_NAME, reportDataSource_REPORTSOURCE_ID)
VALUES
	('Accounts & Transaction Information', 'Accounts & Transaction Information', @REPORTDATASOURCE_ID);
 
SET @REPORTDATASUBSOURCEGROUP_ID = LAST_INSERT_ID();
 
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & ACH Information', 'Accounts and ACH information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_ACH', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Bank Cards', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert ACH ID
CALL INSERTREPORTFIELD('ENTITYACH_ENTITYACHID', 'ACH ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert ACH Type
CALL INSERTREPORTFIELD('ENTITYACH_ACHTYPE', 'ACH Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Routing Number
CALL INSERTREPORTFIELD('ENTITYACH_ROUTINGNBR', 'Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITYACH_BANKNBR', 'Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bank Name
CALL INSERTREPORTFIELD('ENTITYACH_BANK', 'Bank Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & AR Monthly Summaries', 'Accounts and AR monthly summary information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_ARMONTHLYHISTORY', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Accounts Receivable Monthly Summary', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ACCTRECVHISTORY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Year
CALL INSERTREPORTFIELD('ACCTRECVHISTORY_CURRYEAR', 'Year', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Month
CALL INSERTREPORTFIELD('ACCTRECVHISTORY_CURRMONTH', 'Month', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('ACCTRECVHISTORY_AMT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert AR History ID
CALL INSERTREPORTFIELD('ACCTRECVHISTORY_ACCTRECVHISTORYID', 'AR History ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & AR Transaction History', 'Accounts and AR transaction (payments, amounts due, adjustments) information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_ARTRANSACTIONS', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Accounts Receivable Transactions', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ACCTRECV_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('ACCTRECV_BATCHNBR', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert AR Date
CALL INSERTREPORTFIELD('ACCTRECV_RDATE', 'AR Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Transaction Type
CALL INSERTREPORTFIELD('ACCTRECV_TYPE', 'Transaction Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('ACCTRECV_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ACCTRECV_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('ACCTRECV_AMT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Order Number
CALL INSERTREPORTFIELD('ACCTRECV_ORDNBR', 'Order Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Apply Date
CALL INSERTREPORTFIELD('ACCTRECV_ADATE', 'Apply Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('ACCTRECV_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('ACCTRECV_CONVRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert AR Transaction ID
CALL INSERTREPORTFIELD('ACCTRECV_ACCTRECVID', 'AR Transaction ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Payment Type
CALL INSERTREPORTFIELD('ACCTRECV_PAYMENTTYPE', 'Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Type
CALL INSERTREPORTFIELD('ACCTRECV_CHARGETYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Number
CALL INSERTREPORTFIELD('ACCTRECV_PAYMENTNUMBER', 'Credit Card Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Expiration Date
CALL INSERTREPORTFIELD('ACCTRECV_EXPIRATIONDATE', 'Credit Card Expiration Date', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bank Routing Number
CALL INSERTREPORTFIELD('ACCTRECV_CHECKROUTINGNUMBER', 'Bank Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bank Name
CALL INSERTREPORTFIELD('ACCTRECV_BANKNAME', 'Bank Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Authorization Code
CALL INSERTREPORTFIELD('ACCTRECV_AUTHORIZATIONCODE', 'Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Charge History ID
CALL INSERTREPORTFIELD('ACCTRECV_CHARGEHISTORYID', 'Charge History ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Converted Amount
CALL INSERTREPORTFIELD('ACCTRECV_CONVERTEDAMOUNT', 'Converted Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Credit Cards', 'Accounts and credit card information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_CREDITCARDS', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Credit Cards', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Credit Card ID
CALL INSERTREPORTFIELD('ENTITYCREDITCARDS_ENTITYCREDITCARDID', 'Credit Card ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Name On Card
CALL INSERTREPORTFIELD('ENTITYCREDITCARDS_NAMEONCARD', 'Name On Card', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Type
CALL INSERTREPORTFIELD('ENTITYCREDITCARDS_CREDITCARDTYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Number
CALL INSERTREPORTFIELD('ENTITYCREDITCARDS_CREDITCARDNUMBER', 'Credit Card Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Expiration Date
CALL INSERTREPORTFIELD('ENTITYCREDITCARDS_CARDEXPDATE', 'Credit Card Expiration Date', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Financial Institution
CALL INSERTREPORTFIELD('ENTITYCREDITCARDS_BANK', 'Financial Institution', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('ENTITYCREDITCARDS_CREDITCARDNOTE', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITYCREDITCARDS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITYCREDITCARDS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITYCREDITCARDS_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITYCREDITCARDS_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITYCREDITCARDS_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITYCREDITCARDS_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Use Date
CALL INSERTREPORTFIELD('ENTITYCREDITCARDS_LASTUSEDATE', 'Last Use Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Gift Annual Summaries', 'Accounts and annual gift summary information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_GIFTANNUAL', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift History Annual Summary', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('GIFTANNUAL_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Deductible
CALL INSERTREPORTFIELD('GIFTANNUAL_DEDUCT', 'Deductible', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Year
CALL INSERTREPORTFIELD('GIFTANNUAL_CURRYEAR', 'Year', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Number of Gifts
CALL INSERTREPORTFIELD('GIFTANNUAL_NBR', 'Number of Gifts', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('GIFTANNUAL_AMT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Amount
CALL INSERTREPORTFIELD('GIFTANNUAL_CONVAMT', 'Converted Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Soft Gift
CALL INSERTREPORTFIELD('GIFTANNUAL_SOFT', 'Soft Gift', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Net Gift Amount
CALL INSERTREPORTFIELD('GIFTANNUAL_NETGIFT', 'Net Gift Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Net Gift Amount
CALL INSERTREPORTFIELD('GIFTANNUAL_CONVNETGIFT', 'Converted Net Gift Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Premium Amount
CALL INSERTREPORTFIELD('GIFTANNUAL_PREMIUM', 'Premium Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Gift Pictures', 'Accounts and gift pictures including associated information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_GIFTPICTURES', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift Picture', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Gift Picture ID
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_ENTITYGIFTPICID', 'Gift Picture ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_AMT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_PROJCODE', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Pledge Code
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_PLDGCODE', 'Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Pledge Code ID
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_PLEDGEID', 'Pledge Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Deductible
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_DEDUCT', 'Deductible', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Anonymous
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_ANNON', 'Anonymous', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Related Account Number
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_SACCTNBR', 'Related Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Program ID
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_PROGRAMID', 'Media Program ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Type
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_PAYTYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Number
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_PAYNBR', 'Credit Card Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Type
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_CARDTYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Expiration Date
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_CARDEXPIRE', 'Credit Card Expiration Date', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bank Routing Number
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_ROUTINGNBR', 'Bank Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bank Account Number
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_BANKNBR', 'Bank Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Outlets', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Code ID
CALL INSERTREPORTFIELD('MEDIAOUTLETS_MEDIACODE_ID', 'Media Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('MEDIAOUTLETS_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Frequency
CALL INSERTREPORTFIELD('MEDIAOUTLETS_FREQ', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Output Power
CALL INSERTREPORTFIELD('MEDIAOUTLETS_POWEROUT', 'Output Power', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('MEDIAOUTLETS_CITYOFLICENSE', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('MEDIAOUTLETS_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('MEDIAOUTLETS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web Page Address
CALL INSERTREPORTFIELD('MEDIAOUTLETS_WEBSITE_URL', 'Web Page Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('MEDIAOUTLETS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('MEDIAOUTLETS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Address 1
CALL INSERTREPORTFIELD('MEDIAOUTLETS_ADDRESS1', 'Address 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 2
CALL INSERTREPORTFIELD('MEDIAOUTLETS_ADDRESS2', 'Address 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 3
CALL INSERTREPORTFIELD('MEDIAOUTLETS_ADDRESS3', 'Address 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Zip Code
CALL INSERTREPORTFIELD('MEDIAOUTLETS_ZIPCODE', 'Zip Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('MEDIAOUTLETS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('MEDIAOUTLETS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('MEDIAOUTLETS_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('MEDIAOUTLETS_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('MEDIAOUTLETS_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('MEDIAOUTLETS_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Email Address
CALL INSERTREPORTFIELD('MEDIAOUTLETS_EMAILADDRESS', 'Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Tag Line
CALL INSERTREPORTFIELD('MEDIAOUTLETS_TAGLINE', 'Tag Line', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Translator
CALL INSERTREPORTFIELD('MEDIAOUTLETS_TRANSLATOR', 'Translator', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Flagship ID
CALL INSERTREPORTFIELD('MEDIAOUTLETS_FLAGSHIPID', 'Flagship ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Commercial / Non-Commercial
CALL INSERTREPORTFIELD('MEDIAOUTLETS_COMMERCIAL', 'Commercial / Non-Commercial', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Target ROI
CALL INSERTREPORTFIELD('MEDIAOUTLETS_TARGETROI', 'Target ROI', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Coverage Area
CALL INSERTREPORTFIELD('MEDIAOUTLETS_COVERAGEAREA', 'Coverage Area', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Delivery Methods', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Delivery Method
CALL INSERTREPORTFIELD('DELIVERYMETHODS_DELIVERY_METHOD', 'Delivery Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('DELIVERYMETHODS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Medium Types', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Medium Type
CALL INSERTREPORTFIELD('MEDIUMTYPES_MEDIUM_TYPE', 'Medium Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('MEDIUMTYPES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Medium Coverage Type
CALL INSERTREPORTFIELD('MEDIUMTYPES_COVERAGETYPE', 'Medium Coverage Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Medium Sub Types', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Medium Sub-Type
CALL INSERTREPORTFIELD('MEDIUMSUBTYPES_MEDIUM_SUBTYPE', 'Medium Sub-Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('MEDIUMSUBTYPES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Outlet Formats', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Format Name
CALL INSERTREPORTFIELD('MEDIAOUTLETFORMATS_FORMAT_NAME', 'Media Format Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('MEDIAOUTLETFORMATS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Motivation Codes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('MOTIVATIONCODES_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('MOTIVATIONCODES_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Number Mailed
CALL INSERTREPORTFIELD('MOTIVATIONCODES_NBR', 'Number Mailed', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Date
CALL INSERTREPORTFIELD('MOTIVATIONCODES_MDATE', 'Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Cost
CALL INSERTREPORTFIELD('MOTIVATIONCODES_COST', 'Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Default Project Code
CALL INSERTREPORTFIELD('MOTIVATIONCODES_DEFPROJCODE', 'Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('MOTIVATIONCODES_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('MOTIVATIONCODES_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('MOTIVATIONCODES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('MOTIVATIONCODES_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Campaign
CALL INSERTREPORTFIELD('MOTIVATIONCODES_CAMPAIGN', 'Campaign', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Kit
CALL INSERTREPORTFIELD('MOTIVATIONCODES_KIT', 'Kit', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Cost Per
CALL INSERTREPORTFIELD('MOTIVATIONCODES_COSTPER', 'Cost Per', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert User 1
CALL INSERTREPORTFIELD('MOTIVATIONCODES_USER1', 'User 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert User 2
CALL INSERTREPORTFIELD('MOTIVATIONCODES_USER2', 'User 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Project Codes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('PROJECTCODES_PROJECT', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('PROJECTCODES_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('PROJECTCODES_DONORENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Email Report
CALL INSERTREPORTFIELD('PROJECTCODES_STMTTOFILE', 'Email Report', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('PROJECTCODES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Projectcodeentity', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('PROJECTCODEENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Pledges', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Pledge Code
CALL INSERTREPORTFIELD('GIFTPLEDGE_PLDGCODE', 'Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFTPLEDGE_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Start Date
CALL INSERTREPORTFIELD('GIFTPLEDGE_STARTDATE', 'Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert End Date
CALL INSERTREPORTFIELD('GIFTPLEDGE_ENDDATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Total Amount Pledged
CALL INSERTREPORTFIELD('GIFTPLEDGE_TOTAMTPLDG', 'Total Amount Pledged', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Amount Per Gift
CALL INSERTREPORTFIELD('GIFTPLEDGE_AMTPERGIFT', 'Amount Per Gift', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Number of Gifts Pledged
CALL INSERTREPORTFIELD('GIFTPLEDGE_NBRPLDG', 'Number of Gifts Pledged', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Frequency
CALL INSERTREPORTFIELD('GIFTPLEDGE_FREQ', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('GIFTPLEDGE_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Amount Given
CALL INSERTREPORTFIELD('GIFTPLEDGE_AMTGIVEN', 'Amount Given', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Amount Remaining
CALL INSERTREPORTFIELD('GIFTPLEDGE_AMTREMAIN', 'Amount Remaining', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Number of Gifts Given
CALL INSERTREPORTFIELD('GIFTPLEDGE_NBRGIVEN', 'Number of Gifts Given', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFTPLEDGE_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('GIFTPLEDGE_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFTPLEDGE_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Pledge Paid Through Date
CALL INSERTREPORTFIELD('GIFTPLEDGE_PLDGPAIDTHRUDATE', 'Pledge Paid Through Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Relatedaccountentity', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('RELATEDACCOUNTENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Gift Summaries', 'Accounts and overall gift summary information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_GIFTSUMMARY', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift History Summary', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('GIFTSUMMARY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('GIFTSUMMARY_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Deductible
CALL INSERTREPORTFIELD('GIFTSUMMARY_DEDUCT', 'Deductible', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Soft Gift
CALL INSERTREPORTFIELD('GIFTSUMMARY_SOFT', 'Soft Gift', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('GIFTSUMMARY_AMT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Amount
CALL INSERTREPORTFIELD('GIFTSUMMARY_CONVAMT', 'Converted Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Number of Gifts Given
CALL INSERTREPORTFIELD('GIFTSUMMARY_NBR', 'Number of Gifts Given', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert First Gift Date
CALL INSERTREPORTFIELD('GIFTSUMMARY_FIRSTDATE', 'First Gift Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert First Gift Amount
CALL INSERTREPORTFIELD('GIFTSUMMARY_FIRSTAMT', 'First Gift Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert First Gift Converted Amount
CALL INSERTREPORTFIELD('GIFTSUMMARY_FIRSTCONVAMT', 'First Gift Converted Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert First Gift Reference Number
CALL INSERTREPORTFIELD('GIFTSUMMARY_FIRSTGIFTREF', 'First Gift Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Large Gift Date
CALL INSERTREPORTFIELD('GIFTSUMMARY_LARGEDATE', 'Large Gift Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Large Gift Amount
CALL INSERTREPORTFIELD('GIFTSUMMARY_LARGEAMT', 'Large Gift Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Large Gift Converted Amount
CALL INSERTREPORTFIELD('GIFTSUMMARY_LARGECONVAMT', 'Large Gift Converted Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Large Gift Reference Number
CALL INSERTREPORTFIELD('GIFTSUMMARY_LARGEGIFTREF', 'Large Gift Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Last Gift Date
CALL INSERTREPORTFIELD('GIFTSUMMARY_LASTDATE', 'Last Gift Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Last Gift Amount
CALL INSERTREPORTFIELD('GIFTSUMMARY_LASTAMT', 'Last Gift Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Last Gift Converted Amount
CALL INSERTREPORTFIELD('GIFTSUMMARY_LASTCONVAMT', 'Last Gift Converted Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Last Gift Reference Number
CALL INSERTREPORTFIELD('GIFTSUMMARY_LASTGIFTREF', 'Last Gift Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Net Gift Amount
CALL INSERTREPORTFIELD('GIFTSUMMARY_NETGIFT', 'Net Gift Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Net Gift Amount
CALL INSERTREPORTFIELD('GIFTSUMMARY_CONVNETGIFT', 'Converted Net Gift Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Premium Amount
CALL INSERTREPORTFIELD('GIFTSUMMARY_PREMIUM', 'Premium Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('First Gift - Gift Headers', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Gift Reference Number
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_GIFTREF', 'Gift Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Gift Date
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_GDATE', 'Gift Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Apply Date
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_APPLYDATE', 'Apply Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_BATCHNBR', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_AMT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Payment Type
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_PAYCODE', 'Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / ACH Type
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_PAYTYPE', 'Credit Card / ACH Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / Bank Account Number
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_PAYNBR', 'Credit Card / Bank Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Expiration Date
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_EXPIRE', 'Credit Card Expiration Date', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Authorization Code
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_CHARGEAUTH', 'Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Receipt Number
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_RCPTNBR', 'Receipt Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Receipt Print Status
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_RCPTPRINT', 'Receipt Print Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Print Group
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_PRTGRP', 'Print Group', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Letter Code
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_LTRCODE', 'Letter Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_CONVRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Order Number
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_ORDNBR', 'Order Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 1
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_PARACODE1', 'Paragraph Code 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 2
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_PARACODE2', 'Paragraph Code 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bank Routing Number
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_ROUTENBR', 'Bank Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Bank Name
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_BANK', 'Bank Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Transaction Source
CALL INSERTREPORTFIELD('GIFTHEADER_FIRSTGIFT_TRANSACTIONSOURCE', 'Transaction Source', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Last Gift - Gift Headers', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Gift Reference Number
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_GIFTREF', 'Gift Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Gift Date
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_GDATE', 'Gift Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Apply Date
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_APPLYDATE', 'Apply Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_BATCHNBR', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_AMT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Payment Type
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_PAYCODE', 'Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / ACH Type
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_PAYTYPE', 'Credit Card / ACH Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / Bank Account Number
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_PAYNBR', 'Credit Card / Bank Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Expiration Date
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_EXPIRE', 'Credit Card Expiration Date', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Authorization Code
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_CHARGEAUTH', 'Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Receipt Number
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_RCPTNBR', 'Receipt Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Receipt Print Status
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_RCPTPRINT', 'Receipt Print Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Print Group
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_PRTGRP', 'Print Group', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Letter Code
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_LTRCODE', 'Letter Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_CONVRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Order Number
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_ORDNBR', 'Order Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 1
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_PARACODE1', 'Paragraph Code 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 2
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_PARACODE2', 'Paragraph Code 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bank Routing Number
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_ROUTENBR', 'Bank Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Bank Name
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_BANK', 'Bank Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Transaction Source
CALL INSERTREPORTFIELD('GIFTHEADER_LASTGIFT_TRANSACTIONSOURCE', 'Transaction Source', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Large Gift - Gift Headers', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Gift Reference Number
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_GIFTREF', 'Gift Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Gift Date
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_GDATE', 'Gift Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Apply Date
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_APPLYDATE', 'Apply Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_BATCHNBR', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_AMT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Payment Type
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_PAYCODE', 'Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / ACH Type
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_PAYTYPE', 'Credit Card / ACH Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / Bank Account Number
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_PAYNBR', 'Credit Card / Bank Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Expiration Date
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_EXPIRE', 'Credit Card Expiration Date', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Authorization Code
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_CHARGEAUTH', 'Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Receipt Number
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_RCPTNBR', 'Receipt Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Receipt Print Status
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_RCPTPRINT', 'Receipt Print Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Print Group
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_PRTGRP', 'Print Group', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Letter Code
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_LTRCODE', 'Letter Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_CONVRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Order Number
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_ORDNBR', 'Order Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 1
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_PARACODE1', 'Paragraph Code 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 2
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_PARACODE2', 'Paragraph Code 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bank Routing Number
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_ROUTENBR', 'Bank Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Bank Name
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_BANK', 'Bank Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Transaction Source
CALL INSERTREPORTFIELD('GIFTHEADER_LARGEGIFT_TRANSACTIONSOURCE', 'Transaction Source', b'0', 2, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Gifts', 'Accounts and gifts (hard & soft) including associated information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_GIFTS', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift Headers', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Gift Reference Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_GIFTREF', 'Gift Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Gift Date
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_GDATE', 'Gift Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Apply Date
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_APPLYDATE', 'Apply Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_BATCHNBR', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_AMT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Payment Type
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PAYCODE', 'Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / ACH Type
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PAYTYPE', 'Credit Card / ACH Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / Bank Account Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PAYNBR', 'Credit Card / Bank Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Expiration Date
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_EXPIRE', 'Credit Card Expiration Date', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Authorization Code
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CHARGEAUTH', 'Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Receipt Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_RCPTNBR', 'Receipt Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Receipt Print Status
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_RCPTPRINT', 'Receipt Print Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Print Group
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PRTGRP', 'Print Group', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Letter Code
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_LTRCODE', 'Letter Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Letter Print Status
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_LTRPRINT', 'Letter Print Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CONVRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Order Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ORDNBR', 'Order Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 1
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PARACODE1', 'Paragraph Code 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 2
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PARACODE2', 'Paragraph Code 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bank Routing Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ROUTENBR', 'Bank Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Media Program ID
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PROGRAMID', 'Media Program ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Episode ID
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_EPISODEID', 'Media Episode ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Bank Name
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_BANK', 'Bank Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Placement ID
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_MEDIAPLACEMENTID', 'Media Placement ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Transaction Source
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_TRANSACTIONSOURCE', 'Transaction Source', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Soft Gift
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_SOFTGIFT', 'Soft Gift', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Batches', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('GIFT_BATCHES_BATCHNBR', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_BDATE', 'Batch Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert GL Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_GLDATE', 'GL Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Fund
CALL INSERTREPORTFIELD('GIFT_BATCHES_FUND', 'Fund', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert GL Account
CALL INSERTREPORTFIELD('GIFT_BATCHES_GLACCT', 'GL Account', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Cost Center
CALL INSERTREPORTFIELD('GIFT_BATCHES_CC', 'Cost Center', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_PROJCODE', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('GIFT_BATCHES_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('GIFT_BATCHES_CONVRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Control Amount
CALL INSERTREPORTFIELD('GIFT_BATCHES_CONTROLAMT', 'Control Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Actual Amount
CALL INSERTREPORTFIELD('GIFT_BATCHES_ACTUALAMT', 'Actual Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Default Motivation Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_DEFMOTVCODE', 'Default Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Project Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_DEFFUNDID', 'Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Pledge Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_DEFPLDGCODE', 'Default Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Payment Type
CALL INSERTREPORTFIELD('GIFT_BATCHES_DEFPAYCODE', 'Default Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('GIFT_BATCHES_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('GIFT_BATCHES_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Posted Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_APPLYDATE', 'Posted Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 1
CALL INSERTREPORTFIELD('GIFT_BATCHES_TYPE1', 'Batch Type 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 2
CALL INSERTREPORTFIELD('GIFT_BATCHES_TYPE2', 'Batch Type 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Actual Number
CALL INSERTREPORTFIELD('GIFT_BATCHES_ACTUALNBR', 'Actual Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Control Number
CALL INSERTREPORTFIELD('GIFT_BATCHES_CONTROLNBR', 'Control Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Status
CALL INSERTREPORTFIELD('GIFT_BATCHES_BATCHSTATUS', 'Batch Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('GIFT_BATCHES_CHANGEUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('GIFT_BATCHES_CHANGEUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Deposit Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_DEPOSITDATE', 'Deposit Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Owner ID
CALL INSERTREPORTFIELD('GIFT_BATCHES_OWNERID', 'Batch Owner ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Owner User Name
CALL INSERTREPORTFIELD('GIFT_BATCHES_BATCHOWNERNAME', 'Batch Owner User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Purchase Location
CALL INSERTREPORTFIELD('GIFT_BATCHES_LOCATION', 'Default Purchase Location', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Free Location
CALL INSERTREPORTFIELD('GIFT_BATCHES_FREELOCATION', 'Default Free Location', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Price Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_PRICECODE', 'Default Price Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Outlets', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Code ID
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_MEDIACODE_ID', 'Media Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Frequency
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_FREQ', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Output Power
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_POWEROUT', 'Output Power', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_CITYOFLICENSE', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web Page Address
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_WEBSITE_URL', 'Web Page Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Address 1
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDRESS1', 'Address 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 2
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDRESS2', 'Address 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 3
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDRESS3', 'Address 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Zip Code
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ZIPCODE', 'Zip Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Email Address
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_EMAILADDRESS', 'Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Tag Line
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_TAGLINE', 'Tag Line', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Translator
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_TRANSLATOR', 'Translator', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Flagship ID
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_FLAGSHIPID', 'Flagship ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Commercial / Non-Commercial
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_COMMERCIAL', 'Commercial / Non-Commercial', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Target ROI
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_TARGETROI', 'Target ROI', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Coverage Area
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_COVERAGEAREA', 'Coverage Area', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Delivery Methods', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Delivery Method
CALL INSERTREPORTFIELD('GIFT_DELIVERYMETHODS_DELIVERY_METHOD', 'Delivery Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_DELIVERYMETHODS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Medium Types', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Medium Type
CALL INSERTREPORTFIELD('GIFT_MEDIUMTYPES_MEDIUM_TYPE', 'Medium Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIUMTYPES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Medium Coverage Type
CALL INSERTREPORTFIELD('GIFT_MEDIUMTYPES_COVERAGETYPE', 'Medium Coverage Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Medium Sub Types', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Medium Sub-Type
CALL INSERTREPORTFIELD('GIFT_MEDIUMSUBTYPES_MEDIUM_SUBTYPE', 'Medium Sub-Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIUMSUBTYPES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Outlet Formats', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Format Name
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETFORMATS_FORMAT_NAME', 'Media Format Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETFORMATS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Placements', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Lead In
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_LEADIN', 'Lead In', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Lead Out
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_LEADOUT', 'Lead Out', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Monday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_MONDAY', 'Monday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Tuesday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_TUESDAY', 'Tuesday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Wednesday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_WEDNESDAY', 'Wednesday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Thursday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_THURSDAY', 'Thursday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Friday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_FRIDAY', 'Friday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Saturday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_SATURDAY', 'Saturday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Sunday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_SUNDAY', 'Sunday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Air Time
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_LOCALTIMESLOT_BEGIN', 'Air Time', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code ID
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_MEDIAID', 'Media Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Begin Date
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_BEGINDATE', 'Begin Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert End Date
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_ENDDATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Media Agency ID
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_AGENCYID', 'Media Agency ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Contract Type
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_CONTRACT_TYPE', 'Contract Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Delivery Method ID
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_DELIVERYID', 'Delivery Method ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Is Default Placement
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_DEFAULTPLACEMENT', 'Is Default Placement', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Programs', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Program Name
CALL INSERTREPORTFIELD('GIFT_MEDIAPROGRAMS_NAME', 'Media Program Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('GIFT_MEDIAPROGRAMS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Length
CALL INSERTREPORTFIELD('GIFT_MEDIAPROGRAMS_LENGTH', 'Length', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Length Seconds / Minutes
CALL INSERTREPORTFIELD('GIFT_MEDIAPROGRAMS_MINSEC', 'Length Seconds / Minutes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIAPROGRAMS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Gift Detail ID
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_GIFTDETAILID', 'Gift Detail ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_AMT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_PROJCODE', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Deductible
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_DEDUCT', 'Deductible', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Anonymous
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_ANNON', 'Anonymous', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Related Account Number
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_SACCTNBR', 'Related Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_GIFTDETAILNOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Motivation Codes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Number Mailed
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_NBR', 'Number Mailed', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Date
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_MDATE', 'Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Cost
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_COST', 'Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Default Project Code
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_DEFPROJCODE', 'Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Campaign
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_CAMPAIGN', 'Campaign', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Kit
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_KIT', 'Kit', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Cost Per
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_COSTPER', 'Cost Per', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert User 1
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_USER1', 'User 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert User 2
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_USER2', 'User 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Project Codes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('GIFT_PROJECTCODES_PROJECT', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('GIFT_PROJECTCODES_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('GIFT_PROJECTCODES_DONORENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Email Report
CALL INSERTREPORTFIELD('GIFT_PROJECTCODES_STMTTOFILE', 'Email Report', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_PROJECTCODES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Projectcodeentity', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Pledges', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Pledge Code
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_PLDGCODE', 'Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Start Date
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_STARTDATE', 'Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert End Date
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_ENDDATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Total Amount Pledged
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_TOTAMTPLDG', 'Total Amount Pledged', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Amount Per Gift
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_AMTPERGIFT', 'Amount Per Gift', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Number of Gifts Pledged
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_NBRPLDG', 'Number of Gifts Pledged', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Frequency
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_FREQ', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Amount Given
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_AMTGIVEN', 'Amount Given', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Amount Remaining
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_AMTREMAIN', 'Amount Remaining', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Number of Gifts Given
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_NBRGIVEN', 'Number of Gifts Given', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Pledge Paid Through Date
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_PLDGPAIDTHRUDATE', 'Pledge Paid Through Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Relatedaccountentity', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Order Annual Summaries', 'Accounts and annual order summary information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_ORDERANNUAL', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order History Annual Summary', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ORDERANNUAL_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('ORDERANNUAL_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Year
CALL INSERTREPORTFIELD('ORDERANNUAL_CURRYEAR', 'Year', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Number
CALL INSERTREPORTFIELD('ORDERANNUAL_NBR', 'Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('ORDERANNUAL_AMT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Amount
CALL INSERTREPORTFIELD('ORDERANNUAL_CONVAMT', 'Converted Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Order Summaries', 'Accounts and overall order summary information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_ORDERSUMMARY', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order History Summary', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Order Summary ID
CALL INSERTREPORTFIELD('ORDERSUMMARY_ORDERSUMMARYID', 'Order Summary ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ORDERSUMMARY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('ORDERSUMMARY_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('ORDERSUMMARY_AMT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Amount
CALL INSERTREPORTFIELD('ORDERSUMMARY_CONVAMT', 'Converted Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Number
CALL INSERTREPORTFIELD('ORDERSUMMARY_NBR', 'Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert First Order Date
CALL INSERTREPORTFIELD('ORDERSUMMARY_FIRSTDATE', 'First Order Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert First Order Amount
CALL INSERTREPORTFIELD('ORDERSUMMARY_FIRSTAMT', 'First Order Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert First Order Converted Amount
CALL INSERTREPORTFIELD('ORDERSUMMARY_FIRSTCONVAMT', 'First Order Converted Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert First Order Number
CALL INSERTREPORTFIELD('ORDERSUMMARY_FIRSTORDNBR', 'First Order Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Large Order Date
CALL INSERTREPORTFIELD('ORDERSUMMARY_LARGEDATE', 'Large Order Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Large Order Amount
CALL INSERTREPORTFIELD('ORDERSUMMARY_LARGEAMT', 'Large Order Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Large Order Converted Amount
CALL INSERTREPORTFIELD('ORDERSUMMARY_LARGECONVAMT', 'Large Order Converted Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Large Order Number
CALL INSERTREPORTFIELD('ORDERSUMMARY_LARGEORDNBR', 'Large Order Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Last Order Date
CALL INSERTREPORTFIELD('ORDERSUMMARY_LASTDATE', 'Last Order Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Last Order Amount
CALL INSERTREPORTFIELD('ORDERSUMMARY_LASTAMT', 'Last Order Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Last Order Converted Amount
CALL INSERTREPORTFIELD('ORDERSUMMARY_LASTCONVAMT', 'Last Order Converted Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Last Order Number
CALL INSERTREPORTFIELD('ORDERSUMMARY_LASTORDNBR', 'Last Order Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('First Order - Order Headers', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Order Number
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_ORDERID', 'Order Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_BATCHID', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Order Date
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_ORDERDATE', 'Order Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Posted Date
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_BATCHPOSTEDDATE', 'Batch Posted Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_MOTIVATIONCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Received Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_RECEIVEDAMOUNT', 'Received Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Credit Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_CREDITAMOUNT', 'Credit Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Order Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_ORDERAMOUNT', 'Order Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Primary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_PRIMARYTAXAMOUNT', 'Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Shipping Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_SHIPPINGAMOUNT', 'Shipping Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Refund Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_REFUNDAMOUNT', 'Refund Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Amount Due
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_AMOUNTDUE', 'Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Associated Gift Reference Number
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_GIFTHEADERID', 'Associated Gift Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / ACH Type
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_PAYMENTTYPE', 'Credit Card / ACH Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Type
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_CHARGETYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Number
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_PAYMENTNUMBER', 'Credit Card Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Expiration Date
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_EXPIRATIONDATE', 'Credit Card Expiration Date', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_CURRENCYCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_CONVERSIONRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Letter Code
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_LETTERCODE', 'Letter Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 1
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_PARAGRAPHCODE1', 'Paragraph Code 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 2
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_PARAGRAPHCODE2', 'Paragraph Code 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Address Type
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_ADDRESSTYPE', 'Ship-To Address Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Should Compute Primary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_COMPUTEPRIMARYTAX', 'Should Compute Primary Tax Amount', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Shipping Code
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_SHIPPINGCODE', 'Shipping Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_SECONDARYTAXAMOUNT', 'Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_CHANGEUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Bank Routing Number
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_CHECKROUTINGNUMBER', 'Bank Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Media Program ID
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_MEDIAPROGRAMID', 'Media Program ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Episode ID
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_MEDIAEPISODEID', 'Media Episode ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_FAIRMARKETVALUE', 'Fair Market Value', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bank Name
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_BANK', 'Bank Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Reference Number
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_REFERENCENUMBER', 'Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Void Authorization Code
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_VOIDAUTHORIZATIONCODE', 'Void Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Placement ID
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_MEDIAPLACEMENTID', 'Media Placement ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Should Compute Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_COMPUTESECONDARYTAX', 'Should Compute Secondary Tax Amount', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Shipping Primary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_SHIPPINGPRIMARYTAXAMOUNT', 'Shipping Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Shipping Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_SHIPPINGSECONDARYTAXAMOUNT', 'Shipping Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Allow Partial Shipments
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_ALLOWPARTIALSHIPMENTS', 'Allow Partial Shipments', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Discount Percentage
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_DISCOUNTPERCENTAGE', 'Discount Percentage', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Transaction Source
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_TRANSACTIONSOURCE', 'Transaction Source', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Should Tax Shipping
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_TAXSHIPPING', 'Should Tax Shipping', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Backorder Item Count
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_BACKORDERITEMCOUNT', 'Backorder Item Count', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Add User
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_BATCHADDUSER', 'Batch Add User', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Control Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_BATCHCONTROLAMOUNT', 'Batch Control Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Batch Control Number
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_BATCHCONTROLNUMBER', 'Batch Control Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Currency Code
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_BATCHCURRENCY', 'Batch Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Date
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_BATCHDATE', 'Batch Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Default Motivation Code
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_BATCHDEFAULTMOTIVATIONCODE', 'Batch Default Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Default Payment Type
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_BATCHDEFAULTPAYMENTTYPE', 'Batch Default Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Default Pledge Code
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_BATCHDEFAULTPLEDGECODE', 'Batch Default Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Default Project Code
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_BATCHDEFAULTPROJECTCODE', 'Batch Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 1
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_BATCHTYPE1', 'Batch Type 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 2
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_BATCHTYPE2', 'Batch Type 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Primary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_BILLTOPRIMARYTAXAMOUNT', 'Bill-To Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_BILLTOSECONDARYTAXAMOUNT', 'Bill-To Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Amount Due
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_CONVERTEDAMOUNTDUE', 'Converted Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Amount Paid To Date
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_CONVERTEDAMOUNTPAIDTODATE', 'Converted Amount Paid To Date', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Current Amount Due
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_CURRENTAMOUNTDUE', 'Current Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Current Amount Paid To Date
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_CURRENTAMOUNTPAIDTODATE', 'Current Amount Paid To Date', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Discount Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_DISCOUNTAMOUNT', 'Discount Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Discount Total Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_DISCOUNTTOTALAMOUNT', 'Discount Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value Total
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_FAIRMARKETVALUETOTAL', 'Fair Market Value Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Total Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_CANCELLEDTOTALAMOUNT', 'Cancelled Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Order Detail Discount Amount Total
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_ITEMSDISCOUNTTOTALAMOUNT', 'Order Detail Discount Amount Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Quantity
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_QUANTITY', 'Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Primary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_SHIPTOPRIMARYTAXAMOUNT', 'Ship-To Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_SHIPTOSECONDARYTAXAMOUNT', 'Ship-To Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Order Total
CALL INSERTREPORTFIELD('ORDERHEADER_FIRSTORDER_ORDERTOTAL', 'Order Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Last Order - Order Headers', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Order Number
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_ORDERID', 'Order Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_BATCHID', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Order Date
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_ORDERDATE', 'Order Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Posted Date
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_BATCHPOSTEDDATE', 'Batch Posted Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_MOTIVATIONCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Received Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_RECEIVEDAMOUNT', 'Received Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Credit Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_CREDITAMOUNT', 'Credit Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Order Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_ORDERAMOUNT', 'Order Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Primary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_PRIMARYTAXAMOUNT', 'Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Shipping Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_SHIPPINGAMOUNT', 'Shipping Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Refund Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_REFUNDAMOUNT', 'Refund Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Amount Due
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_AMOUNTDUE', 'Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Associated Gift Reference Number
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_GIFTHEADERID', 'Associated Gift Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / ACH Type
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_PAYMENTTYPE', 'Credit Card / ACH Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Type
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_CHARGETYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Number
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_PAYMENTNUMBER', 'Credit Card Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Expiration Date
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_EXPIRATIONDATE', 'Credit Card Expiration Date', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_CURRENCYCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_CONVERSIONRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Letter Code
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_LETTERCODE', 'Letter Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 1
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_PARAGRAPHCODE1', 'Paragraph Code 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 2
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_PARAGRAPHCODE2', 'Paragraph Code 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Address Type
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_ADDRESSTYPE', 'Ship-To Address Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Should Compute Primary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_COMPUTEPRIMARYTAX', 'Should Compute Primary Tax Amount', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Shipping Code
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_SHIPPINGCODE', 'Shipping Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_SECONDARYTAXAMOUNT', 'Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_CHANGEUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Bank Routing Number
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_CHECKROUTINGNUMBER', 'Bank Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Media Program ID
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_MEDIAPROGRAMID', 'Media Program ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Episode ID
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_MEDIAEPISODEID', 'Media Episode ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_FAIRMARKETVALUE', 'Fair Market Value', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bank Name
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_BANK', 'Bank Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Reference Number
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_REFERENCENUMBER', 'Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Void Authorization Code
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_VOIDAUTHORIZATIONCODE', 'Void Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Placement ID
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_MEDIAPLACEMENTID', 'Media Placement ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Should Compute Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_COMPUTESECONDARYTAX', 'Should Compute Secondary Tax Amount', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Shipping Primary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_SHIPPINGPRIMARYTAXAMOUNT', 'Shipping Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Shipping Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_SHIPPINGSECONDARYTAXAMOUNT', 'Shipping Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Allow Partial Shipments
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_ALLOWPARTIALSHIPMENTS', 'Allow Partial Shipments', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Discount Percentage
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_DISCOUNTPERCENTAGE', 'Discount Percentage', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Transaction Source
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_TRANSACTIONSOURCE', 'Transaction Source', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Should Tax Shipping
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_TAXSHIPPING', 'Should Tax Shipping', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Backorder Item Count
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_BACKORDERITEMCOUNT', 'Backorder Item Count', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Add User
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_BATCHADDUSER', 'Batch Add User', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Control Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_BATCHCONTROLAMOUNT', 'Batch Control Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Batch Control Number
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_BATCHCONTROLNUMBER', 'Batch Control Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Currency Code
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_BATCHCURRENCY', 'Batch Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Date
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_BATCHDATE', 'Batch Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Default Motivation Code
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_BATCHDEFAULTMOTIVATIONCODE', 'Batch Default Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Default Payment Type
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_BATCHDEFAULTPAYMENTTYPE', 'Batch Default Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Default Pledge Code
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_BATCHDEFAULTPLEDGECODE', 'Batch Default Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Default Project Code
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_BATCHDEFAULTPROJECTCODE', 'Batch Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 1
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_BATCHTYPE1', 'Batch Type 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 2
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_BATCHTYPE2', 'Batch Type 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Primary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_BILLTOPRIMARYTAXAMOUNT', 'Bill-To Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_BILLTOSECONDARYTAXAMOUNT', 'Bill-To Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Amount Due
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_CONVERTEDAMOUNTDUE', 'Converted Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Amount Paid To Date
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_CONVERTEDAMOUNTPAIDTODATE', 'Converted Amount Paid To Date', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Current Amount Due
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_CURRENTAMOUNTDUE', 'Current Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Current Amount Paid To Date
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_CURRENTAMOUNTPAIDTODATE', 'Current Amount Paid To Date', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Discount Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_DISCOUNTAMOUNT', 'Discount Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Discount Total Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_DISCOUNTTOTALAMOUNT', 'Discount Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value Total
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_FAIRMARKETVALUETOTAL', 'Fair Market Value Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Total Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_CANCELLEDTOTALAMOUNT', 'Cancelled Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Order Detail Discount Amount Total
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_ITEMSDISCOUNTTOTALAMOUNT', 'Order Detail Discount Amount Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Quantity
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_QUANTITY', 'Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Primary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_SHIPTOPRIMARYTAXAMOUNT', 'Ship-To Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_SHIPTOSECONDARYTAXAMOUNT', 'Ship-To Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Order Total
CALL INSERTREPORTFIELD('ORDERHEADER_LASTORDER_ORDERTOTAL', 'Order Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Large Order - Order Headers', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Order Number
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_ORDERID', 'Order Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_BATCHID', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Order Date
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_ORDERDATE', 'Order Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Posted Date
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_BATCHPOSTEDDATE', 'Batch Posted Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_MOTIVATIONCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Received Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_RECEIVEDAMOUNT', 'Received Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Credit Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_CREDITAMOUNT', 'Credit Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Order Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_ORDERAMOUNT', 'Order Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Primary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_PRIMARYTAXAMOUNT', 'Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Shipping Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_SHIPPINGAMOUNT', 'Shipping Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Refund Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_REFUNDAMOUNT', 'Refund Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Amount Due
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_AMOUNTDUE', 'Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Associated Gift Reference Number
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_GIFTHEADERID', 'Associated Gift Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / ACH Type
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_PAYMENTTYPE', 'Credit Card / ACH Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Type
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_CHARGETYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Number
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_PAYMENTNUMBER', 'Credit Card Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Expiration Date
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_EXPIRATIONDATE', 'Credit Card Expiration Date', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_CURRENCYCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_CONVERSIONRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Letter Code
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_LETTERCODE', 'Letter Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 1
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_PARAGRAPHCODE1', 'Paragraph Code 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 2
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_PARAGRAPHCODE2', 'Paragraph Code 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Address Type
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_ADDRESSTYPE', 'Ship-To Address Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Should Compute Primary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_COMPUTEPRIMARYTAX', 'Should Compute Primary Tax Amount', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Shipping Code
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_SHIPPINGCODE', 'Shipping Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_SECONDARYTAXAMOUNT', 'Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_CHANGEUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Bank Routing Number
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_CHECKROUTINGNUMBER', 'Bank Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Media Program ID
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_MEDIAPROGRAMID', 'Media Program ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Episode ID
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_MEDIAEPISODEID', 'Media Episode ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_FAIRMARKETVALUE', 'Fair Market Value', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bank Name
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_BANK', 'Bank Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Reference Number
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_REFERENCENUMBER', 'Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Void Authorization Code
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_VOIDAUTHORIZATIONCODE', 'Void Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Placement ID
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_MEDIAPLACEMENTID', 'Media Placement ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Should Compute Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_COMPUTESECONDARYTAX', 'Should Compute Secondary Tax Amount', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Shipping Primary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_SHIPPINGPRIMARYTAXAMOUNT', 'Shipping Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Shipping Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_SHIPPINGSECONDARYTAXAMOUNT', 'Shipping Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Allow Partial Shipments
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_ALLOWPARTIALSHIPMENTS', 'Allow Partial Shipments', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Discount Percentage
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_DISCOUNTPERCENTAGE', 'Discount Percentage', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Transaction Source
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_TRANSACTIONSOURCE', 'Transaction Source', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Should Tax Shipping
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_TAXSHIPPING', 'Should Tax Shipping', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Backorder Item Count
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_BACKORDERITEMCOUNT', 'Backorder Item Count', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Add User
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_BATCHADDUSER', 'Batch Add User', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Control Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_BATCHCONTROLAMOUNT', 'Batch Control Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Batch Control Number
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_BATCHCONTROLNUMBER', 'Batch Control Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Currency Code
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_BATCHCURRENCY', 'Batch Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Date
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_BATCHDATE', 'Batch Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Default Motivation Code
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_BATCHDEFAULTMOTIVATIONCODE', 'Batch Default Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Default Payment Type
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_BATCHDEFAULTPAYMENTTYPE', 'Batch Default Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Default Pledge Code
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_BATCHDEFAULTPLEDGECODE', 'Batch Default Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Default Project Code
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_BATCHDEFAULTPROJECTCODE', 'Batch Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 1
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_BATCHTYPE1', 'Batch Type 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 2
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_BATCHTYPE2', 'Batch Type 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Primary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_BILLTOPRIMARYTAXAMOUNT', 'Bill-To Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_BILLTOSECONDARYTAXAMOUNT', 'Bill-To Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Amount Due
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_CONVERTEDAMOUNTDUE', 'Converted Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Amount Paid To Date
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_CONVERTEDAMOUNTPAIDTODATE', 'Converted Amount Paid To Date', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Current Amount Due
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_CURRENTAMOUNTDUE', 'Current Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Current Amount Paid To Date
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_CURRENTAMOUNTPAIDTODATE', 'Current Amount Paid To Date', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Discount Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_DISCOUNTAMOUNT', 'Discount Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Discount Total Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_DISCOUNTTOTALAMOUNT', 'Discount Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value Total
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_FAIRMARKETVALUETOTAL', 'Fair Market Value Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Total Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_CANCELLEDTOTALAMOUNT', 'Cancelled Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Order Detail Discount Amount Total
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_ITEMSDISCOUNTTOTALAMOUNT', 'Order Detail Discount Amount Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Quantity
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_QUANTITY', 'Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Primary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_SHIPTOPRIMARYTAXAMOUNT', 'Ship-To Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_SHIPTOSECONDARYTAXAMOUNT', 'Ship-To Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Order Total
CALL INSERTREPORTFIELD('ORDERHEADER_LARGEORDER_ORDERTOTAL', 'Order Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Orders', 'Accounts and orders including associated information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_ORDERS', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order Headers', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Order Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ORDERID', 'Order Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BATCHID', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Order Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ORDERDATE', 'Order Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Posted Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BATCHPOSTEDDATE', 'Batch Posted Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_MOTIVATIONCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Received Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_RECEIVEDAMOUNT', 'Received Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Credit Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CREDITAMOUNT', 'Credit Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Order Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ORDERAMOUNT', 'Order Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Primary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_PRIMARYTAXAMOUNT', 'Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Shipping Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPPINGAMOUNT', 'Shipping Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Refund Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_REFUNDAMOUNT', 'Refund Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Amount Due
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_AMOUNTDUE', 'Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Associated Gift Reference Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_GIFTHEADERID', 'Associated Gift Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / ACH Type
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_PAYMENTTYPE', 'Credit Card / ACH Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Type
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CHARGETYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_PAYMENTNUMBER', 'Credit Card Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Expiration Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_EXPIRATIONDATE', 'Credit Card Expiration Date', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CURRENCYCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CONVERSIONRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Letter Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_LETTERCODE', 'Letter Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 1
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_PARAGRAPHCODE1', 'Paragraph Code 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 2
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_PARAGRAPHCODE2', 'Paragraph Code 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Address Type
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ADDRESSTYPE', 'Ship-To Address Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Should Compute Primary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_COMPUTEPRIMARYTAX', 'Should Compute Primary Tax Amount', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Shipping Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPPINGCODE', 'Shipping Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SECONDARYTAXAMOUNT', 'Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CHANGEUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bank Routing Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CHECKROUTINGNUMBER', 'Bank Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Media Program ID
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_MEDIAPROGRAMID', 'Media Program ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Episode ID
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_MEDIAEPISODEID', 'Media Episode ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_FAIRMARKETVALUE', 'Fair Market Value', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bank Name
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BANK', 'Bank Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Reference Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_REFERENCENUMBER', 'Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Void Authorization Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_VOIDAUTHORIZATIONCODE', 'Void Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Placement ID
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_MEDIAPLACEMENTID', 'Media Placement ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Should Compute Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_COMPUTESECONDARYTAX', 'Should Compute Secondary Tax Amount', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Shipping Primary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPPINGPRIMARYTAXAMOUNT', 'Shipping Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Shipping Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPPINGSECONDARYTAXAMOUNT', 'Shipping Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Allow Partial Shipments
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ALLOWPARTIALSHIPMENTS', 'Allow Partial Shipments', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Discount Percentage
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_DISCOUNTPERCENTAGE', 'Discount Percentage', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Transaction Source
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_TRANSACTIONSOURCE', 'Transaction Source', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Should Tax Shipping
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_TAXSHIPPING', 'Should Tax Shipping', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Backorder Item Count
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BACKORDERITEMCOUNT', 'Backorder Item Count', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Primary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BILLTOPRIMARYTAXAMOUNT', 'Bill-To Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BILLTOSECONDARYTAXAMOUNT', 'Bill-To Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Amount Due
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CONVERTEDAMOUNTDUE', 'Converted Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Amount Paid To Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CONVERTEDAMOUNTPAIDTODATE', 'Converted Amount Paid To Date', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Current Amount Due
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CURRENTAMOUNTDUE', 'Current Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Current Amount Paid To Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CURRENTAMOUNTPAIDTODATE', 'Current Amount Paid To Date', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Discount Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_DISCOUNTAMOUNT', 'Discount Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Discount Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_DISCOUNTTOTALAMOUNT', 'Discount Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value Total
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_FAIRMARKETVALUETOTAL', 'Fair Market Value Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CANCELLEDTOTALAMOUNT', 'Cancelled Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Order Detail Discount Amount Total
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ITEMSDISCOUNTTOTALAMOUNT', 'Order Detail Discount Amount Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Quantity
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_QUANTITY', 'Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Primary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPTOPRIMARYTAXAMOUNT', 'Ship-To Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPTOSECONDARYTAXAMOUNT', 'Ship-To Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Order Total
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ORDERTOTAL', 'Order Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Batches', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('ORDER_BATCHES_BATCHNBR', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_BDATE', 'Batch Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert GL Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_GLDATE', 'GL Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Fund
CALL INSERTREPORTFIELD('ORDER_BATCHES_FUND', 'Fund', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert GL Account
CALL INSERTREPORTFIELD('ORDER_BATCHES_GLACCT', 'GL Account', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Cost Center
CALL INSERTREPORTFIELD('ORDER_BATCHES_CC', 'Cost Center', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_PROJCODE', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('ORDER_BATCHES_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('ORDER_BATCHES_CONVRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Control Amount
CALL INSERTREPORTFIELD('ORDER_BATCHES_CONTROLAMT', 'Control Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Actual Amount
CALL INSERTREPORTFIELD('ORDER_BATCHES_ACTUALAMT', 'Actual Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Default Motivation Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_DEFMOTVCODE', 'Default Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Project Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_DEFFUNDID', 'Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Pledge Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_DEFPLDGCODE', 'Default Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Payment Type
CALL INSERTREPORTFIELD('ORDER_BATCHES_DEFPAYCODE', 'Default Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ORDER_BATCHES_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ORDER_BATCHES_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Posted Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_APPLYDATE', 'Posted Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 1
CALL INSERTREPORTFIELD('ORDER_BATCHES_TYPE1', 'Batch Type 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 2
CALL INSERTREPORTFIELD('ORDER_BATCHES_TYPE2', 'Batch Type 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Actual Number
CALL INSERTREPORTFIELD('ORDER_BATCHES_ACTUALNBR', 'Actual Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Control Number
CALL INSERTREPORTFIELD('ORDER_BATCHES_CONTROLNBR', 'Control Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Status
CALL INSERTREPORTFIELD('ORDER_BATCHES_BATCHSTATUS', 'Batch Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ORDER_BATCHES_CHANGEUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ORDER_BATCHES_CHANGEUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Deposit Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_DEPOSITDATE', 'Deposit Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Owner ID
CALL INSERTREPORTFIELD('ORDER_BATCHES_OWNERID', 'Batch Owner ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Owner User Name
CALL INSERTREPORTFIELD('ORDER_BATCHES_BATCHOWNERNAME', 'Batch Owner User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Purchase Location
CALL INSERTREPORTFIELD('ORDER_BATCHES_LOCATION', 'Default Purchase Location', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Free Location
CALL INSERTREPORTFIELD('ORDER_BATCHES_FREELOCATION', 'Default Free Location', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Price Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_PRICECODE', 'Default Price Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Motivation Codes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Number Mailed
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_NBR', 'Number Mailed', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Date
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_MDATE', 'Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Cost
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_COST', 'Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Default Project Code
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_DEFPROJCODE', 'Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Campaign
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_CAMPAIGN', 'Campaign', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Kit
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_KIT', 'Kit', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Cost Per
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_COSTPER', 'Cost Per', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert User 1
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_USER1', 'User 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert User 2
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_USER2', 'User 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Outlets', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Code ID
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_MEDIACODE_ID', 'Media Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Frequency
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_FREQ', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Output Power
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_POWEROUT', 'Output Power', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_CITYOFLICENSE', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web Page Address
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_WEBSITE_URL', 'Web Page Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Address 1
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDRESS1', 'Address 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 2
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDRESS2', 'Address 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 3
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDRESS3', 'Address 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Zip Code
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ZIPCODE', 'Zip Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Email Address
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_EMAILADDRESS', 'Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Tag Line
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_TAGLINE', 'Tag Line', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Translator
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_TRANSLATOR', 'Translator', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Flagship ID
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_FLAGSHIPID', 'Flagship ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Commercial / Non-Commercial
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_COMMERCIAL', 'Commercial / Non-Commercial', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Target ROI
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_TARGETROI', 'Target ROI', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Coverage Area
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_COVERAGEAREA', 'Coverage Area', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Delivery Methods', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Delivery Method
CALL INSERTREPORTFIELD('ORDER_DELIVERYMETHODS_DELIVERY_METHOD', 'Delivery Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_DELIVERYMETHODS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Medium Types', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Medium Type
CALL INSERTREPORTFIELD('ORDER_MEDIUMTYPES_MEDIUM_TYPE', 'Medium Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIUMTYPES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Medium Coverage Type
CALL INSERTREPORTFIELD('ORDER_MEDIUMTYPES_COVERAGETYPE', 'Medium Coverage Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Medium Sub Types', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Medium Sub-Type
CALL INSERTREPORTFIELD('ORDER_MEDIUMSUBTYPES_MEDIUM_SUBTYPE', 'Medium Sub-Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIUMSUBTYPES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Outlet Formats', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Format Name
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETFORMATS_FORMAT_NAME', 'Media Format Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETFORMATS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Placements', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Lead In
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_LEADIN', 'Lead In', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Lead Out
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_LEADOUT', 'Lead Out', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Monday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_MONDAY', 'Monday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Tuesday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_TUESDAY', 'Tuesday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Wednesday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_WEDNESDAY', 'Wednesday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Thursday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_THURSDAY', 'Thursday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Friday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_FRIDAY', 'Friday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Saturday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_SATURDAY', 'Saturday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Sunday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_SUNDAY', 'Sunday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Air Time
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_LOCALTIMESLOT_BEGIN', 'Air Time', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code ID
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_MEDIAID', 'Media Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Begin Date
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_BEGINDATE', 'Begin Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert End Date
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_ENDDATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Media Agency ID
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_AGENCYID', 'Media Agency ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Contract Type
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_CONTRACT_TYPE', 'Contract Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Delivery Method ID
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_DELIVERYID', 'Delivery Method ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Is Default Placement
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_DEFAULTPLACEMENT', 'Is Default Placement', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Programs', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Program Name
CALL INSERTREPORTFIELD('ORDER_MEDIAPROGRAMS_NAME', 'Media Program Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('ORDER_MEDIAPROGRAMS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Length
CALL INSERTREPORTFIELD('ORDER_MEDIAPROGRAMS_LENGTH', 'Length', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Length Seconds / Minutes
CALL INSERTREPORTFIELD('ORDER_MEDIAPROGRAMS_MINSEC', 'Length Seconds / Minutes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIAPROGRAMS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Order Detail ID
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_ORDERDETAILID', 'Order Detail ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Price Code
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PRICECODE', 'Price Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Price
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PRICE', 'Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Product ID
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PRODUCTID', 'Product ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Reduct Inventory
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_REDUCEINVENTORY', 'Reduct Inventory', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value Amount Per Item
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_FAIRMARKETVALUE', 'Fair Market Value Amount Per Item', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Allocated Date
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_ALLOCATEDDATE', 'Allocated Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Backordered Date
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_BACKORDERDATE', 'Backordered Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Canceled Date
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELDATE', 'Canceled Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Return Date
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_RETURNDATE', 'Return Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Authorization Code
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_AUTHORIZATIONCODE', 'Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Packing Slip Print Status
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PACKINGSLIPSTATE', 'Packing Slip Print Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Print Group
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PRINTGROUP', 'Print Group', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Packing Slip Print Date
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PRINTDATE', 'Packing Slip Print Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Void Authorization Code
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_VOIDAUTHORIZATIONCODE', 'Void Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Quantity
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_QUANTITY', 'Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Transaction Type ID
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_TYPE', 'Transaction Type ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_STATUS', 'Status', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Product Location ID
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_LOCATION', 'Product Location ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Discount Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_DISCOUNTAMOUNT', 'Discount Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Primary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_SHIPTOPRIMARYTAX', 'Ship-To Primary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Secondary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_SHIPTOSECONDARYTAX', 'Ship-To Secondary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Address Primary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_BILLTOPRIMARYTAX', 'Bill-To Address Primary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Secondary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_BILLTOSECONDARYTAX', 'Bill-To Secondary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Is Cancelled
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_ISCANCELLED', 'Is Cancelled', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Shipping Package ID
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_SHIPPINGPACKAGEID', 'Shipping Package ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Discount Percentage
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_DISCOUNTPERCENTAGE', 'Discount Percentage', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Discount Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMDISCOUNTTOTALAMOUNT', 'Cancelled Line Item Discount Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Overall Discount Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMOVERALLDISCOUNTTOTALAMOUNT', 'Cancelled Line Item Overall Discount Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Primary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMPRIMARYTAX', 'Cancelled Line Item Primary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Product Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMPRODUCTAMOUNT', 'Cancelled Line Item Product Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Secondary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMSECONDARYTAX', 'Cancelled Line Item Secondary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Shipping Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMSHIPPINGAMOUNT', 'Cancelled Line Item Shipping Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMTOTALAMOUNT', 'Cancelled Line Item Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value Total
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_FAIRMARKETVALUETOTAL', 'Fair Market Value Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Order Detail Net Total
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_NETTOTAL', 'Order Detail Net Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Percentage Discount Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PERCENTAGEDISCOUNTAMOUNT', 'Percentage Discount Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Premium Quantity
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PREMIUMQUANTITY', 'Premium Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Discount Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_DISCOUNTTOTALAMOUNT', 'Discount Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_STATUSNAME', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Transaction Type
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_TYPENAME', 'Transaction Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Products', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Product ID
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_PRODUCTID', 'Product ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Product Code
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_PRODCODE', 'Product Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Type
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_TYPE', 'Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Designation
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_DESIGNATION', 'Designation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Weight
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_WEIGHT', 'Weight', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Class
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_CLASS', 'Class', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_PREFERREDVENDOR', 'Preferred Vendor', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor Account Number
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_PREFERREDVENDORID', 'Preferred Vendor Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Reorder Point
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_MINREORDERQTY', 'Reorder Point', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Lead Time
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_LEADTIME', 'Lead Time', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Projected Cost
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_PROJECTEDCOST', 'Projected Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Unit Cost
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_ACTUALCOST', 'Unit Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_FAIRMARKETVALUE', 'Fair Market Value', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Selling Price
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_DEFAULTPRICE', 'Selling Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Is Suspended
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_SUSPENDED', 'Is Suspended', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Product Locations', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Location Code
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_LOCCODE', 'Location Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Location Actual
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_LOCACTUAL', 'Location Actual', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Allocated
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_ALLOCATED', 'Allocated', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert On Hand
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_ONHAND', 'On Hand', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert On Order
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_ONORDER', 'On Order', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Estimated Delivery Date
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_ESTDELIVERYDATE', 'Estimated Delivery Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Backordered
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_BACKORDERED', 'Backordered', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_INACTIVE', 'Inactive', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Shipping Package Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Ship Date
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_SHIPDATE', 'Ship Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Tracking Number
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_TRACKINGNUMBER', 'Tracking Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Ship Weight
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_SHIPWEIGHT', 'Ship Weight', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Ship Amount
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_SHIPAMOUNT', 'Ship Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Package Date
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_PACKAGEDATE', 'Package Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Shipping Code
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_SHIPPINGCODE', 'Shipping Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Pledges', 'Accounts and pledge information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_PLEDGE', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Pledge', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Pledge ID
CALL INSERTREPORTFIELD('PLEDGE_PLEDGEID', 'Pledge ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Pledge Code
CALL INSERTREPORTFIELD('PLEDGE_PLDGCODE', 'Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('PLEDGE_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Start Date
CALL INSERTREPORTFIELD('PLEDGE_STARTDATE', 'Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert End Date
CALL INSERTREPORTFIELD('PLEDGE_ENDDATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Total Amount Pledged
CALL INSERTREPORTFIELD('PLEDGE_TOTAMTPLDG', 'Total Amount Pledged', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Amount Per Gift
CALL INSERTREPORTFIELD('PLEDGE_AMTPERGIFT', 'Amount Per Gift', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Number of Gifts Pledged
CALL INSERTREPORTFIELD('PLEDGE_NBRPLDG', 'Number of Gifts Pledged', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Frequency
CALL INSERTREPORTFIELD('PLEDGE_FREQ', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('PLEDGE_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Amount Given
CALL INSERTREPORTFIELD('PLEDGE_AMTGIVEN', 'Amount Given', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Pledges', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Amount Remaining
CALL INSERTREPORTFIELD('GIFTPLEDGE_AMTREMAIN', 'Amount Remaining', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Pledge', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Number of Gifts Given
CALL INSERTREPORTFIELD('PLEDGE_NBRGIVEN', 'Number of Gifts Given', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('PLEDGE_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('PLEDGE_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('PLEDGE_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('PLEDGE_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('PLEDGE_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('PLEDGE_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Pledge Paid Through Date
CALL INSERTREPORTFIELD('PLEDGE_PLDGPAIDTHRUDATE', 'Pledge Paid Through Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Subscriptions', 'Accounts and subscription information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_SUBSCRIPTIONS', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Subscriptions', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Product ID
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_PRODUCTID', 'Product ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Quantity
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_PURQTY', 'Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Remaining Quantity
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_REMAINQTY', 'Remaining Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Order Number
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_ORDNBR', 'Order Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Date Last Used
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_LASTDATE', 'Date Last Used', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Subscription Type
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_SUBTYPE', 'Subscription Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Type
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_ADDRTYPE', 'Address Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Order Detail ID
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_ORDERDETAILID', 'Order Detail ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Full Name
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_SNAME', 'Ship-To Full Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Address Lines
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_SADDRLINES', 'Ship-To Address Lines', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Ship-To City
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_SCITY', 'Ship-To City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Ship-To State
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_SSTATE', 'Ship-To State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Zip Code
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_SZIP', 'Ship-To Zip Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Country
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_SCOUNTRY', 'Ship-To Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last User ID
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_LASTUSER', 'Last User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Ordersubscription', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTION_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Subscriptions', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Title
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_STITLE', 'Ship-To Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Ship-To First Name
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_SFIRSTNAME', 'Ship-To First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Last Name
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_SLASTNAME', 'Ship-To Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Suffix
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_SSUFFIX', 'Ship-To Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Subscription ID
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_SUBSCRIPTIONID', 'Subscription ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Payment Type
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_PAYMENTTYPE', 'Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Type
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_CHARGETYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Expiration Date
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_EXPIRATIONDATE', 'Credit Card Expiration Date', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert ACH Routing Number
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_ACHROUTINGNUMBER', 'ACH Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert ACH Account Number
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_ACHACCOUNTNUMBER', 'ACH Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert ACH Type
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_ACHTYPE', 'ACH Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Number
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_PAYMENTNUMBER', 'Credit Card Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Auto Renew
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_AUTORENEW', 'Auto Renew', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Auto Renew Quantity
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_AUTORENEWQUANTITY', 'Auto Renew Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Auto Renew Amount
CALL INSERTREPORTFIELD('ORDERSUBSCRIPTIONS_AUTORENEWAMOUNT', 'Auto Renew Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Products', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Product ID
CALL INSERTREPORTFIELD('PRODUCTS_PRODUCTID', 'Product ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Product Code
CALL INSERTREPORTFIELD('PRODUCTS_PRODCODE', 'Product Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('PRODUCTS_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Type
CALL INSERTREPORTFIELD('PRODUCTS_TYPE', 'Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Designation
CALL INSERTREPORTFIELD('PRODUCTS_DESIGNATION', 'Designation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('PRODUCTS_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Weight
CALL INSERTREPORTFIELD('PRODUCTS_WEIGHT', 'Weight', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('PRODUCTS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Class
CALL INSERTREPORTFIELD('PRODUCTS_CLASS', 'Class', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor
CALL INSERTREPORTFIELD('PRODUCTS_PREFERREDVENDOR', 'Preferred Vendor', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor Account Number
CALL INSERTREPORTFIELD('PRODUCTS_PREFERREDVENDORID', 'Preferred Vendor Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Reorder Point
CALL INSERTREPORTFIELD('PRODUCTS_MINREORDERQTY', 'Reorder Point', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Lead Time
CALL INSERTREPORTFIELD('PRODUCTS_LEADTIME', 'Lead Time', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Projected Cost
CALL INSERTREPORTFIELD('PRODUCTS_PROJECTEDCOST', 'Projected Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Unit Cost
CALL INSERTREPORTFIELD('PRODUCTS_ACTUALCOST', 'Unit Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value
CALL INSERTREPORTFIELD('PRODUCTS_FAIRMARKETVALUE', 'Fair Market Value', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('PRODUCTS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('PRODUCTS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('PRODUCTS_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Selling Price
CALL INSERTREPORTFIELD('PRODUCTS_DEFAULTPRICE', 'Selling Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Is Suspended
CALL INSERTREPORTFIELD('PRODUCTS_SUSPENDED', 'Is Suspended', b'0', 6, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Accounts & Transactions', 'Accounts and transactions (orders, hard & soft gifts) including associated information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PEOPLE_TRANSACTIONS', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift - Gift Headers', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Gift Reference Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_GIFTREF', 'Gift Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Gift Date
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_GDATE', 'Gift Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Apply Date
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_APPLYDATE', 'Apply Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_BATCHNBR', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_AMT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Payment Type
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PAYCODE', 'Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / ACH Type
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PAYTYPE', 'Credit Card / ACH Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / Bank Account Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PAYNBR', 'Credit Card / Bank Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Expiration Date
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_EXPIRE', 'Credit Card Expiration Date', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Authorization Code
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CHARGEAUTH', 'Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Receipt Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_RCPTNBR', 'Receipt Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Receipt Print Status
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_RCPTPRINT', 'Receipt Print Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Print Group
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PRTGRP', 'Print Group', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Letter Code
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_LTRCODE', 'Letter Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Letter Print Status
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_LTRPRINT', 'Letter Print Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CONVRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Order Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ORDNBR', 'Order Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 1
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PARACODE1', 'Paragraph Code 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 2
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PARACODE2', 'Paragraph Code 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bank Routing Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ROUTENBR', 'Bank Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Media Program ID
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PROGRAMID', 'Media Program ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Episode ID
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_EPISODEID', 'Media Episode ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Bank Name
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_BANK', 'Bank Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Placement ID
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_MEDIAPLACEMENTID', 'Media Placement ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Transaction Source
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_TRANSACTIONSOURCE', 'Transaction Source', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Soft Gift
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_SOFTGIFT', 'Soft Gift', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift - Batches', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('GIFT_BATCHES_BATCHNBR', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_BDATE', 'Batch Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert GL Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_GLDATE', 'GL Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Fund
CALL INSERTREPORTFIELD('GIFT_BATCHES_FUND', 'Fund', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert GL Account
CALL INSERTREPORTFIELD('GIFT_BATCHES_GLACCT', 'GL Account', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Cost Center
CALL INSERTREPORTFIELD('GIFT_BATCHES_CC', 'Cost Center', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_PROJCODE', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('GIFT_BATCHES_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('GIFT_BATCHES_CONVRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Control Amount
CALL INSERTREPORTFIELD('GIFT_BATCHES_CONTROLAMT', 'Control Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Actual Amount
CALL INSERTREPORTFIELD('GIFT_BATCHES_ACTUALAMT', 'Actual Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Default Motivation Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_DEFMOTVCODE', 'Default Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Project Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_DEFFUNDID', 'Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Pledge Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_DEFPLDGCODE', 'Default Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Payment Type
CALL INSERTREPORTFIELD('GIFT_BATCHES_DEFPAYCODE', 'Default Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('GIFT_BATCHES_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('GIFT_BATCHES_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Posted Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_APPLYDATE', 'Posted Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 1
CALL INSERTREPORTFIELD('GIFT_BATCHES_TYPE1', 'Batch Type 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 2
CALL INSERTREPORTFIELD('GIFT_BATCHES_TYPE2', 'Batch Type 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Actual Number
CALL INSERTREPORTFIELD('GIFT_BATCHES_ACTUALNBR', 'Actual Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Control Number
CALL INSERTREPORTFIELD('GIFT_BATCHES_CONTROLNBR', 'Control Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Status
CALL INSERTREPORTFIELD('GIFT_BATCHES_BATCHSTATUS', 'Batch Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('GIFT_BATCHES_CHANGEUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('GIFT_BATCHES_CHANGEUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Deposit Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_DEPOSITDATE', 'Deposit Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Owner ID
CALL INSERTREPORTFIELD('GIFT_BATCHES_OWNERID', 'Batch Owner ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Owner User Name
CALL INSERTREPORTFIELD('GIFT_BATCHES_BATCHOWNERNAME', 'Batch Owner User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Purchase Location
CALL INSERTREPORTFIELD('GIFT_BATCHES_LOCATION', 'Default Purchase Location', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Free Location
CALL INSERTREPORTFIELD('GIFT_BATCHES_FREELOCATION', 'Default Free Location', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Price Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_PRICECODE', 'Default Price Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift - Media Outlets', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Code ID
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_MEDIACODE_ID', 'Media Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Frequency
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_FREQ', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Output Power
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_POWEROUT', 'Output Power', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_CITYOFLICENSE', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web Page Address
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_WEBSITE_URL', 'Web Page Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Address 1
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDRESS1', 'Address 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 2
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDRESS2', 'Address 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 3
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDRESS3', 'Address 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Zip Code
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ZIPCODE', 'Zip Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Email Address
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_EMAILADDRESS', 'Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Tag Line
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_TAGLINE', 'Tag Line', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Translator
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_TRANSLATOR', 'Translator', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Flagship ID
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_FLAGSHIPID', 'Flagship ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Commercial / Non-Commercial
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_COMMERCIAL', 'Commercial / Non-Commercial', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Target ROI
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_TARGETROI', 'Target ROI', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Coverage Area
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_COVERAGEAREA', 'Coverage Area', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift - Media Delivery Methods', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Delivery Method
CALL INSERTREPORTFIELD('GIFT_DELIVERYMETHODS_DELIVERY_METHOD', 'Delivery Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_DELIVERYMETHODS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift - Medium Types', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Medium Type
CALL INSERTREPORTFIELD('GIFT_MEDIUMTYPES_MEDIUM_TYPE', 'Medium Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIUMTYPES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Medium Coverage Type
CALL INSERTREPORTFIELD('GIFT_MEDIUMTYPES_COVERAGETYPE', 'Medium Coverage Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift - Medium Sub Types', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Medium Sub-Type
CALL INSERTREPORTFIELD('GIFT_MEDIUMSUBTYPES_MEDIUM_SUBTYPE', 'Medium Sub-Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIUMSUBTYPES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift - Media Outlet Formats', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Format Name
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETFORMATS_FORMAT_NAME', 'Media Format Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETFORMATS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift - Media Placements', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Lead In
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_LEADIN', 'Lead In', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Lead Out
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_LEADOUT', 'Lead Out', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Monday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_MONDAY', 'Monday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Tuesday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_TUESDAY', 'Tuesday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Wednesday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_WEDNESDAY', 'Wednesday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Thursday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_THURSDAY', 'Thursday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Friday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_FRIDAY', 'Friday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Saturday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_SATURDAY', 'Saturday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Sunday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_SUNDAY', 'Sunday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Air Time
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_LOCALTIMESLOT_BEGIN', 'Air Time', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code ID
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_MEDIAID', 'Media Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Begin Date
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_BEGINDATE', 'Begin Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert End Date
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_ENDDATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Media Agency ID
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_AGENCYID', 'Media Agency ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Contract Type
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_CONTRACT_TYPE', 'Contract Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Delivery Method ID
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_DELIVERYID', 'Delivery Method ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Is Default Placement
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_DEFAULTPLACEMENT', 'Is Default Placement', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift - Media Programs', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Program Name
CALL INSERTREPORTFIELD('GIFT_MEDIAPROGRAMS_NAME', 'Media Program Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('GIFT_MEDIAPROGRAMS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Length
CALL INSERTREPORTFIELD('GIFT_MEDIAPROGRAMS_LENGTH', 'Length', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Length Seconds / Minutes
CALL INSERTREPORTFIELD('GIFT_MEDIAPROGRAMS_MINSEC', 'Length Seconds / Minutes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIAPROGRAMS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift - Gift Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Gift Detail ID
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_GIFTDETAILID', 'Gift Detail ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_AMT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_PROJCODE', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Deductible
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_DEDUCT', 'Deductible', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Anonymous
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_ANNON', 'Anonymous', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Related Account Number
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_SACCTNBR', 'Related Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_GIFTDETAILNOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift - Motivation Codes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Number Mailed
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_NBR', 'Number Mailed', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Date
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_MDATE', 'Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Cost
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_COST', 'Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Default Project Code
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_DEFPROJCODE', 'Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Campaign
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_CAMPAIGN', 'Campaign', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Kit
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_KIT', 'Kit', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Cost Per
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_COSTPER', 'Cost Per', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert User 1
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_USER1', 'User 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert User 2
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_USER2', 'User 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift - Project Codes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('GIFT_PROJECTCODES_PROJECT', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('GIFT_PROJECTCODES_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('GIFT_PROJECTCODES_DONORENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Email Report
CALL INSERTREPORTFIELD('GIFT_PROJECTCODES_STMTTOFILE', 'Email Report', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_PROJECTCODES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift - Gift - Projectcodeentity', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift - Pledges', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Pledge Code
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_PLDGCODE', 'Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Start Date
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_STARTDATE', 'Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert End Date
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_ENDDATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Total Amount Pledged
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_TOTAMTPLDG', 'Total Amount Pledged', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Amount Per Gift
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_AMTPERGIFT', 'Amount Per Gift', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Number of Gifts Pledged
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_NBRPLDG', 'Number of Gifts Pledged', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Frequency
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_FREQ', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Amount Given
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_AMTGIVEN', 'Amount Given', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Amount Remaining
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_AMTREMAIN', 'Amount Remaining', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Number of Gifts Given
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_NBRGIVEN', 'Number of Gifts Given', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Pledge Paid Through Date
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_PLDGPAIDTHRUDATE', 'Pledge Paid Through Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift - Gift - Relatedaccountentity', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order - Order Headers', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Order Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ORDERID', 'Order Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BATCHID', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Order Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ORDERDATE', 'Order Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Posted Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BATCHPOSTEDDATE', 'Batch Posted Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_MOTIVATIONCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Received Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_RECEIVEDAMOUNT', 'Received Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Credit Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CREDITAMOUNT', 'Credit Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Order Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ORDERAMOUNT', 'Order Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Primary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_PRIMARYTAXAMOUNT', 'Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Shipping Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPPINGAMOUNT', 'Shipping Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Refund Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_REFUNDAMOUNT', 'Refund Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Amount Due
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_AMOUNTDUE', 'Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Associated Gift Reference Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_GIFTHEADERID', 'Associated Gift Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / ACH Type
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_PAYMENTTYPE', 'Credit Card / ACH Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Type
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CHARGETYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_PAYMENTNUMBER', 'Credit Card Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Expiration Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_EXPIRATIONDATE', 'Credit Card Expiration Date', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CURRENCYCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CONVERSIONRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Letter Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_LETTERCODE', 'Letter Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 1
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_PARAGRAPHCODE1', 'Paragraph Code 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 2
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_PARAGRAPHCODE2', 'Paragraph Code 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Address Type
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ADDRESSTYPE', 'Ship-To Address Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Should Compute Primary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_COMPUTEPRIMARYTAX', 'Should Compute Primary Tax Amount', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Shipping Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPPINGCODE', 'Shipping Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SECONDARYTAXAMOUNT', 'Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CHANGEUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bank Routing Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CHECKROUTINGNUMBER', 'Bank Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Media Program ID
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_MEDIAPROGRAMID', 'Media Program ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Episode ID
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_MEDIAEPISODEID', 'Media Episode ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_FAIRMARKETVALUE', 'Fair Market Value', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bank Name
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BANK', 'Bank Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Reference Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_REFERENCENUMBER', 'Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Void Authorization Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_VOIDAUTHORIZATIONCODE', 'Void Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Placement ID
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_MEDIAPLACEMENTID', 'Media Placement ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Should Compute Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_COMPUTESECONDARYTAX', 'Should Compute Secondary Tax Amount', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Shipping Primary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPPINGPRIMARYTAXAMOUNT', 'Shipping Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Shipping Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPPINGSECONDARYTAXAMOUNT', 'Shipping Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Allow Partial Shipments
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ALLOWPARTIALSHIPMENTS', 'Allow Partial Shipments', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Discount Percentage
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_DISCOUNTPERCENTAGE', 'Discount Percentage', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Transaction Source
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_TRANSACTIONSOURCE', 'Transaction Source', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Should Tax Shipping
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_TAXSHIPPING', 'Should Tax Shipping', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Backorder Item Count
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BACKORDERITEMCOUNT', 'Backorder Item Count', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Primary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BILLTOPRIMARYTAXAMOUNT', 'Bill-To Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BILLTOSECONDARYTAXAMOUNT', 'Bill-To Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Amount Due
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CONVERTEDAMOUNTDUE', 'Converted Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Amount Paid To Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CONVERTEDAMOUNTPAIDTODATE', 'Converted Amount Paid To Date', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Current Amount Due
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CURRENTAMOUNTDUE', 'Current Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Current Amount Paid To Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CURRENTAMOUNTPAIDTODATE', 'Current Amount Paid To Date', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Discount Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_DISCOUNTAMOUNT', 'Discount Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Discount Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_DISCOUNTTOTALAMOUNT', 'Discount Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value Total
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_FAIRMARKETVALUETOTAL', 'Fair Market Value Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CANCELLEDTOTALAMOUNT', 'Cancelled Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Order Detail Discount Amount Total
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ITEMSDISCOUNTTOTALAMOUNT', 'Order Detail Discount Amount Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Quantity
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_QUANTITY', 'Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Primary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPTOPRIMARYTAXAMOUNT', 'Ship-To Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPTOSECONDARYTAXAMOUNT', 'Ship-To Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Order Total
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ORDERTOTAL', 'Order Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order - Batches', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('ORDER_BATCHES_BATCHNBR', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_BDATE', 'Batch Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert GL Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_GLDATE', 'GL Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Fund
CALL INSERTREPORTFIELD('ORDER_BATCHES_FUND', 'Fund', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert GL Account
CALL INSERTREPORTFIELD('ORDER_BATCHES_GLACCT', 'GL Account', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Cost Center
CALL INSERTREPORTFIELD('ORDER_BATCHES_CC', 'Cost Center', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_PROJCODE', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('ORDER_BATCHES_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('ORDER_BATCHES_CONVRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Control Amount
CALL INSERTREPORTFIELD('ORDER_BATCHES_CONTROLAMT', 'Control Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Actual Amount
CALL INSERTREPORTFIELD('ORDER_BATCHES_ACTUALAMT', 'Actual Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Default Motivation Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_DEFMOTVCODE', 'Default Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Project Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_DEFFUNDID', 'Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Pledge Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_DEFPLDGCODE', 'Default Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Payment Type
CALL INSERTREPORTFIELD('ORDER_BATCHES_DEFPAYCODE', 'Default Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ORDER_BATCHES_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ORDER_BATCHES_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Posted Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_APPLYDATE', 'Posted Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 1
CALL INSERTREPORTFIELD('ORDER_BATCHES_TYPE1', 'Batch Type 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 2
CALL INSERTREPORTFIELD('ORDER_BATCHES_TYPE2', 'Batch Type 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Actual Number
CALL INSERTREPORTFIELD('ORDER_BATCHES_ACTUALNBR', 'Actual Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Control Number
CALL INSERTREPORTFIELD('ORDER_BATCHES_CONTROLNBR', 'Control Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Status
CALL INSERTREPORTFIELD('ORDER_BATCHES_BATCHSTATUS', 'Batch Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ORDER_BATCHES_CHANGEUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ORDER_BATCHES_CHANGEUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Deposit Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_DEPOSITDATE', 'Deposit Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Owner ID
CALL INSERTREPORTFIELD('ORDER_BATCHES_OWNERID', 'Batch Owner ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Owner User Name
CALL INSERTREPORTFIELD('ORDER_BATCHES_BATCHOWNERNAME', 'Batch Owner User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Purchase Location
CALL INSERTREPORTFIELD('ORDER_BATCHES_LOCATION', 'Default Purchase Location', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Free Location
CALL INSERTREPORTFIELD('ORDER_BATCHES_FREELOCATION', 'Default Free Location', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Price Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_PRICECODE', 'Default Price Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order - Motivation Codes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Number Mailed
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_NBR', 'Number Mailed', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Date
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_MDATE', 'Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Cost
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_COST', 'Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Default Project Code
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_DEFPROJCODE', 'Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Campaign
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_CAMPAIGN', 'Campaign', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Kit
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_KIT', 'Kit', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Cost Per
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_COSTPER', 'Cost Per', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert User 1
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_USER1', 'User 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert User 2
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_USER2', 'User 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order - Media Outlets', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Code ID
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_MEDIACODE_ID', 'Media Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Frequency
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_FREQ', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Output Power
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_POWEROUT', 'Output Power', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_CITYOFLICENSE', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web Page Address
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_WEBSITE_URL', 'Web Page Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Address 1
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDRESS1', 'Address 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 2
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDRESS2', 'Address 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 3
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDRESS3', 'Address 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Zip Code
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ZIPCODE', 'Zip Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Email Address
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_EMAILADDRESS', 'Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Tag Line
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_TAGLINE', 'Tag Line', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Translator
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_TRANSLATOR', 'Translator', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Flagship ID
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_FLAGSHIPID', 'Flagship ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Commercial / Non-Commercial
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_COMMERCIAL', 'Commercial / Non-Commercial', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Target ROI
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_TARGETROI', 'Target ROI', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Coverage Area
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_COVERAGEAREA', 'Coverage Area', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order - Media Delivery Methods', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Delivery Method
CALL INSERTREPORTFIELD('ORDER_DELIVERYMETHODS_DELIVERY_METHOD', 'Delivery Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_DELIVERYMETHODS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order - Medium Types', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Medium Type
CALL INSERTREPORTFIELD('ORDER_MEDIUMTYPES_MEDIUM_TYPE', 'Medium Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIUMTYPES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Medium Coverage Type
CALL INSERTREPORTFIELD('ORDER_MEDIUMTYPES_COVERAGETYPE', 'Medium Coverage Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order - Medium Sub Types', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Medium Sub-Type
CALL INSERTREPORTFIELD('ORDER_MEDIUMSUBTYPES_MEDIUM_SUBTYPE', 'Medium Sub-Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIUMSUBTYPES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order - Media Outlet Formats', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Format Name
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETFORMATS_FORMAT_NAME', 'Media Format Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETFORMATS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order - Media Placements', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Lead In
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_LEADIN', 'Lead In', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Lead Out
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_LEADOUT', 'Lead Out', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Monday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_MONDAY', 'Monday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Tuesday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_TUESDAY', 'Tuesday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Wednesday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_WEDNESDAY', 'Wednesday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Thursday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_THURSDAY', 'Thursday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Friday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_FRIDAY', 'Friday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Saturday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_SATURDAY', 'Saturday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Sunday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_SUNDAY', 'Sunday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Air Time
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_LOCALTIMESLOT_BEGIN', 'Air Time', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code ID
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_MEDIAID', 'Media Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Begin Date
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_BEGINDATE', 'Begin Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert End Date
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_ENDDATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Media Agency ID
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_AGENCYID', 'Media Agency ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Contract Type
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_CONTRACT_TYPE', 'Contract Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Delivery Method ID
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_DELIVERYID', 'Delivery Method ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Is Default Placement
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_DEFAULTPLACEMENT', 'Is Default Placement', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order - Media Programs', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Program Name
CALL INSERTREPORTFIELD('ORDER_MEDIAPROGRAMS_NAME', 'Media Program Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('ORDER_MEDIAPROGRAMS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Length
CALL INSERTREPORTFIELD('ORDER_MEDIAPROGRAMS_LENGTH', 'Length', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Length Seconds / Minutes
CALL INSERTREPORTFIELD('ORDER_MEDIAPROGRAMS_MINSEC', 'Length Seconds / Minutes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIAPROGRAMS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order - Order Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Order Detail ID
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_ORDERDETAILID', 'Order Detail ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Price Code
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PRICECODE', 'Price Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Price
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PRICE', 'Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Product ID
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PRODUCTID', 'Product ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Reduct Inventory
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_REDUCEINVENTORY', 'Reduct Inventory', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value Amount Per Item
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_FAIRMARKETVALUE', 'Fair Market Value Amount Per Item', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Allocated Date
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_ALLOCATEDDATE', 'Allocated Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Backordered Date
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_BACKORDERDATE', 'Backordered Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Canceled Date
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELDATE', 'Canceled Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Return Date
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_RETURNDATE', 'Return Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Authorization Code
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_AUTHORIZATIONCODE', 'Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Packing Slip Print Status
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PACKINGSLIPSTATE', 'Packing Slip Print Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Print Group
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PRINTGROUP', 'Print Group', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Packing Slip Print Date
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PRINTDATE', 'Packing Slip Print Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Void Authorization Code
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_VOIDAUTHORIZATIONCODE', 'Void Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Quantity
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_QUANTITY', 'Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Transaction Type ID
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_TYPE', 'Transaction Type ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_STATUS', 'Status', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Product Location ID
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_LOCATION', 'Product Location ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Discount Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_DISCOUNTAMOUNT', 'Discount Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Primary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_SHIPTOPRIMARYTAX', 'Ship-To Primary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Secondary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_SHIPTOSECONDARYTAX', 'Ship-To Secondary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Address Primary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_BILLTOPRIMARYTAX', 'Bill-To Address Primary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Secondary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_BILLTOSECONDARYTAX', 'Bill-To Secondary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Is Cancelled
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_ISCANCELLED', 'Is Cancelled', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Shipping Package ID
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_SHIPPINGPACKAGEID', 'Shipping Package ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Discount Percentage
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_DISCOUNTPERCENTAGE', 'Discount Percentage', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Discount Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMDISCOUNTTOTALAMOUNT', 'Cancelled Line Item Discount Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Overall Discount Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMOVERALLDISCOUNTTOTALAMOUNT', 'Cancelled Line Item Overall Discount Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Primary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMPRIMARYTAX', 'Cancelled Line Item Primary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Product Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMPRODUCTAMOUNT', 'Cancelled Line Item Product Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Secondary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMSECONDARYTAX', 'Cancelled Line Item Secondary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Shipping Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMSHIPPINGAMOUNT', 'Cancelled Line Item Shipping Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMTOTALAMOUNT', 'Cancelled Line Item Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value Total
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_FAIRMARKETVALUETOTAL', 'Fair Market Value Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Order Detail Net Total
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_NETTOTAL', 'Order Detail Net Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Percentage Discount Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PERCENTAGEDISCOUNTAMOUNT', 'Percentage Discount Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Premium Quantity
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PREMIUMQUANTITY', 'Premium Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Discount Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_DISCOUNTTOTALAMOUNT', 'Discount Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_STATUSNAME', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Transaction Type
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_TYPENAME', 'Transaction Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order - Products', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Product ID
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_PRODUCTID', 'Product ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Product Code
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_PRODCODE', 'Product Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Type
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_TYPE', 'Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Designation
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_DESIGNATION', 'Designation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Weight
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_WEIGHT', 'Weight', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Class
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_CLASS', 'Class', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_PREFERREDVENDOR', 'Preferred Vendor', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor Account Number
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_PREFERREDVENDORID', 'Preferred Vendor Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Reorder Point
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_MINREORDERQTY', 'Reorder Point', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Lead Time
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_LEADTIME', 'Lead Time', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Projected Cost
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_PROJECTEDCOST', 'Projected Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Unit Cost
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_ACTUALCOST', 'Unit Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_FAIRMARKETVALUE', 'Fair Market Value', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Selling Price
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_DEFAULTPRICE', 'Selling Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Is Suspended
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_SUSPENDED', 'Is Suspended', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order - Product Locations', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Location Code
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_LOCCODE', 'Location Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Location Actual
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_LOCACTUAL', 'Location Actual', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Allocated
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_ALLOCATED', 'Allocated', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert On Hand
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_ONHAND', 'On Hand', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert On Order
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_ONORDER', 'On Order', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Estimated Delivery Date
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_ESTDELIVERYDATE', 'Estimated Delivery Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Backordered
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_BACKORDERED', 'Backordered', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_INACTIVE', 'Inactive', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order - Shipping Package Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Ship Date
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_SHIPDATE', 'Ship Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Tracking Number
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_TRACKINGNUMBER', 'Tracking Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Ship Weight
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_SHIPWEIGHT', 'Ship Weight', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Ship Amount
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_SHIPAMOUNT', 'Ship Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Package Date
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_PACKAGEDATE', 'Package Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Shipping Code
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_SHIPPINGCODE', 'Shipping Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Recurring Batches', 'Recurring batches and associated information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_RECURRINGBATCHES', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Recurring Batches', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Recurring Batch ID
CALL INSERTREPORTFIELD('BATCHESRECUR_BATCHRECURID', 'Recurring Batch ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Recurring Batch Type
CALL INSERTREPORTFIELD('BATCHESRECUR_TYPE', 'Recurring Batch Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Date Used
CALL INSERTREPORTFIELD('BATCHESRECUR_DATEUSED', 'Last Date Used', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('BATCHESRECUR_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Account Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITY_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('ENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('ENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('ENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('ENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('ENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Spouse Name
CALL INSERTREPORTFIELD('ENTITY_SPOUSE', 'Spouse Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ENTITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ENTITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ENTITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ENTITY_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ENTITY_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ENTITY_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('ENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('ENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('ENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('ENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('ENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('ENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('ENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('ENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('ENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Salutation
CALL INSERTREPORTFIELD('ENTITY_DEFAULTSALUTATION', 'Default Salutation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Marital Status
CALL INSERTREPORTFIELD('ENTITY_MARITALSTATUS', 'Marital Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert AR Balance
CALL INSERTREPORTFIELD('ENTITY_ACCTBAL', 'AR Balance', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Job Title
CALL INSERTREPORTFIELD('ENTITY_JOBTITLE', 'Job Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web
CALL INSERTREPORTFIELD('ENTITY_WEB', 'Web', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift Picture', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Gift Picture ID
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_ENTITYGIFTPICID', 'Gift Picture ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_AMT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_PROJCODE', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Pledge Code
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_PLDGCODE', 'Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Deductible
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_DEDUCT', 'Deductible', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Anonymous
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_ANNON', 'Anonymous', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Related Account Number
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_SACCTNBR', 'Related Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Program ID
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_PROGRAMID', 'Media Program ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Type
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_PAYTYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Number
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_PAYNBR', 'Credit Card Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Type
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_CARDTYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Expiration Date
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_CARDEXPIRE', 'Credit Card Expiration Date', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bank Routing Number
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_ROUTINGNBR', 'Bank Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bank Account Number
CALL INSERTREPORTFIELD('ENTITYGIFTPIC_BANKNBR', 'Bank Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Pledges', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Pledge ID
CALL INSERTREPORTFIELD('GIFTPLEDGE_PLEDGEID', 'Pledge ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('GIFTPLEDGE_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Pledge Code
CALL INSERTREPORTFIELD('GIFTPLEDGE_PLDGCODE', 'Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFTPLEDGE_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Start Date
CALL INSERTREPORTFIELD('GIFTPLEDGE_STARTDATE', 'Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert End Date
CALL INSERTREPORTFIELD('GIFTPLEDGE_ENDDATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Total Amount Pledged
CALL INSERTREPORTFIELD('GIFTPLEDGE_TOTAMTPLDG', 'Total Amount Pledged', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Amount Per Gift
CALL INSERTREPORTFIELD('GIFTPLEDGE_AMTPERGIFT', 'Amount Per Gift', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Number of Gifts Pledged
CALL INSERTREPORTFIELD('GIFTPLEDGE_NBRPLDG', 'Number of Gifts Pledged', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Frequency
CALL INSERTREPORTFIELD('GIFTPLEDGE_FREQ', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('GIFTPLEDGE_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Amount Given
CALL INSERTREPORTFIELD('GIFTPLEDGE_AMTGIVEN', 'Amount Given', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Amount Remaining
CALL INSERTREPORTFIELD('GIFTPLEDGE_AMTREMAIN', 'Amount Remaining', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Number of Gifts Given
CALL INSERTREPORTFIELD('GIFTPLEDGE_NBRGIVEN', 'Number of Gifts Given', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFTPLEDGE_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('GIFTPLEDGE_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFTPLEDGE_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Pledge Paid Through Date
CALL INSERTREPORTFIELD('GIFTPLEDGE_PLDGPAIDTHRUDATE', 'Pledge Paid Through Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
INSERT INTO REPORTDATASUBSOURCEGROUP
	(DESCRIPTION, DISPLAY_NAME, reportDataSource_REPORTSOURCE_ID)
VALUES
	('Administrative', 'Administrative', @REPORTDATASOURCE_ID);
 
SET @REPORTDATASUBSOURCEGROUP_ID = LAST_INSERT_ID();
 
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Motivation Codes', 'Motivation code information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_MOTIVATIONCODES', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Motivation Codes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code ID
CALL INSERTREPORTFIELD('MOTIVATIONCODES_MOTVCODEID', 'Motivation Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('MOTIVATIONCODES_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('MOTIVATIONCODES_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Number Mailed
CALL INSERTREPORTFIELD('MOTIVATIONCODES_NBR', 'Number Mailed', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Date
CALL INSERTREPORTFIELD('MOTIVATIONCODES_MDATE', 'Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Cost
CALL INSERTREPORTFIELD('MOTIVATIONCODES_COST', 'Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Default Project Code
CALL INSERTREPORTFIELD('MOTIVATIONCODES_DEFPROJCODE', 'Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('MOTIVATIONCODES_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('MOTIVATIONCODES_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('MOTIVATIONCODES_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('MOTIVATIONCODES_CHANGEUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('MOTIVATIONCODES_CHANGEUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('MOTIVATIONCODES_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('MOTIVATIONCODES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('MOTIVATIONCODES_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Campaign
CALL INSERTREPORTFIELD('MOTIVATIONCODES_CAMPAIGN', 'Campaign', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Kit
CALL INSERTREPORTFIELD('MOTIVATIONCODES_KIT', 'Kit', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Cost Per
CALL INSERTREPORTFIELD('MOTIVATIONCODES_COSTPER', 'Cost Per', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert User 1
CALL INSERTREPORTFIELD('MOTIVATIONCODES_USER1', 'User 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert User 2
CALL INSERTREPORTFIELD('MOTIVATIONCODES_USER2', 'User 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Motivation Groups', 'Motivation groups including associated motivation code information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_MOTIVATIONGROUPS', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Motivation Groups', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Motivation Group ID
CALL INSERTREPORTFIELD('MOTIVATIONGROUPS_MOTVGRPID', 'Motivation Group ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Motivation Group
CALL INSERTREPORTFIELD('MOTIVATIONGROUPS_MOTVGRP', 'Motivation Group', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('MOTIVATIONGROUPS_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Date
CALL INSERTREPORTFIELD('MOTIVATIONGROUPS_MDATE', 'Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Cost
CALL INSERTREPORTFIELD('MOTIVATIONGROUPS_COST', 'Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('MOTIVATIONGROUPS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Motivation Codes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code ID
CALL INSERTREPORTFIELD('MOTIVATIONCODES_MOTVCODEID', 'Motivation Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('MOTIVATIONCODES_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('MOTIVATIONCODES_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Number Mailed
CALL INSERTREPORTFIELD('MOTIVATIONCODES_NBR', 'Number Mailed', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Date
CALL INSERTREPORTFIELD('MOTIVATIONCODES_MDATE', 'Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Cost
CALL INSERTREPORTFIELD('MOTIVATIONCODES_COST', 'Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Default Project Code
CALL INSERTREPORTFIELD('MOTIVATIONCODES_DEFPROJCODE', 'Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('MOTIVATIONCODES_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('MOTIVATIONCODES_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('MOTIVATIONCODES_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('MOTIVATIONCODES_CHANGEUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('MOTIVATIONCODES_CHANGEUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('MOTIVATIONCODES_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('MOTIVATIONCODES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('MOTIVATIONCODES_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Campaign
CALL INSERTREPORTFIELD('MOTIVATIONCODES_CAMPAIGN', 'Campaign', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Kit
CALL INSERTREPORTFIELD('MOTIVATIONCODES_KIT', 'Kit', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Cost Per
CALL INSERTREPORTFIELD('MOTIVATIONCODES_COSTPER', 'Cost Per', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert User 1
CALL INSERTREPORTFIELD('MOTIVATIONCODES_USER1', 'User 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert User 2
CALL INSERTREPORTFIELD('MOTIVATIONCODES_USER2', 'User 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'MPX Users', 'MPX User information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_USERS', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('MPower Users', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert User ID
CALL INSERTREPORTFIELD('TBLUSER_USERID', 'User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert User Name
CALL INSERTREPORTFIELD('TBLUSER_USERNAME', 'User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('TBLUSER_DESCRIPTION', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Authentication Time
CALL INSERTREPORTFIELD('TBLUSER_LASTAUTHENTICATIONTIME', 'Last Authentication Time', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Full Name
CALL INSERTREPORTFIELD('TBLUSER_FULLNAME', 'Full Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('TBLUSER_STATUS', 'Status', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Search Limit
CALL INSERTREPORTFIELD('TBLUSER_SEARCHLIMIT', 'Search Limit', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Last Batch Number
CALL INSERTREPORTFIELD('TBLUSER_LASTBATCHID', 'Last Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Email Address
CALL INSERTREPORTFIELD('TBLUSER_EMAIL', 'Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default View
CALL INSERTREPORTFIELD('TBLUSER_DEFAULTVIEW', 'Default View', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Country
CALL INSERTREPORTFIELD('TBLUSER_DEFAULTCOUNTRY', 'Default Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Security
CALL INSERTREPORTFIELD('TBLUSER_BATCHSECURITY', 'Batch Security', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Project Codes', 'Project code information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PROJECTCODES', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Project Codes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Project ID
CALL INSERTREPORTFIELD('PROJECTCODES_PROJECTID', 'Project ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('PROJECTCODES_PROJECT', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('PROJECTCODES_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Restriction Type
CALL INSERTREPORTFIELD('PROJECTCODES_NETASSETTYPE', 'Restriction Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('PROJECTCODES_DONORACCTNBR', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Email Report
CALL INSERTREPORTFIELD('PROJECTCODES_STMTTOFILE', 'Email Report', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('PROJECTCODES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Project Codes & Categories', 'Project codes and associated category information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PROJECTCODES_CATEGORIES', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Project Codes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Project ID
CALL INSERTREPORTFIELD('PROJECTCODES_PROJECTID', 'Project ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('PROJECTCODES_PROJECT', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('PROJECTCODES_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Restriction Type
CALL INSERTREPORTFIELD('PROJECTCODES_NETASSETTYPE', 'Restriction Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('PROJECTCODES_DONORACCTNBR', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Email Report
CALL INSERTREPORTFIELD('PROJECTCODES_STMTTOFILE', 'Email Report', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('PROJECTCODES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Project Categories', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Project Category ID
CALL INSERTREPORTFIELD('PROJECTCATEGORY_PROJECTCATEGORYID', 'Project Category ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert GL Account
CALL INSERTREPORTFIELD('PROJECTCATEGORY_GLACCT', 'GL Account', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Is Default Category
CALL INSERTREPORTFIELD('PROJECTCATEGORY_CATEGORYDEFAULT', 'Is Default Category', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('PROJECTCATEGORY_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Cost Center
CALL INSERTREPORTFIELD('PROJECTCATEGORY_CC', 'Cost Center', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Fund
CALL INSERTREPORTFIELD('PROJECTCATEGORY_FUND', 'Fund', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('PROJECTCATEGORY_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
INSERT INTO REPORTDATASUBSOURCEGROUP
	(DESCRIPTION, DISPLAY_NAME, reportDataSource_REPORTSOURCE_ID)
VALUES
	('Inventory Information', 'Inventory Information', @REPORTDATASOURCE_ID);
 
SET @REPORTDATASUBSOURCEGROUP_ID = LAST_INSERT_ID();
 
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'BOM Products & Components', 'BOM products and their component products', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PRODUCTCOMPONENTS', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Products', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Product ID
CALL INSERTREPORTFIELD('PRODUCTS_PRODUCTID', 'Product ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Product Code
CALL INSERTREPORTFIELD('PRODUCTS_PRODCODE', 'Product Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('PRODUCTS_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Type
CALL INSERTREPORTFIELD('PRODUCTS_TYPE', 'Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Designation
CALL INSERTREPORTFIELD('PRODUCTS_DESIGNATION', 'Designation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('PRODUCTS_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Weight
CALL INSERTREPORTFIELD('PRODUCTS_WEIGHT', 'Weight', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('PRODUCTS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Class
CALL INSERTREPORTFIELD('PRODUCTS_CLASS', 'Class', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor
CALL INSERTREPORTFIELD('PRODUCTS_PREFERREDVENDOR', 'Preferred Vendor', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor Account Number
CALL INSERTREPORTFIELD('PRODUCTS_PREFERREDVENDORID', 'Preferred Vendor Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Reorder Point
CALL INSERTREPORTFIELD('PRODUCTS_MINREORDERQTY', 'Reorder Point', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Lead Time
CALL INSERTREPORTFIELD('PRODUCTS_LEADTIME', 'Lead Time', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Projected Cost
CALL INSERTREPORTFIELD('PRODUCTS_PROJECTEDCOST', 'Projected Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Unit Cost
CALL INSERTREPORTFIELD('PRODUCTS_ACTUALCOST', 'Unit Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value
CALL INSERTREPORTFIELD('PRODUCTS_FAIRMARKETVALUE', 'Fair Market Value', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('PRODUCTS_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('PRODUCTS_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('PRODUCTS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('PRODUCTS_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('PRODUCTS_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('PRODUCTS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('PRODUCTS_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Selling Price
CALL INSERTREPORTFIELD('PRODUCTS_DEFAULTPRICE', 'Selling Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Is Suspended
CALL INSERTREPORTFIELD('PRODUCTS_SUSPENDED', 'Is Suspended', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Product Keywords', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Keyword
CALL INSERTREPORTFIELD('PRODUCTKEYWORDS_KEYWORD', 'Keyword', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Product Prices', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Price Code
CALL INSERTREPORTFIELD('PRODUCTPRICES_PRICECODE', 'Price Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Price
CALL INSERTREPORTFIELD('PRODUCTPRICES_PRICE', 'Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('PRODUCTPRICES_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('BOM Product Components', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert BOM Product Component Detail ID
CALL INSERTREPORTFIELD('PRODUCTBOM_BOMID', 'BOM Product Component Detail ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Quantity
CALL INSERTREPORTFIELD('PRODUCTBOM_QTY', 'Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Componentproduct', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Product ID
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_PRODUCTID', 'Product ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Product Code
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_PRODCODE', 'Product Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Type
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_TYPE', 'Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Designation
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_DESIGNATION', 'Designation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Weight
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_WEIGHT', 'Weight', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Class
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_CLASS', 'Class', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_PREFERREDVENDOR', 'Preferred Vendor', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor Account Number
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_PREFERREDVENDORID', 'Preferred Vendor Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Reorder Point
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_MINREORDERQTY', 'Reorder Point', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Lead Time
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_LEADTIME', 'Lead Time', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Projected Cost
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_PROJECTEDCOST', 'Projected Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Unit Cost
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_ACTUALCOST', 'Unit Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_FAIRMARKETVALUE', 'Fair Market Value', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Selling Price
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_DEFAULTPRICE', 'Selling Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Is Suspended
CALL INSERTREPORTFIELD('COMPONENTPRODUCT_SUSPENDED', 'Is Suspended', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Componentproductprices', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Price Code
CALL INSERTREPORTFIELD('COMPONENTPRODUCTPRICES_PRICECODE', 'Price Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Price
CALL INSERTREPORTFIELD('COMPONENTPRODUCTPRICES_PRICE', 'Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('COMPONENTPRODUCTPRICES_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Products', 'Product information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PRODUCTS', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Products', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Product ID
CALL INSERTREPORTFIELD('PRODUCTS_PRODUCTID', 'Product ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Product Code
CALL INSERTREPORTFIELD('PRODUCTS_PRODCODE', 'Product Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('PRODUCTS_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Type
CALL INSERTREPORTFIELD('PRODUCTS_TYPE', 'Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Designation
CALL INSERTREPORTFIELD('PRODUCTS_DESIGNATION', 'Designation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('PRODUCTS_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Weight
CALL INSERTREPORTFIELD('PRODUCTS_WEIGHT', 'Weight', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('PRODUCTS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Class
CALL INSERTREPORTFIELD('PRODUCTS_CLASS', 'Class', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor
CALL INSERTREPORTFIELD('PRODUCTS_PREFERREDVENDOR', 'Preferred Vendor', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor Account Number
CALL INSERTREPORTFIELD('PRODUCTS_PREFERREDVENDORID', 'Preferred Vendor Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Reorder Point
CALL INSERTREPORTFIELD('PRODUCTS_MINREORDERQTY', 'Reorder Point', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Lead Time
CALL INSERTREPORTFIELD('PRODUCTS_LEADTIME', 'Lead Time', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Projected Cost
CALL INSERTREPORTFIELD('PRODUCTS_PROJECTEDCOST', 'Projected Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Unit Cost
CALL INSERTREPORTFIELD('PRODUCTS_ACTUALCOST', 'Unit Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value
CALL INSERTREPORTFIELD('PRODUCTS_FAIRMARKETVALUE', 'Fair Market Value', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('PRODUCTS_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('PRODUCTS_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('PRODUCTS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('PRODUCTS_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('PRODUCTS_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('PRODUCTS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('PRODUCTS_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Selling Price
CALL INSERTREPORTFIELD('PRODUCTS_DEFAULTPRICE', 'Selling Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Is Suspended
CALL INSERTREPORTFIELD('PRODUCTS_SUSPENDED', 'Is Suspended', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Product Keywords', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Keyword
CALL INSERTREPORTFIELD('PRODUCTKEYWORDS_KEYWORD', 'Keyword', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Product Prices', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Price Code
CALL INSERTREPORTFIELD('PRODUCTPRICES_PRICECODE', 'Price Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Price
CALL INSERTREPORTFIELD('PRODUCTPRICES_PRICE', 'Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('PRODUCTPRICES_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Products & Activity', 'Products and their associated activities', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PRODUCTACTIVITY', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Products', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Product ID
CALL INSERTREPORTFIELD('PRODUCTS_PRODUCTID', 'Product ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Product Code
CALL INSERTREPORTFIELD('PRODUCTS_PRODCODE', 'Product Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('PRODUCTS_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Type
CALL INSERTREPORTFIELD('PRODUCTS_TYPE', 'Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Designation
CALL INSERTREPORTFIELD('PRODUCTS_DESIGNATION', 'Designation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('PRODUCTS_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Weight
CALL INSERTREPORTFIELD('PRODUCTS_WEIGHT', 'Weight', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('PRODUCTS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Class
CALL INSERTREPORTFIELD('PRODUCTS_CLASS', 'Class', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor
CALL INSERTREPORTFIELD('PRODUCTS_PREFERREDVENDOR', 'Preferred Vendor', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor Account Number
CALL INSERTREPORTFIELD('PRODUCTS_PREFERREDVENDORID', 'Preferred Vendor Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Reorder Point
CALL INSERTREPORTFIELD('PRODUCTS_MINREORDERQTY', 'Reorder Point', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Lead Time
CALL INSERTREPORTFIELD('PRODUCTS_LEADTIME', 'Lead Time', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Projected Cost
CALL INSERTREPORTFIELD('PRODUCTS_PROJECTEDCOST', 'Projected Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Unit Cost
CALL INSERTREPORTFIELD('PRODUCTS_ACTUALCOST', 'Unit Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value
CALL INSERTREPORTFIELD('PRODUCTS_FAIRMARKETVALUE', 'Fair Market Value', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('PRODUCTS_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('PRODUCTS_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('PRODUCTS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('PRODUCTS_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('PRODUCTS_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('PRODUCTS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('PRODUCTS_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Selling Price
CALL INSERTREPORTFIELD('PRODUCTS_DEFAULTPRICE', 'Selling Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Is Suspended
CALL INSERTREPORTFIELD('PRODUCTS_SUSPENDED', 'Is Suspended', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Product Keywords', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Keyword
CALL INSERTREPORTFIELD('PRODUCTKEYWORDS_KEYWORD', 'Keyword', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Product Prices', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Price Code
CALL INSERTREPORTFIELD('PRODUCTPRICES_PRICECODE', 'Price Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Price
CALL INSERTREPORTFIELD('PRODUCTPRICES_PRICE', 'Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('PRODUCTPRICES_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Product Activity', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Product Activity ID
CALL INSERTREPORTFIELD('PRODUCTACTIVITY_ACTIVITYID', 'Product Activity ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Location Code
CALL INSERTREPORTFIELD('PRODUCTACTIVITY_LOCCODE', 'Location Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Date
CALL INSERTREPORTFIELD('PRODUCTACTIVITY_TDATE', 'Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Type
CALL INSERTREPORTFIELD('PRODUCTACTIVITY_TYPE', 'Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Quantity
CALL INSERTREPORTFIELD('PRODUCTACTIVITY_QTY', 'Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('PRODUCTACTIVITY_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Unit Cost
CALL INSERTREPORTFIELD('PRODUCTACTIVITY_UNITCOST', 'Unit Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('PRODUCTACTIVITY_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('PRODUCTACTIVITY_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('PRODUCTACTIVITY_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('PRODUCTACTIVITY_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Target Product ID
CALL INSERTREPORTFIELD('PRODUCTACTIVITY_TARGETPRODUCTID', 'Target Product ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Target Location ID
CALL INSERTREPORTFIELD('PRODUCTACTIVITY_TARGETLOCATION', 'Target Location ID', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Quantity Consumed
CALL INSERTREPORTFIELD('PRODUCTACTIVITY_QTYCONSUMED', 'Quantity Consumed', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Estimated Delivery Date
CALL INSERTREPORTFIELD('PRODUCTACTIVITY_ESTDELIVERYDATE', 'Estimated Delivery Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Products & Locations ', 'Products and location information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PRODUCTLOCATIONS', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Products', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Product ID
CALL INSERTREPORTFIELD('PRODUCTS_PRODUCTID', 'Product ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Product Code
CALL INSERTREPORTFIELD('PRODUCTS_PRODCODE', 'Product Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('PRODUCTS_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Type
CALL INSERTREPORTFIELD('PRODUCTS_TYPE', 'Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Designation
CALL INSERTREPORTFIELD('PRODUCTS_DESIGNATION', 'Designation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('PRODUCTS_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Weight
CALL INSERTREPORTFIELD('PRODUCTS_WEIGHT', 'Weight', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('PRODUCTS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Class
CALL INSERTREPORTFIELD('PRODUCTS_CLASS', 'Class', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor
CALL INSERTREPORTFIELD('PRODUCTS_PREFERREDVENDOR', 'Preferred Vendor', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor Account Number
CALL INSERTREPORTFIELD('PRODUCTS_PREFERREDVENDORID', 'Preferred Vendor Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Reorder Point
CALL INSERTREPORTFIELD('PRODUCTS_MINREORDERQTY', 'Reorder Point', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Lead Time
CALL INSERTREPORTFIELD('PRODUCTS_LEADTIME', 'Lead Time', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Projected Cost
CALL INSERTREPORTFIELD('PRODUCTS_PROJECTEDCOST', 'Projected Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Unit Cost
CALL INSERTREPORTFIELD('PRODUCTS_ACTUALCOST', 'Unit Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value
CALL INSERTREPORTFIELD('PRODUCTS_FAIRMARKETVALUE', 'Fair Market Value', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('PRODUCTS_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('PRODUCTS_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('PRODUCTS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('PRODUCTS_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('PRODUCTS_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('PRODUCTS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('PRODUCTS_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Selling Price
CALL INSERTREPORTFIELD('PRODUCTS_DEFAULTPRICE', 'Selling Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Is Suspended
CALL INSERTREPORTFIELD('PRODUCTS_SUSPENDED', 'Is Suspended', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Product Keywords', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Keyword
CALL INSERTREPORTFIELD('PRODUCTKEYWORDS_KEYWORD', 'Keyword', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Product Prices', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Price Code
CALL INSERTREPORTFIELD('PRODUCTPRICES_PRICECODE', 'Price Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Price
CALL INSERTREPORTFIELD('PRODUCTPRICES_PRICE', 'Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('PRODUCTPRICES_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Product Locations', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Product Location ID
CALL INSERTREPORTFIELD('PRODUCTLOCATION_PRODUCTLOCATIONID', 'Product Location ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Location Code
CALL INSERTREPORTFIELD('PRODUCTLOCATION_LOCCODE', 'Location Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Location Actual
CALL INSERTREPORTFIELD('PRODUCTLOCATION_LOCACTUAL', 'Location Actual', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('PRODUCTLOCATION_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Allocated
CALL INSERTREPORTFIELD('PRODUCTLOCATION_ALLOCATED', 'Allocated', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert On Hand
CALL INSERTREPORTFIELD('PRODUCTLOCATION_ONHAND', 'On Hand', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert On Order
CALL INSERTREPORTFIELD('PRODUCTLOCATION_ONORDER', 'On Order', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Estimated Delivery Date
CALL INSERTREPORTFIELD('PRODUCTLOCATION_ESTDELIVERYDATE', 'Estimated Delivery Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Backordered
CALL INSERTREPORTFIELD('PRODUCTLOCATION_BACKORDERED', 'Backordered', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('PRODUCTLOCATION_INACTIVE', 'Inactive', b'0', 6, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Products & Monthly Activity Summaries', 'Products and monthly activity summary information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_PRODUCTHISTORY', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Products', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Product ID
CALL INSERTREPORTFIELD('PRODUCTS_PRODUCTID', 'Product ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Product Code
CALL INSERTREPORTFIELD('PRODUCTS_PRODCODE', 'Product Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('PRODUCTS_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Type
CALL INSERTREPORTFIELD('PRODUCTS_TYPE', 'Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Designation
CALL INSERTREPORTFIELD('PRODUCTS_DESIGNATION', 'Designation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('PRODUCTS_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Weight
CALL INSERTREPORTFIELD('PRODUCTS_WEIGHT', 'Weight', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('PRODUCTS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Class
CALL INSERTREPORTFIELD('PRODUCTS_CLASS', 'Class', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor
CALL INSERTREPORTFIELD('PRODUCTS_PREFERREDVENDOR', 'Preferred Vendor', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor Account Number
CALL INSERTREPORTFIELD('PRODUCTS_PREFERREDVENDORID', 'Preferred Vendor Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Reorder Point
CALL INSERTREPORTFIELD('PRODUCTS_MINREORDERQTY', 'Reorder Point', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Lead Time
CALL INSERTREPORTFIELD('PRODUCTS_LEADTIME', 'Lead Time', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Projected Cost
CALL INSERTREPORTFIELD('PRODUCTS_PROJECTEDCOST', 'Projected Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Unit Cost
CALL INSERTREPORTFIELD('PRODUCTS_ACTUALCOST', 'Unit Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value
CALL INSERTREPORTFIELD('PRODUCTS_FAIRMARKETVALUE', 'Fair Market Value', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('PRODUCTS_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('PRODUCTS_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('PRODUCTS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('PRODUCTS_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('PRODUCTS_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('PRODUCTS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('PRODUCTS_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Selling Price
CALL INSERTREPORTFIELD('PRODUCTS_DEFAULTPRICE', 'Selling Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Is Suspended
CALL INSERTREPORTFIELD('PRODUCTS_SUSPENDED', 'Is Suspended', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Product Keywords', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Keyword
CALL INSERTREPORTFIELD('PRODUCTKEYWORDS_KEYWORD', 'Keyword', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Product Prices', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Price Code
CALL INSERTREPORTFIELD('PRODUCTPRICES_PRICECODE', 'Price Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Price
CALL INSERTREPORTFIELD('PRODUCTPRICES_PRICE', 'Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('PRODUCTPRICES_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Product Activity Monthly Summary', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Product History ID
CALL INSERTREPORTFIELD('PRODUCTHISTORY_PRODUCTHISTORYID', 'Product History ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Location Code
CALL INSERTREPORTFIELD('PRODUCTHISTORY_LOCCODE', 'Location Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Year
CALL INSERTREPORTFIELD('PRODUCTHISTORY_CURRYEAR', 'Year', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Month
CALL INSERTREPORTFIELD('PRODUCTHISTORY_CURRMONTH', 'Month', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Beginning Quantity
CALL INSERTREPORTFIELD('PRODUCTHISTORY_QTYBEG', 'Beginning Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Quantity Allocated
CALL INSERTREPORTFIELD('PRODUCTHISTORY_QTYALL', 'Quantity Allocated', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Quantity Ordered
CALL INSERTREPORTFIELD('PRODUCTHISTORY_QTYORD', 'Quantity Ordered', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Quantity Received
CALL INSERTREPORTFIELD('PRODUCTHISTORY_QTYREC', 'Quantity Received', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Quantity Transferred
CALL INSERTREPORTFIELD('PRODUCTHISTORY_QTYTRN', 'Quantity Transferred', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Quantity Adjusted
CALL INSERTREPORTFIELD('PRODUCTHISTORY_QTYADJ', 'Quantity Adjusted', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Quantity Shipped
CALL INSERTREPORTFIELD('PRODUCTHISTORY_QTYSHP', 'Quantity Shipped', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Quantity Backordered
CALL INSERTREPORTFIELD('PRODUCTHISTORY_QTYBCK', 'Quantity Backordered', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Ending Quantity
CALL INSERTREPORTFIELD('PRODUCTHISTORY_QTYACT', 'Ending Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Unit Cost
CALL INSERTREPORTFIELD('PRODUCTHISTORY_AVGCST', 'Unit Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Reorder Point
CALL INSERTREPORTFIELD('PRODUCTHISTORY_REORDER', 'Reorder Point', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Next Delivery Date
CALL INSERTREPORTFIELD('PRODUCTHISTORY_NEXTDELIVERYDATE', 'Next Delivery Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
INSERT INTO REPORTDATASUBSOURCEGROUP
	(DESCRIPTION, DISPLAY_NAME, reportDataSource_REPORTSOURCE_ID)
VALUES
	('Media Information', 'Media Information', @REPORTDATASOURCE_ID);
 
SET @REPORTDATASUBSOURCEGROUP_ID = LAST_INSERT_ID();
 
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Media Outlets & Placements', 'Media outlets including associated placement and program information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_MEDIAOUTLETS_PLACEMENTS', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Outlets', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Code ID
CALL INSERTREPORTFIELD('MEDIAOUTLETS_MEDIACODE_ID', 'Media Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('MEDIAOUTLETS_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Frequency
CALL INSERTREPORTFIELD('MEDIAOUTLETS_FREQ', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Output Power
CALL INSERTREPORTFIELD('MEDIAOUTLETS_POWEROUT', 'Output Power', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('MEDIAOUTLETS_CITYOFLICENSE', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('MEDIAOUTLETS_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('MEDIAOUTLETS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web Page Address
CALL INSERTREPORTFIELD('MEDIAOUTLETS_WEBSITE_URL', 'Web Page Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('MEDIAOUTLETS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('MEDIAOUTLETS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Address 1
CALL INSERTREPORTFIELD('MEDIAOUTLETS_ADDRESS1', 'Address 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 2
CALL INSERTREPORTFIELD('MEDIAOUTLETS_ADDRESS2', 'Address 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 3
CALL INSERTREPORTFIELD('MEDIAOUTLETS_ADDRESS3', 'Address 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Zip Code
CALL INSERTREPORTFIELD('MEDIAOUTLETS_ZIPCODE', 'Zip Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('MEDIAOUTLETS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('MEDIAOUTLETS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('MEDIAOUTLETS_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('MEDIAOUTLETS_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('MEDIAOUTLETS_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('MEDIAOUTLETS_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Email Address
CALL INSERTREPORTFIELD('MEDIAOUTLETS_EMAILADDRESS', 'Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Tag Line
CALL INSERTREPORTFIELD('MEDIAOUTLETS_TAGLINE', 'Tag Line', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Translator
CALL INSERTREPORTFIELD('MEDIAOUTLETS_TRANSLATOR', 'Translator', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Flagship ID
CALL INSERTREPORTFIELD('MEDIAOUTLETS_FLAGSHIPID', 'Flagship ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Commercial / Non-Commercial
CALL INSERTREPORTFIELD('MEDIAOUTLETS_COMMERCIAL', 'Commercial / Non-Commercial', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Target ROI
CALL INSERTREPORTFIELD('MEDIAOUTLETS_TARGETROI', 'Target ROI', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Coverage Area
CALL INSERTREPORTFIELD('MEDIAOUTLETS_COVERAGEAREA', 'Coverage Area', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Delivery Methods', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Delivery Method
CALL INSERTREPORTFIELD('DELIVERYMETHODS_DELIVERY_METHOD', 'Delivery Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('DELIVERYMETHODS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Medium Types', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Medium Type
CALL INSERTREPORTFIELD('MEDIUMTYPES_MEDIUM_TYPE', 'Medium Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('MEDIUMTYPES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Medium Coverage Type
CALL INSERTREPORTFIELD('MEDIUMTYPES_COVERAGETYPE', 'Medium Coverage Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Medium Sub Types', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Medium Sub-Type
CALL INSERTREPORTFIELD('MEDIUMSUBTYPES_MEDIUM_SUBTYPE', 'Medium Sub-Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('MEDIUMSUBTYPES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Outlet Formats', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Format Name
CALL INSERTREPORTFIELD('MEDIAOUTLETFORMATS_FORMAT_NAME', 'Media Format Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('MEDIAOUTLETFORMATS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Placements', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Lead In
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_LEADIN', 'Lead In', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Lead Out
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_LEADOUT', 'Lead Out', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Monday
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_MONDAY', 'Monday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Tuesday
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_TUESDAY', 'Tuesday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Wednesday
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_WEDNESDAY', 'Wednesday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Thursday
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_THURSDAY', 'Thursday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Friday
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_FRIDAY', 'Friday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Saturday
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_SATURDAY', 'Saturday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Sunday
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_SUNDAY', 'Sunday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Air Time
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_LOCALTIMESLOT_BEGIN', 'Air Time', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code ID
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_MEDIAID', 'Media Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Begin Date
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_BEGINDATE', 'Begin Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert End Date
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_ENDDATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Media Agency ID
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_AGENCYID', 'Media Agency ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Contract Type
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_CONTRACT_TYPE', 'Contract Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Delivery Method ID
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_DELIVERYID', 'Delivery Method ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Is Default Placement
CALL INSERTREPORTFIELD('MEDIAPLACEMENTS_DEFAULTPLACEMENT', 'Is Default Placement', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Programs', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Program Name
CALL INSERTREPORTFIELD('MEDIAPROGRAMS_NAME', 'Media Program Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('MEDIAPROGRAMS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Length
CALL INSERTREPORTFIELD('MEDIAPROGRAMS_LENGTH', 'Length', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Length Seconds / Minutes
CALL INSERTREPORTFIELD('MEDIAPROGRAMS_MINSEC', 'Length Seconds / Minutes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('MEDIAPROGRAMS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Media Programs', ' Media programs including episode, air date, and premium information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_MEDIAPROGRAMS', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Programs', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Program ID
CALL INSERTREPORTFIELD('MEDIAPROGRAMS_PROGRAMID', 'Media Program ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Program Name
CALL INSERTREPORTFIELD('MEDIAPROGRAMS_NAME', 'Media Program Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('MEDIAPROGRAMS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Length
CALL INSERTREPORTFIELD('MEDIAPROGRAMS_LENGTH', 'Length', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Length Seconds / Minutes
CALL INSERTREPORTFIELD('MEDIAPROGRAMS_MINSEC', 'Length Seconds / Minutes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('MEDIAPROGRAMS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Episodes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Name
CALL INSERTREPORTFIELD('MEDIAEPISODES_NAME', 'Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Epside Number
CALL INSERTREPORTFIELD('MEDIAEPISODES_EPISODENBR', 'Epside Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('MEDIAEPISODES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Air Dates', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Air Date ID
CALL INSERTREPORTFIELD('MEDIAAIRDATES_AIRDATEID', 'Air Date ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Air Date
CALL INSERTREPORTFIELD('MEDIAAIRDATES_AIRDATE', 'Air Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('MEDIAAIRDATES_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Premiums', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Premium ID
CALL INSERTREPORTFIELD('MEDIAPREMIUMS_PREMIUMID', 'Media Premium ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Product ID
CALL INSERTREPORTFIELD('MEDIAPREMIUMS_PRODUCTID', 'Product ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Quantity
CALL INSERTREPORTFIELD('MEDIAPREMIUMS_QTY', 'Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Speak Line
CALL INSERTREPORTFIELD('MEDIAPREMIUMS_SPEAKLINE', 'Speak Line', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('MEDIAPREMIUMS_MOTIVATIONCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Motivation Description
CALL INSERTREPORTFIELD('MEDIAPREMIUMS_MOTIVATIONDESCRIPTION', 'Motivation Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert # of Days Available
CALL INSERTREPORTFIELD('MEDIAPREMIUMS_NUMBEROFDAYSAVAILABLE', '# of Days Available', b'0', 2, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
INSERT INTO REPORTDATASUBSOURCEGROUP
	(DESCRIPTION, DISPLAY_NAME, reportDataSource_REPORTSOURCE_ID)
VALUES
	('Transaction Information', 'Transaction Information', @REPORTDATASOURCE_ID);
 
SET @REPORTDATASUBSOURCEGROUP_ID = LAST_INSERT_ID();
 
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Batches', 'Batch information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_BATCHES', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Batches', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('BATCHES_BATCHNBR', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Date
CALL INSERTREPORTFIELD('BATCHES_BDATE', 'Batch Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert GL Date
CALL INSERTREPORTFIELD('BATCHES_GLDATE', 'GL Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Fund
CALL INSERTREPORTFIELD('BATCHES_FUND', 'Fund', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert GL Account
CALL INSERTREPORTFIELD('BATCHES_GLACCT', 'GL Account', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Cost Center
CALL INSERTREPORTFIELD('BATCHES_CC', 'Cost Center', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('BATCHES_PROJCODE', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('BATCHES_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('BATCHES_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('BATCHES_CONVRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Control Amount
CALL INSERTREPORTFIELD('BATCHES_CONTROLAMT', 'Control Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Actual Amount
CALL INSERTREPORTFIELD('BATCHES_ACTUALAMT', 'Actual Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Default Motivation Code
CALL INSERTREPORTFIELD('BATCHES_DEFMOTVCODE', 'Default Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Project Code
CALL INSERTREPORTFIELD('BATCHES_DEFFUNDID', 'Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Pledge Code
CALL INSERTREPORTFIELD('BATCHES_DEFPLDGCODE', 'Default Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Payment Type
CALL INSERTREPORTFIELD('BATCHES_DEFPAYCODE', 'Default Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('BATCHES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('BATCHES_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('BATCHES_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Posted Date
CALL INSERTREPORTFIELD('BATCHES_APPLYDATE', 'Posted Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 1
CALL INSERTREPORTFIELD('BATCHES_TYPE1', 'Batch Type 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 2
CALL INSERTREPORTFIELD('BATCHES_TYPE2', 'Batch Type 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Actual Number
CALL INSERTREPORTFIELD('BATCHES_ACTUALNBR', 'Actual Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Control Number
CALL INSERTREPORTFIELD('BATCHES_CONTROLNBR', 'Control Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Status
CALL INSERTREPORTFIELD('BATCHES_BATCHSTATUS', 'Batch Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('BATCHES_CHANGEUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('BATCHES_CHANGEUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('BATCHES_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Deposit Date
CALL INSERTREPORTFIELD('BATCHES_DEPOSITDATE', 'Deposit Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Owner ID
CALL INSERTREPORTFIELD('BATCHES_OWNERID', 'Batch Owner ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Owner User Name
CALL INSERTREPORTFIELD('BATCHES_BATCHOWNERNAME', 'Batch Owner User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Purchase Location
CALL INSERTREPORTFIELD('BATCHES_LOCATION', 'Default Purchase Location', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Free Location
CALL INSERTREPORTFIELD('BATCHES_FREELOCATION', 'Default Free Location', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Price Code
CALL INSERTREPORTFIELD('BATCHES_PRICECODE', 'Default Price Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Credit Card Transaction History', 'Credit card payment requests and approval status information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_CREDITCARDTRANSACTIONHISTORY', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Credit Card Transaction History', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Charge History ID
CALL INSERTREPORTFIELD('CHARGEHISTORY_CHARGEHISTORYID', 'Charge History ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Transaction ID
CALL INSERTREPORTFIELD('CHARGEHISTORY_TRANSID', 'Transaction ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Transaction Type
CALL INSERTREPORTFIELD('CHARGEHISTORY_TRANSTYPE', 'Transaction Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Transaction Date
CALL INSERTREPORTFIELD('CHARGEHISTORY_TDATE', 'Transaction Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Transaction Source
CALL INSERTREPORTFIELD('CHARGEHISTORY_SOURCE', 'Transaction Source', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('CHARGEHISTORY_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / ACH Type
CALL INSERTREPORTFIELD('CHARGEHISTORY_CHARGETYPE', 'Credit Card / ACH Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('CHARGEHISTORY_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Print Group
CALL INSERTREPORTFIELD('CHARGEHISTORY_PRTGRP', 'Print Group', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Authorization Code
CALL INSERTREPORTFIELD('CHARGEHISTORY_AUTHORIZATIONCODE', 'Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('CHARGEHISTORY_AMOUNT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Gift History', 'Gifts (hard & soft) and their associated information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_GIFTS', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift Headers', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Gift Reference Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_GIFTREF', 'Gift Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Gift Date
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_GDATE', 'Gift Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Apply Date
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_APPLYDATE', 'Apply Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_BATCHNBR', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_AMT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Payment Type
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PAYCODE', 'Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / ACH Type
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PAYTYPE', 'Credit Card / ACH Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / Bank Account Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PAYNBR', 'Credit Card / Bank Account Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Expiration Date
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_EXPIRE', 'Credit Card Expiration Date', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Authorization Code
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CHARGEAUTH', 'Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Receipt Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_RCPTNBR', 'Receipt Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Receipt Print Status
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_RCPTPRINT', 'Receipt Print Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Print Group
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PRTGRP', 'Print Group', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Letter Code
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_LTRCODE', 'Letter Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Letter Print Status
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_LTRPRINT', 'Letter Print Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CONVRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Order Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ORDNBR', 'Order Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 1
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PARACODE1', 'Paragraph Code 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 2
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PARACODE2', 'Paragraph Code 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bank Routing Number
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ROUTENBR', 'Bank Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Media Program ID
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_PROGRAMID', 'Media Program ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Episode ID
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_EPISODEID', 'Media Episode ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Bank Name
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_BANK', 'Bank Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Placement ID
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_MEDIAPLACEMENTID', 'Media Placement ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Transaction Source
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_TRANSACTIONSOURCE', 'Transaction Source', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Soft Gift
CALL INSERTREPORTFIELD('GIFT_GIFTHEADER_SOFTGIFT', 'Soft Gift', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Batches', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('GIFT_BATCHES_BATCHNBR', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_BDATE', 'Batch Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert GL Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_GLDATE', 'GL Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Fund
CALL INSERTREPORTFIELD('GIFT_BATCHES_FUND', 'Fund', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert GL Account
CALL INSERTREPORTFIELD('GIFT_BATCHES_GLACCT', 'GL Account', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Cost Center
CALL INSERTREPORTFIELD('GIFT_BATCHES_CC', 'Cost Center', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_PROJCODE', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('GIFT_BATCHES_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('GIFT_BATCHES_CONVRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Control Amount
CALL INSERTREPORTFIELD('GIFT_BATCHES_CONTROLAMT', 'Control Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Actual Amount
CALL INSERTREPORTFIELD('GIFT_BATCHES_ACTUALAMT', 'Actual Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Default Motivation Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_DEFMOTVCODE', 'Default Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Project Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_DEFFUNDID', 'Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Pledge Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_DEFPLDGCODE', 'Default Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Payment Type
CALL INSERTREPORTFIELD('GIFT_BATCHES_DEFPAYCODE', 'Default Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('GIFT_BATCHES_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('GIFT_BATCHES_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Posted Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_APPLYDATE', 'Posted Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 1
CALL INSERTREPORTFIELD('GIFT_BATCHES_TYPE1', 'Batch Type 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 2
CALL INSERTREPORTFIELD('GIFT_BATCHES_TYPE2', 'Batch Type 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Actual Number
CALL INSERTREPORTFIELD('GIFT_BATCHES_ACTUALNBR', 'Actual Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Control Number
CALL INSERTREPORTFIELD('GIFT_BATCHES_CONTROLNBR', 'Control Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Status
CALL INSERTREPORTFIELD('GIFT_BATCHES_BATCHSTATUS', 'Batch Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('GIFT_BATCHES_CHANGEUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('GIFT_BATCHES_CHANGEUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Deposit Date
CALL INSERTREPORTFIELD('GIFT_BATCHES_DEPOSITDATE', 'Deposit Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Owner ID
CALL INSERTREPORTFIELD('GIFT_BATCHES_OWNERID', 'Batch Owner ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Owner User Name
CALL INSERTREPORTFIELD('GIFT_BATCHES_BATCHOWNERNAME', 'Batch Owner User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Purchase Location
CALL INSERTREPORTFIELD('GIFT_BATCHES_LOCATION', 'Default Purchase Location', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Free Location
CALL INSERTREPORTFIELD('GIFT_BATCHES_FREELOCATION', 'Default Free Location', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Price Code
CALL INSERTREPORTFIELD('GIFT_BATCHES_PRICECODE', 'Default Price Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Outlets', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Code ID
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_MEDIACODE_ID', 'Media Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Frequency
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_FREQ', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Output Power
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_POWEROUT', 'Output Power', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_CITYOFLICENSE', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web Page Address
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_WEBSITE_URL', 'Web Page Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Address 1
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDRESS1', 'Address 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 2
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDRESS2', 'Address 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 3
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDRESS3', 'Address 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Zip Code
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ZIPCODE', 'Zip Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Email Address
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_EMAILADDRESS', 'Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Tag Line
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_TAGLINE', 'Tag Line', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Translator
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_TRANSLATOR', 'Translator', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Flagship ID
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_FLAGSHIPID', 'Flagship ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Commercial / Non-Commercial
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_COMMERCIAL', 'Commercial / Non-Commercial', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Target ROI
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_TARGETROI', 'Target ROI', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Coverage Area
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETS_COVERAGEAREA', 'Coverage Area', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Delivery Methods', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Delivery Method
CALL INSERTREPORTFIELD('GIFT_DELIVERYMETHODS_DELIVERY_METHOD', 'Delivery Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_DELIVERYMETHODS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Medium Types', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Medium Type
CALL INSERTREPORTFIELD('GIFT_MEDIUMTYPES_MEDIUM_TYPE', 'Medium Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIUMTYPES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Medium Coverage Type
CALL INSERTREPORTFIELD('GIFT_MEDIUMTYPES_COVERAGETYPE', 'Medium Coverage Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Medium Sub Types', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Medium Sub-Type
CALL INSERTREPORTFIELD('GIFT_MEDIUMSUBTYPES_MEDIUM_SUBTYPE', 'Medium Sub-Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIUMSUBTYPES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Outlet Formats', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Format Name
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETFORMATS_FORMAT_NAME', 'Media Format Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIAOUTLETFORMATS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Placements', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Lead In
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_LEADIN', 'Lead In', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Lead Out
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_LEADOUT', 'Lead Out', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Monday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_MONDAY', 'Monday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Tuesday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_TUESDAY', 'Tuesday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Wednesday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_WEDNESDAY', 'Wednesday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Thursday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_THURSDAY', 'Thursday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Friday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_FRIDAY', 'Friday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Saturday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_SATURDAY', 'Saturday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Sunday
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_SUNDAY', 'Sunday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Air Time
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_LOCALTIMESLOT_BEGIN', 'Air Time', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code ID
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_MEDIAID', 'Media Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Begin Date
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_BEGINDATE', 'Begin Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert End Date
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_ENDDATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Media Agency ID
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_AGENCYID', 'Media Agency ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Contract Type
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_CONTRACT_TYPE', 'Contract Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Delivery Method ID
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_DELIVERYID', 'Delivery Method ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Is Default Placement
CALL INSERTREPORTFIELD('GIFT_MEDIAPLACEMENTS_DEFAULTPLACEMENT', 'Is Default Placement', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Programs', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Program Name
CALL INSERTREPORTFIELD('GIFT_MEDIAPROGRAMS_NAME', 'Media Program Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('GIFT_MEDIAPROGRAMS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Length
CALL INSERTREPORTFIELD('GIFT_MEDIAPROGRAMS_LENGTH', 'Length', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Length Seconds / Minutes
CALL INSERTREPORTFIELD('GIFT_MEDIAPROGRAMS_MINSEC', 'Length Seconds / Minutes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_MEDIAPROGRAMS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Gift Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Gift Detail ID
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_GIFTDETAILID', 'Gift Detail ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Amount
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_AMT', 'Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_PROJCODE', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Deductible
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_DEDUCT', 'Deductible', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Anonymous
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_ANNON', 'Anonymous', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Related Account Number
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_SACCTNBR', 'Related Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('GIFT_GIFTDETAIL_GIFTDETAILNOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Motivation Codes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Number Mailed
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_NBR', 'Number Mailed', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Date
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_MDATE', 'Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Cost
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_COST', 'Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Default Project Code
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_DEFPROJCODE', 'Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Campaign
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_CAMPAIGN', 'Campaign', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Kit
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_KIT', 'Kit', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Cost Per
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_COSTPER', 'Cost Per', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert User 1
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_USER1', 'User 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert User 2
CALL INSERTREPORTFIELD('GIFT_MOTIVATIONCODES_USER2', 'User 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Project Codes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('GIFT_PROJECTCODES_PROJECT', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('GIFT_PROJECTCODES_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('GIFT_PROJECTCODES_DONORENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Email Report
CALL INSERTREPORTFIELD('GIFT_PROJECTCODES_STMTTOFILE', 'Email Report', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('GIFT_PROJECTCODES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Projectcodeentity', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('GIFT_PROJECTCODEENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Pledges', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Pledge Code
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_PLDGCODE', 'Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Start Date
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_STARTDATE', 'Start Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert End Date
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_ENDDATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Total Amount Pledged
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_TOTAMTPLDG', 'Total Amount Pledged', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Amount Per Gift
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_AMTPERGIFT', 'Amount Per Gift', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Number of Gifts Pledged
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_NBRPLDG', 'Number of Gifts Pledged', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Frequency
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_FREQ', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Amount Given
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_AMTGIVEN', 'Amount Given', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Amount Remaining
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_AMTREMAIN', 'Amount Remaining', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Number of Gifts Given
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_NBRGIVEN', 'Number of Gifts Given', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Pledge Paid Through Date
CALL INSERTREPORTFIELD('GIFT_GIFTPLEDGE_PLDGPAIDTHRUDATE', 'Pledge Paid Through Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Relatedaccountentity', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Organization Flag
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ORGFLAG', 'Organization Flag', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Title
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_TITLE', 'Title', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert First Name
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_FIRSTNAME', 'First Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Last Name
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_LASTNAME', 'Last Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Suffix
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_SUFFIX', 'Suffix', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Organization Name
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ORGANIZATIONNAME', 'Organization Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ACTIVE', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Middle Name
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_MIDDLENAME', 'Middle Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 1
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ADDRESS1', 'Address Line 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 2
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ADDRESS2', 'Address Line 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address Line 3
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_ADDRESS3', 'Address Line 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_CITY', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Postal Code
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_POSTALCODE', 'Postal Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Include Organization Name In Address
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_INCLUDEORGNAME', 'Include Organization Name In Address', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Default Email Address
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_DEFAULTEMAIL', 'Default Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Phone Number
CALL INSERTREPORTFIELD('GIFT_RELATEDACCOUNTENTITY_DEFAULTPHONE', 'Default Phone Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
-- Insert REPORTDATASUBSOURCE
INSERT REPORTDATASUBSOURCE
  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)
VALUES 
  (NULL, 1, 'Order History', 'Orders and their associated information', '/datasources/ReportWizardJdbcDSForMPX', 1, 'VW_REPORT_ORDERS', @REPORTDATASUBSOURCEGROUP_ID);

SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order Headers', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Account Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ENTITYID', 'Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Order Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ORDERID', 'Order Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BATCHID', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Order Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ORDERDATE', 'Order Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Posted Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BATCHPOSTEDDATE', 'Batch Posted Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_MOTIVATIONCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Received Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_RECEIVEDAMOUNT', 'Received Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Credit Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CREDITAMOUNT', 'Credit Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Order Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ORDERAMOUNT', 'Order Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Primary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_PRIMARYTAXAMOUNT', 'Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Shipping Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPPINGAMOUNT', 'Shipping Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Refund Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_REFUNDAMOUNT', 'Refund Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Amount Due
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_AMOUNTDUE', 'Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Associated Gift Reference Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_GIFTHEADERID', 'Associated Gift Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Credit Card / ACH Type
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_PAYMENTTYPE', 'Credit Card / ACH Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Type
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CHARGETYPE', 'Credit Card Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_PAYMENTNUMBER', 'Credit Card Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Credit Card Expiration Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_EXPIRATIONDATE', 'Credit Card Expiration Date', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CURRENCYCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CONVERSIONRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Letter Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_LETTERCODE', 'Letter Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 1
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_PARAGRAPHCODE1', 'Paragraph Code 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Paragraph Code 2
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_PARAGRAPHCODE2', 'Paragraph Code 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Address Type
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ADDRESSTYPE', 'Ship-To Address Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Should Compute Primary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_COMPUTEPRIMARYTAX', 'Should Compute Primary Tax Amount', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Shipping Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPPINGCODE', 'Shipping Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SECONDARYTAXAMOUNT', 'Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CHANGEUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Bank Routing Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CHECKROUTINGNUMBER', 'Bank Routing Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Media Program ID
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_MEDIAPROGRAMID', 'Media Program ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Episode ID
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_MEDIAEPISODEID', 'Media Episode ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_FAIRMARKETVALUE', 'Fair Market Value', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bank Name
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BANK', 'Bank Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Reference Number
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_REFERENCENUMBER', 'Reference Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Void Authorization Code
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_VOIDAUTHORIZATIONCODE', 'Void Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Placement ID
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_MEDIAPLACEMENTID', 'Media Placement ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Should Compute Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_COMPUTESECONDARYTAX', 'Should Compute Secondary Tax Amount', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Shipping Primary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPPINGPRIMARYTAXAMOUNT', 'Shipping Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Shipping Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPPINGSECONDARYTAXAMOUNT', 'Shipping Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Allow Partial Shipments
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ALLOWPARTIALSHIPMENTS', 'Allow Partial Shipments', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Discount Percentage
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_DISCOUNTPERCENTAGE', 'Discount Percentage', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Transaction Source
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_TRANSACTIONSOURCE', 'Transaction Source', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Should Tax Shipping
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_TAXSHIPPING', 'Should Tax Shipping', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Backorder Item Count
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BACKORDERITEMCOUNT', 'Backorder Item Count', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Primary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BILLTOPRIMARYTAXAMOUNT', 'Bill-To Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_BILLTOSECONDARYTAXAMOUNT', 'Bill-To Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Amount Due
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CONVERTEDAMOUNTDUE', 'Converted Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Converted Amount Paid To Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CONVERTEDAMOUNTPAIDTODATE', 'Converted Amount Paid To Date', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Current Amount Due
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CURRENTAMOUNTDUE', 'Current Amount Due', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Current Amount Paid To Date
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CURRENTAMOUNTPAIDTODATE', 'Current Amount Paid To Date', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Discount Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_DISCOUNTAMOUNT', 'Discount Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Discount Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_DISCOUNTTOTALAMOUNT', 'Discount Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value Total
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_FAIRMARKETVALUETOTAL', 'Fair Market Value Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_CANCELLEDTOTALAMOUNT', 'Cancelled Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Order Detail Discount Amount Total
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ITEMSDISCOUNTTOTALAMOUNT', 'Order Detail Discount Amount Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Quantity
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_QUANTITY', 'Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Primary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPTOPRIMARYTAXAMOUNT', 'Ship-To Primary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Secondary Tax Amount
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_SHIPTOSECONDARYTAXAMOUNT', 'Ship-To Secondary Tax Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Order Total
CALL INSERTREPORTFIELD('ORDER_ORDERHEADER_ORDERTOTAL', 'Order Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Batches', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Batch Number
CALL INSERTREPORTFIELD('ORDER_BATCHES_BATCHNBR', 'Batch Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_BDATE', 'Batch Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert GL Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_GLDATE', 'GL Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Fund
CALL INSERTREPORTFIELD('ORDER_BATCHES_FUND', 'Fund', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert GL Account
CALL INSERTREPORTFIELD('ORDER_BATCHES_GLACCT', 'GL Account', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Cost Center
CALL INSERTREPORTFIELD('ORDER_BATCHES_CC', 'Cost Center', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Project Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_PROJCODE', 'Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('ORDER_BATCHES_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Currency Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_CURRCODE', 'Currency Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Conversion Rate
CALL INSERTREPORTFIELD('ORDER_BATCHES_CONVRATE', 'Conversion Rate', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Control Amount
CALL INSERTREPORTFIELD('ORDER_BATCHES_CONTROLAMT', 'Control Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Actual Amount
CALL INSERTREPORTFIELD('ORDER_BATCHES_ACTUALAMT', 'Actual Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Default Motivation Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_DEFMOTVCODE', 'Default Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Project Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_DEFFUNDID', 'Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Pledge Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_DEFPLDGCODE', 'Default Pledge Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Payment Type
CALL INSERTREPORTFIELD('ORDER_BATCHES_DEFPAYCODE', 'Default Payment Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ORDER_BATCHES_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ORDER_BATCHES_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Posted Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_APPLYDATE', 'Posted Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 1
CALL INSERTREPORTFIELD('ORDER_BATCHES_TYPE1', 'Batch Type 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Batch Type 2
CALL INSERTREPORTFIELD('ORDER_BATCHES_TYPE2', 'Batch Type 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Actual Number
CALL INSERTREPORTFIELD('ORDER_BATCHES_ACTUALNBR', 'Actual Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Control Number
CALL INSERTREPORTFIELD('ORDER_BATCHES_CONTROLNBR', 'Control Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Status
CALL INSERTREPORTFIELD('ORDER_BATCHES_BATCHSTATUS', 'Batch Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ORDER_BATCHES_CHANGEUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ORDER_BATCHES_CHANGEUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Deposit Date
CALL INSERTREPORTFIELD('ORDER_BATCHES_DEPOSITDATE', 'Deposit Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Batch Owner ID
CALL INSERTREPORTFIELD('ORDER_BATCHES_OWNERID', 'Batch Owner ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Batch Owner User Name
CALL INSERTREPORTFIELD('ORDER_BATCHES_BATCHOWNERNAME', 'Batch Owner User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Purchase Location
CALL INSERTREPORTFIELD('ORDER_BATCHES_LOCATION', 'Default Purchase Location', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Free Location
CALL INSERTREPORTFIELD('ORDER_BATCHES_FREELOCATION', 'Default Free Location', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Default Price Code
CALL INSERTREPORTFIELD('ORDER_BATCHES_PRICECODE', 'Default Price Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Motivation Codes', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Motivation Code
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_MOTVCODE', 'Motivation Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Number Mailed
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_NBR', 'Number Mailed', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Date
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_MDATE', 'Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Cost
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_COST', 'Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Default Project Code
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_DEFPROJCODE', 'Default Project Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_STATUS', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_CHANGEDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Campaign
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_CAMPAIGN', 'Campaign', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Kit
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_KIT', 'Kit', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Cost Per
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_COSTPER', 'Cost Per', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert User 1
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_USER1', 'User 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert User 2
CALL INSERTREPORTFIELD('ORDER_MOTIVATIONCODES_USER2', 'User 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Outlets', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Code ID
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_MEDIACODE_ID', 'Media Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Media Code
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_MEDIACODE', 'Media Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Frequency
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_FREQ', 'Frequency', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Output Power
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_POWEROUT', 'Output Power', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert City
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_CITYOFLICENSE', 'City', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert State
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_STATE', 'State', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Country
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_COUNTRY', 'Country', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Web Page Address
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_WEBSITE_URL', 'Web Page Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Address 1
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDRESS1', 'Address 1', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 2
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDRESS2', 'Address 2', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Address 3
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDRESS3', 'Address 3', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Zip Code
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ZIPCODE', 'Zip Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Add User ID
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDUSERID', 'Add User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Add User Name
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_ADDUSERNAME', 'Add User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Modified User ID
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_CHGUSERID', 'Modified User ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Modified User Name
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_CHGUSERNAME', 'Modified User Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Email Address
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_EMAILADDRESS', 'Email Address', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Tag Line
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_TAGLINE', 'Tag Line', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Translator
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_TRANSLATOR', 'Translator', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Flagship ID
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_FLAGSHIPID', 'Flagship ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Commercial / Non-Commercial
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_COMMERCIAL', 'Commercial / Non-Commercial', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Target ROI
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_TARGETROI', 'Target ROI', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Coverage Area
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETS_COVERAGEAREA', 'Coverage Area', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Delivery Methods', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Delivery Method
CALL INSERTREPORTFIELD('ORDER_DELIVERYMETHODS_DELIVERY_METHOD', 'Delivery Method', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_DELIVERYMETHODS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Medium Types', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Medium Type
CALL INSERTREPORTFIELD('ORDER_MEDIUMTYPES_MEDIUM_TYPE', 'Medium Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIUMTYPES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Medium Coverage Type
CALL INSERTREPORTFIELD('ORDER_MEDIUMTYPES_COVERAGETYPE', 'Medium Coverage Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Medium Sub Types', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Medium Sub-Type
CALL INSERTREPORTFIELD('ORDER_MEDIUMSUBTYPES_MEDIUM_SUBTYPE', 'Medium Sub-Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIUMSUBTYPES_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Outlet Formats', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Format Name
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETFORMATS_FORMAT_NAME', 'Media Format Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIAOUTLETFORMATS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Placements', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Lead In
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_LEADIN', 'Lead In', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Lead Out
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_LEADOUT', 'Lead Out', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Monday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_MONDAY', 'Monday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Tuesday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_TUESDAY', 'Tuesday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Wednesday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_WEDNESDAY', 'Wednesday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Thursday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_THURSDAY', 'Thursday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Friday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_FRIDAY', 'Friday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Saturday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_SATURDAY', 'Saturday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Sunday
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_SUNDAY', 'Sunday', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Air Time
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_LOCALTIMESLOT_BEGIN', 'Air Time', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Media Code ID
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_MEDIAID', 'Media Code ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Begin Date
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_BEGINDATE', 'Begin Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert End Date
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_ENDDATE', 'End Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Media Agency ID
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_AGENCYID', 'Media Agency ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Contract Type
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_CONTRACT_TYPE', 'Contract Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Delivery Method ID
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_DELIVERYID', 'Delivery Method ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Is Default Placement
CALL INSERTREPORTFIELD('ORDER_MEDIAPLACEMENTS_DEFAULTPLACEMENT', 'Is Default Placement', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Media Programs', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Media Program Name
CALL INSERTREPORTFIELD('ORDER_MEDIAPROGRAMS_NAME', 'Media Program Name', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Notes
CALL INSERTREPORTFIELD('ORDER_MEDIAPROGRAMS_NOTES', 'Notes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Length
CALL INSERTREPORTFIELD('ORDER_MEDIAPROGRAMS_LENGTH', 'Length', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Length Seconds / Minutes
CALL INSERTREPORTFIELD('ORDER_MEDIAPROGRAMS_MINSEC', 'Length Seconds / Minutes', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_MEDIAPROGRAMS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Order Details', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Order Detail ID
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_ORDERDETAILID', 'Order Detail ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Price Code
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PRICECODE', 'Price Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Price
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PRICE', 'Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Product ID
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PRODUCTID', 'Product ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Reduct Inventory
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_REDUCEINVENTORY', 'Reduct Inventory', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value Amount Per Item
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_FAIRMARKETVALUE', 'Fair Market Value Amount Per Item', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Allocated Date
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_ALLOCATEDDATE', 'Allocated Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Backordered Date
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_BACKORDERDATE', 'Backordered Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Canceled Date
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELDATE', 'Canceled Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Return Date
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_RETURNDATE', 'Return Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Authorization Code
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_AUTHORIZATIONCODE', 'Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Packing Slip Print Status
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PACKINGSLIPSTATE', 'Packing Slip Print Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Print Group
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PRINTGROUP', 'Print Group', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Packing Slip Print Date
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PRINTDATE', 'Packing Slip Print Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Void Authorization Code
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_VOIDAUTHORIZATIONCODE', 'Void Authorization Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Quantity
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_QUANTITY', 'Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Transaction Type ID
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_TYPE', 'Transaction Type ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_STATUS', 'Status', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Product Location ID
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_LOCATION', 'Product Location ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Discount Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_DISCOUNTAMOUNT', 'Discount Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Primary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_SHIPTOPRIMARYTAX', 'Ship-To Primary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Ship-To Secondary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_SHIPTOSECONDARYTAX', 'Ship-To Secondary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Address Primary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_BILLTOPRIMARYTAX', 'Bill-To Address Primary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Bill-To Secondary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_BILLTOSECONDARYTAX', 'Bill-To Secondary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Is Cancelled
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_ISCANCELLED', 'Is Cancelled', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert Shipping Package ID
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_SHIPPINGPACKAGEID', 'Shipping Package ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Discount Percentage
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_DISCOUNTPERCENTAGE', 'Discount Percentage', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Discount Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMDISCOUNTTOTALAMOUNT', 'Cancelled Line Item Discount Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Overall Discount Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMOVERALLDISCOUNTTOTALAMOUNT', 'Cancelled Line Item Overall Discount Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Primary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMPRIMARYTAX', 'Cancelled Line Item Primary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Product Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMPRODUCTAMOUNT', 'Cancelled Line Item Product Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Secondary Tax
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMSECONDARYTAX', 'Cancelled Line Item Secondary Tax', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Shipping Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMSHIPPINGAMOUNT', 'Cancelled Line Item Shipping Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Cancelled Line Item Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_CANCELLEDLINEITEMTOTALAMOUNT', 'Cancelled Line Item Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value Total
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_FAIRMARKETVALUETOTAL', 'Fair Market Value Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Order Detail Net Total
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_NETTOTAL', 'Order Detail Net Total', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Percentage Discount Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PERCENTAGEDISCOUNTAMOUNT', 'Percentage Discount Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Premium Quantity
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_PREMIUMQUANTITY', 'Premium Quantity', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Discount Total Amount
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_DISCOUNTTOTALAMOUNT', 'Discount Total Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Status
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_STATUSNAME', 'Status', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Transaction Type
CALL INSERTREPORTFIELD('ORDER_ORDERDETAIL_TYPENAME', 'Transaction Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Products', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Product ID
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_PRODUCTID', 'Product ID', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Product Code
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_PRODCODE', 'Product Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Description
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_DESCRIPT', 'Description', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Type
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_TYPE', 'Type', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Designation
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_DESIGNATION', 'Designation', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Category
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_CATEGORY', 'Category', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Weight
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_WEIGHT', 'Weight', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_INACTIVE', 'Inactive', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Class
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_CLASS', 'Class', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_PREFERREDVENDOR', 'Preferred Vendor', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Preferred Vendor Account Number
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_PREFERREDVENDORID', 'Preferred Vendor Account Number', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Reorder Point
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_MINREORDERQTY', 'Reorder Point', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Lead Time
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_LEADTIME', 'Lead Time', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Projected Cost
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_PROJECTEDCOST', 'Projected Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Unit Cost
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_ACTUALCOST', 'Unit Cost', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Fair Market Value
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_FAIRMARKETVALUE', 'Fair Market Value', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Add Date
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_ADDDATE', 'Add Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Modified Date
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_CHGDATE', 'Modified Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Selling Price
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_DEFAULTPRICE', 'Selling Price', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Is Suspended
CALL INSERTREPORTFIELD('ORDER_PRODUCTS_SUSPENDED', 'Is Suspended', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Product Locations', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Location Code
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_LOCCODE', 'Location Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Location Actual
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_LOCACTUAL', 'Location Actual', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Note
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_NOTE', 'Note', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Allocated
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_ALLOCATED', 'Allocated', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert On Hand
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_ONHAND', 'On Hand', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert On Order
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_ONORDER', 'On Order', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Estimated Delivery Date
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_ESTDELIVERYDATE', 'Estimated Delivery Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Backordered
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_BACKORDERED', 'Backordered', b'0', 2, @REPORTFIELDGROUP_ID);

-- Insert Inactive
CALL INSERTREPORTFIELD('ORDER_PRODUCTLOCATION_INACTIVE', 'Inactive', b'0', 6, @REPORTFIELDGROUP_ID);

-- Insert REPORTFIELDGROUP
CALL INSERTREPORTFIELDGROUP('Shipping Package Information', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);

-- Insert Ship Date
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_SHIPDATE', 'Ship Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Tracking Number
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_TRACKINGNUMBER', 'Tracking Number', b'0', 1, @REPORTFIELDGROUP_ID);

-- Insert Ship Weight
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_SHIPWEIGHT', 'Ship Weight', b'0', 3, @REPORTFIELDGROUP_ID);

-- Insert Ship Amount
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_SHIPAMOUNT', 'Ship Amount', b'0', 5, @REPORTFIELDGROUP_ID);

-- Insert Package Date
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_PACKAGEDATE', 'Package Date', b'0', 4, @REPORTFIELDGROUP_ID);

-- Insert Shipping Code
CALL INSERTREPORTFIELD('ORDER_SHIPPINGPACKAGES_SHIPPINGCODE', 'Shipping Code', b'0', 1, @REPORTFIELDGROUP_ID);

-- ********************************************************************************************
 
UPDATE REPORTFIELDGROUP SET NAME = 'Project Code Account' WHERE NAME = 'Projectcodeentity';
UPDATE REPORTFIELDGROUP SET NAME = 'Gift - Project Code Account' WHERE NAME = 'Gift - Projectcodeentity';
UPDATE REPORTFIELDGROUP SET NAME = 'Gift - Project Code Account' WHERE NAME = 'Gift - Gift - Projectcodeentity';
UPDATE REPORTFIELDGROUP SET NAME = 'Gift Detail Related Account' WHERE NAME = 'Relatedaccountentity';
UPDATE REPORTFIELDGROUP SET NAME = 'Gift - Gift Detail Related Account' WHERE NAME = 'Gift - Relatedaccountentity';
UPDATE REPORTFIELDGROUP SET NAME = 'Gift - Gift Detail Related Account' WHERE NAME = 'Gift - Gift - Relatedaccountentity';
 
INSERT REPORTCUSTOMFILTERDEFINITION_REPORTDATASUBSOURCE
SELECT REPORTCUSTOMFILTERDEFINITION_ID, REPORTDATASUBSOURCE_REPORTSUBSOURCE_ID, REPORTDATASUBSOURCE_REPORTSUBSOURCE_ID, REPORTSUBSOURCE_ID + REPORTCUSTOMFILTERDEFINITION_ID
FROM REPORTFIELDGROUP_REPORTDATASUBSOURCE
JOIN REPORTCUSTOMFILTERDEFINITION ON 1 = 1
WHERE REPORTCUSTOMFILTERDEFINITION_ID < 100000
AND REPORTFIELDGROUP_REPORTFIELDGROUP_ID IN
  (SELECT REPORTFIELDGROUP_ID FROM REPORTFIELD_REPORTFIELDGROUP
  WHERE REPORTFIELD_ID IN
    (SELECT REPORTFIELD_ID FROM REPORTFIELD
    WHERE COLUMN_NAME = 'ENTITY_ENTITYID'));

CREATE TABLE TMP ( REPORTFIELD_ID INT, REPORTDATASUBSOURCE_ID INT);
CREATE TABLE TMP2 ( REPORTFIELD_ID INT);

INSERT TMP
SELECT A.REPORTFIELD_ID, C.REPORTDATASUBSOURCE_REPORTSUBSOURCE_ID
FROM REPORTFIELD A
JOIN REPORTFIELD_REPORTFIELDGROUP B ON B.REPORTFIELD_ID = A.REPORTFIELD_ID
JOIN REPORTFIELDGROUP_REPORTDATASUBSOURCE C ON B.REPORTFIELDGROUP_REPORTFIELDGROUP_ID = C.REPORTFIELDGROUP_REPORTFIELDGROUP_ID;

INSERT TMP2
SELECT REPORTFIELD_ID FROM TMP WHERE REPORTFIELD_ID =
(SELECT REPORTFIELD_ID FROM TMP B WHERE B.REPORTDATASUBSOURCE_ID = TMP.REPORTDATASUBSOURCE_ID LIMIT 0, 1);

UPDATE REPORTFIELD SET IS_DEFAULT = 1
WHERE REPORTFIELD_ID IN
(SELECT REPORTFIELD_ID FROM TMP2);

DROP TABLE TMP;
DROP TABLE TMP2;
