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

<%@ page import="
		com.jaspersoft.jasperserver.war.dto.StringOption,
		com.jaspersoft.jasperserver.war.common.UserLocale
		" %>

<%@ taglib prefix="spring" uri="/spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
  <title><spring:message code='jsp.Login.title'/></title>
  <meta name="noMenu" content="true">
  <meta name="pageHeading" content="<spring:message code='jsp.Login.pageHeading'/>"/>

<% response.setHeader("LoginRequested","true");
   session.removeAttribute("js_uname");
   session.removeAttribute("js_upassword");
%>

</head>

<body>
<!-- $Id:$ -->
<table cellpadding="20" cellspacing="0" width="100%" border="0">
  <tr>
    <td align="center" valign="middle">
			<br><br><br><br><br><br><br>
			<form name="fmLogin" method="POST" action="j_acegi_security_check" onSubmit="return (validatePassword());">
				<table border="0" cellpadding="1" cellspacing="0" style="width:340px">
					<tbody>
						<tr>
							<td><img src="images/pixel.gif" width="100" height="1"></td>
							<td><span class="fsection"><spring:message code='jsp.Login.section'/></span></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td style="padding-right:5px;"><img src="images/pixel.gif" width="220" height="1"></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align="right" nowrap="true">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code='jsp.Login.username'/>:&nbsp;</td>
							<td><input type="text" name="j_username" value="" size="20" maxlength="100" class="control"></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align="right" nowrap="true"><spring:message code='jsp.Login.password'/>:&nbsp;</td>
							<td><input type="password" name="j_password" value="" size="20" maxlength="100" class="control"></td>
							<td>&nbsp;</td>
						</tr>

						<c:if test="${paramValues.error != null}">
						<c:choose>
							<c:when test="${exception!=null}">
							  <tr><td colspan="3">${exception}</td></tr>
							</c:when>
							<c:otherwise>
							  	<tr>
									<td align="center" class="ferror" colspan="3"><spring:message code='jsp.loginError.invalidCredentials1'/><br/><spring:message code='jsp.loginError.invalidCredentials2'/>
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
						</c:if>
						
						<% if ("true".equals(request.getParameter("showPasswordChange"))) { %>
                         <tr>
                          <td colspan="3" align="center" class="ferror" ><spring:message code='jsp.loginError.expiredPassword1'/><br/><spring:message code='jsp.loginError.expiredPassword2'/>
                          </td>
                         </tr>                       
                        <% } %>

						<tr>
							<td>&nbsp;</td>
							<td align="left" style="padding-top:5px;"><a id="showHideLocaleLink" href="#" onclick="toggleLocaleDetails();return false;" class="nonbold"><spring:message code="jsp.Login.link.showLocale"/></a></td>
							<td>&nbsp;</td>
						</tr>
					</tbody>

					<!-- locale/timezone section -->
					<tbody id="localeDetails" style="display:none">
						<tr>
							<td align="right" valign="middle" style="padding-top:5px;" nowrap="true"><spring:message code='jsp.Login.locale'/>:&nbsp;</td>
							<td colspan="2" style="text-align:left;padding-right:5px;padding-top:5px;">
								<select name="userLocale" class="control" style="width:220px">
									<c:forEach items="${userLocales}" var="locale">
										<option value="${locale.code}" <c:if test="${preferredLocale == locale.code}">selected</c:if>>
											<spring:message code="locale.option"
												arguments='<%= new String[]{((UserLocale) pageContext.getAttribute("locale")).getCode(), ((UserLocale) pageContext.getAttribute("locale")).getDescription()} %>'/>
										</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<td align="right" valign="middle" style="padding-top:5px;" nowrap="true"><spring:message code='jsp.Login.timezone'/>:&nbsp;</td>
							<td colspan="2" style="text-align:left;padding-right:5px;padding-top:4px;">
								<select name="userTimezone" class="control" style="width:220px">
									<c:forEach items="${userTimezones}" var="timezone">
										<option value="${timezone.code}" <c:if test="${preferredTimezone == timezone.code}">selected</c:if>>
											<spring:message code="timezone.option"
												arguments='<%= new String[]{((StringOption) pageContext.getAttribute("timezone")).getCode(), ((StringOption) pageContext.getAttribute("timezone")).getDescription()} %>'/>
										</option>
									</c:forEach>
								</select>
							</td>
						</tr>
					</tbody>

                    <c:if test="${allowUserPasswordChange eq 'true'}">
					<tbody>
						<tr>
							<td>&nbsp;</td>
							<td align="left" style="padding-top:5px;"><a id="showHideChangePasswordLink" href="#" onclick="togglePasswordDetails();return false;" class="nonbold"><spring:message code="jsp.Login.link.changePassword"/></a></td>
							<td>&nbsp;</td>
						</tr>
					</tbody>
					<tbody id="passwordDetails" style="display:none">
					    <tr>&nbsp;</tr>
					    <tr>&nbsp;</tr>
					    <tr>&nbsp;</tr>
						<tr>
							<td align="right" nowrap="true"><spring:message code='jsp.Login.link.newPassaowrd'/>:&nbsp;</td>
							<td><input type="text" name="j_newpassword1" id="j_newpassword1" value="" size="20" maxlength="100" class="control"></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align="right" nowrap="true"><spring:message code='jsp.Login.link.repeatNewPassword'/>:&nbsp;</td>
							<td><input type="text" name="j_newpassword2" id="j_newpassword2"  value="" size="20" maxlength="100" class="control"></td>
							<td>&nbsp;</td>
						</tr>
					</tbody>
					</c:if>


					<tbody>
						<tr>
						 <td colspan="3" align="center" style="padding-top:10px;padding-right:15px;" nowrap="true">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="btnsubmit" value="<spring:message code='jsp.Login.button.login'/>" class="wizardbutton">&nbsp;&nbsp;&nbsp;<input type="reset" name="btnreset" value="<spring:message code='jsp.Login.button.reset'/>" class="wizardbutton"></td>
						</tr>
					</tbody>

				</table>
				<input type="hidden" name="passwordExpiredDays" value="${passwordExpirationInDays}" />
			</form>
		</td>
	</tr>
