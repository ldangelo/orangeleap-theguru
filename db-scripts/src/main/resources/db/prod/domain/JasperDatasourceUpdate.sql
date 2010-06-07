Update JIJdbcDatasource
Set connectionUrl = '$jdbcurl$',
username = '$username$',
password = '$password$'
Where id = (Select id from JIResource where JIResource.name = 'ReportWizardJdbcDS');

Update JIJdbcDatasource
Set connectionUrl = '$jdbcurl$',
username = '$username$',
password = '$password$'
Where id = (Select id from JIResource where JIResource.name = 'ReportWizardJdbcDSSegmentationResults');
