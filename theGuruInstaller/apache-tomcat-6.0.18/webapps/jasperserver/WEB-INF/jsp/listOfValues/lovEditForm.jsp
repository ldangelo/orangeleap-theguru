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

<HTML>
<HEAD>
<TITLE><spring:message code="jsp.lovEditForm.title"/></TITLE>
<meta name="pageHeading" content="<spring:message code="jsp.lovEditForm.pageHeading"/>"/>
</HEAD>
<body leftMargin="0" topMargin="0" marginheight="0" marginwidth="0">

<form name="fmListOfValues" method="post" action="">
<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr valign="top">
<c:if test='${masterFlow == "reportUnit"}'>
    <td width="1">
<table width="100%" border="0" cellpading="0" cellspacing="0">
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.naming"/></span></td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.jrxml"/></span></td></tr>
  <tr><td nowrap="true"><a class="wizard_menu_current" href="javascript:document.forms[0]._eventId_cancel.click();"><spring:message code="jsp.reportWizard.resources"/></a></td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.dataSource"/></span></td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.query"/></span></td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.customization"/></span></td></tr>
</table>
    </td>
</c:if>
    <td>

<table align="center" cellspacing="1" cellpadding="0" border="0">
	<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>

	<tr>
	  <td>&nbsp;</td>
	  <td><span class="fsection"><spring:message code="jsp.lovEditForm.header"/></span></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>

	<spring:bind path="listOfValuesDTO.listOfValues.name">
        <tr>
            <TD align="right">* <spring:message code="label.name"/>&nbsp;</TD>
            <TD align="left"><input type="text" class="fnormal" name="${status.expression}" value="${status.value}" size="40" <c:if test='${status.value != null && status.value != "" && listOfValuesDTO.editMode}'>readonly="true"</c:if>/></TD>
        </tr>
		<c:if test="${status.error}">
			<tr>
				<td>&nbsp;</td>
				<td><span class="ferror">${status.errorMessage}</span></td>
			</tr>
		</c:if>
    </spring:bind>
    <spring:bind path="listOfValuesDTO.listOfValues.label">
        <TR>
			<TD align="right">* <spring:message code="label.label"/>&nbsp;</TD>
            <TD align="left"><input type="text" class="fnormal" name="${status.expression}" value="${status.value}" size="40"/></TD>
        </TR>
		<c:if test="${status.error}">
			<tr>
				<td>&nbsp;</td>
				<td><span class="ferror">${status.errorMessage}</span></td>
			</tr>
		</c:if>
    </spring:bind>
    <spring:bind path="listOfValuesDTO.listOfValues.description">
		<tr>
			<td align="right" valign="top"><spring:message code="label.description"/>&nbsp;</td>
			<td align="left"><textarea name="${status.expression}" rows="5" cols="28" class="fnormal"><c:out value='${status.value}'/></textarea></td>
		</tr>
		<c:if test="${status.error}">
		<tr>
			<td>&nbsp;</td>
			<td><span class="ferror">${status.errorMessage}</span></td>
		</tr>
		</c:if>
    </spring:bind>
		<tr>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>
				
				<c:if test='${masterFlow == "reportUnit"}'>
				 <input type="submit" class="fnormal" name="_eventId_cancel" value="<spring:message code="button.cancel"/>" />&nbsp;
				 <input type="submit" class="fnormal" name="_eventId_back" value="<spring:message code="button.back"/>" />&nbsp;
	            </c:if>
	            <c:if test='${masterFlow != "reportUnit"}'>
	             <input type="button" class="fnormal" name="_eventId_cancel" value="<spring:message code="button.cancel"/>" OnClick='javascript:window.location.href="flow.html?_flowId=repositoryExplorerFlow&showFolder=<%=request.getParameter("ParentFolderUri")%>"'/>&nbsp;
	             <input type="button" class="fnormal" name="_eventId_back" value="<spring:message code="button.back"/>" OnClick='javascript:window.location.href="flow.html?_flowId=repositoryExplorerFlow&showFolder=<%=request.getParameter("ParentFolderUri")%>"' />&nbsp;
	            </c:if>
	            <input type="submit" class="fnormal" name="_eventId_next" value="<spring:message code="button.next"/>"/>
			</td>
		</tr>
</table>

</td>
</tr>
</table>
</form>


</body>
</HTML>
