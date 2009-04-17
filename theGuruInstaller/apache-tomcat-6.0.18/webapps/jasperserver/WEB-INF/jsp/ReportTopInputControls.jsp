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

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/jasperserver.tld" prefix="js" %>
<%@ taglib uri="/spring" prefix="spring" %>
<%@ page errorPage="/WEB-INF/jsp/JSErrorPage.jsp" %>

<c:set var="hasErrors" value="false"/>
<c:forEach items="${requestScope.wrappers}" var="wrapper">
	<c:if test="${not empty wrapper.errorMessage}">
		<c:set var="hasErrors" value="true"/>
	</c:if>
</c:forEach>
<input type="hidden" id="_inputValuesErrors" value="${hasErrors}"/>
<c:remove var="hasErrors"/>

<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>

<table width="100%" cellpadding="3" cellspacing="0" border="0">
	<tr class="formcontent">
		<td align="center">
			<js:parametersForm reportName="${requestScope.reportUnit}" renderJsp="ReportTopParametersForm.jsp"/>
		</td>
	</tr>
	<tr class="formheader">
		<td align="center">
			<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td align="left" valign="middle" nowrap="nowrap">
						<input type="button" onclick="inputControlsDialogReset();"
							value="<spring:message code="jasper.report.view.top.inputs.reset"/>"
							title="<spring:message code="jasper.report.view.inputs.reset.hint"/>"
							class="formheaderbutton" onmouseover="this.className='formheaderbuttonhover'" onmouseout="this.className='formheaderbutton'"/>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td align="right" valign="middle" nowrap="nowrap">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" onclick="submitTopInputValues();" 
							value="<spring:message code="jasper.report.view.top.inputs.run.report"/>" 
							class="formheaderbutton" onmouseover="this.className='formheaderbuttonhover'" onmouseout="this.className='formheaderbutton'"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
