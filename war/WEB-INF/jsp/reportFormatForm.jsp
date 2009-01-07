<%@ include file="/WEB-INF/jsp/include.jsp"%>
<mp:page pageName='ReportFormat' />


<form:form method="post" commandName="reportsource">
	<h1>Report Wizard</h1>
	<h2>Select the report type</h2>
	<hr width="100%" size=1 color="black">
	<div class="columns">
	<TABLE>
		<TR>
			<TD style="width:350px">
				<input type="radio" name="reportType" value="tabular"
					title="Tabular Report" 
					<c:if test="${reportType == 'tabular'}"> checked="true" </c:if>
				/>
				<span id="tabularSpan" style="text-decoration : underline;" onmouseover="document.getElementById('tabularSummaryImage').src = 'images/reporttabularstyle.gif';" >Tabular</span>
				or
				<span id="summarySpan" style="text-decoration : underline;" onmouseover="document.getElementById('tabularSummaryImage').src = 'images/reportsummarystyle.gif';" >Summary</span>
				Report
			</TD>
			<TD>
				<input type="radio" name="reportType" value="matrix"
					title="Matrix Report"
					<c:if test="${reportType == 'matrix'}"> checked="true" </c:if> 
				/>Matrix Report</TD>
		</TR>
		<TR>
			<TD><img width="203" height="87" id="tabularSummaryImage" title="Tabular Report"
				alt="Tabular Report" src="images/reporttabularstyle.gif" /></TD>
			<TD><img width="203" height="87" title="Matrix Report"
				alt="Matrix Report" src="images/reportmatrixstyle.gif" /></TD>
		</TR>
		<TR valign="top">
			<TD>Tabular reports are the simplest and fastest<br> way to list your data.<br><br>Summary reports list your data with sub-totals<br> and other summary information.</TD>

			<TD>Matrix reports list summaries of your data in<br> a grid against both horizontal and vertical criteria.</TD>
		</TR>
	</TABLE>
	<br>
	<h2>Select the report layout</h2>
	<hr width="100%" size=1 color="black">
	<TABLE>
		<TR>
			<TD><form:select path="reportTemplatePath" multiple="false">
				<form:options items="${reportsource.reportTemplateList}"
					itemLabel="description" itemValue="uriString" />
			</form:select></TD>
		</TR>
	</TABLE>
	<BR>
	</div>
	<jsp:include page="snippets/navbuttons.jsp" />
</form:form>
