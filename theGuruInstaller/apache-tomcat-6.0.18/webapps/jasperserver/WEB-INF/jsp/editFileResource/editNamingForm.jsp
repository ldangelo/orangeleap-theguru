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
<title><spring:message code="jsp.editNamingForm.title"/></title>
<meta name="pageHeading" content="<spring:message code="jsp.editNamingForm.pageHeading"/>"/>
<script>
function jumpTo(pageTo){
    document.forms[0].jumpToPage.value=pageTo;
    document.forms[0].jumpButton.click();
}
</script>
</head>
<body bgcolor="#CCCCCC">
<FORM name="aqRsrRsrNm" action="" method="post">
    <table width="100%" border="0" align="center">
        
        <tr>
            <td width="40%">&nbsp;</td>
            <td width="40%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
        </tr>

        <tr><td colspan="3">&nbsp;</td></tr>
        <tr>
        <td colspan="3"><div align="center"><strong><spring:message code="jsp.editNamingForm.message"/>:</strong></div></td>
        </tr>
        <tr>
        <td><p><br/>
          </p>
          <p>&nbsp; </p></td>
        <td colspan="2">&nbsp;</td>
        </tr>
        <tr><spring:bind path="resource.name">
        <td><div align="right"><strong><spring:message code="label.name"/>:</strong></div></td>
        <td colspan="2"><input name="${status.expression}" type="text" class="fnormal" value="${status.value}" size="20" <c:if test="${resource.editMode}">disabled</c:if>/><c:if test="${status.error}"><BR/><span class="ferror">${status.errorMessage}</span></c:if></td>
		</spring:bind>
		</tr>
        <tr><spring:bind path="resource.label">
        <td><div align="right"><strong><spring:message code="label.label"/>:</strong></div></td>
        <td colspan="2"><input name="${status.expression}" type="text" class="fnormal" value="${status.value}" size="20"><c:if test="${status.error}"><BR/><span class="ferror">${status.errorMessage}</span></c:if></td></spring:bind>
        </tr>
        <tr><spring:bind path="resource.description">
			<td align="right" valign="top"><spring:message code="label.description"/>&nbsp;</td>
			<td align="left"><textarea name="${status.expression}" rows="5" cols="28" class="fnormal"><c:out value='${status.value}'/></textarea></td>
		</tr>
		<c:if test="${status.error}">
		<tr>
			<td>&nbsp;</td>
			<td><span class="ferror">${status.errorMessage}</span></td>
		</tr>
		</c:if>
        <tr><spring:bind path="resource.type">
        <td><div align="right"><strong><spring:message code="label.type"/>:</strong></div></td>
        <td colspan="2">
            <select name="${status.expression}" size="1">
            <c:forEach items='${resource.types}' var='type'>
                <option value="${type}" <c:if test='${status.value==type}'>selected="true"</c:if>>${type}</option>
            </c:forEach>
            </select></td></spring:bind>
        </tr>
        <tr><td colspan="3">&nbsp;</td></tr>
        <tr>
        <td colspan="3"><div align="center"><strong><spring:message code="jsp.editNamingForm.message2"/></strong></div></td>
        </tr>
        <tr><td colspan="3">&nbsp;</td></tr>
        <tr>
        <td colspan="3" align="center"><input type="submit" class="fnormal" name="_eventId_Cancel" value="<spring:message code="button.cancel"/>"/>&nbsp;
        <input type="submit" class="fnormal" name="_eventId_Back" value="<spring:message code="button.back"/>">&nbsp;
        <input type="submit" class="fnormal" name="_eventId_Save" value="<spring:message code="button.save"/>"></td>
        </tr>
    </table>
    <input type="submit" class="fnormal" style="visibility:hidden;" value="" name="_eventId_Jump" id="jumpButton">
    <input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
</FORM>
</body>
</html>
