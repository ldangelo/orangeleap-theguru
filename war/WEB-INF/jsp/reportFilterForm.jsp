
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<script type="text/javascript" src="js/mpower.reportfilters.js"></script>

<form:form method="post" commandName="reportsource">
	<jsp:include page="snippets/formerrors.jsp"/>
<!--  hidden tables cloned to add new filters -->
<c:set var="filterIndex" scope="request" value="0"/>
<jsp:include page="/WEB-INF/jsp/reportFilterFormStandardFilter.jsp" />
<jsp:include page="/WEB-INF/jsp/reportFilterFormCustomFilter.jsp" />
<jsp:include page="/WEB-INF/jsp/reportFilterFormOperators.jsp" />
<jsp:include page="/WEB-INF/jsp/reportFilterFormActions.jsp" />
<jsp:include page="/WEB-INF/jsp/reportFilterFormBeginGroup.jsp" />
<jsp:include page="/WEB-INF/jsp/reportFilterFormEndGroup.jsp" />
<c:set var="comparisonSelectId" scope="request" value="baseComparisonSelect"/>
<jsp:include page="/WEB-INF/jsp/reportFilterFormStandardFilterComparison.jsp" />
<c:set var="comparisonSelectId" scope="request" value=""/>

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
		<optgroup label="Filter types">
			<option label="Standard Filter" value="1">Standard Filter</option>
			<option label="Custom Filter" value="2">Custom Filter</option>
			<option label="Group" value="3">Group</option>
		</optgroup>
	</select>
	<br>
	<br>
 	<table id="report_filters_add" class="tablesorter" index="0" bgcolor=#E0E0E0 >
		<tr index="-1" ><th>Selected Filters</th></tr>
        <c:set var="filterIndex" scope="request" value="0"/>
	    <c:forEach var="filter" items="${selectedFilters}" varStatus="outer">
			<c:set var="currentFilter" scope="request" value="${filter}"/>
			<tr index="${filterIndex}">
				<td><jsp:include page="/WEB-INF/jsp/reportFilterFormOperators.jsp" /></td>
				<td><c:choose><c:when test='${filter.filterType == 1}'><jsp:include page="/WEB-INF/jsp/reportFilterFormStandardFilter.jsp" /></c:when><c:when test='${filter.filterType == 2}'><jsp:include page="/WEB-INF/jsp/reportFilterFormCustomFilter.jsp" /></c:when><c:when test='${filter.filterType == 3}'><jsp:include page="/WEB-INF/jsp/reportFilterFormBeginGroup.jsp" /></c:when><c:when test='${filter.filterType == 4}'><jsp:include page="/WEB-INF/jsp/reportFilterFormEndGroup.jsp" /></c:when></c:choose>
				</td>
				<td><jsp:include page="/WEB-INF/jsp/reportFilterFormActions.jsp" /></td>
			</tr>
			<c:set var="filterIndex" scope="request" value="${filterIndex + 1}"/>
		</c:forEach>
		<c:if test="${filterIndex == 0}">
			<tr index="${filterIndex}">
				<td><jsp:include page="/WEB-INF/jsp/reportFilterFormOperators.jsp" /></td>
				<td><jsp:include page="/WEB-INF/jsp/reportFilterFormStandardFilter.jsp" /></td>
				<td><jsp:include page="/WEB-INF/jsp/reportFilterFormActions.jsp" /></td>
			</tr>
		</c:if>
	</table>
	<br>
	<br>
	<Table id="limit_row_count" class="tablesorter">
		<h2>Limit Row Count</h2>
		<hr width="100%" size=1 color="black">
		<TR><TH>Limit the number of rows displayed in this report.</TH></TR>
		<TR>
			<TD>
				<SELECT id="rowCountSelect" name="rowCountSelect" onchange="updateRowCountInput(this);">
					<option value="-1"<c:if test="${rowCount == -1}"> selected="true" </c:if>>All</option>
					<option value="10"<c:if test="${rowCount == 10}"> selected="true" </c:if>>10</option>
					<option value="25"<c:if test="${rowCount == 25}"> selected="true" </c:if>>25</option>
					<option value="50"<c:if test="${rowCount == 50}"> selected="true" </c:if>>50</option>
					<option value="100"<c:if test="${rowCount == 100}"> selected="true" </c:if>>100</option>
					<option value=""<c:if test="${rowCount != -1 && rowCount != 10 && rowCount != 25 &&	rowCount != 50 && rowCount != 100}"> selected="true" </c:if>>Custom</option>
				</SELECT>
				<input id="rowCount" name="rowCount" value="${rowCount}"<c:if test="${rowCount == -1 || rowCount == 10 || rowCount == 25 ||	rowCount == 50 || rowCount == 100}"> style="display:none" </c:if>/>
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
 	<h2>Advanced Options</h2>
	<hr width="100%" size=1 color="black">
	<c:if test="${segmentationTypeCount > 0}" >
	<table id="report_segmentation_options" class="tablesorter" >
		<TR><TH><input type="checkbox" id="useReportAsSegmentation" name="useReportAsSegmentation" value="true"
		onchange="if ($('#useReportAsSegmentation').attr('checked')) { $('#segmentationTypeDiv').show(); } else { $('#segmentationTypeDiv').hide(); }  cleanUpFilterTable('#report_filters_add');"
		<c:if test="${useReportAsSegmentation}">checked="true"</c:if>/>Use report as segmenation (disables Prompt for Value options)</TH></TR>
	</table>
	<div id="segmentationTypeDiv" name="segmentationTypeDiv" <c:if test="${!useReportAsSegmentation}">style="display:none"> </c:if>
		<select id="reportSegmentationTypeId" name="reportSegmentationTypeId" >
		<c:forEach var="segmentationType" items="${segmentationTypes}" varStatus="outer"><c:if test="${segmentationType != null}"><option label="${segmentationType.segmentationType}" value="${segmentationType.id}" <c:if test="${segmentationType.id == segmentationTypeId}">selected="true" </c:if>>${segmentationType.segmentationType}</option></c:if></c:forEach>
		</select>
		<br>
		<br>
	</div>
	</c:if>
	<table class="tablesorter" id="showSqlQueryTable">
		<th>
			<span id="showSqlQuerySpan" style="cursor: pointer;text-decoration:underline;" onclick="showSqlQueryClick();" >Show SQL Query</span>
			<input type="checkbox" style="display:none" id="showSqlQuery" name="showSqlQuery" value="true" />
		</th>
	</table>
    <br>
	<br>
	<br>
</div>
<jsp:include page="snippets/navbuttons.jsp" />
</form:form>


<c:if test="${showSqlQuery && sqlQuery != null && sqlQuery != ''}">
	<div id="dialog" class="jqmWindow jqmID1" style="z-index: 3000; margin-left: -207.5px; margin-top: -159px; display: block;">
	  <div class="modalTopLeft">
		<div class="modalTopRight">
			<h4 id="modalTitle" class="dragHandle">
				Report SQL Query</h4>
			<a class="jqmClose hideText" href="javascript:void(0)">Close</a>
		</div>
	  </div>
	  <div class="modalContentWrapper">
		<div class="modalContent">
			<TEXTAREA id="sqlQuery" ROWS="15" COLS="100">${sqlQuery}</TEXTAREA>
		</div>
		<div class="modalSideRight"></div>
	  </div>
	  <div class="modalBottomLeft"> 
	    <div class="modalBottomRight"></div>
	  </div>
	</div>
</c:if>
