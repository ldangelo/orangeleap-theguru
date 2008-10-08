<%@ include file="/WEB-INF/jsp/include.jsp"%>


<form method="post">
<h1>Report Wizard</h1>

<h2>Select Matrix Report Options</h2>
<div class="columns">
<Table>

	<Table id="report_groupbyfields" class="tablesorter">
		<thead> 
			<th>Field to group by</th>
			<th>Sort order</th>
			<th></th>
		</thead>
		
		<TR rowIndex="0">
			<TD><SELECT id="reportGroupByFields[0].fieldId"
				name="reportGroupByFields[0].fieldId"
				onchange="javascript:groupByFieldRowCloner('^(reportGroupByFields).*(fieldId).*')">
				<option label="" value="-1" selected></option>
				<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">
					<c:forEach var="f" items="${fgroup.fields}" varStatus="inner">
						<c:if test="${f != null }">
							<option label="${f.displayName}" value="${f.id}">${f.displayName}</option>
						</c:if>
					</c:forEach>
				</c:forEach>
			</SELECT></TD>

			<TD><SELECT id="reportGroupByFields[0].sortOrder"
				name="reportGroupByFields[0].sortOrder">
				<option value="ASC">Ascending</option>
				<option value="DESC">Descending</option>
			</SELECT></TD>

<!--  			<TD><SELECT id="reportGroupByFields[0].groupDateByOption"
				name="reportGroupByFields[0].groupDateByOption"
				disabled="disabled">
				<option value="1">Day</option>
				<option value="2">Month</option>
				<option value="3">Year</option>
			</SELECT></TD>-->

			<TD><img class="deleteButton" src="images/icons/deleteRow.png"
				style="cursor: pointer; display: none;" /></TD>

		</TR>
	</Table>

	<TR></TR>
	<TR></TR>
</Table>
<br>

<br>
<br>
</div>
<jsp:include page="snippets/navbuttons.jsp" /></form>


