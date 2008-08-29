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


<input type="submit" value="Cancel" name="_cancel">
<input type="submit" value="Save" name="_target10">

</form:form>

