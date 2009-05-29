package com.mpower.util;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.transaction.support.TransactionSynchronizationManager;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import com.mpower.util.SessionHelper;;

public class InitializeRequestFilter extends OncePerRequestFilter {

	protected final Log logger = LogFactory.getLog(getClass());

	private Object getBean(HttpServletRequest request, String bean) {
		ServletContext servletContext = request.getSession().getServletContext();
		WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
		return wac.getBean(bean);
	}

	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		HttpSession httpSession = request.getSession();
		assert httpSession != null;
		logger.debug("*** Setting Session");
		SessionHelper.tl_data.set(httpSession);
		filterChain.doFilter(request, response);
	}
}