</table>



<script language="Javascript">
    document.fmLogin.j_username.focus();
</script>

<script>
	var localeShowing=false;
	var passwordShowing=false;
	var localeDetails = document.getElementById("localeDetails");
	var passwordDetails = document.getElementById("passwordDetails");
	var showHideLocaleLink = document.getElementById("showHideLocaleLink");
	var showHideChangePasswordLink = document.getElementById("showHideChangePasswordLink");

	var tBodyDisplay = "block";
	if (navigator.appName=="Netscape")
		tBodyDisplay = "table-row-group";

	function toggleLocaleDetails() {
		if(localeShowing) {
			localeShowing = false;
			localeDetails.style.display="none";
			updateLocaleLink("<spring:message code='jsp.Login.link.showLocale' javaScriptEscape='true'/>");
		} else {
			localeShowing = true;
			localeDetails.style.display=tBodyDisplay;
			updateLocaleLink("<spring:message code='jsp.Login.link.hideLocale' javaScriptEscape='true'/>");
			document.fmLogin.userLocale.focus();
		}
	}

	function togglePasswordDetails() {

		var p1 = document.getElementById("j_newpassword1");
		var p2 = document.getElementById("j_newpassword2");

		if(passwordShowing) {
			passwordShowing = false;
			passwordDetails.style.display="none";
			var textField1 = createPField("text", "j_newpassword1");
			var textField2 = createPField("text", "j_newpassword2");
			p1.parentNode.replaceChild(textField1, p1);
			p2.parentNode.replaceChild(textField2, p2);
			updatePasswordLink("<spring:message code='jsp.Login.link.changePassword' javaScriptEscape='true'/>");
		} else {
			passwordShowing = true;
			var passwordField1 = createPField("password", "j_newpassword1");
			var passwordField2 = createPField("password", "j_newpassword2");
			p1.parentNode.replaceChild(passwordField1, p1);
			p2.parentNode.replaceChild(passwordField2, p2);
			passwordDetails.style.display=tBodyDisplay;
			updatePasswordLink("<spring:message code='jsp.Login.link.cancelPassword' javaScriptEscape='true'/>");
			document.fmLogin.j_newpassword1.focus();
		}
	}

	function updateLocaleLink(newText) {
			showHideLocaleLink.innerText?showHideLocaleLink.innerText=newText:showHideLocaleLink.innerHTML=newText;
	}

	function updatePasswordLink(newText) {
			showHideChangePasswordLink.innerText?showHideChangePasswordLink.innerText=newText:showHideChangePasswordLink.innerHTML=newText;
	}

        function validatePassword() {
              var p1 = document.getElementById("j_newpassword1");
              var p2 = document.getElementById("j_newpassword2");

              if (p1 == null) {
                 return true;
              }

              if (passwordDetails.style.display == tBodyDisplay) {

                  if (p1.value.replace(/^\s+|\s+$/g, "") == "") {
                     alert("<spring:message code='jsp.Login.link.nonEmptyPassword' javaScriptEscape='true'/>");
                     return false;
                  }

                  if (p1.value != p2.value) {
                     alert("<spring:message code='jsp.Login.link.passwordNotMatch' javaScriptEscape='true'/>");
                     return false;
                  }
              } else {
                  p1.value = "";
                  p2.value = "";
              }
              return true;

        }

        function createPField(type, id) {
              element = document.createElement("input");
              element.setAttribute("type", type);
              element.setAttribute("name", id);
              element.setAttribute("id", id);
              element.setAttribute("value", "");
              element.setAttribute("size", "20");
              element.setAttribute("maxlength", "100");
              element.setAttribute("class", "control");
              return element;
        }
        
    <% if ("true".equals(request.getParameter("showPasswordChange"))) { %>
       togglePasswordDetails();
    
    <% } %>


</script>
</body>

</html>
