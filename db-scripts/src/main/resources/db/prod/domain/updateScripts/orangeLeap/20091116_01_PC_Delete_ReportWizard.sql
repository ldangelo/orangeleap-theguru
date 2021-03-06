DELIMITER $$

DROP PROCEDURE IF EXISTS `DELETE_REPORTWIZARD`$$

CREATE PROCEDURE DELETE_REPORTWIZARD(REPORTWIZARDID INT)
BEGIN
	IF EXISTS (SELECT REPORTWIZARD_REPORTFILTER.REPORTWIZARD_REPORTWIZARD_ID FROM REPORTWIZARD_REPORTFILTER
		JOIN REPORTFILTER ON REPORTFILTER.REPORTFILTER_ID = REPORTWIZARD_REPORTFILTER.REPORTFILTERS_REPORTFILTER_ID
		JOIN REPORTCUSTOMFILTER ON REPORTCUSTOMFILTER.REPORTCUSTOMFILTER_ID = REPORTFILTER.REPORTCUSTOMFILTER_REPORTCUSTOMFILTER_ID
		JOIN REPORTCUSTOMFILTERDEFINITION ON REPORTCUSTOMFILTER.REPORTCUSTOMFILTERDEFINITION_ID = REPORTCUSTOMFILTERDEFINITION.REPORTCUSTOMFILTERDEFINITION_ID
		JOIN REPORTCUSTOMFILTER_REPORTCUSTOMFILTERCRITERIA ON REPORTCUSTOMFILTER_REPORTCUSTOMFILTERCRITERIA.REPORTCUSTOMFILTER_REPORTCUSTOMFILTER_ID = REPORTCUSTOMFILTER.REPORTCUSTOMFILTER_ID
		JOIN REPORTCUSTOMFILTERCRITERIA ON REPORTCUSTOMFILTERCRITERIA.REPORTCUSTOMFILTERCRITERIA_ID = REPORTCUSTOMFILTER_REPORTCUSTOMFILTERCRITERIA.REPORTCUSTOMFILTERCRITERIA_REPORTCUSTOMFILTERCRITERIA_ID
		WHERE REPORTCUSTOMFILTERDEFINITION.DISPLAY_HTML LIKE '%SEGMENTATION%'
		AND CRITERIA = REPORTWIZARDID)
	THEN
		UPDATE REPORTWIZARD SET REPORT_NAME = CONCAT(REPORT_NAME, ' (Deleted)')
    WHERE REPORTWIZARD_ID = REPORTWIZARDID
    AND REPORT_NAME NOT LIKE '% (Deleted)';
	ELSE
		-- Delete chart settings
		DROP TABLE IF EXISTS TEMP_REPORTCHARTSETTINGS;

		CREATE TEMPORARY TABLE TEMP_REPORTCHARTSETTINGS
		SELECT reportChartSettings_REPORTCHARTSETTINGS_ID FROM REPORTWIZARD_REPORTCHARTSETTINGS WHERE REPORTWIZARD_REPORTWIZARD_ID = REPORTWIZARDID;

		DELETE FROM REPORTWIZARD_REPORTCHARTSETTINGS WHERE REPORTWIZARD_REPORTWIZARD_ID = REPORTWIZARDID;

		DELETE FROM REPORTCHARTSETTINGS WHERE REPORTCHARTSETTINGS_ID IN
		(SELECT reportChartSettings_REPORTCHARTSETTINGS_ID FROM TEMP_REPORTCHARTSETTINGS);

		DROP TABLE IF EXISTS TEMP_REPORTCHARTSETTINGS;

		-- Delete filters
		DROP TABLE IF EXISTS TEMP_REPORTFILTER;

		CREATE TEMPORARY TABLE TEMP_REPORTFILTER
		SELECT REPORTFILTER_ID, reportCustomFilter_REPORTCUSTOMFILTER_ID, reportStandardFilter_REPORTSTANDARDFILTER_ID
		FROM REPORTFILTER WHERE REPORTFILTER_ID IN
		(SELECT reportFilters_REPORTFILTER_ID FROM REPORTWIZARD_REPORTFILTER WHERE REPORTWIZARD_REPORTWIZARD_ID = REPORTWIZARDID);

		DELETE FROM REPORTWIZARD_REPORTFILTER WHERE REPORTWIZARD_REPORTWIZARD_ID = REPORTWIZARDID;

		DELETE FROM REPORTFILTER WHERE REPORTFILTER_ID IN
		(SELECT REPORTFILTER_ID FROM TEMP_REPORTFILTER);

		DELETE FROM REPORTSTANDARDFILTER WHERE REPORTSTANDARDFILTER_ID IN
		(SELECT reportStandardFilter_REPORTSTANDARDFILTER_ID FROM TEMP_REPORTFILTER);

		DELETE FROM REPORTCUSTOMFILTER_REPORTCUSTOMFILTERCRITERIA WHERE REPORTCUSTOMFILTER_REPORTCUSTOMFILTER_ID IN
		(SELECT reportCustomFilter_REPORTCUSTOMFILTER_ID FROM TEMP_REPORTFILTER);

		DELETE FROM REPORTCUSTOMFILTERCRITERIA WHERE REPORTCUSTOMFILTERCRITERIA_ID IN
		(SELECT reportCustomFilterCriteria_REPORTCUSTOMFILTERCRITERIA_ID FROM REPORTCUSTOMFILTER_REPORTCUSTOMFILTERCRITERIA WHERE REPORTCUSTOMFILTER_REPORTCUSTOMFILTER_ID IN
		(SELECT reportCustomFilter_REPORTCUSTOMFILTER_ID FROM TEMP_REPORTFILTER));

		DELETE FROM REPORTCUSTOMFILTER WHERE REPORTCUSTOMFILTER_ID IN
		(SELECT reportCustomFilter_REPORTCUSTOMFILTER_ID FROM TEMP_REPORTFILTER);

		DROP TABLE IF EXISTS TEMP_REPORTFILTER;


		-- Delete selected fields
		DROP TABLE IF EXISTS TEMP_REPORTSELECTEDFIELD;

		CREATE TEMPORARY TABLE TEMP_REPORTCROSSTABROWS
		SELECT reportSelectedFields_REPORTSELECTEDFIELD_ID FROM REPORTWIZARD_REPORTSELECTEDFIELD WHERE REPORTWIZARD_REPORTWIZARD_ID = REPORTWIZARDID;

		DELETE FROM REPORTWIZARD_REPORTSELECTEDFIELD WHERE REPORTWIZARD_REPORTWIZARD_ID = REPORTWIZARDID;

		DELETE FROM REPORTSELECTEDFIELD WHERE REPORTSELECTEDFIELD_ID IN
		(SELECT reportSelectedFields_REPORTSELECTEDFIELD_ID FROM TEMP_REPORTCROSSTABROWS);

		DROP TABLE IF EXISTS TEMP_REPORTSELECTEDFIELD;


		DROP TABLE IF EXISTS TEMP_REPORTCROSSTABROWS;

		CREATE TEMPORARY TABLE TEMP_REPORTCROSSTABROWS
		SELECT reportCrossTabRows_REPORTCROSSTABROWS_ID FROM REPORTCROSSTABFIELDS_REPORTCROSSTABROW
		WHERE REPORTCROSSTABFIELDS_REPORTCROSSTABFIELDS_ID IN
		(SELECT reportCrossTabFields_REPORTCROSSTABFIELDS_ID FROM REPORTWIZARD WHERE REPORTWIZARD_ID = REPORTWIZARDID);

		DELETE FROM REPORTCROSSTABFIELDS_REPORTCROSSTABROW
		WHERE REPORTCROSSTABFIELDS_REPORTCROSSTABFIELDS_ID IN
		(SELECT reportCrossTabFields_REPORTCROSSTABFIELDS_ID FROM REPORTWIZARD WHERE REPORTWIZARD_ID = REPORTWIZARDID);

		DELETE FROM REPORTCROSSTABROW WHERE REPORTCROSSTABROWS_ID IN
		(SELECT reportCrossTabRows_REPORTCROSSTABROWS_ID FROM TEMP_REPORTCROSSTABROWS);

		DROP TABLE IF EXISTS TEMP_REPORTCROSSTABROWS;


		DROP TABLE IF EXISTS TEMP_REPORTCROSSTABCOLUMNS;

		CREATE TEMPORARY TABLE TEMP_REPORTCROSSTABCOLUMNS
		SELECT reportCrossTabColumns_REPORTCROSSTABCOLUMN_ID FROM REPORTCROSSTABFIELDS_REPORTCROSSTABCOLUMN
		WHERE REPORTCROSSTABFIELDS_REPORTCROSSTABFIELDS_ID IN
		(SELECT reportCrossTabFields_REPORTCROSSTABFIELDS_ID FROM REPORTWIZARD WHERE REPORTWIZARD_ID = REPORTWIZARDID);

		DELETE FROM REPORTCROSSTABFIELDS_REPORTCROSSTABCOLUMN
		WHERE REPORTCROSSTABFIELDS_REPORTCROSSTABFIELDS_ID IN
		(SELECT reportCrossTabFields_REPORTCROSSTABFIELDS_ID FROM REPORTWIZARD WHERE REPORTWIZARD_ID = REPORTWIZARDID);

		DELETE FROM REPORTCROSSTABCOLUMN WHERE REPORTCROSSTABCOLUMN_ID IN
		(SELECT reportCrossTabColumns_REPORTCROSSTABCOLUMN_ID FROM TEMP_REPORTCROSSTABCOLUMNS);

		DROP TABLE IF EXISTS TEMP_REPORTCROSSTABCOLUMNS;


		DROP TABLE IF EXISTS TEMP_REPORTCROSSTABMEASURES;

		CREATE TEMPORARY TABLE TEMP_REPORTCROSSTABMEASURES
		SELECT reportCrossTabMeasure_REPORTCROSSTABMEASURE_ID FROM REPORTCROSSTABFIELDS_REPORTCROSSTABMEASURE
		WHERE REPORTCROSSTABFIELDS_REPORTCROSSTABFIELDS_ID IN
		(SELECT reportCrossTabFields_REPORTCROSSTABFIELDS_ID FROM REPORTWIZARD WHERE REPORTWIZARD_ID = REPORTWIZARDID);

		DELETE FROM REPORTCROSSTABFIELDS_REPORTCROSSTABMEASURE
		WHERE REPORTCROSSTABFIELDS_REPORTCROSSTABFIELDS_ID IN
		(SELECT reportCrossTabFields_REPORTCROSSTABFIELDS_ID FROM REPORTWIZARD WHERE REPORTWIZARD_ID = REPORTWIZARDID);

		DELETE FROM REPORTCROSSTABMEASURE WHERE REPORTCROSSTABMEASURE_ID IN
		(SELECT reportCrossTabMeasure_REPORTCROSSTABMEASURE_ID FROM TEMP_REPORTCROSSTABMEASURES);

		DROP TABLE IF EXISTS TEMP_REPORTCROSSTABMEASURES;


		DROP TABLE IF EXISTS TEMP_REPORTCROSSTABFIELDS;

		CREATE TEMPORARY TABLE TEMP_REPORTCROSSTABFIELDS
		SELECT reportCrossTabFields_REPORTCROSSTABFIELDS_ID FROM REPORTWIZARD WHERE REPORTWIZARD_ID = REPORTWIZARDID;

		DELETE FROM REPORTWIZARD WHERE REPORTWIZARD_ID = REPORTWIZARDID;

		DELETE FROM REPORTCROSSTABFIELDS WHERE REPORTCROSSTABFIELDS_ID IN
		(SELECT reportCrossTabFields_REPORTCROSSTABFIELDS_ID FROM TEMP_REPORTCROSSTABFIELDS);

		DROP TABLE IF EXISTS TEMP_REPORTCROSSTABFIELDS;
	END IF;
END$$