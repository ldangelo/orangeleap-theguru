<%@ include file="/WEB-INF/jsp/include.jsp" %>


<form:form method="post" commandName="rreportFormat">
		<h1>
			Report Wizard
		</h1>

		<h2>
		Enter filter Information
		</h2>
<div class="columns">
	<h3>Filter Information</h3>
<Table>	


<TR>
<TD>
<SELECT>
<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">
<c:forEach var="f" items="${fgroup.fields}" varStatus="inner">
<option label="${f.displayName}" value="fieldGroups[${outer.count-1}].fields[${inner.count-1}]">${f.displayName}</option>
</c:forEach>
</c:forEach>
</SELECT>
</TD>
<TD>
<SELECT>
<option>equals</option>
<option>not equal</option>
<option>less then</option>
<option>greater then</option>
</SELECT>
</TD>
<TD>
<input type="text" value="" maxlength="100" title="Value 0"> AND
</TD>
</TR>
<TR></TR>
<TR></TR>
<TD>Limit the number of rows displayed in this report.</TD></TR>
<TR>
<TD>
<SELECT>
<option>All</option>
<option>10</option>
<option>25</option>
<option>Custom</option>
</SELECT>
</TD>
</TR>
<TR></TR>
<TR>
<TD>
<input type="checkbox" value="no" name="details"/>Hide report details</TD>
</Table>
<br>

<br>
<br>
</div>
<jsp:include page="snippets/navbuttons.jsp"/>
</form:form>


