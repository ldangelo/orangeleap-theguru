package com.mpower.ws.orangeleapV2.client;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.xml.namespace.QName;

import org.apache.cxf.endpoint.Client;
import org.apache.cxf.ws.security.wss4j.WSS4JOutInterceptor;
import org.apache.ws.security.WSConstants;
import org.apache.ws.security.handler.WSHandlerConstants;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import com.mpower.ws.orangeleapV2.client.OrangeLeapService;
import com.orangeleap.common.security.CasUtil;
import com.orangeleap.common.security.OrangeLeapAuthentication;

public class OrangeLeapWebServiceClientV2 extends OrangeLeapAuthentication implements ApplicationContextAware{
	private static ApplicationContext ctx = null;
	
	public static ApplicationContext getApplicationContext() {
		return ctx;
	}

	public void setApplicationContext(ApplicationContext ctx) {
		this.ctx = ctx;
	}
	
	public OrangeLeap getOrangeLeap() {
		OrangeLeapService orangeLeapService;
		String siteName = "orangeleap";
		if (System.getProperty("contextPrefix").replace("-", "").length() > 0)
			siteName = System.getProperty("contextPrefix").replace("-", "");
		try {
			String url = System.getProperty("casClient.serverUrl") +  "/" + siteName + "/services2.0/orangeleap.wsdl";
			String targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/";
			String serviceName = "OrangeLeapService";
			orangeLeapService = new OrangeLeapService(new URL(url), new QName(targetNamespace, serviceName));
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}

		OrangeLeap orangeLeapPort = orangeLeapService.getOrangeLeapPort();

		ApplicationContext applicationContext = getApplicationContext();

		CasUtil.populateOrageLeapAuthenticationWithCasCredentials(this, System.getProperty("casClient.serverUrl") +  "/" + siteName + "/j_spring_cas_security_check");
    	
        Map outProps = new HashMap();
		Client client = org.apache.cxf.frontend.ClientProxy.getClient(orangeLeapPort);
		org.apache.cxf.endpoint.Endpoint cxfEndpoint = client.getEndpoint();

		PWCallbackHandler pwHandler = new PWCallbackHandler(this.getUserName(),this.getPassword());
		outProps.put(WSHandlerConstants.ACTION,WSHandlerConstants.USERNAME_TOKEN);
		outProps.put(WSHandlerConstants.USER, this.getUserName());
		outProps.put(WSHandlerConstants.PASSWORD_TYPE, WSConstants.PW_TEXT);
//		outProps.put(WSHandlerConstants.PW_CALLBACK_CLASS, PWCallbackHandler.class.getName());
		outProps.put(WSHandlerConstants.PW_CALLBACK_REF, pwHandler);
		outProps.put(WSHandlerConstants.ADD_UT_ELEMENTS,WSConstants.NONCE_LN + " " + WSConstants.CREATED_LN);

		WSS4JOutInterceptor wssOut = new WSS4JOutInterceptor(outProps);
		cxfEndpoint.getOutInterceptors().add(wssOut);
		return orangeLeapPort;
	}
}
