<%@ include file="/WEB-INF/jsp/include.jsp"%>


<form method="post">
<h1>Report Wizard</h1>

<h2>Select Matrix Report Options</h2>
<div class="columns">
<Table>

	<Table id="report_matrixrows" class="tablesorter">
		<thead> 
			<th>Row Fields</th>
			<th>Sort order</th>
			<th></th>
		</thead>
		
		<TR rowIndex="0">
			<TD><SELECT id="reportCrossTabFields.reportCrossTabRows[0].fieldId"
				name="reportCrossTabFields.reportCrossTabRows[0].fieldId"
<!-- 			onchange="javascript:groupByFieldRowCloner('^(reportCrossTabFields).*(reportCrossTabRows).*(fieldId).*')"> -->
				<option label="" value="-1" selected></option>
				<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">
					<c:forEach var="f" items="${fgroup.fields}" varStatus="inner">
						<c:if test="${f != null }">
							<option label="${f.displayName}" value="${f.id}">${f.displayName}</option>
						</c:if>
					</c:forEach>
				</c:forEach>
			</SELECT></TD>

			<TD><SELECT id="reportCrossTabFields.reportCrossTabRows[0].sortOrder"
				name="reportCrossTabFields.reportCrossTabRows[0].sortOrder">
				<option value="ASC">Ascending</option>
				<option value="DESC">Descending</option>
			</SELECT></TD>

<!--  			<TD><SELECT id="reportCrossTabFields.reportCrossTabRows[0].groupDateByOption"
				name="reportCrossTabFields.reportCrossTabRows[0].groupDateByOption"
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
	<Table id="report_matrixColumns" class="tablesorter">
		<thead> 
			<th>Column Fields</th>
			<th>Sort order</th>
			<th></th>
		</thead>
		
		<TR rowIndex="0">
			<TD><SELECT id="reportCrossTabFields.reportCrossTabColumns[0].fieldId"
				name="reportCrossTabFields.reportCrossTabColumns[0].fieldId"
<!--  				onchange="javascript:groupByFieldRowCloner('^(reportCrossTabFields).*(reportCrossTabColumns).*(fieldId).*')">-->
				<option label="" value="-1" selected></option>
				<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">
					<c:forEach var="f" items="${fgroup.fields}" varStatus="inner">
						<c:if test="${f != null }">
							<option label="${f.displayName}" value="${f.id}">${f.displayName}</option>
						</c:if>
					</c:forEach>
				</c:forEach>
			</SELECT></TD>

			<TD><SELECT id="reportCrossTabFields.reportCrossTabColumns[0].sortOrder"
				name="reportCrossTabFields.reportCrossTabColumns[0].sortOrder">
				<option value="ASC">Ascending</option>
				<option value="DESC">Descending</option>
			</SELECT></TD>

<!--  			<TD><SELECT id="reportCrossTabFields.reportCrossTabColumns[0].groupDateByOption"
				name="reportCrossTabFields.reportCrossTabColumns[0].groupDateByOption"
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

	<Table id="report_matrixMeasure" class="tablesorter">
		<thead> 
			<th>Measure</th>
			<th>Operation</th>
			<th></th>
		</thead>
		
		<TR rowIndex="0">
			<TD><SELECT id="reportCrossTabFields.reportCrossTabMeasure"
				name="reportCrossTabFields.reportCrossTabMeasure"
				<option label="" value="-1" selected></option>
				<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">
					<c:forEach var="f" items="${fgroup.fields}" varStatus="inner">
						<c:if test="${f != null }">
							<option label="${f.displayName}" value="${f.id}">${f.displayName}</option>
						</c:if>
					</c:forEach>
				</c:forEach>
			</SELECT></TD>
			
			<TD><SELECT id="reportCrossTabFields.reportCrossTabOperation"
				name="reportCrossTabFields.reportCrossTabOperation">
				<option value="SUM">Sum</option>
				<option value="AVERAGE">Average</option>
				<option value="MAX">Max</option>
				<option value="MIN">Min</option>
				<option value="COUNT">Count</option>
			</SELECT></TD>
			

		</TR>
	</Table>
	<TR></TR>

</Table>
<br>

<br>
<br>
</div>
<jsp:include page="snippets/navbuttons.jsp" /></form>


