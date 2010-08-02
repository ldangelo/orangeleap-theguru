DELIMITER $$

DROP FUNCTION IF EXISTS GET_ENTITY_TYPE_FOR_TABLE $$

CREATE FUNCTION GET_ENTITY_TYPE_FOR_TABLE(TABLENAME VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
	DECLARE RESULT VARCHAR(255);

	IF UPPER(TABLENAME) = 'CONSTITUENT' THEN
		SET RESULT = 'constituent';
	ELSEIF UPPER(TABLENAME) = 'DISTRO_LINE' THEN
		SET RESULT = 'distributionline';
	ELSEIF UPPER(TABLENAME) = 'GIFT' THEN
		SET RESULT = 'gift';
	ELSEIF UPPER(TABLENAME) = 'COMMUNICATION_HISTORY' THEN
		SET RESULT = 'communicationhistory';
	ELSEIF UPPER(TABLENAME) = 'ADDRESS' THEN
		SET RESULT = 'address';
	ELSEIF UPPER(TABLENAME) = 'EMAIL' THEN
		SET RESULT = 'email';
	ELSEIF UPPER(TABLENAME) = 'PHONE' THEN
		SET RESULT = 'phone';
	ELSEIF UPPER(TABLENAME) = 'ADJUSTED_GIFT' THEN
		SET RESULT = 'adjustedgift';
	ELSEIF UPPER(TABLENAME) = 'PICKLIST' THEN
		SET RESULT = 'picklist';
	ELSEIF UPPER(TABLENAME) = 'PICKLIST_ITEM' THEN
		SET RESULT = 'picklistitem';
	ELSEIF UPPER(TABLENAME) = 'RECURRING_GIFT' THEN
		SET RESULT = 'recurringGift';
	ELSEIF UPPER(TABLENAME) = 'PAYMENT_SOURCE' THEN
		SET RESULT = 'paymentSource';
	ELSEIF UPPER(TABLENAME) = 'PLEDGE' THEN
		SET RESULT = 'pledge';
	ELSEIF UPPER(TABLENAME) = 'GIFT_IN_KIND' THEN
		SET RESULT = 'giftInKind';
    ELSE
        SET RESULT = LOWER(REPLACE(TABLENAME, '_', ''));
	END IF;

	RETURN(RESULT);	-- return
END$$