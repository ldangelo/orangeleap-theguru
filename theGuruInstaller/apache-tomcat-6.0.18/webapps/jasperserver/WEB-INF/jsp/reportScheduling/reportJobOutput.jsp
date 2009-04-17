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

<%@page import="java.util.Set,
		com.jaspersoft.jasperserver.war.dto.ByteEnum,
		com.jaspersoft.jasperserver.war.common.UserLocale"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/spring" prefix="spring"%>

<html>
<head>
  <script language="JavaScript">
function clickedSequentialFilenames(checkbox)
{
	var timestampPattern = document.getElementById("timestampPattern");
	var timestampPatternText = document.getElementById("timestampPatternText");
	if (checkbox.checked)
	{
		timestampPattern.value = "";
		timestampPatternText.value = "<spring:message code="report.scheduling.job.edit.repository.inline.hint.timestampPattern" javaScriptEscape="true"/>";
		timestampPatternText.disabled = false;
		timestampPatternText.className = "ftooltip";
	}
	else
	{
		timestampPattern.value = "";
		timestampPatternText.value = "";
		timestampPatternText.disabled = true;
		timestampPatternText.className = "fnormal";
	}
}
  </script>
</head>
<body>

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
<c:if test="${!isRunNowMode}">
      <a class="flow_navigation" href="javascript:document.fmEditJob.jobDetails.click();"><spring:message code="report.scheduling.job.edit.header"/></a>
      |
      <a class="flow_navigation" href="javascript:document.fmEditJob.jobTrigger.click();"><spring:message code="report.scheduling.job.edit.trigger.header"/></a>
      |
</c:if>
<c:if test="${hasReportParameters}">
      <a class="flow_navigation" href="javascript:document.fmEditJob.jobParameters.click();"><spring:message code="report.scheduling.job.edit.parameters.header"/></a>
      |
</c:if>
      <span class="flow_navigation_current"><spring:message code="report.scheduling.job.edit.output.header"/></span>
	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
		
<table border="0" cellpadding="1" cellspacing="0" align="center">	
<spring:bind path="job.baseOutputFilename">
  <tr>
	<td align="right"><spring:message code="report.scheduling.job.edit.output.label.baseFileName"/></td>
    <td>&nbsp;</td>
	<td>
      <input type="text" name="${status.expression}" value="<c:out value="${status.value}"/>" size="40" maxlength="200" class="fnormal"/>
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
	
<spring:bind path="job.contentRepositoryDestination.outputDescription">
  <tr>
	<td align="right" valign="top"><spring:message code="report.scheduling.job.edit.output.label.outputDescription"/></td>
    <td>&nbsp;</td>
	<td>
	  <textarea name="${status.expression}" cols="37" rows="4" class="fnormal"><c:out value='${status.value}'/></textarea>
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
	
<spring:bind path="job.outputFormats">
  <tr>
	<td align="right"><spring:message code="report.scheduling.job.edit.output.label.outputFormats"/></td>
    <td>&nbsp;</td>
	<td>
      <input type="hidden" name="_${status.expression}"/>
      <table border="0" cellpadding="0" cellspacing="0">
	    <tr>
  <c:forEach var="outputFormat" items="${requestScope.allOutputFormats}">
			<td valign="middle">
				<input type="checkbox" name="${status.expression}" value="${outputFormat.code}"
					<%= status.getValue() != null && ((Set) status.getValue()).contains(new Byte(((ByteEnum) pageContext.getAttribute("outputFormat")).getCode())) ? "checked" : "" %>
				/>
			</td>
			<td valign="middle">
				<spring:message code="${outputFormat.labelMessage}"/>
			</td>
			<td>&nbsp;</td>
  </c:forEach>
		</tr>
      </table>
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

<c:if test="${!(empty requestScope.outputLocales)}">	
<spring:bind path="job.outputLocale">
  <tr>
	<td align="right"><spring:message code="report.scheduling.job.edit.output.label.locale"/></td>
    <td>&nbsp;</td>
	<td>
	  <select name="${status.expression}" class="fnormal">
	    <option value="" <c:if test="${empty status.value}">selected</c:if>><spring:message code="report.scheduling.job.edit.output.locale.default"/></option>
  <c:forEach items="${requestScope.outputLocales}" var="locale">
	    <option value="${locale.code}" <c:if test="${status.value == locale.code}">selected</c:if>>
	    	<spring:message code="locale.option"
	    		arguments='<%= new String[]{((UserLocale) pageContext.getAttribute("locale")).getCode(), ((UserLocale) pageContext.getAttribute("locale")).getDescription()} %>'/>
	    </option>
  </c:forEach>
	  </select>
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
</c:if>
	
  <tr>
    <td colspan="3">&nbsp;</td>
  </tr>	
  <tr>
    <td colspan="3" align="center"><span class="fheader"><spring:message code="report.scheduling.job.edit.repository.header"/></span></td>
  </tr>
	
<spring:bind path="job.contentRepositoryDestination.folderURI">
  <tr>
	<td align="right">* <spring:message code="report.scheduling.job.edit.repository.label.folder"/></td>
    <td>&nbsp;</td>
	<td>
	  <select name="${status.expression}" class="fnormal">
	    <option value="" <c:if test="${status.value == ''}">selected</c:if>><spring:message code="report.scheduling.job.edit.repository.folder.none.label"/></option>
  <c:forEach items="${requestScope.contentFolders}" var="folder">
	    <option value="${folder.URIString}" <c:if test="${status.value == folder.URIString}">selected</c:if>>${folder.URIString} (${folder.label})</option>
  </c:forEach>
	  </select>
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
	
