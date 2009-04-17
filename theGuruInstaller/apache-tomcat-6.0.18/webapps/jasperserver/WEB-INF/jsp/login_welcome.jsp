<%--
* Copyright (C) 2005 - 2007 JasperSoft Corporation. All rights reserved.
* http://www.jaspersoft.com.
* Licensed under commercial JasperSoft Subscription License Agreement
--%>

<%@ page import="
        com.jaspersoft.jasperserver.war.dto.StringOption,
        com.jaspersoft.jasperserver.war.common.UserLocale
        " %>

<%@ taglib prefix="spring" uri="/spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
  <META name="decorator" content="orangeLeap"/>
  <title><spring:message code='jsp.Login.title'/></title>
  <link href="${pageContext.request.contextPath}/stylesheets/stylesheet.css" rel="stylesheet" type="text/css">
  <link href="${pageContext.request.contextPath}/stylesheets/login.css" rel="stylesheet" type="text/css">
 <link href="${pageContext.request.contextPath}/stylesheets/dialog.css" rel="stylesheet" type="text/css">
  <meta name="noMenu" content="true">
  <meta name="pageHeading" content="<spring:message code='jsp.Login.pageHeading'/>"/>
 <script language=JavaScript src="${pageContext.request.contextPath}/scripts/jasperserver.js"></script>
 <script language=JavaScript src="${pageContext.request.contextPath}/scripts/common.js"></script>

<% response.setHeader("LoginRequested","true");
   session.removeAttribute("js_uname");
   session.removeAttribute("js_upassword");
%>

<script src="scripts/common.js"></script>

</head>

<body>
<div class="loginPane">
	<div class="loginContent">
		<form name="fmLogin" method="POST" action="j_acegi_security_check" >
	    <img src="images/orangeleap-logo-tag.png" />

	    <h1 class="loginHeader">Please sign in.</h1>

    	<c:if test="${not empty param.login_error}">
    		<p style="color:red;padding:0;margin:0;"><c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}"/></p>
    	</c:if>
        <c:if test="${paramValues.error != null}">
        <c:choose>
            <c:when test="${exception!=null}">
				<p style="color:red;padding:0;margin:0;"><c:out value="${exception}"/></p>
            </c:when>
            <c:otherwise>
    				<p style="color:red;padding:0;margin:0;"><spring:message code='jsp.loginError.invalidCredentials1'/><br/><spring:message code='jsp.loginError.invalidCredentials2'/></p>                   
            </c:otherwise>
        </c:choose>
        </c:if>
        
		<table class="loginInfo">
			<tr>
				<td style="text-align:right"><label for="j_username">Username:</label></td>
				<td><input size="30" class="loginField" type="text" name="j_username" id="j_username"  <c:if test="${not empty param.login_error}">value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}"</c:if> /></td>
    		</tr>
			<tr>
				<td style="text-align:right"><label for="j_password">Password:</label></td>
				<td><input size="30" class="loginField" type="password" name="j_password" id="j_password" /></td>
    		</tr>
    		<tr>
	    		<td class="loginButton" align="center" colspan="2">
	    		<input class="loginButton" name="btnsubmit" id="btnsubmit" type="submit" value="Sign In" />
	    		</td>
            </tr>
            <%--
            <tr>
	    		<td>&nbsp;</td>
	    		<td><a href="#">Forgot your password?</a></td>
            </tr>
            --%>
   		</table>


	</div>
</div>
</form>

<script language="Javascript">
    document.fmLogin.j_username.focus();
</script>

</body>

</html>
