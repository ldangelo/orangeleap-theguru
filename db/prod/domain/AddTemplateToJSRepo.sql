/*
*
* This script updates the Jasperserver repository with a new mpower landscape report template.
*
*/



-- ******************JIResourceFolder****************
-- @maxId =
SELECT @maxId := MAX(id)+1 FROM JIResourceFolder;
-- PARENTFOLDER =
SELECT @parentId := id FROM `jasperserver`.`JIResourceFolder`where uri = '/templates';

insert into JIResourceFolder values(@maxId,0, '/templates/mpower_report_template_landscape_files', b'1', 'mpower_report_template_landscape_files', 'mpower report template landscape', 'Template for Landscape reports.', @parentId, '2008-10-21 10:28:10');

-- PARENTFOLDER FK references JIResourceFolder (id)






-- *******************JIResource*******************
-- @maxId =
SELECT @maxId := MAX(id)+1 FROM JIResource;
-- PARENT FOLDER =
SELECT @parentId := id FROM `jasperserver`.`JIResourceFolder`where uri = '/templates';
-- CHILDERNFOLDER =
SELECT @childId := id FROM `jasperserver`.`JIResourceFolder`where uri = '/templates/mpower_report_template_landscape_files';

insert into JIResource values(@maxId, 0,'mpower_report_template_landscape_jrxml', @childId, null, 'Main jrxml', 'Main jrxml', '2008-10-21 10:28:10');
insert into JIResource values(@maxId + 1, 0,'mpower_report_template_landscape', @parentId, @childId, 'mpower report template landscape', null, '2008-10-21 10:28:10');

-- PARENTFOLDER and CHILDRENFOLDER FK references JIResourceFolder (id)





-- *****************JIFileResource******************
-- ID =
SELECT @id := id FROM JIResource WHERE name = 'mpower_report_template_landscape_jrxml';

insert into JIFileResource values(@id,
'<?xml version="1.0" encoding="UTF-8"  ?>
<!-- Created with iReport - A designer for JasperReports -->
<!DOCTYPE jasperReport PUBLIC "//JasperReports//DTD Report Design//EN" "http://jasperreports.sourceforge.net/dtds/jasperreport.dtd">
<jasperReport
		 name="mpower_report_template"
		 columnCount="1"
		 printOrder="Vertical"
		 orientation="Landscape"
		 pageWidth="842"
		 pageHeight="595"
		 columnWidth="535"
		 columnSpacing="0"
		 leftMargin="30"
		 rightMargin="30"
		 topMargin="20"
		 bottomMargin="20"
		 whenNoDataType="NoPages"
		 isTitleNewPage="false"
		 isSummaryNewPage="false">
	<property name="ireport.scriptlethandling" value="0" />
	<property name="ireport.encoding" value="UTF-8" />
	<import value="java.util.*" />
	<import value="net.sf.jasperreports.engine.*" />
	<import value="net.sf.jasperreports.engine.data.*" />

	<style
		name="detail"
		hAlign="Left"
		fontName="Arial"
		fontSize="14"
	>
	</style>
	<style 
		name="header"
		mode="Opaque"
		forecolor="#FFFFFF"
		backcolor="#666666"
		hAlign="Left"
		vAlign="Middle"
		bottomBorder="1Point"
		fontName="Arial"
		fontSize="14"
		isBold="true"
		isItalic="false"
	>
					<box>					<pen lineWidth="0.75" lineStyle="Solid" lineColor="#000000"/>
					<topPen lineWidth="0.0" lineStyle="Solid" lineColor="#000000"/>
					<leftPen lineWidth="0.0" lineStyle="Solid" lineColor="#000000"/>
					<bottomPen lineWidth="0.75" lineStyle="Solid" lineColor="#000000"/>
					<rightPen lineWidth="0.0" lineStyle="Solid" lineColor="#000000"/>
</box>
	</style>
	<style 
		name="headerVariables"
		hAlign="Left"
		vAlign="Middle"
		bottomBorder="1Point"
		fontName="Arial"
		fontSize="14"
		isBold="true"
	>
	</style>
	<style 
		name="titleStyle"
		fontName="Verdana"
		fontSize="18"
		isBold="true"
	>
	</style>
	<style 
		name="importeStyle"
		hAlign="Right"
	>
	</style>
	<style 
		name="oddRowStyle"
		mode="Opaque"
		backcolor="#CCCCCC"
	>
	</style>


		<background>
			<band height="0"  isSplitAllowed="true" >
			</band>
		</background>
		<title>
			<band height="34"  isSplitAllowed="true" >
			</band>
		</title>
		<pageHeader>
			<band height="95"  isSplitAllowed="true" >
				<image  evaluationTime="Now" hyperlinkType="None"  hyperlinkTarget="Self" >
					<reportElement
						x="0"
						y="0"
						width="251"
						height="87"
						key="image-1"
						stretchType="RelativeToBandHeight"
						isPrintInFirstWholeBand="true"/>
					<box></box>
					<graphicElement stretchType="RelativeToBandHeight"/>
					<imageExpression class="java.lang.String"><![CDATA["repo:/Images/mpowerLogo.gif"]]></imageExpression>
				</image>
			</band>
		</pageHeader>
		<columnHeader>
			<band height="30"  isSplitAllowed="true" >
			</band>
		</columnHeader>
		<detail>
			<band height="100"  isSplitAllowed="true" >
			</band>
		</detail>
		<columnFooter>
			<band height="30"  isSplitAllowed="true" >
			</band>
		</columnFooter>
		<pageFooter>
			<band height="50"  isSplitAllowed="true" >
			</band>
		</pageFooter>
		<lastPageFooter>
			<band height="50"  isSplitAllowed="true" >
			</band>
		</lastPageFooter>
		<summary>
			<band height="50"  isSplitAllowed="true" >
			</band>
		</summary>
</jasperReport>
'
, 'jrxml', null);

-- BLOB is a byte array of the report template file

-- FK on id that references JIResource (id);





-- *********************JIReportUnit*****************
-- ID =
SELECT @id := id FROM JIResource WHERE name = 'mpower_report_template_landscape';
-- REPORTDATASOURCE =
SELECT @rdsId := id FROM `jasperserver`.`JIResource` WHERE name = 'ReportWizardJdbcDS';
-- MAINREPORT =
SELECT @mainReportId := id FROM JIResource WHERE name = 'mpower_report_template_landscape_jrxml';

insert into JIReportUnit values (@id, @rdsId,null, @mainReportId, '', '', b'0', 1);

-- FK on (reportDataSource) references JIResource (id);
-- FK on (mainReport) references JIFileResource (id);
-- FK on (id) references JIResource (id);






-- *******************JIReportUnitresource***********
-- Do not need to insert into this table for this template update











