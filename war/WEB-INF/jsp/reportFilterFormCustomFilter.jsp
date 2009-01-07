<%@ include file="/WEB-INF/jsp/include.jsp"%>

<TABLE id="report_custom_filters" class="tablesorter" style="display: none;width: 555px" bgcolor=#E0E0E0 >
	<TR><TH>Custom filter criteria
		<input type="hidden" value="2" objectname="reportFilters[INDEXREPLACEMENT].filterType" />
	</TH></TR>
	<TR>
		<TD>
			<c:choose>
				<c:when test="${(currentFilter == null)}">
					<SELECT id="customFilterSelect"
						name="customFilterSelect"
						style="width:545px"
						onchange="populateCustomFilterRow(this, document.getElementById('report_filters_add'));" >
						<option value="0">Select a custom filter from the drop down list</option>
						<optgroup>
							<c:forEach var="customFilter" items="${customFilters}" varStatus="outer">
								<c:if test="${customFilter != null}">
									<option label="${customFilter.displayText}" value="${customFilter.id}" displayhtml="${customFilter.displayHtml}">${customFilter.displayText}</option>
								</c:if>
							</c:forEach>
						</optgroup>
					</SELECT>
				</c:when>
				<c:otherwise>
					${currentFilter.reportCustomFilter.populatedDisplayHtml}
					<input type="hidden" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.customFilterId" value="${currentFilter.reportCustomFilter.customFilterId}"
					<input type="hidden" objectname="reportFilters[INDEXREPLACEMENT].reportCustomFilter.displayHtml" value="${currentFilter.reportCustomFilter.displayHtml}"
				</c:otherwise>
			</c:choose>
		</TD>
	</TR>
</TABLE>
