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
<%@taglib uri="/WEB-INF/jasperserver.tld" prefix="js" %>

<html>
<head>
  <script language=JavaScript src="${pageContext.request.contextPath}/scripts/checkbox-utils.js"></script>
  <script language="JavaScript">
	  checkboxListInit('logEvents', 'frm', 'selectEventsAll', 'selectedIds', <%= ((java.util.Collection) pageContext.findAttribute("events")).size() %>, 0);
	  
  	function toRemoveEvents() {
  		var toRemove;
  		if (checkboxListAnySelected('logEvents')) {
  			toRemove = confirm('<spring:message code="remove.confirm.message" javaScriptEscape="true"/>');
  		} else {
  			toRemove = false;
  			alert('<spring:message code="remove.no.item.selected" javaScriptEscape="true"/>');
  		}
  		return toRemove;
  	}
  </script>
</head>

<body>

<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr>
    <td>

<span class="fsection"><spring:message code="jsp.eventList.header"/></span>
<br/>
<br/>
<form name="frm" action="" method="post">
  <input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
  <input type="hidden" name="eventId"/>
  <input type="submit" class="fnormal" name="_eventId_ViewEvent" id="viewEvent" value="view" style="visibility:hidden;"/>
  <input type="submit" class="fnormal" name="_eventId_changeEventsType" id="changeEventsType" value="view" style="visibility:hidden;"/>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
	  <td class="paddedcell" colspan="4">
		  <select name="showEvents" onchange="javascript:document.frm.changeEventsType.click();" class="fnormal">
			  <option value="showAll" <c:if test="${showEvents == 'showAll'}">selected</c:if>><spring:message code="jsp.eventList.showAll"/></option>
			  <option value="showUnread" <c:if test="${showEvents == 'showUnread'}">selected</c:if>><spring:message code="jsp.eventList.showUnread"/></option>
		  </select>
		  <br/><br/>
	  </td>
  </tr>
  <tr bgcolor="#c2c4b6" class="fheader">
    <!--<td width="1">&nbsp;</td>-->
	<td class="paddedcell" width="1%" nowrap>
		<input type="checkbox" name="selectEventsAll" class="fnormal" 
			onclick="checkboxListAllClicked('logEvents', this)" 
			title="<spring:message code="list.checkbox.select.all.hint"/>"/>
		</td>
	<td width="50%"><spring:message code="jsp.eventList.message"/></td>
    <td width="20%"><spring:message code="jsp.eventList.date"/></td>
    <td width="10%"><spring:message code="label.type"/></td>
    <td width="20%"><spring:message code="jsp.eventList.component"/></td>
    <!--<td width="1">&nbsp;</td>-->
  </tr>
<c:forEach items="${events}" var="event" varStatus="itStatus">
  <tr <c:if test="${itStatus.count % 2 == 0}">class="list_alternate"</c:if>>
    <!--<td width="1">&nbsp;</td>-->
	  <td class="paddedcell" nowrap><input type="checkbox" name="selectedIds" value="${event.id}" class="fnormal" onclick="checkboxListCheckboxClicked('logEvents', this)"/>&nbsp;&nbsp;</td>
	  <td>
		  <a href="javascript:document.frm.eventId.value='${event.id}';document.frm.viewEvent.click();"
			  <c:if test="${event.state == 2}">class="link_read"</c:if>
		  >
			  <spring:message code="${event.messageCode}"/>
		  </a>
	  </td>
	<td nowrap><js:formatDate value="${event.occurrenceDate}"/></td>
    <td nowrap><spring:message code="eventType.${event.type}.label"/></td>
	<td><spring:message code="event.component.${event.component}"/></td>
  </tr>
</c:forEach>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4">
			<input type="submit" class="fnormal" name="_eventId_delete" value="<spring:message code="button.remove"/>" onclick="return toRemoveEvents()"/>
			<input type="submit" class="fnormal" name="_eventId_markAsRead" value="<spring:message code="jsp.eventList.button.markAsRead"/>"/>
			<input type="submit" class="fnormal" name="_eventId_markAsUnread" value="<spring:message code="jsp.eventList.button.markAsUnread"/>"/>
		</td>
	</tr>
</table>
</form>

    </td>
  </tr>
</table>

</body>
</html>
