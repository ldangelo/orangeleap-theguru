<%@ include file="/WEB-INF/jsp/include.jsp"%>
<script type="text/javascript" src="js/mpower.reportfilters.js"></script>

<form method="post">

<h1>Report Wizard</h1>
<div class="columns">
 	<h2>Filters</h2>
	<hr width="100%" size=1 color="black">
	<table id="report_filters_select" class="tablesorter" >
		<TR><TH>Add Filter</TH></TR>
		<tr>
	</table>

	<select id="addFilterSelect" name="addFilterSelect"
		onchange="cloneFilterRow(this, document.getElementById('report_filters_add'));">
		<option label="" value="0"></option>
		<option label="Standard Filter" value="1">Standard Filter</option>
		<option label="Custom Filter" value="2">Custom Filter</option>
		<option label="Group" value="3">Group</option>
	</select>
	<br>
	<br>
 	<table id="report_filters_add" class="tablesorter" index="0" bgcolor=#E0E0E0 >
		<tr><th>Selected Filters</th></tr>
	</table>
	<br>
	<br>

	<Table id="limit_row_count" class="tablesorter">	
		<h2>Limit Row Count</h2>
		<hr width="100%" size=1 color="black">
		<TR><TH>Limit the number of rows displayed in this report.</TH></TR>
		<TR>
			<TD>
				<SELECT id="rowCount" name="rowCount">
					<option value="-1">All</option>
					<option value="10">10</option>
					<option value="25">25</option>
					<option value="50">50</option>
					<option value="100">100</option>
					<option>Custom</option>
				</SELECT>
			</TD>
		</TR>
		<TR>
			<TD>
				<input type="checkbox" value="no" name="details" />Hide report details
			</TD>
		</TR>
	</Table>
	<br>
	<br>
	<br>
</div>
<jsp:include page="snippets/navbuttons.jsp" /></form>

<!--  hidden tables cloned to add new filters -->
<TABLE id="report_standard_filters" class="tablesorter" style="display: none;" bgcolor=#E0E0E0 >
	<TR><TH>Field</TH><TH>Comparison / Duration</TH><TH>Prompt for</TH><TH>Value</TH></TR>
	<TR rowIndex="0">
		<TD>
			<input type="hidden" value="1" objectname="reportFilters[INDEXREPLACEMENT].filterType" />
			<SELECT objectname="reportFilters[INDEXREPLACEMENT].reportStandardFilter.fieldId" 
				onchange="filterCriteria(this);"  style="width: 150px">
				<option label="None" value="-1">None</option>
				<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">
					<c:forEach var="f" items="${fgroup.fields}" varStatus="inner">
						<c:if test="${f != null }">
							<option label="${f.displayName}" value="${f.id}" fieldType="${f.fieldType}" >${f.displayName}</option>
						</c:if>
					</c:forEach>
				</c:forEach>
			</SELECT>
		</TD>
		<TD>
			<SELECT objectname="reportFilters[INDEXREPLACEMENT].reportStandardFilter.comparison" style="width: 170px"
				onchange="displayPromptForCriteriaOptions(this);" >
				<option value="1">equals</option>
				<option value="2">not equal</option>
				<option value="3">less than</option>
				<option value="4">greater than</option>
				<option value="5">less or equal</option>
				<option value="6">greater or equal</option>
				<option value="7">starts with</option>				
				<option value="8">ends with</option>
				<option value="9">contains</option>
				<option value="10">does not contain</option>
				<!-- Date only options -->
				<optgroup label="Fiscal Year" dateonly="true" style="display: none;" >
					<option label="Current FY" value="20" dateonly="true" >Current FY</option>
					<option label="Previous FY" value="21" dateonly="true" >Previous FY</option>
					<option label="Previous 2 FY" value="22" dateonly="true" >Previous 2 FY</option>
					<option label="2 FY Ago" value="23" dateonly="true" >2 FY Ago</option>
					<option label="Current And Prvious FY" value="24" dateonly="true" >Current And Previous FY</option>
					<option label="Previous 2 FY" value="25" dateonly="true" >Previous 2 FY</option>
				</optgroup>
				<optgroup label="Fiscal Quater" dateonly="true" style="display: none;" >
					<option label="Current" value="26" dateonly="true" >Current FQ</option>
					<option label="Current and Next" value="27" dateonly="true" >Current and Next FQ</option>
					<option label="Current and Previous" value="28" dateonly="true" >Current and Previous FQ</option>
					<option label="Previous" value="29" dateonly="true" >Previous FQ</option>
				</optgroup>
				<optgroup label="Calendar Year" dateonly="true" style="display: none;" >
					<option label="Current CY" value="30" dateonly="true" >Current CY</option>
					<option label="Previous CY" value="31" dateonly="true" >Previous CY</option>
					<option label="Current and Previous CY" value="32" dateonly="true" >Current and Previous CY</option>
				</optgroup>
				<optgroup label="Calendar Month" dateonly="true" style="display: none;" >
					<option label="Current" value="33" dateonly="true" >Current CM</option>
					<option label="Previous" value="34" dateonly="true" >Previous CM</option>
					<option label="Current and Previous" value="35" dateonly="true" >Current and Previous CM</option>
				</optgroup>
				<optgroup label="Calendar Week" dateonly="true" style="display: none;" >
					<option label="Current" value="36" dateonly="true" >Current CW</option>
					<option label="Previous" value="37" dateonly="true" >Previous CW</option>
					<option label="Current And Previous" value="38" dateonly="true" >Current and Previous CW</option>
				</optgroup>
				<optgroup label="Calendar Day" dateonly="true" style="display: none;" >
					<option label="Today CD" value="39" dateonly="true" >Today CD</option>
					<option label="Yesterday CD" value="40" dateonly="true" >Yesterday CD</option>
					<option label="Last 7 CD" value="41" dateonly="true" >Last 7 CD</option>
					<option label="Last 30 CD" value="42" dateonly="true" >Last 30 CD</option>
					<option label="Last 60 CD" value="43" dateonly="true" >Last 60 CD</option>
					<option label="Last 90 CD" value="44" dateonly="true" >Last 90 CD</option>
					<option label="Last 120 CD" value="45" dateonly="true" >Last 120 CD</option>
				</optgroup>
			</SELECT>
		</TD>
		<TD>
			<input type="checkbox" objectname="reportFilters[INDEXREPLACEMENT].reportStandardFilter.promptForCriteria"
				checked="checked"
				value="true"
				onclick="togglePromptForCriteriaTextBox(this);">
				<!-- onclick="document.getElementById(this.name + 'TextBox').disabled=this.checked;document.getElementById(this.name + 'TextBox').value='';">-->				
		</TD>
		<TD>
			<input objectname="reportFilters[INDEXREPLACEMENT].reportStandardFilter.criteria" 
				disabled="disabled">
		</TD>
	</TR>
