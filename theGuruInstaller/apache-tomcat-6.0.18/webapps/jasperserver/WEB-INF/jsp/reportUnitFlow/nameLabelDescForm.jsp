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
  <title><spring:message code="jsp.reportUnitFlow.nameLabelDescForm.title"/></title>
  <meta name="pageHeading" content="<c:choose><c:when test='${wrapper.aloneEditMode}'><spring:message code='jsp.pageHeading.editReportWizard'/></c:when><c:otherwise><spring:message code='jsp.pageHeading.createReportWizard'/></c:otherwise></c:choose>"/>
  <meta http-equiv="Content-Type" content="text/html"/>
  <script>
        function jumpTo(pageTo){
        document.forms[0].jumpToPage.value=pageTo;
        document.forms[0].jumpButton.click();
        }
  </script>
</head>

<body>

<FORM name="fmCRPopNLD" action="" method="post">
<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr valign="top">
    <td width="1">
<table width="100%" border="0" cellpading="0" cellspacing="0">
  <tr><td nowrap="true"><a class="wizard_menu_current" href="javascript:;"><spring:message code="jsp.reportWizard.naming"/></a></td></tr>
  <tr><td nowrap="true"><a class="wizard_menu" href="javascript:document.forms[0].jrxmlUpload.click();"><spring:message code="jsp.reportWizard.jrxml"/></a></td></tr>
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
          <table align="center" cellspacing="1" cellpadding="0" border="0">
            <tr>
                <td>&nbsp;</td>
                <td><span class="fsection"><spring:message code="jsp.reportUnitFlow.nameLabelDescForm.header"/></span></td>
            </tr>
            <tr>
                <td colspan="2">&nbsp;</td>
            </tr>
<spring:bind path="wrapper.reportUnit.name">
            <tr>
                <td align="right"><spring:message code="jsp.reportUnitFlow.nameLabelDescForm.star.name"/>&nbsp;</td>
                <td align="left"><input type="text" class="fnormal" name="${status.expression}" <c:if test="${wrapper.editMode}">readonly="true"</c:if> value="<c:out value='${status.value}'/>" size="40"/></td>
            </tr>
            <c:if test="${status.error}">
            <tr>
                <td>&nbsp;</td>
                <td><span class="ferror">${status.errorMessage}</span></td>
            </tr>
            </c:if>
</spring:bind>
<spring:bind path="wrapper.reportUnit.label">
            <tr>
                <td align="right"><spring:message code="jsp.reportUnitFlow.nameLabelDescForm.star.label"/>&nbsp;</td>
                <td align="left"><input type="text" class="fnormal" name="${status.expression}" value="<c:out value='${status.value}'/>" size="40"/></td>
            </tr>
            <c:if test="${status.error}">
            <tr>
                <td>&nbsp;</td>
                <td><span class="ferror">${status.errorMessage}</span></td>
            </tr>
            </c:if>
</spring:bind>
<spring:bind path="wrapper.reportUnit.description">
            <tr>
                <td align="right" valign="top"><spring:message code="label.description"/>&nbsp;</td>
                <td align="left"><textarea name="${status.expression}" rows="5" cols="28" class="fnormal"><c:out value='${status.value}'/></textarea></td>
            </tr> 
            <c:if test="${status.error}">
            <tr>
                <td>&nbsp;</td>
                <td><span class="ferror">${status.errorMessage}</span></td>
            </tr>
            </c:if>
</spring:bind>
            <tr>
                <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                  <input type="button" name="_eventId_Cancel" class="fnormal" value='<spring:message code="button.cancel"/>' OnClick='javascript:window.location.href="flow.html?_flowId=repositoryExplorerFlow&showFolder=<%=request.getParameter("ParentFolderUri")%>"'/>&nbsp;
                  <input name="_eventId_Next" value='<spring:message code="button.next"/>' type="submit" class="fnormal" >&nbsp;
                  <input name="_eventId_Finish" value='<spring:message code="button.finish"/>' type="submit" class="fnormal" >&nbsp;
                </td>
            </tr>
          </table>
            <input type="hidden" name="jumpToPage">
            <input type="submit" style="visibility:hidden;" class="fnormal" value="" name="_eventId_Jump" id="jumpButton">
            <input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>          

    </td>
  </tr>
</table>
</FORM>

</body>

</html>

 
