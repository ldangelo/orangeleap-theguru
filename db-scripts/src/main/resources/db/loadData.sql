TRUNCATE TABLE ReportSource_ReportFieldGroup;
TRUNCATE TABLE ReportFieldGroup_ReportField;
TRUNCATE TABLE ReportField;
TRUNCATE TABLE ReportFieldGroup;
TRUNCATE TABLE ReportDataSubSource;
TRUNCATE TABLE ReportDataSource;





INSERT INTO ReportField (displayName,columnName,type,isDefault,canBeSummarized) values('First Name','FIRST_NAME',b'1',b'1',0);
INSERT INTO ReportField (displayName,columnName,type,isDefault,canBeSummarized) values('Last Name','LAST_NAME',b'1',b'1',0);
INSERT INTO ReportField (displayName,columnName,type,isDefault,canBeSummarized) values('Middle Name','MIDDLE_NAME',b'1',b'1',0);

INSERT INTO ReportFieldGroup(Name) values('Name');

INSERT INTO ReportFieldGroup_ReportField(ReportFieldGroup_id,fields_id) values(1,1);
INSERT INTO ReportFieldGroup_ReportField(ReportFieldGroup_id,fields_id) values(1,2);
INSERT INTO ReportFieldGroup_ReportField(ReportFieldGroup_id,fields_id) values(1,3);

INSERT INTO ReportDataSubSource(displayName,viewName,reportType,standardFilter,advancedFilter,rowCount) values('People','PEOPLE',0,null,null,0);
INSERT INTO ReportDataSubSource_ReportFieldGroup(ReportSource_REPORTSOURCE_ID,fieldGroups_id) values(1,1);
INSERT INTO ReportDataSource(Name) values ('People');

INSERT INTO ReportDataSource_ReportDataSubSource(ReportDataSource_REPORTSOURCE_ID,subSource_REPORTSOURCE_ID) values(1,1);

INSERT INTO ReportField (displayName,columnName,type,isDefault,canBeSummarized) values('Address 1','ADDRESS1',b'1',b'1',0);
INSERT INTO ReportField (displayName,columnName,type,isDefault,canBeSummarized) values('Address 2','ADDRESS2',b'1',b'1',0);
INSERT INTO ReportField (displayName,columnName,type,isDefault,canBeSummarized) values('Middle Name','CITY',b'1',b'1',0);

INSERT INTO ReportFieldGroup(Name) values('Address');

INSERT INTO ReportFieldGroup_ReportField(ReportFieldGroup_id,fields_id) values(2,4);
INSERT INTO ReportFieldGroup_ReportField(ReportFieldGroup_id,fields_id) values(2,5);
INSERT INTO ReportFieldGroup_ReportField(ReportFieldGroup_id,fields_id) values(2,6);
