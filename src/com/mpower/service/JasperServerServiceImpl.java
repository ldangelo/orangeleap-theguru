package com.mpower.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.jaspersoft.jasperserver.api.metadata.xml.domain.impl.ResourceDescriptor;
import com.jaspersoft.jasperserver.irplugin.JServer;

//@Service("jasperServerService")
public class JasperServerServiceImpl implements JasperServerService {
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
	public void setPassword(String pass) {
		password = pass;

	}

	@Override
	public void setURI(String URI) {
		uri = URI;

	}

	@Override
	public void setUserName(String username) {
		userName = username;

	}

}
