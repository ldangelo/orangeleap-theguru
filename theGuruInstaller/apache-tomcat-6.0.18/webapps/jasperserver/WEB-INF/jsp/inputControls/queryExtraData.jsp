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

<html>
<head>
  <title><spring:message code="jsp.queryExtraData.title"/></title>
  <meta name="pageHeading" content="<spring:message code="jsp.queryExtraData.pageHeading"/>"/>
</head>

<body>

<form name="fmQuery" method="post" action="">
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

<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
<table border="0" cellpadding="1" cellspacing="0" align="center">
  <tr>
    <td>&nbsp;</td>
    <td><span class="fsection"><spring:message code="jsp.queryExtraData.title"/></span></td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
<spring:bind path="control.inputControl.queryValueColumn">
  <tr>
    <td align="right">* <spring:message code="jsp.queryExtraData.valueColumn"/>&nbsp;</td>
    <td>
		<input type="text" name="${status.expression}" value="${status.value}" size="40" class="fnormal"/>
		<c:if test="${status.error}"><BR><span class="ferror">${status.errorMessage}</span></c:if>
	</td>
  </tr>
</spring:bind>

</table>

<table border="0" cellpadding="1" cellspacing="0" align="center">
	<tr bgcolor="#c2c4b6" class="fheader">
		<td><b>&nbsp;<spring:message code="jsp.queryExtraData.visibleColumns"/></b></td>
		<td><input type="submit" class="fnormal" name="_eventId_removeItem" value="-"/></td>
	</tr>

	<c:forEach items="${control.inputControl.queryVisibleColumnsAsList}" var="column">
		<TR>
			<TD><c:out value="${column}"/></td>
			<TD><input type="checkbox" name="itemToDelete" value="${column}"/></td>
		</tr>
	</c:forEach>
	<tr>
		<spring:bind path="control.newVisibleColumn">
			<td>
				<input type="text" class="fnormal" name="${status.expression}" value="${status.value}"/>
			</td>
			<c:if test="${status.error!=null}"><br/><span class="ferror">${status.errorMessage}</span></c:if>
		</spring:bind>
		<td><input type="submit" class="fnormal" name="_eventId_addItem" value="+"></td>
	</tr>

  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">
      <input type="submit" name="_eventId_cancel" value="<spring:message code="button.cancel"/>" class="fnormal"/>
	  <input type="submit" name="_eventId_back" value="<spring:message code="button.back"/>" class="fnormal"/>
	  <input type="submit" name="_eventId_save" value="<spring:message code="button.save"/>" class="fnormal"/>&nbsp;
    </td>
  </tr>
</table>

    </td>
  </tr>
</table>
</form>

</body>

</html>
