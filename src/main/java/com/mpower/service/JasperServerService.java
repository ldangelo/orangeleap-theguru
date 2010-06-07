package com.mpower.service;

import java.util.List;

import com.jaspersoft.jasperserver.api.metadata.xml.domain.impl.ResourceDescriptor;

public interface JasperServerService {
	
	List list(String dir, String username, String password) throws Exception;

	ResourceDescriptor getDatasource(String datasourceName, String username, String password) throws Exception;

	void setBaseUri(String uri);
	String getBaseUri();
	
	void setRepositoryUri(String uri);
	String getRepositoryUri();

}
