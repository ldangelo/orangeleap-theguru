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
<%@ taglib uri="/WEB-INF/jasperserver.tld" prefix="js"%>

<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr>
    <td>

<span class="fsection"><spring:message code="jsp.repository.defaultView.header"/></span>
<br/>
<br/>
<spring:message code="jsp.repository.defaultView.path"/>: <a href="<c:url value="flow.html"><c:param name="_flowId" value="repositoryFlow"/></c:url>"><spring:message code="jsp.repository.defaultView.root"/></a>
<c:set var="lastFolder" value="/"/>
<c:forEach items="${requestScope.pathFolders}" var="folder">
/<a href="<c:url value="flow.html"><c:param name="_flowId" value="repositoryFlow"/><c:param name="folder" value="${folder.URIString}"/></c:url>">${folder.name}</a>
<c:set var="lastFolder" value="${folder.URIString}"/>
</c:forEach>
<form name="frm" action="" method="post">
  <input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
  <input type="hidden" name="resource"/>
  <input type="hidden" name="resourceType"/>
  <input type="submit" class="fnormal" name="_eventId_ViewReport" id="viewReport" value="view" style="visibility:hidden;"/>
  <input type="submit" class="fnormal" name="_eventId_ViewOlapModel" id="viewOlapModel" value="view" style="visibility:hidden;"/>
  <input type="submit" class="fnormal" name="_eventId_ScheduleReport" id="scheduleReport" value="schedule" style="visibility:hidden;"/>
  <input type="submit" class="fnormal" name="_eventId_runReportInBackground" id="runReportInBackground" value="runReportInBackground" style="visibility:hidden;"/>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr bgcolor="#c2c4b6" class="fheader">
    <td class="paddedcell" width="20%"><spring:message code="label.display_name"/></td>
    <td class="paddedcell" width="30%"><spring:message code="label.description"/></td>
    <td class="paddedcell" width="20%"><spring:message code="label.type"/></td>
    <td class="paddedcell"><spring:message code="label.date"/></td>
  </tr>
<js:paginator items="${resources}" page="${currentPage}">
<c:forEach items="${paginatedItems}" var="resource" varStatus="itStatus">
<c:if test="${resource.resourceType == 'com.jaspersoft.jasperserver.api.metadata.common.domain.Folder'}">
  <tr height="18" <c:if test="${itStatus.count % 2 == 0}">class="list_alternate"</c:if>>
    <td class="paddedcell"><a href="<c:url value="flow.html"><c:param name="_flowId" value="repositoryFlow"/><c:param name="folder" value="${resource.URIString}"/></c:url>">${resource.label}</a></td>
    <td class="paddedcell">${resource.description}</td>
    <td class="paddedcell"><spring:message code="label.folder"/></td>
    <td class="paddedcell" nowrap><js:formatDate value="${resource.creationDate}"/></td>
  </tr>
</c:if>
<c:if test="${resource.resourceType != 'com.jaspersoft.jasperserver.api.metadata.common.domain.Folder'}">
  <tr height="18" <c:if test="${itStatus.count % 2 == 0}">class="list_alternate"</c:if>>
     <td class="paddedcell">
		<c:choose>
		<c:when test="${resource.resourceType == 'com.jaspersoft.jasperserver.api.metadata.jasperreports.domain.ReportUnit'}">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<a href="javascript:document.frm.resource.value='${resource.URIString}';document.frm.viewReport.click();">
							<c:out value="${resource.label}"/>
						</a>
					</td>
					<td align="right" valign="middle" nowrap>
						<a href="javascript:document.frm.resource.value='${resource.URIString}';document.frm.scheduleReport.click();" title="<spring:message code="repository.browser.schedule.hint"/>">
							<img border="0" src="images/schedule.gif" alt="<spring:message code="repository.browser.schedule.hint"/>"/>
						</a>
						<a href="javascript:document.frm.resource.value='${resource.URIString}';document.frm.runReportInBackground.click();" title="<spring:message code="repository.browser.run.in.background.hint"/>">
							<img border="0" src="images/runreport.gif" alt="<spring:message code="repository.browser.run.in.background.hint"/>"/>
						</a>
					</td>
				</tr>
			</table>
		</c:when>
		<%-- olap web flow --%>
		<c:when test="${resource.resourceType == 'com.jaspersoft.jasperserver.api.metadata.olap.domain.OlapUnit'}">
			<a href="javascript:disableLink('<c:url value="/olap/viewOlap.html"><c:param name="name" value="${resource.URIString}"/><c:param name="new" value="true"/><c:param name="parentFlow" value="repositoryFlow"/><c:param name="folderPath" value="${lastFolder}"/></c:url>');" class="disLink" onclick="this.disabled='true'">
				<c:out value="${resource.label}"/></a>
		</c:when>
		<c:when test="${resource.resourceType == 'com.jaspersoft.jasperserver.api.metadata.common.domain.ContentResource'}">
			<a href="<c:url value="/fileview/fileview${resource.URIString}"/>" target="_new">
				<c:out value="${resource.label}"/></a>
		</c:when>
		<c:otherwise>
			<c:out value="${resource.label}"/>
		</c:otherwise>
		</c:choose>
	</td>
    <td class="paddedcell"><c:out value="${resource.description}"/></td>
    <td class="paddedcell"><spring:message code="resource.${resource.resourceType}.label"/></td>
    <td class="paddedcell" nowrap><js:formatDate value="${resource.creationDate}"/></td>
  </tr>
</c:if>
</c:forEach>
	<tr>
		<td  class="paddedcell" colspan="5">
			<js:paginatorLinks/>
		</td>
	</tr>
</js:paginator>
</table>
</form>

    </td>
  </tr>
</table>

<script type="text/javascript"> 
<!-- // bug #8381 disable olap link after first click
function disableLink(url) { 
	document.write("<style type='text/css'>.disLink{display:none;}</style>"); 
	location.href = url; 
} 
// -->
</script> 

