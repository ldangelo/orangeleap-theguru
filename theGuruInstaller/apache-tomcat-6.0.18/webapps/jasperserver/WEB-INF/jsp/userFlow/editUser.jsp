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
<%@ taglib uri="http://acegisecurity.org/authz" prefix="authz"%>

<html>
<head>
  <title><spring:message code="jsp.editUser.title"/></title>
  <meta name="pageHeading" content="<spring:message code="jsp.editUser.title"/>">
</head>

<body>

<table border="0" cellpadding="0" cellspacing="0" width="100%" style="padding-top:20px;">
  <tr>
    <td rowspan=2 align="left" valign="top" width="105">

<c:if test='${user.user.username!=null}'>
<authz:authorize ifAnyGranted="ROLE_ADMINISTRATOR">
  <input type="submit" <c:if test="${!user.user.enabled or user.user.externallyDefined}"> disabled</c:if> name="switchUser" value='<spring:message code="jsp.editUser.loginAs"/>'
         onclick='document.location="j_acegi_switch_user?j_username=${user.user.username}"'/>
</authz:authorize>
</c:if>
    </td>
    <td align="center" style="padding-bottom:10px">
    <span class="fsection"><c:if test="${role.role.externallyDefined}"><spring:message code="jsp.editUser.externallyDefined"/>&nbsp;</c:if><spring:message code="label.user"/>: ${user.user.fullName}</span></td>
    <td rowspan=2 width="105">&nbsp;</td>
  </tr>

  <tr><td>
<form name="fmCreEdUsr" action="" method="post">
<table class="formtable" align="center" border="0" cellpadding="1" cellspacing="0" style="padding:5px">
<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>

<spring:bind path="user.user.username">
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td align="right">* <spring:message code="jsp.editUser.userName"/>&nbsp;</td>
    <td>

    <c:if test="${!user.user.externallyDefined}">
    <input type="text" name="${status.expression}" class="fnormal" value="${status.value}" size="30" maxlength="100" <c:if test="${user.editMode}">readonly</c:if>/>
    </c:if>
    <c:if test="${user.user.externallyDefined}">
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

<spring:bind path="user.user.fullName">
  <tr valign="middle">
    <td align="right">* <spring:message code="jsp.editUser.fullName"/>&nbsp;</td>
    <td><input type="text" name="${status.expression}" class="fnormal" value="${status.value}" size="30" maxlength="100"/></td>
  </tr>
  <c:if test="${status.error}">
  <tr>
    <td>&nbsp;</td>
    <td class="ferror"><c:out value="${status.errorMessage}"/></td>
  </tr>
  </c:if>
</spring:bind>

<c:if test="${!user.user.externallyDefined}">

<%--  if we have an externally defined user, you cannot set the password.
      The user is enabled/disabled externally too.
--%>
<spring:bind path="user.user.password">
  <tr>
    <td align="right">* <spring:message code="jsp.editUser.password"/>&nbsp;</td>
    <td><input type="password" name="${status.expression}" class="fnormal" value="${status.value}" size="30" maxlength="100"/></td>
  </tr>
  <c:if test="${status.error}">
  <tr>
    <td>&nbsp;</td>
    <td class="ferror"><c:out value="${status.errorMessage}"/></td>
  </tr>
  </c:if>
</spring:bind>

<spring:bind path="user.confirmedPassword">
  <tr>
    <td align="right">* <spring:message code="jsp.editUser.confirmPassword"/>&nbsp;</td>
    <td><input type="password" name="${status.expression}" class="fnormal" value="${status.value}" size="30" maxlength="100"/></td>
  </tr>
  <c:if test="${status.error}">
  <tr>
    <td>&nbsp;</td>
    <td class="ferror"><c:out value="${status.errorMessage}"/></td>
  </tr>
  </c:if>
</spring:bind>
</c:if>

<spring:bind path="user.user.emailAddress">
  <tr>
    <td align="right"><spring:message code="jsp.editUser.email"/>&nbsp;</td>
    <td><input type="text" name="${status.expression}" class="fnormal" value="${status.value}" size="30" maxlength="100"/></td>
  </tr>
  <c:if test="${status.error}">
  <tr>
    <td>&nbsp;</td>
    <td class="ferror"><c:out value="${status.errorMessage}"/></td>
  </tr>
  </c:if>
</spring:bind>

<spring:bind path="user.user.enabled">
  <c:if test="${user.user.enabled or user.user.externallyDefined}">
    <c:set var="checked" value="checked"/>
  </c:if>
  <tr>
    <td align="right"><spring:message code="jsp.editUser.enabled"/>&nbsp;</td>
	<td>
		<input name="_${status.expression}" type="hidden"/>
		<input type="checkbox" name="${status.expression}" ${checked}
			<c:if test="${user.user.externallyDefined}">disabled="disabled"</c:if>
		/>
	</td>
  </tr>
  <c:remove var="checked"/>
</spring:bind>

  <!-- profile attributes -->
  
  <c:forEach items="${user.user.attributes}" var="pattr">
    <tr height="20">	     
     <td align="right">${pattr.attrName}&nbsp;</td>
     <td>${pattr.attrValue}</td>
    </tr>
  </c:forEach>

  <!-- end profile attributes -->

  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>

  <tr>
    <td colspan="2" align="center">
      <table border="0" cellpadding="2" cellspacing="0">
        <tr>
          <td><spring:message code="jsp.editUser.availableRoles"/></td>
          <td>&nbsp;</td>
          <td><spring:message code="jsp.editUser.assignedRoles"/></td>
        </tr>
        <tr>
          <td>
		  <spring:bind path="user.selectedAvailableRoles">
			<select name="${status.expression}" size="5" style="width:160" multiple class="fnormal">
				<c:forEach items="${user.availableRoles}" var="role">
              		<option value="${role.roleName}"><c:out value="${role.roleName}"/></option>
				</c:forEach>
            </select>
		  </spring:bind>
		  </td>
          <td valign="middle" align="center"><input type="submit" name="_eventId_add" class="fnormal" value=">" style="width:30"/><br><br><input type="submit" name="_eventId_remove" class="fnormal" value="<" style="width:30"/></td>
          <td>
		  <spring:bind path="user.selectedAssignedRoles">
			<select name="${status.expression}" size="5" style="width:160" multiple class="fnormal">
				<c:forEach items="${user.assignedRoles}" var="role">
              		<option value="${role.roleName}"><c:out value="${role.roleName}"/></option>
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


 
