<%@ include file="/WEB-INF/jsp/include.jsp" %>
<mp:page pageName='reportSubSource'/>

*${reportDataSubSources}*

<form:form name="myform" method="post" commandName="reportsource">
   <form:select path="subSourceId" multiple="false">
   <form:options items="${reportDataSubSources}" itemLabel="displayName" itemValue="id"/>
</form:select>

<input type="submit" value="Back" name="_target0">
<input type="submit" value="Next" name="_target2">

</form:form>

