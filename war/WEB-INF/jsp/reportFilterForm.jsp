<%@ include file="/WEB-INF/jsp/include.jsp"%>


<form method="post">

<h2>Enter filter Information</h2>
<div class="columns">
<h3>Filter Information</h3>
<Table>
<h1>Standard Filters</h1>
	<Table id="report_standard_filters" >
<TR><TH>Fields</TH><TH>Duration</TH></TR>
<TR>
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
</TR>
</TABLE>
<h1>Advanced Filters</h1>
<TABLE id="report_advanced_filters" class="tablesorter">
<TR><TH>Field</TH><TH>Operator</TH><TH>Prompt for value</TH><TH>Value</TH></TR>
		<TR rowIndex="0">
			<TD><SELECT id="advancedFilters[0].fieldId"
				name="advancedFilters[0].fieldId">
				<option label="None" value="-1">None</option>
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
				<option value="5">less or equal</option>
				<option value="6">greater or equal</option>
				<option value="7">starts with</option>				
				<option value="8">ends with</option>
				<option value="9">contains</option>
				<option value="10">does not contain</option>
			</SELECT></TD>

			<TD><input type="checkbox" 
				id="advancedFilters[0].promptForCriteria"
				name="advancedFilters[0].promptForCriteria" 
				checked="checked"
				value="true"
				onclick="document.getElementById(this.name + 'TextBox').disabled=this.checked;document.getElementById(this.name + 'TextBox').value='';">
			</TD>

			<TD><input id="advancedFilters[0].promptForCriteriaTextBox" 
				name="advancedFilters[0].criteria"
				disabled="disabled">
			</TD>

			<TD><img  class="deleteButton" src="images/icons/deleteRow.png"
				style="cursor: pointer; display: none;" /></TD>
		</TR>
	</Table>

	<TR></TR>
	<TR></TR>
<h1>Limit Row</h1>
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


