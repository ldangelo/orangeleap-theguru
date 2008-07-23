<%@ include file="/WEB-INF/jsp/include.jsp" %>

<form:form method="post" commandName="reportsource">
		<h1>
			Report Wizard
		</h1>
${reportsource}
<br>
${reportsource.dataSource}
<br>
${reportsource.dataSubSource}
<br>
${reportsource.dataSubSource.fieldGroups}
<br>

<br>
${reportsource.srcId}
<br>
${reportsource.subSourceId}

<c:forEach var="fgroup" items="${reportsource.dataSubSource.fieldGroups}">
<h2>${fgroup.name}</h2>
<table width="100%">
<tr>
<form:checkboxes path="" items="${reportsource.dataSubSource.fieldGroups}" itemLabel="name"/>
</tr></table>
<BR></c:forEach>
<Table>	
<TR>
</TR>


</Table>
<br>
<br>

<input type="submit" value="Cancel" name="_target2">
<input type="submit" value="Next" name="_target4">


</form:form>


