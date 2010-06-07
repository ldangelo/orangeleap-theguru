<%@ include file="/WEB-INF/jsp/include.jsp" %>
 <%
        String contextPrefix = System.getProperty("contextPrefix");
        if (contextPrefix == null) contextPrefix = "";
        String redirectURL = "../"+contextPrefix+"jasperserver/flow.html?_flowId=repositoryExplorerFlow";
        response.sendRedirect(redirectURL);
    %>

