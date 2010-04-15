<%@ include file="/WEB-INF/jsp/include.jsp" %>
	<%
    	String contextPrefix = System.getProperty("contextPrefix");
        if (contextPrefix == null) contextPrefix = "";
        String redirectURL = "/" + contextPrefix + "jasperserver/flow.html?_flowId=reportJobFlow&isNewModeRequest=true&isRunNowModeRequest=true&reportUnitURIRequest="  + request.getAttribute("reportPath") 
          + "&ParentFolderUri=" + request.getAttribute("reportParentPath") 
          + "&outputName=" + request.getAttribute("reportName")
          + "&defaultOutputLocation=" + "/Reports/" + request.getAttribute("companyName") + "/Content_files";
        response.sendRedirect(redirectURL);
	%>
 
