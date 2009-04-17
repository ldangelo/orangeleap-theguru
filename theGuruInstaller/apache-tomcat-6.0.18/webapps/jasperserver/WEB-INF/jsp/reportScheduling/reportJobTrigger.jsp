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

<%@page import="java.util.Set,java.util.List,java.util.TimeZone,
		com.jaspersoft.jasperserver.war.dto.ByteEnum,
		com.jaspersoft.jasperserver.war.dto.StringOption"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/spring" prefix="spring"%>
<%@taglib uri="/WEB-INF/jasperserver.tld" prefix="js" %>

<html>
<head>
  <script language=JavaScript src="${pageContext.request.contextPath}/scripts/checkbox-utils.js"></script>
  <script language="JavaScript">
<c:if test="${requestScope.triggerRecurrenceType == 3}">
<spring:bind path="job.trigger.months">
	  checkboxListInit('triggerMonths', 'fmEditJob', 'allMonths', '${status.expression}', 
		  <%= ((java.util.Collection) pageContext.findAttribute("allMonths")).size() %>, 
		  <%= status.getValue() == null ? 0 : ((Set) status.getValue()).size() %>);
</spring:bind>
</c:if>

var timezoneOffsets = new Array();
<c:forEach items="${requestScope.timeZones}" var="timeZone">
timezoneOffsets["<%=((StringOption) pageContext.getAttribute("timeZone")).getCode()%>"] = <%=TimeZone.getTimeZone(((StringOption) pageContext.getAttribute("timeZone")).getCode()).getOffset(System.currentTimeMillis())%>;
</c:forEach>

<spring:bind path="job.trigger.timezone">
	function selectedTimezoneOffset() {
		var tzSelect = document.fmEditJob['${status.expression}'];
		return timezoneOffsets[tzSelect.options[tzSelect.selectedIndex].value];
	}
</spring:bind>
  </script>
</head>

<body>

<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr>
    <td>

<form name="fmEditJob" method="post" action="">
	
<input type="submit" class="fnormal" name="_eventId_jobDetails" id="jobDetails" value="jobDetails" style="visibility:hidden;"/>
<input type="submit" class="fnormal" name="_eventId_jobTrigger" id="jobTrigger" value="jobTrigger" style="visibility:hidden;"/>
<input type="submit" class="fnormal" name="_eventId_jobParameters" id="jobParameters" value="jobParameters" style="visibility:hidden;"/>
<input type="submit" class="fnormal" name="_eventId_jobOutput" id="jobOutput" value="jobOutput" style="visibility:hidden;"/>
	
<input type="submit" class="fnormal" name="_eventId_noRecurrence" id="noRecurrence" value="noRecurrence" style="visibility:hidden;"/>
<input type="submit" class="fnormal" name="_eventId_simpleRecurrence" id="simpleRecurrence" value="simpleRecurrence" style="visibility:hidden;"/>
<input type="submit" class="fnormal" name="_eventId_calendarRecurrence" id="calendarRecurrence" value="calendarRecurrence" style="visibility:hidden;"/>

<table border="0" cellpadding="1" cellspacing="0" align="center">
<input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
  <tr>
    <td align="center">
      <a class="flow_navigation" href="javascript:document.fmEditJob.jobDetails.click();"><spring:message code="report.scheduling.job.edit.header"/></a>
      |
      <span class="flow_navigation_current"><spring:message code="report.scheduling.job.edit.trigger.header"/></span>
      |
<c:if test="${hasReportParameters}">
      <a class="flow_navigation" href="javascript:document.fmEditJob.jobParameters.click();"><spring:message code="report.scheduling.job.edit.parameters.header"/></a>
      |
</c:if>
      <a class="flow_navigation" href="javascript:document.fmEditJob.jobOutput.click();"><spring:message code="report.scheduling.job.edit.output.header"/></a>
	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
		
<spring:bind path="job.trigger.startType">
	<c:set var="startTypeName" value="${status.expression}"/>
</spring:bind>
		
<spring:bind path="job.trigger.startDate">
	<c:set var="startDateName" value="${status.expression}"/>
</spring:bind>

