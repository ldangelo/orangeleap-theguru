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

<%@ page language="java" contentType="text/html" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<title><spring:message code="jsp.olapXmlaDefinition.title"/></title>
</head>

<body>


<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr>
    <td>

<FORM name="aqRsrRsrNm" action="" method="post">
    <table border="0" cellpadding="1" cellspacing="0" border="0" align="center">
        <tr><td colspan="2">&nbsp;</td></tr>
	    <spring:bind path="wrapper.fileResource.name">
	        <tr>
	        <td align="right">* <spring:message code="label.name"/>&nbsp;</td>
	        <td colspan="2"><input <c:if test="${wrapper.editMode || (wrapper.suggested && wrapper.subflowMode)}">readonly</c:if> name="${status.expression}" type="text" value="${status.value}" size="20" class="fnormal"><c:if test="${status.error}"><BR><span class="ferror">${status.errorMessage}</span></c:if></td>
	        </tr>
	    </spring:bind>
	    <spring:bind path="wrapper.fileResource.label">
	        <tr>
	        <td align="right">* <spring:message code="label.label"/>&nbsp;</td>
	        <td colspan="2"><input name="${status.expression}" type="text" class="fnormal" value="${status.value}" size="20"><c:if test="${status.error}"><BR><span class="ferror">${status.errorMessage}</span></c:if></td>
	        </tr>
	    </spring:bind>
	    <spring:bind path="wrapper.fileResource.description">
	        <tr>
	        <td align="right"><spring:message code="label.description"/>&nbsp;</td>
	        <td colspan="2"><input name="${status.expression}" type="text" class="fnormal" value="${status.value}" size="30"><c:if test="${status.error}"><BR><span class="ferror">${status.errorMessage}</span></c:if></td>
	        </tr>
	    </spring:bind>
        <tr><td align="right">* <spring:message code="jsp.olapXmlaDefinition.mondrianConnection"/>&nbsp;</td>
        <td colspan="2"><c:choose><c:when test="${wrapper.fileResource.fileType!=null}">${wrapper.allTypes[wrapper.fileResource.fileType]}</c:when>
        <c:otherwise>
        <spring:bind path="wrapper.fileResource.fileType">
        	<select name="${status.expression}" class="fnormal">
				<c:forEach items="${wrapper.allTypes}" var="type">
                	<option name="${type.key}">${type.value}</option>
	           </c:forEach>
    	    </select>      	
    	 </spring:bind>
        </c:otherwise></c:choose></td></tr>
        <tr><td colspan="2">&nbsp;</td></tr>
        <tr>
        <td>&nbsp;</td>
        <td>
        <input type="submit" class="fnormal" name="_eventId_Cancel" value="<spring:message code="button.cancel"/>"/>&nbsp;
        <input type="submit" class="fnormal" name="_eventId_Back" value="<spring:message code="button.back"/>">&nbsp;
        <c:choose>
            <c:when test='${wrapper.standAloneMode}'>
        		<input type="submit" class="fnormal" name="_eventId_Save" value="<spring:message code="button.save"/>">
            </c:when>
            <c:otherwise>
        		<input type="submit" class="fnormal" name="_eventId_Next" value="<spring:message code="button.next"/>">
            </c:otherwise>
        </c:choose></td>
        </tr>
    </table>

    <input type="hidden" name="jumpToPage">
    <input type="submit" class="fnormal" style="visibility:hidden;" value="" name="_eventId_Jump" id="jumpButton">
    <input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
</FORM>

    </td>
  </tr>
</table>

</body>

</html>