<spring:bind path="job.contentRepositoryDestination.sequentialFilenames">
<c:set var="sequentialFilenames" value="${status.value}"/>
  <tr>
	<td align="right"><spring:message code="report.scheduling.job.edit.repository.label.sequentialFilenames"/></td>
    <td>&nbsp;</td>
	<td>
      <input type="hidden" name="_${status.expression}"/>
      <input type="checkbox" name="${status.expression}" <c:if test="${status.value}">checked</c:if> class="fnormal"
      	onclick="clickedSequentialFilenames(this)"
      />
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
	
<spring:bind path="job.contentRepositoryDestination.timestampPattern">
  <tr>
	<td align="right"><spring:message code="report.scheduling.job.edit.repository.label.timestampPattern"/></td>
    <td>&nbsp;</td>
	<td>
	  <input id="timestampPattern" name="${status.expression}" type="hidden" value="${status.value}"/>
      <input type="text" id="timestampPatternText" size="40" maxlength="100"
      <c:choose>
      	<c:when test="${not sequentialFilenames}">
      		class="fnormal" 
      		disabled="disabled"
      	</c:when>
      	<c:when test="${empty status.value}">
      		class="ftooltip" 
      		value="<spring:message code="report.scheduling.job.edit.repository.inline.hint.timestampPattern"/>"
      	</c:when>
      	<c:otherwise>
      		class="fnormal" 
      		value="${status.value}"
      	</c:otherwise>
      </c:choose>
      	onfocus="this.value = document.fmEditJob['${status.expression}'].value;this.className = 'fnormal'"
      	onblur="document.fmEditJob['${status.expression}'].value = this.value;if(this.value == ''){this.value='<spring:message code="report.scheduling.job.edit.repository.inline.hint.timestampPattern" javaScriptEscape="true"/>';this.className='ftooltip'}"
      />
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
	
<spring:bind path="job.contentRepositoryDestination.overwriteFiles">
  <tr>
	<td align="right"><spring:message code="report.scheduling.job.edit.repository.label.overwriteFiles"/></td>
    <td>&nbsp;</td>
	<td>
      <input type="hidden" name="_${status.expression}"/>
      <input type="checkbox" name="${status.expression}" <c:if test="${status.value}">checked</c:if> class="fnormal"/>
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
	
  <tr>
    <td colspan="3">&nbsp;</td>
  </tr>	
  <tr>
    <td colspan="3" align="center"><span class="fheader"><spring:message code="report.scheduling.job.edit.email.header"/></span></td>
  </tr>
	
<spring:bind path="job.mailNotification.toAddresses">
  <tr>
	<td align="right"><spring:message code="report.scheduling.job.edit.email.label.to"/></td>
    <td>&nbsp;</td>
	<td>
      <input type="text" name="${status.expression}" value="${status.value}" size="40" maxlength="1000" class="fnormal"/>
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
	
<spring:bind path="job.mailNotification.subject">
  <tr>
	<td align="right"><spring:message code="report.scheduling.job.edit.email.label.subject"/></td>
    <td>&nbsp;</td>
	<td>
      <input type="text" name="${status.expression}" value="${status.value}" size="40" maxlength="100" class="fnormal"/>
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
	
<spring:bind path="job.mailNotification.messageText">
  <tr>
    <td align="right" valign="top"><spring:message code="report.scheduling.job.edit.email.label.messageText"/></td>
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
	
<spring:bind path="job.mailNotification.resultSendType">
  <tr>
	<td align="right"><spring:message code="report.scheduling.job.edit.email.label.attachFiles"/></td>
    <td>&nbsp;</td>
	<td>
      <input type="hidden" name="${status.expression}" value="${status.value}"/>
      <input type="checkbox" name="attachFilesCheckbox" <c:if test="${status.value == 2}">checked</c:if> class="fnormal"
		  onclick="document.fmEditJob['${status.expression}'].value = this.checked ? 2 : 1"/>
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
	
<spring:bind path="job.mailNotification.skipEmptyReports">
  <tr>
	<td align="right"><spring:message code="report.scheduling.job.edit.email.label.skipEmptyReports"/></td>
    <td>&nbsp;</td>
	<td>
      <input type="hidden" name="_${status.expression}" value="${status.value}"/>
      <input type="checkbox" name="${status.expression}" <c:if test="${status.value}">checked</c:if> class="fnormal"/>
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
		  
</table>
		  
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">
      <input type="submit" name="_eventId_cancel" value="<spring:message code="button.cancel"/>"  class="fnormal"/>
      &nbsp;
<c:if test="${!isRunNowMode or hasReportParameters}">
      <input type="submit" name="_eventId_back" value="<spring:message code="button.back"/>" class="fnormal"/>
      &nbsp;
</c:if>
      <input type="submit" name="_eventId_save" value="<spring:message code="button.save"/>" class="fnormal"/>
    </td>
  </tr>

</table>
</form>

    </td>
  </tr>
</table>

</body>
</html>
