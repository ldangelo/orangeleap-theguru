<%@ include file="/WEB-INF/jsp/include.jsp" %>
<mp:page pageName='ReportFormat'/>


<form:form method="post" commandName="reportsource">
		<h1>
			Report Wizard
		</h1>

		<h2>
		Select the report type
		</h2>
<div class="columns">
<TABLE>
<TR>
<TD>
<form:radiobutton path="reportType" value="tabular" title="Tabular Report" />Tabular Report
</TD>
<TD>
<form:radiobutton path="reportType" value="summary" title="Summary Report" />Summary Report
</TD>
<TD>
<form:radiobutton path="reportType" value="matrix" title="Matrix Report" />Matrix Report
</TD>
</TR>
<TR>
<TD>
<img width="203" height="87" title="Tabular Report" alt="Tabular Report" src="images/reporttabularstyle.gif"/>
</TD>
<TD>
<img width="203" height="87" title="Summary Report" alt="Summary Report" src="images/reportsummarystyle.gif"/>
</TD>
<TD>
<img width="203" height="87" title="Matrix Report" alt="Matrix Report" src="images/reportmatrixstyle.gif"/></TD>
</TR>
<TR>
<TD>Tabular reports are the simplest and fastest way to list your data.
</TD>
<TD>Summary reports list your data with subtotals and other summary information.
</TD>
<TD>Matrix reports list summaries of your data in a grid against both horizontal and vertical criteria.
</TD>
</TR>
</TABLE>

		<h2>
		Select the report layout
		</h2>

<TABLE>
<TR>
<TD><SELECT id="reportLayout"
	name="reportLayout">
	<option value="PORTRAIT">Portrait</option>
	<option value="LANDSCAPE">Landscape</option>
</SELECT></TD>
</TR>
</TABLE>
</div>
<jsp:include page="snippets/navbuttons.jsp"/>
</form:form>


