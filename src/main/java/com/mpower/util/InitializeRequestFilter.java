package com.mpower.util;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.FilterChain;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.security.Authentication;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.GrantedAuthorityImpl;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.userdetails.UserDetails;
import org.springframework.security.userdetails.UserDetailsService;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.transaction.support.TransactionSynchronizationManager;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import com.orangeleap.common.security.OrangeLeapSystemAuthenticationToken;

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

		// Check authenticationEnvironment property.  If it is MPX or STANDALONE, then
		// we need to populate the security context.  If it is any other value or just not there,
		// then assume it's using CAS and the security context should be populated elsewhere.
		String authenticationEnvironment = System.getProperty("authenticationEnvironment");
		if ("mpx".equalsIgnoreCase(authenticationEnvironment) || "standalone".equalsIgnoreCase(authenticationEnvironment)) {
			Object username = httpSession.getAttribute("username");
			Object password = httpSession.getAttribute("password");
			// if the user name is null or if the user name or password don't match the incoming values
			if (username == null ||
			(username != null && password != null
			&& (request.getParameter("username") != null && !username.equals(request.getParameter("username"))
			|| request.getParameter("password") != null && !password.equals(request.getParameter("password"))))) {
				username = request.getParameter("username");
				password = request.getParameter("password");
				if (username != null && "mpx".equalsIgnoreCase(System.getProperty("authenticationEnvironment"))) {
					UserDetailsService userDetailsService = (UserDetailsService)getBean(request, "jdbcAuthenticationDao");
					UserDetails userDetails = userDetailsService.loadUserByUsername(username.toString());
					password = userDetails.getPassword();
				}
				httpSession.setAttribute("username", username);
				httpSession.setAttribute("password", password);
			}
			populateSecurityContext(username, password);
		}

		filterChain.doFilter(request, response);
	}

	private void populateSecurityContext(Object username, Object password) {
		if (username != null && password != null) {
			final GrantedAuthority[] ga = new GrantedAuthority[] {new GrantedAuthorityImpl("ROLE_USER")};

			// Create a fake authentication token for tangerine system user
    		Authentication token = new OrangeLeapSystemAuthenticationToken(
    			username.toString(), username, password, null, ga);

    		SecurityContextHolder.getContext().setAuthentication(token);
		}
	}
}
