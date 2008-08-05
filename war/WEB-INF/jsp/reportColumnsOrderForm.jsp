<%@ include file="/WEB-INF/jsp/include.jsp" %>


<form:form method="post" commandName="rreportFormat">
		<h1>
			Report Wizard
		</h1>

		<h2>
		Report Column Order
		</h2>
<div class="columns">
<table>
<Tr><td>
<SELECT size="10" style="width:275px;">
<c:forEach var="rds" items="${reportsource.reportDataSource.subSources}">
<c:forEach var="fgroup" items="${rds.fieldGroups}">
<c:forEach var="field" items="${fgroup.fields}">
<input type=checkbox name="${fgroup.name}" value="${field.id}" checked="${field.isDefault}">${field.displayName}</td>
</c:forEach>
</c:forEach>
</c:forEach>
</SELECT></td>
<td>
	<div class="text">Top</div>
	<div class="text"><input type="button" title="Top" alt="Top" /></div>
	<div class "text">Up</div>
	<div class="text"><input type="button"  title="Up" alt="Up" /></div>
	<div class="text"><input type="button"  title="Up" alt="Up" /></div>
	<div class "text">Down</div>
	<div class="text"><input type="button"  title="Up" alt="Up" /></div>
	<div class "text">Bottom</div>
</td></Tr>
</table>
<br>
<br>
</div>
<input type="submit" value="Back" name="_target4">
<input type="submit" value="Next" name="_target6">


</form:form>


