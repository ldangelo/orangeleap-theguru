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
<title><spring:message code="jsp.resourceNamingForm.title"/></title>
<script>
function jumpTo(pageTo){
    document.forms[0].jumpToPage.value=pageTo;
    document.forms[0].jumpButton.click();
}
</script>
</head>

<body>


<FORM name="aqRsrRsrNm3" action="" method="post">
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
<input type="submit" class="fnormal" name="_eventId_resources" id="resources" value="resources" style="visibility:hidden;"/>

    </td>
</c:if>
    <td>

    <table border="0" cellpadding="1" cellspacing="0" border="0" align="center">
        <tr>
            <td>&nbsp;</td>
            <td><span class="fsection">
				<c:choose>
					<c:when test="${(fileResource.parentFlowObject != null && fileResource.parentFlowObject.reportUnit == null)}">
						<c:choose>
							<c:when test="${fileResource.parentFlowObject.accessGrant}">
								<spring:message code="jsp.accessGrantResource"/>
							</c:when>
							<c:otherwise>
								<spring:message code="jsp.schemaResource"/>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:if test="${fileResource.subflowMode}"><spring:message code="jsp.reportWizard"/> - </c:if><spring:message code="jsp.fileResource"/>
					</c:otherwise>
				</c:choose>
			</span></td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
		<tr>
	        <td>&nbsp;</td>
	        <td>
				<c:choose>
		        	<%--<c:when test='${uploadedFileName!=null || uploadedFileExt!=null}'><b>${uploadedFileName}.${uploadedFileExt}</b> successfully uploaded.</c:when>--%>
					<c:when test='${uploadedFileName!=null || uploadedFileExt!=null}'><spring:message code="jsp.resourceNamingForm.resourceUploaded" arguments="${uploadedFileName}.${uploadedFileExt}"/></c:when>
		        	<c:otherwise>
						<spring:message code="jsp.resourceNamingForm.resourceSelected1"/><b>${fileResource.fileResource.referenceURI}</b>&nbsp;
						<spring:message code="jsp.resourceNamingForm.resourceSelected2"/>
					</c:otherwise>
				</c:choose>
        	</td>
        </tr>
        <tr><td colspan="2">&nbsp;</td></tr>
    <spring:bind path="fileResource.fileResource.name">
        <tr>
        <td align="right">* <spring:message code="label.name"/>&nbsp;</td>
        <td colspan="2">
			<input 
				<c:if test="${fileResource.editMode || (fileResource.suggested && fileResource.subflowMode)}">readonly</c:if>
				<c:if test="${fileResource.subflowMode && (fileResource.fileResource.fileType=='olapMondrianSchema' || fileResource.fileResource.fileType=='accessGrantSchema') && fileResource.source=='CONTENT_REPOSITORY'}">disabled</c:if> 
				name="${status.expression}" 
				type="text" 
				value="${status.value}" 
				size="20" 
				class="fnormal">				
				<c:if test="${status.error}"><BR><span class="ferror">${status.errorMessage}</span></c:if>
			</td>
        </tr>
    </spring:bind>
    <spring:bind path="fileResource.fileResource.label">
        <tr>
        <td align="right">* <spring:message code="label.label"/>&nbsp;</td>
        <td colspan="2">
			<input 
				<c:if test="${fileResource.subflowMode && (fileResource.fileResource.fileType=='olapMondrianSchema' || fileResource.fileResource.fileType=='accessGrantSchema') && fileResource.source=='CONTENT_REPOSITORY'}">disabled</c:if> 
				name="${status.expression}" 
				type="text" 
				class="fnormal" 
				value="${status.value}" 
				size="20">
				<c:if test="${status.error}"><BR><span class="ferror">${status.errorMessage}</span></c:if>
		</td>
        </tr>
    </spring:bind>
		<spring:bind path="fileResource.fileResource.description">
			<tr>
				<td align="right" valign="top"><spring:message code="label.description"/>&nbsp;</td>
				<td align="left">
				<textarea 
					<c:if test="${fileResource.subflowMode && (fileResource.fileResource.fileType=='olapMondrianSchema' || fileResource.fileResource.fileType=='accessGrantSchema') && fileResource.source=='CONTENT_REPOSITORY'}">disabled</c:if> 
					name="${status.expression}" rows="5" cols="28" class="fnormal"><c:out value='${status.value}'/></textarea></td>
			</tr>
			<c:if test="${status.error}">
			<tr>
				<td>&nbsp;</td>
				<td><span class="ferror">${status.errorMessage}</span></td>
			</tr>
			</c:if>
		</spring:bind>

        <spring:bind path="fileResource.fileResource.fileType">
        <tr><td align="right"><spring:message code="label.type"/>&nbsp;</td>
        <td colspan="2"><c:choose>
		<c:when test="${fileResource.fileResource.fileType!=null}">${allTypes[fileResource.fileResource.fileType]}</c:when>
        <c:otherwise>
        	<select name="${status.expression}" class="fnormal">
				<c:forEach items="${allTypes}" var="type">
                	<option value="${type.key}">${type.value}</option>
	           </c:forEach>
    	    </select>      	
        </c:otherwise></c:choose></td></tr>
    	</spring:bind>
