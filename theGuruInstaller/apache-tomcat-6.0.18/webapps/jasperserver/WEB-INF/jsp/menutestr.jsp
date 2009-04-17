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

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/spring" prefix="spring"%>

<!-- this ugly page of jsp is for testing only -->

<c:forEach begin="0" end="${indent}">&nbsp;</c:forEach>
<spring:message code='jsp.menutestr.name'/> <spring:message code="${menu.name}"/><br/>
<c:forEach begin="0" end="${indent}">&nbsp;</c:forEach>
<spring:message code='jsp.menutestr.url'/> <c:out value="${menu.url}"/><spring:message code='jsp.menutestr.none'/><br/>
<c:forEach begin="0" end="${indent}">&nbsp;</c:forEach>
<spring:message code='jsp.menutestr.roles'/> <c:forEach var="role" items="${menu.roles}">
           <c:out value="${role}"/></c:forEach> <spring:message code='jsp.menutestr.right.brace'/><br/><br/>

<% com.jaspersoft.jasperserver.war.common.SiteMenu.MenuItem menu 
     = (com.jaspersoft.jasperserver.war.common.SiteMenu.MenuItem)
         request.getAttribute("menu");
   for (int i=0; i<menu.getSubItems().length; i++) {
     // i wish i could actually pass object params in jsp... ug.
     request.setAttribute("menu", menu.getSubItems()[i]);
     Object oldIndent = request.getAttribute("indent");
     request.setAttribute("indent", 
			  ((Integer)request.getAttribute("indent")).intValue()+4); 
%>
<jsp:include page="menutestr.jsp" flush="true"/>
<%   request.setAttribute("indent", oldIndent); } %>
<br/>

