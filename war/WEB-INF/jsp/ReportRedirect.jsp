<%@ include file="/WEB-INF/jsp/include.jsp" %>
 <%
        String contextPrefix = System.getProperty("contextPrefix");
        if (contextPrefix == null) contextPrefix = "";
        String redirectURL = "/"+contextPrefix+"jasperserver";
        response.sendRedirect(redirectURL);
    %>

