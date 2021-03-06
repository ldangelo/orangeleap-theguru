DELIMITER $$

DROP PROCEDURE IF EXISTS `IS_SEGMENTATION_IN_USE`$$

CREATE PROCEDURE IS_SEGMENTATION_IN_USE(REPORTWIZARDID INT)
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
		SELECT 1 AS IN_USE;
	ELSE
		SELECT 0 AS IN_USE;
	END IF;
END$$