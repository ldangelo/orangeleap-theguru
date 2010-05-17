
<%@ include file="/WEB-INF/jsp/include.jsp" %>
					<%
					String contextPrefix = System.getProperty("contextPrefix");
					if (contextPrefix == null) contextPrefix = "";
					pageContext.setAttribute("contextPrefix",contextPrefix);
					%>

<c:redirect url="../${contextPrefix}jasperserver/flow.html?_flowId=viewReportFlow&reportUnit=${reportPath}&standAlone=true&ParentFolderUri=/reports/Clementine" />
