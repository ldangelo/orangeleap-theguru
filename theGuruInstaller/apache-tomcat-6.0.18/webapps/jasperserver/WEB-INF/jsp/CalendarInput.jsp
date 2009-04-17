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

<input type="text" name="${name}" id="${name}" value="${value}" class="fnormal" 
	onmousedown="cancelEventBubbling(event)" 
<c:if test="${not empty onchange}">onchange="${onchange}"</c:if>
<c:if test="${readOnly}">disabled="disabled"</c:if>
/>
<c:if test="${not readOnly}">
<img id="${name}Img" src="${imageSrc}"
	border="0" style="margin-top: 2px; vertical-align: top;"
<c:if test="${not empty imageTooltip}">alt="${imageTooltip}"</c:if>
/>
<script>
	Calendar.setup({
		inputField : "<c:out value="${name}"/>",
		ifFormat : "<c:out value="${pattern}"/>",
		button : "<c:out value="${name}Img"/>",
		showsTime : <c:out value="${hasTime}"/>,
		tzOffset : <c:out value="${timezoneOffset}"/>
	});
</script>
</c:if>				
