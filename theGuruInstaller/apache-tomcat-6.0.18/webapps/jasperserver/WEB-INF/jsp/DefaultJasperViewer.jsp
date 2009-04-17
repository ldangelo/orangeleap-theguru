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

<%--
Default rendering HTML fragment for a JR report called from the JasperViewerTag.

 Expects attributes:
    pageIndex:          Integer         Current page in report
    lastPageIndex:      Integer         Greatest page number in report
    page:               String          URL for surrounding page
    exporter:           JRHtmlExporter  The wrapped JasperPrint
    pageIndexParameter:     String      parameter name in URL for paging    
--%>

<%@ taglib prefix="spring" uri="/spring" %>
<%@page import="net.sf.jasperreports.engine.export.*" %>
<%@page import="net.sf.jasperreports.engine.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/WEB-INF/jasperserver.tld" prefix="js" %>
<%@page errorPage="/WEB-INF/jsp/JSErrorPage.jsp" %>

<div id="parentFolder" style='display:none'><%=request.getParameter("ParentFolderUri")%></div>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr>
    <td colspan="3">
      <table width="100%" cellpadding="0" cellspacing="4" border="0">
        <tr valign='top'>
            <td width="35%" align="left">
            <table cellpadding="0" cellspacing="0" border="0">
              <tr valign='top'>
<c:if test="${hasInputControls and (reportControlsLayout == 1 or reportControlsLayout == 2)}">
	      <td width="1" valign="top">
		      <a
		      	<c:choose>
		      		<c:when test="${reportControlsLayout == 2}">
		      	href="javascript:backToInputControlsPage();"
		      		</c:when>
		      		<c:when test="${reportControlsLayout == 1}">
		      	href="javascript:showInputControlsDialog();" 
		      		</c:when>
		      	</c:choose>
	      		title="<spring:message code="jasper.report.view.hint.report.options"/>">
		      	<img border="0" src="${pageContext.request.contextPath}/images/report_options.gif" alt="<spring:message code="jasper.report.view.hint.report.options"/>"/>
		      </a>
	      </td>
		  <td width="1">
		  	&nbsp;&nbsp;
		  	<c:if test="${!showClose and !emptyReport}">&nbsp;</c:if>
		  </td>
</c:if>
<c:if test="${showClose}">
          <td width="1" valign="top">
		      <a href="javascript:closeViewReport(document.getElementById('parentFolder').innerHTML);" title="<spring:message code="jasper.report.view.hint.close"/>">
		      	<img border="0" src="${pageContext.request.contextPath}/images/return_to_repo.gif" alt="<spring:message code="jasper.report.view.hint.close"/>"/>
		      </a>
          </td>
		  <td width="1">
		  	&nbsp;&nbsp;
		  	<c:if test="${!emptyReport}">&nbsp;</c:if>
		  </td>
</c:if>
<c:if test="${(showClose || (hasInputControls && (reportControlsLayout == 1 || reportControlsLayout == 2))) and !emptyReport}">
		  <td width="1" style="border-left:1px solid #C0C0C0">&nbsp;&nbsp;</td>
</c:if>
<c:if test="${!emptyReport}">
		  <input type="hidden" name="output"/>
		  <c:forEach items="${configuredExporters}" var="configuredExporter">
	          <td width="1" valign="top"><a href="javascript:exportReport('${configuredExporter.key}')" title="<spring:message code='${configuredExporter.value.descriptionKey}'/>"><img src="${pageContext.request.contextPath}${configuredExporter.value.iconSrc}" border="0" alt="<spring:message code='${configuredExporter.value.descriptionKey}'/>"/></a></td>
	          <td width="1">&nbsp;&nbsp;</td>
          </c:forEach>
</c:if>
              </tr>
            </table>
          </td>
          <td width="30%" align="center">
<c:if test="${emptyReport}">
  <span style="font-size:14px; font-weight:bold">
 <%
      if (request.getAttribute("reportUnitDisplayName") != null) {
         session.setAttribute("reportUnitDisplayName", (String)request.getAttribute("reportUnitDisplayName"));
      }
      out.println("<BR>"+session.getAttribute("reportUnitDisplayName"));
%>    
  </span>  <br><br>       
            <span class="noDataMsg"><spring:message code="jasper.report.view.empty"/></span>
</c:if>
<c:if test="${!emptyReport and (lastPageIndex > 0 or configurationBean.paginationForSinglePageReport)}">
            <table cellpadding="0" cellspacing="0" border="0">
              <tr>
