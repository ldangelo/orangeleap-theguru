<%@ include file="/WEB-INF/jsp/include.jsp"%>
<table id="report_filters_operator" class="tablesorter" style="display: none;" bgcolor=#E0E0E0 >
	<tr index="-1" ><th>Operators</th></tr>
	<TR index="-1" >
		<TD>
			<SELECT objectname="reportFilters[INDEXREPLACEMENT].operator" >
				<option value="0" 
					<c:if test="${(currentFilter != null) && (currentFilter.operator == 0)}"> selected="true" </c:if>			 
					>And
				</option>
				<option value="1"
					<c:if test="${(currentFilter != null) && (currentFilter.operator == 1)}"> selected="true" </c:if> >Or
				</option>
			</SELECT>
			<SELECT objectname="reportFilters[INDEXREPLACEMENT].operatorNot" >
				<option value="0"
					<c:if test="${(currentFilter != null) && (currentFilter.operatorNot == 0)}"> selected="true" </c:if> ></option>
				<option value="1"
					<c:if test="${(currentFilter != null) && (currentFilter.operatorNot == 1)}"> selected="true" </c:if> >Not</option>
			</SELECT>
		</TD>
	</TR>
</table>
