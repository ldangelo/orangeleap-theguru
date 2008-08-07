package com.mpower.service;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.springframework.stereotype.Component;


import com.mpower.domain.ReportDataSource;

@Component("sessionService")
public class SessionServiceImpl implements SessionService {

    /** Logger for this class and subclasses */
    protected final Log logger = LogFactory.getLog(getClass());
   
	@Override
	public ReportDataSource lookupReportDataSource(ServletRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

//	private static void storeUser(ServletRequest request, User user) {
//		storeValue((HttpServletRequest) request, SessionValue.USER, user);
//	}

//	private static Object lookupValue(HttpServletRequest request, SessionValue name) {
//		return request.getSession(true).getAttribute(name.toString());
//	}

//	private static void storeValue(HttpServletRequest request, SessionValue name, Object value) {
//		request.getSession(true).setAttribute(name.toString(), value);
//	}
}
