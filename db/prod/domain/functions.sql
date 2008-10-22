-- Create function to retrieve person custom fields
DROP FUNCTION IF EXISTS GETPERSONCUSTOMFIELD$$

CREATE FUNCTION `GETPERSONCUSTOMFIELD`(PERSONID INT, FIELDNAME VARCHAR(255))
	RETURNS VARCHAR(255)
BEGIN
  DECLARE FIELDVALUE VARCHAR(255);

  SELECT FIELD_VALUE INTO FIELDVALUE
    FROM PERSON_CUSTOM_FIELD
    JOIN CUSTOM_FIELD ON CUSTOM_FIELD.CUSTOM_FIELD_ID = PERSON_CUSTOM_FIELD.CUSTOM_FIELD_ID
    WHERE PERSON_ID = PERSONID
    AND FIELD_NAME = FIELDNAME;

	RETURN FIELDVALUE;
END$$


-- Create function to retrieve gift custom fields
DROP FUNCTION IF EXISTS GETGIFTCUSTOMFIELD$$

CREATE FUNCTION `GETGIFTCUSTOMFIELD`(GIFTID INT, FIELDNAME VARCHAR(255))
	RETURNS VARCHAR(255)
BEGIN
  DECLARE FIELDVALUE VARCHAR(255);

  SELECT FIELD_VALUE INTO FIELDVALUE
    FROM GIFT_CUSTOM_FIELD
    JOIN CUSTOM_FIELD ON CUSTOM_FIELD.CUSTOM_FIELD_ID = GIFT_CUSTOM_FIELD.CUSTOM_FIELD_ID
    WHERE GIFT_ID = GIFTID
    AND FIELD_NAME = FIELDNAME;

	RETURN FIELDVALUE;
END$$


-- Create function to retrieve distribution line custom fields
DROP FUNCTION IF EXISTS GETDISTROLINECUSTOMFIELD$$

CREATE FUNCTION `GETDISTROLINECUSTOMFIELD`(DISTROLINEID INT, FIELDNAME VARCHAR(255))
	RETURNS VARCHAR(255)
BEGIN
  DECLARE FIELDVALUE VARCHAR(255);

  SELECT FIELD_VALUE INTO FIELDVALUE
    FROM DISTRO_LINE_CUSTOM_FIELD
    JOIN CUSTOM_FIELD ON CUSTOM_FIELD.CUSTOM_FIELD_ID = DISTRO_LINE_CUSTOM_FIELD.CUSTOM_FIELD_ID
    WHERE DISTRO_LINE_ID = DISTROLINEID
    AND FIELD_NAME = FIELDNAME;

	RETURN FIELDVALUE;
END$$


-- Create function to retrieve commitment custom fields
DROP FUNCTION IF EXISTS GETCOMMITMENTCUSTOMFIELD$$

CREATE FUNCTION `GETCOMMITMENTCUSTOMFIELD`(COMMITMENTID INT, FIELDNAME VARCHAR(255))
	RETURNS VARCHAR(255)
BEGIN
  DECLARE FIELDVALUE VARCHAR(255);

  SELECT FIELD_VALUE INTO FIELDVALUE
    FROM COMMITMENT_CUSTOM_FIELD
    JOIN CUSTOM_FIELD ON CUSTOM_FIELD.CUSTOM_FIELD_ID = COMMITMENT_CUSTOM_FIELD.CUSTOM_FIELD_ID
    WHERE COMMITMENT_ID = COMMITMENTID
    AND FIELD_NAME = FIELDNAME;

	RETURN FIELDVALUE;
END$$
