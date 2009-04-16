use theguru;

Update jijdbcdatasource
Set connectionUrl = 'MPXConnectionString',
username = 'MPXUserName',
password = 'MPXPassword'
Where id = (Select id from jiresource where jiresource.name = 'ReportWizardJdbcDSForMPX');

