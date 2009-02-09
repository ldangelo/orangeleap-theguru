<%@ include file="/WEB-INF/jsp/include.jsp"%>

<TR rowIndex="${measureIndex}">
	<TD style="width: 360px">
	<SELECT 
		id="reportCrossTabFields.reportCrossTabMeasure[${measureIndex}].fieldId"
		name="reportCrossTabFields.reportCrossTabMeasure[${measureIndex}].fieldId"
		onchange="fillCalcOptions(this); "
		style="width: 260px">
		<option label="" value="-1" selected></option>
		<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">
			<optgroup label="${fgroup.name}">
				<c:forEach var="f" items="${fgroup.fields}" varStatus="inner">
					<c:if test="${f != null }">
						<option label="${f.displayName}" value="${f.id}" fieldType="${f.fieldType}"
							<c:if test="${fieldId != -1 && fieldId == f.id}">
								selected="true"
							</c:if>
						>${f.displayName}</option>
					</c:if>
				</c:forEach>
			</optgroup>
		</c:forEach>
	</SELECT></TD>


	<TD style="width:390px"><SELECT id="reportCrossTabFields.reportCrossTabOperation"
				name="reportCrossTabFields.reportCrossTabOperation"
				style="width:260px" >
				<!-- <option value="SUM" <c:if test="${matrixOperation == 'SUM'}">selected="true"</c:if>>Sum</option>
				<option value="AVERAGE" <c:if test="${matrixOperation == 'AVERAGE'}">selected="true"</c:if>>Average</option>
				<option value="MAX" <c:if test="${matrixOperation == 'MAX'}">selected="true"</c:if>>Max</option>
				<option value="MIN" <c:if test="${matrixOperation == 'MIN'}">selected="true"</c:if>>Min</option>
				<option value="COUNT" <c:if test="${matrixOperation == 'COUNT'}">selected="true"</c:if>>Count</option>
				 -->
				<!-- options -->
				<!-- <c:if test="${dateFieldSelected == null}"> style="display: none;" </c:if> > -->
					<option label="Sum" value="SUM" moneyonly="true" 
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 20)}"> selected="true" </c:if> >Sum</option>
					<option label="Average" value="AVERAGE" moneyonly="true" 
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 21)}"> selected="true" </c:if> >Average</option>
					<option label="Max" value="MAX" moneyonly="false" 
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 22)}"> selected="true" </c:if> >Max</option>
					<option label="Min" value="MIN" moneyonly="false"  
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 23)}"> selected="true" </c:if> >Min</option>
					<option label="Count" value="COUNT" moneyonly="false"  
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 24)}"> selected="true" </c:if> >Count</option>
			</SELECT></TD>
<!--  
	<TD style="width: 360px"><SELECT
		id="reportCrossTabFields.reportCrossTabMeasure[${measureIndex}].sortOrder"
		name="reportCrossTabFields.reportCrossTabMeasure[${measureIndex}].sortOrder"
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
-->
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
