<%@ include file="/WEB-INF/jsp/include.jsp"%>
<TR rowIndex="${rowIndex}">
	<TD style="width: 360px"><SELECT
		id="reportCrossTabFields.reportCrossTabRows[${rowIndex}].fieldId"
		name="reportCrossTabFields.reportCrossTabRows[${rowIndex}].fieldId"
		style="width: 260px">
		<option label="" value="-1" selected></option>
		<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">
			<c:forEach var="f" items="${fgroup.fields}" varStatus="inner">
				<c:if test="${f != null }">
					<option label="${f.displayName}" value="${f.id}"
						<c:if test="${fieldId != -1 && fieldId == f.id}">
							selected="true"
						</c:if>
					>${f.displayName}</option>
				</c:if>
			</c:forEach>
		</c:forEach>
	</SELECT></TD>

	<TD style="width: 360px"><SELECT
		id="reportCrossTabFields.reportCrossTabRows[${rowIndex}].sortOrder"
		name="reportCrossTabFields.reportCrossTabRows[${rowIndex}].sortOrder"
		style="width: 260px">
		<option value="ASC"
			<c:if test="${(sortOrder != null) && (sortOrder == 'ASC')}">
				selected="true"
			</c:if>
		>Ascending</option>
		<option value="DESC"
			<c:if test="${(sortOrder != null) && (sortOrder == 'DESC')}">
				selected="true"
			</c:if>
		>Descending</option>
	</SELECT></TD>

	<!--  			<TD><SELECT id="reportCrossTabFields.reportCrossTabRows[0].groupDateByOption"
				name="reportCrossTabFields.reportCrossTabRows[0].groupDateByOption"
				disabled="disabled">
				<option value="1">Day</option>
				<option value="2">Month</option>
				<option value="3">Year</option>
			</SELECT></TD>-->

	<TD><img class="deleteButton" src="images/icons/deleteRow.png"
		<c:if test="${fieldId == -1 && (sortOrder == '' || sortOrder == 'ASC')}">
			style="cursor: pointer; display: none;"
		</c:if>
	/></TD>
</TR>
