<%@ include file="/WEB-INF/jsp/include.jsp"%>

<form method="post">

<h1>Report Wizard</h1>
<div class="columns">
	<h2>Standard Filters</h2>
	<hr width="100%" size=1 color="black">
	<Table id="report_standard_filters" class="tablesorter">
		<TR><TH>Fields</TH><TH>Duration</TH><TH></TH></TR>
		<TR rowIndex="0">
			<TD>
				<SELECT id="standardFilters[0].fieldId" name="standardFilters[0].fieldId">
					<option label="None" value="-1">None</option>
					<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">
						<c:forEach var="f" items="${fgroup.fields}" varStatus="inner">
							<c:if test="${f != null && f.fieldType.isDate}">
								<option label="${f.displayName}" value="${f.id}">${f.displayName}</option>
							</c:if>
						</c:forEach>
					</c:forEach>
				</SELECT>
			</TD>
			<TD>
				<SELECT id="standardFilters[0].duration" name="standardFilters[0].duration">
					<option label="None" value="-1">None</option>
					<optgroup label="Fiscal Year" >
						<option label="Current FY" value="1">Current FY</option>
						<option label="Previous FY" value="2">Previous FY</option>
						<option label="Previous 2 FY" value="3">Previous 2 FY</option>
						<option label="2 FY Ago" value="4">2 FY Ago</option>
						<option label="Current And Prvious FY" value="5">Current And Previous FY</option>
						<option label="Previous 2 FY" value="6">Previous 2 FY</option>
					</optgroup>
					<optgroup label="Fiscal Quater" >
						<option label="Current" value="7">Current FQ</option>
						<option label="Current and Next" value="8">Current and Next FQ</option>
						<option label="Current and Previous" value="9">Current and Previous FQ</option>
						<option label="Previous" value="10">Previous FQ</option>
					</optgroup>
					<optgroup label="Calendar Year">
						<option label="Current CY" value="11">Current CY</option>
						<option label="Previous CY" value="12">Previous CY</option>
						<option label="Current and Previous CY" value="13">Current and Previous CY</option>
					</optgroup>
					<optgroup label="Calendar Month">
						<option label="Current" value="14">Current CM</option>
						<option label="Previous" value="15">Previous CM</option>
						<option label="Current and Previous" value="16">Current and Previous CM</option>
					</optgroup>
					<optgroup label="Calendar Week">
						<option label="Current" value="17">Current CW</option>
						<option label="Previous" value="18">Previous CW</option>
						<option label="Current And Previous" value="19">Current and Previous CW</option>
					</optgroup>
					<optgroup label="Calendar Day">
						<option label="Today CD" value="20">Today CD</option>
						<option label="Yesterday CD" value="21">Yesterday CD</option>
						<option label="Last 7 CD" value="22">Last 7 CD</option>
						<option label="Last 30 CD" value="23">Last 30 CD</option>
						<option label="Last 60 CD" value="24">Last 60 CD</option>
						<option label="Last 90 CD" value="25">Last 90 CD</option>
						<option label="Last 120 CD" value="26">Last 120 CD</option>
					</optgroup>
				</SELECT>
			</TD>
			<TD>
				<img  class="deleteButton" src="images/icons/deleteRow.png"
					style="cursor: pointer; display: none;" />
			</TD>
		</TR>
	</TABLE>
	<br>	

	<h2>Advanced Filters</h2>
	<hr width="100%" size=1 color="black"> 
	<TABLE id="report_advanced_filters" class="tablesorter">
		<TR><TH>Logical Operator</TH><TH>Field</TH><TH>Operator</TH><TH>Prompt for value</TH><TH>Value</TH></TR>
		<TR rowIndex="0">
			<TD>
				<SELECT id="advancedFilters[0].logicalOperator"
					name="advancedFilters[0].logicalOperator">
					<option value="0"> </option>				
					<option value="1">And</option>
					<option value="2">Or</option>
				</SELECT>
			</TD>
			<TD>
				<SELECT id="advancedFilters[0].fieldId"
					name="advancedFilters[0].fieldId"
					<option label="None" value="-1">None</option>
					<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">
						<c:forEach var="f" items="${fgroup.fields}" varStatus="inner">
							<c:if test="${f != null }">
								<option label="${f.displayName}" value="${f.id}" >${f.displayName}</option>
							</c:if>
						</c:forEach>
					</c:forEach>
				</SELECT>
			</TD>
			<TD>
				<SELECT id="advancedFilters[0].operator"
					name="advancedFilters[0].operator">
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
				</SELECT>
			</TD>
			<TD>
				<input type="checkbox" 
					id="advancedFilters[0].promptForCriteria"
					name="advancedFilters[0].promptForCriteria" 
					checked="checked"
					value="true"
					onclick="document.getElementById(this.name + 'TextBox').disabled=this.checked;document.getElementById(this.name + 'TextBox').value='';">
			</TD>
			<TD>
				<input id="advancedFilters[0].promptForCriteriaTextBox" 
					name="advancedFilters[0].criteria"
					disabled="disabled">
			</TD>
			<TD>
				<img  class="deleteButton" src="images/icons/deleteRow.png"
					style="cursor: pointer; display: none;" />
			</TD>
		</TR>
	</Table>
	<br>

	<input type="hidden" value="0" id="customFiltersIndex" />
	<h2>Custom Filters</h2>
	<hr width="100%" size=1 color="black"> 
	<TABLE id="report_custom_filters" class="tablesorter">
		<TR><TH>Select custom filter(s) to add</TH><TH></TH></TR>
		<TR>
			<TD>
				<SELECT id="customFilterSelect"
					name="customFilterSelect"
					onchange="addCustomFilterRow(this, document.getElementById('customFiltersIndex'));"	
					style="width:500px;margin:5px 0 5px 0;">
					<option value="0">To add a custom filter, select it from the drop down list</option>
					<c:forEach var="customFilter" items="${customFilters}" varStatus="outer">
						<c:if test="${customFilter != null}">
							<option label="${customFilter.displayText}" value="${customFilter.id}">${customFilter.displayText}</option>
						</c:if>
					</c:forEach>
				</SELECT>
			</TD>
		</TR>
	</TABLE>
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


