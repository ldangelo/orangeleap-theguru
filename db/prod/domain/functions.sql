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
