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
  <title><spring:message code="jsp.schemaUploadForm.title"/></title>
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
					<td colspan="3"><span class="fsection"><spring:message code="jsp.schemaUploadForm.header"/></span></td>
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
							<td align="left"><input maxlength="100" name="${status.expression}" type="text" class="fnormal" size="40" value="${status.value}"></td>
						</tr>
						<c:if test="${status.error}">
						<tr>
							<td>&nbsp;</td>
							<td><span class="ferror">${status.errorMessage}</span></td>
						</tr>
						</c:if>
					</spring:bind>
					<%-- edit schema info or add new schema --%>
					<tr>
						<td colspan="3">&nbsp;</td>
					</tr>
                    <c:if test="${connectionWrapper.schemaLocated}">
						<tr>
							<td>&nbsp;</td>
							<td colspan="3"><b><spring:message code="jsp.schemaUploadForm.alreadyLocated"/></b></td>
						</tr>
						<tr>
							<td colspan="3">&nbsp;</td>
						</tr>
                    </c:if>
                    <tr>
                        <td>&nbsp;</td>
                        <td colspan="3">
						<c:choose>
							<c:when test='${connectionWrapper.aloneEditMode}'><spring:message code="jsp.schemaUploadForm.locateNewSchema"/></c:when>
							<c:otherwise><spring:message code="jsp.schemaUploadForm.locateSchemaSource"/></c:otherwise>
						</c:choose></td>
                    </tr>
					<%-- radio button for schema from file system --%>
					<tr>
						<td colspan="3">&nbsp;</td>
					</tr>
                    <spring:bind path="connectionWrapper.source">
					<tr>
						<td align="right">
							<input type="radio" id="FILE_SYSTEM" name="${status.expression}" value="FILE_SYSTEM" 
								<c:if test="${status.value!='CONTENT_REPOSITORY'}">checked="true"</c:if>/>
						</td>
						<td align="left"><spring:message code="jsp.schemaUploadForm.schemaFromFS"/></td>
					</tr>
                    </spring:bind>
					<%-- text box for schema file --%>
                    <spring:bind path="connectionWrapper.schemaData">
                        <tr>
	                        <td>&nbsp;</td>
	                        <td align="left">
								<input type="file" name="${status.expression}" size="30" class="fnormal" onChange="document.forms[0].FILE_SYSTEM.click();"/>
								<c:if test="${connectionWrapper.source!='CONTENT_REPOSITORY'}"><br>&nbsp;<span class="ferror">${schemaUnparsable}</span></c:if>
								<c:if test="${status.error}"><br>&nbsp;<span class="ferror">${status.errorMessage}</span></c:if>
							</td>
                   		 </tr>
					</spring:bind>
					<%-- radio button for schema from repository --%>
                    <spring:bind path="connectionWrapper.source">					
                        <tr>
                            <td align="right">
								<input type="radio" id="CONTENT_REPOSITORY" name="${status.expression}" value="CONTENT_REPOSITORY" 
								<c:if test="${status.value=='CONTENT_REPOSITORY'}">checked="true"</c:if> 
								<c:if test="${connectionWrapper.reusableSchemas==null}">disabled="true"</c:if>/>
							</td>
                            <td align="left"><spring:message code="jsp.schemaUploadForm.schemaFromRepo"/></td>
                        </tr>
                        <c:if test="${status.error || schemaUnparsable}">
	                        <tr>
	                            <td>&nbsp;</td>
	                            <td colspan="3"><span class="ferror">${status.errorMessage}${schemaUnparsable}</span></td>
	                        </tr>
                        </c:if>
                    </spring:bind>
					<%-- list box for schema uri --%>
					<spring:bind path="connectionWrapper.schemaUri">
						<tr>
	                        <td>&nbsp;</td>
	                        <td align="left">
								<select name="${status.expression}" class="fnormal" onClick="document.forms[0].CONTENT_REPOSITORY.click();">
									<%-- set selection --%>
                                    <c:forEach items="${connectionWrapper.reusableSchemas}" var="schema">
                                        <option name="${schema}" <c:if test='${status.value==schema}'>selected="true"</c:if>>${schema}</option>
                                    </c:forEach>
                                </select>	                        
	                        </td>
                   		 </tr>
                        <c:if test="${status.error || (connectionWrapper.source=='CONTENT_REPOSITORY' && schemaUnparsable!=null) }">
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><span class="ferror">${status.errorMessage}
									<c:if test="${connectionWrapper.source=='CONTENT_REPOSITORY'}">${schemaUnparsable}</c:if>
								</span></td>
							</tr>
                        </c:if>
                    </spring:bind>
				</c:if>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="3" align="left">
						<input type="submit" name="_eventId_Cancel" value="<spring:message code="button.cancel"/>" onclick="" class="fnormal"/>&nbsp;
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
