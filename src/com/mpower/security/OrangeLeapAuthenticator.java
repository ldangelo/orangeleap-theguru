package com.mpower.security;

import java.text.MessageFormat;
import java.util.Iterator;

import javax.naming.directory.DirContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.ldap.DefaultInitialDirContextFactory;
import org.springframework.security.ldap.DefaultSpringSecurityContextSource;
import org.springframework.security.ldap.SpringSecurityContextSource;
import org.springframework.security.ldap.SpringSecurityLdapTemplate;
import org.springframework.security.userdetails.ldap.LdapUserDetailsImpl;
import org.springframework.security.userdetails.ldap.LdapUserDetailsMapper;
import org.springframework.dao.DataAccessException;
import org.springframework.ldap.core.ContextSource;
import org.springframework.ldap.core.DirContextOperations;
import org.springframework.ldap.core.DistinguishedName;
import org.springframework.security.Authentication;
import org.springframework.security.BadCredentialsException;
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;
import org.springframework.security.providers.ldap.LdapAuthenticator;
import org.springframework.security.providers.ldap.authenticator.AbstractLdapAuthenticator;
import org.springframework.security.userdetails.ldap.LdapUserDetails;
import org.springframework.security.ldap.InitialDirContextFactory;
import org.springframework.util.Assert;

import com.mpower.util.SessionHelper;

;

public class OrangeLeapAuthenticator implements LdapAuthenticator {
	private static final Log logger = LogFactory
			.getLog(OrangeLeapAuthenticator.class);

	private LdapUserDetailsMapper userDetailsMapper = new LdapUserDetailsMapper();
	private MessageFormat userLookupPattern; // LDAP pattern to use for finding
	// the user
	DefaultSpringSecurityContextSource contextSource;

	public OrangeLeapAuthenticator(DefaultSpringSecurityContextSource contextSource) {
		//super(contextSource);
		
		this.contextSource = contextSource; 
	}
	   public DirContextOperations authenticate(Authentication authentication) {
	        DirContextOperations user = null;
	        Assert.isInstanceOf(UsernamePasswordAuthenticationToken.class, authentication,
	                "Can only process UsernamePasswordAuthenticationToken objects");

	        String username = authentication.getName();
	        String password = (String)authentication.getCredentials();
	        String userDn = getSearchDN(username);
	        username = username.substring(0,username.indexOf('@'));
	        
	        // If DN patterns are configured, try authenticating with them directly
//	        Iterator dns = getUserDns(username).iterator();

//	        while (dns.hasNext() && user == null) {
	            user = bindWithDn(userDn, username, password);
//	        }

	        if (user == null) {
	            throw new BadCredentialsException("BindAuthenticator.badCredentials", "Bad credentials");
	        }

   			SessionHelper.getGuruSessionData().setUsername(authentication.getName());
			SessionHelper.getGuruSessionData().setPassword(password);

	        return user;
	    }

	
	public DirContextOperations authenticate(Authentication authentication,String dummy) {
		String username = authentication.getName();
		String password = (String) authentication.getCredentials();
		String userDn = getSearchDN(username);
		logger.debug("Attempting bind with [" + userDn + "]");

		DefaultSpringSecurityContextSource contextSource = (DefaultSpringSecurityContextSource) this.contextSource;
//		contextSource.setUserName(username);
		contextSource.setUserDn(userDn);
		contextSource.setPassword(password);
		
		SpringSecurityLdapTemplate template = new SpringSecurityLdapTemplate(contextSource);
		

		// Attempt to bind with the given credentials. If this doesn't throw an
		// exception,
		// credentials are valid. We don't care about the returned user details,
		// we use the
		// details coming out of the database
		try {

			DirContextOperations dirContext = template.retrieveEntry(userDn,null);

			SessionHelper.getGuruSessionData().setUsername(authentication.getName());
			SessionHelper.getGuruSessionData().setPassword(password);
			
			return dirContext;
		} catch (BadCredentialsException e) {
			// This will be thrown if an invalid user name is used and the
			// method may
			// be called multiple times to try different names, so we trap the
			// exception
			// unless a subclass wishes to implement more specialized behaviour.
			logger.debug("Bad Credentials for user " + username);
		}
		return null;
	}

	/**
	 * Build the LDAP query string to attempt to bind the user with. This method
	 * knows how the split the username with the '@' sign in the middle to
	 * breakout the username from the site name.
	 * 
	 * @param username
	 *            to build the LDAP query string for
	 * @return the formatted LDAP query string
	 */
	protected String getSearchDN(String username) {

		String[] args = null;
		if (username.indexOf("@") > -1) {
			args = username.split("@"); // split into username and site name
		} else {
			args = new String[] { username };
		}

		String format = userLookupPattern.format(args);
		
		DefaultSpringSecurityContextSource contextSource = (DefaultSpringSecurityContextSource) this.contextSource;
		
		String rootDn = contextSource.getBaseLdapPathAsString();
//		if (rootDn.length() > 0) {
//			format = format + "," + rootDn;
//		}

		return format;

	}

	public LdapUserDetailsMapper getUserDetailsMapper() {
		return userDetailsMapper;
	}

	public void setUserDetailsMapper(LdapUserDetailsMapper userDetailsMapper) {
		this.userDetailsMapper = userDetailsMapper;
	}

	public String getUserLookupPattern() {
		return userLookupPattern.toString();
	}

	public void setUserLookupPattern(String userLookupPattern) {
		this.userLookupPattern = new MessageFormat(userLookupPattern);
	}
	   private DirContextOperations bindWithDn(String userDn, String username, String password) {
	        SpringSecurityLdapTemplate template = new SpringSecurityLdapTemplate(
	                new BindWithSpecificDnContextSource((SpringSecurityContextSource) contextSource, userDn, password));

	        try {
	            return template.retrieveEntry(userDn, null);

	        } catch (BadCredentialsException e) {
	            // This will be thrown if an invalid user name is used and the method may
	            // be called multiple times to try different names, so we trap the exception
	            // unless a subclass wishes to implement more specialized behaviour.
	            handleBindException(userDn, username, e.getCause());
	        }

	        return null;
	    }

	    /**
	     * Allows subclasses to inspect the exception thrown by an attempt to bind with a particular DN.
	     * The default implementation just reports the failure to the debug log.
	     */
	    protected void handleBindException(String userDn, String username, Throwable cause) {
	        if (logger.isDebugEnabled()) {
	            logger.debug("Failed to bind as " + userDn + ": " + cause);
	        }
	    }

	    private class BindWithSpecificDnContextSource implements ContextSource {
	        private SpringSecurityContextSource ctxFactory;
	        DistinguishedName userDn;
	        private String password;

	        public BindWithSpecificDnContextSource(SpringSecurityContextSource ctxFactory, String userDn, String password) {
	            this.ctxFactory = ctxFactory;
	            this.userDn = new DistinguishedName(userDn);
	            this.userDn.prepend(ctxFactory.getBaseLdapPath());
	            this.password = password;
	        }

	        public DirContext getReadOnlyContext() throws DataAccessException {
	            return ctxFactory.getReadWriteContext(userDn.toString(), password);
	        }

	        public DirContext getReadWriteContext() throws DataAccessException {
	            return getReadOnlyContext();
	        }
	    }

}