</Table>

<TABLE id="report_custom_filters" class="tablesorter" style="display: none;width: 555px" bgcolor=#E0E0E0 >
	<TR><TH>Custom filter criteria
		<input type="hidden" value="2" objectname="reportFilters[INDEXREPLACEMENT].filterType" />
	</TH></TR>
	<TR>
		<TD>
			<SELECT id="customFilterSelect"
				name="customFilterSelect"
				style="width:545px"
				onchange="populateCustomFilterRow(this, document.getElementById('report_filters_add'));" >
				<option value="0">Select a custom filter from the drop down list</option>
				<c:forEach var="customFilter" items="${customFilters}" varStatus="outer">
					<c:if test="${customFilter != null}">
						<option label="${customFilter.displayText}" value="${customFilter.id}">${customFilter.displayText}</option>
					</c:if>
				</c:forEach>
			</SELECT>
		</TD>
	</TR>
</TABLE>

<table id="report_filters_operator" class="tablesorter" style="display: none;" bgcolor=#E0E0E0 >
	<tr><th>Operators</th></tr>
	<TR>
		<TD>
			<SELECT objectname="reportFilters[INDEXREPLACEMENT].operator" >
				<option value="0">And</option>
				<option value="1">Or</option>
			</SELECT>
			<SELECT objectname="reportFilters[INDEXREPLACEMENT].operatorNot" >
				<option value="0"></option>
				<option value="1">Not</option>
			</SELECT>
		</TD>
	</TR>
</table>

<table id="report_filters_action" class="tablesorter" style="display: none;" bgcolor=#E0E0E0 >
	<TR><TH>Action</TH></TR>
	<TR>
		<TD>
			<img class="deleteButton" src="images/icons/deleteRow.png" style="cursor: pointer;"/>
			<img class="moveUpButton" src="images/filterUp.gif" style="cursor: pointer;"/>
			<img class="moveDownButton" src="images/filterDown.gif" style="cursor: pointer;"/>
		</td>
	</TR>
</table>

<table id="report_filter_group_begin" class="tablesorter" style="display: none;" bgcolor=#D0D0D0 >
	<TR><TH>Grouping <input type="hidden" value="3" objectname="reportFilters[INDEXREPLACEMENT].filterType" /></TH></TR>
	<TR><TD id="beginGroupLabel" style="font-weight: bold" >Begin Group</TD></TR>
</table>

<table id="report_filter_group_end" class="tablesorter" style="display: none;" bgcolor=#D0D0D0 >
	<TR><TH>Grouping <input type="hidden" value="4" objectname="reportFilters[INDEXREPLACEMENT].filterType" /></TH></TR>
	<TR><TD id="endGroupLabel" style="font-weight: bold">End Group</TD></TR>
</table>