<table border="0" cellpadding="1" cellspacing="0" align="center">

<c:if test="${!(empty requestScope.timeZones)}">
<spring:bind path="job.trigger.timezone">
  <tr>
	<td align="right"><spring:message code="report.scheduling.job.edit.trigger.label.timezone"/></td>
    <td>&nbsp;</td>
	<td>
	  <select name="${status.expression}" class="fnormal">
  <c:forEach items="${requestScope.timeZones}" var="timeZone">
	    <option value="${timeZone.code}" <c:if test="${status.value == timeZone.code or (empty status.value and preferredTimezone == timeZone.code)}">selected</c:if>>
	    	<spring:message code="timezone.option"
	    		arguments='<%= new String[]{((StringOption) pageContext.getAttribute("timeZone")).getCode(), ((StringOption) pageContext.getAttribute("timeZone")).getDescription()} %>'/>
	    </option>
  </c:forEach>
	  </select>
    </td>
  </tr>
  <c:if test="${status.error}">
    <c:forEach items="${status.errorMessages}" var="error">
  <tr>
    <td colspan="2">&nbsp;</td>
	<td><span class="ferror"><c:out value="${error}"/></span></td>
  </tr>
    </c:forEach>
  </c:if>
</spring:bind>
</c:if>
	
  <tr>
	<td align="right" width="25%"><spring:message code="report.scheduling.job.edit.trigger.label.start"/></td>
    <td width="10px">&nbsp;</td>
	<td width="75%">
<spring:bind path="job.trigger.startType">
      <input type="radio" name="${status.expression}" value="1" class="fnormal" 
		  onclick="document.fmEditJob['${startDateName}'].value=''"
		  <c:if test="${status.value == 1}">checked</c:if>/>
      <spring:message code="report.scheduling.job.edit.trigger.start.immediately"/>
    </td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
	<td>
      <input type="radio" name="${status.expression}" value="2" class="fnormal" <c:if test="${status.value == 2}">checked</c:if>/>
</spring:bind>
<spring:bind path="job.trigger.startDate">
      <spring:message code="report.scheduling.job.edit.trigger.start.date.before"/>
      <js:calendarInput name="${status.expression}" value="${status.value}" imageTipMessage="report.scheduling.job.edit.trigger.date.picker"
      		onchange="document.fmEditJob['${startTypeName}'][1].checked=true"
      		timezoneOffset="selectedTimezoneOffset"/>
      <spring:message code="report.scheduling.job.edit.trigger.start.date.after"/>
</spring:bind>
    </td>
  </tr>
<spring:bind path="job.trigger.startType">
  <c:if test="${status.error}">
    <c:forEach items="${status.errorMessages}" var="error">
  <tr>
    <td colspan="2">&nbsp;</td>
	<td><span class="ferror"><c:out value="${error}"/></span></td>
  </tr>
    </c:forEach>
  </c:if>
</spring:bind>
<spring:bind path="job.trigger.startDate">
  <c:if test="${status.error}">
    <c:forEach items="${status.errorMessages}" var="error">
  <tr>
    <td colspan="2">&nbsp;</td>
	<td><span class="ferror"><c:out value="${error}"/></span></td>
  </tr>
    </c:forEach>
  </c:if>
</spring:bind>
		  
  <tr>
    <td colspan="3">&nbsp;</td>
  </tr>
		  
  <tr>
    <td colspan="3" align="center" nowrap="true">
      <table border="0" cellpadding="0" cellspacing="0">
	    <tr>
	      <td valign="middle">
	        <input type="radio" name="recurrenceType"
	          <c:if test="${requestScope.triggerRecurrenceType == 1}">checked</c:if>
	          onclick="document.fmEditJob._eventId_noRecurrence.click()"
	        />
	      </td>
	      <td valign="middle" nowrap="true">
	        <spring:message code="report.scheduling.job.edit.trigger.recurrence.type.none"/>
	      </td>
	      <td>
	        &nbsp;
	      </td>
	      <td valign="middle">
	        <input type="radio" name="recurrenceType"
	          <c:if test="${requestScope.triggerRecurrenceType == 2}">checked</c:if>
	          onclick="document.fmEditJob._eventId_simpleRecurrence.click()"
	        />
	      </td>
	      <td valign="middle" nowrap="true">
	        <spring:message code="report.scheduling.job.edit.trigger.recurrence.type.simple"/>
	      </td>
	      <td>
	        &nbsp;
	      </td>
	      <td valign="middle">
	        <input type="radio" name="recurrenceType"
	          <c:if test="${requestScope.triggerRecurrenceType == 3}">checked</c:if>
	          onclick="document.fmEditJob._eventId_calendarRecurrence.click()"
	        />
	      </td>
	      <td valign="middle" nowrap="true">
	        <spring:message code="report.scheduling.job.edit.trigger.recurrence.type.calendar"/>
	      </td>
	    </tr>
      </table>
	</td>
  </tr>
		  
  <tr>
    <td colspan="3">&nbsp;</td>
  </tr>
  
