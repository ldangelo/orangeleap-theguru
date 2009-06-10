<%@ include file="/WEB-INF/jsp/include.jsp"%>

<script type="text/javascript" src="js/mpower.reportfields.js"></script>



<form:form method="post" commandName="reportsource">
<h1>Report Wizard</h1>
<h2>Select the fields to display</h2>
<hr width="100%" size=1 color="black">
	<jsp:include page="snippets/formerrors.jsp"/>

<div class = "content">
<!-- Hidden table used for cloning rows -->
<table id="report_fields_source" class="tablesorter" bgcolor=#E0E0E0 style="display:none">
	<jsp:include page="/WEB-INF/jsp/reportColumnsFormSelectedField.jsp" />
</table>
<table>
	<tr>
		<th>Field Groups</th>
		<th>Fields</th>
	</tr>
	<tr>
		<td></td>
		<td><input id="fieldSearch" style="width: 506px" onkeyup="updateDisplayedFields();"></td>
	</tr>
	<tr>
		<td><select id="fieldGroups" size=10 style="width: 260px"
			onchange="updateDisplayedFields();">
			<optgroup label="Field Groups"><c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer"><option groupid=${fgroup.id}>${fgroup.name}</option></c:forEach></optgroup>
			<option groupid="-1">All Fields</option>
		</select></td>
		<td><select id="fields" size=10 style="width: 512px; display: none;"
			ondblclick="addReportField(this);" >
			<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer"><optgroup label="${fgroup.name}" fieldgroupid=${fgroup.id}>	<c:forEach var="f" items="${fgroup.fields}" varStatus="inner"><c:if test="${f != null}"><option value=${f.id} fieldgroupid=${fgroup.id} fieldid=${f.id} fieldtype=${f.fieldType}>${f.displayName}</option></c:if></c:forEach></optgroup></c:forEach>
		</select>
		<select id="fieldsDisplay" size=10 style="width: 512px;"
			ondblclick="addReportField(this);">
		</select></td>
	</tr>
</table>
<br>

<table id="report_fields_selected" class="tablesorter" bgcolor=#E0E0E0>
	<th>
		<span class="selectedFieldsTitleWrapper">Selected Fields
			<span class="selectedFieldsTitleDistinctWrapper"><input id="uniqueRecords" name="uniqueRecords" value="true"  type="checkbox"
							<c:if test="${(reportUniqueRecords == true)}">
								checked="true"
							</c:if>/>Unique Records </td>
			</span>
		</span>
	</th>

	<tr>
		<td>
		<table id="report_fields_add" index="0" class="tablesorter"	bgcolor=#E0E0E0>
			<tr index="-1">
				<th>Field</th>
				<th align=center>Sort Order</th>
				<th align=center>Group By</th>
				<th align=center>Count</th>
				<th align=center>Maximum</th>
				<th align=center>Minimum</th>
				<th align=center>Sum</th>
				<th align=center>Average</th>
				<th align=center>Actions
					<img class="deleteButton"
						src="images/icons/deleteRow.png" style="cursor: pointer;"
						onclick="deleteAllFieldRows();"/>
				</th>
			</tr><c:set var="fieldIndex" scope="request" value="0"/>
            <c:forEach var="field" items="${selectedFields}" varStatus="outer"><c:set var="currentField" scope="request" value="${field}"/><jsp:include page="/WEB-INF/jsp/reportColumnsFormSelectedField.jsp" /><c:set var="fieldIndex" scope="request" value="${fieldIndex + 1}"/></c:forEach>
		</table>
	</td>
	</tr>
</table>
</div>
<div id="chartSettings" style="display: none;">
	<br>
	<br>
	<h2>Select chart settings</h2>
	<hr width="100%" size=1 color="black">
	<table id="chartSettings" class="tablesorter" bgcolor=#E0E0E0>
		<tr>
			<th>Chart Type</th>
			<th>Location</th>
			<th>Field for X-Axis/Value</th>
			<th>Field for Y-Axis/Wedge</th>
			<th>Operation for Y-Axis/Wedge</th>
		</tr>
		<TR rowIndex="0">
			<TD><SELECT id="reportChartSettings[0].chartType"
				name="reportChartSettings[0].chartType" >
				<option label="" value="-1"
					<c:if test="${reportChartSettings[0].chartType == '-1'}">
						selected="true"
					</c:if>>No Chart</option>
				<option label="Bar Chart" value="Bar"
					<c:if test="${reportChartSettings[0].chartType == 'Bar'}">
						selected="true"
					</c:if>>Bar Chart</option>
				<option label="Pie Chart" value="Pie"
					<c:if test="${reportChartSettings[0].chartType == 'Pie'}">
						selected="true"
					</c:if>>Pie Chart</option>
			</SELECT></TD>
			<TD><SELECT id="reportChartSettings[0].location"
				name="reportChartSettings[0].location">
				<OPTION label="Header" value="header"
					<c:if test="${reportChartSettings[0].location == 'header'}">
						selected="true"
					</c:if>
				>Header</OPTION>
				<OPTION label="Footer" value="footer"
					<c:if test="${reportChartSettings[0].location == 'footer'}">
						selected="true"
					</c:if>
				>Footer</OPTION>
			</SELECT></TD>
			<TD><SELECT id="reportChartSettings[0].fieldIdx"
				name="reportChartSettings[0].fieldIdx" >
				<c:forEach var="f" items="${reportGroupByFields}" varStatus="inner"><c:if test="${f != null }"><option label="${f.displayName}" value="${f.id}"<c:if test="${reportChartSettings[0].fieldIdx == f.id}"> selected="true"</c:if>>${f.displayName}</option></c:if>
				</c:forEach></SELECT></TD>
			<TD><SELECT id="reportChartSettings[0].fieldIdy"
				name="reportChartSettings[0].fieldIdy"
				onchange="fillChartCalcOptions(this); " >
				<option label="Default Selected" value="${reportChartSettings[0].fieldIdy}" >Default</option>
			</SELECT></TD>

			<TD><SELECT id="reportChartSettings[0].operation"
				name="reportChartSettings[0].operation">
				<option label="Record Count" value="RecordCount" moneyonly="false"
					<c:if test="${reportChartSettings[0].operation == 'RecordCount'}">
						selected="true"
					</c:if>>Record Count</option>
				<option label="Sum" value="Sum" moneyonly="true"
					<c:if test="${reportChartSettings[0].operation == 'Sum'}">
						selected="true"
					</c:if>>Sum</option></SELECT></TD>
		</TR>
	</table>
</div>
<br>
<br>
<jsp:include page="snippets/navbuttons.jsp" />
</form:form>
