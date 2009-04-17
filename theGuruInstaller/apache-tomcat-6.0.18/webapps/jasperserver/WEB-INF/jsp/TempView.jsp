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

<html>
<head>
  <title><spring:message code='jsp.TempView.title'/></title>
  <meta name="pageHeading" content="<spring:message code='jsp.TempView.pageHeading'/>"/>
  </head>

<body>

<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr>
    <td>

<span class="fsection"><spring:message code='jsp.TempView.section'/></span>
<br/>
<br/>
<form name="fmLstRpts" method="post" action="">
<table border="0" width="100%" cellpadding="0" cellspacing="0">
	<input type="submit" name="_eventId_selectOlapView" id="selectOlapView" value="" style="visibility:hidden;"/>
	<input type="hidden" name="olapUnit"/>
	<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
  <tr bgcolor="#c2c4b6" class="fheader">
    <td width="1">&nbsp;</td>
    <td width="20%"><spring:message code='jsp.TempView.view_name'/></td>
    <td width="30%"><spring:message code='jsp.TempView.label'/></td>
    <td width="40%"><spring:message code='jsp.TempView.description'/></td>
    <td width="10%"><spring:message code='jsp.TempView.date'/></td>
  </tr>
<c:forEach var="olapUnit" items="${requestScope.olapUnits}">
  <tr>
    <td width="1">&nbsp;</td>
	<td><a href="javascript:document.fmLstRpts.olapUnit.value='${olapUnit.URIString}';document.fmLstRpts.selectOlapView.click();"><c:out value="${olapUnit.name}"/></a></td>
    <td><c:out value="${olapUnit.label}"/></td>
    <td><c:out value="${olapUnit.description}"/></td>
    <td nowrap><spring:message code="repository.browser.creation.date" arguments="${olapUnit.creationDate}"/></td>
  </tr>
</c:forEach>
</table>
</form>

    </td>
  </tr>
</table>

</body>

</html>