<c:if test="${requestScope.triggerRecurrenceType == 1}">

<spring:bind path="job.trigger.endDate">
  <input type="hidden" name="${status.expression}" id="${status.expression}" class="fnormal" value=""/>
</spring:bind>

</c:if>

<c:if test="${requestScope.triggerRecurrenceType == 2}">
		
<spring:bind path="job.trigger.occurrenceCount">
  <c:set var="occurrenceCountName" value="${status.expression}"/>
  <c:set var="occurrenceCountValue" value="${status.value}"/>
  <c:set var="occurrenceCountError" value="${status.error}"/>
  <input type="hidden" name="${status.expression}" value="${status.value}"/>
</spring:bind>
		
<spring:bind path="job.trigger.endDate">
  <c:set var="endDateName" value="${status.expression}"/>
  <c:set var="endDateValue" value="${status.value}"/>
</spring:bind>

<script language="JavaScript">
	function resetOccurrenceCount() {
		document.fmEditJob['${occurrenceCountName}'].value=-1;
		document.fmEditJob._maxOccurrences.value='';		
	}
	
	function resetEndDate() {
		document.fmEditJob['${endDateName}'].value='';
	}
	
	function selectIndefiniteRecurrence() {
		document.fmEditJob._recurrenceType[0].checked=true;
	}
	
	function selectEndDateRecurrence() {
		document.fmEditJob._recurrenceType[1].checked=true;
	}
	
	function selectCountRecurrence() {
		document.fmEditJob._recurrenceType[2].checked=true;
	}
</script>

  <tr>
	<td align="right"><spring:message code="report.scheduling.job.edit.trigger.label.recurrence"/></td>
    <td>&nbsp;</td>
	<td>
      <input type="radio" name="_recurrenceType" value="2" class="fnormal" <c:if test="${not occurrenceCountError and occurrenceCountValue == -1 and empty endDateValue}">checked</c:if>
		  onclick="resetEndDate();resetOccurrenceCount();"/>
      <spring:message code="report.scheduling.job.edit.trigger.recurrence.indefinitely"/>
    </td>
  </tr>

<spring:bind path="job.trigger.endDate">
  <tr>
    <td colspan="2">&nbsp;</td>
	<td>
      <input type="radio" name="_recurrenceType" value="3" class="fnormal" <c:if test="${not empty status.value}">checked</c:if>
		  onclick="resetOccurrenceCount();"/>
      <spring:message code="report.scheduling.job.edit.simple.trigger.end.date.before"/>
      <js:calendarInput name="${status.expression}" value="${status.value}" imageTipMessage="report.scheduling.job.edit.trigger.date.picker"
      		onchange="if(this.value != ''){resetOccurrenceCount();selectEndDateRecurrence();}else{selectIndefiniteRecurrence();}"
      		timezoneOffset="selectedTimezoneOffset"/>
      <spring:message code="report.scheduling.job.edit.simple.trigger.end.date.after"/>
    </td>
  </tr>
  <c:if test="${status.error}">
    <c:forEach items="${status.errorMessages}" var="error">
  <tr>
    <td colspan="2">&nbsp;</td>
	<td><span class="ferror"><c:out value="${error}"/></span></td>
  </tr>
    </c:forEach>
  </c:if>
