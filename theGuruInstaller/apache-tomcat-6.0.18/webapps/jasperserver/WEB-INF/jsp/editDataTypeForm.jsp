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
<%@taglib uri="/WEB-INF/jasperserver.tld" prefix="js" %>

<html>
<head>
  <title><spring:message code="jsp.editDataTypeForm.title"/></title>
  <meta name="pageHeading" content='<spring:message code="jsp.editDataTypeForm.pageHeading"/>'/>
</head>

<body>

<form name="fmDataType" method="post" action="">
<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr valign="top">
<c:if test='${masterFlow == "reportUnit"}'>
    <td width="1">
<table width="100%" border="0" cellpading="0" cellspacing="0">
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.naming"/></span></td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.jrxml"/></span></td></tr>
  <tr><td nowrap="true"><a class="wizard_menu_current" href="javascript:document.forms[0]._eventId_cancel.click();"><spring:message code="jsp.reportWizard.resources"/></a></td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.dataSource"/></span></td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.query"/></span></td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.customization"/></span></td></tr>
</table>
    </td>
</c:if>
    <td>
<input type="submit" name="_eventId_changeCombo" id="changeCombo" style="visibility:hidden;" />
<table border="0" cellpadding="1" cellspacing="0" align="center">
<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
  <tr>
    <td>&nbsp;</td>
    <td><span class="fsection"><spring:message code="jsp.editDataTypeForm.title"/></span></td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
<spring:bind path="dataType.dataType.name">
  <tr>
    <td align="right"><spring:message code="jsp.editDataTypeForm.name"/>&nbsp;</td>
    <td><input type="text" name="${status.expression}" value="${status.value}" size="40" class="fnormal"  <c:if test='${dataType.editMode}'>readonly="true"</c:if>/></td>
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

<spring:bind path="dataType.dataType.label">
  <tr>
    <td align="right"><spring:message code="jsp.editDataTypeForm.label"/>&nbsp;</td>
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

<spring:bind path="dataType.dataType.description">
  <tr>
    <td align="right" valign="top"><spring:message code="jsp.editDataTypeForm.description"/>&nbsp;</td>
    <td><textarea name="${status.expression}" cols="37" rows="4" class="fnormal"><c:out value="${status.value}"/></textarea></td>
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

<spring:bind path="dataType.dataType.type">
  <tr>
    <td align="right"><spring:message code="jsp.editDataTypeForm.type"/>&nbsp;</td>
    <td>
      <select name="${status.expression}" class="fnormal" onchange="javascript:document.fmDataType.changeCombo.click();">
        <c:if test="${status.value==1}"><option value="1" selected><spring:message code="jsp.editDataTypeForm.text"/></option></c:if>
        <c:if test="${status.value!=1}"><option value="1"><spring:message code="jsp.editDataTypeForm.text"/></option></c:if>
        <c:if test="${status.value==2}"><option value="2" selected><spring:message code="jsp.editDataTypeForm.number"/></option></c:if>
        <c:if test="${status.value!=2}"><option value="2"><spring:message code="jsp.editDataTypeForm.number"/></option></c:if>
        <c:if test="${status.value==3}"><option value="3" selected><spring:message code="jsp.editDataTypeForm.date"/></option></c:if>
        <c:if test="${status.value!=3}"><option value="3"><spring:message code="jsp.editDataTypeForm.date"/></option></c:if>
        <c:if test="${status.value==4}"><option value="4" selected><spring:message code="jsp.editDataTypeForm.datetime"/></option></c:if>
        <c:if test="${status.value!=4}"><option value="4"><spring:message code="jsp.editDataTypeForm.datetime"/></option></c:if>
      </select>
    </td>
  </tr>
</spring:bind>

<c:if test="${dataType.dataType.type != 2 && dataType.dataType.type != 3 && dataType.dataType.type != 4}">
	<spring:bind path="dataType.dataType.regularExpr">
	  <tr>
		<td align="right"><spring:message code="jsp.editDataTypeForm.pattern"/>&nbsp;</td>
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
</c:if>
<c:choose>
<c:when test="${dataType.dataType.type == 3 || dataType.dataType.type == 4}">
<spring:bind path="dataType.minValueText">
  <tr>
    <td align="right"><spring:message code="jsp.editDataTypeForm.minValue"/>&nbsp;</td>
    <td>
        <c:choose>
            <c:when test="${dataType.dataType.type == 3}">
                <js:calendarInput name="${status.expression}" value="${status.value}"
                    formatPattern="${requestScope.calendarDatePattern}"
                    time="false"
                    imageTipMessage="jsp.defaultParametersForm.pickDate"/>
            </c:when>
            <c:otherwise>
                <js:calendarInput name="${status.expression}" value="${status.value}"
                    formatPattern="${requestScope.calendarDatetimePattern}"
                    imageTipMessage="jsp.defaultParametersForm.pickDate"/>
            </c:otherwise>
        </c:choose>
    </td>
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
</c:when>
<c:otherwise>
<spring:bind path="dataType.dataType.minValue">
  <tr>
    <td align="right"><spring:message code="jsp.editDataTypeForm.minValue"/>&nbsp;</td>
    <td>
	   <input type="text" name="${status.expression}" value="${status.value}" size="40" class="fnormal"/>&nbsp;
	</td>
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
</c:otherwise>
</c:choose>

