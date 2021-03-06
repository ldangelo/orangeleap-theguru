PRINT '-- Account has the specified code type'
PRINT 'INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)'
PRINT 'SELECT 100, ''Codes - Account has a code type of [CODETYPE] with any code value'','
PRINT '''EXISTS (SELECT * FROM ENTITYCODES WHERE ENTITYCODES.ENTITYID = [VIEWNAME].ENTITY_ENTITYID AND CODETYPE = ''''{0}'''')'','
PRINT '''Codes - Account has a code type of <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0].criteria" value="{0}" /> with any code value'';'
PRINT ''
PRINT '-- Account has one of the specified codes'
PRINT 'INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)'
PRINT 'SELECT 200, ''Codes - Account has a code type of [CODETYPE] <br>with any of the following code values : [CODEVALUE], [CODEVALUE], [CODEVALUE], [CODEVALUE], or [CODEVALUE]'','
PRINT '''EXISTS (SELECT * FROM ENTITYCODES WHERE ENTITYCODES.ENTITYID = [VIEWNAME].ENTITY_ENTITYID AND CODETYPE = ''''{0}'''' AND CODEVALUE IN (''''{1}'''', ''''{2}'''', ''''{3}'''', ''''{4}'''', ''''{5}''''))'','
PRINT '''Codes - Account has a code type of <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0].criteria" value="{0}" /> with any of the following code values : <br/> <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1].criteria" value="{1}" /> <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[2].criteria" value="{2}" /> <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[3].criteria" value="{3}" /> <BR> <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[4].criteria" value="{4}" /> <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[5].criteria"  value="{5}" > <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[6].criteria" value="{6}" />'';'
PRINT ''
PRINT '-- Gift total in a particular year'
PRINT 'INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)'
PRINT 'SELECT 300, ''Gift Totals - Account gave at least $[GIFTAMOUNT] in hard gifts in calendar year [GIFTYEAR]'','
PRINT '''((SELECT SUM(AMT) FROM GIFTHEADER WHERE GIFTHEADER.ENTITYID = [VIEWNAME].ENTITY_ENTITYID AND YEAR(GDATE) = {1}) >= {0})'','
PRINT '''Gift Totals - Account gave at least $<span class="criteriaWrapper"><input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0].criteria" value="{0}"style="width:75px" fieldtype="MONEY" /></span> in hard gifts in calendar year <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1].criteria" value="{1}" style="width:75px" />'';'
PRINT ''
PRINT '-- Gift total in date range'
PRINT 'INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)'
PRINT 'SELECT 350, ''Gift Totals - Account gave at least $[GIFTAMOUNT] in hard gifts between [GIFTDATE] and [GIFTDATE]'','
PRINT '''((SELECT SUM(AMT) FROM GIFTHEADER WHERE GIFTHEADER.ENTITYID = [VIEWNAME].ENTITY_ENTITYID AND GDATE BETWEEN {1} AND {2}) >= {0})'','
PRINT '''Gift Totals - Account gave at least <span class="criteriaWrapper">$<input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0].criteria" value="{0}" style="width:100px" fieldtype="MONEY" /></span> in hard gifts <br>between <span class="criteriaWrapper"><input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1].criteria" fieldtype="DATE" value="{1}" style="width:110px"/></span> and <span class="criteriaWrapper"><input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[2].criteria" fieldtype="DATE" value="{2}" style="width:110px"/></span>'';'
PRINT ''
PRINT 'INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)'
PRINT 'SELECT 390, ''Pledge Codes - Account has an active or fulfilled pledge code of [PLEDGECODE]'','
PRINT '''EXISTS (SELECT * FROM GIFTPLEDGE WHERE GIFTPLEDGE.ENTITYID = [VIEWNAME].ENTITY_ENTITYID AND PLDGCODE = ''''{0}'''' AND STATUS IN (''''A'''',''''F''''))'','
PRINT '''Pledge Codes - Account has an active or fulfilled pledge code of <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0].criteria" value="{0}" />'';'
PRINT ''
PRINT '-- Account is in a segmentation'
PRINT 'INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)'
PRINT 'SELECT 400, ''Segmentation - Account is in segmentation job number [JOBNUMBER] and group number [GROUPNUMBER]'','
PRINT '''EXISTS (SELECT * FROM S{0}G{1} SEGTABLE WHERE SEGTABLE.ENTITYID = [VIEWNAME].ENTITY_ENTITYID)'','
PRINT '''Segmentation - Account is in segmentation job number <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0].criteria" value="{0}" /> <br> and group number <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1].criteria" value="{1}" />'';'
PRINT ''
PRINT '-- Account is in a merge job'
PRINT 'INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)'
PRINT 'SELECT 500, ''Segmentation - Account is in merge job number [JOBNUMBER]'','
PRINT '''EXISTS (SELECT * FROM M{0} SEGTABLE WHERE SEGTABLE.ENTITYID = [VIEWNAME].ENTITY_ENTITYID)'','
PRINT '''Segmentation - Account is in merge job number <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0].criteria" value="{0}" />'';'
PRINT ''
PRINT '-- Account is in the Guru segmentation'
PRINT 'INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)'
PRINT 'SELECT 550, ''The Guru Segmentation - Account is in the Guru segmentation / report'','
PRINT '''EXISTS (SELECT * FROM THEGURU_SEGMENTATION_RESULT SEGTABLE WHERE SEGTABLE.REPORT_ID = {0} AND SEGTABLE.ENTITY_ID = [VIEWNAME].ENTITY_ENTITYID)'','
PRINT '''The Guru Segmentation - Account is in segmentation / report <br> {lookupReferenceBean:mpxAccountSegmentationList}'';'
PRINT ''
PRINT '-- Zip Radius'
PRINT 'INSERT INTO REPORTCUSTOMFILTERDEFINITION (REPORTCUSTOMFILTERDEFINITION_ID, DISPLAY_TEXT, SQL_TEXT, DISPLAY_HTML)'
PRINT 'SELECT 600, ''Zip Radius - Account is within [ZIPRADIUS] miles of zip code [ZIPCODE]'','
PRINT '''(CONVERT(VARCHAR(5), [VIEWNAME].ENTITY_POSTALCODE) IN (SELECT TOZIP.ZIPLOW AS POSTALCODE FROM ZIPCODES TOZIP CROSS JOIN (SELECT * FROM ZIPCODES FROMZIP WHERE FROMZIP.ZIPLOW = ''''{1}'''') FROMZIP WHERE SQRT(((69.1 * (TOZIP.LATITUDE - FROMZIP.LATITUDE)) * (69.1 * (TOZIP.LATITUDE - FROMZIP.LATITUDE))) + ((53 * (TOZIP.LONGITUDE - FROMZIP.LONGITUDE)) * (53 * (TOZIP.LONGITUDE - FROMZIP.LONGITUDE)))) <= {0}))'','
PRINT '''Zip Radius - Account is within <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[0].criteria" style="width:75px" value="{0}" /> miles of zip code <input class="customCriteria" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[1].criteria" style="width:100px" value="{1}" />'';'
PRINT ''
PRINT ''

