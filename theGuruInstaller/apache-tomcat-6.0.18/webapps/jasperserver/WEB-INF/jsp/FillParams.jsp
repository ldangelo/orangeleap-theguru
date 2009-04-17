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
<%@taglib uri="/WEB-INF/jasperserver.tld" prefix="js" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="/spring" %>
<%@ page errorPage="/WEB-INF/jsp/JSErrorPage.jsp" %>


<form name="frm" method="post" action="<c:url value="flow.html"/>">
	<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr><td align="center">
<table border="0" cellpadding="20" cellspacing="0">
  <tr>
    <td align="center" colspan="2">
<br/>
<br/>
  <div style="font-size:14px; font-weight:bold">
 <%
      if (request.getAttribute("reportUnitDisplayName") != null) {
         session.setAttribute("reportUnitDisplayName", (String)request.getAttribute("reportUnitDisplayName"));
      }
      out.println(session.getAttribute("reportUnitDisplayName"));
%>    
  </div>  <br><br> 

<js:parametersForm reportName="${requestScope.reportUnit}" renderJsp="${requestScope.controlsDisplayForm}"/>
    </td>
  </tr>

	<tr>
		<td align="left" nowrap="nowrap">
			<input type="submit" name="_eventId_resetToDefaults" class="fnormal"
				value='<spring:message code="jasper.report.view.inputs.reset"/>'
				title='<spring:message code="jasper.report.view.inputs.reset.hint"/>'/>
		</td>
		<td align="right" nowrap="nowrap">
			<input type="submit" name="_eventId_submit" value='<spring:message code="jsp.FillParams.button.runReport"/>' class="fnormal"/>&nbsp;
		<% if (request.getParameter("ParentFolderUri") != null) { %>	
			<input type="button" name="_eventId_cancel" value='<spring:message code="button.cancel"/>' class="fnormal" onclick='javascript:window.location.href="flow.html?_flowId=repositoryExplorerFlow&showFolder=<%=request.getParameter("ParentFolderUri")%>"' />
		<% } else { %>
		    <input type="submit" name="_eventId_cancel" value='<spring:message code="button.cancel"/>' class="fnormal" />
		<% } %>
		</td>
	</tr>
	
</table>
</td></tr>
</table>
</form>
