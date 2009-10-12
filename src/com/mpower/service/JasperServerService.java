package com.mpower.service;

import java.util.List;

import com.jaspersoft.jasperserver.api.metadata.xml.domain.impl.ResourceDescriptor;

public interface JasperServerService {
	
	List list(String dir) throws Exception;

	ResourceDescriptor getDatasource(String datasourceName) throws Exception;

	void setPassword(String pass);
	String getPassword();

	void setUserName(String username);
	String getUserName();

	void setBaseUri(String uri);
	String getBaseUri();
	
	void setRepositoryUri(String uri);
	String getRepositoryUri();

}
