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
  <title><spring:message code="jsp.editMondrianXmlaSourceForm.title"/></title>
  <meta name="pageHeading" content='<spring:message code="jsp.editMondrianXmlaSourceForm.pageHeading"/>'/>
</head>

<body>

<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr>
    <td>
		<form name="fmMondrianXmlaSource" method="post" action="">
		<table border="0" cellpadding="1" cellspacing="0" align="center">
		<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
		  <tr>
			<td>&nbsp;</td>
			<td><span class="fsection"><spring:message code="jsp.editMondrianXmlaSourceForm.title"/></span></td>
		  </tr>
		  <tr>
			<td colspan="2">&nbsp;</td>
		  </tr>
		<spring:bind path="mondrianXmlaSource.mondrianXmlaDefinition.name">
		  <tr>
			<td align="right"><spring:message code="jsp.editMondrianXmlaSourceForm.name"/></td>
			<td><input type="text" name="${status.expression}" <c:if test='${mondrianXmlaSource.aloneEditMode}'>disabled="true"</c:if> value="${status.value}" size="40" class="fnormal"/></td>
		  </tr>
		  <c:if test="${status.error}">
			<c:forEach items="${status.errorMessages}" var="error">
		  <tr>
			<td>&nbsp;</td>
			<td><span class="ferror"><c:out value="${error}"/></span></td>
		  </tr>
			</c:forEach>
		  </c:if>
		</spring:bind>

		<spring:bind path="mondrianXmlaSource.mondrianXmlaDefinition.label">
		  <tr>
			<td align="right"><spring:message code="jsp.editMondrianXmlaSourceForm.label"/></td>
			<td><input type="text" name="${status.expression}" value="${status.value}" size="40" class="fnormal"/></td>
		  </tr>
		  <c:if test="${status.error}">
			<c:forEach items="${status.errorMessages}" var="error">
		  <tr>
			<td>&nbsp;</td>
			<td><span class="ferror"><c:out value="${error}"/></span></td>
		  </tr>
			</c:forEach>
		  </c:if>
		</spring:bind>

		<spring:bind path="mondrianXmlaSource.mondrianXmlaDefinition.description">
		  <tr>
			<td align="right" valign="top"><spring:message code="jsp.editMondrianXmlaSourceForm.description"/></td>
			<td><input type="text" name="${status.expression}" value="${status.value}" size="40" class="fnormal"/></td>
		  </tr>
		  <c:if test="${status.error}">
			<c:forEach items="${status.errorMessages}" var="error">
		  <tr>
			<td>&nbsp;</td>
			<td><span class="ferror"><c:out value="${error}"/></span></td>
		  </tr>
			</c:forEach>
		  </c:if>
		</spring:bind>

		<tr>
			<td colspan="2">&nbsp;</td>
		</tr>

		<spring:bind path="mondrianXmlaSource.mondrianXmlaDefinition.catalog">
		  <tr>
			<%-- <td align="right">Pattern&nbsp;</td> --%>
			<td align="right"><spring:message code="jsp.editMondrianXmlaSourceForm.catalog"/></td>
			<td><input type="text" name="${status.expression}" value="${status.value}" size="40" class="fnormal"/><spring:message code="jsp.editMondrianXmlaSourceForm.foodmart"/></td>
		  </tr>
		  <c:if test="${status.error}">
			<c:forEach items="${status.errorMessages}" var="error">
		  <tr>
			<td>&nbsp;</td>
			<td><span class="ferror"><c:out value="${error}"/></span></td>
		  </tr>
			</c:forEach>
		  </c:if>
		</spring:bind>

		<spring:bind path="mondrianXmlaSource.connectionUri">
		  <tr>
			<%-- <td align="right">Minimum value&nbsp;</td> --%>
			<td align="right"><spring:message code="jsp.editMondrianXmlaSourceForm.connection_reference"/></td>
			<td>
				<select name="${status.expression}" class="fnormal" onClick="document.forms[0].CONTENT_REPOSITORY.click();">
					<c:forEach items="${mondrianXmlaSource.allMondrianConnections}" var="connection">
						<option name="${connection}" <c:if test='${status.value==connection}'>selected="true"</c:if>>${connection}</option>
					</c:forEach>
				</select>	                        
			</td>
		  </tr>
		  <c:if test="${mondrianXmlaSource.connectionInvalid}">
			  <tr>
				<td>&nbsp;</td>
				<td><span class="ferror"><c:out value='<spring:message code="jsp.editMondrianXmlaSourceForm.invalidConnection"/>'/></span></td>
			  </tr>
		  </c:if>
		</spring:bind>
		  <tr>
			<td colspan="2">&nbsp;</td>
		  </tr>
		  <tr>
			<td>&nbsp;</td>
			<td>
			  <input type="button" name="_eventId_cancel" value='<spring:message code="button.cancel"/>' class="fnormal" OnClick='javascript:window.location.href="flow.html?_flowId=repositoryExplorerFlow&showFolder=<%=request.getParameter("ParentFolderUri")%>"'/>
			  <input type="submit" name="_eventId_save" value='<spring:message code="button.save"/>' class="fnormal"/>&nbsp;
			</td>
		  </tr>
		</table>
		</form>
    </td>
  </tr>
</table>

</body>

</html>
