package com.mpower.service;

import java.util.List;

import com.jaspersoft.jasperserver.api.metadata.xml.domain.impl.ResourceDescriptor;
import com.jaspersoft.jasperserver.irplugin.JServer;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

//@Service("jasperServerService")
public class JasperServerServiceImpl implements JasperServerService {
    protected final Log logger = LogFactory.getLog(getClass());
    private String userName;
    private String password;
    private String uri;
    private JServer jserver;

    @Override
    public String getPassword() {
	return password;
    }

    @Override
    public String getURI() {
	return uri;
    }

    @Override
    public String getUserName() {
	return userName;
    }

    @Override
    public List list(String dir) throws Exception {
	logger.info("list(" + dir + ")");
	jserver = new JServer();
	jserver.setUsername(userName);
	jserver.setPassword(password);
	jserver.setUrl(uri);
	ResourceDescriptor rd = new ResourceDescriptor();
	rd.setWsType(ResourceDescriptor.TYPE_FOLDER);
	rd.setUriString(dir);

	return jserver.getWSClient().list(rd);
    }

    @Override
    public ResourceDescriptor getDatasource(String datasourceName) throws Exception {
    	ResourceDescriptor result = null;

    	logger.info("getDatasource(" + datasourceName + ")");
    	jserver = new JServer();
		jserver.setUsername(userName);
		jserver.setPassword(password);
		jserver.setUrl(uri);

		List datasources = jserver.getWSClient().listDatasources();
		java.util.Iterator itDatasources = datasources.iterator();
		while (itDatasources.hasNext()) {
			ResourceDescriptor resource = (ResourceDescriptor) itDatasources.next();
			if (resource.getUriString().equals(datasourceName)) {
				return resource;
			}
		}
		return result;
    }

    @Override
    public void setPassword(String pass) {
	logger.info("setPassword(" + pass + ")");
	password = pass;

    }

    @Override
    public void setURI(String URI) {
	logger.info("setURI(" + URI + ")");
	uri = URI;

    }

    @Override
    public void setUserName(String username) {
	logger.info("setUserName(" + username + ")");
	userName = username;

    }

}
