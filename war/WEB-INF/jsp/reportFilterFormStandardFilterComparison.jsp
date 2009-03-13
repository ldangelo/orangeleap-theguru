<%@ include file="/WEB-INF/jsp/include.jsp"%>
<SELECT objectname="reportFilters[INDEXREPLACEMENT].reportStandardFilter.comparison" 
	<c:if test="${comparisonSelectId != null && comparisonSelectId != ''}"> id="${comparisonSelectId}" style="width: 140px;display:none" </c:if>
	<c:if test="${comparisonSelectId == null || comparisonSelectId == ''}"> style="width: 140px;" </c:if>
	onchange="displayPromptForCriteriaOptions(this);" >

	<option value="1" 
		<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 1)}"> selected="true" </c:if> >equals</option>
	<option value="3" 
		<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 3)}"> selected="true" </c:if> >less than</option>
	<option value="5"
		<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 5)}"> selected="true" </c:if> >less than or equal to</option>
	<option value="4"
		<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 4)}"> selected="true" </c:if> >greater than</option>
	<option value="6"
		<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 6)}"> selected="true" </c:if> >greater than or equal to</option>
	<option value="7"
		<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 7)}"> selected="true" </c:if> >starts with</option>
	<option value="8"
		<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 8)}"> selected="true" </c:if> >ends with</option>
	<option value="9"
		 <c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 9)}"> selected="true" </c:if> >contains</option>
	<option value="11"
		 <c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 11)}"> selected="true" </c:if> >has any value</option>
	<c:if test="${dateFieldSelected == null || (comparisonSelectId != null && comparisonSelectId != '')}">					 
		<!-- Date only options -->
		<optgroup label="Fiscal Year" dateonly="true" >
			<option label="Current FY" value="20" dateonly="true" 
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 20)}"> selected="true" </c:if> >Current FY</option>
			<option label="Previous FY" value="21" dateonly="true" 
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 21)}"> selected="true" </c:if> >Previous FY</option>
			<option label="Previous 2 FY" value="22" dateonly="true" 
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 22)}"> selected="true" </c:if> >Previous 2 FY</option>
<!-- 		<option label="2 FY Ago" value="23" dateonly="true"  
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 23)}"> selected="true" </c:if> >2 FY Ago</option>-->
			<option label="Current And Prvious FY" value="24" dateonly="true"  
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 24)}"> selected="true" </c:if> >Current And Previous FY</option>
		</optgroup>
		<optgroup label="Fiscal Quarter" dateonly="true" > 
			<option label="Current FQ" value="26" dateonly="true"  
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 26)}"> selected="true" </c:if> >Current FQ</option>
			<option label="Current and Next FQ" value="27" dateonly="true"  
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 27)}"> selected="true" </c:if> >Current and Next FQ</option>
			<option label="Current and Previous FQ" value="28" dateonly="true"
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 28)}"> selected="true" </c:if> >Current and Previous FQ</option>
			<option label="Previous FQ" value="29" dateonly="true"  
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 29)}"> selected="true" </c:if> >Previous FQ</option>
		</optgroup>
		<optgroup label="Calendar Year" dateonly="true" > 
			<option label="Current CY" value="30" dateonly="true"  
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 30)}"> selected="true" </c:if> >Current CY</option>
			<option label="Previous CY" value="31" dateonly="true"  
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 31)}"> selected="true" </c:if> >Previous CY</option>
			<option label="Current and Previous CY" value="32" dateonly="true"
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 32)}"> selected="true" </c:if> >Current and Previous CY</option>
		</optgroup>
		<optgroup label="Calendar Month" dateonly="true" > 
			<option label="Current CM" value="33" dateonly="true"
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 33)}"> selected="true" </c:if> >Current CM</option>
			<option label="Previous CM" value="34" dateonly="true"
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 34)}"> selected="true" </c:if> >Previous CM</option>
			<option label="Current and Previous CM" value="35" dateonly="true"
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 35)}"> selected="true" </c:if> >Current and Previous CM</option>
		</optgroup>
		<optgroup label="Calendar Week" dateonly="true" > 
			<option label="Current CW" value="36" dateonly="true"
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 36)}"> selected="true" </c:if> >Current CW</option>
			<option label="Previous CW" value="37" dateonly="true"
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 37)}"> selected="true" </c:if> >Previous CW</option>
			<option label="Current And Previous CW" value="38" dateonly="true"
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 38)}"> selected="true" </c:if> >Current and Previous CW</option>
		</optgroup>
		<optgroup label="Calendar Day" dateonly="true" > 
			<option label="Today CD" value="39" dateonly="true"
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 39)}"> selected="true" </c:if> >Today CD</option>
			<option label="Yesterday CD" value="40" dateonly="true"
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 40)}"> selected="true" </c:if> >Yesterday CD</option>
			<option label="Last 7 CD" value="41" dateonly="true"
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 41)}"> selected="true" </c:if> >Last 7 CD</option>
			<option label="Last 30 CD" value="42" dateonly="true"
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 42)}"> selected="true" </c:if> >Last 30 CD</option>
			<option label="Last 60 CD" value="43" dateonly="true"
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 43)}"> selected="true" </c:if> >Last 60 CD</option>
			<option label="Last 90 CD" value="44" dateonly="true"
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 44)}"> selected="true" </c:if> >Last 90 CD</option>
			<option label="Last 120 CD" value="45" dateonly="true"
				<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 45)}"> selected="true" </c:if> >Last 120 CD</option>
		</optgroup>
	</c:if>
</SELECT>
