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

<%@ page isErrorPage="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="/spring" %>

<html>

<head>
  <title><spring:message code='jsp.flowRemoveError.title'/></title>
  <LINK href="/stylesheets/styles.css" type="text/css" rel="stylesheet">
  <LINK href="/stylesheets/base.css" type="text/css" rel="stylesheet">
  <meta name="pageHeading" content='<spring:message code="jsp.flowRemoveError.pageHeading"/>'/>
  <meta name="noMenu" content="true">
</head>

<body>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<form name="fmErrorPage" method="post">
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr><td align="center" class="ferror"><spring:message code='jsp.flowRemoveError.errorMsg1'/></td></tr>
<tr><td>&nbsp;</td></tr>
<c:forEach items="${requestScope.failedResources}" var="resource">
<tr><td align="center">${resource}</td></tr>
</c:forEach>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td width="100%" align="center">
<input type="submit" class="fnormal" name="_eventId_back" id="back" value="edit" style="visibility:hidden;"/>
<a href="javascript:document.fmErrorPage.back.click()"/><spring:message code='jsp.flowError.errorMsg2'/></a>
</td></tr>


</table>
</form>

</body>

</html>


