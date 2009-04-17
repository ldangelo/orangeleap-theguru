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

<c:choose>
	<c:when test="${empty control.controlInfo.promptLabel}">
		<c:set var="controlLabel" value="${control.inputControl.label}"/>
	</c:when>
	<c:otherwise>
		<c:set var="controlLabel" value="${control.controlInfo.promptLabel}"/>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${control.inputControl.mandatory
			and (control.inputControl.type == 2
				or control.inputControl.type == 6
				or control.inputControl.type == 7
				or control.inputControl.type == 8
				or control.inputControl.type == 9
				or control.inputControl.type == 10
				or control.inputControl.type == 11
				)}">
		<spring:message code="jsp.defaultParametersForm.star.input.label" arguments="${controlLabel}"/>
	</c:when>
	<c:otherwise>
		<c:out value="${controlLabel}"/>
	</c:otherwise>
</c:choose>