<c:if test="${fileResource.subflowMode && (fileResource.fileResource.fileType == 'olapMondrianSchema' || fileResource.fileResource.fileType == 'accessGrantSchema')}">
		<spring:bind path="fileResource.fileResource.parentFolder">
		<tr>
		<td align="right"><spring:message code="label.folder"/>&nbsp;</td>
		<td colspan="2">
			<c:choose>
			<c:when test="${fileResource.editMode || fileResource.source=='CONTENT_REPOSITORY' && fileResource.fileResource.parentFolder!=null}">${fileResource.fileResource.parentFolder}</c:when>
			<c:otherwise>
			<select 
				name="${status.expression}" 
				class="fnormal" 
				onClick="document.forms[0].CONTENT_REPOSITORY.click();">

				<c:forEach items="${fileResource.allFolders}" var="folder">
					<option name="${folder}" 
						<c:if test='${status.value==folder}'>selected="true"</c:if>>${folder}
					</option>
				</c:forEach>
			</select>	                        
			<c:if test="${status.error}"><BR><span class="ferror">${status.errorMessage}</span></c:if>
			</c:otherwise>
			</c:choose>
		</td>
		</tr>
		</spring:bind>
</c:if>			
        <tr><td colspan="2">&nbsp;</td></tr>
        <tr>
        <td>&nbsp;</td>
        <td>
        <% if ("olapClientConnectionFlow".equalsIgnoreCase(request.getParameter("_flowId")) ||
               "fileResourceFlow".equalsIgnoreCase(request.getParameter("_flowId"))) {  %>
         <input type="button" class="fnormal" name="_eventId_Cancel" value="<spring:message code="button.cancel"/>" OnClick='javascript:window.location.href="flow.html?_flowId=repositoryExplorerFlow&showFolder=<%=request.getParameter("ParentFolderUri")%>"'/>&nbsp;      
        <% } else { %>
         <input type="submit" class="fnormal" name="_eventId_Cancel" value="<spring:message code="button.cancel"/>" />&nbsp;       
        <% } %>
        <input type="submit" class="fnormal" name="_eventId_Back" value="<spring:message code="button.back"/>">&nbsp;
        <c:choose>
            <c:when test='${fileResource.standAloneMode}'>
        <input type="submit" class="fnormal" name="_eventId_Save" value="<spring:message code="button.save"/>">
            </c:when>
            <c:otherwise>
        <input type="submit" class="fnormal" name="_eventId_Next" value="<spring:message code="button.next"/>">
            </c:otherwise>
        </c:choose></td>
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