PRINT '-- INSERT INTO REPORTDATASOURCE'
PRINT 'INSERT INTO REPORTDATASOURCE'
PRINT '	(REPORT_NAME)'
PRINT 'VALUES'
PRINT '	(''MPX v10.2.3442'');'
PRINT ''
PRINT 'SET @REPORTDATASOURCE_ID = LAST_INSERT_ID();'
PRINT ''

DECLARE @TABLENAME varchar(50), @SubSourceGroup VarChar(100), @PreviousSubSourceGroup VarChar(100), @SubSourceDescription VarChar(255),
	@PrimaryKey VarChar(255)
Set @PreviousSubSourceGroup = ''
Declare @CRLF as VarChar(50)
Set @CRLF = Char(13) + Char(10)

Declare viewCursor Cursor For
Select Name From SysObjects Where Name Like 'VW_REPORT%' And Xtype = 'V'
And Name Not In ('VW_REPORT_GIFTHEADERCOMBINED', 'VW_REPORT_PEOPLE_TRANSACTIONS_BASE')
Order By
ISNULL((SELECT SUBSOURCEGROUP FROM DATADICTIONARY WHERE TABLENAME = Name AND COLUMNNAME IS NULL),''),
ISNULL((SELECT DESCRIPTION FROM DATADICTIONARY WHERE TABLENAME = Name AND COLUMNNAME IS NULL),'')

