<%@ include file="/WEB-INF/jsp/include.jsp"%>
<mp:page pageName='ReportResultsToSegmentation' />


<form:form method="post" commandName="reportsource">
	<h1>Report Wizard</h1>
	<h2>Segmentation Results</h2>
	<hr width="100%" size=1 color="black">
		<jsp:include page="snippets/formerrors.jsp"/>
	<div class="columns">
	<br>
	<table class="tablesorter">
	<c:if test="${!hasErrors}"><tr><td>Segmentation Result<td><span style="color:#008800">Success</span></td></tr></c:if>
	<c:if test="${hasErrors}"><tr><td>Segmentation Result<td><span style="color:#DD0000">Failure</span></td></tr></c:if>
	<tr><td>Segmentation / Report ID</td><td>${wiz.id}</td></tr>
	<tr><td>Result Count</td><td>${rowsAffected}</td></tr>
	<tr><td>Last Run Date</td><td><fmt:formatDate value="${lastRunDate}" pattern="yyyy-MM-dd hh:mm:ss"/></td></tr>
	<tr><td>Last Run By</td><td>${lastRunBy}</td></tr>
	<tr><td>Execution Time (milliseconds)</td><td>${executionTime}</td></tr>
	<tr><td>Report Name</td><td>${wiz.reportName}</td></tr>
	<tr><td>Report Path</td><td>${wiz.reportPath}</td></tr>
	<tr><td>Segmentation Type</td><td>${segmentationType}</td></tr>
	</table>
	<br>
	<br>
	</div>
	<jsp:include page="snippets/navbuttons.jsp" />
</form:form>
