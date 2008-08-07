<%@ include file="/WEB-INF/jsp/include.jsp" %>

<form:form method="post" commandName="fieldGroups">
		<h1>
			Report Wizard
		</h1>

<c:forEach var="fgroup" items="${fieldGroups}">
<h2>${fgroup.name}</h2>
<table width="100%">
<tr>
<form:checkboxes path="$fgroup.fields" items="$fgroup.fields" element="isDefault" itemLabel="displayName"/>
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


