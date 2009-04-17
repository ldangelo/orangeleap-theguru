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

<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr>
    <td>

<form name="fmEditJob" method="post" action="">
	
<input type="submit" class="fnormal" name="_eventId_jobDetails" id="jobDetails" value="jobDetails" style="visibility:hidden;"/>
<input type="submit" class="fnormal" name="_eventId_jobTrigger" id="jobTrigger" value="jobTrigger" style="visibility:hidden;"/>
<input type="submit" class="fnormal" name="_eventId_jobParameters" id="jobParameters" value="jobParameters" style="visibility:hidden;"/>
<input type="submit" class="fnormal" name="_eventId_jobOutput" id="jobOutput" value="jobOutput" style="visibility:hidden;"/>

<table border="0" cellpadding="1" cellspacing="0" align="center">
<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
  <tr>
    <td align="center">
      <span class="flow_navigation_current"><spring:message code="report.scheduling.job.edit.header"/></span>
      |
      <a class="flow_navigation" href="javascript:document.fmEditJob.jobTrigger.click();"><spring:message code="report.scheduling.job.edit.trigger.header"/></a>
      |
<c:if test="${hasReportParameters}">
      <a class="flow_navigation" href="javascript:document.fmEditJob.jobParameters.click();"><spring:message code="report.scheduling.job.edit.parameters.header"/></a>
      |
</c:if>
      <a class="flow_navigation" href="javascript:document.fmEditJob.jobOutput.click();"><spring:message code="report.scheduling.job.edit.output.header"/></a>
	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>	
  <tr>
    <td>
		
<table border="0" cellpadding="1" cellspacing="0" align="center">
	
<spring:bind path="job.source.reportUnitURI">
  <tr>
	<td align="right"><spring:message code="report.scheduling.job.edit.label.report"/></td>
    <td>&nbsp;</td>
	<td>
      <input type="text" value="${status.value}" size="40" class="fnormal" disabled/>
    </td>
  </tr>
</spring:bind>
	
<spring:bind path="job.label">
  <tr>
	<td align="right">* <spring:message code="report.scheduling.job.edit.label.label"/></td>
    <td>&nbsp;</td>
	<td>
      <input type="text" name="${status.expression}" value="<c:out value="${status.value}"/>" size="40" maxlength="100" class="fnormal"/>
    </td>
  </tr>
  <c:if test="${status.error}">
    <c:forEach items="${status.errorMessages}" var="error">
  <tr>
    <td colspan="2">&nbsp;</td>
	<td><span class="ferror"><c:out value="${error}"/></span></td>
  </tr>
    </c:forEach>
  </c:if>
</spring:bind>
	
<spring:bind path="job.description">
  <tr>
    <td align="right" valign="top"><spring:message code="report.scheduling.job.edit.label.description"/></td>
    <td>&nbsp;</td>
    <td><textarea name="${status.expression}" cols="37" rows="4" class="fnormal"><c:out value="${status.value}"/></textarea></td>
  </tr>
  <c:if test="${status.error}">
    <c:forEach items="${status.errorMessages}" var="error">
  <tr>
    <td colspan="2">&nbsp;</td>
    <td><span class="ferror"><c:out value="${error}"/></span></td>
  </tr>
    </c:forEach>
  </c:if>
</spring:bind>
</table>
		  
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">
      <input type="submit" name="_eventId_cancel" value="<spring:message code="button.cancel"/>" class="fnormal"/>
      &nbsp;
      <input type="submit" name="_eventId_next" value="<spring:message code="button.next"/>" class="fnormal"/>
<c:if test="${!isNewMode}">
      &nbsp;
      <input type="submit" name="_eventId_save" value="<spring:message code="button.save"/>" class="fnormal"/>
</c:if>
    </td>
  </tr>

</table>
</form>

    </td>
  </tr>
</table>
