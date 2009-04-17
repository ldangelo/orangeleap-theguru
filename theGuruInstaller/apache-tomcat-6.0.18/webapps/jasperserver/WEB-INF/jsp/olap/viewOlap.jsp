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
<%@ page session="true" contentType="text/html" %>
<%@ taglib uri="http://www.tonbeller.com/jpivot" prefix="jp" %>
<%@ taglib uri="http://www.tonbeller.com/wcf" prefix="wcf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/jasperserver.tld" prefix="js" %>
<%@ taglib uri="/spring" prefix="spring" %>
<%@ page errorPage="error.jsp" %>
<%--

  JPivot / WCF comes with its own "expression language", which simply
  is a path of properties. E.g. #{customer.address.name} is
  translated into:
    session.getAttribute("customer").getAddress().getName()
  WCF uses jakarta commons beanutils to do so, for an exact syntax
  see its documentation.

  With JSP 2.0 you should use <code>#{}</code> notation to define
  expressions for WCF attributes and <code>\${}</code> to define
  JSP EL expressions.

  No longer true? We have rtexprvalue = true on JPivot tags now
  
    JSP EL expressions can not be used with WCF tags currently, all
    tag attributes have their <code>rtexprvalue</code> set to false.
    There may be a twin library supporting JSP EL expressions in
    the future (similar to the twin libraries in JSTL, e.g. core
    and core_rt).

  Check out the WCF distribution which contains many examples on
  how to use the WCF tags (like tree, form, table etc).

--%>

<html>
<head>
  <title><spring:message code="jsp.viewOlap.title"/></title>
  <meta http-equiv="Content-Type" content="text/html; charset=${requestScope['com.jaspersoft.ji.characterEncoding']}">
</head>

<body bgcolor=white>

<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr>
    <td>

<form action="<c:url value="viewOlap.html"/>" method="post">

<%-- Needed for navigator --%>
<wcf:renderParam name="linkParameters" value="name=${requestScope.name}"/>


<input type="hidden" name="name" value="${requestScope.name}"/>
<input type="hidden" name="ParentFolderUri" value="<%=request.getParameter("ParentFolderUri")%>"/>
<c:if test="${olapModel == null}">
  <jsp:forward page="empty.jsp"/>
</c:if>

<%-- define table, navigator and forms --%>
<jp:table id="${requestScope.name}/table" query="#{olapModel}"/>
<jp:navigator id="${requestScope.name}/navi" query="#{olapModel}" visible="false"/>
<wcf:form id="${requestScope.name}/mdxedit" xmlUri="/WEB-INF/jpivot/table/mdxedit.xml" model="#{olapModel}" visible="false"/>
<wcf:form id="${requestScope.name}/sortform" xmlUri="/WEB-INF/jpivot/table/sortform.xml" model="#(${requestScope.name}/table)" visible="false"/>

<jp:print id="${requestScope.name}/print"/>
<wcf:form id="${requestScope.name}/printform" xmlUri="/WEB-INF/jpivot/print/printpropertiesform.xml" model="#(${requestScope.name}/print)" visible="false"/>

<jp:chart id="${requestScope.name}/chart" query="#{olapModel}" visible="false"/>
<wcf:form id="${requestScope.name}/chartform" xmlUri="/WEB-INF/jpivot/chart/chartpropertiesform.xml" model="#(${requestScope.name}/chart)" visible="false"/>

<%-- for the drillthrough model, this needs to be named XXX.drilthroughtable --%>
<wcf:table id="${requestScope.name}.drillthroughtable" visible="false" selmode="none" editable="true"/>

<c:if test="${olapSession.olapUnit != null}">
	<h2><c:out value="${olapSession.olapUnit.label}"/></h2>
</c:if>

