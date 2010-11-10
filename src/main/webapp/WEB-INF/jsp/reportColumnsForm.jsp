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
<tr>
	<th>
		<span class="selectedFieldsTitleWrapper">Selected Fields
			<span class="selectedFieldsTitleDistinctWrapper"><input id="uniqueRecords" name="uniqueRecords" value="true"  type="checkbox"
							<c:if test="${(reportUniqueRecords == true)}">
								checked="true"
							</c:if>/>Unique Records 
			</span>
		</span>
	</th>
</tr>
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
			<th>Chart</th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
		</tr>
		<TR rowIndex="0">
			<TD>Type <br/><SELECT id="reportChartSettings[0].chartType"
				name="reportChartSettings[0].chartType" >
			<option label="" value="-1"
				<c:if test="${reportChartSettings[0].chartType == '-1'}">
					selected="true"
				</c:if>>No Chart</option>
			<option label="Area" value="Area"
				<c:if test="${reportChartSettings[0].chartType == 'Area'}">
					selected="true"
				</c:if>>Area</option>
			<option label="Bar" value="Bar"
				<c:if test="${reportChartSettings[0].chartType == 'Bar'}">
					selected="true"
				</c:if>>Bar</option>
			<option label="Bar 3D" value="Bar3D"
				<c:if test="${reportChartSettings[0].chartType == 'Bar 3D'}">
					selected="true"
				</c:if>>Bar 3D</option>
			<option label="Line" value="Line"
				<c:if test="${reportChartSettings[0].chartType == 'Line'}">
					selected="true"
				</c:if>>Line</option>
			<option label="Pie" value="Pie"
				<c:if test="${reportChartSettings[0].chartType == 'Pie'}">
					selected="true"
				</c:if>>Pie</option>
			<option label="Pie 3D" value="Pie3D"
				<c:if test="${reportChartSettings[0].chartType == 'Pie 3D'}">
					selected="true"
				</c:if>>Pie 3D</option>
			<option label="Scatter" value="Scatter"
				<c:if test="${reportChartSettings[0].chartType == 'Scatter'}">
					selected="true"
				</c:if>>Scatter</option>
			<option label="Stacked Area" value="StackedArea"
				<c:if test="${reportChartSettings[0].chartType == 'Stacked Area'}">
					selected="true"
				</c:if>>Stacked Area</option>
			<option label="Stacked Bar" value="StackedBar"
				<c:if test="${reportChartSettings[0].chartType == 'Stacked Bar'}">
					selected="true"
				</c:if>>Stacked Bar</option>
			<option label="Stacked Bar 3D" value="StackedBar3D"
				<c:if test="${reportChartSettings[0].chartType == 'Stacked Bar 3D'}">
					selected="true"
				</c:if>>Stacked Bar 3D</option>
			<option label="Time Series" value="TimeSeries"
				<c:if test="${reportChartSettings[0].chartType == 'Time Series'}">
					selected="true"
				</c:if>>Time Series</option>
			<option label="XY Area" value="XYArea"
				<c:if test="${reportChartSettings[0].chartType == 'XY Area'}">
					selected="true"
				</c:if>>XY Area</option>
			<option label="XY Bar" value="XYBar"
				<c:if test="${reportChartSettings[0].chartType == 'XY Bar'}">
					selected="true"
				</c:if>>XY Bar</option>
			<option label="XY Line" value="XYLine"
				<c:if test="${reportChartSettings[0].chartType == 'XY Line'}">
					selected="true"
				</c:if>>XY Line</option>
			</SELECT></TD>


			<TD>Location <br/> <SELECT id="reportChartSettings[0].location"
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
				<OPTION label="Chart Only" value="chartOnly"
					<c:if test="${reportChartSettings[0].location == 'chartOnly'}">
						selected="true"
					</c:if>
				>Chart Only</OPTION>

			</SELECT></TD>
			<TD>Category (x-axis)<br/><SELECT id="reportChartSettings[0].fieldIdx"
				name="reportChartSettings[0].fieldIdx" >
				<c:forEach var="f" items="${reportGroupByFields}" varStatus="inner"><c:if test="${f != null }"><option label="${f.displayName}" value="${f.id}"<c:if test="${reportChartSettings[0].fieldIdx == f.id}"> selected="true"</c:if>>${f.displayName}</option></c:if>
				</c:forEach></SELECT></TD>
			<TD>Series (y-axis) <br/><SELECT id="reportChartSettings[0].reportChartSettingsSeries[0].series"
				name="reportChartSettings[0].reportChartSettingsSeries[0].series"
				onchange="fillChartCalcOptions(this); " >
				<option label="Default Selected" value="${reportChartSettings[0].reportChartSettingsSeries[0].series}" >Default</option>
			</SELECT></TD>
			<TD>Operation for Series <br/><SELECT id="reportChartSettings[0].operation"
				name="reportChartSettings[0].reportChartSettingsSeries[0].operation">
				<option label="Record Count" value="RecordCount" moneyonly="false"
					<c:if test="${reportChartSettings[0].reportChartSettingsSeries[0].operation == 'RecordCount'}">
						selected="true"
					</c:if>>Record Count</option>
				<option label="Sum" value="Sum" moneyonly="true"
					<c:if test="${reportChartSettings[0].reportChartSettingsSeries[0].operation == 'Sum'}">
						selected="true"
					</c:if>>Sum</option></SELECT></TD>

		<TR>
			<TD>Title <br/><input type="text" name="reportChartSettings[0].chartTitle" id="reportChartSettings[0].chartTitle"
			<c:if test="${reportChartSettings[0].chartTitle != null}"> value="${reportChartSettings[0].chartTitle}"</c:if>>
			</TD>
			<TD>Subtitle <br/><input type="text" name="reportChartSettings[0].chartSubTitle" id="reportChartSettings[0].chartSubTitle"
			<c:if test="${reportChartSettings[0].chartSubTitle != null}"> value="${reportChartSettings[0].chartSubTitle}"</c:if>>
			</TD>
			<TD>Category(x) Axis Label <br/><input type="text" name="reportChartSettings[0].categoryAxisLabel" id="reportChartSettings[0].categoryAxisLabel"
			<c:if test="${reportChartSettings[0].categoryAxisLabel != null}"> value="${reportChartSettings[0].categoryAxisLabel}"</c:if>>
			</TD>				
			<TD>Value(y) Axis Label <br/><input type="text" name="reportChartSettings[0].valueAxisLabel" id="reportChartSettings[0].valueAxisLabel"
			<c:if test="${reportChartSettings[0].valueAxisLabel != null}"> value="${reportChartSettings[0].valueAxisLabel}"</c:if>>
			</TD>	
			<TD></TD>			
		</TR>					

		</TR>
	</table>
</div>
<br>
<br>
<jsp:include page="snippets/navbuttons.jsp" />
</form:form>
