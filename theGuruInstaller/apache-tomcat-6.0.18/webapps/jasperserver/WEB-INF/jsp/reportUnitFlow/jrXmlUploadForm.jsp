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
  <title><spring:message code="jsp.jrXmlUploadForm.title"/></title>
  <meta name="pageHeading" content="<c:choose><c:when test='${wrapper.aloneEditMode}'><spring:message code="jsp.pageHeading.editReportWizard"/></c:when><c:otherwise><spring:message code="jsp.pageHeading.createReportWizard"/></c:otherwise></c:choose>"/>
  <meta http-equiv="Content-Type" content="text/html; charset=${requestScope['com.jaspersoft.ji.characterEncoding']}">
  <script>
            function jumpTo(pageTo){
            document.forms[0].jumpToPage.value=pageTo;
            document.forms[0].jumpButton.click();
            }
  </script>
</head>

<body>

<FORM name="fmCRPopJrxml_1" action="" method="post" enctype="multipart/form-data">
<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr valign="top">
    <td width="1">
<table width="100%" border="0" cellpading="0" cellspacing="0">
  <tr><td nowrap="true"><a class="wizard_menu" href="javascript:document.forms[0].reportNaming.click();"><spring:message code="jsp.reportWizard.naming"/></a></td></tr>
  <tr><td nowrap="true"><a class="wizard_menu_current" href="javascript:document.forms[0].jrxmlUpload.click();"><spring:message code="jsp.reportWizard.jrxml"/></a></td></tr>
  <tr><td nowrap="true"><a class="wizard_menu" href="javascript:document.forms[0]._eventId_resources.click();"><spring:message code="jsp.reportWizard.resources"/></a></td></tr>
  <tr><td nowrap="true"><a class="wizard_menu" href="javascript:document.forms[0].dataSource.click();"><spring:message code="jsp.reportWizard.dataSource"/></a></td></tr>
  <tr><td nowrap="true"><a class="wizard_menu" href="javascript:document.forms[0].query.click();"><spring:message code="jsp.reportWizard.query"/></a></td></tr>
  <tr><td nowrap="true"><a class="wizard_menu" href="javascript:document.forms[0].customization.click();"><spring:message code="jsp.reportWizard.customization"/></a></td></tr>
