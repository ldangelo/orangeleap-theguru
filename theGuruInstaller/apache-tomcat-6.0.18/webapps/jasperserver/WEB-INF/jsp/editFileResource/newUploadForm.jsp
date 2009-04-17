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
<title>Upload Resource</title>
<meta name="pageHeading" content="EDIT RESOURCE"/>
<script>
function jumpTo(pageTo){
    document.forms[0].jumpToPage.value=pageTo;
    document.forms[0].jumpButton.click();
}
</script>
</head>
<body bgColor="#f9f8f2" topmargin="0" leftmargin="0">
<FORM name="fmCRPopJrxml_1" action="" method="post" method="post" enctype="multipart/form-data">       
    <table cols="4" width="100%" align="center" valign="top" border="0" height="50%">
        <tr>
            <td width="15%">&nbsp;</td>
            <td width="20%">&nbsp;</td>
            <td width="35%">&nbsp;</td>
            <td width="15%">&nbsp;</td>
        </tr> 
        <tr>
            <td align="right" colspan="4">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="4" align="center"><strong>Upload Resource File: ${resource.name}</strong></td>
        </tr>
        <tr>
            <td colspan="4">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="4">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="4" align="center"><strong>Upload a new file to overwrite the exising resource</strong></td>
        </tr>
        <tr>
                    <td colspan="4">&nbsp;</td>
        </tr>
        <tr><spring:bind path="resource.data">
            <td width="15%">&nbsp;</td>
            <td width="20%" align="right"><b>&nbsp;File:&nbsp;</b></td>
            <td width="35%" align="left">&nbsp;<input type="file" name="${status.expression}" value="<c:url value='${status.value}'/>" size="30" class="fnormal"/><c:if test="${status.error}"><BR><span class="ferror">${status.errorMessage}</span></c:if></td>
            <td width="15%">&nbsp;</td></spring:bind>
        </tr>
        <tr>
            <td colspan="4">&nbsp;</td>
        </tr>
        <tr>
            <td width="15%">&nbsp;</td>
            <td width="20%" align="right">&nbsp;</td>
            <td width="35%" align="left">
            <input type="submit" class="fnormal" name="_eventId_Cancel" value="Cancel"/>&nbsp;
            <input name="_eventId_Next" value="Next" type="submit" class="fnormal">
            </td>
            <td width="15%">&nbsp;</td>
        </tr>           
    </table>
    <input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
    <input type="submit" class="fnormal" style="visibility:hidden;" value="" name="_eventId_Jump" id="jumpButton">
</FORM>
</body>
</html>

 