<c:choose>
  <c:when test="${pageIndex > 0}">
          <td width="1"><a href="javascript:navigateToReportPage(0);" title="<spring:message code="jasper.report.view.hint.first.page"/>"><img border="0" src="images/first.gif" alt="<spring:message code="jasper.report.view.hint.first.page"/>" class="imageborder" onMouseover="borderImage(this,'#C0C0C0')" onMouseout="borderImage(this,'white')"/></a></td>
          <td width="1"><a href="javascript:navigateToReportPage(${pageIndex-1});" title="<spring:message code="jasper.report.view.hint.previous.page"/>"><img border="0" src="images/prev.gif" alt="<spring:message code="jasper.report.view.hint.previous.page"/>" class="imageborder" onMouseover="borderImage(this,'#C0C0C0')" onMouseout="borderImage(this,'white')"/></a></td>
  </c:when>
  <c:otherwise>
          <td width="1"><img src="${pageContext.request.contextPath}/images/first-d.gif" alt="<spring:message code="jasper.report.view.hint.first.page"/>" class="imageborder"/></td>
          <td width="1"><img src="${pageContext.request.contextPath}/images/prev-d.gif" alt="<spring:message code="jasper.report.view.hint.previous.page"/>" class="imageborder"/></td>
  </c:otherwise>
</c:choose>
          <td align="center" nowrap="nowrap"><spring:message code="jasper.report.view.page" arguments='<%= new Object[]{new Integer(((Integer) request.getAttribute("pageIndex")).intValue() + 1), new Integer(((Integer) request.getAttribute("lastPageIndex")).intValue() + 1)} %>'/></td>
<c:choose>
  <c:when test="${pageIndex < lastPageIndex}">
          <td width="1"><a href="javascript:navigateToReportPage(${pageIndex+1});" title="<spring:message code="jasper.report.view.hint.next.page"/>"><img border="0" src="images/next.gif" alt="<spring:message code="jasper.report.view.hint.next.page"/>" class="imageborder" onMouseover="borderImage(this,'#C0C0C0')" onMouseout="borderImage(this,'white')"/></a></td>
          <td width="1"><a href="javascript:navigateToReportPage(${lastPageIndex});" title="<spring:message code="jasper.report.view.hint.last.page"/>"><img border="0" src="images/last.gif" alt="<spring:message code="jasper.report.view.hint.last.page"/>" class="imageborder" onMouseover="borderImage(this,'#C0C0C0')" onMouseout="borderImage(this,'white')"/></a></td>
  </c:when>
  <c:otherwise>
          <td width="1"><img src="${pageContext.request.contextPath}/images/next-d.gif" alt="<spring:message code="jasper.report.view.hint.next.page"/>" class="imageborder"/></td>
          <td width="1"><img src="${pageContext.request.contextPath}/images/last-d.gif" alt="<spring:message code="jasper.report.view.hint.last.page"/>" class="imageborder"/></td>
  </c:otherwise>
</c:choose>
              </tr>
            </table>
</c:if>
          </td>
          <td width="35%" align="right" valign="top" nowrap="nowrap">
<c:choose>
	<c:when test="${hasInputControls && reportControlsLayout == 3}">
		<a href="#" onclick="toggleTopControlsPanel();" class="formlink">
		<c:choose>
			<c:when test="${inputControlsHidden}">
				<c:set var="showDisplayStyle" value="inline"/>
				<c:set var="hideDisplayStyle" value="none"/>
			</c:when>
			<c:otherwise>
				<c:set var="showDisplayStyle" value="none"/>
				<c:set var="hideDisplayStyle" value="inline"/>
			</c:otherwise>
		</c:choose>
			<img id="topControlsShowImg" src="${pageContext.request.contextPath}/images/arrow_down.gif" border="0" style="display:${showDisplayStyle};"/>
			<span id="topControlsShowSpan" style="display:${showDisplayStyle};"><spring:message code="jasper.report.view.show.top.controls"/></span>
			<img id="topControlsHideImg" src="${pageContext.request.contextPath}/images/arrow_up.gif" border="0" style="display:${hideDisplayStyle};"/>
			<span id="topControlsHideSpan" style="display:${hideDisplayStyle};"><spring:message code="jasper.report.view.hide.top.controls"/></span>
		</a>
	</c:when>
	<c:otherwise>
		&nbsp;
	</c:otherwise>
</c:choose>
          &nbsp;
          </td>
        </tr>
      </table>
    </td>
  </tr>                                                                                                         
<c:if test="${!emptyReport}">
  <tr>
    <td width="50%">&nbsp;</td>
    <td>
		<jsp:useBean id="exporter" type="JRHtmlExporter" scope="request"/>
<%
  exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, out);
  exporter.exportReport();
%>
    </td>
    <td width="50%">&nbsp;</td>
  </tr>
</c:if>
</table>
</td></tr>
</table>