Update jijdbcdatasource
Set connectionUrl = '$jdbcurl$',
username = '$username$',
password = '$password$'
Where id = (Select id from jiresource where jiresource.name = 'ReportWizardJdbcDS');

