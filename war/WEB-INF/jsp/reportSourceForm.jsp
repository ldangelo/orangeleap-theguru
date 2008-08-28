<%@ include file="/WEB-INF/jsp/include.jsp" %>

<form:form name="myform" method="post" commandName="reportsource">

<form:select path="srcId" multiple="false">
<form:options items="${reportsource.dataSources}" itemLabel="name" itemValue="id"/>
</form:select>


<div class="buttonposition">
<jsp:include page="snippets/navbuttons.jsp" />
</div>
</form:form>

