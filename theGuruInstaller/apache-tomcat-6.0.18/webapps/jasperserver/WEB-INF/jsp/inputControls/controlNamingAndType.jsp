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
<meta name="pageHeading" content="<spring:message code="jsp.controlNamingAndType.pageHeading"/>"/>
<title><spring:message code="jsp.controlNamingAndType.title"/></title>
<script>
function jumpTo(pageTo){
    document.forms[0].jumpToPage.value=pageTo;
    document.forms[0].jumpButton.click();
}
</script>
</head>
<body bgcolor="#CCCCCC">

<FORM name="fmCRContNam" action="" method="post">
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
	  <td><span class="fsection"><c:if test='${control.subflowMode}'><spring:message code="jsp.reportWizard"/> - </c:if><spring:message code="jsp.inputControl"/></span></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>


	<spring:bind path="control.inputControl.name">
		<tr>
			<td align="right">* <spring:message code="label.parameter.name"/>&nbsp;</td>
			<td align="left">
				<input maxlength="100" name="${status.expression}" type="text" class="fnormal" size="40" value="${status.value}" <c:if test='${control.editMode}'>readonly="true"</c:if>/>
				<c:if test="${status.error}"><BR><span class="ferror">${status.errorMessage}</span></c:if>
			</td>
		</tr>
    </spring:bind>

    <spring:bind path="control.inputControl.label">
		<tr>
			<td align="right">* <spring:message code="label.prompt.text"/>&nbsp;</td>
			<td align="left">
				<input maxlength="100" name="${status.expression}" type="text" class="fnormal" size="40" value="${status.value}"/>
				<c:if test="${status.error}"><BR><span class="ferror">${status.errorMessage}</span></c:if>
			</td>
		</tr>
    </spring:bind>

    <spring:bind path="control.inputControl.description">
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

    <spring:bind path="control.inputControl.type">
		<tr>
			<td align="right"><spring:message code="label.type"/>&nbsp;</td>
			<td align="left">
				<select name="${status.expression}" size="1" class="fnormal">
					<c:forEach items='${control.supportedControlTypes}' var='type'>
						<option value="${type.key}" <c:if test='${type.key==status.value}'>selected="true"</c:if>><spring:message code="${type.value}"/></option>
					</c:forEach>
				</select>
				<c:if test="${status.error}"><br/><span class="ferror">${status.errorMessage}</span></c:if>
			</td>
		</tr>
    </spring:bind>

	<spring:bind path="control.inputControl.mandatory">
		<tr>
			<td align="right"><spring:message code="jsp.controlNamingAndType.mandatory"/>&nbsp;</td>
			<td align="left">
				<input name="_${status.expression}" type="hidden"/>
				<input name="${status.expression}" type="checkbox" <c:if test='${status.value}'>checked="true"</c:if> size="30">
			</td>
		</tr>
    </spring:bind>

    <spring:bind path="control.inputControl.readOnly">
		<tr>
			<td align="right"><spring:message code="jsp.controlNamingAndType.readonly"/>&nbsp;</td>
			<td align="left">
				<input name="_${status.expression}" type="hidden"/>
				<input name="${status.expression}" type="checkbox" <c:if test='${status.value}'>checked="true"</c:if> size="30"/>
			</td>
		</tr>
    </spring:bind>

	<spring:bind path="control.inputControl.visible">
		<tr>
			<td align="right"><spring:message code="jsp.controlNamingAndType.visible"/>&nbsp;</td>
			<td align="left">
				<input name="_${status.expression}" type="hidden"/>
				<input name="${status.expression}" type="checkbox" <c:if test='${status.value}'>checked="true"</c:if> size="30"/>
			</td>
		</tr>
	</spring:bind>

    <tr><td colspan="2">&nbsp;</td></tr>

	<tr>
		<td>&nbsp;</td>
		<td align="left">
		    <c:if test='${masterFlow == "reportUnit"}'>
			 <input type="submit" class="fnormal" name="_eventId_Cancel" value="<spring:message code="button.cancel"/>" />&nbsp;
			 <input type="submit" class="fnormal" name="_eventId_Back" value="<spring:message code="button.back"/>">&nbsp;		    
		    </c:if>
		    <c:if test='${masterFlow != "reportUnit"}'>
			 <input type="button" class="fnormal" name="_eventId_Cancel" value="<spring:message code="button.cancel"/>" OnClick='javascript:window.location.href="flow.html?_flowId=repositoryExplorerFlow&showFolder=<%=request.getParameter("ParentFolderUri")%>"'/>&nbsp;
			 <input type="button" class="fnormal" name="_eventId_Back" value="<spring:message code="button.back"/>" OnClick='javascript:window.location.href="flow.html?_flowId=repositoryExplorerFlow&showFolder=<%=request.getParameter("ParentFolderUri")%>"'">&nbsp;		    
		    </c:if>
			<input type="submit" class="fnormal" name="_eventId_Next" value="<spring:message code="button.next"/>">
		</td>
	</tr>
</table>

    <input type="hidden" name="jumpToPage">
    <input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
    <input type="submit" class="fnormal" style="visibility:hidden;" value="" name="_eventId_Jump" id="jumpButton">

</td>
</tr>
</table>
</FORM>
</body>
</html>
