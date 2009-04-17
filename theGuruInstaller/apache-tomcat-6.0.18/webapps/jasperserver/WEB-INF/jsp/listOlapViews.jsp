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
  <title><spring:message code='jsp.listOlapViews.title'/></title>
  <meta name="pageHeading" content="<spring:message code='jsp.listOlapViews.pageHeading'/>"/>
  </head>

<body>

<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr>
    <td>

<span class="fsection"><spring:message code='jsp.listOlapViews.section'/></span>
<br/>
<br/>
<form name="fmLstOlaps" method="post" action="">
<table border="0" width="100%" cellpadding="0" cellspacing="0">
	<!-- dummy inputs, to keep visual consistency with Reports -->
	<input type="submit" name="_eventId_selectOlapView" id="selectOlapView" value="" style="visibility:hidden;"/>
	<input type="hidden" name="olapUnit"/>
	<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
  <tr bgcolor="#c2c4b6" class="fheader">
    <td class="paddedcell" width="20%"><spring:message code='jsp.listOlapViews.olap_view_name'/></td>
    <td class="paddedcell" width="40%"><spring:message code='jsp.listOlapViews.description'/></td>
    <td class="paddedcell" width="10%"><spring:message code='jsp.listOlapViews.date'/></td>
    <td class="paddedcell" width="10%"><spring:message code='RM_CREATE_FOLDER_PARENT_FOLDER'/></td>
  </tr>
<js:paginator items="${olapUnits}" page="${currentPage}">
<c:forEach var="olapUnit" items="${paginatedItems}" varStatus="itStatus">
  <tr height="18" <c:if test="${itStatus.count % 2 == 0}">class="list_alternate"</c:if>>
    <td><a href="javascript:disableLink('<c:url value="/olap/viewOlap.html"><c:param name="name" value="${olapUnit.URIString}"/><c:param name="new" value="true"/></c:url>');" class="disLink" onclick="this.disabled='true'">
		<c:out value="${olapUnit.label}"/></a></td>
    <td class="paddedcell"><c:out value="${olapUnit.description}"/></td>
    <td class="paddedcell" nowrap><js:formatDate value="${olapUnit.creationDate}"/></td>
    <td class="paddedcell" nowrap>   
     <a href="flow.html?_flowId=repositoryExplorerFlow&curlnk=2&showFolder=${olapUnit.parentFolder}">
      <c:out value="${olapUnit.parentFolder}"/>
     </a> 
    </td>
  </tr>
</c:forEach>
	<tr>
		<td class="paddedcell" colspan="4">
			<js:paginatorLinks/>
		</td>
	</tr>
</js:paginator>
</table>
</form>

    </td>
  </tr>
</table>

<script type="text/javascript"> 
function disableLink(url) { 
	//document.write("<style type='text/css'>.disLink{display:none;}</style>"); 
	location.href = url; 
} 
// -->
</script> 
</body>

</html>
