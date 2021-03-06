DROP TABLE IF EXISTS THEGURU_GENERATED_VIEWS;
CREATE TABLE THEGURU_GENERATED_VIEWS (
    VIEW_TEXT VARCHAR(65535)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS THEGURU_VIEW;
CREATE TABLE THEGURU_VIEW (
	VIEW_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	VIEW_NAME VARCHAR(64),
	VIEW_DISPLAY_TEXT VARCHAR(255),
	PRIMARY_TABLE VARCHAR(64),
	PRIMARY_TABLE_IS_VIEW BIT,
	PRIMARY_TABLE_ALIAS VARCHAR(64),
	PRIMARY_TABLE_COLUMN_PREFIX VARCHAR(64),
	FIELD_GROUP_PREFIX VARCHAR(255),
	FIELD_GROUP_OVERRIDE VARCHAR(255),
	INCLUDE_ALL_FIELDS BIT,
    WHERE_CLAUSE VARCHAR(8000),
	SORT_ORDER INT,
	PARENT_ENTITY_TYPE VARCHAR(255),
	SUB_FIELD_NAME VARCHAR(255),
	DEFAULT_PAGE_TYPE VARCHAR(255),
	SQL_OVERRIDE TEXT,
	PRIMARY KEY (VIEW_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS THEGURU_VIEW_JOIN;
CREATE TABLE THEGURU_VIEW_JOIN (
	JOIN_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	VIEW_ID INTEGER UNSIGNED,
	JOIN_TYPE VARCHAR(20),
	JOIN_TABLE VARCHAR(64),
	JOIN_TABLE_IS_VIEW BIT,
	JOIN_TABLE_ALIAS VARCHAR(64),
	JOIN_TABLE_COLUMN_PREFIX VARCHAR(255),
	JOIN_CRITERIA VARCHAR(2000),
	FIELD_GROUP_PREFIX VARCHAR(255),
	FIELD_GROUP_OVERRIDE VARCHAR(255),
	INCLUDE_ALL_FIELDS BIT,
	SORT_ORDER INTEGER,
	PARENT_ENTITY_TYPE VARCHAR(255),
	SUB_FIELD_NAME VARCHAR(255),
	DEFAULT_PAGE_TYPE VARCHAR(255),
	PRIMARY KEY (JOIN_ID),
	CONSTRAINT FK_THEGURU_VIEW FOREIGN KEY (VIEW_ID) REFERENCES THEGURU_VIEW (VIEW_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS THEGURU_VIEW_WHERE;
CREATE TABLE THEGURU_VIEW_WHERE (
	WHERE_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	VIEW_ID INTEGER UNSIGNED,
	WHERE_TEXT VARCHAR(8000),
	PRIMARY KEY (WHERE_ID),
	CONSTRAINT FK_THEGURU_WHERE_VIEW FOREIGN KEY (VIEW_ID) REFERENCES THEGURU_VIEW (VIEW_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS THEGURU_TABLE_ADDITIONAL_FIELD;
CREATE TABLE THEGURU_TABLE_ADDITIONAL_FIELD (
	FIELD_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	TABLE_NAME VARCHAR(64),
	FIELD_TEXT VARCHAR(2000),
	FIELD_ALIAS VARCHAR(64),
	PRIMARY KEY (FIELD_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS;
CREATE TABLE THEGURU_TABLE_ADDITIONAL_FIELD_DEFINITIONS (
	FIELD_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	TABLE_NAME VARCHAR(64),
	FIELD_GROUP VARCHAR(255),
    DISPLAY_NAME VARCHAR(255),
	COLUMN_NAME VARCHAR(4000),
    ALIAS_NAME VARCHAR(64),
    FIELD_TYPE INT,
	PRIMARY KEY (FIELD_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS THEGURU_TABLE_FIELD_EXCLUSIONS;
CREATE TABLE THEGURU_TABLE_FIELD_EXCLUSIONS (
	FIELD_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	TABLE_NAME VARCHAR(64),
	FIELD_NAME VARCHAR(2000),
	PRIMARY KEY (FIELD_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS THEGURU_FIELD_DEFINITIONS;
CREATE TABLE THEGURU_FIELD_DEFINITIONS (
	FIELD_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	VIEW_NAME VARCHAR(64),
	FIELD_GROUP VARCHAR(255),
	COLUMN_NAME VARCHAR(1000),
	ALIAS_NAME VARCHAR(64),
	DISPLAY_TEXT VARCHAR(255),
	FIELD_TYPE INT,
	PRIMARY_KEY VARCHAR(255),
	PRIMARY KEY (FIELD_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS THEGURU_FIELD_FIELDGROUP_OVERRIDE;
CREATE TABLE THEGURU_FIELD_FIELDGROUP_OVERRIDE (
	FIELD_FIELDGROUP_OVERRIDE_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	ALIAS_NAME VARCHAR(64),
	FIELD_GROUP_OVERRIDE VARCHAR(255),
	PRIMARY KEY (FIELD_FIELDGROUP_OVERRIDE_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
