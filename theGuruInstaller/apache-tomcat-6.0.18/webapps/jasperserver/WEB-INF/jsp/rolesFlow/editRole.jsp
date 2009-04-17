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
  <title><spring:message code="jsp.editRole.title"/></title>
  <meta name="pageHeading" content="CREATE / EDIT ROLE">
</head>

<body>

<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr>
    <td>

<form name="fmCreEdUsr" action="" method="post">
<table border="0" cellpadding="1" cellspacing="0" align="center">
<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>

<spring:bind path="role.role.roleName">
  <tr>
    <td>&nbsp;</td>
    <td><span class="fsection"><c:if test="${role.role.externallyDefined}"><spring:message code="jsp.editRole.externallyDefined"/>&nbsp;</c:if><spring:message code="jsp.editRole.role"/></span></td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">* <spring:message code="jsp.editRole.roleName"/>&nbsp;</td>
    <td>

    <c:if test="${!role.role.externallyDefined}">
    <input type="text" name="${status.expression}" class="fnormal" value="${status.value}" size="30" maxlength="100" <c:if test="${role.editMode}">readonly</c:if>/>
    </c:if>
    <c:if test="${role.role.externallyDefined}">
        <span class="fnormal"><c:out value="${status.value}"/></span>
    <input type="hidden" name="${status.expression}" value="${status.value}"/>
    </c:if>
    </td>
  </tr>
  <c:if test="${status.error}">
  <tr>
    <td>&nbsp;</td>
    <td class="ferror"><c:out value="${status.errorMessage}"/></td>
  </tr>
  </c:if>
</spring:bind>

  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>

  <tr>
    <td colspan="2" align="center">
      <table border="0" cellpadding="2" cellspacing="0">
        <tr>
          <td><spring:message code="jsp.editRole.availableUsers"/></td>
          <td>&nbsp;</td>
          <td><spring:message code="jsp.editRole.usersInRole"/></td>
        </tr>
        <tr>
          <td>
		  <spring:bind path="role.selectedUsersNotInRole">
			<select name="${status.expression}" size="5" style="width:160" multiple class="fnormal">
				<c:forEach items="${role.usersNotInRole}" var="user">
              		<option value="${user.username}"><c:out value="${user.username}"/></option>
				</c:forEach>
            </select>
		  </spring:bind>
		  </td>
          <td valign="middle" align="center">
            <input type="submit" name="_eventId_add" class="fnormal" value=">" style="width:30"/>
            <br>
            <br>
            <input type="submit" name="_eventId_remove" class="fnormal" value="<" style="width:30"/>
          </td>
          <td>
		  <spring:bind path="role.selectedUsersInRole">
			<select name="${status.expression}" size="5" style="width:160" multiple class="fnormal">
				<c:forEach items="${role.usersInRole}" var="user">
              		<option value="${user.username}"><c:out value="${user.username}"/></option>
				</c:forEach>
            </select>
		  </spring:bind>
		  </td>
        </tr>
      </table>
    </td>
  </tr>

  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>

  <tr>
    <td colspan="2" align="center">
      <input type="submit" name="_eventId_save" class="fnormal" value="<spring:message code="button.save"/>"/>&nbsp;
      <input type="submit" name="_eventId_cancel" class="fnormal" value="<spring:message code="button.cancel"/>"/>
    </td>
  </tr>
</table>
</form>

    </td>
  </tr>
</table>

</body>

</html>

 