</spring:bind>

<spring:bind path="job.trigger.occurrenceCount">
  <tr>
    <td colspan="2">&nbsp;</td>
	<td>
      <input type="radio" name="_recurrenceType" value="4" class="fnormal" <c:if test="${status.error or status.value != -1}">checked</c:if>
		  onclick="resetEndDate();document.fmEditJob['${status.expression}'].value=document.fmEditJob._maxOccurrences.value"/>
      <spring:message code="report.scheduling.job.edit.trigger.recurrence.times.before"/>
      <input type="text" name="_maxOccurrences" size="6" class="integer_normal"
		  <c:choose>
			  <c:when test="${status.error or status.value != -1}">value="${status.value}"</c:when>
			  <c:otherwise>value=""</c:otherwise>
		  </c:choose>
		  onchange="if(this.value != ''){document.fmEditJob['${status.expression}'].value=this.value;resetEndDate();selectCountRecurrence();}else{document.fmEditJob['${status.expression}'].value=-1;selectIndefiniteRecurrence();}"/>
      <spring:message code="report.scheduling.job.edit.trigger.recurrence.times.after"/>
    </td>
  </tr>
  <c:if test="${status.error}">
    <c:forEach items="${status.errorMessages}" var="error">
  <tr>
    <td colspan="2">&nbsp;</td>
	<td><span class="ferror"><c:out value="${error}"/></span></td>
  </tr>
    </c:forEach>
  </c:if>
</spring:bind>
	
  <tr>
	<td align="right">* <spring:message code="report.scheduling.job.edit.trigger.label.recurrence.interval"/></td>
    <td>&nbsp;</td>
	<td>
<spring:bind path="job.trigger.recurrenceInterval">
      <input type="text" name="${status.expression}" value="${status.value}" size="6" class="integer_normal"/>
</spring:bind>
<spring:bind path="job.trigger.recurrenceIntervalUnit">	
      <select name="${status.expression}" class="fnormal">
  <c:forEach var="intervalUnit" items="${requestScope.intervalUnits}">
		  <option value="${intervalUnit.code}" <c:if test="${status.value == intervalUnit.code}">selected</c:if>><spring:message code="${intervalUnit.labelMessage}"/></option>
  </c:forEach>
	  </select>
</spring:bind>
    </td>
  </tr>
<spring:bind path="job.trigger.recurrenceInterval">
  <c:if test="${status.error}">
    <c:forEach items="${status.errorMessages}" var="error">
  <tr>
    <td colspan="2">&nbsp;</td>
	<td><span class="ferror"><c:out value="${error}"/></span></td>
  </tr>
    </c:forEach>
  </c:if>
</spring:bind>
<spring:bind path="job.trigger.recurrenceIntervalUnit">
  <c:if test="${status.error}">
    <c:forEach items="${status.errorMessages}" var="error">
  <tr>
    <td colspan="2">&nbsp;</td>
	<td><span class="ferror"><c:out value="${error}"/></span></td>
  </tr>
    </c:forEach>
  </c:if>
</spring:bind>

</c:if>
		  
<c:if test="${requestScope.triggerRecurrenceType == 3}">

<spring:bind path="job.trigger.endDate">
  <tr>
	<td align="right"><spring:message code="report.scheduling.job.edit.trigger.label.end"/></td>
    <td>&nbsp;</td>
	<td>
      <js:calendarInput name="${status.expression}" value="${status.value}" imageTipMessage="report.scheduling.job.edit.trigger.date.picker"
      		timezoneOffset="selectedTimezoneOffset"/>
	</td>
  </tr>
  <c:if test="${status.error}">
    <c:forEach items="${status.errorMessages}" var="error">
  <tr>
    <td colspan="2">&nbsp;</td>
	<td><span class="ferror"><c:out value="${error}"/></span></td>
  </tr>
    </c:forEach>
  </c:if>
</spring:bind>
	
  <tr>
    <td colspan="3">&nbsp;</td>
  </tr>
	