Open viewCursor
Fetch Next From viewCursor Into @TABLENAME
While @@Fetch_Status = 0
Begin
	DECLARE @DISPLAYNAME varchar(100)
	-- SET @DISPLAYNAME = ISNULL((SELECT DESCRIPTION FROM DATADICTIONARY WHERE TABLENAME = @TABLENAME AND COLUMNNAME IS NULL),'')

	SELECT
		@DISPLAYNAME = ISNULL(DESCRIPTION, ''),
		@SubSourceGroup = ISNULL(SubSourceGroup, ''),
		@SubSourceDescription = ISNULL(LongDescription, '')
	FROM DATADICTIONARY WHERE TABLENAME = @TABLENAME AND COLUMNNAME IS NULL

	IF LEN(@DISPLAYNAME) = 0
	BEGIN
		CONTINUE
		Fetch Next From viewCursor Into @TABLENAME
	END
		--SET @DISPLAYNAME = dbo.pCase_Extended((SELECT Replace(Replace(@TABLENAME, 'VW_REPORT_',''), '_', ' ')))

	IF @SubSourceGroup <> @PreviousSubSourceGroup
	BEGIN
		PRINT 'INSERT INTO REPORTDATASUBSOURCEGROUP'
		PRINT '	(DESCRIPTION, DISPLAY_NAME, reportDataSource_REPORTSOURCE_ID)'
		PRINT 'VALUES'
		PRINT '	(''' + @SubSourceGroup + ''', ''' + @SubSourceGroup + ''', @REPORTDATASOURCE_ID);'
		PRINT ''
		PRINT 'SET @REPORTDATASUBSOURCEGROUP_ID = LAST_INSERT_ID();'
		PRINT ''
		SET @PreviousSubSourceGroup = @SubSourceGroup
	END

	DECLARE @REPORTDATASUBSOURCE VARCHAR(8000)
	DECLARE @REPORTFIELDGROUP VARCHAR(8000)
	DECLARE @REPORTFIELDGROUP_REPORTDATASUBSOURCE VARCHAR(8000)
	DECLARE @INSERTREPORTFIELD VARCHAR(8000)
	DECLARE @REPORTFIELD_REPORTFIELDGROUP VARCHAR(8000)
	DECLARE @FIELDNAME VARCHAR(100), @TEMPFIELDNAME VARCHAR(100)
	DECLARE @FIELDTYPE VARCHAR(100)
	DECLARE @FieldGroup VarChar(100), @CurrentFieldGroup VarChar(100), @CurrentFieldName VarChar(100)
	Set @CurrentFieldGroup = ''

	DECLARE CSR CURSOR FOR
	SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TABLENAME

	OPEN CSR

	-- Insert REPORTDATASUBSOURCE
	PRINT '-- Insert REPORTDATASUBSOURCE'
	SET @REPORTDATASUBSOURCE = 'INSERT REPORTDATASUBSOURCE' + @CRLF +
		'  (REPORTSUBSOURCE_ID, DATABASE_TYPE, DISPLAY_NAME, DESCRIPTION, JASPER_DATASOURCE_NAME, SEGMENTATION_RESULTS_DATASOURCE_NAME, REPORT_FORMAT_TYPE, VIEW_NAME, reportDataSubSourceGroup_REPORTSUBSOURCEGROUP_ID)' + @CRLF +
		'VALUES ' + @CRLF + '  (NULL, 1, ''' + @DISPLAYNAME + ''', ''' + @SubSourceDescription + ''', ''/datasources/ReportWizardJdbcDSForMPX'', ''/datasources/ReportWizardJdbcDSForMPX'', 1, ''' + @TABLENAME + ''', @REPORTDATASUBSOURCEGROUP_ID);' + @CRLF + @CRLF +
		'SET @REPORTSUBSOURCE_ID = LAST_INSERT_ID();' + @CRLF + @CRLF

	PRINT @REPORTDATASUBSOURCE

	FETCH NEXT FROM CSR INTO @FIELDNAME, @FIELDTYPE
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @TEMPFIELDNAME = @FIELDNAME
		DECLARE @PREFIX VARCHAR(20)
		SET @PREFIX = ''
		IF @TABLENAME In ('VW_REPORT_PEOPLE_TRANSACTIONS', 'VW_REPORT_GIFTS', 'VW_REPORT_ORDERS',
		'VW_REPORT_PEOPLE_GIFTS', 'VW_REPORT_PEOPLE_ORDERS')
		BEGIN
			IF @TABLENAME = 'VW_REPORT_PEOPLE_TRANSACTIONS' AND CHARINDEX('GIFT_', @TEMPFIELDNAME) > 0
				SET @PREFIX = 'Gift - '
			IF @TABLENAME = 'VW_REPORT_PEOPLE_TRANSACTIONS' AND CHARINDEX('ORDER_', @TEMPFIELDNAME) > 0
				SET @PREFIX = 'Order - '

			SET @TEMPFIELDNAME = Replace(@TEMPFIELDNAME, 'GIFT_', '')
			SET @TEMPFIELDNAME = Replace(@TEMPFIELDNAME, 'ORDER_', '')
		END

		IF @TABLENAME In ('VW_REPORT_PEOPLE_ORDERSUMMARY', 'VW_REPORT_PEOPLE_GIFTSUMMARY', 'VW_REPORT_PEOPLE_GIFTANNUAL', 'VW_REPORT_PEOPLE_ORDERANNUAL')
		BEGIN
			IF CHARINDEX('HEADER_LARGE', @TEMPFIELDNAME) > 0 AND CHARINDEX('GIFT', @TEMPFIELDNAME) > 0
				SET @PREFIX = 'Large Gift - '
			IF CHARINDEX('HEADER_LAST', @TEMPFIELDNAME) > 0 AND CHARINDEX('GIFT', @TEMPFIELDNAME) > 0
				SET @PREFIX = 'Last Gift - '
			IF CHARINDEX('HEADER_FIRST', @TEMPFIELDNAME) > 0 AND CHARINDEX('GIFT', @TEMPFIELDNAME) > 0
				SET @PREFIX = 'First Gift - '
			IF CHARINDEX('HEADER_LARGE', @TEMPFIELDNAME) > 0 AND CHARINDEX('ORDER', @TEMPFIELDNAME) > 0
				SET @PREFIX = 'Large Order - '
			IF CHARINDEX('HEADER_LAST', @TEMPFIELDNAME) > 0 AND CHARINDEX('ORDER', @TEMPFIELDNAME) > 0
				SET @PREFIX = 'Last Order - '
			IF CHARINDEX('HEADER_FIRST', @TEMPFIELDNAME) > 0 AND CHARINDEX('ORDER', @TEMPFIELDNAME) > 0
				SET @PREFIX = 'First Order - '
		END

		SET @CURRENTFIELDNAME = ISNULL((SELECT DESCRIPTION FROM DATADICTIONARY WHERE TABLENAME = @TABLENAME AND COLUMNNAME = @FIELDNAME),'')
		SET @PrimaryKey = ISNULL((SELECT PrimaryKey FROM DATADICTIONARY WHERE TABLENAME = @TABLENAME AND COLUMNNAME = @FIELDNAME),'')
		IF (LEN(@CURRENTFIELDNAME) = 0)
		BEGIN
			FETCH NEXT FROM CSR INTO @FIELDNAME, @FIELDTYPE
			CONTINUE
		END
			--Set @CurrentFieldName = dbo.pCase_Extended(SubString(@TEMPFIELDNAME, CharIndex('_', @TEMPFIELDNAME) + 1, Len(@TEMPFIELDNAME)))
		Set @FieldGroup = @PREFIX + dbo.pCase_Extended(SubString(@TEMPFIELDNAME, 1, CharIndex('_', @TEMPFIELDNAME) - 1))

		IF (@FieldGroup <> @CurrentFieldGroup)
		BEGIN
			PRINT '-- Insert REPORTFIELDGROUP'
			SET @REPORTFIELDGROUP = 'CALL INSERTREPORTFIELDGROUP(''' + @PREFIX + ISNULL((SELECT DESCRIPTION FROM DATADICTIONARY WHERE TABLENAME = Replace(@FieldGroup, @PREFIX, '') AND COLUMNNAME IS NULL),@FieldGroup) + ''', @REPORTSUBSOURCE_ID, @REPORTFIELDGROUP_ID);'
			PRINT @REPORTFIELDGROUP + @CRLF + @CRLF
			SET @CurrentFieldGroup = @FieldGroup
			/*
			SET @REPORTFIELDGROUP = 'INSERT REPORTFIELDGROUP' + @CRLF +
				'  (REPORTFIELDGROUP_ID, NAME)'  + @CRLF + 'VALUES' + @CRLF + '  (NULL, ''' + @PREFIX + ISNULL((SELECT DESCRIPTION FROM DATADICTIONARY WHERE TABLENAME = Replace(@FieldGroup, @PREFIX, '') AND COLUMNNAME IS NULL),@FieldGroup) + ''');' + @CRLF + @CRLF +
				'SET @REPORTFIELDGROUP_ID = LAST_INSERT_ID();' + @CRLF + @CRLF
			SET @CurrentFieldGroup = @FieldGroup

			PRINT @REPORTFIELDGROUP

			PRINT '-- Insert REPORTFIELDGROUP_REPORTDATASUBSOURCE'

			SET @REPORTFIELDGROUP_REPORTDATASUBSOURCE = 'SET @MAXREPORTSUBSOURCE_ID = (SELECT IFNULL(MAX(REPORTSUBSOURCE_ID),0) + 1 FROM REPORTFIELDGROUP_REPORTDATASUBSOURCE);' + @CRLF + @CRLF +
				  'INSERT REPORTFIELDGROUP_REPORTDATASUBSOURCE' + @CRLF +
						'  (REPORTFIELDGROUP_REPORTFIELDGROUP_ID, REPORTDATASUBSOURCE_REPORTSUBSOURCE_ID, REPORTSUBSOURCE_ID)' + @CRLF +
				  'VALUES' + @CRLF + '  (@REPORTFIELDGROUP_ID, @REPORTSUBSOURCE_ID, @MAXREPORTSUBSOURCE_ID);' + @CRLF + @CRLF

			PRINT @REPORTFIELDGROUP_REPORTDATASUBSOURCE
			*/
		END

		-- Insert REPORTFIELD
		PRINT N'-- Insert ' + @CurrentFieldName
		SET @INSERTREPORTFIELD = 'CALL INSERTREPORTFIELD(''' + @PrimaryKey + ''',''' + @FIELDNAME + ''', ''' + @CurrentFieldName + ''', b''0'', ' +
		CASE
			WHEN (@FIELDTYPE in ('varchar', 'nvarchar', 'char')) THEN  '1, '
			WHEN (@FIELDTYPE in ('tinyint', 'int', 'bigint')) THEN  '2, '
			WHEN (@FIELDTYPE in ('float','real')) THEN  '3, '
			WHEN (@FIELDTYPE in ('datetime','smalldatetime')) THEN  '4, '
			WHEN (@FIELDTYPE in ('decimal','money')) THEN  '5, '
			WHEN (@FIELDTYPE = 'bit') THEN  '6, '
			ELSE '1, '
		END +
		'@REPORTFIELDGROUP_ID);'

		/*
		SET @INSERTREPORTFIELD = 'INSERT REPORTFIELD' + @CRLF +
			'  (REPORTFIELD_ID, AVERAGE, CAN_BE_SUMMARIZED, COLUMN_NAME, DISPLAY_NAME, IS_DEFAULT, IS_SUMMARIZED, LARGEST_VALUE, PERFORMSUMMARY, IS_SELECTED, SMALLEST_VALUE, RECORD_COUNT, FIELD_TYPE)' + @CRLF +
			'VALUES' + @CRLF + '  (NULL, '

	  --REPORTFIELD_ID

		--AVERAGE
		IF @FIELDTYPE IN ('MONEY','INT')
		BEGIN
			SET @INSERTREPORTFIELD = @INSERTREPORTFIELD + '1, '
		END
		ELSE
		BEGIN
			SET @INSERTREPORTFIELD = @INSERTREPORTFIELD + '0, '
		END
		--CAN_BE_SUMMARIZED
		IF @FIELDTYPE IN ('MONEY','INT')
		BEGIN
			SET @INSERTREPORTFIELD = @INSERTREPORTFIELD + '1, '
		END
		ELSE
		BEGIN
			SET @INSERTREPORTFIELD = @INSERTREPORTFIELD + '0, '
		END
		--COLUMN_NAME
		SET @INSERTREPORTFIELD = @INSERTREPORTFIELD + '''' + @FIELDNAME + ''', '
		--DISPLAY_NAME
		SET @INSERTREPORTFIELD = @INSERTREPORTFIELD + '''' + @CurrentFieldName + ''', '
		--IS_DEFAULT
		SET @INSERTREPORTFIELD = @INSERTREPORTFIELD + '0, '
		--IS_SUMMARIZED
		SET @INSERTREPORTFIELD = @INSERTREPORTFIELD + '0, '
		--LARGEST_VALUE
		SET @INSERTREPORTFIELD = @INSERTREPORTFIELD + '0, '
		--PERFORMSUMMARY
		SET @INSERTREPORTFIELD = @INSERTREPORTFIELD + '0, '
		--IS_SELECTED
		SET @INSERTREPORTFIELD = @INSERTREPORTFIELD + '0, '
		--SMALLEST_VALUE
		SET @INSERTREPORTFIELD = @INSERTREPORTFIELD + '0, '
		--RECORD_COUNT
		SET @INSERTREPORTFIELD = @INSERTREPORTFIELD + '0, ' + @CRLF;
		--FIELD_TYPE
		SET @INSERTREPORTFIELD = @INSERTREPORTFIELD +
		CASE
			WHEN (@FIELDTYPE in ('varchar', 'nvarchar', 'char')) THEN  '1); '
			WHEN (@FIELDTYPE in ('tinyint', 'int', 'bigint')) THEN  '2); '
			WHEN (@FIELDTYPE in ('float','real')) THEN  '3); '
			WHEN (@FIELDTYPE in ('datetime','smalldatetime')) THEN  '4); '
			WHEN (@FIELDTYPE in ('decimal','money')) THEN  '5); '
			WHEN (@FIELDTYPE = 'bit') THEN  '6); '
			ELSE 'UNKNOWN);'
		END

		SET @INSERTREPORTFIELD = @INSERTREPORTFIELD + @CRLF + 'SET @REPORTFIELD_ID = LAST_INSERT_ID();' + @CRLF + @CRLF
