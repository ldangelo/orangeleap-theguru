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

<%@ page
  contentType="text/html"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/spring" prefix="spring"%>

<html>
<head>
  <title><spring:message code="jsp.olap.properties.title"/></title>
</head>

<body>

<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr>
    <td>

<span class="fsection"><spring:message code="jsp.olap.properties.title"/></span>
<br/>
<br/>

<table border="0" width="100%" cellpadding="0" cellspacing="0">
  <tr bgcolor="#c2c4b6" class="fheader">
    <td class="paddedcell" width="30%"><spring:message code="jsp.olap.properties.property"/></td>
    <td class="paddedcell"><spring:message code="jsp.olap.properties.value"/></td>
  </tr>
  <tr>
    <td class="paddedcell"><b>JdbcDrivers</b></td>
    <td class="paddedcell"><%= mondrian.olap.MondrianProperties.instance().JdbcDrivers.get() %></td>
  </tr>
  <tr class="list_alternate">
    <td class="paddedcell"><b>drillThroughMaxRows</b></td>
    <td class="paddedcell"><%= mondrian.olap.MondrianProperties.instance().MaxRows.get() %></td>
  </tr>
  <tr>
    <td class="paddedcell"><b>DisableCaching</b></td>
    <td class="paddedcell"><%= mondrian.olap.MondrianProperties.instance().DisableCaching.get() %></td>
  </tr>
  <tr class="list_alternate">
    <td class="paddedcell"><b>TraceLevel</b></td>
    <td class="paddedcell"><%= mondrian.olap.MondrianProperties.instance().TraceLevel.get() %></td>
  </tr>
  <tr>
    <td class="paddedcell"><b>DebugOutFile</b></td>
    <td class="paddedcell"><%= mondrian.olap.MondrianProperties.instance().DebugOutFile.get() %></td>
  </tr>
  <tr class="list_alternate">
    <td class="paddedcell"><b>QueryLimit</b></td>
    <td class="paddedcell"><%= mondrian.olap.MondrianProperties.instance().QueryLimit.get() %></td>
  </tr>
  <tr>
    <td class="paddedcell"><b>ResultLimit</b></td>
    <td class="paddedcell"><%= mondrian.olap.MondrianProperties.instance().ResultLimit.get() %></td>
  </tr>
  <tr class="list_alternate">
    <td class="paddedcell"><b>LargeDimensionThreshold</b></td>
    <td class="paddedcell"><%= mondrian.olap.MondrianProperties.instance().LargeDimensionThreshold.get() %></td>
  </tr>
  <tr>
    <td class="paddedcell"><b>SparseSegmentDensityThreshold</b></td>
    <td class="paddedcell"><%= mondrian.olap.MondrianProperties.instance().SparseSegmentDensityThreshold.get() %></td>
  </tr>
  <tr class="list_alternate">
    <td class="paddedcell"><b>SparseSegmentCountThreshold</b></td>
    <td class="paddedcell"><%= mondrian.olap.MondrianProperties.instance().SparseSegmentCountThreshold.get() %></td>
  </tr>
  <tr>
    <td class="paddedcell"><b>UseAggregates</b></td>
    <td class="paddedcell"><%= mondrian.olap.MondrianProperties.instance().UseAggregates.get() %></td>
  </tr>
  <tr class="list_alternate">
    <td class="paddedcell"><b>ReadAggregates</b></td>
    <td class="paddedcell"><%= mondrian.olap.MondrianProperties.instance().ReadAggregates.get() %></td>
  </tr>
  <tr>
    <td class="paddedcell"><b>ChooseAggregateByVolume</b></td>
    <td class="paddedcell"><%= mondrian.olap.MondrianProperties.instance().ChooseAggregateByVolume.get() %></td>
  </tr>
</table>

    </td>
  </tr>
</table>

</body>

</html>

 
