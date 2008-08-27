insert into REPORTDATASOURCE values(1,'People');
insert into REPORTDATASOURCE values(2,'Gifts');

Insert into REPORTDATASUBSOURCE values(1,'People',0,'PERSON',1);
insert into REPORTDATASUBSOURCE values(2,'People & Addresses',0,'vpeopleaddress',1);
insert into REPORTDATASUBSOURCE values(3,'People & Gifts',0,'vpeoplegift',1);
insert into REPORTDATASUBSOURCE values(4,'Gifts',0,'GIFT',2);

insert into REPORTFIELDGROUP values(1,'People General');
insert into REPORTFIELDGROUP values(2,'People Address');
insert into REPORTFIELDGROUP values(3,'People Misc.');
insert into REPORTFIELDGROUP values(4,'Gift General');
insert into REPORTFIELDGROUP values(5,'Gift Payment');

insert into REPORTFIELDGROUP_ReportDataSubSource values(1,1,1);
insert into REPORTFIELDGROUP_ReportDataSubSource values(3,1,2);
insert into REPORTFIELDGROUP_ReportDataSubSource values(1,2,3);
insert into REPORTFIELDGROUP_ReportDataSubSource values(2,2,4);
insert into REPORTFIELDGROUP_ReportDataSubSource values(3,2,5);
insert into REPORTFIELDGROUP_ReportDataSubSource values(1,3,6);
insert into REPORTFIELDGROUP_ReportDataSubSource values(2,3,7);
insert into REPORTFIELDGROUP_ReportDataSubSource values(3,3,8);
insert into REPORTFIELDGROUP_ReportDataSubSource values(4,3,9);
insert into REPORTFIELDGROUP_ReportDataSubSource values(4,4,10);

