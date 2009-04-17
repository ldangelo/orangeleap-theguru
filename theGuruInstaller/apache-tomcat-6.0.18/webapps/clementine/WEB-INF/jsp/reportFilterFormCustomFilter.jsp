<%@ include file="/WEB-INF/jsp/include.jsp"%>

<TABLE id="report_custom_filters" class="tablesorter" style="display: none;width: 520px" bgcolor=#E0E0E0 >
	<TR index="-1" ><TH>Custom filter criteria
		<input type="hidden" value="2" objectname="reportFilters[INDEXREPLACEMENT].filterType" />
	</TH></TR>
	<TR index="-1" >
		<TD>
			<c:choose>
				<c:when test="${(currentFilter == null || currentFilter.reportCustomFilter.customFilterDefinitionId == 0)}">
					<SELECT id="customFilterSelect"
						name="customFilterSelect"
						style="width:515px"
						onchange="populateCustomFilterRow(this, document.getElementById('report_filters_add'));" >
						<option value="0">Select a custom filter from the drop down list</option>
						<optgroup label="Custom Filters">
							<c:forEach var="customFilter" items="${customFilters}" varStatus="outer">
								<c:if test="${customFilter != null}">
									<option label="${customFilter.displayText}" value="${customFilter.id}" displayhtml="${customFilter.displayHtml}" >${customFilter.displayText}</option>
								</c:if>
							</c:forEach>
						</optgroup>
					</SELECT>
				</c:when>
				<c:otherwise>
					${currentFilter.reportCustomFilter.populatedDisplayHtml}
					<input type="hidden" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.customFilterDefinitionId" value="${currentFilter.reportCustomFilter.customFilterDefinitionId}" />
					<input type="hidden" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.displayHtml" value="${currentFilter.reportCustomFilter.displayHtml}" />
				</c:otherwise>
			</c:choose>
		</TD>
	</TR>
</TABLE>
