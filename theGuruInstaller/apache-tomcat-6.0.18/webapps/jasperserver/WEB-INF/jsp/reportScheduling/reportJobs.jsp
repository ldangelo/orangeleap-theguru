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

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/spring" prefix="spring"%>
<%@taglib uri="/WEB-INF/jasperserver.tld" prefix="js" %>

<html>
<head>
  <script language="JavaScript" src="${pageContext.request.contextPath}/scripts/checkbox-utils.js"></script>
  <script language="JavaScript">
	  checkboxListInit('reportJobs', 'frm', 'selectedJobsAll', 'selectedJobs', <%= ((java.util.Collection) pageContext.findAttribute("jobs")).size() %>, 0);
	  
  	function toRemoveJobs() {
  		var toRemove;
  		if (checkboxListAnySelected('reportJobs')) {
  			toRemove = confirm('<spring:message code="remove.confirm.message" javaScriptEscape="true"/>');
  		} else {
  			toRemove = false;
  			alert('<spring:message code="remove.no.item.selected" javaScriptEscape="true"/>');
  		}
  		return toRemove;
  	}
  </script>
</head>

<body>

<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr>
    <td>

<span class="fsection"><spring:message code="report.scheduling.list.title" arguments="${ownerURI}"/></span>
<br/>
<br/>

<c:if test="${not empty requestScope.errorMessage}">
	<span class="ferror"><spring:message code="${requestScope.errorMessage}" arguments="${requestScope.errorArguments}"/></span>
	<br/>
	<br/>
</c:if>

<form name="frm" action="" method="post">
  <input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
  <input type="hidden" name="editJobId" value=""/>
  <input type="submit" class="fnormal" name="_eventId_edit" id="edit" value="edit" style="visibility:hidden;"/>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr bgcolor="#c2c4b6" class="fheader">
    <td class="paddedcell" width="10%"><spring:message code="report.scheduling.list.header.id"/></td>
    <td class="paddedcell" width="23%"><spring:message code="report.scheduling.list.header.label"/></td>
    <td class="paddedcell" width="11%"><spring:message code="report.scheduling.list.header.owner"/></td>
    <td class="paddedcell" width="14%"><spring:message code="report.scheduling.list.header.state"/></td>
    <td class="paddedcell" width="19%"><spring:message code="report.scheduling.list.header.prevFireTime"/></td>
    <td class="paddedcell" width="19%"><spring:message code="report.scheduling.list.header.nextFireTime"/></td>
    <td class="paddedcell" align="center">
		<input type="checkbox" name="selectedJobsAll" class="fnormal" 
			onclick="checkboxListAllClicked('reportJobs', this)"
			title="<spring:message code="list.checkbox.select.all.hint"/>"/>
	</td>
  </tr>
<c:forEach items="${requestScope.jobs}" var="job" varStatus="status">
  <tr <c:if test="${status.count % 2 == 0}">class="list_alternate"</c:if>>
    <td class="paddedcell">
		${job.id}
		&nbsp;
		<a href="javascript:document.frm.editJobId.value='${job.id}';document.frm.edit.click();"><spring:message code="report.scheduling.list.label.edit"/></a>
	</td>
    <td class="paddedcell">
		<c:out value="${job.label}"/>
	</td>
    <td class="paddedcell">
		${job.username}
	</td>
    <td class="paddedcell">
		<spring:message code="report.scheduling.list.state.${job.runtimeInformation.state}"/>
	</td>
    <td class="paddedcell">
		<c:if test="${job.runtimeInformation.previousFireTime != null}">
			<js:formatDate value="${job.runtimeInformation.previousFireTime}"/>
		</c:if>
	</td>
    <td class="paddedcell">
		<c:if test="${job.runtimeInformation.nextFireTime != null}">
			<js:formatDate value="${job.runtimeInformation.nextFireTime}"/>
		</c:if>
	</td>
    <td class="paddedcell" align="center"><input type="checkbox" name="selectedJobs" value="${job.id}" class="fnormal" onclick="checkboxListCheckboxClicked('reportJobs', this)"/></td>
  </tr>
</c:forEach>
  <tr>
    <td colspan="7">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6">
      <% if (request.getParameter("ParentFolderUri") == null) { %>
       <input type="submit" class="fnormal" name="_eventId_back" value="<spring:message code="button.back"/>" class="fnormal" />
      &nbsp;      
      <% } else {  %>
       <input type="button" class="fnormal" name="_eventId_back" value="<spring:message code="button.back"/>" class="fnormal" OnClick='javascript:window.location.href="flow.html?_flowId=repositoryExplorerFlow&showFolder=<%=request.getParameter("ParentFolderUri")%>"'/>
      &nbsp;
      <% } %>
      <input type="submit" class="fnormal" name="_eventId_new" value="<spring:message code="report.scheduling.list.button.new"/>" class="fnormal"/>
      &nbsp;
      <input type="submit" class="fnormal" name="_eventId_now" value="<spring:message code="report.scheduling.list.button.now"/>" class="fnormal"/>
      &nbsp;
      <input type="submit" class="fnormal" name="_eventId_refresh" value="<spring:message code="report.scheduling.list.button.refresh"/>" class="fnormal"/>
    </td>
    <td>
      <input type="submit" class="fnormal" name="_eventId_delete" value="<spring:message code="button.remove"/>" class="fnormal"
		  onclick="return toRemoveJobs()"/>
    </td>
  </tr>
</form>
</table>

    </td>
  </tr>
</table>

</body>
</html>
