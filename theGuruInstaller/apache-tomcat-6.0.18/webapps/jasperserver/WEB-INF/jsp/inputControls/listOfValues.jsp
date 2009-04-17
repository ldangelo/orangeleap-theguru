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

<%@ page language="java" contentType="text/html" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<html>
<head>
<meta name="pageHeading" content="<spring:message code="jsp.listOfValues.pageHeading"/>"/>
<title><spring:message code="jsp.listOfValues.title"/></title>
<script>
function jumpTo(pageTo){
    document.forms[0].jumpToPage.value=pageTo;
    document.forms[0].jumpButton.click();
}
</script>
</head>
<body bgcolor="#CCCCCC">

<FORM name="fmCRContLov" action="" method="post">
<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr valign="top">
<c:if test='${masterFlow == "reportUnit"}'>
    <td width="1">
<table width="100%" border="0" cellpading="0" cellspacing="0">
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.naming"/></span></td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.jrxml"/></span></td></tr>
  <tr><td nowrap="true"><a class="wizard_menu_current" href="javascript:document.forms[0]._eventId_Cancel.click();"><spring:message code="jsp.reportWizard.resources"/></a></td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.dataSource"/></span></td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.query"/></span></td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.customization"/></span></td></tr>
</table>
    </td>
</c:if>
    <td>

<table align="center" cellspacing="1" cellpadding="0" border="0">

	<tr>
	  <td>&nbsp;</td>
	  <td colspan="2"><span class="fsection"><spring:message code="jsp.listOfValues.title"/></span></td>
	</tr>
	<tr>
		<td colspan="3">&nbsp;</td>
	</tr>

	<spring:bind path="control.source">
		<tr>
			<td>&nbsp;</td>
			<td><input name="${status.expression}" type="radio" value="CONTENT_REPOSITORY" <c:if test='${status.value!="LOCAL"}'>checked="true"</c:if> <c:if test="${empty control.existingPathList}">disabled</c:if>></td>
			<td><spring:message code="label.fromRepository"/></td>
		</tr>
	</spring:bind>
	<spring:bind path="control.existingPath">
		<tr>
			<td colspan="2">&nbsp;</td>
			<td>
				<select name="${status.expression}" size="1"<c:if test="${empty control.existingPathList}">disabled</c:if> class="fnormal">
					<c:forEach items='${control.existingPathList}' var='path'>
						<option value="${path}" <c:if test='${path==status.value}'>selected="true"</c:if>>${path}</option>
					</c:forEach>
				<c:if test="${status.error!=null}"><BR><span class="ferror">${status.errorMessage}</span></c:if>
				</select>
			</td>
		</tr>
	</spring:bind>

	<tr>
		<td colspan="3">&nbsp;</td>
	</tr>

	<spring:bind path="control.source">
		<tr>
			<td>&nbsp;</td>
			<td><input type="radio" name="${status.expression}" value="LOCAL" <c:if test='${status.value=="LOCAL"}'>checked="true"</c:if>></td>
			<td><spring:message code="label.locallyDefined"/></td>
		</tr>
	</spring:bind>

	<tr>
		<td colspan="3">&nbsp;</td>
	</tr>

	<tr>
		<td>&nbsp;</td>
		<td colspan="2">
		   <c:if test='${masterFlow == "reportUnit"}'>
		    <input type="submit" class="fnormal" name="_eventId_Cancel" value="<spring:message code="button.cancel"/>"/>&nbsp;
		   </c:if>
		   <c:if test='${masterFlow != "reportUnit"}'>
			<input type="button" class="fnormal" name="_eventId_Cancel" value="<spring:message code="button.cancel"/>" OnClick='javascript:window.location.href="flow.html?_flowId=repositoryExplorerFlow&showFolder=<%=request.getParameter("ParentFolderUri")%>"'/>&nbsp;
		   </c:if>
		   <input type="submit" class="fnormal" name="_eventId_Back" value="<spring:message code="button.back"/>"/>&nbsp;
		   <input type="submit" class="fnormal" name="_eventId_Next" value="<spring:message code="button.next"/>"/>
		</td>
	</tr>
</table>

	<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>

</td>
</tr>
</table>
</FORM>
</body>
</html>