</table>
<input type="submit" class="fnormal" name="_eventId_reportNaming" id="reportNaming" value="reportNaming" style="visibility:hidden;"/>
<input type="submit" class="fnormal" name="_eventId_jrxmlUpload" id="jrxmlUpload" value="jrxmlUpload" style="visibility:hidden;"/>
<input type="submit" class="fnormal" name="_eventId_resources" id="resources" value="resources" style="visibility:hidden;"/>
<input type="submit" class="fnormal" name="_eventId_dataSource" id="dataSource" value="dataSource" style="visibility:hidden;"/>
<input type="submit" class="fnormal" name="_eventId_query" id="query" value="query" style="visibility:hidden;"/>
<input type="submit" class="fnormal" name="_eventId_customization" id="customization" value="customization" style="visibility:hidden;"/>
    </td>
    <td>
                <table align="center" cellpadding="1" cellspacing="0" border="0">
	                <tr>
	                    <td>&nbsp;</td>
	                    <td colspan="2"><span class="fsection"><spring:message code="jsp.jrXmlUploadForm.header"/></span></td>
	                </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <c:if test="${wrapper.jrxmlLocated}">
                    <tr>
                        <td>&nbsp;</td>
                        <td colspan="2"><b><spring:message code="jsp.jrXmlUploadForm.fileLocated"/></b></td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    </c:if>
                    <tr>
                        <td>&nbsp;</td>
                        <td colspan="2"><strong><c:choose><c:when test='${wrapper.aloneEditMode}'><spring:message code="jsp.jrXmlUploadForm.locateFile.overwriting"/></c:when>
                        <c:otherwise><spring:message code="jsp.jrXmlUploadForm.locateFile"/></c:otherwise></c:choose></strong></td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <spring:bind path="wrapper.source">
                        <tr>
                            <td>&nbsp;</td>
                            <td align="right"><input type="radio" id="FILE_SYSTEM" name="${status.expression}" value="FILE_SYSTEM" <c:if test="${status.value!='CONTENT_REPOSITORY'}">checked="true"</c:if>/></td>
                            <td align="left"><spring:message code="jsp.jrXmlUploadForm.fromFileSystem"/></td>
                        </tr>
                    </spring:bind>
                    <spring:bind path="wrapper.jrxmlData">
                        <tr>
	                        <td>&nbsp;</td>
	                        <td>&nbsp;</td>
	                        <td align="left"><input type="file" name="${status.expression}" size="30" class="fnormal" onChange="document.forms[0].FILE_SYSTEM.click();"/><c:if test="${status.error}"><br>&nbsp;<span class="ferror">${status.errorMessage}</span></c:if><c:if test="${wrapper.source!='CONTENT_REPOSITORY'}"><br>&nbsp;<span class="ferror"><spring:message code="${jrxmlUnparsable}"/></span></c:if></td>
                   		 </tr>
					</spring:bind>
					<tr>
						<td colspan="3">&nbsp;</td>
                    </tr>
                    <spring:bind path="wrapper.source">					
                        <tr>
                            <td>&nbsp;</td>
                            <td align="right"><input type="radio" id="CONTENT_REPOSITORY" name="${status.expression}" value="CONTENT_REPOSITORY" <c:if test="${status.value=='CONTENT_REPOSITORY'}">checked="true"</c:if> <c:if test='${empty wrapper.reusableJrxmls}'>disabled="true"</c:if>/></td>
                            <td align="left"><spring:message code="jsp.jrXmlUploadForm.fromContentRepo"/></td>
                        </tr>
                        <c:if test="${status.error || jrxmlUnparsable}">
	                        <tr>
	                            <td>&nbsp;</td>
	                            <td colspan="2"><span class="ferror">${status.errorMessage}<spring:message code="${jrxmlUnparsable}"/></span></td>
	                        </tr>
                        </c:if>
                    </spring:bind>
					<spring:bind path="wrapper.jrxmlUri">
						<tr>
	                        <td>&nbsp;</td>
	                        <td>&nbsp;</td>
	                        <td align="left">
								<select name="${status.expression}" class="fnormal" onClick="document.forms[0].CONTENT_REPOSITORY.click();" <c:if test='${empty wrapper.reusableJrxmls}'>disabled="true"</c:if>>
                                    <c:forEach items="${wrapper.reusableJrxmls}" var="jrxml">
                                        <option name="${jrxml}" <c:if test='${status.value==jrxml}'>selected="true"</c:if>>${jrxml}</option>
                                    </c:forEach>
                                </select>	                        
	                        </td>
                   		 </tr>
                        <c:if test="${status.error || (wrapper.source=='CONTENT_REPOSITORY' && jrxmlUnparsable!=null) }">
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td><span class="ferror">${status.errorMessage}<c:if test="${wrapper.source=='CONTENT_REPOSITORY'}"><spring:message code="${jrxmlUnparsable}"/></c:if></span></td>
                        </tr>
                        </c:if>
                    </spring:bind>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td colspan="2" align="left">
                            <input type="button" name="_eventId_Cancel" value='<spring:message code="button.cancel"/>' OnClick='javascript:window.location.href="flow.html?_flowId=repositoryExplorerFlow&showFolder=<%=request.getParameter("ParentFolderUri")%>"' class="fnormal"/>&nbsp;
                            <input name="_eventId_Back" value='<spring:message code="button.back"/>' type="submit" class="fnormal">&nbsp;
                            <input name="_eventId_Next" value='<spring:message code="button.next"/>' type="submit" class="fnormal">
                            <input name="_eventId_Finish" value='<spring:message code="button.finish"/>' type="submit" class="fnormal">
                        </td>
                    </tr>           
                </table>
            <input type="hidden" name="jumpToPage">
            <input type="submit"  class="fnormal" style="visibility:hidden;" value="" name="_eventId_Jump" id="jumpButton">
            <input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>

    </td>
  </tr>
</table>
</FORM>

</body>

</html>

 
