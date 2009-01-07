
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<script type="text/javascript" src="js/mpower.reportfilters.js"></script>

<form method="post">

<!--  hidden tables cloned to add new filters -->
<c:set var="filterIndex" scope="request" value="0"/>
<jsp:include page="/WEB-INF/jsp/reportFilterFormStandardFilter.jsp" />
<jsp:include page="/WEB-INF/jsp/reportFilterFormCustomFilter.jsp" />
<jsp:include page="/WEB-INF/jsp/reportFilterFormOperators.jsp" />
<jsp:include page="/WEB-INF/jsp/reportFilterFormActions.jsp" />
<jsp:include page="/WEB-INF/jsp/reportFilterFormBeginGroup.jsp" />
<jsp:include page="/WEB-INF/jsp/reportFilterFormEndGroup.jsp" />


<h1>Report Wizard</h1>
<div class="columns">
 	<h2>Select filters for the report</h2>
	<hr width="100%" size=1 color="black">
	<table id="report_filters_select" class="tablesorter" >
		<TR><TH>Add Filter</TH></TR>
	</table>
	<select id="addFilterSelect" name="addFilterSelect"
		onchange="cloneFilterRow(this, document.getElementById('report_filters_add'));">
		<option label="Select type of filter to add" value="0">Select type of filter to add</option>
		<optgroup>
			<option label="Standard Filter" value="1">Standard Filter</option>
			<option label="Custom Filter" value="2">Custom Filter</option>
			<option label="Group" value="3">Group</option>
		</optgroup>
	</select>
	<br>
	<br>
 	<table id="report_filters_add" class="tablesorter" index="0" bgcolor=#E0E0E0 >
		<tr><th>Selected Filters</th></tr>
        <c:set var="filterIndex" scope="request" value="0"/>	
	    <c:forEach var="filter" items="${selectedFilters}" varStatus="outer">
			<c:set var="currentFilter" scope="request" value="${filter}"/>
			<tr index="${filterIndex}">
				<td><jsp:include page="/WEB-INF/jsp/reportFilterFormOperators.jsp" /></td>
				<td>
					<c:choose>
						<c:when test='${filter.filterType == 1}'>
							<jsp:include page="/WEB-INF/jsp/reportFilterFormStandardFilter.jsp" />
						</c:when>
						<c:when test='${filter.filterType == 2}'>
							<jsp:include page="/WEB-INF/jsp/reportFilterFormCustomFilter.jsp" />
						</c:when>
						<c:when test='${filter.filterType == 3}'>
							<jsp:include page="/WEB-INF/jsp/reportFilterFormBeginGroup.jsp" />
						</c:when>
						<c:when test='${filter.filterType == 4}'>
							<jsp:include page="/WEB-INF/jsp/reportFilterFormEndGroup.jsp" />
						</c:when>
					</c:choose>
				</td>
				<td><jsp:include page="/WEB-INF/jsp/reportFilterFormActions.jsp" /></td>
			</tr>
			<c:set var="filterIndex" scope="request" value="${filterIndex + 1}"/>
		</c:forEach>
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
					<option value="-1"
						<c:if test="${rowCount == -1}"> selected="true" </c:if>
					>All</option>
					<option value="10"
						<c:if test="${rowCount == 10}"> selected="true" </c:if>
					>10</option>
					<option value="25"
						<c:if test="${rowCount == 25}"> selected="true" </c:if>
					>25</option>
					<option value="50"
						<c:if test="${rowCount == 50}"> selected="true" </c:if>
					>50</option>
					<option value="100"
						<c:if test="${rowCount == 100}"> selected="true" </c:if>
					>100</option>
					<!-- <option>Custom</option> -->
			</TD>
		</TR>
<!--		<TR>
			<TD>
				<input type="checkbox" value="no" name="details" />Hide report details
			</TD>
		</TR>-->
	</Table>
	<br>
	<br>
	<br>
</div>
<jsp:include page="snippets/navbuttons.jsp" /></form>