<%-- define a toolbar --%>
<wcf:toolbar id="${requestScope.name}/toolbar" bundle="com.tonbeller.jpivot.toolbar.resources">
  <wcf:scriptbutton id="cubeNaviButton" tooltip="jsp.jpivot.toolb.cube" img="cube" model="#(${requestScope.name}/navi.visible)"/>
  <wcf:scriptbutton id="mdxEditButton" tooltip="jsp.jpivot.toolb.mdx.edit" img="mdx-edit" model="#(${requestScope.name}/mdxedit.visible)"/>
  <wcf:scriptbutton id="sortConfigButton" tooltip="jsp.jpivot.toolb.table.config" img="sort-asc" model="#(${requestScope.name}/sortform.visible)"/>
  <wcf:separator/>
  <wcf:scriptbutton id="levelStyle" tooltip="jsp.jpivot.toolb.level.style" img="level-style" model="#(${requestScope.name}/table.extensions.axisStyle.levelStyle)"/>
  <wcf:scriptbutton id="hideSpans" tooltip="jsp.jpivot.toolb.hide.spans" img="hide-spans" model="#(${requestScope.name}/table.extensions.axisStyle.hideSpans)"/>
  <wcf:scriptbutton id="propertiesButton" tooltip="jsp.jpivot.toolb.properties"  img="properties" model="#(${requestScope.name}/table.rowAxisBuilder.axisConfig.propertyConfig.showProperties)"/>
  <wcf:scriptbutton id="nonEmpty" tooltip="jsp.jpivot.toolb.non.empty" img="non-empty" model="#(${requestScope.name}/table.extensions.nonEmpty.buttonPressed)"/>
  <wcf:scriptbutton id="swapAxes" tooltip="jsp.jpivot.toolb.swap.axes"  img="swap-axes" model="#(${requestScope.name}/table.extensions.swapAxes.buttonPressed)"/>
  <wcf:separator/>
  <wcf:scriptbutton id="drillMember" model="#(${requestScope.name}/table.extensions.drillMember.enabled)" tooltip="jsp.jpivot.toolb.navi.member" radioGroup="navi" img="navi-member"/>
  <wcf:scriptbutton id="drillPosition" model="#(${requestScope.name}/table.extensions.drillPosition.enabled)" tooltip="jsp.jpivot.toolb.navi.position" radioGroup="navi" img="navi-position"/>
  <wcf:scriptbutton id="drillReplace" model="#(${requestScope.name}/table.extensions.drillReplace.enabled)"	 tooltip="jsp.jpivot.toolb.navi.replace" radioGroup="navi" img="navi-replace"/>
  <wcf:scriptbutton id="drillThrough"  model="#(${requestScope.name}/table.extensions.drillThrough.enabled)"  tooltip="jsp.jpivot.toolb.navi.drillthru" img="navi-through"/>
  <wcf:separator/>
  <wcf:scriptbutton id="chartButton" tooltip="jsp.jpivot.toolb.chart" img="chart" model="#(${requestScope.name}/chart.visible)"/>
  <wcf:scriptbutton id="chartPropertiesButton" tooltip="jsp.jpivot.toolb.chart.config" img="chart-config" model="#(${requestScope.name}/chartform.visible)"/>
  <wcf:separator/>
  <wcf:scriptbutton id="printPropertiesButton" tooltip="jsp.jpivot.toolb.print.config" img="print-config" model="#(${requestScope.name}/printform.visible)"/>
  <c:url var="pdfPrintURI" value="./Print"><c:param name="view" value="${requestScope.name}"/><c:param name="type" value="PDF"/></c:url>
  <wcf:imgbutton id="printpdf" tooltip="jsp.jpivot.toolb.print" img="print" href="${pdfPrintURI}"/>
  <c:remove var="pdfPrintURI"/>
  <c:url var="xlsPrintURI" value="./Print"><c:param name="view" value="${requestScope.name}"/><c:param name="type" value="XLS"/></c:url>
  <wcf:imgbutton id="printxls" tooltip="jsp.jpivot.toolb.excel" img="excel" href="${xlsPrintURI}"/>
  <c:remove var="xlsPrintURI"/>
</wcf:toolbar>

<%-- render toolbar --%>
<wcf:render ref="${requestScope.name}/toolbar" xslUri="/WEB-INF/jpivot/toolbar/htoolbar.xsl" xslCache="true"/>
<p>

