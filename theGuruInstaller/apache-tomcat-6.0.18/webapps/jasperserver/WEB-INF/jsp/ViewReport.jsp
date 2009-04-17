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

<%@page import="com.jaspersoft.jasperserver.war.common.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/WEB-INF/jasperserver.tld" prefix="js" %>
<%@ taglib prefix="spring" uri="/spring" %>
<%@page errorPage="/WEB-INF/jsp/JSErrorPage.jsp" %>

<html>
<head>
  <title><spring:message code='jsp.ViewReport.title'/></title>
  <meta name="pageHeading" content="<spring:message code='jsp.ViewReport.pageHeading'/>">
  <link href="${pageContext.request.contextPath}/stylesheets/dialog.css" rel="stylesheet" type="text/css">
  <script language="JavaScript" src="${pageContext.request.contextPath}/scripts/error.js"></script>
  <script language="JavaScript" src="${pageContext.request.contextPath}/scripts/ajax.js"></script>
  <script language="JavaScript" src="${pageContext.request.contextPath}/scripts/common.js"></script>
  <script language="JavaScript" src="${pageContext.request.contextPath}/scripts/common-utils.js"></script>
  <script language="JavaScript" src="${pageContext.request.contextPath}/scripts/view-report.js"></script>
</head>

<body>
<div id="parentFolder" style='display:none'><%=request.getParameter("ParentFolderUri")%></div>
<c:set var="showClose" value='${!flowExecutionContext.activeSession.root}' scope="request"/>
<% if (("true".equals(request.getParameter("standAlone"))) || ("true".equals((String)request.getAttribute("standAlone")))) { %>
   <c:set var="showClose" value='true' scope="request"/>
<% } %>


<table cellpadding="0" cellspacing="0" width="100%" border="0">
<c:if test="${hasInputControls and reportControlsLayout == 3}">
  <tr id="topInputControlsPanel" <c:if test="${inputControlsHidden}">style="display:none;"</c:if>>
    <td>
<form name="inputControlsFrm" method="post" action="<c:url value="flow.html"/>" style="margin-bottom:0;"
	onsubmit="submitTopInputValues(); return false">
      <table cellpadding="0" cellspacing="0" width="100%" border="0">
        <tr>
  	      <td align="center" id="inputControlsContainer">
	        <jsp:include page="${controlsDisplayForm}"/>
  	      </td>
        </tr>
      </table>
<input type="hidden" name="ParentFolderUri" id="ParentFolderUri" value="<%=request.getParameter("ParentFolderUri")%>"/>  
</form>
    </td>
  </tr>
</c:if>
  <tr>
    <td>
<form name="viewReportForm" action="<c:url value="flow.html"/>" method="post">
<input type="hidden" name="pageIndex" value="${pageIndex}"/>
      <table width="100%" cellpadding="0" cellspacing="0" border="0">
      	<tr height="0" style="display:none;"><td>
<input type="submit" class="fnormal" name="_eventId_export" value="" style="visibility:hidden;"/>
<input type="submit" class="fnormal" name="_eventId_back" value="" style="visibility:hidden;"/>
<input type="submit" class="fnormal" name="_eventId_close" value="" style="visibility:hidden;"/>
<input type="submit" class="fnormal" name="_eventId_backToListOfReports" value="" style="visibility:hidden;"/>
      	</td></tr>
        <tr>
    <td id="reportContainer" align="center">
      <table id="reportContained" width="100%" cellpadding="0" cellspacing="0" border="0">
      <tr><td>
<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
<c:choose>
	<c:when test="${empty popupInputControlsDialog and empty showOnlyTopControls}">
		<js:jasperviewer
			imageServlet="${pageContext.request.contextPath}/reportimage?jrprint=${jasperPrintName}&"
			page='${requestScope.page}'
			jasperPrintAttribute="${jasperPrintName}"
			renderJsp="${requestScope.reportDisplayForm}"/>
	</c:when>
	<c:when test="${showOnlyTopControls}">
			<table width="100%" cellpadding="0" cellspacing="4" border="0">
				<tr>
					<td align="left" width="10%">
					<c:if test="${showClose}">
						<a href="javascript:closeViewReport(document.getElementById('parentFolder').innerHTML);" title="<spring:message code="jasper.report.view.hint.close"/>">
							<img border="0" src="${pageContext.request.contextPath}/images/return_to_repo.gif" alt="<spring:message code="jasper.report.view.hint.close"/>"/>
						</a>
					</c:if>
					</td>
					<td align="center" width="80%">
					  <div style="font-size:14px; font-weight:bold">
 <%
      if (request.getAttribute("reportUnitDisplayName") != null) {
         session.setAttribute("reportUnitDisplayName", (String)request.getAttribute("reportUnitDisplayName"));
      }
      out.println("<BR>"+session.getAttribute("reportUnitDisplayName"));
%>    
                       </div>  <br>
						<span class="noDataMsg"><spring:message code="jasper.report.view.message.submit.top.controls"/></span>
					</td>
					<td width="10%">
						&nbsp;
					</td>
				</tr>
			</table>
	</c:when>
</c:choose>
      </tr></td>
      </table>
    </td>
        </tr>
      </table>
</form>
    </td>
  </tr>
</table>

<c:if test="${hasInputControls && (reportControlsLayout == 1 || reportControlsLayout == 3)}">
<div id='jsErrorPopup' style='height: 550px; width: 750px;position:absolute;display:none;z-index:99'>
	<jsp:include page="JSErrorPopup.jsp"/>
</div>
</c:if>

<c:if test="${hasInputControls && reportControlsLayout == 1}">
<form name="inputControlsFrm" method="post" action="<c:url value="flow.html"/>"
	onsubmit="submitInputValues(); return false">
<div id="inputControlsContainer" class="dialogtable" 
	 style="top: 100px; left: 376px; width: 400px; position: absolute; display: none;">
	<jsp:include page="ViewReportControlsDialog.jsp"/>
</div>
 <input type="hidden" name="ParentFolderUri" id="ParentFolderUri" value="<%=request.getParameter("ParentFolderUri")%>"/>
</form>

<c:if test="${not empty popupInputControlsDialog}">
<script language="JavaScript">
	showInputControlsDialog(<c:out value="${showClose}"/>);
</script>
</c:if>
</c:if>

</body>

</html>

 
