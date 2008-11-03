insert into REPORTDATASOURCE values(1,'People');
insert into REPORTDATASOURCE values(2,'Gifts');

-- MPX
insert into REPORTDATASOURCE values(3,'MPX People');


insert into REPORTDATASUBSOURCE 
		(REPORTSUBSOURCE_ID, DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSource_REPORTSOURCE_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
		values(1,'People',0,'PERSON',1, 0, '/datasources/ReportWizardJdbcDS');
insert into REPORTDATASUBSOURCE 
		(REPORTSUBSOURCE_ID, DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSource_REPORTSOURCE_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
		values(2,'People & Addresses',0,'VPEOPLEADDRESS',1, 0, '/datasources/ReportWizardJdbcDS');
insert into REPORTDATASUBSOURCE 
		(REPORTSUBSOURCE_ID, DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSource_REPORTSOURCE_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
		values(3,'People & Gifts',0,'VPEOPLEGIFT',1, 0, '/datasources/ReportWizardJdbcDS');
insert into REPORTDATASUBSOURCE
		(REPORTSUBSOURCE_ID, DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSource_REPORTSOURCE_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
		values(4,'Gifts',0,'GIFT',2, 0, '/datasources/ReportWizardJdbcDS');
insert into REPORTDATASUBSOURCE 
		(REPORTSUBSOURCE_ID, DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSource_REPORTSOURCE_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
		values(5,'People & Gift Distributions',0,'VPEOPLEGIFTDISTRO',1, 0, '/datasources/ReportWizardJdbcDS');
insert into REPORTDATASUBSOURCE 
		(REPORTSUBSOURCE_ID, DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSource_REPORTSOURCE_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
		values(6,'Gift Distributions',0,'VGIFTDISTRO',2, 0, '/datasources/ReportWizardJdbcDS');

-- MPX 
insert into REPORTDATASUBSOURCE 
		(REPORTSUBSOURCE_ID, DISPLAY_NAME, DATABASE_TYPE, VIEW_NAME, reportDataSource_REPORTSOURCE_ID, REPORT_FORMAT_TYPE, JASPER_DATASOURCE_NAME)
		values(7,'People',1,'ENTITY',3, 1, '/datasources/ReportWizardJdbcDSForMPX');

insert into REPORTFIELDGROUP values(1,'People General');
insert into REPORTFIELDGROUP values(2,'People Address');
insert into REPORTFIELDGROUP values(3,'People Misc.');
insert into REPORTFIELDGROUP values(4,'Gift General');
insert into REPORTFIELDGROUP values(5,'Gift Payment');
insert into REPORTFIELDGROUP values(6,'Gift Distribution');

-- MPX 
insert into REPORTFIELDGROUP values(7,'People General'); 
insert into REPORTFIELDGROUP values(8,'People Address');

insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(1,1,1);
insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(3,1,2);
insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(1,2,3);
insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(2,2,4);
insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(3,2,5);
insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(1,3,6);
insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(2,3,7);
insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(3,3,8);
insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(4,3,9);
insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(1,5,10);
insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(2,5,11);
insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(3,5,12);
insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(4,5,13);
insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(6,5,14);
insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(4,6,15);
insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(6,6,16);

-- MPX 
insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(7,7,17);
insert into REPORTFIELDGROUP_REPORTDATASUBSOURCE values(8,7,18);

insert into REPORTFIELD values(1,b'0',b'0','PERSON_ID','Account Number',b'1',b'0',b'0',b'0',b'0',b'0',3);
insert into REPORTFIELD values(2,b'0',b'0','FIRST_NAME','First Name',b'1',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(3,b'0',b'0','MIDDLE_NAME','Middle Name',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(4,b'0',b'0','LAST_NAME','Last Name',b'1',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(5,b'0',b'0','ANNIVERSARY','Anniversary Date',b'0',b'0',b'0',b'0',b'0',b'0',4);
insert into REPORTFIELD values(6,b'0',b'0','BIRTHDATE','Birthday',b'0',b'0',b'0',b'0',b'0',b'0',4);
insert into REPORTFIELD values(7,b'0',b'0','EMAIL','E-Mail Address',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(8,b'0',b'0','LASED_DONOR','Lapsed Donor',b'0',b'0',b'0',b'0',b'0',b'0',6);
insert into REPORTFIELD values(9,b'0',b'0','MAJOR_DONOR','Major Donor',b'0',b'0',b'0',b'0',b'0',b'0',6);
insert into REPORTFIELD values(10,b'0',b'0','MARITAL_STATUS','Marital Status',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(11,b'0',b'0','ORGANIZATION_NAME','Organization',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(12,b'0',b'0','PREFERRED_PHONE_TYPE','Preferred Phone Type',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(13,b'0',b'0','SPOUSE_FIRST_NAME','Spouse First Name',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(14,b'0',b'0','SPOUSE_Name','Spouse Name',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(15,b'0',b'0','SUFFIX','Suffix',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(16,b'0',b'0','TITLE','Title',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(17,b'0',b'0','ADDRESS_LINE_1','Address Line 1',b'1',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(18,b'0',b'0','ADDRESS_LINE_2','Address Line 2',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(19,b'0',b'0','ADDRESS_LINE_3','Address Line 3',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(20,b'0',b'0','ADDRESS_TYPE','Address Type',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(21,b'0',b'0','CITY','City',b'1',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(22,b'0',b'0','COUNTRY','Country',b'1',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(23,b'0',b'0','POSTAL_CODE','Zip Code',b'1',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(24,b'0',b'0','STATE_PROVINCE','State',b'1',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(25,b'0',b'0','TRANSACTION_DATE','Gift Date',b'1',b'0',b'0',b'0',b'0',b'0',4);
insert into REPORTFIELD values(26,b'0',b'1','VALUE','Gift Amount',b'1',b'0',b'0',b'0',b'0',b'0',5);
insert into REPORTFIELD values(27,b'0',b'1','AMOUNT','Gift Distribution Amount',b'1',b'0',b'0',b'0',b'0',b'0',5);
insert into REPORTFIELD values(28,b'0',b'0','MOTIVATION_CODE','Motivation Code',b'1',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(29,b'0',b'0','PROJECT_CODE','Project Code',b'1',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(30,b'0',b'0','GETPERSONCUSTOMFIELD(PERSON_ID, ''DOGNAME'')','Dog Name',b'1',b'0',b'0',b'0',b'0',b'0',0);

-- MPX 
insert into REPORTFIELD values(31,b'0',b'0','ENTITYID','Account Number',b'1',b'0',b'0',b'0',b'0',b'0',3);
insert into REPORTFIELD values(32,b'0',b'0','FIRSTNAME','First Name',b'1',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(33,b'0',b'0','LASTNAME','Last Name',b'1',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(34,b'0',b'0','ORGANIZATIONNAME','Organization Name',b'1',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(35,b'0',b'0','ADDRESS1','Address 1',b'1',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(36,b'0',b'0','ADDRESS2','Address 2',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(37,b'0',b'0','ADDRESS3','Address 3',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(38,b'0',b'0','CITY','City',b'1',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(39,b'0',b'0','STATE','State',b'1',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(40,b'0',b'0','POSTALCODE','Zip Code',b'1',b'0',b'0',b'0',b'0',b'0',1);


-- Account Number in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(1,1,2,1);
-- First Name in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(2,1,2,2);
-- Middle Name in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(3,1,3,3);
-- Last Name in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(4,1,4,4);
-- Anniversary in People Misc.
insert into REPORTFIELD_REPORTFIELDGROUP values(5,3,8,5);
-- BirthDate in People Misc.
insert into REPORTFIELD_REPORTFIELDGROUP values(6,3,9,6);
-- E-mail in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(7,1,7,7);
-- Organization in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(11,1,6,11);  
-- Spouse First Name in People Misc.
insert into REPORTFIELD_REPORTFIELDGROUP values(13,3,10,13); 
-- Spouse Name in People Misc.
insert into REPORTFIELD_REPORTFIELDGROUP values(14,3,11,14);
-- Suffix in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(15,1,5,15); 
-- Title in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(16,1,1,16); 
-- Address Line 1 in People Address
insert into REPORTFIELD_REPORTFIELDGROUP values(17,2,12,17);
-- Address Line 2 in People Address
insert into REPORTFIELD_REPORTFIELDGROUP values(18,2,13,18); 
-- Address Line 3 in People Address
insert into REPORTFIELD_REPORTFIELDGROUP values(19,2,14,19); 
-- Address Type in People Address
insert into REPORTFIELD_REPORTFIELDGROUP values(20,2,15,20);
-- City in People Address
insert into REPORTFIELD_REPORTFIELDGROUP values(21,2,16,21); 
-- Country in People Address
insert into REPORTFIELD_REPORTFIELDGROUP values(22,2,17,22);
-- Postal Code in People Address
insert into REPORTFIELD_REPORTFIELDGROUP values(23,2,18,23);
-- State in People Address
insert into REPORTFIELD_REPORTFIELDGROUP values(24,2,19,24); 
-- Transaction date into gift general
insert into REPORTFIELD_REPORTFIELDGROUP values(25,4,20,25); 
-- Gift Amount into gift general
insert into REPORTFIELD_REPORTFIELDGROUP values(26,4,21,26); 
-- Gift Distribution Amount into gift general
insert into REPORTFIELD_REPORTFIELDGROUP values(27,6,20,27);
-- Motivation Code into gift distribution 
insert into REPORTFIELD_REPORTFIELDGROUP values(28,6,21,28);
-- Project Code into gift distribution
insert into REPORTFIELD_REPORTFIELDGROUP values(29,6,22,29);
-- Dog Name into People General
insert into REPORTFIELD_REPORTFIELDGROUP values(30,3,2,30);

-- MPX
-- Account Number into people general
insert into REPORTFIELD_REPORTFIELDGROUP values(31,7,22,31);
-- First Name into people general
insert into REPORTFIELD_REPORTFIELDGROUP values(32,7,22,32);
-- Last Name into people general
insert into REPORTFIELD_REPORTFIELDGROUP values(33,7,22,33);
-- Organization Name into people general
insert into REPORTFIELD_REPORTFIELDGROUP values(34,7,22,34);
-- Address 1 into people address
insert into REPORTFIELD_REPORTFIELDGROUP values(35,8,22,35);
-- Address 2 into people address
insert into REPORTFIELD_REPORTFIELDGROUP values(36,8,22,36);
-- Address 3 into people address
insert into REPORTFIELD_REPORTFIELDGROUP values(37,8,22,37);
-- City into people address
insert into REPORTFIELD_REPORTFIELDGROUP values(38,8,22,38);
-- State into people address
insert into REPORTFIELD_REPORTFIELDGROUP values(39,8,22,39);
-- Zip code into people address
insert into REPORTFIELD_REPORTFIELDGROUP values(40,8,22,40);


-- Drop views if they already exists
DROP VIEW IF EXISTS VPEOPLEADDRESS;
DROP VIEW IF EXISTS VPEOPLEGIFT;
DROP VIEW IF EXISTS VPEOPLEGIFTDISTRO;
DROP VIEW IF EXISTS VGIFTDISTRO;


-- Create vpeopleaddress
CREATE VIEW VPEOPLEADDRESS AS SELECT `ADDRESS`.`ADDRESS_LINE_1` AS `ADDRESS_LINE_1`,`ADDRESS`.`ADDRESS_LINE_2` AS `ADDRESS_LINE_2`,`ADDRESS`.`ADDRESS_LINE_3` AS `ADDRESS_LINE_3`,`ADDRESS`.`ADDRESS_TYPE` AS `ADDRESS_TYPE`,`ADDRESS`.`CITY` AS `CITY`,`ADDRESS`.`COUNTRY` AS `COUNTRY`,`ADDRESS`.`POSTAL_CODE` AS `POSTAL_CODE`,`ADDRESS`.`STATE_PROVINCE` AS `STATE_PROVINCE`,`PERSON`.`ANNIVERSARY` AS `ANNIVERSARY`,`PERSON`.`BIRTHDATE` AS `BIRTHDATE`,`PERSON`.`EMAIL` AS `EMAIL`,`PERSON`.`FIRST_NAME` AS `FIRST_NAME`,`PERSON`.`LAPSED_DONOR` AS `LAPSED_DONOR`,`PERSON`.`LAST_NAME` AS `LAST_NAME`,`PERSON`.`MAJOR_DONOR` AS `MAJOR_DONOR`,`PERSON`.`MARITAL_STATUS` AS `MARITAL_STATUS`,`PERSON`.`MIDDLE_NAME` AS `MIDDLE_NAME`,`PERSON`.`ORGANIZATION_NAME` AS `ORGANIZATION_NAME`,`PERSON`.`PREFERRED_PHONE_TYPE` AS `PREFERRED_PHONE_TYPE`,`PERSON`.`SPOUSE_FIRST_NAME` AS `SPOUSE_FIRST_NAME`,`PERSON`.`SPOUSE_NAME` AS `SPOUSE_NAME`,`PERSON`.`SUFFIX` AS `SUFFIX`,`PERSON`.`TITLE` AS `TITLE`,`PERSON`.`PERSON_ID` AS `PERSON_ID`,`ADDRESS`.`ADDRESS_ID` AS `ADDRESS_ID` FROM   `PERSON_ADDRESS` JOIN `PERSON` ON  `PERSON_ADDRESS`.`PERSON_ID` = `PERSON`.`PERSON_ID`    JOIN `ADDRESS` ON  `ADDRESS`.`ADDRESS_ID` = `PERSON_ADDRESS`.`ADDRESS_ID`;

-- Create vpeoplegift
CREATE VIEW VPEOPLEGIFT AS SELECT `GIFT`.`AUTH_CODE` AS `AUTH_CODE`,`GIFT`.`CHECK_NUMBER` AS `CHECK_NUMBER`,`GIFT`.`COMMENTS` AS `COMMENTS`,`GIFT`.`ORIGINAL_GIFT_ID` AS `ORIGINAL_GIFT_ID`,`GIFT`.`PAYMENT_TYPE` AS `PAYMENT_TYPE`,`GIFT`.`REFUND_GIFT_ID` AS `REFUND_GIFT_ID`,`GIFT`.`REFUND_GIFT_TRANSACTION_DATE` AS `REFUND_GIFT_TRANSACTION_DATE`,`GIFT`.`TRANSACTION_DATE` AS `TRANSACTION_DATE`,`GIFT`.`VALUE` AS `VALUE`,`VPEOPLEADDRESS`.`ADDRESS_LINE_1` AS `ADDRESS_LINE_1`,`VPEOPLEADDRESS`.`ADDRESS_LINE_2` AS `ADDRESS_LINE_2`,`VPEOPLEADDRESS`.`ADDRESS_LINE_3` AS `ADDRESS_LINE_3`,`VPEOPLEADDRESS`.`ADDRESS_TYPE` AS `ADDRESS_TYPE`,`VPEOPLEADDRESS`.`CITY` AS `CITY`,`VPEOPLEADDRESS`.`COUNTRY` AS `COUNTRY`,`VPEOPLEADDRESS`.`POSTAL_CODE` AS `POSTAL_CODE`,`VPEOPLEADDRESS`.`STATE_PROVINCE` AS `STATE_PROVINCE`,`VPEOPLEADDRESS`.`ANNIVERSARY` AS `ANNIVERSARY`,`VPEOPLEADDRESS`.`BIRTHDATE` AS `BIRTHDATE`,`VPEOPLEADDRESS`.`EMAIL` AS `EMAIL`,`VPEOPLEADDRESS`.`FIRST_NAME` AS `FIRST_NAME`,`VPEOPLEADDRESS`.`LAPSED_DONOR` AS `LAPSED_DONOR`,`VPEOPLEADDRESS`.`LAST_NAME` AS `LAST_NAME`,`VPEOPLEADDRESS`.`MAJOR_DONOR` AS `MAJOR_DONOR`,`VPEOPLEADDRESS`.`MARITAL_STATUS` AS `MARITAL_STATUS`,`VPEOPLEADDRESS`.`MIDDLE_NAME` AS `MIDDLE_NAME`,`VPEOPLEADDRESS`.`ORGANIZATION_NAME` AS `ORGANIZATION_NAME`,`VPEOPLEADDRESS`.`PREFERRED_PHONE_TYPE` AS `PREFERRED_PHONE_TYPE`,`VPEOPLEADDRESS`.`SPOUSE_FIRST_NAME` AS `SPOUSE_FIRST_NAME`,`VPEOPLEADDRESS`.`SPOUSE_NAME` AS `SPOUSE_NAME`,`VPEOPLEADDRESS`.`SUFFIX` AS `SUFFIX`,`VPEOPLEADDRESS`.`TITLE` AS `TITLE`,`VPEOPLEADDRESS`.`PERSON_ID` AS `PERSON_ID`,`VPEOPLEADDRESS`.`ADDRESS_ID` AS `ADDRESS_ID` FROM  `GIFT` JOIN `VPEOPLEADDRESS` ON  `GIFT`.`PERSON_ID` = `VPEOPLEADDRESS`.`PERSON_ID`;

-- Create vpeoplegiftdistro
CREATE VIEW VPEOPLEGIFTDISTRO AS SELECT  AUTH_CODE, CHECK_NUMBER, COMMENTS, ORIGINAL_GIFT_ID,PAYMENT_TYPE, REFUND_GIFT_ID, REFUND_GIFT_TRANSACTION_DATE, TRANSACTION_DATE, VALUE, ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, ADDRESS_TYPE, CITY, COUNTRY, POSTAL_CODE, STATE_PROVINCE, ANNIVERSARY, BIRTHDATE, EMAIL, FIRST_NAME, LAPSED_DONOR, LAST_NAME, MAJOR_DONOR, MARITAL_STATUS, MIDDLE_NAME, ORGANIZATION_NAME, PREFERRED_PHONE_TYPE, SPOUSE_FIRST_NAME, SPOUSE_NAME, SUFFIX, TITLE, VPEOPLEADDRESS.PERSON_ID, ADDRESS_ID, DISTRO_LINE.AMOUNT, DISTRO_LINE.MOTIVATION_CODE, DISTRO_LINE.PROJECT_CODE FROM GIFT LEFT JOIN DISTRO_LINE ON GIFT.GIFT_ID = DISTRO_LINE.GIFT_ID LEFT JOIN VPEOPLEADDRESS ON GIFT.PERSON_ID = VPEOPLEADDRESS.PERSON_ID;

-- Create vgiftdistro
CREATE VIEW VGIFTDISTRO AS SELECT AUTH_CODE, CHECK_NUMBER, COMMENTS, ORIGINAL_GIFT_ID,PAYMENT_TYPE, REFUND_GIFT_ID, REFUND_GIFT_TRANSACTION_DATE, TRANSACTION_DATE, VALUE, DISTRO_LINE.AMOUNT, DISTRO_LINE.MOTIVATION_CODE, DISTRO_LINE.PROJECT_CODE FROM GIFT LEFT JOIN DISTRO_LINE ON GIFT.GIFT_ID = DISTRO_LINE.GIFT_ID LEFT JOIN VPEOPLEADDRESS ON GIFT.PERSON_ID = VPEOPLEADDRESS.PERSON_ID;

