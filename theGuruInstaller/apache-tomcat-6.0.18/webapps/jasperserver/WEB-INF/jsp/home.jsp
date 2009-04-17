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
<%@ taglib prefix="spring" uri="/spring" %>
<html>
<head>
  <title><spring:message code='jsp.home.title'/></title>
  <meta name="pageHeading" content="HOME PAGE">
</head>

<body>

<form name="fmHome" action="" method="GET">
<table cellpadding="20" cellspacing="0" width="100%" border="0">
  <tr>
    <td>
      <br/>
      <br/>
      <b><spring:message code='jsp.home.content_title'/></b><spring:message code='jsp.home.summary'/>
      <br>
      <br>
      <b><spring:message code='jsp.home.detail1'/></b> <br>
      <spring:message code='jsp.home.detail2'/><br>
      <spring:message code='jsp.home.detail3'/><br>
      <spring:message code='jsp.home.detail4'/><br>
      <spring:message code='jsp.home.detail5'/><br>
      <spring:message code='jsp.home.detail6'/>
      <input type="hidden" name="topage" value="">
    </td>
  </tr>
</table>
</form>

</body>
</html>
