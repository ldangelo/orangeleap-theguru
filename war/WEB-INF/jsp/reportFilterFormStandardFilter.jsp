<%@ include file="/WEB-INF/jsp/include.jsp"%>
<TABLE id="report_standard_filters" class="tablesorter" style="display: none;" bgcolor=#E0E0E0 >
	<TR index="-1" ><TH>Field</TH><TH>Comparison / Duration</TH><TH>Prompt for</TH><TH>Value</TH></TR>
	<TR index="-1" >
		<TD>
			<input type="hidden" value="1" objectname="reportFilters[INDEXREPLACEMENT].filterType" />
			<SELECT objectname="reportFilters[INDEXREPLACEMENT].reportStandardFilter.fieldId"
				onchange="filterCriteria(this); applyMasks($(this).parents('tr[index!=-1]'));"  style="width: 150px">
				<option label="None" value="-1">None</option>
				<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer"><optgroup label="${fgroup.name}"><c:forEach var="f" items="${fgroup.fields}" varStatus="inner"><c:if test="${f != null }"><option label="${f.displayName}" value="${f.id}" fieldType="${f.fieldType}"<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.fieldId == f.id)}"> selected="true"<c:if test="${f.fieldType == 'DATE'}"><c:set var="dateFieldSelected" scope="page" value="true"/></c:if></c:if>>${f.displayName}</option></c:if></c:forEach></optgroup></c:forEach>
			</SELECT>
		</TD>
		<TD><jsp:include page="/WEB-INF/jsp/reportFilterFormStandardFilterComparison.jsp" /></TD>
		<TD align=center><input type="checkbox" objectname="reportFilters[INDEXREPLACEMENT].reportStandardFilter.promptForCriteria" <c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.promptForCriteria == true)}">checked="checked"</c:if> value="true"	onclick="togglePromptForCriteriaTextBox(this);"	></TD>
		<TD><div class="criteriaWrapper"> <input objectname="reportFilters[INDEXREPLACEMENT].reportStandardFilter.criteria" style="width: 110px" <c:if test="${(dateFieldSelected != null) || (currentFilter == null) || ((currentFilter != null) && (currentFilter.reportStandardFilter.promptForCriteria == true))}">disabled="disabled"</c:if> <c:if test="${currentFilter != null}">value="${currentFilter.reportStandardFilter.criteria}"</c:if>> </div>
		</TD>
	</TR>
</Table>