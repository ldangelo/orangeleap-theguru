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
<%@ taglib uri="/WEB-INF/jasperserver.tld" prefix="js" %>
<%@ taglib uri="/spring" prefix="spring"%>
<%@ page errorPage="/WEB-INF/jsp/JSErrorPage.jsp" %>

<html>
<head>
  <script language="JavaScript" src="${pageContext.request.contextPath}/scripts/checkbox-utils.js"></script>
  <script language="JavaScript">
  	function removeRepositoryUsers() {
  		if (checkboxListAnySelected('users')) {
			if (confirm('<spring:message code="jsp.userList.confirmRemove" javaScriptEscape="true"/>')) {
				document.frm.remove.click();
			}
  		} else {
  			alert('<spring:message code="jsp.userList.nothing.to.remove" javaScriptEscape="true"/>');
  		}
  	}
  </script>
</head>

<body>

<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr>
    <td>
      <span class="fsection"><spring:message code="jsp.userList.header"/></span>
      <br/>
      <br/>

<form name="frm" action="" method="post">
<!-- should be populated only if there are search results -->
<!-- presently tested against all users in database -->
<table border="0" width="100%" cellpadding="0" cellspacing="0">
<!-- API CALL START -->
<c:if test="${!empty users}">
  <tr class="fheader" bgcolor="#c2c4b6">
	  <td class="paddedcell" width="20%"><spring:message code="jsp.userList.userName"/></td>
	  <td class="paddedcell"><spring:message code="jsp.userList.fullName"/></td>
	  <td class="paddedcell" width="23%"><spring:message code="jsp.userList.email"/></td>
	  <td class="paddedcell" width="15%" align="center"><spring:message code="jsp.userList.enabled"/></td>
	  <td class="paddedcell" width="15%" align="center"><spring:message code="jsp.userList.external"/></td>
      <td class="paddedcell" width="1">
		<input type="checkbox" name="selectAll" class="fnormal" 
			onclick="checkboxListAllClicked('users', this)"
			title="<spring:message code="list.checkbox.select.all.hint"/>"/>
      </td>
  </tr>
<js:paginator items="${users}" page="${currentPage}">
	<script language="JavaScript">
	  checkboxListInit('users', 'frm', 'selectAll', 'selectedUsers', <%= ((java.util.Collection) pageContext.findAttribute("paginatedItems")).size() %>, 0);	  
	</script>
	
  <c:forEach items="${paginatedItems}" var="user" varStatus="itStatus">
  <tr <c:if test="${itStatus.count % 2 == 0}">class="list_alternate"</c:if>>
    <td class="paddedcell"><a href="javascript:frm.userName.value='<c:out value="${user.username}"/>';frm.edit.click();"><c:out value="${user.username}"/></a></td>
	<td class="paddedcell"><c:out value="${user.fullName}"/></td>
	<td class="paddedcell"><c:out value="${user.emailAddress}"/></td>
	<td class="paddedcell" align="center">
		<c:if test="${user.enabled}"><spring:message code="jsp.userList.yes"/></c:if>
		<c:if test="${!user.enabled}"><spring:message code="jsp.userList.no"/></c:if>
	</td>
	<td class="paddedcell" align="center">
		<c:if test="${user.externallyDefined}"><spring:message code="jsp.userList.yes"/></c:if>
		<c:if test="${!user.externallyDefined}"><spring:message code="jsp.userList.no"/></c:if>
    </td>
    <td class="paddedcell" align="center"><input type="checkbox" name="selectedUsers" value="${user.username}" class="fnormal" onclick="checkboxListCheckboxClicked('users', this)"/></td>
  </tr>
  </c:forEach>
	<tr>
		<td colspan="6">
			<js:paginatorLinks/>
		</td>
	</tr>
</js:paginator>
	<tr>
	  <td colspan="6">&nbsp;</td>
	</tr>
	  <tr>
	    <td colspan="2"><input type="submit" name="_eventId_add" value="<spring:message code="jsp.userList.button.createUser"/>" class="fnormal"></td>
	    <td colspan="4" align="right"><input type="button" value="<spring:message code="button.remove"/>" class="fnormal" onclick="removeRepositoryUsers()"></td>
		<input type="submit" name="_eventId_remove" id="remove"  style="visibility:hidden;"/>
	  </tr>
</c:if>
<!-- API CALL END -->
</table>
<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
<input type="submit" class="fnormal" name="_eventId_edit" id="edit" value="edit" style="visibility:hidden;"/>
<input type="hidden" name="userName" id="userName"/>
</form>
</td>
</tr>
</table>

</body>
</html>
