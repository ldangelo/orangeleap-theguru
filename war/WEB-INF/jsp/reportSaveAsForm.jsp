<%@ include file="/WEB-INF/jsp/include.jsp" %>

<form:form name="myform" method="post" commandName="reportsource">

<!-- 
<form:select path="srcId" multiple="false">
<form:options items="${reportsource.dataSources}" itemLabel="name" itemValue="id"/>
</form:select>

 -->
<table>
<tr><td>Report Name</td><td><form:input path="reportName" size="20" maxlength="40"/></td></tr>
<tr><td>Report Comment</td><td><form:input path="reportComment" size="40" maxlength="80"/></td></tr>
</table>

<div class="addbuttonposition">
<table>
<tr>
<td align="Left" width=360>
<input type="image" src="images/run_report_off.gif" value="Run Report" ALT="Run Report" name="_target12" onmouseover="this.src = 'images/run_report_on.gif';" onmouseout="this.src = 'images/run_report_off.gif';">
<input type="image" src="images/cancel_off.gif" value="Cancel" name="_target9" ALT="Cancel" onmouseover="this.src = 'images/cancel_on.gif';" onmouseout="this.src = 'images/cancel_off.gif';">
<input type="image" src="images/save_off.gif" value="Save" name="_target12" ALT="Save" onmouseover="this.src = 'images/save_on.gif';" onmouseout="this.src = 'images/save_off.gif';">
</td>
</table>
</div>

</form:form>