*/
		PRINT @INSERTREPORTFIELD + @CRLF + @CRLF
/*
		PRINT '-- Insert REPORTFIELD_REPORTFIELDGROUP'
		SET @REPORTFIELD_REPORTFIELDGROUP = 'INSERT REPORTFIELD_REPORTFIELDGROUP' + @CRLF +
			'  (FIELDS_REPORTFIELD_ID, REPORTFIELDGROUP_ID, REPORTFIELDGROUP_REPORTFIELDGROUP_ID, REPORTFIELD_ID)' + @CRLF +
			'VALUES' + @CRLF + '  (@REPORTFIELD_ID, @REPORTFIELDGROUP_ID, @REPORTFIELDGROUP_ID ,@REPORTFIELD_ID);' + @CRLF + @CRLF
		PRINT @REPORTFIELD_REPORTFIELDGROUP

		PRINT '-- ********************************************************************************************'
*/
	  FETCH NEXT FROM CSR INTO @FIELDNAME, @FIELDTYPE
	END

	CLOSE CSR
	DEALLOCATE CSR

	PRINT '-- ********************************************************************************************'

	Fetch Next From viewCursor Into @TABLENAME
End
Close viewCursor
Deallocate viewCursor

PRINT ''
PRINT 'UPDATE REPORTFIELDGROUP SET NAME = ''Project Code Account'' WHERE NAME = ''Projectcodeentity'';'
PRINT 'UPDATE REPORTFIELDGROUP SET NAME = ''Gift - Project Code Account'' WHERE NAME = ''Gift - Projectcodeentity'';'
PRINT 'UPDATE REPORTFIELDGROUP SET NAME = ''Gift - Project Code Account'' WHERE NAME = ''Gift - Gift - Projectcodeentity'';'
PRINT 'UPDATE REPORTFIELDGROUP SET NAME = ''Gift Detail Related Account'' WHERE NAME = ''Relatedaccountentity'';'
PRINT 'UPDATE REPORTFIELDGROUP SET NAME = ''Gift - Gift Detail Related Account'' WHERE NAME = ''Gift - Relatedaccountentity'';'
PRINT 'UPDATE REPORTFIELDGROUP SET NAME = ''Gift - Gift Detail Related Account'' WHERE NAME = ''Gift - Gift - Relatedaccountentity'';'
PRINT ''
PRINT 'INSERT REPORTCUSTOMFILTERDEFINITION_REPORTDATASUBSOURCE
SELECT REPORTCUSTOMFILTERDEFINITION_ID, REPORTDATASUBSOURCE_REPORTSUBSOURCE_ID, REPORTDATASUBSOURCE_REPORTSUBSOURCE_ID, REPORTSUBSOURCE_ID + REPORTCUSTOMFILTERDEFINITION_ID
FROM REPORTFIELDGROUP_REPORTDATASUBSOURCE
JOIN REPORTCUSTOMFILTERDEFINITION ON 1 = 1
WHERE REPORTCUSTOMFILTERDEFINITION_ID < 100000
AND REPORTFIELDGROUP_REPORTFIELDGROUP_ID IN
  (SELECT REPORTFIELDGROUP_ID FROM REPORTFIELD_REPORTFIELDGROUP
  WHERE REPORTFIELD_ID IN
    (SELECT REPORTFIELD_ID FROM REPORTFIELD
    WHERE COLUMN_NAME = ''ENTITY_ENTITYID''));'


PRINT '
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
DROP TABLE TMP2;'