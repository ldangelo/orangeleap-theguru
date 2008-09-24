<%@ include file="/WEB-INF/jsp/include.jsp"%>


<form method="post">
<h1>Report Wizard</h1>

<h2>Chart Settings</h2>
<div class="columns">
<Table>

	<Table id="report_chartsettings" class="tablesorter">
		<thead> 
			<th>Chart Type</th>
			<th>Field for X-Axis/Value</th>
			<th>Field for Y-Axis/Wedge</th>
			<th>Operation for Y-Axis/Wedge</th>
			<th></th>
		</thead>
		
		<TR rowIndex="0">
			<TD><SELECT id="reportChartSettings[0].chartType"
				name="reportChartSettings[0].chartType"
				<!-- onchange="javascript:groupByFieldRowCloner('^(reportChartSettings).*(chartType).*')"> -->
				<option label="" value="-1" selected></option>
				<option label="Bar Chart" value="Bar">Bar Chart</option>
				<option label="Pie Chart" value="Pie">Pie Chart</option>
			</SELECT></TD>
 
			<TD><SELECT id="reportChartSettings[0].fieldIdx"
				name="reportChartSettings[0].fieldIdx"
				<c:forEach var="f" items="${reportGroupByFields}" varStatus="inner">
					<c:if test="${f != null }">
						<option label="${f.displayName}" value="${f.id}">${f.displayName}</option>
					</c:if>
				</c:forEach>
			</SELECT></TD>
 
			<TD><SELECT id="reportChartSettings[0].fieldIdy"
				name="reportChartSettings[0].fieldIdy"
				<c:forEach var="f" items="${reportSummarizedByFields}" varStatus="inner">
					<c:if test="${f != null }">
						<option label="${f.displayName}" value="${f.id}">${f.displayName}</option>
					</c:if>
				</c:forEach>
			</SELECT></TD>
  
			<TD><SELECT id="reportChartSettings[0].operation"
				name="reportChartSettings[0].operation"
				<option label="Record Count" value="RecordCount" selected>Record Count</option>
				<option label="Sum" value="Sum">Sum</option>
			</SELECT></TD>

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


