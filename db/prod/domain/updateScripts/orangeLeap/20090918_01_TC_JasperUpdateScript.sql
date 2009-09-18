DELIMITER $$

DROP PROCEDURE IF EXISTS JASPER_UPDATE_SCRIPT$$

CREATE PROCEDURE JASPER_UPDATE_SCRIPT() BEGIN
	IF NOT EXISTS
		(SELECT * FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_NAME='JITenant' AND TABLE_SCHEMA = DATABASE())
	THEN
		ALTER TABLE JILogEvent
			ADD userId BIGINT;

		UPDATE JILogEvent le
			SET le.userId = (SELECT u.id FROM JIUser u WHERE u.username = le.username);

		ALTER TABLE JILogEvent
			DROP username;

		ALTER TABLE JIObjectPermission 
			MODIFY uri VARCHAR(250) NOT NULL;

		ALTER TABLE JIObjectPermission 
			MODIFY recipientobjectclass VARCHAR(250);


		ALTER TABLE JIReportJob 
			ADD owner BIGINT NOT NULL;

		UPDATE JIReportJob rj
			SET rj.owner = (SELECT u.id FROM JIUser u WHERE u.username = rj.username);

		CREATE TABLE tmpId (id BIGINT);
		INSERT tmpId SELECT id FROM JIReportJob WHERE owner NOT IN (SELECT id FROM JIUser);
		DELETE FROM JIReportJobOutputFormat WHERE report_job_id IN (SELECT id FROM tmpId);
		DELETE FROM JIReportJobParameter WHERE job_id IN (SELECT id FROM tmpId);
		DELETE FROM JIReportJob WHERE owner NOT IN (SELECT id FROM JIUser);
		DROP TABLE tmpId;

		ALTER TABLE JIReportJob
			DROP username;

		ALTER TABLE JIReportJob 
			MODIFY report_unit_uri VARCHAR(250) NOT NULL;


		ALTER TABLE JIReportJobMail 
			MODIFY message text;

		ALTER TABLE JIReportJobRepoDest 
			MODIFY folder_uri VARCHAR(250) NOT NULL;

		ALTER TABLE JIReportJobRepoDest 
			MODIFY output_description VARCHAR(250);

		ALTER TABLE JIRepositoryCache 
			MODIFY uri VARCHAR(250) NOT NULL;

		CREATE TABLE JITenant (
			id BIGINT NOT NULL AUTO_INCREMENT,
			tenantId VARCHAR(100) NOT NULL,
			parentId BIGINT,
			tenantName VARCHAR(100) NOT NULL,
			tenantDesc VARCHAR(250),
			tenantNote VARCHAR(250),
			tenantUri VARCHAR(250) NOT NULL,
			tenantFolderUri VARCHAR(250) NOT NULL,
			primary key (id),
			UNIQUE (tenantId)
		) ENGINE=InnoDB;

		INSERT into JITenant 
			values (1, 'organizations', null, 'root', 'organizations', ' ', '/', '/');

		ALTER TABLE JIRole
			MODIFY rolename VARCHAR(100) NOT NULL;

		ALTER TABLE JIRole
			DROP index rolename;

		ALTER TABLE JIRole
			ADD tenantId BIGINT NOT NULL;

		UPDATE JIRole
			SET tenantId = 1;

		ALTER TABLE JIRole
			ADD UNIQUE (rolename, tenantId);

		ALTER TABLE JIUser
			MODIFY username VARCHAR(100) NOT NULL;

		ALTER TABLE JIUser
			DROP index username;

		ALTER TABLE JIUser
			ADD tenantId BIGINT NOT NULL;

		UPDATE JIUser
			SET tenantId = 1;

		ALTER TABLE JIUser
			ADD UNIQUE (username, tenantId);

		ALTER TABLE JILogEvent
			ADD INDEX FK5F32081591865AF (userId),
			ADD CONSTRAINT FK5F32081591865AF 
			FOREIGN KEY (userId) 
			REFERENCES JIUser (id);

		CREATE INDEX uri_index ON JIObjectPermission (uri);

		ALTER TABLE JIReportJob
			ADD INDEX FK156F5F6A4141263C (owner), 
			ADD CONSTRAINT FK156F5F6A4141263C 
			FOREIGN KEY (owner) 
			REFERENCES JIUser (id);

		ALTER TABLE JIRole
			ADD INDEX FK82724655E415AC2D (tenantId),
			ADD CONSTRAINT FK82724655E415AC2D
			FOREIGN KEY (tenantId)
			REFERENCES JITenant (id);

		ALTER TABLE JITenant
			ADD INDEX FKB1D7B2C97803CC2D (parentId),
			ADD CONSTRAINT FKB1D7B2C97803CC2D
			FOREIGN KEY (parentId)
			REFERENCES JITenant (id);

		ALTER TABLE JIUser
			ADD INDEX FK8273B1AAE415AC2D (tenantId),
			ADD CONSTRAINT FK8273B1AAE415AC2D
			FOREIGN KEY (tenantId)
			REFERENCES JITenant (id);

		UPDATE JIUser SET password = '';
		UPDATE JIJdbcDatasource SET password = '';
	END IF;
END;
$$

DELIMITER ;

CALL JASPER_UPDATE_SCRIPT();

DROP PROCEDURE JASPER_UPDATE_SCRIPT;


