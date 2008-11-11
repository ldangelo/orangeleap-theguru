package com.mpower.service;

import java.util.List;

public interface JasperServerService {
	List list(String dir) throws Exception;

	void setPassword(String pass);
	String getPassword();

	void setUserName(String username);
	String getUserName();

	void setURI(String URI);
	String getURI();
}
