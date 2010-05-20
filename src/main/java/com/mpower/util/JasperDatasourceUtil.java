package com.mpower.util;

import java.util.Iterator;

import com.jaspersoft.jasperserver.api.metadata.xml.domain.impl.ResourceDescriptor;
import com.jaspersoft.jasperserver.api.metadata.xml.domain.impl.ResourceProperty;
import com.mpower.service.JasperServerService;

public class JasperDatasourceUtil {
	private JasperServerService jasperServerService;

	public ReportDatasourceSettings getJasperDatasourceSettings(String jasperDatasourceName, String username, String password) throws Exception {
		ResourceDescriptor resource = jasperServerService.getDatasource(jasperDatasourceName, username, password);
		return getReportDatasourceSettings(resource);
	}

	private ReportDatasourceSettings getReportDatasourceSettings(ResourceDescriptor resource) {
		ReportDatasourceSettings reportSegmentationDatasourceSource = new ReportDatasourceSettings();
		Iterator itProperties = resource.getProperties().iterator();
		while (itProperties.hasNext()) {
			ResourceProperty property = (ResourceProperty)itProperties.next();
			if (property.getName().equals(ResourceDescriptor.PROP_DATASOURCE_CONNECTION_URL))
				reportSegmentationDatasourceSource.setConnectionUrl(property.getValue());
			else if (property.getName().equals(ResourceDescriptor.PROP_DATASOURCE_DRIVER_CLASS))
				reportSegmentationDatasourceSource.setDriver(property.getValue());
			else if (property.getName().equals(ResourceDescriptor.PROP_DATASOURCE_USERNAME))
				reportSegmentationDatasourceSource.setUsername(property.getValue());
			else if (property.getName().equals(ResourceDescriptor.PROP_DATASOURCE_PASSWORD))
				reportSegmentationDatasourceSource.setPassword(property.getValue());
		}
		return reportSegmentationDatasourceSource;
	}

	public JasperServerService getJasperServerService() {
		return jasperServerService;
	}

	public void setJasperServerService(JasperServerService jasperServerService) {
		this.jasperServerService = jasperServerService;
	}
}