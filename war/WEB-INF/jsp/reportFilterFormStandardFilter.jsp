<%@ include file="/WEB-INF/jsp/include.jsp"%>

<TABLE id="report_standard_filters" class="tablesorter" style="display: none;" bgcolor=#E0E0E0 >
	<TR index="-1" ><TH>Field</TH><TH>Comparison / Duration</TH><TH>Prompt for</TH><TH>Value</TH></TR>
	<TR index="-1" >
		<TD>
			<input type="hidden" value="1" objectname="reportFilters[INDEXREPLACEMENT].filterType" />
			<SELECT objectname="reportFilters[INDEXREPLACEMENT].reportStandardFilter.fieldId" 
				onchange="filterCriteria(this);"  style="width: 150px">
				<option label="None" value="-1">None</option>
				<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">
					<optgroup label="${fgroup.name}">
						<c:forEach var="f" items="${fgroup.fields}" varStatus="inner">
							<c:if test="${f != null }">
								<option label="${f.displayName}" value="${f.id}" fieldType="${f.fieldType}" 
									<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.fieldId == f.id)}">
										selected="true"
										<c:if test="${f.fieldType == 'DATE'}">
											<c:set var="dateFieldSelected" scope="page" value="true"/>
										</c:if>
									</c:if>
									>${f.displayName}</option>
							</c:if>
						</c:forEach>
					</optgroup>
				</c:forEach>
			</SELECT>
		</TD>
		<TD>
			<SELECT objectname="reportFilters[INDEXREPLACEMENT].reportStandardFilter.comparison" style="width: 140px"
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
				<!-- Date only options -->
				<optgroup label="Fiscal Year" dateonly="true" 
					<c:if test="${dateFieldSelected == null}"> style="display: none;" </c:if> >
					<option label="Current FY" value="20" dateonly="true" 
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 20)}"> selected="true" </c:if> >Current FY</option>
					<option label="Previous FY" value="21" dateonly="true" 
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 21)}"> selected="true" </c:if> >Previous FY</option>
					<option label="Previous 2 FY" value="22" dateonly="true" 
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 22)}"> selected="true" </c:if> >Previous 2 FY</option>
					<option label="2 FY Ago" value="23" dateonly="true"  
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 23)}"> selected="true" </c:if> >2 FY Ago</option>
					<option label="Current And Prvious FY" value="24" dateonly="true"  
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 24)}"> selected="true" </c:if> >Current And Previous FY</option>
					<option label="Previous 2 FY" value="25" dateonly="true"  
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 25)}"> selected="true" </c:if> >Previous 2 FY</option>
				</optgroup>
				<optgroup label="Fiscal Quater" dateonly="true" 
					<c:if test="${dateFieldSelected == null}"> style="display: none;" </c:if> >
					<option label="Current" value="26" dateonly="true"  
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 26)}"> selected="true" </c:if> >Current FQ</option>
					<option label="Current and Next" value="27" dateonly="true"  
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 27)}"> selected="true" </c:if> >Current and Next FQ</option>
					<option label="Current and Previous" value="28" dateonly="true"
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 28)}"> selected="true" </c:if> >Current and Previous FQ</option>
					<option label="Previous" value="29" dateonly="true"  
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 29)}"> selected="true" </c:if> >Previous FQ</option>
				</optgroup>
				<optgroup label="Calendar Year" dateonly="true" 
					<c:if test="${dateFieldSelected == null}"> style="display: none;" </c:if> >
					<option label="Current CY" value="30" dateonly="true"  
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 30)}"> selected="true" </c:if> >Current CY</option>
					<option label="Previous CY" value="31" dateonly="true"  
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 31)}"> selected="true" </c:if> >Previous CY</option>
					<option label="Current and Previous CY" value="32" dateonly="true"
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 32)}"> selected="true" </c:if> >Current and Previous CY</option>
				</optgroup>
				<optgroup label="Calendar Month" dateonly="true" 
					<c:if test="${dateFieldSelected == null}"> style="display: none;" </c:if> >
					<option label="Current" value="33" dateonly="true"
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 33)}"> selected="true" </c:if> >Current CM</option>
					<option label="Previous" value="34" dateonly="true"
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 34)}"> selected="true" </c:if> >Previous CM</option>
					<option label="Current and Previous" value="35" dateonly="true"
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 35)}"> selected="true" </c:if> >Current and Previous CM</option>
				</optgroup>
				<optgroup label="Calendar Week" dateonly="true" 
					<c:if test="${dateFieldSelected == null}"> style="display: none;" </c:if> >
					<option label="Current" value="36" dateonly="true"
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 36)}"> selected="true" </c:if> >Current CW</option>
					<option label="Previous" value="37" dateonly="true"
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 37)}"> selected="true" </c:if> >Previous CW</option>
					<option label="Current And Previous" value="38" dateonly="true"
						<c:if test="${(currentFilter != null) && (currentFilter.reportStandardFilter.comparison == 38)}"> selected="true" </c:if> >Current and Previous CW</option>
				</optgroup>
				<optgroup label="Calendar Day" dateonly="true" 
					<c:if test="${dateFieldSelected == null}"> style="display: none;" </c:if> >
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
			</SELECT>
		</TD>
		<TD align=center>
			<input type="checkbox" objectname="reportFilters[INDEXREPLACEMENT].reportStandardFilter.promptForCriteria"
				<c:if test="${(currentFilter == null) || ((currentFilter != null) && (currentFilter.reportStandardFilter.promptForCriteria == true))}">
					checked="checked"
				</c:if>
				<c:if test="${dateFieldSelected != null}"> disabled="disabled" </c:if>
				value="true"
				onclick="togglePromptForCriteriaTextBox(this);"	>
		</TD>
		<TD>
			<input objectname="reportFilters[INDEXREPLACEMENT].reportStandardFilter.criteria" style="width: 110px" 
				<c:if test="${(dateFieldSelected != null) || (currentFilter == null) || ((currentFilter != null) && (currentFilter.reportStandardFilter.promptForCriteria == true))}">
				disabled="disabled"
				</c:if>
				<c:if test="${currentFilter != null}">
					value="${currentFilter.reportStandardFilter.criteria}"
				</c:if>
			>
		</TD>
	</TR>
</Table>
