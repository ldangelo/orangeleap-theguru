-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.51a-log


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Definition of table `JIBeanDatasource`
--

DROP TABLE IF EXISTS `JIBeanDatasource`;
CREATE TABLE `JIBeanDatasource` (
  `id` bigint(20) NOT NULL,
  `beanName` varchar(100) NOT NULL,
  `beanMethod` varchar(100) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK674BF34A8BF376D` (`id`),
  CONSTRAINT `FK674BF34A8BF376D` FOREIGN KEY (`id`) REFERENCES `JIResource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIBeanDatasource`
--

/*!40000 ALTER TABLE `JIBeanDatasource` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIBeanDatasource` ENABLE KEYS */;


--
-- Definition of table `JIContentResource`
--

DROP TABLE IF EXISTS `JIContentResource`;
CREATE TABLE `JIContentResource` (
  `id` bigint(20) NOT NULL,
  `data` longblob,
  `file_type` varchar(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKE466FC68A8BF376D` (`id`),
  CONSTRAINT `FKE466FC68A8BF376D` FOREIGN KEY (`id`) REFERENCES `JIResource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIContentResource`
--

/*!40000 ALTER TABLE `JIContentResource` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIContentResource` ENABLE KEYS */;


--
-- Definition of table `JICustomDatasource`
--

DROP TABLE IF EXISTS `JICustomDatasource`;
CREATE TABLE `JICustomDatasource` (
  `id` bigint(20) NOT NULL,
  `serviceClass` varchar(250) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK2BBCEDF5A8BF376D` (`id`),
  CONSTRAINT `FK2BBCEDF5A8BF376D` FOREIGN KEY (`id`) REFERENCES `JIResource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JICustomDatasource`
--

/*!40000 ALTER TABLE `JICustomDatasource` DISABLE KEYS */;
/*!40000 ALTER TABLE `JICustomDatasource` ENABLE KEYS */;


--
-- Definition of table `JICustomDatasourceProperty`
--

DROP TABLE IF EXISTS `JICustomDatasourceProperty`;
CREATE TABLE `JICustomDatasourceProperty` (
  `ds_id` bigint(20) NOT NULL,
  `value` text,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY  (`ds_id`,`name`),
  KEY `FKB8A66AEA858A89D1` (`ds_id`),
  CONSTRAINT `FKB8A66AEA858A89D1` FOREIGN KEY (`ds_id`) REFERENCES `JICustomDatasource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JICustomDatasourceProperty`
--

/*!40000 ALTER TABLE `JICustomDatasourceProperty` DISABLE KEYS */;
/*!40000 ALTER TABLE `JICustomDatasourceProperty` ENABLE KEYS */;


--
-- Definition of table `JIDataType`
--

DROP TABLE IF EXISTS `JIDataType`;
CREATE TABLE `JIDataType` (
  `id` bigint(20) NOT NULL,
  `type` tinyint(4) default NULL,
  `maxLength` int(11) default NULL,
  `decimals` int(11) default NULL,
  `regularExpr` varchar(255) default NULL,
  `minValue` tinyblob,
  `maxValue` tinyblob,
  `strictMin` bit(1) default NULL,
  `strictMax` bit(1) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK533BCC63A8BF376D` (`id`),
  CONSTRAINT `FK533BCC63A8BF376D` FOREIGN KEY (`id`) REFERENCES `JIResource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIDataType`
--

/*!40000 ALTER TABLE `JIDataType` DISABLE KEYS */;
INSERT INTO `JIDataType` (`id`,`type`,`maxLength`,`decimals`,`regularExpr`,`minValue`,`maxValue`,`strictMin`,`strictMax`) VALUES
 (4,3,NULL,NULL,NULL,NULL,NULL,0x00,0x00),
 (5,1,NULL,NULL,'',NULL,NULL,0x00,0x00),
 (7,2,NULL,NULL,'',NULL,NULL,0x00,0x00);
/*!40000 ALTER TABLE `JIDataType` ENABLE KEYS */;


--
-- Definition of table `JIFileResource`
--

DROP TABLE IF EXISTS `JIFileResource`;
CREATE TABLE `JIFileResource` (
  `id` bigint(20) NOT NULL,
  `data` longblob,
  `file_type` varchar(20) default NULL,
  `reference` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKF75B58895A0C539` (`reference`),
  KEY `FKF75B5889A8BF376D` (`id`),
  CONSTRAINT `FKF75B58895A0C539` FOREIGN KEY (`reference`) REFERENCES `JIFileResource` (`id`),
  CONSTRAINT `FKF75B5889A8BF376D` FOREIGN KEY (`id`) REFERENCES `JIResource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIFileResource`
--

/*!40000 ALTER TABLE `JIFileResource` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIFileResource` ENABLE KEYS */;


--
-- Definition of table `JIInputControl`
--

DROP TABLE IF EXISTS `JIInputControl`;
CREATE TABLE `JIInputControl` (
  `id` bigint(20) NOT NULL,
  `type` tinyint(4) default NULL,
  `mandatory` bit(1) default NULL,
  `readOnly` bit(1) default NULL,
  `visible` bit(1) default NULL,
  `data_type` bigint(20) default NULL,
  `list_of_values` bigint(20) default NULL,
  `list_query` bigint(20) default NULL,
  `query_value_column` varchar(200) default NULL,
  `defaultValue` tinyblob,
  PRIMARY KEY  (`id`),
  KEY `FKCAC6A512120E06F7` (`data_type`),
  KEY `FKCAC6A512B37DB6EB` (`list_query`),
  KEY `FKCAC6A51262A86F04` (`list_of_values`),
  KEY `FKCAC6A512A8BF376D` (`id`),
  CONSTRAINT `FKCAC6A512120E06F7` FOREIGN KEY (`data_type`) REFERENCES `JIDataType` (`id`),
  CONSTRAINT `FKCAC6A51262A86F04` FOREIGN KEY (`list_of_values`) REFERENCES `JIListOfValues` (`id`),
  CONSTRAINT `FKCAC6A512A8BF376D` FOREIGN KEY (`id`) REFERENCES `JIResource` (`id`),
  CONSTRAINT `FKCAC6A512B37DB6EB` FOREIGN KEY (`list_query`) REFERENCES `JIQuery` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIInputControl`
--

/*!40000 ALTER TABLE `JIInputControl` DISABLE KEYS */;
INSERT INTO `JIInputControl` (`id`,`type`,`mandatory`,`readOnly`,`visible`,`data_type`,`list_of_values`,`list_query`,`query_value_column`,`defaultValue`) VALUES
 (6,2,0x00,0x00,0x01,5,NULL,NULL,NULL,NULL),
 (2381,2,0x00,0x00,0x01,7,NULL,NULL,NULL,NULL),
 (3510,2,0x00,0x00,0x01,5,NULL,NULL,NULL,NULL),
 (3513,2,0x00,0x00,0x01,5,NULL,NULL,NULL,NULL),
 (3514,2,0x00,0x00,0x01,5,NULL,NULL,NULL,NULL),
 (3662,2,0x00,0x00,0x01,7,NULL,NULL,NULL,NULL),
 (3803,2,0x00,0x00,0x01,5,NULL,NULL,NULL,NULL),
 (3805,2,0x00,0x00,0x01,5,NULL,NULL,NULL,NULL),
 (3806,2,0x00,0x00,0x01,5,NULL,NULL,NULL,NULL),
 (3810,2,0x00,0x00,0x01,5,NULL,NULL,NULL,NULL),
 (3811,2,0x00,0x00,0x01,5,NULL,NULL,NULL,NULL),
 (3812,2,0x00,0x00,0x01,5,NULL,NULL,NULL,NULL),
 (4004,2,0x00,0x00,0x01,7,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `JIInputControl` ENABLE KEYS */;


--
-- Definition of table `JIInputControlQueryColumn`
--

DROP TABLE IF EXISTS `JIInputControlQueryColumn`;
CREATE TABLE `JIInputControlQueryColumn` (
  `input_control_id` bigint(20) NOT NULL,
  `query_column` varchar(200) NOT NULL,
  `column_index` int(11) NOT NULL,
  PRIMARY KEY  (`input_control_id`,`column_index`),
  KEY `FKE436A5CCE7922149` (`input_control_id`),
  CONSTRAINT `FKE436A5CCE7922149` FOREIGN KEY (`input_control_id`) REFERENCES `JIInputControl` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIInputControlQueryColumn`
--

/*!40000 ALTER TABLE `JIInputControlQueryColumn` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIInputControlQueryColumn` ENABLE KEYS */;


--
-- Definition of table `JIJNDIJdbcDatasource`
--

DROP TABLE IF EXISTS `JIJNDIJdbcDatasource`;
CREATE TABLE `JIJNDIJdbcDatasource` (
  `id` bigint(20) NOT NULL,
  `jndiName` varchar(100) NOT NULL,
  `timezone` varchar(100) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK7F9DA248A8BF376D` (`id`),
  CONSTRAINT `FK7F9DA248A8BF376D` FOREIGN KEY (`id`) REFERENCES `JIResource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIJNDIJdbcDatasource`
--

/*!40000 ALTER TABLE `JIJNDIJdbcDatasource` DISABLE KEYS */;
INSERT INTO `JIJNDIJdbcDatasource` (`id`,`jndiName`,`timezone`) VALUES
 (2,'jdbc/sugarcrm',NULL);
/*!40000 ALTER TABLE `JIJNDIJdbcDatasource` ENABLE KEYS */;


--
-- Definition of table `JIJdbcDatasource`
--

DROP TABLE IF EXISTS `JIJdbcDatasource`;
CREATE TABLE `JIJdbcDatasource` (
  `id` bigint(20) NOT NULL,
  `driver` varchar(100) NOT NULL,
  `password` varchar(100) default NULL,
  `connectionUrl` text,
  `username` varchar(100) default NULL,
  `timezone` varchar(100) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKC8BDFCBFA8BF376D` (`id`),
  CONSTRAINT `FKC8BDFCBFA8BF376D` FOREIGN KEY (`id`) REFERENCES `JIResource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIJdbcDatasource`
--

/*!40000 ALTER TABLE `JIJdbcDatasource` DISABLE KEYS */;
INSERT INTO `JIJdbcDatasource` (`id`,`driver`,`password`,`connectionUrl`,`username`,`timezone`) VALUES
 (1,'com.mysql.jdbc.Driver','magicdragon!','jdbc:mysql://localhost:3306/sugarcrm','root',NULL),
 (3,'com.mysql.jdbc.Driver','orangeleap','jdbc:mysql://localhost:10006/company1?autoReconnect=true&useUnicode=true','orangeleap',NULL),
 (198,'com.microsoft.sqlserver.jdbc.SQLServerDriver','mpx','jdbc:sqlserver://Puddy;databaseName=ClementineTestDatabase;instanceName=Puddy05','sa','America/Chicago'),
 (3924,'com.mysql.jdbc.Driver','orangeleap','jdbc:mysql://localhost:10206/sandbox','orangeleap',NULL);
/*!40000 ALTER TABLE `JIJdbcDatasource` ENABLE KEYS */;


--
-- Definition of table `JIListOfValues`
--

DROP TABLE IF EXISTS `JIListOfValues`;
CREATE TABLE `JIListOfValues` (
  `id` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK4E86A776A8BF376D` (`id`),
  CONSTRAINT `FK4E86A776A8BF376D` FOREIGN KEY (`id`) REFERENCES `JIResource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIListOfValues`
--

/*!40000 ALTER TABLE `JIListOfValues` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIListOfValues` ENABLE KEYS */;


--
-- Definition of table `JIListOfValuesItem`
--

DROP TABLE IF EXISTS `JIListOfValuesItem`;
CREATE TABLE `JIListOfValuesItem` (
  `id` bigint(20) NOT NULL,
  `label` varchar(255) default NULL,
  `value` tinyblob,
  `idx` int(11) NOT NULL,
  PRIMARY KEY  (`id`,`idx`),
  KEY `FKD37CEBA993F0E1F6` (`id`),
  CONSTRAINT `FKD37CEBA993F0E1F6` FOREIGN KEY (`id`) REFERENCES `JIListOfValues` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIListOfValuesItem`
--

/*!40000 ALTER TABLE `JIListOfValuesItem` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIListOfValuesItem` ENABLE KEYS */;


--
-- Definition of table `JILogEvent`
--

DROP TABLE IF EXISTS `JILogEvent`;
CREATE TABLE `JILogEvent` (
  `id` bigint(20) NOT NULL auto_increment,
  `occurrence_date` datetime NOT NULL,
  `event_type` tinyint(4) NOT NULL,
  `username` varchar(100) default NULL,
  `component` varchar(100) default NULL,
  `message` varchar(250) NOT NULL,
  `resource_uri` varchar(250) default NULL,
  `event_text` mediumtext,
  `event_data` mediumblob,
  `event_state` tinyint(4) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JILogEvent`
--

/*!40000 ALTER TABLE `JILogEvent` DISABLE KEYS */;
INSERT INTO `JILogEvent` (`id`,`occurrence_date`,`event_type`,`username`,`component`,`message`,`resource_uri`,`event_text`,`event_data`,`event_state`) VALUES
 (58,'2009-03-23 08:00:17',1,'demoadmin','reportScheduler','log.error.report.job.failed','/Reports/Default/Constituent_List_-_State_Prompt','Job: Oklahoma List (ID: 23)\nReport unit: /Reports/Default/Constituent_List_-_State_Prompt\nQuartz Job: ReportJobs.job_23\nQuartz Trigger: ReportJobs.trigger_23_0\nExceptions:\n\nAn error occurred while executing the report.\ncom.jaspersoft.jasperserver.api.JSExceptionWrapper: net.sf.jasperreports.engine.JRException: Error executing SQL statement for : mpower_template_jrxml_1221161748849\n	at net.sf.jasperreports.engine.query.JRJdbcQueryExecuter.createDatasource(JRJdbcQueryExecuter.java:141)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.util.JRTimezoneJdbcQueryExecuter.createDatasource(JRTimezoneJdbcQueryExecuter.java:127)\n	at net.sf.jasperreports.engine.fill.JRFillDataset.createQueryDatasource(JRFillDataset.java:656)\n	at net.sf.jasperreports.engine.fill.JRFillDataset.initDatasource(JRFillDataset.java:588)\n	at net.sf.jasperreports.engine.fill.JRBaseFiller.setParameters(JRBaseFiller.java:1196)\n	at net.sf.jasperreports.engine.fill.JRBaseFiller.fill(JRBaseFiller.java:833)\n	at net.sf.jasperreports.engine.fill.JRFiller.fillReport(JRFiller.java:123)\n	at net.sf.jasperreports.engine.JasperFillManager.fillReport(JasperFillManager.java:420)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.EngineServiceImpl.fillReport(EngineServiceImpl.java:638)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.EngineServiceImpl.fillReport(EngineServiceImpl.java:333)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.EngineServiceImpl.executeReport(EngineServiceImpl.java:765)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.domain.impl.ReportUnitRequest.execute(ReportUnitRequest.java:60)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.EngineServiceImpl.execute(EngineServiceImpl.java:265)\n	at com.jaspersoft.jasperserver.api.engine.scheduling.quartz.ReportExecutionJob.executeReport(ReportExecutionJob.java:441)\n	at com.jaspersoft.jasperserver.api.engine.scheduling.quartz.ReportExecutionJob.executeAndSendReport(ReportExecutionJob.java:369)\n	at com.jaspersoft.jasperserver.api.engine.scheduling.quartz.ReportExecutionJob.execute(ReportExecutionJob.java:188)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:195)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:520)\nCaused by: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Table \'mpoweropen.VPEOPLEADDRESS\' doesn\'t exist\n	at com.mysql.jdbc.SQLError.createSQLException(SQLError.java:936)\n	at com.mysql.jdbc.MysqlIO.checkErrorPacket(MysqlIO.java:2985)\n	at com.mysql.jdbc.MysqlIO.sendCommand(MysqlIO.java:1631)\n	at com.mysql.jdbc.MysqlIO.sqlQueryDirect(MysqlIO.java:1723)\n	at com.mysql.jdbc.Connection.execSQL(Connection.java:3283)\n	at com.mysql.jdbc.PreparedStatement.executeInternal(PreparedStatement.java:1332)\n	at com.mysql.jdbc.PreparedStatement.executeQuery(PreparedStatement.java:1467)\n	at org.apache.commons.dbcp.DelegatingPreparedStatement.executeQuery(DelegatingPreparedStatement.java:92)\n	at net.sf.jasperreports.engine.query.JRJdbcQueryExecuter.createDatasource(JRJdbcQueryExecuter.java:135)\n	... 17 more\n',NULL,1),
 (59,'2009-04-30 14:04:00',1,'demoadmin','reportScheduler','log.error.report.job.failed','/Reports/Default/THEGURU_17','Job: Gifts greater than $1000 (ID: 3)\nReport unit: /Reports/Default/THEGURU_17\nQuartz Job: ReportJobs.job_3\nQuartz Trigger: ReportJobs.trigger_3_0\nExceptions:\n\nAn error occurred while saving THEGURU_17.pdf into the repository.\ncom.jaspersoft.jasperserver.api.JSException: jsexception.report.resource.already.exists.no.overwrite\n	at com.jaspersoft.jasperserver.api.engine.scheduling.quartz.ReportExecutionJob.saveToRepository(ReportExecutionJob.java:846)\n	at com.jaspersoft.jasperserver.api.engine.scheduling.quartz.ReportExecutionJob.saveToRepository(ReportExecutionJob.java:513)\n	at com.jaspersoft.jasperserver.api.engine.scheduling.quartz.ReportExecutionJob.executeAndSendReport(ReportExecutionJob.java:380)\n	at com.jaspersoft.jasperserver.api.engine.scheduling.quartz.ReportExecutionJob.execute(ReportExecutionJob.java:188)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:195)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:520)\n',NULL,1),
 (60,'2009-05-01 09:00:00',1,'demoadmin','reportScheduler','log.error.report.job.failed','/Reports/Default/THEGURU_17','Job: Gifts greater than $500 (ID: 2)\nReport unit: /Reports/Default/THEGURU_17\nQuartz Job: ReportJobs.job_2\nQuartz Trigger: ReportJobs.trigger_2_0\nExceptions:\n\nAn error occurred while saving THEGURU_17.pdf into the repository.\ncom.jaspersoft.jasperserver.api.JSException: jsexception.report.resource.already.exists.no.overwrite\n	at com.jaspersoft.jasperserver.api.engine.scheduling.quartz.ReportExecutionJob.saveToRepository(ReportExecutionJob.java:846)\n	at com.jaspersoft.jasperserver.api.engine.scheduling.quartz.ReportExecutionJob.saveToRepository(ReportExecutionJob.java:513)\n	at com.jaspersoft.jasperserver.api.engine.scheduling.quartz.ReportExecutionJob.executeAndSendReport(ReportExecutionJob.java:380)\n	at com.jaspersoft.jasperserver.api.engine.scheduling.quartz.ReportExecutionJob.execute(ReportExecutionJob.java:188)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:195)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:520)\n',NULL,1),
 (61,'2009-05-12 11:48:30',1,'demoadmin','reportScheduler','log.error.report.job.failed','/Reports/Default/THEGURU_17','Job: Gifts greater than $1000 (ID: 7)\nReport unit: /Reports/Default/THEGURU_17\nQuartz Job: ReportJobs.job_7\nQuartz Trigger: ReportJobs.trigger_7_0\nExceptions:\n\nAn error occurred while executing the report.\ncom.jaspersoft.jasperserver.api.JSException: jsexception.error.creating.connection\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.JdbcDataSourceService.createConnection(JdbcDataSourceService.java:61)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.BaseJdbcDataSource.setReportParameterValues(BaseJdbcDataSource.java:52)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.JdbcDataSourceService.setReportParameterValues(JdbcDataSourceService.java:66)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.EngineServiceImpl.fillReport(EngineServiceImpl.java:633)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.EngineServiceImpl.fillReport(EngineServiceImpl.java:333)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.EngineServiceImpl.executeReport(EngineServiceImpl.java:765)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.domain.impl.ReportUnitRequest.execute(ReportUnitRequest.java:60)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.EngineServiceImpl.execute(EngineServiceImpl.java:265)\n	at com.jaspersoft.jasperserver.api.engine.scheduling.quartz.ReportExecutionJob.executeReport(ReportExecutionJob.java:441)\n	at com.jaspersoft.jasperserver.api.engine.scheduling.quartz.ReportExecutionJob.executeAndSendReport(ReportExecutionJob.java:369)\n	at com.jaspersoft.jasperserver.api.engine.scheduling.quartz.ReportExecutionJob.execute(ReportExecutionJob.java:188)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:195)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:520)\nCaused by: com.mysql.jdbc.CommunicationsException: Communications link failure due to underlying exception: \n\n** BEGIN NESTED EXCEPTION ** \n\njava.net.ConnectException\nMESSAGE: Connection refused\n\nSTACKTRACE:\n\njava.net.ConnectException: Connection refused\n	at java.net.PlainSocketImpl.socketConnect(Native Method)\n	at java.net.PlainSocketImpl.doConnect(PlainSocketImpl.java:333)\n	at java.net.PlainSocketImpl.connectToAddress(PlainSocketImpl.java:195)\n	at java.net.PlainSocketImpl.connect(PlainSocketImpl.java:182)\n	at java.net.SocksSocketImpl.connect(SocksSocketImpl.java:366)\n	at java.net.Socket.connect(Socket.java:519)\n	at java.net.Socket.connect(Socket.java:469)\n	at java.net.Socket.<init>(Socket.java:366)\n	at java.net.Socket.<init>(Socket.java:209)\n	at com.mysql.jdbc.StandardSocketFactory.connect(StandardSocketFactory.java:256)\n	at com.mysql.jdbc.MysqlIO.<init>(MysqlIO.java:271)\n	at com.mysql.jdbc.Connection.createNewIO(Connection.java:2771)\n	at com.mysql.jdbc.Connection.<init>(Connection.java:1555)\n	at com.mysql.jdbc.NonRegisteringDriver.connect(NonRegisteringDriver.java:285)\n	at java.sql.DriverManager.getConnection(DriverManager.java:582)\n	at java.sql.DriverManager.getConnection(DriverManager.java:185)\n	at org.apache.commons.dbcp.DriverManagerConnectionFactory.createConnection(DriverManagerConnectionFactory.java:48)\n	at org.apache.commons.dbcp.PoolableConnectionFactory.makeObject(PoolableConnectionFactory.java:290)\n	at org.apache.commons.pool.impl.GenericObjectPool.borrowObject(GenericObjectPool.java:771)\n	at org.apache.commons.dbcp.PoolingDataSource.getConnection(PoolingDataSource.java:95)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.JdbcDataSourceService.createConnection(JdbcDataSourceService.java:58)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.BaseJdbcDataSource.setReportParameterValues(BaseJdbcDataSource.java:52)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.JdbcDataSourceService.setReportParameterValues(JdbcDataSourceService.java:66)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.EngineServiceImpl.fillReport(EngineServiceImpl.java:633)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.EngineServiceImpl.fillReport(EngineServiceImpl.java:333)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.EngineServiceImpl.executeReport(EngineServiceImpl.java:765)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.domain.impl.ReportUnitRequest.execute(ReportUnitRequest.java:60)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.EngineServiceImpl.execute(EngineServiceImpl.java:265)\n	at com.jaspersoft.jasperserver.api.engine.scheduling.quartz.ReportExecutionJob.executeReport(ReportExecutionJob.java:441)\n	at com.jaspersoft.jasperserver.api.engine.scheduling.quartz.ReportExecutionJob.executeAndSendReport(ReportExecutionJob.java:369)\n	at com.jaspersoft.jasperserver.api.engine.scheduling.quartz.ReportExecutionJob.execute(ReportExecutionJob.java:188)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:195)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:520)\n\n\n** END NESTED EXCEPTION **\n\n\n\nLast packet sent to the server was 8 ms ago.\n	at com.mysql.jdbc.Connection.createNewIO(Connection.java:2847)\n	at com.mysql.jdbc.Connection.<init>(Connection.java:1555)\n	at com.mysql.jdbc.NonRegisteringDriver.connect(NonRegisteringDriver.java:285)\n	at java.sql.DriverManager.getConnection(DriverManager.java:582)\n	at java.sql.DriverManager.getConnection(DriverManager.java:185)\n	at org.apache.commons.dbcp.DriverManagerConnectionFactory.createConnection(DriverManagerConnectionFactory.java:48)\n	at org.apache.commons.dbcp.PoolableConnectionFactory.makeObject(PoolableConnectionFactory.java:290)\n	at org.apache.commons.pool.impl.GenericObjectPool.borrowObject(GenericObjectPool.java:771)\n	at org.apache.commons.dbcp.PoolingDataSource.getConnection(PoolingDataSource.java:95)\n	at com.jaspersoft.jasperserver.api.engine.jasperreports.service.impl.JdbcDataSourceService.createConnection(JdbcDataSourceService.java:58)\n	... 12 more\n',NULL,1);
/*!40000 ALTER TABLE `JILogEvent` ENABLE KEYS */;


--
-- Definition of table `JIMondrianConnection`
--

DROP TABLE IF EXISTS `JIMondrianConnection`;
CREATE TABLE `JIMondrianConnection` (
  `id` bigint(20) NOT NULL,
  `reportDataSource` bigint(20) default NULL,
  `mondrianSchema` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK4FF53B19C495A60B` (`mondrianSchema`),
  KEY `FK4FF53B19324CFECB` (`reportDataSource`),
  KEY `FK4FF53B191D51BFAD` (`id`),
  CONSTRAINT `FK4FF53B191D51BFAD` FOREIGN KEY (`id`) REFERENCES `JIOlapClientConnection` (`id`),
  CONSTRAINT `FK4FF53B19324CFECB` FOREIGN KEY (`reportDataSource`) REFERENCES `JIResource` (`id`),
  CONSTRAINT `FK4FF53B19C495A60B` FOREIGN KEY (`mondrianSchema`) REFERENCES `JIFileResource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIMondrianConnection`
--

/*!40000 ALTER TABLE `JIMondrianConnection` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIMondrianConnection` ENABLE KEYS */;


--
-- Definition of table `JIMondrianXMLADefinition`
--

DROP TABLE IF EXISTS `JIMondrianXMLADefinition`;
CREATE TABLE `JIMondrianXMLADefinition` (
  `id` bigint(20) NOT NULL,
  `catalog` varchar(100) NOT NULL,
  `mondrianConnection` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK313B2AB8DC098B1` (`mondrianConnection`),
  KEY `FK313B2AB8A8BF376D` (`id`),
  CONSTRAINT `FK313B2AB8A8BF376D` FOREIGN KEY (`id`) REFERENCES `JIResource` (`id`),
  CONSTRAINT `FK313B2AB8DC098B1` FOREIGN KEY (`mondrianConnection`) REFERENCES `JIMondrianConnection` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIMondrianXMLADefinition`
--

/*!40000 ALTER TABLE `JIMondrianXMLADefinition` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIMondrianXMLADefinition` ENABLE KEYS */;


--
-- Definition of table `JIObjectPermission`
--

DROP TABLE IF EXISTS `JIObjectPermission`;
CREATE TABLE `JIObjectPermission` (
  `id` bigint(20) NOT NULL auto_increment,
  `uri` varchar(255) NOT NULL,
  `recipientobjectclass` varchar(100) default NULL,
  `recipientobjectid` bigint(20) default NULL,
  `permissionMask` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIObjectPermission`
--

/*!40000 ALTER TABLE `JIObjectPermission` DISABLE KEYS */;
INSERT INTO `JIObjectPermission` (`id`,`uri`,`recipientobjectclass`,`recipientobjectid`,`permissionMask`) VALUES
 (1,'repo:/','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',2,1),
 (2,'repo:/','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',1,2),
 (7,'repo:/Reports','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',4,2),
 (10,'repo:/Reports/company1','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',1,0),
 (16,'repo:/Reports/Default','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',4,30),
 (18,'repo:/Reports/Default','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',8,1),
 (19,'repo:/Reports/Default','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',7,2),
 (23,'repo:/Reports/Default/Content_files','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',7,30),
 (26,'repo:/','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',4,2),
 (36,'repo:/datatypes','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',1,0),
 (37,'repo:/','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',8,2),
 (38,'repo:/','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',6,1),
 (46,'repo:/images','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',6,2),
 (48,'repo:/datatypes','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',6,2),
 (66,'repo:/Reports/company1','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',4,30),
 (71,'repo:/Reports/company1/Images','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',6,1),
 (72,'repo:/Reports/company1/Images','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',4,2),
 (73,'repo:/Reports/company1/Content_files','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',6,1),
 (74,'repo:/Reports/company1/Content_files','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',4,30),
 (76,'repo:/Reports/company1/templates','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',4,2),
 (77,'repo:/Reports/company1/templates','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',6,1),
 (86,'repo:/','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',7,2),
 (118,'repo:/Reports/company1','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',7,0),
 (121,'repo:/Reports/Default/Images','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',4,2),
 (123,'repo:/Reports/Default/templates','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',4,2),
 (128,'repo:/Reports/The_Guru_Folder','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',1,0),
 (130,'repo:/','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',18,1),
 (131,'repo:/','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',17,2),
 (132,'repo:/','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',13,2),
 (133,'repo:/','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',14,2),
 (134,'repo:/','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',15,1),
 (135,'repo:/','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',16,1),
 (136,'repo:/Reports/company1','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',16,0),
 (137,'repo:/Reports/company1','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',13,0),
 (138,'repo:/Reports/company1','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',14,0),
 (139,'repo:/Reports/company1','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',15,0),
 (140,'repo:/Reports/company1','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',18,0),
 (141,'repo:/Reports/company1','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',17,0),
 (142,'repo:/Reports/Default','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',13,30),
 (143,'repo:/Reports/Default','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',14,30),
 (144,'repo:/Reports/Default','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',17,30),
 (148,'repo:/Reports/demo','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',13,30),
 (149,'repo:/Reports/demo','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',14,30),
 (150,'repo:/Reports/demo','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',15,0),
 (151,'repo:/Reports/demo','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',4,0),
 (152,'repo:/Reports/demo','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',18,0),
 (153,'repo:/Reports/demo','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',6,0),
 (154,'repo:/Reports/demo','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',17,0),
 (155,'repo:/Reports/The_Guru_Folder','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',6,0),
 (156,'repo:/Reports/The_Guru_Folder','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',4,0),
 (157,'repo:/Reports/The_Guru_Folder','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',17,30),
 (158,'repo:/Reports/The_Guru_Folder','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',13,0),
 (159,'repo:/Reports/The_Guru_Folder','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',14,0),
 (160,'repo:/Reports/The_Guru_Folder','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',15,0),
 (161,'repo:/Reports/The_Guru_Folder','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',16,0),
 (162,'repo:/Reports/sandbox','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',16,0),
 (163,'repo:/Reports/sandbox','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',13,30),
 (164,'repo:/Reports/sandbox','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',14,0),
 (165,'repo:/Reports/sandbox','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',4,0),
 (166,'repo:/Reports/sandbox','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',1,0),
 (167,'repo:/Reports/sandbox','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',18,0),
 (168,'repo:/Reports/sandbox','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',6,0),
 (169,'repo:/Reports/sandbox','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',17,0),
 (170,'repo:/Reports/demo','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',1,0),
 (171,'repo:/Reports/demo','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',7,0),
 (172,'repo:/Reports/The_Guru_Folder','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',7,0),
 (173,'repo:/Reports/sandbox','com.jaspersoft.jasperserver.api.metadata.user.domain.impl.hibernate.RepoRole',7,0);
/*!40000 ALTER TABLE `JIObjectPermission` ENABLE KEYS */;


--
-- Definition of table `JIOlapClientConnection`
--

DROP TABLE IF EXISTS `JIOlapClientConnection`;
CREATE TABLE `JIOlapClientConnection` (
  `id` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK3CA3B7D4A8BF376D` (`id`),
  CONSTRAINT `FK3CA3B7D4A8BF376D` FOREIGN KEY (`id`) REFERENCES `JIResource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIOlapClientConnection`
--

/*!40000 ALTER TABLE `JIOlapClientConnection` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIOlapClientConnection` ENABLE KEYS */;


--
-- Definition of table `JIOlapUnit`
--

DROP TABLE IF EXISTS `JIOlapUnit`;
CREATE TABLE `JIOlapUnit` (
  `id` bigint(20) NOT NULL,
  `olapClientConnection` bigint(20) default NULL,
  `mdx_query` text NOT NULL,
  `view_options` longblob,
  PRIMARY KEY  (`id`),
  KEY `FKF034DCCF8F542247` (`olapClientConnection`),
  KEY `FKF034DCCFA8BF376D` (`id`),
  CONSTRAINT `FKF034DCCF8F542247` FOREIGN KEY (`olapClientConnection`) REFERENCES `JIOlapClientConnection` (`id`),
  CONSTRAINT `FKF034DCCFA8BF376D` FOREIGN KEY (`id`) REFERENCES `JIResource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIOlapUnit`
--

/*!40000 ALTER TABLE `JIOlapUnit` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIOlapUnit` ENABLE KEYS */;


--
-- Definition of table `JIProfileAttribute`
--

DROP TABLE IF EXISTS `JIProfileAttribute`;
CREATE TABLE `JIProfileAttribute` (
  `id` bigint(20) NOT NULL auto_increment,
  `attrName` varchar(255) NOT NULL,
  `attrValue` varchar(255) NOT NULL,
  `principalobjectclass` varchar(255) NOT NULL,
  `principalobjectid` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIProfileAttribute`
--

/*!40000 ALTER TABLE `JIProfileAttribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIProfileAttribute` ENABLE KEYS */;


--
-- Definition of table `JIQuery`
--

DROP TABLE IF EXISTS `JIQuery`;
CREATE TABLE `JIQuery` (
  `id` bigint(20) NOT NULL,
  `dataSource` bigint(20) default NULL,
  `query_language` varchar(40) NOT NULL,
  `sql_query` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FKCBCB0EC92B329A97` (`dataSource`),
  KEY `FKCBCB0EC9A8BF376D` (`id`),
  CONSTRAINT `FKCBCB0EC92B329A97` FOREIGN KEY (`dataSource`) REFERENCES `JIResource` (`id`),
  CONSTRAINT `FKCBCB0EC9A8BF376D` FOREIGN KEY (`id`) REFERENCES `JIResource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIQuery`
--

/*!40000 ALTER TABLE `JIQuery` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIQuery` ENABLE KEYS */;


--
-- Definition of table `JIReportJob`
--

DROP TABLE IF EXISTS `JIReportJob`;
CREATE TABLE `JIReportJob` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `label` varchar(100) NOT NULL,
  `description` text,
  `report_unit_uri` varchar(200) NOT NULL,
  `job_trigger` bigint(20) NOT NULL,
  `base_output_name` varchar(100) NOT NULL,
  `output_locale` varchar(20) default NULL,
  `content_destination` bigint(20) default NULL,
  `mail_notification` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK156F5F6AE4D73E35` (`mail_notification`),
  KEY `FK156F5F6A9EEC902C` (`content_destination`),
  KEY `FK156F5F6A74D2696E` (`job_trigger`),
  CONSTRAINT `FK156F5F6A74D2696E` FOREIGN KEY (`job_trigger`) REFERENCES `JIReportJobTrigger` (`id`),
  CONSTRAINT `FK156F5F6A9EEC902C` FOREIGN KEY (`content_destination`) REFERENCES `JIReportJobRepoDest` (`id`),
  CONSTRAINT `FK156F5F6AE4D73E35` FOREIGN KEY (`mail_notification`) REFERENCES `JIReportJobMail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIReportJob`
--

/*!40000 ALTER TABLE `JIReportJob` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIReportJob` ENABLE KEYS */;


--
-- Definition of table `JIReportJobCalendarTrigger`
--

DROP TABLE IF EXISTS `JIReportJobCalendarTrigger`;
CREATE TABLE `JIReportJobCalendarTrigger` (
  `id` bigint(20) NOT NULL,
  `minutes` varchar(200) NOT NULL,
  `hours` varchar(80) NOT NULL,
  `days_type` tinyint(4) NOT NULL,
  `week_days` varchar(20) default NULL,
  `month_days` varchar(100) default NULL,
  `months` varchar(40) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FKC374C7D0D2B2EB53` (`id`),
  CONSTRAINT `FKC374C7D0D2B2EB53` FOREIGN KEY (`id`) REFERENCES `JIReportJobTrigger` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIReportJobCalendarTrigger`
--

/*!40000 ALTER TABLE `JIReportJobCalendarTrigger` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIReportJobCalendarTrigger` ENABLE KEYS */;


--
-- Definition of table `JIReportJobMail`
--

DROP TABLE IF EXISTS `JIReportJobMail`;
CREATE TABLE `JIReportJobMail` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` int(11) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `send_type` tinyint(4) NOT NULL,
  `skip_empty` bit(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIReportJobMail`
--

/*!40000 ALTER TABLE `JIReportJobMail` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIReportJobMail` ENABLE KEYS */;


--
-- Definition of table `JIReportJobMailRecipient`
--

DROP TABLE IF EXISTS `JIReportJobMailRecipient`;
CREATE TABLE `JIReportJobMailRecipient` (
  `destination_id` bigint(20) NOT NULL,
  `recipient_type` tinyint(4) NOT NULL,
  `address` varchar(100) NOT NULL,
  `recipient_idx` int(11) NOT NULL,
  PRIMARY KEY  (`destination_id`,`recipient_idx`),
  KEY `FKBB6DB6D880001AAE` (`destination_id`),
  CONSTRAINT `FKBB6DB6D880001AAE` FOREIGN KEY (`destination_id`) REFERENCES `JIReportJobMail` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIReportJobMailRecipient`
--

/*!40000 ALTER TABLE `JIReportJobMailRecipient` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIReportJobMailRecipient` ENABLE KEYS */;


--
-- Definition of table `JIReportJobOutputFormat`
--

DROP TABLE IF EXISTS `JIReportJobOutputFormat`;
CREATE TABLE `JIReportJobOutputFormat` (
  `report_job_id` bigint(20) NOT NULL,
  `output_format` tinyint(4) NOT NULL,
  PRIMARY KEY  (`report_job_id`,`output_format`),
  KEY `FKB42A5CE2C3389A8` (`report_job_id`),
  CONSTRAINT `FKB42A5CE2C3389A8` FOREIGN KEY (`report_job_id`) REFERENCES `JIReportJob` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIReportJobOutputFormat`
--

/*!40000 ALTER TABLE `JIReportJobOutputFormat` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIReportJobOutputFormat` ENABLE KEYS */;


--
-- Definition of table `JIReportJobParameter`
--

DROP TABLE IF EXISTS `JIReportJobParameter`;
CREATE TABLE `JIReportJobParameter` (
  `job_id` bigint(20) NOT NULL,
  `parameter_value` blob,
  `parameter_name` varchar(100) NOT NULL,
  PRIMARY KEY  (`job_id`,`parameter_name`),
  KEY `FKEAC52B5F2EC643D` (`job_id`),
  CONSTRAINT `FKEAC52B5F2EC643D` FOREIGN KEY (`job_id`) REFERENCES `JIReportJob` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIReportJobParameter`
--

/*!40000 ALTER TABLE `JIReportJobParameter` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIReportJobParameter` ENABLE KEYS */;


--
-- Definition of table `JIReportJobRepoDest`
--

DROP TABLE IF EXISTS `JIReportJobRepoDest`;
CREATE TABLE `JIReportJobRepoDest` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` int(11) NOT NULL,
  `folder_uri` varchar(200) NOT NULL,
  `sequential_filenames` bit(1) NOT NULL,
  `overwrite_files` bit(1) NOT NULL,
  `output_description` varchar(100) default NULL,
  `timestamp_pattern` varchar(250) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIReportJobRepoDest`
--

/*!40000 ALTER TABLE `JIReportJobRepoDest` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIReportJobRepoDest` ENABLE KEYS */;


--
-- Definition of table `JIReportJobSimpleTrigger`
--

DROP TABLE IF EXISTS `JIReportJobSimpleTrigger`;
CREATE TABLE `JIReportJobSimpleTrigger` (
  `id` bigint(20) NOT NULL,
  `occurrence_count` int(11) NOT NULL,
  `recurrence_interval` int(11) default NULL,
  `recurrence_interval_unit` tinyint(4) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKB9337C5CD2B2EB53` (`id`),
  CONSTRAINT `FKB9337C5CD2B2EB53` FOREIGN KEY (`id`) REFERENCES `JIReportJobTrigger` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIReportJobSimpleTrigger`
--

/*!40000 ALTER TABLE `JIReportJobSimpleTrigger` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIReportJobSimpleTrigger` ENABLE KEYS */;


--
-- Definition of table `JIReportJobTrigger`
--

DROP TABLE IF EXISTS `JIReportJobTrigger`;
CREATE TABLE `JIReportJobTrigger` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` int(11) NOT NULL,
  `timezone` varchar(40) default NULL,
  `start_type` tinyint(4) NOT NULL,
  `start_date` datetime default NULL,
  `end_date` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIReportJobTrigger`
--

/*!40000 ALTER TABLE `JIReportJobTrigger` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIReportJobTrigger` ENABLE KEYS */;


--
-- Definition of table `JIReportUnit`
--

DROP TABLE IF EXISTS `JIReportUnit`;
CREATE TABLE `JIReportUnit` (
  `id` bigint(20) NOT NULL,
  `reportDataSource` bigint(20) default NULL,
  `query` bigint(20) default NULL,
  `mainReport` bigint(20) default NULL,
  `controlrenderer` varchar(100) default NULL,
  `reportrenderer` varchar(100) default NULL,
  `promptcontrols` bit(1) default NULL,
  `controlslayout` tinyint(4) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK98818B778FDA11CC` (`query`),
  KEY `FK98818B77324CFECB` (`reportDataSource`),
  KEY `FK98818B778C8DF21B` (`mainReport`),
  KEY `FK98818B77A8BF376D` (`id`),
  CONSTRAINT `FK98818B77324CFECB` FOREIGN KEY (`reportDataSource`) REFERENCES `JIResource` (`id`),
  CONSTRAINT `FK98818B778C8DF21B` FOREIGN KEY (`mainReport`) REFERENCES `JIFileResource` (`id`),
  CONSTRAINT `FK98818B778FDA11CC` FOREIGN KEY (`query`) REFERENCES `JIQuery` (`id`),
  CONSTRAINT `FK98818B77A8BF376D` FOREIGN KEY (`id`) REFERENCES `JIResource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIReportUnit`
--

/*!40000 ALTER TABLE `JIReportUnit` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIReportUnit` ENABLE KEYS */;


--
-- Definition of table `JIReportUnitInputControl`
--

DROP TABLE IF EXISTS `JIReportUnitInputControl`;
CREATE TABLE `JIReportUnitInputControl` (
  `report_unit_id` bigint(20) NOT NULL,
  `input_control_id` bigint(20) NOT NULL,
  `control_index` int(11) NOT NULL,
  PRIMARY KEY  (`report_unit_id`,`control_index`),
  KEY `FK5FBE934AE7922149` (`input_control_id`),
  KEY `FK5FBE934AA6A48880` (`report_unit_id`),
  CONSTRAINT `FK5FBE934AA6A48880` FOREIGN KEY (`report_unit_id`) REFERENCES `JIReportUnit` (`id`),
  CONSTRAINT `FK5FBE934AE7922149` FOREIGN KEY (`input_control_id`) REFERENCES `JIInputControl` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIReportUnitInputControl`
--

/*!40000 ALTER TABLE `JIReportUnitInputControl` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIReportUnitInputControl` ENABLE KEYS */;


--
-- Definition of table `JIReportUnitResource`
--

DROP TABLE IF EXISTS `JIReportUnitResource`;
CREATE TABLE `JIReportUnitResource` (
  `report_unit_id` bigint(20) NOT NULL,
  `resource_id` bigint(20) NOT NULL,
  `resource_index` int(11) NOT NULL,
  PRIMARY KEY  (`report_unit_id`,`resource_index`),
  KEY `FK8B1C4CA5865B10DA` (`resource_id`),
  KEY `FK8B1C4CA5A6A48880` (`report_unit_id`),
  CONSTRAINT `FK8B1C4CA5865B10DA` FOREIGN KEY (`resource_id`) REFERENCES `JIFileResource` (`id`),
  CONSTRAINT `FK8B1C4CA5A6A48880` FOREIGN KEY (`report_unit_id`) REFERENCES `JIReportUnit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIReportUnitResource`
--

/*!40000 ALTER TABLE `JIReportUnitResource` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIReportUnitResource` ENABLE KEYS */;


--
-- Definition of table `JIRepositoryCache`
--

DROP TABLE IF EXISTS `JIRepositoryCache`;
CREATE TABLE `JIRepositoryCache` (
  `id` bigint(20) NOT NULL auto_increment,
  `uri` varchar(200) NOT NULL,
  `cache_name` varchar(20) NOT NULL,
  `data` longblob,
  `version` int(11) NOT NULL,
  `version_date` datetime NOT NULL,
  `item_reference` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uri` (`uri`,`cache_name`),
  KEY `FKE7338B19E7C5A6` (`item_reference`),
  CONSTRAINT `FKE7338B19E7C5A6` FOREIGN KEY (`item_reference`) REFERENCES `JIRepositoryCache` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1211 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIRepositoryCache`
--

/*!40000 ALTER TABLE `JIRepositoryCache` DISABLE KEYS */;
INSERT INTO `JIRepositoryCache` (`id`,`uri`,`cache_name`,`data`,`version`,`version_date`,`item_reference`) VALUES
 (403,'/Reports/Default/templates/mpower_template_landscape_files/mpower_template_landscape_jrxml','JasperReport',0xACED0005737200286E65742E73662E6A61737065727265706F7274732E656E67696E652E4A61737065725265706F727400000000000027D80200034C000B636F6D70696C65446174617400164C6A6176612F696F2F53657269616C697A61626C653B4C0011636F6D70696C654E616D655375666669787400124C6A6176612F6C616E672F537472696E673B4C000D636F6D70696C6572436C61737371007E00027872002D6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A52426173655265706F727400000000000027D802002549000C626F74746F6D4D617267696E49000B636F6C756D6E436F756E7449000D636F6C756D6E53706163696E6749000B636F6C756D6E57696474685A001069676E6F7265506167696E6174696F6E5A00136973466C6F6174436F6C756D6E466F6F7465725A0010697353756D6D6172794E6577506167655A000E69735469746C654E65775061676549000A6C6566744D617267696E42000B6F7269656E746174696F6E49000A7061676548656967687449000970616765576964746842000A7072696E744F7264657249000B72696768744D617267696E490009746F704D617267696E42000E7768656E4E6F44617461547970654C000A6261636B67726F756E647400244C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5242616E643B4C000C636F6C756D6E466F6F74657271007E00044C000C636F6C756D6E48656164657271007E00045B000864617461736574737400285B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52446174617365743B4C000B64656661756C74466F6E7474002A4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525265706F7274466F6E743B4C000C64656661756C745374796C657400254C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525374796C653B4C000664657461696C71007E00045B0005666F6E747374002B5B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525265706F7274466F6E743B4C0012666F726D6174466163746F7279436C61737371007E00024C000A696D706F72747353657474000F4C6A6176612F7574696C2F5365743B4C00086C616E677561676571007E00024C000E6C61737450616765466F6F74657271007E00044C000B6D61696E446174617365747400274C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52446174617365743B4C00046E616D6571007E00024C00066E6F4461746171007E00044C000A70616765466F6F74657271007E00044C000A7061676548656164657271007E00045B00067374796C65737400265B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525374796C653B4C000773756D6D61727971007E00045B000974656D706C6174657374002F5B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525265706F727454656D706C6174653B4C00057469746C6571007E0004787000000014000000010000000000000217000000000000001E02000002530000034A010000001E00000014017372002B6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736542616E6400000000000027D80200034900066865696768745A000E697353706C6974416C6C6F7765644C00137072696E745768656E45787072657373696F6E74002A4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5245787072657373696F6E3B787200336E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365456C656D656E7447726F757000000000000027D80200024C00086368696C6472656E7400104C6A6176612F7574696C2F4C6973743B4C000C656C656D656E7447726F757074002C4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52456C656D656E7447726F75703B7870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000077040000000A78700000000001707371007E000E7371007E00140000000077040000000A78700000001E01707371007E000E7371007E00140000000077040000000A78700000001E01707070707371007E000E7371007E00140000000077040000000A78700000006401707070737200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000043F400000000000037400226E65742E73662E6A61737065727265706F7274732E656E67696E652E646174612E2A74001D6E65742E73662E6A61737065727265706F7274732E656E67696E652E2A74000B6A6176612E7574696C2E2A787400046A6176617371007E000E7371007E00140000000277040000000A737200306E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365546578744669656C6400000000000027D802001049000D626F6F6B6D61726B4C6576656C42000E6576616C756174696F6E54696D6542000F68797065726C696E6B54617267657442000D68797065726C696E6B547970655A0015697353747265746368576974684F766572666C6F774C0014616E63686F724E616D6545787072657373696F6E71007E000F4C000F6576616C756174696F6E47726F75707400254C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5247726F75703B4C000A65787072657373696F6E71007E000F4C001968797065726C696E6B416E63686F7245787072657373696F6E71007E000F4C001768797065726C696E6B5061676545787072657373696F6E71007E000F5B001368797065726C696E6B506172616D65746572737400335B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5248797065726C696E6B506172616D657465723B4C001C68797065726C696E6B5265666572656E636545787072657373696F6E71007E000F4C001A68797065726C696E6B546F6F6C74697045787072657373696F6E71007E000F4C000F6973426C616E6B5768656E4E756C6C7400134C6A6176612F6C616E672F426F6F6C65616E3B4C00086C696E6B5479706571007E00024C00077061747465726E71007E0002787200326E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736554657874456C656D656E7400000000000027D80200204C0006626F726465727400104C6A6176612F6C616E672F427974653B4C000B626F72646572436F6C6F727400104C6A6176612F6177742F436F6C6F723B4C000C626F74746F6D426F7264657271007E00294C0011626F74746F6D426F72646572436F6C6F7271007E002A4C000D626F74746F6D50616464696E677400134C6A6176612F6C616E672F496E74656765723B4C0008666F6E744E616D6571007E00024C0008666F6E7453697A6571007E002B4C0013686F72697A6F6E74616C416C69676E6D656E7471007E00294C00066973426F6C6471007E00274C000869734974616C696371007E00274C000D6973506466456D62656464656471007E00274C000F6973537472696B655468726F75676871007E00274C000C69735374796C65645465787471007E00274C000B6973556E6465726C696E6571007E00274C000A6C656674426F7264657271007E00294C000F6C656674426F72646572436F6C6F7271007E002A4C000B6C65667450616464696E6771007E002B4C00076C696E65426F787400274C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A524C696E65426F783B4C000B6C696E6553706163696E6771007E00294C00066D61726B757071007E00024C000770616464696E6771007E002B4C000B706466456E636F64696E6771007E00024C000B706466466F6E744E616D6571007E00024C000A7265706F7274466F6E7471007E00064C000B7269676874426F7264657271007E00294C00107269676874426F72646572436F6C6F7271007E002A4C000C726967687450616464696E6771007E002B4C0008726F746174696F6E71007E00294C0009746F70426F7264657271007E00294C000E746F70426F72646572436F6C6F7271007E002A4C000A746F7050616464696E6771007E002B4C0011766572746963616C416C69676E6D656E7471007E00297872002E6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365456C656D656E7400000000000027D80200164900066865696768745A001769735072696E74496E466972737457686F6C6542616E645A001569735072696E74526570656174656456616C7565735A001A69735072696E745768656E44657461696C4F766572666C6F77735A0015697352656D6F76654C696E655768656E426C616E6B42000C706F736974696F6E5479706542000B7374726574636854797065490005776964746849000178490001794C00096261636B636F6C6F7271007E002A4C001464656661756C745374796C6550726F76696465727400344C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5244656661756C745374796C6550726F76696465723B4C000C656C656D656E7447726F757071007E00124C0009666F7265636F6C6F7271007E002A4C00036B657971007E00024C00046D6F646571007E00294C000B706172656E745374796C6571007E00074C0018706172656E745374796C654E616D655265666572656E636571007E00024C00137072696E745768656E45787072657373696F6E71007E000F4C00157072696E745768656E47726F75704368616E67657371007E00254C000D70726F706572746965734D617074002D4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5250726F706572746965734D61703B5B001370726F706572747945787072657373696F6E737400335B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5250726F706572747945787072657373696F6E3B7870000000120001000002000000006300000114000000127071007E000D71007E00227074000B746578744669656C642D3170707070707070707070707070707372000E6A6176612E6C616E672E427974659C4E6084EE50F51C02000142000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870037070707070707070707372002E6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A52426173654C696E65426F7800000000000027D802000B4C000D626F74746F6D50616464696E6771007E002B4C0009626F74746F6D50656E74002B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F626173652F4A52426F7850656E3B4C000C626F78436F6E7461696E657274002C4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52426F78436F6E7461696E65723B4C000B6C65667450616464696E6771007E002B4C00076C65667450656E71007E00374C000770616464696E6771007E002B4C000370656E71007E00374C000C726967687450616464696E6771007E002B4C0008726967687450656E71007E00374C000A746F7050616464696E6771007E002B4C0006746F7050656E71007E0037787070737200336E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365426F78426F74746F6D50656E00000000000027D80200007872002D6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365426F7850656E00000000000027D80200014C00076C696E65426F7871007E002C7872002A6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736550656E00000000000027D80200044C00096C696E65436F6C6F7271007E002A4C00096C696E655374796C6571007E00294C00096C696E6557696474687400114C6A6176612F6C616E672F466C6F61743B4C000C70656E436F6E7461696E657274002C4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5250656E436F6E7461696E65723B787070707071007E003971007E003971007E003170737200316E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365426F784C65667450656E00000000000027D80200007871007E003B70707071007E003971007E0039707371007E003B70707071007E003971007E003970737200326E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365426F78526967687450656E00000000000027D80200007871007E003B70707071007E003971007E003970737200306E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365426F78546F7050656E00000000000027D80200007871007E003B70707071007E003971007E0039707070707070707070707070707000000000010100007070737200316E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736545787072657373696F6E00000000000027D802000449000269645B00066368756E6B737400305B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5245787072657373696F6E4368756E6B3B4C000E76616C7565436C6173734E616D6571007E00024C001276616C7565436C6173735265616C4E616D6571007E000278700000000C757200305B4C6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A5245787072657373696F6E4368756E6B3B6D59CFDE694BA355020000787000000003737200366E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736545787072657373696F6E4368756E6B00000000000027D8020002420004747970654C00047465787471007E000278700174000A22506167652022202B207371007E004C0474000B504147455F4E554D4245527371007E004C01740009202B2022206F6620227400106A6176612E6C616E672E537472696E67707070707070737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C75657870007400044E6F6E65707371007E002400000012000100000200000000640000017C000000127071007E000D71007E00227074000B746578744669656C642D327070707070707070707070707070707070707070707070707371007E0036707371007E003A70707071007E005971007E005971007E0057707371007E004070707071007E005971007E0059707371007E003B70707071007E005971007E0059707371007E004370707071007E005971007E0059707371007E004570707071007E005971007E00597070707070707070707070707070000000000201000070707371007E00470000000D7571007E004A000000037371007E004C017400052222202B207371007E004C0474000B504147455F4E554D4245527371007E004C01740005202B2022227400106A6176612E6C616E672E537472696E6770707070707071007E00557400044E6F6E657078700000003201707372002E6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A52426173654461746173657400000000000027D802000D5A000669734D61696E4200177768656E5265736F757263654D697373696E67547970655B00066669656C64737400265B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A524669656C643B4C001066696C74657245787072657373696F6E71007E000F5B000667726F7570737400265B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5247726F75703B4C00046E616D6571007E00025B000A706172616D657465727374002A5B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52506172616D657465723B4C000D70726F706572746965734D617071007E002F4C000571756572797400254C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5251756572793B4C000E7265736F7572636542756E646C6571007E00024C000E7363726970746C6574436C61737371007E00025B000A736F72744669656C647374002A5B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52536F72744669656C643B5B00097661726961626C65737400295B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525661726961626C653B787001017070707400236D706F7765725F74656D706C6174655F6A72786D6C5F313232313136313734383834397572002A5B4C6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A52506172616D657465723B22000C8D2AC3602102000078700000000F737200306E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365506172616D6574657200000000000027D80200085A000E6973466F7250726F6D7074696E675A000F697353797374656D446566696E65644C001664656661756C7456616C756545787072657373696F6E71007E000F4C000B6465736372697074696F6E71007E00024C00046E616D6571007E00024C000D70726F706572746965734D617071007E002F4C000E76616C7565436C6173734E616D6571007E00024C001276616C7565436C6173735265616C4E616D6571007E00027870010170707400155245504F52545F504152414D45544552535F4D41507372002B6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A5250726F706572746965734D617000000000000027D80200034C00046261736571007E002F4C000E70726F706572746965734C69737471007E00114C000D70726F706572746965734D617074000F4C6A6176612F7574696C2F4D61703B787070707074000D6A6176612E7574696C2E4D6170707371007E0074010170707400115245504F52545F434F4E4E454354494F4E7371007E00777070707400136A6176612E73716C2E436F6E6E656374696F6E707371007E0074010170707400105245504F52545F4D41585F434F554E547371007E00777070707400116A6176612E6C616E672E496E7465676572707371007E0074010170707400125245504F52545F444154415F534F555243457371007E00777070707400286E65742E73662E6A61737065727265706F7274732E656E67696E652E4A5244617461536F75726365707371007E0074010170707400105245504F52545F5343524950544C45547371007E007770707074002F6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A5241627374726163745363726970746C6574707371007E00740101707074000D5245504F52545F4C4F43414C457371007E00777070707400106A6176612E7574696C2E4C6F63616C65707371007E0074010170707400165245504F52545F5245534F555243455F42554E444C457371007E00777070707400186A6176612E7574696C2E5265736F7572636542756E646C65707371007E0074010170707400105245504F52545F54494D455F5A4F4E457371007E00777070707400126A6176612E7574696C2E54696D655A6F6E65707371007E0074010170707400155245504F52545F464F524D41545F464143544F52597371007E007770707074002E6E65742E73662E6A61737065727265706F7274732E656E67696E652E7574696C2E466F726D6174466163746F7279707371007E0074010170707400135245504F52545F434C4153535F4C4F414445527371007E00777070707400156A6176612E6C616E672E436C6173734C6F61646572707371007E00740101707074001A5245504F52545F55524C5F48414E444C45525F464143544F52597371007E00777070707400206A6176612E6E65742E55524C53747265616D48616E646C6572466163746F7279707371007E0074010170707400145245504F52545F46494C455F5245534F4C5645527371007E007770707074002D6E65742E73662E6A61737065727265706F7274732E656E67696E652E7574696C2E46696C655265736F6C766572707371007E0074010170707400125245504F52545F5649525455414C495A45527371007E00777070707400296E65742E73662E6A61737065727265706F7274732E656E67696E652E4A525669727475616C697A6572707371007E00740101707074001449535F49474E4F52455F504147494E4154494F4E7371007E00777070707400116A6176612E6C616E672E426F6F6C65616E707371007E0074010170707400105245504F52545F54454D504C415445537371007E00777070707400146A6176612E7574696C2E436F6C6C656374696F6E707371007E0077707371007E00140000000277040000000A740019697265706F72742E7363726970746C657468616E646C696E67740010697265706F72742E656E636F64696E6778737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000271007E00B67400055554462D3871007E00B5740001307870707070757200295B4C6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A525661726961626C653B62E6837C982CB7440200007870000000057372002F6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A52426173655661726961626C6500000000000027D802000D42000B63616C63756C6174696F6E42000D696E6372656D656E74547970655A000F697353797374656D446566696E65644200097265736574547970654C000A65787072657373696F6E71007E000F4C000E696E6372656D656E7447726F757071007E00254C001B696E6372656D656E746572466163746F7279436C6173734E616D6571007E00024C001F696E6372656D656E746572466163746F7279436C6173735265616C4E616D6571007E00024C0016696E697469616C56616C756545787072657373696F6E71007E000F4C00046E616D6571007E00024C000A726573657447726F757071007E00254C000E76616C7565436C6173734E616D6571007E00024C001276616C7565436C6173735265616C4E616D6571007E0002787008050101707070707371007E0047000000007571007E004A000000017371007E004C0174000E6E657720496E746567657228312971007E00827074000B504147455F4E554D4245527071007E0082707371007E00BD08050102707070707371007E0047000000017571007E004A000000017371007E004C0174000E6E657720496E746567657228312971007E00827074000D434F4C554D4E5F4E554D4245527071007E0082707371007E00BD010501017371007E0047000000027571007E004A000000017371007E004C0174000E6E657720496E746567657228312971007E0082707070707371007E0047000000037571007E004A000000017371007E004C0174000E6E657720496E746567657228302971007E00827074000C5245504F52545F434F554E547071007E0082707371007E00BD010501027371007E0047000000047571007E004A000000017371007E004C0174000E6E657720496E746567657228312971007E0082707070707371007E0047000000057571007E004A000000017371007E004C0174000E6E657720496E746567657228302971007E00827074000A504147455F434F554E547071007E0082707371007E00BD010501037371007E0047000000067571007E004A000000017371007E004C0174000E6E657720496E746567657228312971007E0082707070707371007E0047000000077571007E004A000000017371007E004C0174000E6E657720496E746567657228302971007E00827074000C434F4C554D4E5F434F554E547071007E00827071007E0071707371007E000E7371007E00140000000277040000000A7371007E0024000000120001000002000000006300000111000000127071007E000D71007E00E870740009746578744669656C64707070707070707070707070707071007E00357070707070707070707371007E0036707371007E003A70707071007E00EC71007E00EC71007E00EA707371007E004070707071007E00EC71007E00EC707371007E003B70707071007E00EC71007E00EC707371007E004370707071007E00EC71007E00EC707371007E004570707071007E00EC71007E00EC7070707070707070707070707070000000000101000070707371007E00470000000A7571007E004A000000037371007E004C0174000A22506167652022202B207371007E004C0474000B504147455F4E554D4245527371007E004C01740009202B2022206F6620227400106A6176612E6C616E672E537472696E6770707070707071007E00557400044E6F6E65707371007E0024000000120001000002000000006400000179000000127071007E000D71007E00E870740009746578744669656C647070707070707070707070707070707070707070707070707371007E0036707371007E003A70707071007E00FE71007E00FE71007E00FC707371007E004070707071007E00FE71007E00FE707371007E003B70707071007E00FE71007E00FE707371007E004370707071007E00FE71007E00FE707371007E004570707071007E00FE71007E00FE7070707070707070707070707070000000000201000070707371007E00470000000B7571007E004A000000037371007E004C017400052222202B207371007E004C0474000B504147455F4E554D4245527371007E004C01740005202B2022227400106A6176612E6C616E672E537472696E6770707070707071007E00557400044E6F6E657078700000003201707371007E000E7371007E00140000000077040000000A7870000000110170757200265B4C6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A525374796C653BD49CC311D90572350200007870000000087372002C6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A52426173655374796C6500000000000027110200315A0009697344656661756C744C00096261636B636F6C6F7271007E002A4C0006626F7264657271007E00294C000B626F72646572436F6C6F7271007E002A4C000C626F74746F6D426F7264657271007E00294C0011626F74746F6D426F72646572436F6C6F7271007E002A4C000D626F74746F6D50616464696E6771007E002B5B0011636F6E646974696F6E616C5374796C65737400315B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52436F6E646974696F6E616C5374796C653B4C001464656661756C745374796C6550726F766964657271007E002E4C000466696C6C71007E00294C0008666F6E744E616D6571007E00024C0008666F6E7453697A6571007E002B4C0009666F7265636F6C6F7271007E002A4C0013686F72697A6F6E74616C416C69676E6D656E7471007E00294C000F6973426C616E6B5768656E4E756C6C71007E00274C00066973426F6C6471007E00274C000869734974616C696371007E00274C000D6973506466456D62656464656471007E00274C000F6973537472696B655468726F75676871007E00274C000C69735374796C65645465787471007E00274C000B6973556E6465726C696E6571007E00274C000A6C656674426F7264657271007E00294C000F6C656674426F72646572436F6C6F7271007E002A4C000B6C65667450616464696E6771007E002B4C00076C696E65426F7871007E002C4C00076C696E6550656E7400234C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5250656E3B4C000B6C696E6553706163696E6771007E00294C00066D61726B757071007E00024C00046D6F646571007E00294C00046E616D6571007E00024C000770616464696E6771007E002B4C000B706172656E745374796C6571007E00074C0018706172656E745374796C654E616D655265666572656E636571007E00024C00077061747465726E71007E00024C000B706466456E636F64696E6771007E00024C000B706466466F6E744E616D6571007E00024C000370656E71007E00294C000C706F736974696F6E5479706571007E00294C000672616469757371007E002B4C000B7269676874426F7264657271007E00294C00107269676874426F72646572436F6C6F7271007E002A4C000C726967687450616464696E6771007E002B4C0008726F746174696F6E71007E00294C000A7363616C65496D61676571007E00294C000B737472657463685479706571007E00294C0009746F70426F7264657271007E00294C000E746F70426F72646572436F6C6F7271007E002A4C000A746F7050616464696E6771007E002B4C0011766572746963616C416C69676E6D656E7471007E0029787000707070707070707070740005417269616C737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E00340000000E707371007E003301707070707070707070707371007E0036707371007E003A70707071007E011A71007E011A71007E0115707371007E004070707071007E011A71007E011A707371007E003B70707071007E011A71007E011A707371007E004370707071007E011A71007E011A707371007E004570707071007E011A71007E011A7371007E003C70707071007E011570707074000664657461696C707070707070707070707070707070707070707371007E0112007372000E6A6176612E6177742E436F6C6F7201A51783108F337502000546000666616C70686149000576616C75654C0002637374001B4C6A6176612F6177742F636F6C6F722F436F6C6F7253706163653B5B00096672676276616C75657400025B465B00066676616C756571007E0125787000000000FF6666667070707070707070707070740005417269616C7371007E01170000000E7371007E012300000000FFFFFFFF70707071007E0119707371007E00540171007E0055707070707070707371007E0036707371007E003A7371007E012300000000FF000000707070707372000F6A6176612E6C616E672E466C6F6174DAEDC9A2DB3CF0EC02000146000576616C75657871007E00343F80000071007E012B71007E012B71007E0122707371007E00407371007E012300000000FF000000707070707371007E012E0000000071007E012B71007E012B707371007E003B7371007E012300000000FF000000707070707371007E012E3F40000071007E012B71007E012B707371007E00437371007E012300000000FF000000707070707371007E012E0000000071007E012B71007E012B707371007E00457371007E012300000000FF000000707070707371007E012E0000000071007E012B71007E012B7371007E003C70707071007E012270707371007E003301740006686561646572707070707070707070707070707070707070707371007E011200707070707070707070740005417269616C7371007E01170000000E7071007E01197071007E012A70707070707070707371007E0036707371007E003A70707371007E012E3F80000071007E014271007E014271007E013F707371007E004070707071007E014271007E0142707371007E003B70707071007E014271007E0142707371007E004370707071007E014271007E0142707371007E004570707071007E014271007E01427371007E003C70707071007E013F70707074000F6865616465725661726961626C6573707070707070707070707070707070707070707371007E01120070707070707070707074000756657264616E617371007E01170000001270707071007E012A70707070707070707371007E0036707371007E003A70707071007E014E71007E014E71007E014B707371007E004070707071007E014E71007E014E707371007E003B70707071007E014E71007E014E707371007E004370707071007E014E71007E014E707371007E004570707071007E014E71007E014E7371007E003C70707071007E014B70707074000A7469746C655374796C65707070707070707070707070707070707070707371007E01120070707070707070707070707071007E0035707070707070707070707371007E0036707371007E003A70707071007E015771007E015771007E0156707371007E004070707071007E015771007E0157707371007E003B70707071007E015771007E0157707371007E004370707071007E015771007E0157707371007E004570707071007E015771007E01577371007E003C70707071007E015670707074000C696D706F7274655374796C65707070707070707070707070707070707070707371007E0112007371007E012300000000FFCCCCCC707070707070707070707070707070707070707070707070707371007E0036707371007E003A70707071007E016171007E016171007E015F707371007E004070707071007E016171007E0161707371007E003B70707071007E016171007E0161707371007E004370707071007E016171007E0161707371007E004570707071007E016171007E01617371007E003C70707071007E015F707071007E013D74000B6F6464526F775374796C65707070707070707070707070707070707070707371007E011200707070707070707070740005417269616C707070707071007E00557071007E00557071007E00557070707371007E0036707371007E003A70707071007E016B71007E016B71007E0169707371007E004070707071007E016B71007E016B707371007E003B70707071007E016B71007E016B707371007E004370707071007E016B71007E016B707371007E004570707071007E016B71007E016B7371007E003C70707071007E016970707074000C53756D6D6172795374796C65707070707070707070707070707070707070707371007E01120070707070707070707070707371007E012300000000FF316AC5707070707070707071007E005570707070707371007E0036707371007E003A70707071007E017571007E017571007E0173707371007E004070707071007E017571007E0175707371007E003B70707071007E017571007E0175707371007E004370707071007E017571007E0175707371007E004570707071007E017571007E01757371007E003C70707071007E017370707074001053756D6D6172795374796C65426C75657071007E016970707070707070707070707070707070707371007E000E7371007E00140000000077040000000A7870000000320170707371007E000E7371007E00140000000277040000000A7371007E00240000001200010000020000000064000002AA000000007071007E000D71007E017F70740009746578744669656C647070707070707070707070707070707070707070707070707371007E0036707371007E003A70707071007E018371007E018371007E0181707371007E004070707071007E018371007E0183707371007E003B70707071007E018371007E0183707371007E004370707071007E018371007E0183707371007E004570707071007E018371007E01837070707070707070707070707070000000000201000070707371007E0047000000087571007E004A000000017371007E004C017400146E6577206A6176612E7574696C2E44617465282974000E6A6176612E7574696C2E4461746570707070707071007E00557400044E6F6E6574000A64642F4D4D2F797979797372002C6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365496D61676500000000000027D802002349000D626F6F6B6D61726B4C6576656C42000E6576616C756174696F6E54696D6542000F68797065726C696E6B54617267657442000D68797065726C696E6B547970655A000669734C617A7942000B6F6E4572726F72547970654C0014616E63686F724E616D6545787072657373696F6E71007E000F4C0006626F7264657271007E00294C000B626F72646572436F6C6F7271007E002A4C000C626F74746F6D426F7264657271007E00294C0011626F74746F6D426F72646572436F6C6F7271007E002A4C000D626F74746F6D50616464696E6771007E002B4C000F6576616C756174696F6E47726F757071007E00254C000A65787072657373696F6E71007E000F4C0013686F72697A6F6E74616C416C69676E6D656E7471007E00294C001968797065726C696E6B416E63686F7245787072657373696F6E71007E000F4C001768797065726C696E6B5061676545787072657373696F6E71007E000F5B001368797065726C696E6B506172616D657465727371007E00264C001C68797065726C696E6B5265666572656E636545787072657373696F6E71007E000F4C001A68797065726C696E6B546F6F6C74697045787072657373696F6E71007E000F4C000C69735573696E67436163686571007E00274C000A6C656674426F7264657271007E00294C000F6C656674426F72646572436F6C6F7271007E002A4C000B6C65667450616464696E6771007E002B4C00076C696E65426F7871007E002C4C00086C696E6B5479706571007E00024C000770616464696E6771007E002B4C000B7269676874426F7264657271007E00294C00107269676874426F72646572436F6C6F7271007E002A4C000C726967687450616464696E6771007E002B4C000A7363616C65496D61676571007E00294C0009746F70426F7264657271007E00294C000E746F70426F72646572436F6C6F7271007E002A4C000A746F7050616464696E6771007E002B4C0011766572746963616C416C69676E6D656E7471007E0029787200356E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736547726170686963456C656D656E7400000000000027D80200034C000466696C6C71007E00294C00076C696E6550656E71007E01144C000370656E71007E00297871007E002D00000057010100000202000000FB00000000000000007071007E000D71007E017F70740007696D6167652D3170707070707070707371007E003C70707071007E019270000000000101000001707070707070707371007E0047000000097571007E004A000000017371007E004C0174001D227265706F3A2F496D616765732F6D706F7765724C6F676F2E676966227400106A6176612E6C616E672E537472696E6770707070707070707070707371007E0036707371007E003A70707071007E019A71007E019A71007E0192707371007E004070707071007E019A71007E019A707371007E003B70707071007E019A71007E019A707371007E004370707071007E019A71007E019A707371007E004570707071007E019A71007E019A7400044E6F6E6570707070707070707078700000005F0170737200366E65742E73662E6A61737065727265706F7274732E656E67696E652E64657369676E2E4A525265706F7274436F6D70696C654461746100000000000027D80200034C001363726F7373746162436F6D70696C654461746171007E00784C001264617461736574436F6D70696C654461746171007E00784C00166D61696E44617461736574436F6D70696C654461746171007E000178707371007E00B73F4000000000000C77080000001000000000787371007E00B73F4000000000000C7708000000100000000078757200025B42ACF317F8060854E00200007870000012D2CAFEBABE0000002E00B80100386D706F7765725F74656D706C6174655F6A72786D6C5F313232313136313734383834395F313233373438393535333838395F35323533353407000101002C6E65742F73662F6A61737065727265706F7274732F656E67696E652F66696C6C2F4A524576616C7561746F72070003010017706172616D657465725F5245504F52545F4C4F43414C450100324C6E65742F73662F6A61737065727265706F7274732F656E67696E652F66696C6C2F4A5246696C6C506172616D657465723B01001A706172616D657465725F5245504F52545F54494D455F5A4F4E4501001C706172616D657465725F5245504F52545F5649525455414C495A455201001E706172616D657465725F5245504F52545F46494C455F5245534F4C56455201001A706172616D657465725F5245504F52545F5343524950544C455401001F706172616D657465725F5245504F52545F504152414D45544552535F4D415001001B706172616D657465725F5245504F52545F434F4E4E454354494F4E01001D706172616D657465725F5245504F52545F434C4153535F4C4F4144455201001C706172616D657465725F5245504F52545F444154415F534F55524345010024706172616D657465725F5245504F52545F55524C5F48414E444C45525F464143544F525901001E706172616D657465725F49535F49474E4F52455F504147494E4154494F4E01001F706172616D657465725F5245504F52545F464F524D41545F464143544F525901001A706172616D657465725F5245504F52545F4D41585F434F554E5401001A706172616D657465725F5245504F52545F54454D504C41544553010020706172616D657465725F5245504F52545F5245534F555243455F42554E444C450100147661726961626C655F504147455F4E554D4245520100314C6E65742F73662F6A61737065727265706F7274732F656E67696E652F66696C6C2F4A5246696C6C5661726961626C653B0100167661726961626C655F434F4C554D4E5F4E554D4245520100157661726961626C655F5245504F52545F434F554E540100137661726961626C655F504147455F434F554E540100157661726961626C655F434F4C554D4E5F434F554E540100063C696E69743E010003282956010004436F64650C001B001C0A0004001E0C0005000609000200200C0007000609000200220C0008000609000200240C0009000609000200260C000A000609000200280C000B0006090002002A0C000C0006090002002C0C000D0006090002002E0C000E000609000200300C000F000609000200320C0010000609000200340C0011000609000200360C0012000609000200380C00130006090002003A0C00140006090002003C0C00150016090002003E0C0017001609000200400C0018001609000200420C0019001609000200440C001A0016090002004601000F4C696E654E756D6265725461626C6501000E637573746F6D697A6564496E6974010030284C6A6176612F7574696C2F4D61703B4C6A6176612F7574696C2F4D61703B4C6A6176612F7574696C2F4D61703B295601000A696E6974506172616D73010012284C6A6176612F7574696C2F4D61703B29560C004B004C0A0002004D01000A696E69744669656C64730C004F004C0A00020050010008696E6974566172730C0052004C0A0002005301000D5245504F52545F4C4F43414C4508005501000D6A6176612F7574696C2F4D6170070057010003676574010026284C6A6176612F6C616E672F4F626A6563743B294C6A6176612F6C616E672F4F626A6563743B0C0059005A0B0058005B0100306E65742F73662F6A61737065727265706F7274732F656E67696E652F66696C6C2F4A5246696C6C506172616D6574657207005D0100105245504F52545F54494D455F5A4F4E4508005F0100125245504F52545F5649525455414C495A45520800610100145245504F52545F46494C455F5245534F4C5645520800630100105245504F52545F5343524950544C45540800650100155245504F52545F504152414D45544552535F4D41500800670100115245504F52545F434F4E4E454354494F4E0800690100135245504F52545F434C4153535F4C4F4144455208006B0100125245504F52545F444154415F534F5552434508006D01001A5245504F52545F55524C5F48414E444C45525F464143544F525908006F01001449535F49474E4F52455F504147494E4154494F4E0800710100155245504F52545F464F524D41545F464143544F52590800730100105245504F52545F4D41585F434F554E540800750100105245504F52545F54454D504C415445530800770100165245504F52545F5245534F555243455F42554E444C4508007901000B504147455F4E554D42455208007B01002F6E65742F73662F6A61737065727265706F7274732F656E67696E652F66696C6C2F4A5246696C6C5661726961626C6507007D01000D434F4C554D4E5F4E554D42455208007F01000C5245504F52545F434F554E5408008101000A504147455F434F554E5408008301000C434F4C554D4E5F434F554E540800850100086576616C756174650100152849294C6A6176612F6C616E672F4F626A6563743B01000A457863657074696F6E730100136A6176612F6C616E672F5468726F7761626C6507008A0100116A6176612F6C616E672F496E746567657207008C010004284929560C001B008E0A008D008F01000E6A6176612F7574696C2F446174650700910A0092001E01001B7265706F3A2F496D616765732F6D706F7765724C6F676F2E6769660800940100166A6176612F6C616E672F537472696E674275666665720700960100055061676520080098010015284C6A6176612F6C616E672F537472696E673B29560C001B009A0A0097009B01000867657456616C756501001428294C6A6176612F6C616E672F4F626A6563743B0C009D009E0A007E009F010006617070656E6401002C284C6A6176612F6C616E672F4F626A6563743B294C6A6176612F6C616E672F537472696E674275666665723B0C00A100A20A009700A3010004206F66200800A501002C284C6A6176612F6C616E672F537472696E673B294C6A6176612F6C616E672F537472696E674275666665723B0C00A100A70A009700A8010008746F537472696E6701001428294C6A6176612F6C616E672F537472696E673B0C00AA00AB0A009700AC0A0097001E01000B6576616C756174654F6C6401000B6765744F6C6456616C75650C00B0009E0A007E00B10100116576616C75617465457374696D61746564010011676574457374696D6174656456616C75650C00B4009E0A007E00B501000A536F7572636546696C650021000200040000001400020005000600000002000700060000000200080006000000020009000600000002000A000600000002000B000600000002000C000600000002000D000600000002000E000600000002000F000600000002001000060000000200110006000000020012000600000002001300060000000200140006000000020015001600000002001700160000000200180016000000020019001600000002001A0016000000080001001B001C0001001D000000D500020001000000692AB7001F2A01B500212A01B500232A01B500252A01B500272A01B500292A01B5002B2A01B5002D2A01B5002F2A01B500312A01B500332A01B500352A01B500372A01B500392A01B5003B2A01B5003D2A01B5003F2A01B500412A01B500432A01B500452A01B50047B10000000100480000005A0016000000150004001C0009001D000E001E0013001F00180020001D00210022002200270023002C00240031002500360026003B00270040002800450029004A002A004F002B0054002C0059002D005E002E0063002F0068001500010049004A0001001D0000003400020004000000102A2BB7004E2A2CB700512A2DB70054B10000000100480000001200040000003B0005003C000A003D000F003E0002004B004C0001001D0000013600030002000000E22A2B1256B9005C0200C0005EB500212A2B1260B9005C0200C0005EB500232A2B1262B9005C0200C0005EB500252A2B1264B9005C0200C0005EB500272A2B1266B9005C0200C0005EB500292A2B1268B9005C0200C0005EB5002B2A2B126AB9005C0200C0005EB5002D2A2B126CB9005C0200C0005EB5002F2A2B126EB9005C0200C0005EB500312A2B1270B9005C0200C0005EB500332A2B1272B9005C0200C0005EB500352A2B1274B9005C0200C0005EB500372A2B1276B9005C0200C0005EB500392A2B1278B9005C0200C0005EB5003B2A2B127AB9005C0200C0005EB5003DB100000001004800000042001000000046000F0047001E0048002D0049003C004A004B004B005A004C0069004D0078004E0087004F0096005000A5005100B4005200C3005300D2005400E100550002004F004C0001001D000000190000000200000001B10000000100480000000600010000005D00020052004C0001001D00000078000300020000004C2A2B127CB9005C0200C0007EB5003F2A2B1280B9005C0200C0007EB500412A2B1282B9005C0200C0007EB500432A2B1284B9005C0200C0007EB500452A2B1286B9005C0200C0007EB50047B10000000100480000001A000600000065000F0066001E0067002D0068003C0069004B006A00010087008800020089000000040001008B001D000001BE0003000300000132014D1BAA0000012D000000000000000D00000045000000510000005D0000006900000075000000810000008D00000099000000A5000000B0000000B6000000D8000000F300000115BB008D5904B700904DA700DFBB008D5904B700904DA700D3BB008D5904B700904DA700C7BB008D5903B700904DA700BBBB008D5904B700904DA700AFBB008D5903B700904DA700A3BB008D5904B700904DA70097BB008D5903B700904DA7008BBB009259B700934DA7008012954DA7007ABB0097591299B7009C2AB4003FB600A0C0008DB600A412A6B600A9B600AD4DA70058BB009759B700AE2AB4003FB600A0C0008DB600A4B600AD4DA7003DBB0097591299B7009C2AB4003FB600A0C0008DB600A412A6B600A9B600AD4DA7001BBB009759B700AE2AB4003FB600A0C0008DB600A4B600AD4D2CB00000000100480000007A001E000000720002007400480078005100790054007D005D007E0060008200690083006C0087007500880078008C0081008D00840091008D00920090009600990097009C009B00A5009C00A800A000B000A100B300A500B600A600B900AA00D800AB00DB00AF00F300B000F600B4011500B5011800B9013000C1000100AF008800020089000000040001008B001D000001BE0003000300000132014D1BAA0000012D000000000000000D00000045000000510000005D0000006900000075000000810000008D00000099000000A5000000B0000000B6000000D8000000F300000115BB008D5904B700904DA700DFBB008D5904B700904DA700D3BB008D5904B700904DA700C7BB008D5903B700904DA700BBBB008D5904B700904DA700AFBB008D5903B700904DA700A3BB008D5904B700904DA70097BB008D5903B700904DA7008BBB009259B700934DA7008012954DA7007ABB0097591299B7009C2AB4003FB600B2C0008DB600A412A6B600A9B600AD4DA70058BB009759B700AE2AB4003FB600B2C0008DB600A4B600AD4DA7003DBB0097591299B7009C2AB4003FB600B2C0008DB600A412A6B600A9B600AD4DA7001BBB009759B700AE2AB4003FB600B2C0008DB600A4B600AD4D2CB00000000100480000007A001E000000CA000200CC004800D0005100D1005400D5005D00D6006000DA006900DB006C00DF007500E0007800E4008100E5008400E9008D00EA009000EE009900EF009C00F300A500F400A800F800B000F900B300FD00B600FE00B9010200D8010300DB010700F3010800F6010C0115010D0118011101300119000100B3008800020089000000040001008B001D000001BE0003000300000132014D1BAA0000012D000000000000000D00000045000000510000005D0000006900000075000000810000008D00000099000000A5000000B0000000B6000000D8000000F300000115BB008D5904B700904DA700DFBB008D5904B700904DA700D3BB008D5904B700904DA700C7BB008D5903B700904DA700BBBB008D5904B700904DA700AFBB008D5903B700904DA700A3BB008D5904B700904DA70097BB008D5903B700904DA7008BBB009259B700934DA7008012954DA7007ABB0097591299B7009C2AB4003FB600B6C0008DB600A412A6B600A9B600AD4DA70058BB009759B700AE2AB4003FB600B6C0008DB600A4B600AD4DA7003DBB0097591299B7009C2AB4003FB600B6C0008DB600A412A6B600A9B600AD4DA7001BBB009759B700AE2AB4003FB600B6C0008DB600A4B600AD4D2CB00000000100480000007A001E000001220002012400480128005101290054012D005D012E0060013200690133006C0137007501380078013C0081013D00840141008D01420090014600990147009C014B00A5014C00A8015000B0015100B3015500B6015600B9015A00D8015B00DB015F00F3016000F60164011501650118016901300171000100B70000000200017400155F313233373438393535333838395F3532353335347400326E65742E73662E6A61737065727265706F7274732E656E67696E652E64657369676E2E4A524A61766163436F6D70696C6572,6,'2009-01-29 10:17:57',NULL),
 (470,'/Reports/Default/templates/mpower_template_export_excel_files/mpower_template_export_excel_jrxml','JasperReport',0xACED0005737200286E65742E73662E6A61737065727265706F7274732E656E67696E652E4A61737065725265706F727400000000000027D80200034C000B636F6D70696C65446174617400164C6A6176612F696F2F53657269616C697A61626C653B4C0011636F6D70696C654E616D655375666669787400124C6A6176612F6C616E672F537472696E673B4C000D636F6D70696C6572436C61737371007E00027872002D6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A52426173655265706F727400000000000027D802002549000C626F74746F6D4D617267696E49000B636F6C756D6E436F756E7449000D636F6C756D6E53706163696E6749000B636F6C756D6E57696474685A001069676E6F7265506167696E6174696F6E5A00136973466C6F6174436F6C756D6E466F6F7465725A0010697353756D6D6172794E6577506167655A000E69735469746C654E65775061676549000A6C6566744D617267696E42000B6F7269656E746174696F6E49000A7061676548656967687449000970616765576964746842000A7072696E744F7264657249000B72696768744D617267696E490009746F704D617267696E42000E7768656E4E6F44617461547970654C000A6261636B67726F756E647400244C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5242616E643B4C000C636F6C756D6E466F6F74657271007E00044C000C636F6C756D6E48656164657271007E00045B000864617461736574737400285B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52446174617365743B4C000B64656661756C74466F6E7474002A4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525265706F7274466F6E743B4C000C64656661756C745374796C657400254C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525374796C653B4C000664657461696C71007E00045B0005666F6E747374002B5B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525265706F7274466F6E743B4C0012666F726D6174466163746F7279436C61737371007E00024C000A696D706F72747353657474000F4C6A6176612F7574696C2F5365743B4C00086C616E677561676571007E00024C000E6C61737450616765466F6F74657271007E00044C000B6D61696E446174617365747400274C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52446174617365743B4C00046E616D6571007E00024C00066E6F4461746171007E00044C000A70616765466F6F74657271007E00044C000A7061676548656164657271007E00045B00067374796C65737400265B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525374796C653B4C000773756D6D61727971007E00045B000974656D706C6174657374002F5B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525265706F727454656D706C6174653B4C00057469746C6571007E0004787000000014000000010000000000000217010000000000001E010000034A00000253010000001E00000014017372002B6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736542616E6400000000000027D80200034900066865696768745A000E697353706C6974416C6C6F7765644C00137072696E745768656E45787072657373696F6E74002A4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5245787072657373696F6E3B787200336E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365456C656D656E7447726F757000000000000027D80200024C00086368696C6472656E7400104C6A6176612F7574696C2F4C6973743B4C000C656C656D656E7447726F757074002C4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52456C656D656E7447726F75703B7870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000077040000000A78700000000001707371007E000E7371007E00140000000077040000000A78700000001E01707371007E000E7371007E00140000000077040000000A78700000001E01707070707371007E000E7371007E00140000000077040000000A78700000006401707070737200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000043F400000000000037400226E65742E73662E6A61737065727265706F7274732E656E67696E652E646174612E2A74001D6E65742E73662E6A61737065727265706F7274732E656E67696E652E2A74000B6A6176612E7574696C2E2A787400046A6176617371007E000E7371007E00140000000277040000000A737200306E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365546578744669656C6400000000000027D802001049000D626F6F6B6D61726B4C6576656C42000E6576616C756174696F6E54696D6542000F68797065726C696E6B54617267657442000D68797065726C696E6B547970655A0015697353747265746368576974684F766572666C6F774C0014616E63686F724E616D6545787072657373696F6E71007E000F4C000F6576616C756174696F6E47726F75707400254C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5247726F75703B4C000A65787072657373696F6E71007E000F4C001968797065726C696E6B416E63686F7245787072657373696F6E71007E000F4C001768797065726C696E6B5061676545787072657373696F6E71007E000F5B001368797065726C696E6B506172616D65746572737400335B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5248797065726C696E6B506172616D657465723B4C001C68797065726C696E6B5265666572656E636545787072657373696F6E71007E000F4C001A68797065726C696E6B546F6F6C74697045787072657373696F6E71007E000F4C000F6973426C616E6B5768656E4E756C6C7400134C6A6176612F6C616E672F426F6F6C65616E3B4C00086C696E6B5479706571007E00024C00077061747465726E71007E0002787200326E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736554657874456C656D656E7400000000000027D80200204C0006626F726465727400104C6A6176612F6C616E672F427974653B4C000B626F72646572436F6C6F727400104C6A6176612F6177742F436F6C6F723B4C000C626F74746F6D426F7264657271007E00294C0011626F74746F6D426F72646572436F6C6F7271007E002A4C000D626F74746F6D50616464696E677400134C6A6176612F6C616E672F496E74656765723B4C0008666F6E744E616D6571007E00024C0008666F6E7453697A6571007E002B4C0013686F72697A6F6E74616C416C69676E6D656E7471007E00294C00066973426F6C6471007E00274C000869734974616C696371007E00274C000D6973506466456D62656464656471007E00274C000F6973537472696B655468726F75676871007E00274C000C69735374796C65645465787471007E00274C000B6973556E6465726C696E6571007E00274C000A6C656674426F7264657271007E00294C000F6C656674426F72646572436F6C6F7271007E002A4C000B6C65667450616464696E6771007E002B4C00076C696E65426F787400274C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A524C696E65426F783B4C000B6C696E6553706163696E6771007E00294C00066D61726B757071007E00024C000770616464696E6771007E002B4C000B706466456E636F64696E6771007E00024C000B706466466F6E744E616D6571007E00024C000A7265706F7274466F6E7471007E00064C000B7269676874426F7264657271007E00294C00107269676874426F72646572436F6C6F7271007E002A4C000C726967687450616464696E6771007E002B4C0008726F746174696F6E71007E00294C0009746F70426F7264657271007E00294C000E746F70426F72646572436F6C6F7271007E002A4C000A746F7050616464696E6771007E002B4C0011766572746963616C416C69676E6D656E7471007E00297872002E6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365456C656D656E7400000000000027D80200164900066865696768745A001769735072696E74496E466972737457686F6C6542616E645A001569735072696E74526570656174656456616C7565735A001A69735072696E745768656E44657461696C4F766572666C6F77735A0015697352656D6F76654C696E655768656E426C616E6B42000C706F736974696F6E5479706542000B7374726574636854797065490005776964746849000178490001794C00096261636B636F6C6F7271007E002A4C001464656661756C745374796C6550726F76696465727400344C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5244656661756C745374796C6550726F76696465723B4C000C656C656D656E7447726F757071007E00124C0009666F7265636F6C6F7271007E002A4C00036B657971007E00024C00046D6F646571007E00294C000B706172656E745374796C6571007E00074C0018706172656E745374796C654E616D655265666572656E636571007E00024C00137072696E745768656E45787072657373696F6E71007E000F4C00157072696E745768656E47726F75704368616E67657371007E00254C000D70726F706572746965734D617074002D4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5250726F706572746965734D61703B5B001370726F706572747945787072657373696F6E737400335B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5250726F706572747945787072657373696F6E3B78700000001200010000020000000063000000B8000000127071007E000D71007E00227074000B746578744669656C642D3170707070707070707070707070707372000E6A6176612E6C616E672E427974659C4E6084EE50F51C02000142000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870037070707070707070707372002E6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A52426173654C696E65426F7800000000000027D802000B4C000D626F74746F6D50616464696E6771007E002B4C0009626F74746F6D50656E74002B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F626173652F4A52426F7850656E3B4C000C626F78436F6E7461696E657274002C4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52426F78436F6E7461696E65723B4C000B6C65667450616464696E6771007E002B4C00076C65667450656E71007E00374C000770616464696E6771007E002B4C000370656E71007E00374C000C726967687450616464696E6771007E002B4C0008726967687450656E71007E00374C000A746F7050616464696E6771007E002B4C0006746F7050656E71007E0037787070737200336E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365426F78426F74746F6D50656E00000000000027D80200007872002D6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365426F7850656E00000000000027D80200014C00076C696E65426F7871007E002C7872002A6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736550656E00000000000027D80200044C00096C696E65436F6C6F7271007E002A4C00096C696E655374796C6571007E00294C00096C696E6557696474687400114C6A6176612F6C616E672F466C6F61743B4C000C70656E436F6E7461696E657274002C4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5250656E436F6E7461696E65723B787070707071007E003971007E003971007E003170737200316E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365426F784C65667450656E00000000000027D80200007871007E003B70707071007E003971007E0039707371007E003B70707071007E003971007E003970737200326E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365426F78526967687450656E00000000000027D80200007871007E003B70707071007E003971007E003970737200306E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365426F78546F7050656E00000000000027D80200007871007E003B70707071007E003971007E0039707070707070707070707070707000000000010100007070737200316E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736545787072657373696F6E00000000000027D802000449000269645B00066368756E6B737400305B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5245787072657373696F6E4368756E6B3B4C000E76616C7565436C6173734E616D6571007E00024C001276616C7565436C6173735265616C4E616D6571007E000278700000000C757200305B4C6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A5245787072657373696F6E4368756E6B3B6D59CFDE694BA355020000787000000003737200366E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736545787072657373696F6E4368756E6B00000000000027D8020002420004747970654C00047465787471007E000278700174000A22506167652022202B207371007E004C0474000B504147455F4E554D4245527371007E004C01740009202B2022206F6620227400106A6176612E6C616E672E537472696E67707070707070737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C75657870007400044E6F6E65707371007E0024000000120001000002000000006400000120000000127071007E000D71007E00227074000B746578744669656C642D327070707070707070707070707070707070707070707070707371007E0036707371007E003A70707071007E005971007E005971007E0057707371007E004070707071007E005971007E0059707371007E003B70707071007E005971007E0059707371007E004370707071007E005971007E0059707371007E004570707071007E005971007E00597070707070707070707070707070000000000201000070707371007E00470000000D7571007E004A000000037371007E004C017400052222202B207371007E004C0474000B504147455F4E554D4245527371007E004C01740005202B2022227400106A6176612E6C616E672E537472696E6770707070707071007E00557400044E6F6E657078700000003201707372002E6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A52426173654461746173657400000000000027D802000D5A000669734D61696E4200177768656E5265736F757263654D697373696E67547970655B00066669656C64737400265B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A524669656C643B4C001066696C74657245787072657373696F6E71007E000F5B000667726F7570737400265B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5247726F75703B4C00046E616D6571007E00025B000A706172616D657465727374002A5B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52506172616D657465723B4C000D70726F706572746965734D617071007E002F4C000571756572797400254C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5251756572793B4C000E7265736F7572636542756E646C6571007E00024C000E7363726970746C6574436C61737371007E00025B000A736F72744669656C647374002A5B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52536F72744669656C643B5B00097661726961626C65737400295B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525661726961626C653B787001017070707400236D706F7765725F74656D706C6174655F6A72786D6C5F313232313136313734383834397572002A5B4C6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A52506172616D657465723B22000C8D2AC3602102000078700000000F737200306E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365506172616D6574657200000000000027D80200085A000E6973466F7250726F6D7074696E675A000F697353797374656D446566696E65644C001664656661756C7456616C756545787072657373696F6E71007E000F4C000B6465736372697074696F6E71007E00024C00046E616D6571007E00024C000D70726F706572746965734D617071007E002F4C000E76616C7565436C6173734E616D6571007E00024C001276616C7565436C6173735265616C4E616D6571007E00027870010170707400155245504F52545F504152414D45544552535F4D41507372002B6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A5250726F706572746965734D617000000000000027D80200034C00046261736571007E002F4C000E70726F706572746965734C69737471007E00114C000D70726F706572746965734D617074000F4C6A6176612F7574696C2F4D61703B787070707074000D6A6176612E7574696C2E4D6170707371007E0074010170707400115245504F52545F434F4E4E454354494F4E7371007E00777070707400136A6176612E73716C2E436F6E6E656374696F6E707371007E0074010170707400105245504F52545F4D41585F434F554E547371007E00777070707400116A6176612E6C616E672E496E7465676572707371007E0074010170707400125245504F52545F444154415F534F555243457371007E00777070707400286E65742E73662E6A61737065727265706F7274732E656E67696E652E4A5244617461536F75726365707371007E0074010170707400105245504F52545F5343524950544C45547371007E007770707074002F6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A5241627374726163745363726970746C6574707371007E00740101707074000D5245504F52545F4C4F43414C457371007E00777070707400106A6176612E7574696C2E4C6F63616C65707371007E0074010170707400165245504F52545F5245534F555243455F42554E444C457371007E00777070707400186A6176612E7574696C2E5265736F7572636542756E646C65707371007E0074010170707400105245504F52545F54494D455F5A4F4E457371007E00777070707400126A6176612E7574696C2E54696D655A6F6E65707371007E0074010170707400155245504F52545F464F524D41545F464143544F52597371007E007770707074002E6E65742E73662E6A61737065727265706F7274732E656E67696E652E7574696C2E466F726D6174466163746F7279707371007E0074010170707400135245504F52545F434C4153535F4C4F414445527371007E00777070707400156A6176612E6C616E672E436C6173734C6F61646572707371007E00740101707074001A5245504F52545F55524C5F48414E444C45525F464143544F52597371007E00777070707400206A6176612E6E65742E55524C53747265616D48616E646C6572466163746F7279707371007E0074010170707400145245504F52545F46494C455F5245534F4C5645527371007E007770707074002D6E65742E73662E6A61737065727265706F7274732E656E67696E652E7574696C2E46696C655265736F6C766572707371007E0074010170707400125245504F52545F5649525455414C495A45527371007E00777070707400296E65742E73662E6A61737065727265706F7274732E656E67696E652E4A525669727475616C697A6572707371007E00740101707074001449535F49474E4F52455F504147494E4154494F4E7371007E00777070707400116A6176612E6C616E672E426F6F6C65616E707371007E0074010170707400105245504F52545F54454D504C415445537371007E00777070707400146A6176612E7574696C2E436F6C6C656374696F6E707371007E0077707371007E00140000000277040000000A740019697265706F72742E7363726970746C657468616E646C696E67740010697265706F72742E656E636F64696E6778737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000271007E00B67400055554462D3871007E00B5740001307870707070757200295B4C6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A525661726961626C653B62E6837C982CB7440200007870000000057372002F6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A52426173655661726961626C6500000000000027D802000D42000B63616C63756C6174696F6E42000D696E6372656D656E74547970655A000F697353797374656D446566696E65644200097265736574547970654C000A65787072657373696F6E71007E000F4C000E696E6372656D656E7447726F757071007E00254C001B696E6372656D656E746572466163746F7279436C6173734E616D6571007E00024C001F696E6372656D656E746572466163746F7279436C6173735265616C4E616D6571007E00024C0016696E697469616C56616C756545787072657373696F6E71007E000F4C00046E616D6571007E00024C000A726573657447726F757071007E00254C000E76616C7565436C6173734E616D6571007E00024C001276616C7565436C6173735265616C4E616D6571007E0002787008050101707070707371007E0047000000007571007E004A000000017371007E004C0174000E6E657720496E746567657228312971007E00827074000B504147455F4E554D4245527071007E0082707371007E00BD08050102707070707371007E0047000000017571007E004A000000017371007E004C0174000E6E657720496E746567657228312971007E00827074000D434F4C554D4E5F4E554D4245527071007E0082707371007E00BD010501017371007E0047000000027571007E004A000000017371007E004C0174000E6E657720496E746567657228312971007E0082707070707371007E0047000000037571007E004A000000017371007E004C0174000E6E657720496E746567657228302971007E00827074000C5245504F52545F434F554E547071007E0082707371007E00BD010501027371007E0047000000047571007E004A000000017371007E004C0174000E6E657720496E746567657228312971007E0082707070707371007E0047000000057571007E004A000000017371007E004C0174000E6E657720496E746567657228302971007E00827074000A504147455F434F554E547071007E0082707371007E00BD010501037371007E0047000000067571007E004A000000017371007E004C0174000E6E657720496E746567657228312971007E0082707070707371007E0047000000077571007E004A000000017371007E004C0174000E6E657720496E746567657228302971007E00827074000C434F4C554D4E5F434F554E547071007E00827071007E0071707371007E000E7371007E00140000000277040000000A7371007E00240000001200010000020000000063000000B5000000127071007E000D71007E00E870740009746578744669656C64707070707070707070707070707071007E00357070707070707070707371007E0036707371007E003A70707071007E00EC71007E00EC71007E00EA707371007E004070707071007E00EC71007E00EC707371007E003B70707071007E00EC71007E00EC707371007E004370707071007E00EC71007E00EC707371007E004570707071007E00EC71007E00EC7070707070707070707070707070000000000101000070707371007E00470000000A7571007E004A000000037371007E004C0174000A22506167652022202B207371007E004C0474000B504147455F4E554D4245527371007E004C01740009202B2022206F6620227400106A6176612E6C616E672E537472696E6770707070707071007E00557400044E6F6E65707371007E002400000012000100000200000000640000011D000000127071007E000D71007E00E870740009746578744669656C647070707070707070707070707070707070707070707070707371007E0036707371007E003A70707071007E00FE71007E00FE71007E00FC707371007E004070707071007E00FE71007E00FE707371007E003B70707071007E00FE71007E00FE707371007E004370707071007E00FE71007E00FE707371007E004570707071007E00FE71007E00FE7070707070707070707070707070000000000201000070707371007E00470000000B7571007E004A000000037371007E004C017400052222202B207371007E004C0474000B504147455F4E554D4245527371007E004C01740005202B2022227400106A6176612E6C616E672E537472696E6770707070707071007E00557400044E6F6E657078700000003201707371007E000E7371007E00140000000077040000000A7870000000110170757200265B4C6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A525374796C653BD49CC311D90572350200007870000000087372002C6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A52426173655374796C6500000000000027110200315A0009697344656661756C744C00096261636B636F6C6F7271007E002A4C0006626F7264657271007E00294C000B626F72646572436F6C6F7271007E002A4C000C626F74746F6D426F7264657271007E00294C0011626F74746F6D426F72646572436F6C6F7271007E002A4C000D626F74746F6D50616464696E6771007E002B5B0011636F6E646974696F6E616C5374796C65737400315B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52436F6E646974696F6E616C5374796C653B4C001464656661756C745374796C6550726F766964657271007E002E4C000466696C6C71007E00294C0008666F6E744E616D6571007E00024C0008666F6E7453697A6571007E002B4C0009666F7265636F6C6F7271007E002A4C0013686F72697A6F6E74616C416C69676E6D656E7471007E00294C000F6973426C616E6B5768656E4E756C6C71007E00274C00066973426F6C6471007E00274C000869734974616C696371007E00274C000D6973506466456D62656464656471007E00274C000F6973537472696B655468726F75676871007E00274C000C69735374796C65645465787471007E00274C000B6973556E6465726C696E6571007E00274C000A6C656674426F7264657271007E00294C000F6C656674426F72646572436F6C6F7271007E002A4C000B6C65667450616464696E6771007E002B4C00076C696E65426F7871007E002C4C00076C696E6550656E7400234C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5250656E3B4C000B6C696E6553706163696E6771007E00294C00066D61726B757071007E00024C00046D6F646571007E00294C00046E616D6571007E00024C000770616464696E6771007E002B4C000B706172656E745374796C6571007E00074C0018706172656E745374796C654E616D655265666572656E636571007E00024C00077061747465726E71007E00024C000B706466456E636F64696E6771007E00024C000B706466466F6E744E616D6571007E00024C000370656E71007E00294C000C706F736974696F6E5479706571007E00294C000672616469757371007E002B4C000B7269676874426F7264657271007E00294C00107269676874426F72646572436F6C6F7271007E002A4C000C726967687450616464696E6771007E002B4C0008726F746174696F6E71007E00294C000A7363616C65496D61676571007E00294C000B737472657463685479706571007E00294C0009746F70426F7264657271007E00294C000E746F70426F72646572436F6C6F7271007E002A4C000A746F7050616464696E6771007E002B4C0011766572746963616C416C69676E6D656E7471007E0029787000707070707070707070740005417269616C737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E00340000000E707371007E003301707070707070707070707371007E0036707371007E003A70707071007E011A71007E011A71007E0115707371007E004070707071007E011A71007E011A707371007E003B70707071007E011A71007E011A707371007E004370707071007E011A71007E011A707371007E004570707071007E011A71007E011A7371007E003C70707071007E011570707074000664657461696C707070707070707070707070707070707070707371007E0112007372000E6A6176612E6177742E436F6C6F7201A51783108F337502000546000666616C70686149000576616C75654C0002637374001B4C6A6176612F6177742F636F6C6F722F436F6C6F7253706163653B5B00096672676276616C75657400025B465B00066676616C756571007E0125787000000000FF6666667070707070707070707070740005417269616C7371007E01170000000E7371007E012300000000FFFFFFFF70707071007E0119707371007E00540171007E0055707070707070707371007E0036707371007E003A7371007E012300000000FF000000707070707372000F6A6176612E6C616E672E466C6F6174DAEDC9A2DB3CF0EC02000146000576616C75657871007E00343F80000071007E012B71007E012B71007E0122707371007E00407371007E012300000000FF000000707070707371007E012E0000000071007E012B71007E012B707371007E003B7371007E012300000000FF000000707070707371007E012E3F40000071007E012B71007E012B707371007E00437371007E012300000000FF000000707070707371007E012E0000000071007E012B71007E012B707371007E00457371007E012300000000FF000000707070707371007E012E0000000071007E012B71007E012B7371007E003C70707071007E012270707371007E003301740006686561646572707070707070707070707070707070707070707371007E011200707070707070707070740005417269616C7371007E01170000000E7071007E01197071007E012A70707070707070707371007E0036707371007E003A70707371007E012E3F80000071007E014271007E014271007E013F707371007E004070707071007E014271007E0142707371007E003B70707071007E014271007E0142707371007E004370707071007E014271007E0142707371007E004570707071007E014271007E01427371007E003C70707071007E013F70707074000F6865616465725661726961626C6573707070707070707070707070707070707070707371007E01120070707070707070707074000756657264616E617371007E01170000001270707071007E012A70707070707070707371007E0036707371007E003A70707071007E014E71007E014E71007E014B707371007E004070707071007E014E71007E014E707371007E003B70707071007E014E71007E014E707371007E004370707071007E014E71007E014E707371007E004570707071007E014E71007E014E7371007E003C70707071007E014B70707074000A7469746C655374796C65707070707070707070707070707070707070707371007E01120070707070707070707070707071007E0035707070707070707070707371007E0036707371007E003A70707071007E015771007E015771007E0156707371007E004070707071007E015771007E0157707371007E003B70707071007E015771007E0157707371007E004370707071007E015771007E0157707371007E004570707071007E015771007E01577371007E003C70707071007E015670707074000C696D706F7274655374796C65707070707070707070707070707070707070707371007E0112007371007E012300000000FFCCCCCC707070707070707070707070707070707070707070707070707371007E0036707371007E003A70707071007E016171007E016171007E015F707371007E004070707071007E016171007E0161707371007E003B70707071007E016171007E0161707371007E004370707071007E016171007E0161707371007E004570707071007E016171007E01617371007E003C70707071007E015F707071007E013D74000B6F6464526F775374796C65707070707070707070707070707070707070707371007E011200707070707070707070740005417269616C707070707071007E00557071007E00557071007E00557070707371007E0036707371007E003A70707071007E016B71007E016B71007E0169707371007E004070707071007E016B71007E016B707371007E003B70707071007E016B71007E016B707371007E004370707071007E016B71007E016B707371007E004570707071007E016B71007E016B7371007E003C70707071007E016970707074000C53756D6D6172795374796C65707070707070707070707070707070707070707371007E01120070707070707070707070707371007E012300000000FF316AC570707070707070707070707070707371007E0036707371007E003A70707071007E017571007E017571007E0173707371007E004070707071007E017571007E0175707371007E003B70707071007E017571007E0175707371007E004370707071007E017571007E0175707371007E004570707071007E017571007E01757371007E003C70707071007E017370707074001053756D6D6172795374796C65426C75657071007E016970707070707070707070707070707070707371007E000E7371007E00140000000077040000000A7870000000320170707371007E000E7371007E00140000000277040000000A7371007E00240000001200010000020000000064000001B3000000007071007E000D71007E017F70740009746578744669656C647070707070707070707070707070707070707070707070707371007E0036707371007E003A70707071007E018371007E018371007E0181707371007E004070707071007E018371007E0183707371007E003B70707071007E018371007E0183707371007E004370707071007E018371007E0183707371007E004570707071007E018371007E01837070707070707070707070707070000000000201000070707371007E0047000000087571007E004A000000017371007E004C017400146E6577206A6176612E7574696C2E44617465282974000E6A6176612E7574696C2E4461746570707070707071007E00557400044E6F6E6574000A64642F4D4D2F797979797372002C6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365496D61676500000000000027D802002349000D626F6F6B6D61726B4C6576656C42000E6576616C756174696F6E54696D6542000F68797065726C696E6B54617267657442000D68797065726C696E6B547970655A000669734C617A7942000B6F6E4572726F72547970654C0014616E63686F724E616D6545787072657373696F6E71007E000F4C0006626F7264657271007E00294C000B626F72646572436F6C6F7271007E002A4C000C626F74746F6D426F7264657271007E00294C0011626F74746F6D426F72646572436F6C6F7271007E002A4C000D626F74746F6D50616464696E6771007E002B4C000F6576616C756174696F6E47726F757071007E00254C000A65787072657373696F6E71007E000F4C0013686F72697A6F6E74616C416C69676E6D656E7471007E00294C001968797065726C696E6B416E63686F7245787072657373696F6E71007E000F4C001768797065726C696E6B5061676545787072657373696F6E71007E000F5B001368797065726C696E6B506172616D657465727371007E00264C001C68797065726C696E6B5265666572656E636545787072657373696F6E71007E000F4C001A68797065726C696E6B546F6F6C74697045787072657373696F6E71007E000F4C000C69735573696E67436163686571007E00274C000A6C656674426F7264657271007E00294C000F6C656674426F72646572436F6C6F7271007E002A4C000B6C65667450616464696E6771007E002B4C00076C696E65426F7871007E002C4C00086C696E6B5479706571007E00024C000770616464696E6771007E002B4C000B7269676874426F7264657271007E00294C00107269676874426F72646572436F6C6F7271007E002A4C000C726967687450616464696E6771007E002B4C000A7363616C65496D61676571007E00294C0009746F70426F7264657271007E00294C000E746F70426F72646572436F6C6F7271007E002A4C000A746F7050616464696E6771007E002B4C0011766572746963616C416C69676E6D656E7471007E0029787200356E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736547726170686963456C656D656E7400000000000027D80200034C000466696C6C71007E00294C00076C696E6550656E71007E01144C000370656E71007E00297871007E002D00000057010100000202000000FB00000000000000007071007E000D71007E017F70740007696D6167652D3170707070707070707371007E003C70707071007E019270000000000101000001707070707070707371007E0047000000097571007E004A000000017371007E004C0174001D227265706F3A2F496D616765732F6D706F7765724C6F676F2E676966227400106A6176612E6C616E672E537472696E6770707070707070707070707371007E0036707371007E003A70707071007E019A71007E019A71007E0192707371007E004070707071007E019A71007E019A707371007E003B70707071007E019A71007E019A707371007E004370707071007E019A71007E019A707371007E004570707071007E019A71007E019A7400044E6F6E6570707070707070707078700000005F0170737200366E65742E73662E6A61737065727265706F7274732E656E67696E652E64657369676E2E4A525265706F7274436F6D70696C654461746100000000000027D80200034C001363726F7373746162436F6D70696C654461746171007E00784C001264617461736574436F6D70696C654461746171007E00784C00166D61696E44617461736574436F6D70696C654461746171007E000178707371007E00B73F4000000000000C77080000001000000000787371007E00B73F4000000000000C7708000000100000000078757200025B42ACF317F8060854E00200007870000012D1CAFEBABE0000002E00B80100376D706F7765725F74656D706C6174655F6A72786D6C5F313232313136313734383834395F313233333838383838313137375F393039313807000101002C6E65742F73662F6A61737065727265706F7274732F656E67696E652F66696C6C2F4A524576616C7561746F72070003010017706172616D657465725F5245504F52545F4C4F43414C450100324C6E65742F73662F6A61737065727265706F7274732F656E67696E652F66696C6C2F4A5246696C6C506172616D657465723B01001A706172616D657465725F5245504F52545F54494D455F5A4F4E4501001C706172616D657465725F5245504F52545F5649525455414C495A455201001E706172616D657465725F5245504F52545F46494C455F5245534F4C56455201001A706172616D657465725F5245504F52545F5343524950544C455401001F706172616D657465725F5245504F52545F504152414D45544552535F4D415001001B706172616D657465725F5245504F52545F434F4E4E454354494F4E01001D706172616D657465725F5245504F52545F434C4153535F4C4F4144455201001C706172616D657465725F5245504F52545F444154415F534F55524345010024706172616D657465725F5245504F52545F55524C5F48414E444C45525F464143544F525901001E706172616D657465725F49535F49474E4F52455F504147494E4154494F4E01001F706172616D657465725F5245504F52545F464F524D41545F464143544F525901001A706172616D657465725F5245504F52545F4D41585F434F554E5401001A706172616D657465725F5245504F52545F54454D504C41544553010020706172616D657465725F5245504F52545F5245534F555243455F42554E444C450100147661726961626C655F504147455F4E554D4245520100314C6E65742F73662F6A61737065727265706F7274732F656E67696E652F66696C6C2F4A5246696C6C5661726961626C653B0100167661726961626C655F434F4C554D4E5F4E554D4245520100157661726961626C655F5245504F52545F434F554E540100137661726961626C655F504147455F434F554E540100157661726961626C655F434F4C554D4E5F434F554E540100063C696E69743E010003282956010004436F64650C001B001C0A0004001E0C0005000609000200200C0007000609000200220C0008000609000200240C0009000609000200260C000A000609000200280C000B0006090002002A0C000C0006090002002C0C000D0006090002002E0C000E000609000200300C000F000609000200320C0010000609000200340C0011000609000200360C0012000609000200380C00130006090002003A0C00140006090002003C0C00150016090002003E0C0017001609000200400C0018001609000200420C0019001609000200440C001A0016090002004601000F4C696E654E756D6265725461626C6501000E637573746F6D697A6564496E6974010030284C6A6176612F7574696C2F4D61703B4C6A6176612F7574696C2F4D61703B4C6A6176612F7574696C2F4D61703B295601000A696E6974506172616D73010012284C6A6176612F7574696C2F4D61703B29560C004B004C0A0002004D01000A696E69744669656C64730C004F004C0A00020050010008696E6974566172730C0052004C0A0002005301000D5245504F52545F4C4F43414C4508005501000D6A6176612F7574696C2F4D6170070057010003676574010026284C6A6176612F6C616E672F4F626A6563743B294C6A6176612F6C616E672F4F626A6563743B0C0059005A0B0058005B0100306E65742F73662F6A61737065727265706F7274732F656E67696E652F66696C6C2F4A5246696C6C506172616D6574657207005D0100105245504F52545F54494D455F5A4F4E4508005F0100125245504F52545F5649525455414C495A45520800610100145245504F52545F46494C455F5245534F4C5645520800630100105245504F52545F5343524950544C45540800650100155245504F52545F504152414D45544552535F4D41500800670100115245504F52545F434F4E4E454354494F4E0800690100135245504F52545F434C4153535F4C4F4144455208006B0100125245504F52545F444154415F534F5552434508006D01001A5245504F52545F55524C5F48414E444C45525F464143544F525908006F01001449535F49474E4F52455F504147494E4154494F4E0800710100155245504F52545F464F524D41545F464143544F52590800730100105245504F52545F4D41585F434F554E540800750100105245504F52545F54454D504C415445530800770100165245504F52545F5245534F555243455F42554E444C4508007901000B504147455F4E554D42455208007B01002F6E65742F73662F6A61737065727265706F7274732F656E67696E652F66696C6C2F4A5246696C6C5661726961626C6507007D01000D434F4C554D4E5F4E554D42455208007F01000C5245504F52545F434F554E5408008101000A504147455F434F554E5408008301000C434F4C554D4E5F434F554E540800850100086576616C756174650100152849294C6A6176612F6C616E672F4F626A6563743B01000A457863657074696F6E730100136A6176612F6C616E672F5468726F7761626C6507008A0100116A6176612F6C616E672F496E746567657207008C010004284929560C001B008E0A008D008F01000E6A6176612F7574696C2F446174650700910A0092001E01001B7265706F3A2F496D616765732F6D706F7765724C6F676F2E6769660800940100166A6176612F6C616E672F537472696E674275666665720700960100055061676520080098010015284C6A6176612F6C616E672F537472696E673B29560C001B009A0A0097009B01000867657456616C756501001428294C6A6176612F6C616E672F4F626A6563743B0C009D009E0A007E009F010006617070656E6401002C284C6A6176612F6C616E672F4F626A6563743B294C6A6176612F6C616E672F537472696E674275666665723B0C00A100A20A009700A3010004206F66200800A501002C284C6A6176612F6C616E672F537472696E673B294C6A6176612F6C616E672F537472696E674275666665723B0C00A100A70A009700A8010008746F537472696E6701001428294C6A6176612F6C616E672F537472696E673B0C00AA00AB0A009700AC0A0097001E01000B6576616C756174654F6C6401000B6765744F6C6456616C75650C00B0009E0A007E00B10100116576616C75617465457374696D61746564010011676574457374696D6174656456616C75650C00B4009E0A007E00B501000A536F7572636546696C650021000200040000001400020005000600000002000700060000000200080006000000020009000600000002000A000600000002000B000600000002000C000600000002000D000600000002000E000600000002000F000600000002001000060000000200110006000000020012000600000002001300060000000200140006000000020015001600000002001700160000000200180016000000020019001600000002001A0016000000080001001B001C0001001D000000D500020001000000692AB7001F2A01B500212A01B500232A01B500252A01B500272A01B500292A01B5002B2A01B5002D2A01B5002F2A01B500312A01B500332A01B500352A01B500372A01B500392A01B5003B2A01B5003D2A01B5003F2A01B500412A01B500432A01B500452A01B50047B10000000100480000005A0016000000150004001C0009001D000E001E0013001F00180020001D00210022002200270023002C00240031002500360026003B00270040002800450029004A002A004F002B0054002C0059002D005E002E0063002F0068001500010049004A0001001D0000003400020004000000102A2BB7004E2A2CB700512A2DB70054B10000000100480000001200040000003B0005003C000A003D000F003E0002004B004C0001001D0000013600030002000000E22A2B1256B9005C0200C0005EB500212A2B1260B9005C0200C0005EB500232A2B1262B9005C0200C0005EB500252A2B1264B9005C0200C0005EB500272A2B1266B9005C0200C0005EB500292A2B1268B9005C0200C0005EB5002B2A2B126AB9005C0200C0005EB5002D2A2B126CB9005C0200C0005EB5002F2A2B126EB9005C0200C0005EB500312A2B1270B9005C0200C0005EB500332A2B1272B9005C0200C0005EB500352A2B1274B9005C0200C0005EB500372A2B1276B9005C0200C0005EB500392A2B1278B9005C0200C0005EB5003B2A2B127AB9005C0200C0005EB5003DB100000001004800000042001000000046000F0047001E0048002D0049003C004A004B004B005A004C0069004D0078004E0087004F0096005000A5005100B4005200C3005300D2005400E100550002004F004C0001001D000000190000000200000001B10000000100480000000600010000005D00020052004C0001001D00000078000300020000004C2A2B127CB9005C0200C0007EB5003F2A2B1280B9005C0200C0007EB500412A2B1282B9005C0200C0007EB500432A2B1284B9005C0200C0007EB500452A2B1286B9005C0200C0007EB50047B10000000100480000001A000600000065000F0066001E0067002D0068003C0069004B006A00010087008800020089000000040001008B001D000001BE0003000300000132014D1BAA0000012D000000000000000D00000045000000510000005D0000006900000075000000810000008D00000099000000A5000000B0000000B6000000D8000000F300000115BB008D5904B700904DA700DFBB008D5904B700904DA700D3BB008D5904B700904DA700C7BB008D5903B700904DA700BBBB008D5904B700904DA700AFBB008D5903B700904DA700A3BB008D5904B700904DA70097BB008D5903B700904DA7008BBB009259B700934DA7008012954DA7007ABB0097591299B7009C2AB4003FB600A0C0008DB600A412A6B600A9B600AD4DA70058BB009759B700AE2AB4003FB600A0C0008DB600A4B600AD4DA7003DBB0097591299B7009C2AB4003FB600A0C0008DB600A412A6B600A9B600AD4DA7001BBB009759B700AE2AB4003FB600A0C0008DB600A4B600AD4D2CB00000000100480000007A001E000000720002007400480078005100790054007D005D007E0060008200690083006C0087007500880078008C0081008D00840091008D00920090009600990097009C009B00A5009C00A800A000B000A100B300A500B600A600B900AA00D800AB00DB00AF00F300B000F600B4011500B5011800B9013000C1000100AF008800020089000000040001008B001D000001BE0003000300000132014D1BAA0000012D000000000000000D00000045000000510000005D0000006900000075000000810000008D00000099000000A5000000B0000000B6000000D8000000F300000115BB008D5904B700904DA700DFBB008D5904B700904DA700D3BB008D5904B700904DA700C7BB008D5903B700904DA700BBBB008D5904B700904DA700AFBB008D5903B700904DA700A3BB008D5904B700904DA70097BB008D5903B700904DA7008BBB009259B700934DA7008012954DA7007ABB0097591299B7009C2AB4003FB600B2C0008DB600A412A6B600A9B600AD4DA70058BB009759B700AE2AB4003FB600B2C0008DB600A4B600AD4DA7003DBB0097591299B7009C2AB4003FB600B2C0008DB600A412A6B600A9B600AD4DA7001BBB009759B700AE2AB4003FB600B2C0008DB600A4B600AD4D2CB00000000100480000007A001E000000CA000200CC004800D0005100D1005400D5005D00D6006000DA006900DB006C00DF007500E0007800E4008100E5008400E9008D00EA009000EE009900EF009C00F300A500F400A800F800B000F900B300FD00B600FE00B9010200D8010300DB010700F3010800F6010C0115010D0118011101300119000100B3008800020089000000040001008B001D000001BE0003000300000132014D1BAA0000012D000000000000000D00000045000000510000005D0000006900000075000000810000008D00000099000000A5000000B0000000B6000000D8000000F300000115BB008D5904B700904DA700DFBB008D5904B700904DA700D3BB008D5904B700904DA700C7BB008D5903B700904DA700BBBB008D5904B700904DA700AFBB008D5903B700904DA700A3BB008D5904B700904DA70097BB008D5903B700904DA7008BBB009259B700934DA7008012954DA7007ABB0097591299B7009C2AB4003FB600B6C0008DB600A412A6B600A9B600AD4DA70058BB009759B700AE2AB4003FB600B6C0008DB600A4B600AD4DA7003DBB0097591299B7009C2AB4003FB600B6C0008DB600A412A6B600A9B600AD4DA7001BBB009759B700AE2AB4003FB600B6C0008DB600A4B600AD4D2CB00000000100480000007A001E000001220002012400480128005101290054012D005D012E0060013200690133006C0137007501380078013C0081013D00840141008D01420090014600990147009C014B00A5014C00A8015000B0015100B3015500B6015600B9015A00D8015B00DB015F00F3016000F60164011501650118016901300171000100B70000000200017400145F313233333838383838313137375F39303931387400326E65742E73662E6A61737065727265706F7274732E656E67696E652E64657369676E2E4A524A61766163436F6D70696C6572,5,'2009-01-29 10:17:57',NULL),
 (1053,'/Reports/Default/templates/mpower_template_files/mpower_template_jrxml','JasperReport',0xACED0005737200286E65742E73662E6A61737065727265706F7274732E656E67696E652E4A61737065725265706F727400000000000027D80200034C000B636F6D70696C65446174617400164C6A6176612F696F2F53657269616C697A61626C653B4C0011636F6D70696C654E616D655375666669787400124C6A6176612F6C616E672F537472696E673B4C000D636F6D70696C6572436C61737371007E00027872002D6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A52426173655265706F727400000000000027D802002549000C626F74746F6D4D617267696E49000B636F6C756D6E436F756E7449000D636F6C756D6E53706163696E6749000B636F6C756D6E57696474685A001069676E6F7265506167696E6174696F6E5A00136973466C6F6174436F6C756D6E466F6F7465725A0010697353756D6D6172794E6577506167655A000E69735469746C654E65775061676549000A6C6566744D617267696E42000B6F7269656E746174696F6E49000A7061676548656967687449000970616765576964746842000A7072696E744F7264657249000B72696768744D617267696E490009746F704D617267696E42000E7768656E4E6F44617461547970654C000A6261636B67726F756E647400244C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5242616E643B4C000C636F6C756D6E466F6F74657271007E00044C000C636F6C756D6E48656164657271007E00045B000864617461736574737400285B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52446174617365743B4C000B64656661756C74466F6E7474002A4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525265706F7274466F6E743B4C000C64656661756C745374796C657400254C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525374796C653B4C000664657461696C71007E00045B0005666F6E747374002B5B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525265706F7274466F6E743B4C0012666F726D6174466163746F7279436C61737371007E00024C000A696D706F72747353657474000F4C6A6176612F7574696C2F5365743B4C00086C616E677561676571007E00024C000E6C61737450616765466F6F74657271007E00044C000B6D61696E446174617365747400274C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52446174617365743B4C00046E616D6571007E00024C00066E6F4461746171007E00044C000A70616765466F6F74657271007E00044C000A7061676548656164657271007E00045B00067374796C65737400265B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525374796C653B4C000773756D6D61727971007E00045B000974656D706C6174657374002F5B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525265706F727454656D706C6174653B4C00057469746C6571007E0004787000000014000000010000000000000217000000000000001E010000034A00000253010000001E00000014017372002B6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736542616E6400000000000027D80200034900066865696768745A000E697353706C6974416C6C6F7765644C00137072696E745768656E45787072657373696F6E74002A4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5245787072657373696F6E3B787200336E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365456C656D656E7447726F757000000000000027D80200024C00086368696C6472656E7400104C6A6176612F7574696C2F4C6973743B4C000C656C656D656E7447726F757074002C4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52456C656D656E7447726F75703B7870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000077040000000A78700000000001707371007E000E7371007E00140000000077040000000A78700000001E01707371007E000E7371007E00140000000077040000000A78700000001E01707070707371007E000E7371007E00140000000077040000000A78700000006401707070737200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000043F400000000000037400226E65742E73662E6A61737065727265706F7274732E656E67696E652E646174612E2A74001D6E65742E73662E6A61737065727265706F7274732E656E67696E652E2A74000B6A6176612E7574696C2E2A787400046A6176617371007E000E7371007E00140000000277040000000A737200306E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365546578744669656C6400000000000027D802001049000D626F6F6B6D61726B4C6576656C42000E6576616C756174696F6E54696D6542000F68797065726C696E6B54617267657442000D68797065726C696E6B547970655A0015697353747265746368576974684F766572666C6F774C0014616E63686F724E616D6545787072657373696F6E71007E000F4C000F6576616C756174696F6E47726F75707400254C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5247726F75703B4C000A65787072657373696F6E71007E000F4C001968797065726C696E6B416E63686F7245787072657373696F6E71007E000F4C001768797065726C696E6B5061676545787072657373696F6E71007E000F5B001368797065726C696E6B506172616D65746572737400335B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5248797065726C696E6B506172616D657465723B4C001C68797065726C696E6B5265666572656E636545787072657373696F6E71007E000F4C001A68797065726C696E6B546F6F6C74697045787072657373696F6E71007E000F4C000F6973426C616E6B5768656E4E756C6C7400134C6A6176612F6C616E672F426F6F6C65616E3B4C00086C696E6B5479706571007E00024C00077061747465726E71007E0002787200326E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736554657874456C656D656E7400000000000027D80200204C0006626F726465727400104C6A6176612F6C616E672F427974653B4C000B626F72646572436F6C6F727400104C6A6176612F6177742F436F6C6F723B4C000C626F74746F6D426F7264657271007E00294C0011626F74746F6D426F72646572436F6C6F7271007E002A4C000D626F74746F6D50616464696E677400134C6A6176612F6C616E672F496E74656765723B4C0008666F6E744E616D6571007E00024C0008666F6E7453697A6571007E002B4C0013686F72697A6F6E74616C416C69676E6D656E7471007E00294C00066973426F6C6471007E00274C000869734974616C696371007E00274C000D6973506466456D62656464656471007E00274C000F6973537472696B655468726F75676871007E00274C000C69735374796C65645465787471007E00274C000B6973556E6465726C696E6571007E00274C000A6C656674426F7264657271007E00294C000F6C656674426F72646572436F6C6F7271007E002A4C000B6C65667450616464696E6771007E002B4C00076C696E65426F787400274C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A524C696E65426F783B4C000B6C696E6553706163696E6771007E00294C00066D61726B757071007E00024C000770616464696E6771007E002B4C000B706466456E636F64696E6771007E00024C000B706466466F6E744E616D6571007E00024C000A7265706F7274466F6E7471007E00064C000B7269676874426F7264657271007E00294C00107269676874426F72646572436F6C6F7271007E002A4C000C726967687450616464696E6771007E002B4C0008726F746174696F6E71007E00294C0009746F70426F7264657271007E00294C000E746F70426F72646572436F6C6F7271007E002A4C000A746F7050616464696E6771007E002B4C0011766572746963616C416C69676E6D656E7471007E00297872002E6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365456C656D656E7400000000000027D80200164900066865696768745A001769735072696E74496E466972737457686F6C6542616E645A001569735072696E74526570656174656456616C7565735A001A69735072696E745768656E44657461696C4F766572666C6F77735A0015697352656D6F76654C696E655768656E426C616E6B42000C706F736974696F6E5479706542000B7374726574636854797065490005776964746849000178490001794C00096261636B636F6C6F7271007E002A4C001464656661756C745374796C6550726F76696465727400344C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5244656661756C745374796C6550726F76696465723B4C000C656C656D656E7447726F757071007E00124C0009666F7265636F6C6F7271007E002A4C00036B657971007E00024C00046D6F646571007E00294C000B706172656E745374796C6571007E00074C0018706172656E745374796C654E616D655265666572656E636571007E00024C00137072696E745768656E45787072657373696F6E71007E000F4C00157072696E745768656E47726F75704368616E67657371007E00254C000D70726F706572746965734D617074002D4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5250726F706572746965734D61703B5B001370726F706572747945787072657373696F6E737400335B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5250726F706572747945787072657373696F6E3B78700000001200010000020000000063000000B8000000127071007E000D71007E00227074000B746578744669656C642D3170707070707070707070707070707372000E6A6176612E6C616E672E427974659C4E6084EE50F51C02000142000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870037070707070707070707372002E6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A52426173654C696E65426F7800000000000027D802000B4C000D626F74746F6D50616464696E6771007E002B4C0009626F74746F6D50656E74002B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F626173652F4A52426F7850656E3B4C000C626F78436F6E7461696E657274002C4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52426F78436F6E7461696E65723B4C000B6C65667450616464696E6771007E002B4C00076C65667450656E71007E00374C000770616464696E6771007E002B4C000370656E71007E00374C000C726967687450616464696E6771007E002B4C0008726967687450656E71007E00374C000A746F7050616464696E6771007E002B4C0006746F7050656E71007E0037787070737200336E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365426F78426F74746F6D50656E00000000000027D80200007872002D6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365426F7850656E00000000000027D80200014C00076C696E65426F7871007E002C7872002A6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736550656E00000000000027D80200044C00096C696E65436F6C6F7271007E002A4C00096C696E655374796C6571007E00294C00096C696E6557696474687400114C6A6176612F6C616E672F466C6F61743B4C000C70656E436F6E7461696E657274002C4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5250656E436F6E7461696E65723B787070707071007E003971007E003971007E003170737200316E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365426F784C65667450656E00000000000027D80200007871007E003B70707071007E003971007E0039707371007E003B70707071007E003971007E003970737200326E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365426F78526967687450656E00000000000027D80200007871007E003B70707071007E003971007E003970737200306E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365426F78546F7050656E00000000000027D80200007871007E003B70707071007E003971007E0039707070707070707070707070707000000000010100007070737200316E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736545787072657373696F6E00000000000027D802000449000269645B00066368756E6B737400305B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5245787072657373696F6E4368756E6B3B4C000E76616C7565436C6173734E616D6571007E00024C001276616C7565436C6173735265616C4E616D6571007E000278700000000C757200305B4C6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A5245787072657373696F6E4368756E6B3B6D59CFDE694BA355020000787000000003737200366E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736545787072657373696F6E4368756E6B00000000000027D8020002420004747970654C00047465787471007E000278700174000A22506167652022202B207371007E004C0474000B504147455F4E554D4245527371007E004C01740009202B2022206F6620227400106A6176612E6C616E672E537472696E67707070707070737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C75657870007400044E6F6E65707371007E0024000000120001000002000000006400000120000000127071007E000D71007E00227074000B746578744669656C642D327070707070707070707070707070707070707070707070707371007E0036707371007E003A70707071007E005971007E005971007E0057707371007E004070707071007E005971007E0059707371007E003B70707071007E005971007E0059707371007E004370707071007E005971007E0059707371007E004570707071007E005971007E00597070707070707070707070707070000000000201000070707371007E00470000000D7571007E004A000000037371007E004C017400052222202B207371007E004C0474000B504147455F4E554D4245527371007E004C01740005202B2022227400106A6176612E6C616E672E537472696E6770707070707071007E00557400044E6F6E657078700000003201707372002E6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A52426173654461746173657400000000000027D802000D5A000669734D61696E4200177768656E5265736F757263654D697373696E67547970655B00066669656C64737400265B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A524669656C643B4C001066696C74657245787072657373696F6E71007E000F5B000667726F7570737400265B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5247726F75703B4C00046E616D6571007E00025B000A706172616D657465727374002A5B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52506172616D657465723B4C000D70726F706572746965734D617071007E002F4C000571756572797400254C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5251756572793B4C000E7265736F7572636542756E646C6571007E00024C000E7363726970746C6574436C61737371007E00025B000A736F72744669656C647374002A5B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52536F72744669656C643B5B00097661726961626C65737400295B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A525661726961626C653B787001017070707400236D706F7765725F74656D706C6174655F6A72786D6C5F313234303432373938343438307572002A5B4C6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A52506172616D657465723B22000C8D2AC3602102000078700000000F737200306E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365506172616D6574657200000000000027D80200085A000E6973466F7250726F6D7074696E675A000F697353797374656D446566696E65644C001664656661756C7456616C756545787072657373696F6E71007E000F4C000B6465736372697074696F6E71007E00024C00046E616D6571007E00024C000D70726F706572746965734D617071007E002F4C000E76616C7565436C6173734E616D6571007E00024C001276616C7565436C6173735265616C4E616D6571007E00027870010170707400155245504F52545F504152414D45544552535F4D41507372002B6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A5250726F706572746965734D617000000000000027D80200034C00046261736571007E002F4C000E70726F706572746965734C69737471007E00114C000D70726F706572746965734D617074000F4C6A6176612F7574696C2F4D61703B787070707074000D6A6176612E7574696C2E4D6170707371007E0074010170707400115245504F52545F434F4E4E454354494F4E7371007E00777070707400136A6176612E73716C2E436F6E6E656374696F6E707371007E0074010170707400105245504F52545F4D41585F434F554E547371007E00777070707400116A6176612E6C616E672E496E7465676572707371007E0074010170707400125245504F52545F444154415F534F555243457371007E00777070707400286E65742E73662E6A61737065727265706F7274732E656E67696E652E4A5244617461536F75726365707371007E0074010170707400105245504F52545F5343524950544C45547371007E007770707074002F6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A5241627374726163745363726970746C6574707371007E00740101707074000D5245504F52545F4C4F43414C457371007E00777070707400106A6176612E7574696C2E4C6F63616C65707371007E0074010170707400165245504F52545F5245534F555243455F42554E444C457371007E00777070707400186A6176612E7574696C2E5265736F7572636542756E646C65707371007E0074010170707400105245504F52545F54494D455F5A4F4E457371007E00777070707400126A6176612E7574696C2E54696D655A6F6E65707371007E0074010170707400155245504F52545F464F524D41545F464143544F52597371007E007770707074002E6E65742E73662E6A61737065727265706F7274732E656E67696E652E7574696C2E466F726D6174466163746F7279707371007E0074010170707400135245504F52545F434C4153535F4C4F414445527371007E00777070707400156A6176612E6C616E672E436C6173734C6F61646572707371007E00740101707074001A5245504F52545F55524C5F48414E444C45525F464143544F52597371007E00777070707400206A6176612E6E65742E55524C53747265616D48616E646C6572466163746F7279707371007E0074010170707400145245504F52545F46494C455F5245534F4C5645527371007E007770707074002D6E65742E73662E6A61737065727265706F7274732E656E67696E652E7574696C2E46696C655265736F6C766572707371007E0074010170707400125245504F52545F5649525455414C495A45527371007E00777070707400296E65742E73662E6A61737065727265706F7274732E656E67696E652E4A525669727475616C697A6572707371007E00740101707074001449535F49474E4F52455F504147494E4154494F4E7371007E00777070707400116A6176612E6C616E672E426F6F6C65616E707371007E0074010170707400105245504F52545F54454D504C415445537371007E00777070707400146A6176612E7574696C2E436F6C6C656374696F6E707371007E0077707371007E00140000000277040000000A740019697265706F72742E7363726970746C657468616E646C696E67740010697265706F72742E656E636F64696E6778737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000271007E00B67400055554462D3871007E00B5740001307870707070757200295B4C6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A525661726961626C653B62E6837C982CB7440200007870000000057372002F6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A52426173655661726961626C6500000000000027D802000D42000B63616C63756C6174696F6E42000D696E6372656D656E74547970655A000F697353797374656D446566696E65644200097265736574547970654C000A65787072657373696F6E71007E000F4C000E696E6372656D656E7447726F757071007E00254C001B696E6372656D656E746572466163746F7279436C6173734E616D6571007E00024C001F696E6372656D656E746572466163746F7279436C6173735265616C4E616D6571007E00024C0016696E697469616C56616C756545787072657373696F6E71007E000F4C00046E616D6571007E00024C000A726573657447726F757071007E00254C000E76616C7565436C6173734E616D6571007E00024C001276616C7565436C6173735265616C4E616D6571007E0002787008050101707070707371007E0047000000007571007E004A000000017371007E004C0174000E6E657720496E746567657228312971007E00827074000B504147455F4E554D4245527071007E0082707371007E00BD08050102707070707371007E0047000000017571007E004A000000017371007E004C0174000E6E657720496E746567657228312971007E00827074000D434F4C554D4E5F4E554D4245527071007E0082707371007E00BD010501017371007E0047000000027571007E004A000000017371007E004C0174000E6E657720496E746567657228312971007E0082707070707371007E0047000000037571007E004A000000017371007E004C0174000E6E657720496E746567657228302971007E00827074000C5245504F52545F434F554E547071007E0082707371007E00BD010501027371007E0047000000047571007E004A000000017371007E004C0174000E6E657720496E746567657228312971007E0082707070707371007E0047000000057571007E004A000000017371007E004C0174000E6E657720496E746567657228302971007E00827074000A504147455F434F554E547071007E0082707371007E00BD010501037371007E0047000000067571007E004A000000017371007E004C0174000E6E657720496E746567657228312971007E0082707070707371007E0047000000077571007E004A000000017371007E004C0174000E6E657720496E746567657228302971007E00827074000C434F4C554D4E5F434F554E547071007E00827071007E0071707371007E000E7371007E00140000000277040000000A7371007E00240000001200010000020000000063000000B5000000127071007E000D71007E00E870740009746578744669656C64707070707070707070707070707071007E00357070707070707070707371007E0036707371007E003A70707071007E00EC71007E00EC71007E00EA707371007E004070707071007E00EC71007E00EC707371007E003B70707071007E00EC71007E00EC707371007E004370707071007E00EC71007E00EC707371007E004570707071007E00EC71007E00EC7070707070707070707070707070000000000101000070707371007E00470000000A7571007E004A000000037371007E004C0174000A22506167652022202B207371007E004C0474000B504147455F4E554D4245527371007E004C01740009202B2022206F6620227400106A6176612E6C616E672E537472696E6770707070707071007E00557400044E6F6E65707371007E002400000012000100000200000000640000011D000000127071007E000D71007E00E870740009746578744669656C647070707070707070707070707070707070707070707070707371007E0036707371007E003A70707071007E00FE71007E00FE71007E00FC707371007E004070707071007E00FE71007E00FE707371007E003B70707071007E00FE71007E00FE707371007E004370707071007E00FE71007E00FE707371007E004570707071007E00FE71007E00FE7070707070707070707070707070000000000201000070707371007E00470000000B7571007E004A000000037371007E004C017400052222202B207371007E004C0474000B504147455F4E554D4245527371007E004C01740005202B2022227400106A6176612E6C616E672E537472696E6770707070707071007E00557400044E6F6E657078700000003201707371007E000E7371007E00140000000077040000000A7870000000110170757200265B4C6E65742E73662E6A61737065727265706F7274732E656E67696E652E4A525374796C653BD49CC311D90572350200007870000000087372002C6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A52426173655374796C6500000000000027110200315A0009697344656661756C744C00096261636B636F6C6F7271007E002A4C0006626F7264657271007E00294C000B626F72646572436F6C6F7271007E002A4C000C626F74746F6D426F7264657271007E00294C0011626F74746F6D426F72646572436F6C6F7271007E002A4C000D626F74746F6D50616464696E6771007E002B5B0011636F6E646974696F6E616C5374796C65737400315B4C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A52436F6E646974696F6E616C5374796C653B4C001464656661756C745374796C6550726F766964657271007E002E4C000466696C6C71007E00294C0008666F6E744E616D6571007E00024C0008666F6E7453697A6571007E002B4C0009666F7265636F6C6F7271007E002A4C0013686F72697A6F6E74616C416C69676E6D656E7471007E00294C000F6973426C616E6B5768656E4E756C6C71007E00274C00066973426F6C6471007E00274C000869734974616C696371007E00274C000D6973506466456D62656464656471007E00274C000F6973537472696B655468726F75676871007E00274C000C69735374796C65645465787471007E00274C000B6973556E6465726C696E6571007E00274C000A6C656674426F7264657271007E00294C000F6C656674426F72646572436F6C6F7271007E002A4C000B6C65667450616464696E6771007E002B4C00076C696E65426F7871007E002C4C00076C696E6550656E7400234C6E65742F73662F6A61737065727265706F7274732F656E67696E652F4A5250656E3B4C000B6C696E6553706163696E6771007E00294C00066D61726B757071007E00024C00046D6F646571007E00294C00046E616D6571007E00024C000770616464696E6771007E002B4C000B706172656E745374796C6571007E00074C0018706172656E745374796C654E616D655265666572656E636571007E00024C00077061747465726E71007E00024C000B706466456E636F64696E6771007E00024C000B706466466F6E744E616D6571007E00024C000370656E71007E00294C000C706F736974696F6E5479706571007E00294C000672616469757371007E002B4C000B7269676874426F7264657271007E00294C00107269676874426F72646572436F6C6F7271007E002A4C000C726967687450616464696E6771007E002B4C0008726F746174696F6E71007E00294C000A7363616C65496D61676571007E00294C000B737472657463685479706571007E00294C0009746F70426F7264657271007E00294C000E746F70426F72646572436F6C6F7271007E002A4C000A746F7050616464696E6771007E002B4C0011766572746963616C416C69676E6D656E7471007E0029787000707070707070707070740005417269616C737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E00340000000E707371007E003301707070707070707070707371007E0036707371007E003A70707071007E011A71007E011A71007E0115707371007E004070707071007E011A71007E011A707371007E003B70707071007E011A71007E011A707371007E004370707071007E011A71007E011A707371007E004570707071007E011A71007E011A7371007E003C70707071007E011570707074000664657461696C707070707070707070707070707070707070707371007E0112007372000E6A6176612E6177742E436F6C6F7201A51783108F337502000546000666616C70686149000576616C75654C0002637374001B4C6A6176612F6177742F636F6C6F722F436F6C6F7253706163653B5B00096672676276616C75657400025B465B00066676616C756571007E0125787000000000FF6666667070707070707070707070740005417269616C7371007E01170000000E7371007E012300000000FFFFFFFF70707071007E0119707371007E00540171007E0055707070707070707371007E0036707371007E003A7371007E012300000000FF000000707070707372000F6A6176612E6C616E672E466C6F6174DAEDC9A2DB3CF0EC02000146000576616C75657871007E00343F80000071007E012B71007E012B71007E0122707371007E00407371007E012300000000FF000000707070707371007E012E0000000071007E012B71007E012B707371007E003B7371007E012300000000FF000000707070707371007E012E3F40000071007E012B71007E012B707371007E00437371007E012300000000FF000000707070707371007E012E0000000071007E012B71007E012B707371007E00457371007E012300000000FF000000707070707371007E012E0000000071007E012B71007E012B7371007E003C70707071007E012270707371007E003301740006686561646572707070707070707070707070707070707070707371007E011200707070707070707070740005417269616C7371007E01170000000E7071007E01197071007E012A70707070707070707371007E0036707371007E003A70707371007E012E3F80000071007E014271007E014271007E013F707371007E004070707071007E014271007E0142707371007E003B70707071007E014271007E0142707371007E004370707071007E014271007E0142707371007E004570707071007E014271007E01427371007E003C70707071007E013F70707074000F6865616465725661726961626C6573707070707070707070707070707070707070707371007E01120070707070707070707074000756657264616E617371007E01170000001270707071007E012A70707070707070707371007E0036707371007E003A70707071007E014E71007E014E71007E014B707371007E004070707071007E014E71007E014E707371007E003B70707071007E014E71007E014E707371007E004370707071007E014E71007E014E707371007E004570707071007E014E71007E014E7371007E003C70707071007E014B70707074000A7469746C655374796C65707070707070707070707070707070707070707371007E01120070707070707070707070707071007E0035707070707070707070707371007E0036707371007E003A70707071007E015771007E015771007E0156707371007E004070707071007E015771007E0157707371007E003B70707071007E015771007E0157707371007E004370707071007E015771007E0157707371007E004570707071007E015771007E01577371007E003C70707071007E015670707074000C696D706F7274655374796C65707070707070707070707070707070707070707371007E0112007371007E012300000000FFCCCCCC707070707070707070707070707070707070707070707070707371007E0036707371007E003A70707071007E016171007E016171007E015F707371007E004070707071007E016171007E0161707371007E003B70707071007E016171007E0161707371007E004370707071007E016171007E0161707371007E004570707071007E016171007E01617371007E003C70707071007E015F707071007E013D74000B6F6464526F775374796C65707070707070707070707070707070707070707371007E011200707070707070707070740005417269616C707070707071007E00557071007E00557071007E00557070707371007E0036707371007E003A70707071007E016B71007E016B71007E0169707371007E004070707071007E016B71007E016B707371007E003B70707071007E016B71007E016B707371007E004370707071007E016B71007E016B707371007E004570707071007E016B71007E016B7371007E003C70707071007E016970707371007E00330274000C53756D6D6172795374796C65707070707070707070707070707070707070707371007E01120070707070707070707070707371007E012300000000FF316AC570707070707070707070707070707371007E0036707371007E003A70707071007E017671007E017671007E0174707371007E004070707071007E017671007E0176707371007E003B70707071007E017671007E0176707371007E004370707071007E017671007E0176707371007E004570707071007E017671007E01767371007E003C70707071007E017470707074001053756D6D6172795374796C65426C75657071007E016970707070707070707070707070707070707371007E000E7371007E00140000000077040000000A7870000000320170707371007E000E7371007E00140000000277040000000A7371007E00240000001200010000020000000064000001B3000000007071007E000D71007E018070740009746578744669656C647070707070707070707070707070707070707070707070707371007E0036707371007E003A70707071007E018471007E018471007E0182707371007E004070707071007E018471007E0184707371007E003B70707071007E018471007E0184707371007E004370707071007E018471007E0184707371007E004570707071007E018471007E01847070707070707070707070707070000000000201000070707371007E0047000000087571007E004A000000017371007E004C017400146E6577206A6176612E7574696C2E44617465282974000E6A6176612E7574696C2E4461746570707070707071007E00557400044E6F6E6574000A64642F4D4D2F797979797372002C6E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A5242617365496D61676500000000000027D802002349000D626F6F6B6D61726B4C6576656C42000E6576616C756174696F6E54696D6542000F68797065726C696E6B54617267657442000D68797065726C696E6B547970655A000669734C617A7942000B6F6E4572726F72547970654C0014616E63686F724E616D6545787072657373696F6E71007E000F4C0006626F7264657271007E00294C000B626F72646572436F6C6F7271007E002A4C000C626F74746F6D426F7264657271007E00294C0011626F74746F6D426F72646572436F6C6F7271007E002A4C000D626F74746F6D50616464696E6771007E002B4C000F6576616C756174696F6E47726F757071007E00254C000A65787072657373696F6E71007E000F4C0013686F72697A6F6E74616C416C69676E6D656E7471007E00294C001968797065726C696E6B416E63686F7245787072657373696F6E71007E000F4C001768797065726C696E6B5061676545787072657373696F6E71007E000F5B001368797065726C696E6B506172616D657465727371007E00264C001C68797065726C696E6B5265666572656E636545787072657373696F6E71007E000F4C001A68797065726C696E6B546F6F6C74697045787072657373696F6E71007E000F4C000C69735573696E67436163686571007E00274C000A6C656674426F7264657271007E00294C000F6C656674426F72646572436F6C6F7271007E002A4C000B6C65667450616464696E6771007E002B4C00076C696E65426F7871007E002C4C00086C696E6B5479706571007E00024C000770616464696E6771007E002B4C000B7269676874426F7264657271007E00294C00107269676874426F72646572436F6C6F7271007E002A4C000C726967687450616464696E6771007E002B4C000A7363616C65496D61676571007E00294C0009746F70426F7264657271007E00294C000E746F70426F72646572436F6C6F7271007E002A4C000A746F7050616464696E6771007E002B4C0011766572746963616C416C69676E6D656E7471007E0029787200356E65742E73662E6A61737065727265706F7274732E656E67696E652E626173652E4A524261736547726170686963456C656D656E7400000000000027D80200034C000466696C6C71007E00294C00076C696E6550656E71007E01144C000370656E71007E00297871007E002D000000550001000002000000011800000000000000007071007E000D71007E018070740005696D61676570707070707070707371007E003C70707071007E019370000000000101000001707070707070707371007E0047000000097571007E004A000000017371007E004C0174002D227265706F3A2F5265706F7274732F44656661756C742F496D616765732F6D706F7765724C6F676F2E676966227400106A6176612E6C616E672E537472696E6770707070707070707070707371007E0036707371007E003A70707071007E019B71007E019B71007E0193707371007E004070707071007E019B71007E019B707371007E003B70707071007E019B71007E019B707371007E004370707071007E019B71007E019B707371007E004570707071007E019B71007E019B7400044E6F6E6570707070707070707078700000005F0170737200366E65742E73662E6A61737065727265706F7274732E656E67696E652E64657369676E2E4A525265706F7274436F6D70696C654461746100000000000027D80200034C001363726F7373746162436F6D70696C654461746171007E00784C001264617461736574436F6D70696C654461746171007E00784C00166D61696E44617461736574436F6D70696C654461746171007E000178707371007E00B73F4000000000000C77080000001000000000787371007E00B73F4000000000000C7708000000100000000078757200025B42ACF317F8060854E00200007870000012E2CAFEBABE0000002E00B80100386D706F7765725F74656D706C6174655F6A72786D6C5F313234303432373938343438305F313234303538313037313338385F39363134383807000101002C6E65742F73662F6A61737065727265706F7274732F656E67696E652F66696C6C2F4A524576616C7561746F72070003010017706172616D657465725F5245504F52545F4C4F43414C450100324C6E65742F73662F6A61737065727265706F7274732F656E67696E652F66696C6C2F4A5246696C6C506172616D657465723B01001A706172616D657465725F5245504F52545F54494D455F5A4F4E4501001C706172616D657465725F5245504F52545F5649525455414C495A455201001E706172616D657465725F5245504F52545F46494C455F5245534F4C56455201001A706172616D657465725F5245504F52545F5343524950544C455401001F706172616D657465725F5245504F52545F504152414D45544552535F4D415001001B706172616D657465725F5245504F52545F434F4E4E454354494F4E01001D706172616D657465725F5245504F52545F434C4153535F4C4F4144455201001C706172616D657465725F5245504F52545F444154415F534F55524345010024706172616D657465725F5245504F52545F55524C5F48414E444C45525F464143544F525901001E706172616D657465725F49535F49474E4F52455F504147494E4154494F4E01001F706172616D657465725F5245504F52545F464F524D41545F464143544F525901001A706172616D657465725F5245504F52545F4D41585F434F554E5401001A706172616D657465725F5245504F52545F54454D504C41544553010020706172616D657465725F5245504F52545F5245534F555243455F42554E444C450100147661726961626C655F504147455F4E554D4245520100314C6E65742F73662F6A61737065727265706F7274732F656E67696E652F66696C6C2F4A5246696C6C5661726961626C653B0100167661726961626C655F434F4C554D4E5F4E554D4245520100157661726961626C655F5245504F52545F434F554E540100137661726961626C655F504147455F434F554E540100157661726961626C655F434F4C554D4E5F434F554E540100063C696E69743E010003282956010004436F64650C001B001C0A0004001E0C0005000609000200200C0007000609000200220C0008000609000200240C0009000609000200260C000A000609000200280C000B0006090002002A0C000C0006090002002C0C000D0006090002002E0C000E000609000200300C000F000609000200320C0010000609000200340C0011000609000200360C0012000609000200380C00130006090002003A0C00140006090002003C0C00150016090002003E0C0017001609000200400C0018001609000200420C0019001609000200440C001A0016090002004601000F4C696E654E756D6265725461626C6501000E637573746F6D697A6564496E6974010030284C6A6176612F7574696C2F4D61703B4C6A6176612F7574696C2F4D61703B4C6A6176612F7574696C2F4D61703B295601000A696E6974506172616D73010012284C6A6176612F7574696C2F4D61703B29560C004B004C0A0002004D01000A696E69744669656C64730C004F004C0A00020050010008696E6974566172730C0052004C0A0002005301000D5245504F52545F4C4F43414C4508005501000D6A6176612F7574696C2F4D6170070057010003676574010026284C6A6176612F6C616E672F4F626A6563743B294C6A6176612F6C616E672F4F626A6563743B0C0059005A0B0058005B0100306E65742F73662F6A61737065727265706F7274732F656E67696E652F66696C6C2F4A5246696C6C506172616D6574657207005D0100105245504F52545F54494D455F5A4F4E4508005F0100125245504F52545F5649525455414C495A45520800610100145245504F52545F46494C455F5245534F4C5645520800630100105245504F52545F5343524950544C45540800650100155245504F52545F504152414D45544552535F4D41500800670100115245504F52545F434F4E4E454354494F4E0800690100135245504F52545F434C4153535F4C4F4144455208006B0100125245504F52545F444154415F534F5552434508006D01001A5245504F52545F55524C5F48414E444C45525F464143544F525908006F01001449535F49474E4F52455F504147494E4154494F4E0800710100155245504F52545F464F524D41545F464143544F52590800730100105245504F52545F4D41585F434F554E540800750100105245504F52545F54454D504C415445530800770100165245504F52545F5245534F555243455F42554E444C4508007901000B504147455F4E554D42455208007B01002F6E65742F73662F6A61737065727265706F7274732F656E67696E652F66696C6C2F4A5246696C6C5661726961626C6507007D01000D434F4C554D4E5F4E554D42455208007F01000C5245504F52545F434F554E5408008101000A504147455F434F554E5408008301000C434F4C554D4E5F434F554E540800850100086576616C756174650100152849294C6A6176612F6C616E672F4F626A6563743B01000A457863657074696F6E730100136A6176612F6C616E672F5468726F7761626C6507008A0100116A6176612F6C616E672F496E746567657207008C010004284929560C001B008E0A008D008F01000E6A6176612F7574696C2F446174650700910A0092001E01002B7265706F3A2F5265706F7274732F44656661756C742F496D616765732F6D706F7765724C6F676F2E6769660800940100166A6176612F6C616E672F537472696E674275666665720700960100055061676520080098010015284C6A6176612F6C616E672F537472696E673B29560C001B009A0A0097009B01000867657456616C756501001428294C6A6176612F6C616E672F4F626A6563743B0C009D009E0A007E009F010006617070656E6401002C284C6A6176612F6C616E672F4F626A6563743B294C6A6176612F6C616E672F537472696E674275666665723B0C00A100A20A009700A3010004206F66200800A501002C284C6A6176612F6C616E672F537472696E673B294C6A6176612F6C616E672F537472696E674275666665723B0C00A100A70A009700A8010008746F537472696E6701001428294C6A6176612F6C616E672F537472696E673B0C00AA00AB0A009700AC0A0097001E01000B6576616C756174654F6C6401000B6765744F6C6456616C75650C00B0009E0A007E00B10100116576616C75617465457374696D61746564010011676574457374696D6174656456616C75650C00B4009E0A007E00B501000A536F7572636546696C650021000200040000001400020005000600000002000700060000000200080006000000020009000600000002000A000600000002000B000600000002000C000600000002000D000600000002000E000600000002000F000600000002001000060000000200110006000000020012000600000002001300060000000200140006000000020015001600000002001700160000000200180016000000020019001600000002001A0016000000080001001B001C0001001D000000D500020001000000692AB7001F2A01B500212A01B500232A01B500252A01B500272A01B500292A01B5002B2A01B5002D2A01B5002F2A01B500312A01B500332A01B500352A01B500372A01B500392A01B5003B2A01B5003D2A01B5003F2A01B500412A01B500432A01B500452A01B50047B10000000100480000005A0016000000150004001C0009001D000E001E0013001F00180020001D00210022002200270023002C00240031002500360026003B00270040002800450029004A002A004F002B0054002C0059002D005E002E0063002F0068001500010049004A0001001D0000003400020004000000102A2BB7004E2A2CB700512A2DB70054B10000000100480000001200040000003B0005003C000A003D000F003E0002004B004C0001001D0000013600030002000000E22A2B1256B9005C0200C0005EB500212A2B1260B9005C0200C0005EB500232A2B1262B9005C0200C0005EB500252A2B1264B9005C0200C0005EB500272A2B1266B9005C0200C0005EB500292A2B1268B9005C0200C0005EB5002B2A2B126AB9005C0200C0005EB5002D2A2B126CB9005C0200C0005EB5002F2A2B126EB9005C0200C0005EB500312A2B1270B9005C0200C0005EB500332A2B1272B9005C0200C0005EB500352A2B1274B9005C0200C0005EB500372A2B1276B9005C0200C0005EB500392A2B1278B9005C0200C0005EB5003B2A2B127AB9005C0200C0005EB5003DB100000001004800000042001000000046000F0047001E0048002D0049003C004A004B004B005A004C0069004D0078004E0087004F0096005000A5005100B4005200C3005300D2005400E100550002004F004C0001001D000000190000000200000001B10000000100480000000600010000005D00020052004C0001001D00000078000300020000004C2A2B127CB9005C0200C0007EB5003F2A2B1280B9005C0200C0007EB500412A2B1282B9005C0200C0007EB500432A2B1284B9005C0200C0007EB500452A2B1286B9005C0200C0007EB50047B10000000100480000001A000600000065000F0066001E0067002D0068003C0069004B006A00010087008800020089000000040001008B001D000001BE0003000300000132014D1BAA0000012D000000000000000D00000045000000510000005D0000006900000075000000810000008D00000099000000A5000000B0000000B6000000D8000000F300000115BB008D5904B700904DA700DFBB008D5904B700904DA700D3BB008D5904B700904DA700C7BB008D5903B700904DA700BBBB008D5904B700904DA700AFBB008D5903B700904DA700A3BB008D5904B700904DA70097BB008D5903B700904DA7008BBB009259B700934DA7008012954DA7007ABB0097591299B7009C2AB4003FB600A0C0008DB600A412A6B600A9B600AD4DA70058BB009759B700AE2AB4003FB600A0C0008DB600A4B600AD4DA7003DBB0097591299B7009C2AB4003FB600A0C0008DB600A412A6B600A9B600AD4DA7001BBB009759B700AE2AB4003FB600A0C0008DB600A4B600AD4D2CB00000000100480000007A001E000000720002007400480078005100790054007D005D007E0060008200690083006C0087007500880078008C0081008D00840091008D00920090009600990097009C009B00A5009C00A800A000B000A100B300A500B600A600B900AA00D800AB00DB00AF00F300B000F600B4011500B5011800B9013000C1000100AF008800020089000000040001008B001D000001BE0003000300000132014D1BAA0000012D000000000000000D00000045000000510000005D0000006900000075000000810000008D00000099000000A5000000B0000000B6000000D8000000F300000115BB008D5904B700904DA700DFBB008D5904B700904DA700D3BB008D5904B700904DA700C7BB008D5903B700904DA700BBBB008D5904B700904DA700AFBB008D5903B700904DA700A3BB008D5904B700904DA70097BB008D5903B700904DA7008BBB009259B700934DA7008012954DA7007ABB0097591299B7009C2AB4003FB600B2C0008DB600A412A6B600A9B600AD4DA70058BB009759B700AE2AB4003FB600B2C0008DB600A4B600AD4DA7003DBB0097591299B7009C2AB4003FB600B2C0008DB600A412A6B600A9B600AD4DA7001BBB009759B700AE2AB4003FB600B2C0008DB600A4B600AD4D2CB00000000100480000007A001E000000CA000200CC004800D0005100D1005400D5005D00D6006000DA006900DB006C00DF007500E0007800E4008100E5008400E9008D00EA009000EE009900EF009C00F300A500F400A800F800B000F900B300FD00B600FE00B9010200D8010300DB010700F3010800F6010C0115010D0118011101300119000100B3008800020089000000040001008B001D000001BE0003000300000132014D1BAA0000012D000000000000000D00000045000000510000005D0000006900000075000000810000008D00000099000000A5000000B0000000B6000000D8000000F300000115BB008D5904B700904DA700DFBB008D5904B700904DA700D3BB008D5904B700904DA700C7BB008D5903B700904DA700BBBB008D5904B700904DA700AFBB008D5903B700904DA700A3BB008D5904B700904DA70097BB008D5903B700904DA7008BBB009259B700934DA7008012954DA7007ABB0097591299B7009C2AB4003FB600B6C0008DB600A412A6B600A9B600AD4DA70058BB009759B700AE2AB4003FB600B6C0008DB600A4B600AD4DA7003DBB0097591299B7009C2AB4003FB600B6C0008DB600A412A6B600A9B600AD4DA7001BBB009759B700AE2AB4003FB600B6C0008DB600A4B600AD4D2CB00000000100480000007A001E000001220002012400480128005101290054012D005D012E0060013200690133006C0137007501380078013C0081013D00840141008D01420090014600990147009C014B00A5014C00A8015000B0015100B3015500B6015600B9015A00D8015B00DB015F00F3016000F60164011501650118016901300171000100B70000000200017400155F313234303538313037313338385F3936313438387400326E65742E73662E6A61737065727265706F7274732E656E67696E652E64657369676E2E4A524A61766163436F6D70696C6572,1,'2009-04-22 14:20:06',NULL);
/*!40000 ALTER TABLE `JIRepositoryCache` ENABLE KEYS */;


--
-- Definition of table `JIResource`
--

DROP TABLE IF EXISTS `JIResource`;
CREATE TABLE `JIResource` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `parent_folder` bigint(20) NOT NULL,
  `childrenFolder` bigint(20) default NULL,
  `label` varchar(100) NOT NULL,
  `description` varchar(250) default NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`,`parent_folder`),
  KEY `FKD444826DA08E2155` (`parent_folder`),
  KEY `FKD444826DA58002DF` (`childrenFolder`),
  CONSTRAINT `FKD444826DA08E2155` FOREIGN KEY (`parent_folder`) REFERENCES `JIResourceFolder` (`id`),
  CONSTRAINT `FKD444826DA58002DF` FOREIGN KEY (`childrenFolder`) REFERENCES `JIResourceFolder` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4052 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIResource`
--

/*!40000 ALTER TABLE `JIResource` DISABLE KEYS */;
INSERT INTO `JIResource` (`id`,`version`,`name`,`parent_folder`,`childrenFolder`,`label`,`description`,`creation_date`) VALUES
 (1,0,'JServerJdbcDS',4,NULL,'JServer Jdbc data source','JServer Jdbc data source','2008-10-21 15:12:33'),
 (2,0,'JServerJNDIDS',4,NULL,'JServer JNDI data source Updated 1','JServer JNDI data source','2008-10-21 15:12:33'),
 (3,14,'ReportWizardJdbcDS',4,NULL,'Report Wizard JDBC Data Source','','2008-10-21 15:12:33'),
 (4,0,'date',5,NULL,'date_label','date description','2008-10-21 15:12:33'),
 (5,0,'String',5,NULL,'String','String datatype','2008-10-21 15:12:33'),
 (6,0,'FIRST_NAME',5,NULL,'FIRST_NAME','FIRST_NAME','2008-10-21 15:12:33'),
 (7,0,'Number',5,NULL,'Number','','2008-10-21 15:12:33'),
 (9,4,'mpowerLogo.gif',6,NULL,'Orange Leap Logo','Default Orange Leap Logo','2008-10-21 15:12:33'),
 (198,3,'ReportWizardJdbcDSForMPX',4,NULL,'Report Wizard JDBC Data Source For MPX','','2008-10-22 00:00:00'),
 (1866,5,'mpower_template_export_excel_jrxml',898,NULL,'Main jrxml','Main jrxml','2009-01-29 10:17:57'),
 (1867,6,'mpower_template_export_excel',224,898,'orange leap export to excel template','Export to Excel Template','2009-01-29 10:17:57'),
 (1868,6,'mpower_template_landscape_jrxml',899,NULL,'Main jrxml','Main jrxml','2009-01-29 10:17:57'),
 (1869,7,'mpower_template_landscape',224,899,'orange leap landscape template','Landscape Template','2009-01-29 10:17:57'),
 (1940,0,'JRLogo',221,NULL,'JR logo','JR logo','2009-01-29 12:51:28'),
 (1941,1,'mpowerLogo.gif',221,NULL,'Orange Leap Logo','Default Orange Leap Logo','2009-01-29 12:51:28'),
 (2771,0,'JRLogo',6,NULL,'JR logo','JR logo','2009-03-19 15:27:39'),
 (2799,0,'mpowerLogo.gif',1335,NULL,'MPower Logo','MPower Logo from images repository','2009-03-19 15:57:23'),
 (2801,7,'mpower_template',224,1335,'orange leap report template','Default Template','2009-03-19 15:57:23'),
 (3530,0,'orangeleap-logo',216,NULL,'Orange Leap Logo','Default Orange Leap Logo','2009-04-21 16:40:51'),
 (3550,0,'orangeleap-logo',1693,NULL,'Orange Leap Logo','Default Orange Leap Logo','2009-04-22 13:53:06'),
 (3551,0,'orangeleap-logo',1694,NULL,'Orange Leap Logo','Default Orange Leap Logo','2009-04-22 13:53:14'),
 (3552,1,'mpower_template_jrxml',1335,NULL,'Main jrxml','Main jrxml','2009-04-22 14:20:06'),
 (3553,0,'mpower_template_jrxml',1696,NULL,'Main jrxml','Main jrxml','2009-04-22 14:29:41'),
 (3554,0,'mpower_template',218,1696,'orange leap report template','Default Template','2009-04-22 14:29:41'),
 (3555,0,'mpower_template_jrxml',1697,NULL,'Main jrxml','Main jrxml','2009-04-22 14:30:42'),
 (3556,0,'mpower_template',1685,1697,'orange leap report template','Default Template','2009-04-22 14:30:42'),
 (3557,0,'mpower_template_jrxml',1698,NULL,'Main jrxml','Main jrxml','2009-04-22 14:31:27'),
 (3558,0,'mpower_template',1688,1698,'orange leap report template','Default Template','2009-04-22 14:31:27'),
 (3559,0,'mpower_template_export_excel_jrxml',1699,NULL,'Main jrxml','Main jrxml','2009-04-22 14:33:39'),
 (3560,0,'mpower_template_export_excel',218,1699,'orange leap export to excel template','Export to Excel Template','2009-04-22 14:33:39'),
 (3561,0,'mpower_template_export_excel_jrxml',1700,NULL,'Main jrxml','Main jrxml','2009-04-22 14:34:28'),
 (3562,0,'mpower_template_export_excel',1685,1700,'orange leap export to excel template','Export to Excel Template','2009-04-22 14:34:28'),
 (3563,0,'mpower_template_export_excel_jrxml',1701,NULL,'Main jrxml','Main jrxml','2009-04-22 14:35:01'),
 (3564,0,'mpower_template_export_excel',1688,1701,'orange leap export to excel template','Export to Excel Template','2009-04-22 14:35:01'),
 (3565,0,'mpower_template_landscape_jrxml',1702,NULL,'Main jrxml','Main jrxml','2009-04-22 14:36:18'),
 (3566,0,'mpower_template_landscape',218,1702,'orange leap landscape template','Landscape Template','2009-04-22 14:36:18'),
 (3567,0,'mpower_template_landscape_jrxml',1703,NULL,'Main jrxml','Main jrxml','2009-04-22 14:36:57'),
 (3568,0,'mpower_template_landscape',1685,1703,'orange leap landscape template','Landscape Template','2009-04-22 14:36:57'),
 (3569,0,'mpower_template_landscape_jrxml',1704,NULL,'Main jrxml','Main jrxml','2009-04-22 14:37:24'),
 (3570,0,'mpower_template_landscape',1688,1704,'orange leap landscape template','Landscape Template','2009-04-22 14:37:24');
/*!40000 ALTER TABLE `JIResource` ENABLE KEYS */;


--
-- Definition of table `JIResourceFolder`
--

DROP TABLE IF EXISTS `JIResourceFolder`;
CREATE TABLE `JIResourceFolder` (
  `id` bigint(20) NOT NULL auto_increment,
  `version` int(11) NOT NULL,
  `uri` varchar(250) NOT NULL,
  `hidden` bit(1) default NULL,
  `name` varchar(100) NOT NULL,
  `label` varchar(100) NOT NULL,
  `description` varchar(250) default NULL,
  `parent_folder` bigint(20) default NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uri` (`uri`),
  KEY `FK7F24453BA08E2155` (`parent_folder`),
  CONSTRAINT `FK7F24453BA08E2155` FOREIGN KEY (`parent_folder`) REFERENCES `JIResourceFolder` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1934 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIResourceFolder`
--

/*!40000 ALTER TABLE `JIResourceFolder` DISABLE KEYS */;
INSERT INTO `JIResourceFolder` (`id`,`version`,`uri`,`hidden`,`name`,`label`,`description`,`parent_folder`,`creation_date`) VALUES
 (1,0,'/',0x00,'/','root','Root of the folder hierarchy',NULL,'2008-10-21 13:30:16'),
 (4,0,'/datasources',0x00,'datasources','Data Sources','Data Sources used by reports',1,'2008-10-21 15:12:33'),
 (5,0,'/datatypes',0x00,'datatypes','Input data types',NULL,1,'2008-10-21 15:12:33'),
 (6,0,'/images',0x00,'images','Images','Folder containing reusable images',1,'2008-10-21 15:12:33'),
 (8,0,'/Reports',0x00,'Reports','Reports','',1,'2008-10-21 15:12:33'),
 (212,0,'/Reports/company1',0x00,'company1','company1','',8,'2008-12-19 15:59:45'),
 (214,0,'/Reports/Default',0x00,'Default','Default','',8,'2008-12-19 15:59:45'),
 (215,0,'/Reports/company1/Content_files',0x00,'Content_files','Content files','',212,'2008-12-19 15:59:45'),
 (216,0,'/Reports/company1/Images',0x00,'Images','Images','',212,'2008-12-19 15:59:45'),
 (218,1,'/Reports/company1/templates',0x00,'templates','Templates','Templates',212,'2008-12-19 15:59:45'),
 (220,0,'/Reports/Default/Content_files',0x00,'Content_files','Content files','',214,'2008-12-19 15:59:46'),
 (221,0,'/Reports/Default/Images',0x00,'Images','Images','',214,'2008-12-19 15:59:46'),
 (224,1,'/Reports/Default/templates',0x00,'templates','Templates','Templates',214,'2008-12-19 15:59:46'),
 (898,0,'/Reports/Default/templates/mpower_template_export_excel_files',0x01,'mpower_template_export_excel_files','export to excel template','Export to Excel Template',224,'2009-01-29 10:17:57'),
 (899,0,'/Reports/Default/templates/mpower_template_landscape_files',0x01,'mpower_template_landscape_files','mpower landscape template','Landscape Template',224,'2009-01-29 10:17:57'),
 (1116,2,'/Reports/The_Guru_Folder',0x00,'The_Guru_Folder','MPX Reports','',8,'2009-02-17 15:43:13'),
 (1335,1,'/Reports/Default/templates/mpower_template_files',0x01,'mpower_template_files','mpower report template','Default Template',224,'2009-03-19 15:57:23'),
 (1667,0,'/Reports/company1/emailTemplates',0x00,'emailTemplates','emailTemplates','',212,'2009-04-21 15:38:12'),
 (1668,6,'/Reports/company1/emailTemplates/thankYou_files',0x01,'thankYou_files','thankYou','Thank you letter template.',1667,'2009-04-21 15:40:45'),
 (1681,0,'/Reports/sandbox',0x00,'sandbox','sandbox','',8,'2009-04-22 13:51:40'),
 (1682,0,'/Reports/demo',0x00,'demo','demo','',8,'2009-04-22 13:51:46'),
 (1683,0,'/Reports/demo/Content_files',0x00,'Content_files','Content files','',1682,'2009-04-22 13:52:03'),
 (1685,0,'/Reports/demo/Templates',0x00,'Templates','Templates','',1682,'2009-04-22 13:52:18'),
 (1686,0,'/Reports/sandbox/Content_files',0x00,'Content_files','Content files','',1681,'2009-04-22 13:52:25'),
 (1688,0,'/Reports/sandbox/Templates',0x00,'Templates','Templates','',1681,'2009-04-22 13:52:33'),
 (1693,0,'/Reports/demo/Images',0x00,'Images','Images','',1682,'2009-04-22 13:53:06'),
 (1694,0,'/Reports/sandbox/Images',0x00,'Images','Images','',1681,'2009-04-22 13:53:14'),
 (1696,0,'/Reports/company1/templates/mpower_template_files',0x01,'mpower_template_files','orange leap report template','Default Template',218,'2009-04-22 14:29:41'),
 (1697,0,'/Reports/demo/Templates/mpower_template_files',0x01,'mpower_template_files','orange leap report template','Default Template',1685,'2009-04-22 14:30:42'),
 (1698,0,'/Reports/sandbox/Templates/mpower_template_files',0x01,'mpower_template_files','orange leap report template','Default Template',1688,'2009-04-22 14:31:27'),
 (1699,0,'/Reports/company1/templates/mpower_template_export_excel_files',0x01,'mpower_template_export_excel_files','orange leap export to excel template','Export to Excel Template',218,'2009-04-22 14:33:39'),
 (1700,0,'/Reports/demo/Templates/mpower_template_export_excel_files',0x01,'mpower_template_export_excel_files','orange leap export to excel template','Export to Excel Template',1685,'2009-04-22 14:34:28'),
 (1701,0,'/Reports/sandbox/Templates/mpower_template_export_excel_files',0x01,'mpower_template_export_excel_files','orange leap export to excel template','Export to Excel Template',1688,'2009-04-22 14:35:01'),
 (1702,0,'/Reports/company1/templates/mpower_template_landscape_files',0x01,'mpower_template_landscape_files','orange leap landscape template','Landscape Template',218,'2009-04-22 14:36:18'),
 (1703,0,'/Reports/demo/Templates/mpower_template_landscape_files',0x01,'mpower_template_landscape_files','orange leap landscape template','Landscape Template',1685,'2009-04-22 14:36:57'),
 (1704,0,'/Reports/sandbox/Templates/mpower_template_landscape_files',0x01,'mpower_template_landscape_files','orange leap landscape template','Landscape Template',1688,'2009-04-22 14:37:24'),
 (1800,0,'/Reports/company1/mailTemplates',0x00,'mailTemplates','mailTemplates','Contains the templates for mail.',212,'2009-05-12 11:48:03'),
 (1810,0,'/Reports/demo/mailTemplates',0x00,'mailTemplates','mailTemplates','Contains the templates for mail.',1682,'2009-05-14 12:34:57'),
 (1813,0,'/Reports/demo/emailTemplates',0x00,'emailTemplates','emailTemplates','',1682,'2009-05-14 12:35:14'),
 (1815,0,'/Reports/sandbox/emailTemplates',0x00,'emailTemplates','emailTemplates','',1681,'2009-05-14 12:35:37'),
 (1817,0,'/Reports/sandbox/mailTemplates',0x00,'mailTemplates','mailTemplates','Contains the templates for mail.',1681,'2009-05-14 12:36:11'),
 (1930,0,'/Reports/sandbox/Temp',0x00,'Temp','Temp','',1681,'2009-05-20 17:02:37'),
 (1931,0,'/Reports/Default/Temp',0x00,'Temp','Temp','',214,'2009-05-20 17:02:53'),
 (1932,0,'/Reports/demo/Temp',0x00,'Temp','Temp','',1682,'2009-05-20 17:03:14'),
 (1933,0,'/Reports/company1/Temp',0x00,'Temp','Temp','',212,'2009-05-20 17:03:39');
/*!40000 ALTER TABLE `JIResourceFolder` ENABLE KEYS */;


--
-- Definition of table `JIRole`
--

DROP TABLE IF EXISTS `JIRole`;
CREATE TABLE `JIRole` (
  `id` bigint(20) NOT NULL auto_increment,
  `rolename` varchar(100) NOT NULL,
  `externallyDefined` bit(1) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `rolename` (`rolename`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIRole`
--

/*!40000 ALTER TABLE `JIRole` DISABLE KEYS */;
INSERT INTO `JIRole` (`id`,`rolename`,`externallyDefined`) VALUES
 (1,'ROLE_USER',0x00),
 (2,'ROLE_ADMINISTRATOR',0x00),
 (3,'ROLE_ANONYMOUS',0x00),
 (4,'ROLE_USER_COMPANY1',0x00),
 (6,'ROLE_ADMIN_COMPANY1',0x00),
 (7,'ROLE_USER_DEFAULT',0x00),
 (8,'ROLE_ADMIN_DEFAULT',0x00),
 (13,'Role_User_Sandbox',0x00),
 (14,'Role_User_Demo',0x00),
 (15,'Role_Admin_Sandbox',0x00),
 (16,'Role_Admin_Demo',0x00),
 (17,'Role_User_MPX',0x00),
 (18,'Role_Admin_MPX',0x00);
/*!40000 ALTER TABLE `JIRole` ENABLE KEYS */;


--
-- Definition of table `JIUser`
--

DROP TABLE IF EXISTS `JIUser`;
CREATE TABLE `JIUser` (
  `id` bigint(20) NOT NULL auto_increment,
  `username` varchar(100) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `emailAddress` varchar(100) default NULL,
  `password` varchar(100) default NULL,
  `externallyDefined` bit(1) default NULL,
  `enabled` bit(1) default NULL,
  `previousPasswordChangeTime` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIUser`
--

/*!40000 ALTER TABLE `JIUser` DISABLE KEYS */;
INSERT INTO `JIUser` (`id`,`username`,`fullname`,`emailAddress`,`password`,`externallyDefined`,`enabled`,`previousPasswordChangeTime`) VALUES
 (1,'anonymousUser','Anonymous User',NULL,'',0x00,0x01,NULL),
 (2,'jasperadmin@company1','Jasper Administrator','','oleap',0x00,0x01,'2009-04-22 16:58:53'),
 (7,'admin@company1','admin','','admin',0x00,0x01,'2008-12-02 10:53:34'),
 (8,'admin','Default Administrator','','stealth',0x00,0x01,'2009-01-27 22:30:49'),
 (9,'demoadmin','demo administrator for two companies','','demoadmin',0x00,0x01,'2009-04-22 14:02:58'),
 (12,'user1@company1','user1','','user1',0x00,0x01,'2009-01-29 14:29:40'),
 (13,'demouser1','demo user 1','','demouser1',0x00,0x01,'2009-04-22 14:03:03'),
 (15,'demouser1@company1','demo user 1 for company 1','','demouser1',0x00,0x01,'2009-01-29 15:36:34'),
 (16,'demoadmin1','Demo admin for company 1','','demoadmin1',0x00,0x01,'2009-01-29 17:52:10'),
 (18,'nolan@company1','Nolan Ryan','','ryan',0x00,0x01,'2009-04-22 14:38:01'),
 (19,'kburstein@demo','Katherine Burstein','katherine.burstein@orangeleap.com','kburstein',0x00,0x01,'2009-04-22 14:00:55'),
 (20,'rnewcomb@company1','Ryan Newcomb','ryan.newcomb@orangeleap.com','rnewcomb',0x00,0x01,'2009-04-22 14:01:51'),
 (21,'ejohnson@demo','Elyn','ejohnson@orangeleap.com','ejohnson',0x00,0x01,'2009-04-22 14:02:49'),
 (22,'ldangelo@demo','Leo D\'Angelo','leo.dangelo@orangeleap.com','ldangelo',0x00,0x01,'2009-04-22 14:04:25'),
 (23,'mmccabe@demo','Matt McCabe','matt.mccabe@orangeleap.com','mmccabe',0x00,0x01,'2009-04-22 14:05:12'),
 (24,'oleap@demo','Orange Leap','karie.kelly@orangleap.com','oleap',0x00,0x01,'2009-04-22 19:09:31'),
 (25,'rmccabe@demo','Randy McCabe','randy.mccabe@orangeleap.com','rmccabe',0x00,0x01,'2009-04-22 14:06:30'),
 (26,'oleap@sandbox','Orange Leap','karie.kelly@orangleap.com','oleap',0x00,0x01,'2009-04-22 14:07:00'),
 (27,'kwilliams@mpx','Keri Williams','keri@orangeleap.com','kwilliams',0x00,0x01,'2009-04-22 14:25:18'),
 (28,'bklann@demo','Bryan Klann','bryan.klann@orangeleap.com','bklann',0x00,0x01,'2009-04-22 14:08:31'),
 (29,'dschiwietz@mpx','Dagi Schiwietz','dagi@orangeleap.com','dschiwietz',0x00,0x01,'2009-04-22 14:26:15'),
 (30,'greg@company1','Greg Maddux','','maddux',0x00,0x01,'2009-04-22 14:26:47'),
 (31,'jritchie@sandbox','Josiah Ritchie','','jritchie',0x00,0x01,'2009-04-22 19:15:43'),
 (32,'sellingson@sandbox','Sandy Ellingson','','sellingson',0x00,0x01,'2009-04-22 19:16:24'),
 (33,'rnewcomb@demo','Ryan Newcomb','ryan.newcomb@orangeleap.com','rnewcomb',0x00,0x01,'2009-04-23 11:31:12'),
 (35,'admin1','admin1','','admin1',0x00,0x01,'2009-04-23 13:11:50'),
 (36,'admin1@sandbox','admin1','','admin1',0x00,0x01,'2009-04-23 13:25:30'),
 (37,'kkelly@demo','Karie Kelly','karie.kelly@orangeleap.com','kkelly',0x00,0x01,'2009-04-23 17:06:07'),
 (38,'kkelly@sandbox','Kkelly','','kkelly',0x00,0x01,'2009-04-23 13:27:14'),
 (41,'cmarti@sandbox','Chris Marti','cmarti@msci.org','cmarti',0x00,0x01,'2009-04-23 16:18:12'),
 (42,'jmt1@sandbox','Jennifer Charland','jcharland@jmtconsulting.com','jmt1',0x00,0x01,'2009-04-27 08:53:17'),
 (43,'mevans@sandbox','Matt Evans','matt.evans@gwpforum.org','mevans',0x00,0x01,'2009-04-27 10:43:33'),
 (44,'mbazin@sandbox','Mark Bazin','mbazin@cristoreyhouston.org','mbazin',0x00,0x01,'2009-04-27 11:35:54'),
 (45,'siyer@sandbox','Sabarinath Iyer  ','sabari@teamsure.net','siyer',0x00,0x01,'2009-04-27 13:26:59'),
 (46,'bsadler@sandbox','Belden Sadler','bsadler@arcstone.com','bsadler',0x00,0x01,'2009-04-27 15:09:49'),
 (47,'rbarnes@sandbox','Rachel Barnes','rbarnes@ftj.com','rbarnes',0x00,0x01,'2009-04-27 15:40:45'),
 (48,'desiringgod1@sandbox','Desiring God 1','peter.melling@desiringgod.org','desiringgod1',0x00,0x01,'2009-04-27 15:49:25'),
 (49,'desiringgod2@sandbox','Desiring God 2','peter.melling@desiringgod.org','desiringgod2',0x00,0x01,'2009-04-27 15:50:11'),
 (50,'desiringgod3@sandbox','Desiring God 3','peter.melling@desiringgod.org','desiringgod3',0x00,0x01,'2009-04-27 15:50:44'),
 (51,'desiringgod4@sandbox','Desiring God 4','peter.melling@desiringgod.org','desiringgod4',0x00,0x01,'2009-04-27 15:51:29'),
 (52,'cscherer@sandbox','Candace Scherer','Execdir@Ovariancancerfoundation.Org','cscherer',0x00,0x01,'2009-04-28 08:51:39'),
 (53,'bdoyle@sandbox','Bernie Doyle','bdymet@christianityworks.com','bdoyle',0x00,0x01,'2009-04-28 13:24:33'),
 (54,'renner1@sandbox','Rick Renner Ministries 1','mikeclark@renner.org','renner1',0x00,0x01,'2009-04-28 17:07:28'),
 (55,'renner2@sandbox','Rick Renner Ministries 2','mikeclark@renner.org','renner2',0x00,0x01,'2009-04-28 17:08:04'),
 (56,'lweinbrandt@sandbox','Leslie Weinbrandt','leslie.weinbrandt@mosaicinfo.org','lweinbrandt',0x00,0x01,'2009-04-30 15:39:11'),
 (57,'wschiro1@sandbox','WS Chiro 1','dwickes@wschiro.edu','wschiro1',0x00,0x01,'2009-04-30 16:23:46'),
 (58,'wschiro2@sandbox','WS Chiro 2','mkimmel@wschiro.edu','wschiro2',0x00,0x01,'2009-04-30 16:26:02'),
 (59,'eklotz@sandbox','Elaine Klotz','elaine@ourcenter.org','eklotz',0x00,0x01,'2009-05-01 14:18:44'),
 (60,'mstradinger@sandbox','Mike Stradinger','mstradinger@holland1916.com','mstradinger',0x00,0x01,'2009-05-01 14:45:49'),
 (61,'ridley1@sandbox','Ridley College 1','jay_goulart@ridleycollege.com','ridley1',0x00,0x01,'2009-05-01 15:05:26'),
 (62,'ridley2@sandbox','Ridley College 2','jay_goulart@ridleycollege.com','ridley2',0x00,0x01,'2009-05-01 15:06:02'),
 (63,'wdaniels1@sandbox','Walt Daniels User 1','wdhiker@optonline.net','wdaniels1',0x00,0x01,'2009-05-01 15:24:14'),
 (64,'wdaniels2@sandbox','Walt Daniels User 2','wdhiker@optonline.net','wdaniels2',0x00,0x01,'2009-05-01 15:24:50'),
 (65,'cpartners1@sandbox','Charity Partners User 1','dme327@aol.com','cpartners1',0x00,0x01,'2009-05-04 08:44:34'),
 (66,'cpartners2@sandbox','Charity Partners User 2','dme327@aol.com','cpartners2',0x00,0x01,'2009-05-04 08:41:50'),
 (67,'cpartners3@sandbox','Charity Partners User 3','dme327@aol.com','cpartners3',0x00,0x01,'2009-05-04 08:43:37'),
 (68,'cpartners4@sandbox','Charity Partners User 4','dme327@aol.com','cpartners4',0x00,0x01,'2009-05-04 08:44:12'),
 (69,'jasperadmin','Jasper Administrator','','oleap',0x00,0x01,'2009-04-22 16:58:53'),
 (70,'lnewsome@sandbox','Liz Newsome','','lnewsome',0x00,0x01,'2009-05-20 09:25:03'),
 (71,'jwarren@sandbox','John Warren','','jwarren',0x00,0x01,'2009-05-20 09:31:11'),
 (72,'cbailey@sandbox','Claudia Bailey','','cbailey',0x00,0x01,'2009-05-20 09:31:29'),
 (73,'bwarren@sandbox','Bill Warren','','bwarren',0x00,0x01,'2009-05-20 09:31:47'),
 (74,'jbyron@sandbox','J. Byron','','jbyron',0x00,0x01,'2009-05-20 09:51:28'),
 (75,'jknechtel@sandbox','J Knechtel','','jknechtel',0x00,0x01,'2009-05-20 09:52:36'),
 (76,'jparker@sandbox','J Parker','','jparker',0x00,0x01,'2009-05-20 09:53:34'),
 (77,'jwest@sandbox','J West','','jwest',0x00,0x01,'2009-05-20 09:54:04'),
 (78,'kspence@sandbox','K Spence','','kspence',0x00,0x01,'2009-05-20 09:54:27'),
 (79,'lgarome@sandbox','L Garome','','lgarome',0x00,0x01,'2009-05-20 09:55:01'),
 (80,'mdahlman@sandbox','M Dahlman','','mdahlman',0x00,0x01,'2009-05-20 09:56:22'),
 (81,'pdxrestore1@sandbox','PDX Restore1','','pdxrestore1',0x00,0x01,'2009-05-20 09:57:56'),
 (82,'pdxrestore2@sandbox','PDX Restore2','','pdxrestore2',0x00,0x01,'2009-05-20 09:58:23'),
 (83,'tfl1@sandbox','TFL1','','tfl1',0x00,0x01,'2009-05-20 10:00:40'),
 (84,'tfl2@sandbox','TFL2','','tfl2',0x00,0x01,'2009-05-20 10:01:00'),
 (85,'aarp1@sandbox','AARP1','','aarp1',0x00,0x01,'2009-05-20 10:03:16'),
 (86,'AARP2@sandbox','AARP2','','aarp2',0x00,0x00,'2009-05-20 10:03:36'),
 (87,'abrown@sandbox','A Brown','','abrown',0x00,0x01,'2009-05-20 10:03:53'),
 (88,'alucp1@sandbox','ALCUP1','','alcup1',0x00,0x01,'2009-05-20 10:05:34'),
 (89,'alcup2@sandbox','alcup2','','alcup2',0x00,0x01,'2009-05-20 10:06:02'),
 (90,'AUCP1@sandbox','aucp1','','aucp1',0x00,0x01,'2009-05-20 10:06:23'),
 (91,'AUCP2@sandbox','aucp2','','aucp2',0x00,0x01,'2009-05-20 10:06:42'),
 (92,'bautrey@sandbox','Burke Autrey','','bautrey',0x00,0x01,'2009-05-20 10:07:08'),
 (93,'jasperadmin@demo','Jasperadmin Demo','','3366',0x00,0x01,'2009-05-20 16:50:28'),
 (94,'jasperadmin@sandbox','Jasperadmin Sandbox','','7263269',0x00,0x01,'2009-05-20 16:52:21');
/*!40000 ALTER TABLE `JIUser` ENABLE KEYS */;


--
-- Definition of table `JIUserRole`
--

DROP TABLE IF EXISTS `JIUserRole`;
CREATE TABLE `JIUserRole` (
  `roleId` bigint(20) NOT NULL,
  `userId` bigint(20) NOT NULL,
  PRIMARY KEY  (`userId`,`roleId`),
  KEY `FKD8B5C14091865AF` (`userId`),
  KEY `FKD8B5C1403C31045` (`roleId`),
  CONSTRAINT `FKD8B5C1403C31045` FOREIGN KEY (`roleId`) REFERENCES `JIRole` (`id`),
  CONSTRAINT `FKD8B5C14091865AF` FOREIGN KEY (`userId`) REFERENCES `JIUser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIUserRole`
--

/*!40000 ALTER TABLE `JIUserRole` DISABLE KEYS */;
INSERT INTO `JIUserRole` (`roleId`,`userId`) VALUES
 (3,1),
 (1,2),
 (2,2),
 (4,2),
 (6,2),
 (8,2),
 (1,7),
 (6,7),
 (1,8),
 (8,8),
 (1,9),
 (2,9),
 (4,9),
 (6,9),
 (1,12),
 (4,12),
 (1,13),
 (4,13),
 (1,15),
 (4,15),
 (1,16),
 (6,16),
 (1,18),
 (4,18),
 (1,19),
 (14,19),
 (16,19),
 (1,20),
 (14,20),
 (16,20),
 (1,21),
 (14,21),
 (16,21),
 (1,22),
 (14,22),
 (16,22),
 (1,23),
 (14,23),
 (16,23),
 (1,24),
 (2,24),
 (14,24),
 (16,24),
 (1,25),
 (14,25),
 (16,25),
 (1,26),
 (13,26),
 (15,26),
 (1,27),
 (2,27),
 (17,27),
 (18,27),
 (1,28),
 (1,29),
 (2,29),
 (17,29),
 (18,29),
 (1,30),
 (4,30),
 (6,30),
 (1,31),
 (13,31),
 (1,32),
 (13,32),
 (1,33),
 (14,33),
 (16,33),
 (1,35),
 (2,35),
 (1,36),
 (2,36),
 (13,36),
 (15,36),
 (1,37),
 (2,37),
 (14,37),
 (16,37),
 (1,38),
 (2,38),
 (13,38),
 (15,38),
 (1,41),
 (15,41),
 (1,42),
 (15,42),
 (1,43),
 (15,43),
 (1,44),
 (15,44),
 (1,45),
 (15,45),
 (1,46),
 (15,46),
 (1,47),
 (15,47),
 (1,48),
 (15,48),
 (1,49),
 (15,49),
 (1,50),
 (15,50),
 (1,51),
 (15,51),
 (1,52),
 (15,52),
 (1,53),
 (15,53),
 (1,54),
 (15,54),
 (1,55),
 (15,55),
 (1,56),
 (15,56),
 (1,57),
 (15,57),
 (1,58),
 (15,58),
 (1,59),
 (15,59),
 (1,60),
 (13,60),
 (1,61),
 (15,61),
 (1,62),
 (15,62),
 (1,63),
 (15,63),
 (1,64),
 (15,64),
 (1,65),
 (15,65),
 (1,66),
 (15,66),
 (1,67),
 (15,67),
 (1,68),
 (15,68),
 (1,69),
 (2,69),
 (4,69),
 (6,69),
 (8,69),
 (1,70),
 (13,70),
 (1,71),
 (13,71),
 (1,72),
 (13,72),
 (1,73),
 (13,73),
 (1,74),
 (13,74),
 (1,75),
 (13,75),
 (1,76),
 (13,76),
 (1,77),
 (13,77),
 (1,78),
 (13,78),
 (1,79),
 (13,79),
 (1,80),
 (13,80),
 (1,81),
 (13,81),
 (1,82),
 (13,82),
 (1,83),
 (13,83),
 (1,84),
 (13,84),
 (1,85),
 (13,85),
 (1,86),
 (13,86),
 (1,87),
 (13,87),
 (1,88),
 (13,88),
 (1,89),
 (13,89),
 (1,90),
 (13,90),
 (1,91),
 (13,91),
 (1,92),
 (13,92),
 (1,93),
 (16,93),
 (1,94),
 (15,94);
/*!40000 ALTER TABLE `JIUserRole` ENABLE KEYS */;


--
-- Definition of table `JIXMLAConnection`
--

DROP TABLE IF EXISTS `JIXMLAConnection`;
CREATE TABLE `JIXMLAConnection` (
  `id` bigint(20) NOT NULL,
  `catalog` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `datasource` varchar(100) NOT NULL,
  `uri` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK94C688A71D51BFAD` (`id`),
  CONSTRAINT `FK94C688A71D51BFAD` FOREIGN KEY (`id`) REFERENCES `JIOlapClientConnection` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `JIXMLAConnection`
--

/*!40000 ALTER TABLE `JIXMLAConnection` DISABLE KEYS */;
/*!40000 ALTER TABLE `JIXMLAConnection` ENABLE KEYS */;


--
-- Definition of table `QRTZ_BLOB_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `TRIGGER_NAME` varchar(80) NOT NULL,
  `TRIGGER_GROUP` varchar(80) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY  (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `TRIGGER_NAME` (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `QRTZ_BLOB_TRIGGERS`
--

/*!40000 ALTER TABLE `QRTZ_BLOB_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_BLOB_TRIGGERS` ENABLE KEYS */;


--
-- Definition of table `QRTZ_CALENDARS`
--

DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS` (
  `CALENDAR_NAME` varchar(80) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY  (`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `QRTZ_CALENDARS`
--

/*!40000 ALTER TABLE `QRTZ_CALENDARS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_CALENDARS` ENABLE KEYS */;


--
-- Definition of table `QRTZ_CRON_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `TRIGGER_NAME` varchar(80) NOT NULL,
  `TRIGGER_GROUP` varchar(80) NOT NULL,
  `CRON_EXPRESSION` varchar(80) NOT NULL,
  `TIME_ZONE_ID` varchar(80) default NULL,
  PRIMARY KEY  (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `TRIGGER_NAME` (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `QRTZ_CRON_TRIGGERS`
--

/*!40000 ALTER TABLE `QRTZ_CRON_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_CRON_TRIGGERS` ENABLE KEYS */;


--
-- Definition of table `QRTZ_FIRED_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(80) NOT NULL,
  `TRIGGER_GROUP` varchar(80) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `INSTANCE_NAME` varchar(80) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(80) default NULL,
  `JOB_GROUP` varchar(80) default NULL,
  `IS_STATEFUL` varchar(1) default NULL,
  `REQUESTS_RECOVERY` varchar(1) default NULL,
  PRIMARY KEY  (`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `QRTZ_FIRED_TRIGGERS`
--

/*!40000 ALTER TABLE `QRTZ_FIRED_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_FIRED_TRIGGERS` ENABLE KEYS */;


--
-- Definition of table `QRTZ_JOB_DETAILS`
--

DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `JOB_NAME` varchar(80) NOT NULL,
  `JOB_GROUP` varchar(80) NOT NULL,
  `DESCRIPTION` varchar(120) default NULL,
  `JOB_CLASS_NAME` varchar(128) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `IS_STATEFUL` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY  (`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `QRTZ_JOB_DETAILS`
--

/*!40000 ALTER TABLE `QRTZ_JOB_DETAILS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_JOB_DETAILS` ENABLE KEYS */;


--
-- Definition of table `QRTZ_JOB_LISTENERS`
--

DROP TABLE IF EXISTS `QRTZ_JOB_LISTENERS`;
CREATE TABLE `QRTZ_JOB_LISTENERS` (
  `JOB_NAME` varchar(80) NOT NULL,
  `JOB_GROUP` varchar(80) NOT NULL,
  `JOB_LISTENER` varchar(80) NOT NULL,
  PRIMARY KEY  (`JOB_NAME`,`JOB_GROUP`,`JOB_LISTENER`),
  KEY `JOB_NAME` (`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `QRTZ_JOB_LISTENERS_ibfk_1` FOREIGN KEY (`JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `QRTZ_JOB_LISTENERS`
--

/*!40000 ALTER TABLE `QRTZ_JOB_LISTENERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_JOB_LISTENERS` ENABLE KEYS */;


--
-- Definition of table `QRTZ_LOCKS`
--

DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS` (
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY  (`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `QRTZ_LOCKS`
--

/*!40000 ALTER TABLE `QRTZ_LOCKS` DISABLE KEYS */;
INSERT INTO `QRTZ_LOCKS` (`LOCK_NAME`) VALUES
 ('CALENDAR_ACCESS'),
 ('JOB_ACCESS'),
 ('MISFIRE_ACCESS'),
 ('STATE_ACCESS'),
 ('TRIGGER_ACCESS');
/*!40000 ALTER TABLE `QRTZ_LOCKS` ENABLE KEYS */;


--
-- Definition of table `QRTZ_PAUSED_TRIGGER_GRPS`
--

DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `TRIGGER_GROUP` varchar(80) NOT NULL,
  PRIMARY KEY  (`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` ENABLE KEYS */;


--
-- Definition of table `QRTZ_SCHEDULER_STATE`
--

DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `INSTANCE_NAME` varchar(80) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  `RECOVERER` varchar(80) default NULL,
  PRIMARY KEY  (`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `QRTZ_SCHEDULER_STATE`
--

/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` ENABLE KEYS */;


--
-- Definition of table `QRTZ_SIMPLE_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `TRIGGER_NAME` varchar(80) NOT NULL,
  `TRIGGER_GROUP` varchar(80) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(7) NOT NULL,
  PRIMARY KEY  (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `TRIGGER_NAME` (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `QRTZ_SIMPLE_TRIGGERS`
--

/*!40000 ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` ENABLE KEYS */;


--
-- Definition of table `QRTZ_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS` (
  `TRIGGER_NAME` varchar(80) NOT NULL,
  `TRIGGER_GROUP` varchar(80) NOT NULL,
  `JOB_NAME` varchar(80) NOT NULL,
  `JOB_GROUP` varchar(80) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `DESCRIPTION` varchar(120) default NULL,
  `NEXT_FIRE_TIME` bigint(13) default NULL,
  `PREV_FIRE_TIME` bigint(13) default NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) default NULL,
  `CALENDAR_NAME` varchar(80) default NULL,
  `MISFIRE_INSTR` smallint(2) default NULL,
  `JOB_DATA` blob,
  PRIMARY KEY  (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `JOB_NAME` (`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `QRTZ_TRIGGERS`
--

/*!40000 ALTER TABLE `QRTZ_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_TRIGGERS` ENABLE KEYS */;


--
-- Definition of table `QRTZ_TRIGGER_LISTENERS`
--

DROP TABLE IF EXISTS `QRTZ_TRIGGER_LISTENERS`;
CREATE TABLE `QRTZ_TRIGGER_LISTENERS` (
  `TRIGGER_NAME` varchar(80) NOT NULL,
  `TRIGGER_GROUP` varchar(80) NOT NULL,
  `TRIGGER_LISTENER` varchar(80) NOT NULL,
  PRIMARY KEY  (`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_LISTENER`),
  KEY `TRIGGER_NAME` (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_TRIGGER_LISTENERS_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `QRTZ_TRIGGER_LISTENERS`
--

/*!40000 ALTER TABLE `QRTZ_TRIGGER_LISTENERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_TRIGGER_LISTENERS` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
