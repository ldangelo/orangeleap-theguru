insert into ReportDataSource values(1,'People');


Insert into ReportDataSubSource values(1,'People',0,'PERSON',1);

insert into REPORTFIELDGROUP values(1,'People General');
insert into REPORTFIELDGROUP values(2,'People Address');
insert into REPORTFIELDGROUP values(3,'People Misc.');
insert into REPORTFIELDGROUP values(4,'Gift General');
insert into REPORTFIELDGROUP values(5,'Gift Payment');

insert into REPORTFIELDGROUP_ReportDataSubSource values(1,1,1);
insert into REPORTFIELDGROUP_ReportDataSubSource values(3,1,2);


insert into REPORTFIELD values(1,b'0',b'0','FIRST_NAME','First Name',b'1',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(2,b'0',b'0','MIDDLE_NAME','Middle Name',b'0',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(3,b'0',b'0','LAST_NAME','Last Name',b'1',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(4,b'0',b'0','ANNIVERSARY','Anniversary Date',b'0',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(5,b'0',b'0','BIRTHDATE','Birthday',b'0',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(6,b'0',b'0','EMAIL','E-Mail Address',b'0',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(7,b'0',b'0','LASED_DONOR','Lapsed Donor',b'0',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(8,b'0',b'0','MAJOR_DONOR','Major Donor',b'0',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(9,b'0',b'0','MARITAL_STATUS','Marital Status',b'0',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(10,b'0',b'0','ORGANIZATION_NAME','Organization',b'0',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(11,b'0',b'0','PREFERRED_PHONE_TYPE','Preferred Phone Type',b'0',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(12,b'0',b'0','SPOUSE_FIRST_NAME','Spouse First Name',b'0',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(13,b'0',b'0','SPOUSE_Name','Spouse Name',b'0',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(14,b'0',b'0','SUFFIX','Suffix',b'0',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(15,b'0',b'0','TITLE','Title',b'0',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(17,b'0',b'0','ADDRESS_LINE_1','Address Line 1',b'1',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(18,b'0',b'0','ADDRESS_LINE_2','Address Line 2',b'0',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(19,b'0',b'0','ADDRESS_LINE_3','Address Line 3',b'0',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(20,b'0',b'0','ADDRESS_TYPE','Address Type',b'0',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(21,b'0',b'0','CITY','City',b'1',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(22,b'0',b'0','COUNTRY','Country',b'1',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(23,b'0',b'0','POSTAL_CODE','Zip Code',b'1',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(24,b'0',b'0','STATE_PROVINCE','State',b'1',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(25,b'0',b'0','TRANSACTION_DATE','Date',b'1',b'0',b'0',b'0',b'0',b'0',0);
insert into REPORTFIELD values(26,b'0',b'0','VALUE','Gift Amount',b'1',b'0',b'0',b'0',b'0',b'0',0);



insert into REPORTFIELD_REPORTFIELDGROUP values(15,1,1,15); -- Title in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(1,1,2,1); -- First Name in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(2,1,3,2); -- Middle Name in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(3,1,4,3); -- Last Name in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(14,1,5,14); -- Suffix in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(10,1,6,10); -- Organization in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(6,1,7,6); -- E-mail in People General
insert into REPORTFIELD_REPORTFIELDGROUP values(4,3,8,4); -- Anniversary in People Misc.
insert into REPORTFIELD_REPORTFIELDGROUP values(5,3,9,5); -- BirthDate in People Misc.
insert into REPORTFIELD_REPORTFIELDGROUP values(12,3,10,12); -- Spouse First Name in People Misc.
insert into REPORTFIELD_REPORTFIELDGROUP values(13,3,11,13); -- Spouse Name in People Misc.
insert into REPORTFIELD_REPORTFIELDGROUP values(17,2,12,17); -- Address Line 1 in People Address
insert into REPORTFIELD_REPORTFIELDGROUP values(18,2,13,18); -- Address Line 2 in People Address
insert into REPORTFIELD_REPORTFIELDGROUP values(19,2,14,19); -- Address Line 3 in People Address
insert into REPORTFIELD_REPORTFIELDGROUP values(20,2,15,20); -- Address Type in People Address
insert into REPORTFIELD_REPORTFIELDGROUP values(21,2,16,21); -- City in People Address
insert into REPORTFIELD_REPORTFIELDGROUP values(22,2,17,22); -- Country in People Address
insert into REPORTFIELD_REPORTFIELDGROUP values(23,2,18,23); -- Postal Code in People Address
insert into REPORTFIELD_REPORTFIELDGROUP values(25,4,19,25); -- Transaction date into gift general
insert into REPORTFIELD_REPORTFIELDGROUP values(26,4,19,26); -- Gift Amount into gift general

