package com.mpower.security;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.Authentication;
import org.springframework.security.context.HttpSessionContextIntegrationFilter;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;
import org.springframework.security.providers.cas.CasAuthenticationToken;
import org.springframework.security.providers.preauth.PreAuthenticatedAuthenticationToken;
import org.springframework.security.userdetails.ldap.LdapUserDetails;

import com.orangeleap.common.security.AuthenticationHelper;
import com.orangeleap.common.security.OrangeLeapRequestLocal;
import com.orangeleap.common.security.OrangeLeapUsernamePasswordLocal;

public class ClementineAuthenticationHelper implements AuthenticationHelper {

	protected final Log logger = LogFactory.getLog(getClass());
	
	@Override
	public void postProcess(Authentication authentication) {
		Map<String, Object> info = OrangeLeapUsernamePasswordLocal.getOrangeLeapAuthInfo();
		
		if (authentication instanceof UsernamePasswordAuthenticationToken) {

			UsernamePasswordAuthenticationToken token = (UsernamePasswordAuthenticationToken)authentication;

			if (SecurityContextHolder.getContext().getAuthentication() == null) {
				SecurityContextHolder.getContext().setAuthentication(token);
			}
			token.setDetails(info);
			info.put(OrangeLeapUsernamePasswordLocal.PASSWORD, authentication.getCredentials());
		} else if (authentication instanceof CasAuthenticationToken) {
			CasAuthenticationToken token = (CasAuthenticationToken) authentication;
			if (SecurityContextHolder.getContext().getAuthentication() == null)
				SecurityContextHolder.getContext().setAuthentication(token);
			token.setDetails(info);
			info.put(OrangeLeapUsernamePasswordLocal.PASSWORD, ((LdapUserDetails)authentication.getPrincipal()).getPassword());
		} else if (authentication instanceof PreAuthenticatedAuthenticationToken) {
			PreAuthenticatedAuthenticationToken token = (PreAuthenticatedAuthenticationToken) authentication;
			if (SecurityContextHolder.getContext().getAuthentication() == null)
				SecurityContextHolder.getContext().setAuthentication(token);
			token.setDetails(info);
			info.put(OrangeLeapUsernamePasswordLocal.PASSWORD, "");
		}
		
		String userName = ((LdapUserDetails)authentication.getPrincipal()).getUsername();
		String siteName = userName.substring(userName.indexOf('@') +1);

		info.put(OrangeLeapUsernamePasswordLocal.USER_NAME,userName);
		info.put(OrangeLeapUsernamePasswordLocal.SITE,siteName);
		

		//
		// let's switch schema's here since we know we are authenticated properly now...

		//setting this in the session so that jasperserver will not have a null password
		HttpServletRequest request = OrangeLeapRequestLocal.getRequest();
		if (request != null) {
		   HttpSession session = request.getSession();
		   if (session != null) session.setAttribute(HttpSessionContextIntegrationFilter.SPRING_SECURITY_CONTEXT_KEY, SecurityContextHolder.getContext());
		}
		
		
		
		// Log remote user parms
		String remoteuserheader = OrangeLeapRequestLocal.getRequest().getHeader("REMOTE_USER");
		if (remoteuserheader != null) {
			logger.info("REMOTE_USER (header) = "+remoteuserheader);
		}
		Object remoteuserattr = OrangeLeapRequestLocal.getRequest().getAttribute("REMOTE_USER");
		if (remoteuserattr != null) {
			logger.info("REMOTE_USER (environment/attribute) = "+remoteuserattr);
		}
        String getremoteuser = OrangeLeapRequestLocal.getRequest().getRemoteUser();
		if (getremoteuser != null) {
			logger.info("getRemoteUser() = "+getremoteuser);
		}
		if (remoteuserheader == null && remoteuserattr == null && getremoteuser == null) {
			logger.info("Remote user header is blank.");
		}

	}
	
}
