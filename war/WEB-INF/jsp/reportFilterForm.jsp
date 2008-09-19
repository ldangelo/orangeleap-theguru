<%@ include file="/WEB-INF/jsp/include.jsp"%>


<form method="post">
<h1>Report Wizard</h1>

<h2>Enter filter Information</h2>
<div class="columns">
<h3>Filter Information</h3>
<Table>

	<Table id="report_filters" class="tablesorter">
		<TR rowIndex="0">
			<TD><SELECT id="advancedFilters[0].fieldId"
				name="advancedFilters[0].fieldId">
				<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">
					<c:forEach var="f" items="${fgroup.fields}" varStatus="inner">
						<c:if test="${f != null }">
							<option label="${f.displayName}" value="${f.id}">${f.displayName}</option>
						</c:if>
					</c:forEach>
				</c:forEach>
			</SELECT></TD>

			<TD><SELECT id="advancedFilters[0].operator"
				name="advancedFilters[0].operator">
				<option value="1">equals</option>
				<option value="2">not equal</option>
				<option value="3">less than</option>
				<option value="4">greater than</option>
			</SELECT></TD>

			<TD><input type="text" name="advancedFilters[0].value" value=""
				maxlength="100" title="Value 0"></TD>
			<TD><img class="deleteButton" src="images/icons/deleteRow.png"
				style="cursor: pointer; display: none;" /></TD>
		</TR>
	</Table>

	<TR></TR>
	<TR></TR>
	<TD>Limit the number of rows displayed in this report.</TD>
	</TR>
	<TR>
		<TD><SELECT id="rowCount" name="rowCount">
			<option value="-1">All</option>
			<option value="10">10</option>
			<option value="25">25</option>
			<option value="50">50</option>
			<option value="100">100</option>
			<option>Custom</option>
		</SELECT></TD>
	</TR>
	<TR></TR>
	<TR>
		<TD><input type="checkbox" value="no" name="details" />Hide
		report details</TD>
</Table>
<br>

<br>
<br>
</div>
<jsp:include page="snippets/navbuttons.jsp" /></form>


