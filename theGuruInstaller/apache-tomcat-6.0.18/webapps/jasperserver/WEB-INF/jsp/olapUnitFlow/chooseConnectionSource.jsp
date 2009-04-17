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
  <title><spring:message code="jsp.chooseConnectionSource.title"/></title>
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
					<td colspan="2"><span class="fsection"><spring:message code="jsp.chooseConnectionSource.header"/></span></td>
				</tr>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				<%-- olap connection info --%>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="2">
					<c:choose>
						<c:when test='${connectionWrapper.aloneEditMode}'><spring:message code="jsp.chooseConnectionSource.locate1"/></c:when>
						<c:otherwise><spring:message code="jsp.chooseConnectionSource.locate2"/></c:otherwise>
					</c:choose></strong></td>
				</tr>
				<spring:bind path="connectionWrapper.source">					
				<c:if test="${connectionWrapper.subNewMode}">
					<tr>
						<td colspan="3">&nbsp;</td>
					</tr>
					<tr>
						<c:choose>
							<c:when test="${connectionWrapper.olapConnectionType=='olapMondrianCon'}">
								<td>&nbsp;</td>
								<td><input type="radio" name="${status.expression}" id="LOCAL" onClick="document.forms[0]._eventId_Next.click();" value="LOCAL" <c:if test='${status.value=="LOCAL"}'>checked="true"</c:if>></td>
								<td><a href="javascript:document.forms[0].LOCAL.click();"><spring:message code="jsp.chooseConnectionSource.localMondrian"/></a></td>
							</c:when>
							<c:otherwise>
								<td>&nbsp;</td>
								<td><input type="radio" name="${status.expression}" id="LOCAL" onClick="document.forms[0]._eventId_Next.click();" value="LOCAL" <c:if test='${status.value=="LOCAL"}'>checked="true"</c:if>></td>
								<td><a href="javascript:document.forms[0].LOCAL.click();"><spring:message code="jsp.chooseConnectionSource.localXmla"/></a></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:if>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="right">
						<c:choose>
							<c:when test="${connectionWrapper.olapConnectionType=='olapMondrianCon'}">
								<input type="radio" id="CONTENT_REPOSITORY" name="${status.expression}" value="CONTENT_REPOSITORY"
								<c:if test="${status.value=='CONTENT_REPOSITORY'}">checked="true"</c:if> 
								<c:if test='${connectionWrapper.reusableMondrianConnections==null}'>disabled="true"</c:if>/>
							</c:when>
							<c:otherwise>
								<input type="radio" id="CONTENT_REPOSITORY" name="${status.expression}" value="CONTENT_REPOSITORY"
								<c:if test="${status.value=='CONTENT_REPOSITORY'}">checked="true"</c:if> 
								<c:if test='${connectionWrapper.reusableXmlaConnections==null}'>disabled="true"</c:if>/>
							</c:otherwise>
						</c:choose>
					</td>
						<td align="left"><spring:message code="jsp.chooseConnectionSource.fromRepository"/></td>
					</tr>
					<c:if test="${status.error || connectionUnparsable}">
						<tr>
							<td>&nbsp;</td>
							<td colspan="2"><span class="ferror">${status.errorMessage}${connectionUnparsable}</span></td>
						</tr>
					</c:if>
				</spring:bind>
				<spring:bind path="connectionWrapper.connectionUri">
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td align="left">
							<c:choose>
								<c:when test="${connectionWrapper.olapConnectionType=='olapMondrianCon'}">
									<select name="${status.expression}" class="fnormal" onClick="document.forms[0].CONTENT_REPOSITORY.click();">
										<c:forEach items="${connectionWrapper.reusableMondrianConnections}" var="connection">
											<option name="${connection}" <c:if test='${status.value==connection}'>selected="true"</c:if>>${connection}</option>
										</c:forEach>
									</select>	                        
								</c:when>
								<c:otherwise>
									<select name="${status.expression}" class="fnormal" onClick="document.forms[0].CONTENT_REPOSITORY.click();">
										<c:forEach items="${connectionWrapper.reusableXmlaConnections}" var="connection">
											<option name="${connection}" <c:if test='${status.value==connection}'>selected="true"</c:if>>${connection}</option>
										</c:forEach>
									</select>	                        
								</c:otherwise>
							</c:choose>
						</td>
					 </tr>
					<c:if test="${status.error || (connectionWrapper.source=='CONTENT_REPOSITORY' && connectionUnparsable!=null) }">
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td><span class="ferror">${status.errorMessage}<c:if test="${connectionWrapper.source=='CONTENT_REPOSITORY'}">${connectionUnparsable}</c:if></span></td>
					</tr>
					</c:if>
				</spring:bind>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="2" align="left">
						<input type="button" name="_eventId_Cancel" value="<spring:message code="button.cancel"/>" class="fnormal" OnClick='javascript:window.location.href="flow.html?_flowId=repositoryExplorerFlow&showFolder=<%=request.getParameter("ParentFolderUri")%>"'/>&nbsp;
						<input name="_eventId_Back" value="<spring:message code="button.back"/>" type="submit" class="fnormal">&nbsp;
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
