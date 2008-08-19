<%@ include file="/WEB-INF/jsp/include.jsp" %>

<form:form name="myform" method="post" commandName="reportsource">

<form:select path="srcId" multiple="false">
<form:options items="${reportsource.dataSources}" itemLabel="name" itemValue="id"/>
</form:select>

<input type="submit" value="Cancel" name="_cancel">
<input type="submit" value="Next" name="_target1">

</form:form>

