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

<table class="dialogcontent" width="100%" height="100%" onmousedown="dialogOnMouseDown(event);">
<tbody>
	<tr>
		<td colspan="2" style="text-align:right; vertical-align:top;">
			<img alt="<spring:message code="report.view.input.controls.dialog.image.tooltip.cancel"/>" src="${pageContext.request.contextPath}/images/x.gif"
				onclick="inputControlsDialogCancel();" onmousedown="cancelEventBubbling(event)"
				class="dialogImagebutton" style="padding:1px;" onmouseover="this.className='dialogImagebuttondown'" onmouseout="this.className='dialogImagebutton'"/>
		</td>
	</tr>
	<tr>
	 <td colspan='2' class="dialogTitle dialogcell" style="padding-top:0px;padding-bottom:4px;">
	 <spring:message code="jasper.report.view.hint.report.options"/>:
	 
<%
      if (request.getAttribute("reportUnitDisplayName") != null) {
         session.setAttribute("reportUnitDisplayName", (String)request.getAttribute("reportUnitDisplayName"));
      }
      out.println(session.getAttribute("reportUnitDisplayName"));
%>
	 </td>
	</tr>

	<tr>
		<td colspan="2" class="dialogcell">
			<table class="dialoginsetframe" width="100%" onmousedown="cancelEventBubbling(event)">
			<tbody>
				<tr>
					<td id="paramsFormContainer">
						<table border="0" cellpadding="20" cellspacing="0" width="100%">
						<tbody>
							<tr>
						    	<td align="center">
						    	<js:parametersForm reportName="${requestScope.reportUnit}" renderJsp="${requestScope.controlsDisplayForm}"/>
								</td>
							</tr>
						</tbody>
						</table>
					</td>
				</tr>
			</tbody>
			</table>
		</td>
	</tr>
	<tr>
		<td align="left" valign="middle" class="dialogcell" style="padding-top:8px;padding-bottom:12px;" nowrap="nowrap">
			<input type="button" onclick="inputControlsDialogReset();"
				onmouseover="this.className='insidebuttonhover'" onmouseout="this.className='insidebutton'" class="insidebutton" 
				value="<spring:message code="jasper.report.view.inputs.reset"/>"
				title="<spring:message code="jasper.report.view.inputs.reset.hint"/>"/>
			&nbsp;&nbsp;
	     </td>
		<td class="dialogcell" align="right" valign="middle" style="padding-top:8px;padding-bottom:12px;" nowrap="nowrap">
			<input type="button" onclick="submitInputValues();" value="<spring:message code="report.view.input.controls.dialog.button.ok"/>" onmouseover="this.className='insidebuttonhover'" onmouseout="this.className='insidebutton'" class="insidebutton"/>&nbsp;&nbsp;
			<input type="button" onclick="inputControlsDialogCancel();" value="<spring:message code="report.view.input.controls.dialog.button.cancel"/>" onmouseover="this.className='insidebuttonhover'" onmouseout="this.className='insidebutton'" class="insidebutton"/>&nbsp;&nbsp;
			<input type="button" onclick="applyInputValues();" value="<spring:message code="report.view.input.controls.dialog.button.apply"/>" onmouseover="this.className='insidebuttonhover'" onmouseout="this.className='insidebutton'" class="insidebutton"/>
		</td>
	</tr>
</tbody>
</table>
