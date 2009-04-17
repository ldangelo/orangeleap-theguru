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
  <title><spring:message code="jsp.connectionNamingForm.title"/></title>
  <meta name="pageHeading" content="<c:choose><c:when test='${connectionWrapper.aloneEditMode}'><spring:message code="jsp.olapDS.pageHeading_edit"/></c:when><c:otherwise><spring:message code="jsp.olapDS.pageHeading_new"/></c:otherwise></c:choose>"/>
  <meta http-equiv="Content-Type" content="text/html; charset=${requestScope['com.jaspersoft.ji.characterEncoding']}">
  <script>
            function jumpTo(pageTo){
            document.forms[0].jumpToPage.value=pageTo;
            document.forms[0].jumpButton.click();
            }
           
  </script>
</head>

<body>


<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr>
    <td>
		<FORM name="fmCRPopSchema_1" action="" method="post" enctype="multipart/form-data">
			<table align="center" cellpadding="1" cellspacing="0" border="0">
				<%-- title line --%>
				<tr>
					<td>&nbsp;</td>
					<td colspan="3"><span class="fsection"><spring:message code="jsp.connectionNamingForm.header"/></span></td>
				</tr>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				<%-- schema status info --%>
				<c:if test="${connectionWrapper.aloneNewMode || connectionWrapper.olapConnectionType=='olapMondrianCon'}">
					<%-- mondrian connection info --%>
					<tr>
						<td colspan="3">&nbsp;</td>
					</tr>
					<spring:bind path="connectionWrapper.connectionName">
						<tr>
							<td align="right">* <spring:message code="label.name"/>&nbsp;</td>
							<td>
								<input maxlength="100" name="${status.expression}" type="text" class="fnormal" size="40" 
								<c:if test='${connectionWrapper.aloneEditMode}'>disabled="true"</c:if> value="${status.value}">
							</td>
						</tr>
						<c:if test="${status.error}">
						<tr>
							<td>&nbsp;</td>
							<td><span class="ferror">${status.errorMessage}</span></td>
						</tr>
						</c:if>
					</spring:bind>
					<spring:bind path="connectionWrapper.connectionLabel">
						<tr align="center">
							<td align="right">* <spring:message code="label.label"/>&nbsp;</td>
							<td align="left">
								<input maxlength="100" name="${status.expression}" type="text" class="fnormal" size="40" value="${status.value}">
							</td>
						</tr>
						<c:if test="${status.error}">
						<tr>
							<td>&nbsp;</td>
							<td><span class="ferror">${status.errorMessage}</span></td>
						</tr>
						</c:if>
					</spring:bind>
					<spring:bind path="connectionWrapper.connectionDescription">
						<tr align="center">
							<td align="right"><spring:message code="label.description"/>&nbsp;</td>
							<td align="left"><textarea name="${status.expression}" rows="5" cols="28" class="fnormal"><c:out value='${status.value}'/></textarea></td>
						</tr>
						<c:if test="${status.error}">
						<tr>
							<td>&nbsp;</td>
							<td><span class="ferror">${status.errorMessage}</span></td>
						</tr>
						</c:if>
					</spring:bind>
					<c:if test="${connectionWrapper.subflowMode}">
							<tr>
							<td align="right"><spring:message code="jsp.connectionNamingForm.folder"/>&nbsp;</td>
							<td colspan="2">
								<c:choose>
								<c:when test="${connectionWrapper.editMode && connectionWrapper.parentFolder!=null}">${connectionWrapper.parentFolder}</c:when>
								<c:otherwise>
								<spring:bind path="connectionWrapper.parentFolder">
								<select
									name="${status.expression}" 
									class="fnormal" 
									onClick="document.forms[0].CONTENT_REPOSITORY.click();">

									<c:forEach items="${connectionWrapper.allFolders}" var="folder">
										<option name="${folder}" 
											<c:if test='${status.value==folder}'>selected="true"</c:if>>${folder}
										</option>
									</c:forEach>
								</select>	                        
								</spring:bind>
								<c:if test="${status.error}"><BR><span class="ferror">${status.errorMessage}</span></c:if>
								</c:otherwise>
								</c:choose>
							</td>
							</tr>
					</c:if>
				</c:if>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="3" align="left">
						<input type="button" name="_eventId_Cancel" value="<spring:message code="button.cancel"/>" class="fnormal" OnClick='javascript:window.location.href="flow.html?_flowId=repositoryExplorerFlow&showFolder=<%=request.getParameter("ParentFolderUri")%>"'/>&nbsp;
                        <% if (request.getParameter("selectedResource") == null) { %>
 						 <input name="_eventId_Back" value="<spring:message code="button.back"/>" type="submit" class="fnormal">&nbsp;
			            <% } %>
						<input name="_eventId_Next" value="<spring:message code="button.next"/>" type="submit" class="fnormal">
					</td>
				</tr>           
			</table>
            <table align="center" cellpadding="1" cellspacing="0" border="0">
            <input type="hidden" name="jumpToPage">
            <input type="submit"  class="fnormal" style="visibility:hidden;" value="" name="_eventId_Jump" id="jumpButton">
            <input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
			</table>
		</FORM>
    </td>
  </tr>
</table>


</body>

</html>