insert into REPORTFIELD values(1,b'0',b'0','FIRST_NAME','First Name',b'1',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(2,b'0',b'0','MIDDLE_NAME','Middle Name',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(3,b'0',b'0','LAST_NAME','Last Name',b'1',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(4,b'0',b'0','ANNIVERSARY','Anniversary Date',b'0',b'0',b'0',b'0',b'0',b'0',4);
insert into REPORTFIELD values(5,b'0',b'0','BIRTHDATE','Birthday',b'0',b'0',b'0',b'0',b'0',b'0',4);
insert into REPORTFIELD values(6,b'0',b'0','EMAIL','E-Mail Address',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(7,b'0',b'0','LASED_DONOR','Lapsed Donor',b'0',b'0',b'0',b'0',b'0',b'0',6);
insert into REPORTFIELD values(8,b'0',b'0','MAJOR_DONOR','Major Donor',b'0',b'0',b'0',b'0',b'0',b'0',6);
insert into REPORTFIELD values(9,b'0',b'0','MARITAL_STATUS','Marital Status',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(10,b'0',b'0','ORGANIZATION_NAME','Organization',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(11,b'0',b'0','PREFERRED_PHONE_TYPE','Preferred Phone Type',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(12,b'0',b'0','SPOUSE_FIRST_NAME','Spouse First Name',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(13,b'0',b'0','SPOUSE_Name','Spouse Name',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(14,b'0',b'0','SUFFIX','Suffix',b'0',b'0',b'0',b'0',b'0',b'0',1);
insert into REPORTFIELD values(15,b'0',b'0','TITLE','Title',b'0',b'0',b'0',b'0',b'0',b'0',1);
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


-- Title in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(15,1,1,15); 
-- First Name in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(1,1,2,1); 
-- Middle Name in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(2,1,3,2); 
-- Last Name in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(3,1,4,3); 
-- Suffix in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(14,1,5,14); 
-- Organization in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(10,1,6,10); 
-- E-mail in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(6,1,7,6); 
-- Anniversary in People Misc.
insert into REPORTFIELD_REPORTFIELDGROUP values(4,3,8,4); 
-- BirthDate in People Misc.
insert into REPORTFIELD_REPORTFIELDGROUP values(5,3,9,5); 
-- Spouse First Name in People Misc.
insert into REPORTFIELD_REPORTFIELDGROUP values(12,3,10,12); 
-- Spouse Name in People Misc.
insert into REPORTFIELD_REPORTFIELDGROUP values(13,3,11,13); 
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

-- Create vpeopleaddress
create view vpeopleaddress as select `address`.`ADDRESS_LINE_1` AS `ADDRESS_LINE_1`,`address`.`ADDRESS_LINE_2` AS `ADDRESS_LINE_2`,`address`.`ADDRESS_LINE_3` AS `ADDRESS_LINE_3`,`address`.`ADDRESS_TYPE` AS `ADDRESS_TYPE`,`address`.`CITY` AS `CITY`,`address`.`COUNTRY` AS `COUNTRY`,`address`.`POSTAL_CODE` AS `POSTAL_CODE`,`address`.`STATE_PROVINCE` AS `STATE_PROVINCE`,`person`.`ANNIVERSARY` AS `ANNIVERSARY`,`person`.`BIRTHDATE` AS `BIRTHDATE`,`person`.`EMAIL` AS `EMAIL`,`person`.`FIRST_NAME` AS `FIRST_NAME`,`person`.`LAPSED_DONOR` AS `LAPSED_DONOR`,`person`.`LAST_NAME` AS `LAST_NAME`,`person`.`MAJOR_DONOR` AS `MAJOR_DONOR`,`person`.`MARITAL_STATUS` AS `MARITAL_STATUS`,`person`.`MIDDLE_NAME` AS `MIDDLE_NAME`,`person`.`ORGANIZATION_NAME` AS `ORGANIZATION_NAME`,`person`.`PREFERRED_PHONE_TYPE` AS `PREFERRED_PHONE_TYPE`,`person`.`SPOUSE_FIRST_NAME` AS `SPOUSE_FIRST_NAME`,`person`.`SPOUSE_NAME` AS `SPOUSE_NAME`,`person`.`SUFFIX` AS `SUFFIX`,`person`.`TITLE` AS `TITLE`,`person`.`PERSON_ID` AS `PERSON_ID`,`address`.`ADDRESS_ID` AS `ADDRESS_ID` from   `person_address` join `person` on  `person_address`.`PERSON_ID` = `person`.`PERSON_ID`    join `address` on  `address`.`ADDRESS_ID` = `person_address`.`ADDRESS_ID`

-- Create vpeoplegift
create view vpeoplegift as select `gift`.`ACH_ACCOUNT_NUMBER` AS `ACH_ACCOUNT_NUMBER`,`gift`.`ACH_ROUTING_NUMBER` AS `ACH_ROUTING_NUMBER`,`gift`.`ACH_TYPE` AS `ACH_TYPE`,`gift`.`AUTH_CODE` AS `AUTH_CODE`,`gift`.`CHECK_NUMBER` AS `CHECK_NUMBER`,`gift`.`COMMENTS` AS `COMMENTS`,`gift`.`CREDIT_CARD_EXPIRATION_DATE` AS `CREDIT_CARD_EXPIRATION_DATE`,`gift`.`CREDIT_CARD_NUMBER` AS `CREDIT_CARD_NUMBER`,`gift`.`CREDIT_CARD_TYPE` AS `CREDIT_CARD_TYPE`,`gift`.`ORIGINAL_GIFT_ID` AS `ORIGINAL_GIFT_ID`,`gift`.`PAYMENT_TYPE` AS `PAYMENT_TYPE`,`gift`.`REFUND_GIFT_ID` AS `REFUND_GIFT_ID`,`gift`.`REFUND_GIFT_TRANSACTION_DATE` AS `REFUND_GIFT_TRANSACTION_DATE`,`gift`.`TRANSACTION_DATE` AS `TRANSACTION_DATE`,`gift`.`VALUE` AS `VALUE`,`vpeopleaddress`.`ADDRESS_LINE_1` AS `ADDRESS_LINE_1`,`vpeopleaddress`.`ADDRESS_LINE_2` AS `ADDRESS_LINE_2`,`vpeopleaddress`.`ADDRESS_LINE_3` AS `ADDRESS_LINE_3`,`vpeopleaddress`.`ADDRESS_TYPE` AS `ADDRESS_TYPE`,`vpeopleaddress`.`CITY` AS `CITY`,`vpeopleaddress`.`COUNTRY` AS `COUNTRY`,`vpeopleaddress`.`POSTAL_CODE` AS `POSTAL_CODE`,`vpeopleaddress`.`STATE_PROVINCE` AS `STATE_PROVINCE`,`vpeopleaddress`.`ANNIVERSARY` AS `ANNIVERSARY`,`vpeopleaddress`.`BIRTHDATE` AS `BIRTHDATE`,`vpeopleaddress`.`EMAIL` AS `EMAIL`,`vpeopleaddress`.`FIRST_NAME` AS `FIRST_NAME`,`vpeopleaddress`.`LAPSED_DONOR` AS `LAPSED_DONOR`,`vpeopleaddress`.`LAST_NAME` AS `LAST_NAME`,`vpeopleaddress`.`MAJOR_DONOR` AS `MAJOR_DONOR`,`vpeopleaddress`.`MARITAL_STATUS` AS `MARITAL_STATUS`,`vpeopleaddress`.`MIDDLE_NAME` AS `MIDDLE_NAME`,`vpeopleaddress`.`ORGANIZATION_NAME` AS `ORGANIZATION_NAME`,`vpeopleaddress`.`PREFERRED_PHONE_TYPE` AS `PREFERRED_PHONE_TYPE`,`vpeopleaddress`.`SPOUSE_FIRST_NAME` AS `SPOUSE_FIRST_NAME`,`vpeopleaddress`.`SPOUSE_NAME` AS `SPOUSE_NAME`,`vpeopleaddress`.`SUFFIX` AS `SUFFIX`,`vpeopleaddress`.`TITLE` AS `TITLE`,`vpeopleaddress`.`PERSON_ID` AS `PERSON_ID`,`vpeopleaddress`.`ADDRESS_ID` AS `ADDRESS_ID` from  `gift` join `vpeopleaddress` on  `gift`.`PERSON_ID` = `vpeopleaddress`.`PERSON_ID`

