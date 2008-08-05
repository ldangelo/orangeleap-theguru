<%@ include file="/WEB-INF/jsp/include.jsp" %>

test<form:form method="post" commandName="reportsource">
		<h1>
			Report Wizard
		</h1>

<c:forEach var="fgroup" items="${fieldGroups}">
<h2>${fgroup.name}</h2>
<table width="100%">
<tr>
<c:forEach var="f" items="${fgroup.fields}">
<input type="checkbox" name="$f.columnName" value="true" <c:if test="${f.isDefault}">checked</c:if>">${f.displayName}
</c:forEach>
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


