UPDATE JIJdbcDatasource
SET connectionUrl = CONCAT(connectionUrl, CASE WHEN connectionUrl Like '%?%' THEN '&' ELSE '?' END, 'useCursorFetch=true')
WHERE id IN (Select id From JIResource Where Name In ('ReportWizardJdbcDS', 'ReportWizardJdbcDSSegmentationResults'))
AND connectionUrl Not Like '%useCursorFetch=true%';

UPDATE JIJdbcDatasource
SET connectionUrl = CONCAT(connectionUrl, CASE WHEN connectionUrl Like '%?%' THEN '&' ELSE '?' END, 'useServerPrepStmts=true')
WHERE id IN (Select id From JIResource Where Name In ('ReportWizardJdbcDS', 'ReportWizardJdbcDSSegmentationResults'))
AND connectionUrl Not Like '%useServerPrepStmts=true%';

UPDATE JIJdbcDatasource
SET connectionUrl = CONCAT(connectionUrl, CASE WHEN connectionUrl Like '%?%' THEN '&' ELSE '?' END, 'create=true')
WHERE id IN (Select id From JIResource Where Name In ('ReportWizardJdbcDS', 'ReportWizardJdbcDSSegmentationResults'))
AND connectionUrl Not Like '%create=true%';

UPDATE JIJdbcDatasource
SET connectionUrl = CONCAT(connectionUrl, CASE WHEN connectionUrl Like '%?%' THEN '&' ELSE '?' END, 'maxAllowedPacket=167772160')
WHERE id IN (Select id From JIResource Where Name In ('ReportWizardJdbcDS', 'ReportWizardJdbcDSSegmentationResults'))
AND connectionUrl Not Like '%maxAllowedPacket=167772160%';
