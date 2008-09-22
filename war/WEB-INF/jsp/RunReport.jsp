<%@ include file="/WEB-INF/jsp/include.jsp" %>

<form:form name="myform" method="post" commandName="reportsource">
<div class="buttonposition">
<jsp:include page="snippets/runbuttons.jsp" />
</div>
<iframe src="http://localhost:8080/jasperserver/flow.html?_flowId=viewReportFlow&reportUnit=${reportPath}&standAlone=false&ParentFolderUri=/reports/Clementine/Temp" width="100%" height="100%">
</iframe>
</form:form>