<%-- if there was an overflow, show error message --%>
<c:if test="${requestScope.olapModel.result.overflowOccured}">
  <p>
  <strong style="color:red"><spring:message code="jsp.viewOlap.overflow"/></strong>
  <p>
</c:if>

<c:set var="naviVarName" value="${requestScope.name}/navi"/>

<%-- olap navigator --%>
<c:if test="${sessionScope[naviVarName].visible}">
	<h3><spring:message code="jsp.viewOlap.navigator"/></h3>
	<wcf:render ref="${requestScope.name}/navi" xslUri="/WEB-INF/jpivot/navi/js-navigator.xsl" xslCache="true"/>
</c:if>

<c:set var="mdxeditVarName" value="${requestScope.name}/mdxedit"/>

<%-- edit mdx --%>
<c:if test="${sessionScope[mdxeditVarName].visible}">
  <h3><spring:message code="jsp.viewOlap.mdx"/></h3>
  <wcf:render ref="${requestScope.name}/mdxedit" xslUri="/WEB-INF/wcf/wcf.xsl" xslCache="true"/>
</c:if>

<c:set var="sortVarName" value="${requestScope.name}/sortform"/>

<%-- sort properties --%>
<c:if test="${sessionScope[sortVarName].visible}">
	<h3><spring:message code="jsp.viewOlap.sortform"/></h3>
	<wcf:render ref="${requestScope.name}/sortform" xslUri="/WEB-INF/wcf/wcf.xsl" xslCache="true"/>
</c:if>

<c:set var="chartVarName" value="${requestScope.name}/chartform"/>

<%-- chart properties --%>
<c:if test="${sessionScope[chartVarName].visible}">
	<h3><spring:message code="jsp.viewOlap.chartform"/></h3>
	<wcf:render ref="${requestScope.name}/chartform" xslUri="/WEB-INF/wcf/wcf.xsl" xslCache="true"/>
</c:if>

<c:set var="printVarName" value="${requestScope.name}/printform"/>

<%-- print properties --%>
<c:if test="${sessionScope[printVarName].visible}">
	<h3><spring:message code="jsp.viewOlap.printform"/></h3>
	<wcf:render ref="${requestScope.name}/printform" xslUri="/WEB-INF/wcf/wcf.xsl" xslCache="true"/>
</c:if>

<c:set var="chartVarName" value="${requestScope.name}/chart"/>

<%-- render chart --%>
<c:if test="${sessionScope[chartVarName].visible}">
	<h3><spring:message code="jsp.viewOlap.chart"/></h3>
	<wcf:render ref="${requestScope.name}/chart" xslUri="/WEB-INF/jpivot/chart/chart.xsl" xslCache="true"/>
</c:if>

<%-- render the table --%>
<p>
<wcf:render ref="${requestScope.name}/table" xslUri="/WEB-INF/jpivot/table/mdxtable.xsl" xslCache="true"/>
<p>
<spring:message code="jsp.viewOlap.slicer"/>:
<wcf:render ref="${requestScope.name}/table" xslUri="/WEB-INF/jpivot/table/mdxslicer.xsl" xslCache="true"/>

<p>
<%-- drill through table --%>
<wcf:render ref="${requestScope.name}.drillthroughtable" xslUri="/WEB-INF/wcf/wcf.xsl" xslCache="true"/>

<%-- <p> --%>
<%-- render chart; move above the navigation table --%>
<%-- <wcf:render ref="${requestScope.name}/chart" xslUri="/WEB-INF/jpivot/chart/chart.xsl" xslCache="true"/> --%>

<p>
<a href="<c:url value="/flow.html"><c:param name="_flowId" value="olapViewListFlow"/></c:url>"><spring:message code="jsp.viewOlap.backToOlap"/></a>
<br/>
<a href="<c:url value="/flow.html"><c:param name="_flowId" value="repositoryExplorerFlow"/>
                                   <c:param name="curlnk" value="2"/>
                                   <c:param name='showFolder' value='<%=request.getParameter("ParentFolderUri")%>'/>
         </c:url>"><spring:message code="jsp.viewOlap.backToRepo"/></a>
		</td>
	</tr>
</table>

</body>

</html>