<spring:bind path="job.trigger.minutes">
  <tr>
	<td align="right">* <spring:message code="report.scheduling.job.edit.trigger.label.minutes"/></td>
    <td>&nbsp;</td>
	<td>
      <input type="text" name="${status.expression}" value="${status.value}" size="10" class="fnormal"/>
    </td>
  </tr>	
  <c:if test="${status.error}">
    <c:forEach items="${status.errorMessages}" var="error">
  <tr>
    <td colspan="2">&nbsp;</td>
	<td><span class="ferror"><c:out value="${error}"/></span></td>
  </tr>
    </c:forEach>
  </c:if>
</spring:bind>
	
<spring:bind path="job.trigger.hours">
  <tr>
	<td align="right">* <spring:message code="report.scheduling.job.edit.trigger.label.hours"/></td>
    <td>&nbsp;</td>
	<td>
      <input type="text" name="${status.expression}" value="${status.value}" size="10" class="fnormal"/>
    </td>
  </tr>	
  <c:if test="${status.error}">
    <c:forEach items="${status.errorMessages}" var="error">
  <tr>
    <td colspan="2">&nbsp;</td>
	<td><span class="ferror"><c:out value="${error}"/></span></td>
  </tr>
    </c:forEach>
  </c:if>
</spring:bind>
	
  <tr>
    <td colspan="3">&nbsp;</td>
  </tr>
		
<spring:bind path="job.trigger.daysType">
	<c:set var="daysTypeName" value="${status.expression}"/>
</spring:bind>
	
  <tr>
	<td align="right"><spring:message code="report.scheduling.job.edit.trigger.label.days"/></td>
    <td>&nbsp;</td>
    <td>
<spring:bind path="job.trigger.daysType">
		<input type="radio" name="${status.expression}" value="1" <c:if test="${status.value == 1}">checked</c:if>/>
		<spring:message code="report.scheduling.job.edit.trigger.label.days.all"/>
</spring:bind>
	</td>
  </tr>	
  <tr>
    <td colspan="2">&nbsp;</td>
    <td>
<spring:bind path="job.trigger.daysType">
      <input type="radio" name="${status.expression}" value="2" <c:if test="${status.value == 2}">checked</c:if>/>
      <spring:message code="report.scheduling.job.edit.trigger.label.days.week"/>
</spring:bind>
  </tr>	
<spring:bind path="job.trigger.weekDays">
  <tr>
    <td colspan="2">&nbsp;</td>
    <td>
      <table border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="25px">
		  </td>
          <td>
            <input type="hidden" name="_${status.expression}" value=""/>
            <table border="0" cellpadding="0" cellspacing="0">
              <tr>
  <c:forEach var="day" items="${requestScope.allWeekDays}" varStatus="it">
      			<td align="center" nowrap>
      				<spring:message code="${day.labelMessage}"/>
      			</td>
      			<td>&nbsp;</td>
  </c:forEach>
      		  </tr>
              <tr>
  <c:forEach var="day" items="${requestScope.allWeekDays}" varStatus="it">
      			<td align="center">
      				<input type="checkbox" name="${status.expression}" value="${day.code}"
      					<%= status.getValue() != null && ((Set) status.getValue()).contains(new Byte(((ByteEnum) pageContext.getAttribute("day")).getCode())) ? "checked" : "" %>
      					onclick="document.fmEditJob['${daysTypeName}'][1].checked=true"
      				/>
      			</td>
      			<td>&nbsp;</td>
  </c:forEach>
      		  </tr>
            </table>
		  </td>
        </tr>
</spring:bind>
	  </table>		
	</td>
  </tr>
<spring:bind path="job.trigger.weekDays">
  <c:if test="${status.error}">
    <c:forEach items="${status.errorMessages}" var="error">
  <tr>
    <td colspan="2">&nbsp;</td>
	<td><span class="ferror"><c:out value="${error}"/></span></td>
  </tr>
    </c:forEach>
  </c:if>
</spring:bind>
  <tr>
    <td colspan="2">&nbsp;</td>
    <td>
<spring:bind path="job.trigger.daysType">
		<input type="radio" name="${status.expression}" value="3" <c:if test="${status.value == 3}">checked</c:if>/>
		<spring:message code="report.scheduling.job.edit.trigger.label.days.month"/>