<spring:bind path="dataType.dataType.strictMin">
  <tr>
    <td align="right"><spring:message code="jsp.editDataTypeForm.strictMin"/>&nbsp;</td>
    <td>
		<input name="_${status.expression}" type="hidden"/>
  <c:if test="${status.value}">
      <input type="checkbox" name="${status.expression}" checked class="fnormal"/>
  </c:if>
  <c:if test="${!status.value}">
      <input type="checkbox" name="${status.expression}" class="fnormal"/>
  </c:if>
     </td>
  </tr>
</spring:bind>

<c:choose>
<c:when test="${dataType.dataType.type == 3 || dataType.dataType.type == 4}">
<spring:bind path="dataType.maxValueText">
  <tr>
    <td align="right"><spring:message code="jsp.editDataTypeForm.maxValue"/>&nbsp;</td>
    <td>
        <c:choose>
            <c:when test="${dataType.dataType.type == 3}">
                <js:calendarInput name="${status.expression}" value="${status.value}"
                    formatPattern="${requestScope.calendarDatePattern}"
                    time="false"
                    imageTipMessage="jsp.defaultParametersForm.pickDate"/>
            </c:when>
            <c:when test="${dataType.dataType.type == 4}">
                <js:calendarInput name="${status.expression}" value="${status.value}"
                    formatPattern="${requestScope.calendarDatetimePattern}"
                    imageTipMessage="jsp.defaultParametersForm.pickDate"/>
            </c:when>
            <c:otherwise>
                <input type="text" name="${status.expression}" value="${status.value}" size="40" class="fnormal"/>
            </c:otherwise>
        </c:choose>
    </td>
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
</c:when>
<c:otherwise>
<spring:bind path="dataType.dataType.maxValue">
  <tr>
    <td align="right"><spring:message code="jsp.editDataTypeForm.maxValue"/>&nbsp;</td>
    <td>
		<c:choose>
			<c:when test="${dataType.dataType.type == 3}">
				<js:calendarInput name="${status.expression}" value="${status.value}"
					formatPattern="${requestScope.calendarDatePattern}"
					time="false"
					imageTipMessage="jsp.defaultParametersForm.pickDate"/>
			</c:when>
			<c:when test="${dataType.dataType.type == 4}">
				<js:calendarInput name="${status.expression}" value="${status.value}"
					formatPattern="${requestScope.calendarDatetimePattern}"
					imageTipMessage="jsp.defaultParametersForm.pickDate"/>
			</c:when>
			<c:otherwise>
				<input type="text" name="${status.expression}" value="${status.value}" size="40" class="fnormal"/>
			</c:otherwise>
		</c:choose>
	</td>
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
</c:otherwise>
</c:choose>

<spring:bind path="dataType.dataType.strictMax">
  <tr>
    <td align="right"><spring:message code="jsp.editDataTypeForm.strictMax"/>&nbsp;</td>
    <td>
		<input name="_${status.expression}" type="hidden"/>
  <c:if test="${status.value}">
      <input type="checkbox" name="${status.expression}" checked class="fnormal"/>
  </c:if>
  <c:if test="${!status.value}">
      <input type="checkbox" name="${status.expression}" class="fnormal"/>
  </c:if>
    </td>
  </tr>
</spring:bind>

  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
     <c:if test='${masterFlow == "reportUnit"}'>
      <input type="submit" name="_eventId_cancel" value='<spring:message code="button.cancel"/>' class="fnormal" />   
      <input type="submit" name="_eventId_back" value='<spring:message code="button.back"/>' class="fnormal"/>
     </c:if>
          
     <c:if test='${masterFlow != "reportUnit"}'>
      <input type="button" name="_eventId_cancel" value='<spring:message code="button.cancel"/>' class="fnormal" OnClick='javascript:window.location.href="flow.html?_flowId=repositoryExplorerFlow&showFolder=<%=request.getParameter("ParentFolderUri")%>"'/>	  
      <input type="button" name="_eventId_back" value='<spring:message code="button.back"/>' class="fnormal" OnClick='javascript:window.location.href="flow.html?_flowId=repositoryExplorerFlow&showFolder=<%=request.getParameter("ParentFolderUri")%>"'/>	  
     </c:if>     
	  <input type="submit" name="_eventId_save" value='<spring:message code="button.save"/>' class="fnormal"/>&nbsp;
    </td>
  </tr>
</table>

    </td>
  </tr>
</table>
</form>

</body>

</html>
