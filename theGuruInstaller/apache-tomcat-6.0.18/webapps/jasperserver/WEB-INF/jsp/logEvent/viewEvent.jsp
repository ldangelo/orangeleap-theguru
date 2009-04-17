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
  <title><spring:message code="jsp.viewEvent.title"/></title>
  <meta name="pageHeading" content="<spring:message code="jsp.viewEvent.title"/>"/>
</head>

<body>

<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr>
    <td>

<form name="frm" action="" method="post">
<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
<table border="0" cellpadding="1" cellspacing="0" align="center">
  <tr>
    <td>&nbsp;</td>
    <td><span class="fsection"><spring:message code="jsp.viewEvent.title"/></span></td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td align="right"><spring:message code="jsp.viewEvent.message"/>&nbsp;</td>
    <td><input type="text" size="40" value="<spring:message code='${event.messageCode}'/>" disabled="true" class="fnormal"/></td>
  </tr>
  <tr>
    <td align="right"><spring:message code="jsp.viewEvent.component"/>&nbsp;</td>
    <td><input type="text" size="40" value="<spring:message code="event.component.${event.component}"/>" disabled="true" class="fnormal"/></td>
  </tr>
  <tr>
    <td align="right"><spring:message code="jsp.viewEvent.occurenceDate"/>&nbsp;</td>
    <td><input type="text" size="40" value="${event.occurrenceDate}" disabled="true" class="fnormal"/></td>
  </tr>
  <tr>
    <td align="right"><spring:message code="label.user"/>&nbsp;</td>
    <td><input type="text" size="40" value="${event.username}" disabled="true" class="fnormal"/></td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td align="right" valign="top"><spring:message code="jsp.viewEvent.text"/>&nbsp;</td>
    <td><textarea rows="10" cols="75" readonly="true" class="fnormal"><c:out value="${event.text}"/></textarea></td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="_eventId_back" value="<spring:message code="button.back"/>" class="fnormal"/></td>
  </tr>
</table>
</form>

    </td>
  </tr>
</table>

</body>

</html>
