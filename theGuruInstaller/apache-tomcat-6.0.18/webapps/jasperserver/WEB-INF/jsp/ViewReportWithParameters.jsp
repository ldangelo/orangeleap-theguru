<%--
 Copyright (C) 2005 - 2007 JasperSoft Corporation.  All rights reserved.
 http://www.jaspersoft.com.

 Unless you have purchased a commercial license agreement from JasperSoft,
 the following license terms apply:

 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2 as published by
 the Free Software Foundation.

 This program is distributed WITHOUT ANY WARRANTY; and without the
 implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 See the GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, see http://www.gnu.org/licenses/gpl.txt
 or write to:

 Free Software Foundation, Inc.,
 59 Temple Place - Suite 330,
 Boston, MA  USA  02111-1307
--%>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="com.jaspersoft.jasperserver.war.common.*" %>
<%@page import="net.sf.jasperreports.engine.export.*" %>
<%@taglib uri="/WEB-INF/jasperserver.tld" prefix="js" %>
<%@taglib uri="/spring" prefix="spring" %>
<%@page errorPage="/WEB-INF/jsp/JSErrorPage.jsp" %>

<html>
<head>
  <title><spring:message code="jsp.ViewReportWithParameters.title"/></title>
  <meta name="pageHeading" content="<spring:message code="jsp.ViewReportWithParameters.pageHeading"/>">
</head>

<body>

<%
    Map additionalParameters = new HashMap();
    additionalParameters.put(JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);

	//exporterClassName=''

%>
<form name="viewReportForm" action="" method="post">
<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
<table cellpadding="0" cellspacing="0" width="100%" border="0">
  <tr>
    <td align="center">
<js:jasperviewer
	imageServlet="${pageContext.request.contextPath}/servlets/image"
	page='${requestScope.page}'
	exporterParameters='<%= additionalParameters %>'
	/>
    </td>
  </tr>
</table>
</form>

</body>

</html>

 