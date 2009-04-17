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
 
<html>
<head>
  <title><spring:message code='jsp.ListReports.title'/></title>
  <meta name="pageHeading" content="<spring:message code='jsp.ListReports.pageHeading'/>"/>
  </head>

<body>
<%-- "$Id$" --%>
<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr>
    <td>

<span class="fsection"><spring:message code='jsp.ListReports.section'/></span>
<br/>
<br/>
<form name="fmLstRpts" method="post" action="">
<table border="0" width="100%" cellpadding="0" cellspacing="0">
	<input type="submit" name="_eventId_selectReport" id="selectReport" value="" style="visibility:hidden;"/>
	<input type="submit" class="fnormal" name="_eventId_ScheduleReport" id="scheduleReport" value="schedule" style="visibility:hidden;"/>
	<input type="submit" class="fnormal" name="_eventId_runReportInBackground" id="runReportInBackground" value="runReportInBackground" style="visibility:hidden;"/>
	<input type="hidden" name="reportUnit"/>
	<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
  <tr bgcolor="#c2c4b6" class="fheader">
    <td class="paddedcell" width="20%"><spring:message code='jsp.ListReports.report_name'/></td>
    <td class="paddedcell" width="40%"><spring:message code='jsp.ListReports.description'/></td>
    <td class="paddedcell" width="10%"><spring:message code='jsp.ListReports.date'/></td>
    <td class="paddedcell" width="10%"><spring:message code='RM_CREATE_FOLDER_PARENT_FOLDER'/></td>
    
  </tr>
<js:paginator items="${reportUnits}" page="${currentPage}">
<c:forEach var="reportUnit" items="${paginatedItems}" varStatus="itStatus">
  <tr heigth="18" <c:if test="${itStatus.count % 2 == 0}">class="list_alternate"</c:if>>
	<td class="paddedcell">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
				<a href="javascript:document.fmLstRpts.reportUnit.value='${reportUnit.URIString}';document.fmLstRpts.selectReport.click();"><c:out value="${reportUnit.label}"/></a>
				</td>
				<td align="right" valign="middle" nowrap>
					<a href="javascript:document.fmLstRpts.reportUnit.value='${reportUnit.URIString}';document.fmLstRpts.scheduleReport.click();" title="<spring:message code="repository.browser.schedule.hint"/>">
						<img border="0" src="images/schedule.gif" alt="<spring:message code="repository.browser.schedule.hint"/>"/>
					</a>
					<a href="javascript:document.fmLstRpts.reportUnit.value='${reportUnit.URIString}';document.fmLstRpts.runReportInBackground.click();" title="<spring:message code="repository.browser.run.in.background.hint"/>">
						<img border="0" src="images/runreport.gif" alt="<spring:message code="repository.browser.run.in.background.hint"/>"/>
					</a>
				</td>
			</tr>
		</table>
	</td>
    <td class="paddedcell"><c:out value="${reportUnit.description}"/></td>
    <td class="paddedcell" nowrap><js:formatDate value="${reportUnit.creationDate}"/></td>
    <td class="paddedcell" nowrap>   
     <a href="flow.html?_flowId=repositoryExplorerFlow&curlnk=2&showFolder=${reportUnit.parentFolder}">
      <c:out value="${reportUnit.parentFolder}"/>
     </a> 
    </td>
  </tr>
</c:forEach>
	<tr>
		<td class="paddedcell" colspan="4">
			<js:paginatorLinks/>
		</td>
	</tr>
</js:paginator>
</table>
</form>

    </td>
  </tr>
</table>

</body>

</html>


