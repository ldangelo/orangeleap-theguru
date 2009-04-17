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

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/spring" prefix="spring" %>

<script language="JavaScript">
	function showHeartbeatDialog()
	{
		var heartbeatDiv = document.getElementById("heartbeatDiv");
    	heartbeatDiv.style.display = "block";
		centerLayer(heartbeatDiv);
		pushOverlayObject("mainTable", "hazeLayer", 92);
		focusOn("heartbeatOK");
	}
	
	function heartbeatDialogSubmit()
	{
		popOverlayObject();
		document.getElementById("heartbeatDiv").style.display = "none";
		var permitted = document.getElementById("heartbeatCheck").checked;
		var heartbeatURL = "<c:out value="${pageContext.request.contextPath}"/>/heartbeat.html?permit=" + permitted;
		ajaxNonReturningUpdate(heartbeatURL, null, null, null, baseErrorHandler);
	}
</script>

<div id="heartbeatDiv" style="height: 110px; width: 430px;position: absolute; display: none; z-index: 199; -moz-user-select: none; cursor: default; left: 330px; top: 180px;">
<table cellspacing="0" cellpadding="0" border="0" class="dialogtable" style="height: 100px; width: 430px; vertical-align: top;">
 <tbody><tr><td>
  <table style="height: 100%; width: 100%;" class="dialogcontent" cellpadding=3 cellspacing=0>
   <tbody><tr>
    <td nowrap="nowrap" align="center" style="padding-bottom: 5px; padding-top: 15px;" class="dialogcell">
     <input type="checkbox" id="heartbeatCheck" style="vertical-align:middle;" checked="true" >
     <label for="heartbeatCheck" style="vertical-align:middle;"><spring:message code="heartbeat.optin.label"/></label>
     <br/><br style="line-height:40%;"/>
    </td>
   </tr>
   <tr>
    <td  class="dialogcell" style="line-height:135%;padding-left:20px;">
     <spring:message code="heartbeat.optin.message" htmlEscape="false"/>
    </td>
   </tr>
   <tr>
    <td nowrap="nowrap" align="center" style="padding-bottom: 8px; padding-top: 15px;" class="dialogcell">
     <input type="button" id="heartbeatOK"  value="<spring:message code="button.ok"/>" 
     	class="insidebutton" onmouseover="this.className='insidebuttonhover'" onmouseout="this.className='insidebutton'"
     	onclick="heartbeatDialogSubmit()"/>
    </td>
   </tr>
  </tbody></table>
 </td></tr>
</tbody></table>
</div>

<script language="JavaScript">
	showHeartbeatDialog();
</script>