</spring:bind>
		&nbsp;
<spring:bind path="job.trigger.monthDays">
		<input type="text" name="${status.expression}" value="${status.value}" size="10" class="fnormal"
			onchange="if(this.value != ''){document.fmEditJob['${daysTypeName}'][2].checked=true;}"
		/>
</spring:bind>
	</td>
  </tr>
<spring:bind path="job.trigger.monthDays">
  <c:if test="${status.error}">
    <c:forEach items="${status.errorMessages}" var="error">
  <tr>
    <td colspan="2">&nbsp;</td>
	<td><span class="ferror"><c:out value="${error}"/></span></td>
  </tr>
    </c:forEach>
  </c:if>
</spring:bind>
<spring:bind path="job.trigger.daysType">
  <c:if test="${status.error}">
    <c:forEach items="${status.errorMessages}" var="error">
  <tr>
    <td colspan="2">&nbsp;</td>
	<td><span class="ferror"><c:out value="${error}"/></span></td>
  </tr>
    </c:forEach>
  </c:if>
</spring:bind>
	
  <tr>
    <td colspan="3">&nbsp;</td>
  </tr>
	
<spring:bind path="job.trigger.months">
  <tr>
	<td align="right"><spring:message code="report.scheduling.job.edit.trigger.label.months"/></td>
    <td>&nbsp;</td>
	<td>
		<input type="checkbox" name="allMonths" onclick="checkboxListAllClicked('triggerMonths', this)"
			<%= status.getValue() != null && ((Set) status.getValue()).size() == ((List) request.getAttribute("allMonths")).size() ? "checked" : "" %>
		/>
		<spring:message code="report.scheduling.job.edit.trigger.label.months.all"/>
	</td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
	<td>
	  <input type="hidden" name="_${status.expression}" value=""/>
      <table border="0" cellpadding="0" cellspacing="0">
	    <tr>
  <c:forEach var="month" items="${requestScope.allMonths}" varStatus="it">
	  <c:if test="${it.count > 1 && it.count % 6 == 1}">
		</tr>
	    <tr>
	  </c:if>
			<td valign="middle">
				<input type="checkbox" name="${status.expression}" value="${month.code}"
					<%= status.getValue() != null && ((Set) status.getValue()).contains(new Byte(((ByteEnum) pageContext.getAttribute("month")).getCode())) ? "checked" : "" %>
					onclick="checkboxListCheckboxClicked('triggerMonths', this)"
				/>
			</td>
			<td valign="middle" nowrap>
				<spring:message code="${month.labelMessage}"/>
			</td>
			<td>&nbsp;</td>
  </c:forEach>
		</tr>
      </table>
    </td>
  </tr>	
  <c:if test="${status.error}">
    <c:forEach items="${status.errorMessages}" var="error">
  <tr>
    <td colspan="2">&nbsp;</td>
	<td><span class="ferror"><c:out value="${error}"/></span></td>
  </tr>
    </c:forEach>
  </c:if>
</spring:bind>
	
</c:if>

<spring:bind path="job.trigger">
  <c:if test="${status.error}">
  <tr>
    <td colspan="3">&nbsp;</td>
  </tr>
    <c:forEach items="${status.errorMessages}" var="error">
  <tr>
	<td colspan="3" align="center"><span class="ferror"><c:out value="${error}"/></span></td>
  </tr>
    </c:forEach>
  </c:if>
</spring:bind>

</table>
		  
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">
      <input type="submit" name="_eventId_cancel" value="<spring:message code="button.cancel"/>" class="fnormal"/>
      &nbsp;
      <input type="submit" name="_eventId_back" value="<spring:message code="button.back"/>" class="fnormal"/>
      &nbsp;
      <input type="submit" name="_eventId_next" value="<spring:message code="button.next"/>" class="fnormal"/>
<c:if test="${!isNewMode}">
      &nbsp;
      <input type="submit" name="_eventId_save" value="<spring:message code="button.save"/>" class="fnormal"/>
</c:if>
    </td>
  </tr>

</table>
</form>

    </td>
  </tr>
</table>

</body>
</html>
