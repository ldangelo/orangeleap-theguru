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
    <title><spring:message code="jsp.resourceUploadForm.title"/></title>
    <script>
        function jumpTo(pageTo){
        document.forms[0].jumpToPage.value=pageTo;
        document.forms[0].jumpButton.click();
        }
    </script>
</head>

<body>

<FORM name="fmCRPopJrxml_1" action="" method="post" method="post" enctype="multipart/form-data">       
<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr valign="top">
<c:if test='${masterFlow == "reportUnit"}'>
    <td width="1">
<table width="100%" border="0" cellpading="0" cellspacing="0">
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.naming"/></span></td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.jrxml"/></span></td></tr>
  <tr><td nowrap="true"><a class="wizard_menu_current" href="javascript:document.forms[0]._eventId_Cancel.click();"><spring:message code="jsp.reportWizard.resources"/></a></td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.dataSource"/></span></td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.query"/></span></td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.customization"/></span></td></tr>
</table>
    </td>
</c:if>
    <td>

                <table align="center" border="0" cellpadding="1" cellspacing="0">
                    <tr>
                        <td>&nbsp;</td>
                        <td colspan="2"><span class="fsection">
						<c:choose><c:when test="${(fileResource.parentFlowObject != null && fileResource.parentFlowObject.reportUnit == null)}">
								<c:if test="${fileResource.parentFlowObject.accessGrant != null}">
								<c:choose>
									<c:when test="${fileResource.parentFlowObject.accessGrant}">
										<spring:message code="jsp.accessGrantResource"/>
									</c:when>
									<c:otherwise>
										<spring:message code="jsp.schemaResource"/>
									</c:otherwise>
								</c:choose>
								</c:if>
							</c:when>
							<c:otherwise>
								<c:if test='${fileResource.subflowMode}'><spring:message code="jsp.reportWizard"/> - </c:if><spring:message code="jsp.fileResource"/>
						</c:otherwise></c:choose>
					</span>
						</td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="2">
					<c:choose>
						<c:when test="${(fileResource.parentFlowObject != null && fileResource.parentFlowObject.reportUnit == null)}">
							<c:choose>
								<c:when test="${fileResource.parentFlowObject.accessGrant}">
									<spring:message code="jsp.resourceUploadForm.locateAccessGrant"/>: 
								</c:when>
								<c:otherwise>
									<spring:message code="jsp.resourceUploadForm.locateSchema"/>: 
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<spring:message code="jsp.resourceUploadForm.locateFileResource"/>: 
						</c:otherwise>
					</c:choose>
					<b><c:choose>
						<c:when test='${fileResource.fileResource.name!=null}'>${fileResource.fileResource.name}</c:when>
						<c:otherwise>${fileResource.fileName}</c:otherwise>
					</c:choose></b>
					</td>
				</tr>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				<c:if test='${fileResource.subflowMode}'><%--Show radio button and combo box in sub mode --%>
					<spring:bind path="fileResource.source">
					<tr>
						<td>&nbsp;</td>
						<td><input type="radio" name="${status.expression}" id="CONTENT_REPOSITORY" value="CONTENT_REPOSITORY" <c:if test="${status.value=='CONTENT_REPOSITORY'}">checked="true"</c:if>/></td>
						<td><spring:message code="label.fromRepository"/></td>
					</tr>
					</spring:bind>	
					<spring:bind path="fileResource.newUri">
						<tr>
							<td colspan="2">&nbsp;</td>
							<td>
							<select name="${status.expression}" class="fnormal" onClick="document.forms[0].CONTENT_REPOSITORY.click();">
								<c:forEach items="${fileResource.allResources}" var="res">
									<option name="${res}" <c:if test='${status.value==res}'>selected="true"</c:if>>${res}</option>
								</c:forEach>
							</select></td>
						</tr>
						<c:if test="${status.error}">
							<tr>
								<td colspan="2">&nbsp;</td>
								<td><span class="ferror">${status.errorMessage}</span></td>
							</tr>
						</c:if>
					</spring:bind>
				</c:if>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				
				<c:if test='${fileResource.subflowMode}'><%--Show radio button and combo box in sub mode --%>
					<spring:bind path="fileResource.source">
					<tr>
						<td>&nbsp;</td>
						<td><input type="radio" id="FILE_SYSTEM" name="${status.expression}" value="FILE_SYSTEM" <c:if test="${status.value=='FILE_SYSTEM'}">checked="true"</c:if>/></td>
						<td><spring:message code="jsp.resourceUploadForm.fromFileSystem"/>
							<c:if test="${status.error}"><BR><span class="ferror">${status.errorMessage}</span></c:if></td>
					</tr>
					</spring:bind>
				</c:if>

				<spring:bind path="fileResource.newData">
				<tr>
					<td colspan="2">&nbsp;</td>
					<td><input type="file" name="${status.expression}" value="<c:out value='${status.value}'/>" size="30" class="fnormal" onChange="document.forms[0].FILE_SYSTEM.click();"/>
						<c:if test="${status.error}"><BR><span class="ferror">${status.errorMessage}</span></c:if></td>
				</tr>
				</spring:bind>

				<spring:bind path="fileResource.source">
					<c:if test="${status.error}">
						<tr>
							<td colspan="2">&nbsp;</td>
							<td><span class="ferror">${status.errorMessage}</span></td>
						</tr>
					</c:if>
				</spring:bind>

				<!-- none -->
				<c:if test="${(fileResource.parentFlowObject != null && fileResource.parentFlowObject.reportUnit == null)}">
					<c:if test="${fileResource.parentFlowObject.accessGrant}">
					<spring:bind path="fileResource.source">
						<tr>
							<td colspan="3">&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><input type="radio" name="${status.expression}" id="NONE" value="NONE" <c:if test='${status.value=="NONE"}'>checked="true"</c:if>></td><!--onClick="document.forms[0]._eventId_Next.click();"-->
							<td><a href="javascript:document.forms[0].NONE.click();"><spring:message code="label.none"/></a></td>
						</tr>
					</spring:bind>
					</c:if>
				</c:if>

				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="2">
					     <input type="submit" class="fnormal" name="_eventId_BackToRepository" value="<spring:message code="button.cancel"/>" />&nbsp;
						<c:if test='${fileResource.subflowMode}'>
							<input name="_eventId_Back" value="<spring:message code="button.back"/>" type="submit" class="fnormal">&nbsp;
						</c:if>
						<input name="_eventId_Next" value="<spring:message code="button.next"/>" type="submit" class="fnormal">
					</td>
				</tr>           
			</table>
            <input type="hidden" name="jumpToPage">
            <input type="submit" class="fnormal" style="visibility:hidden;" value="" name="_eventId_Jump" id="jumpButton">
            <input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
    </td>
  </tr>
</table>
</FORM>

</body>

</html>



