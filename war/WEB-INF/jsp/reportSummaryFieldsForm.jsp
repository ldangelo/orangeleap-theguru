<%@ include file="/WEB-INF/jsp/include.jsp" %>


<form:form method="post" commandName="rreportFormat">
		<h1>
			Report Wizard
		</h1>

		<h2>
		Select the summary information and summary type
		</h2>
<div class="columns">
	<h3>Standard Summary Fields</h3>
<Table>	
<TR>
<TH>Columns</TH><TH>        </TH><TH>Sum</TH><TH>Average</TH><TH>Largest Value</TH><TH>Smallest Value</TH>
</TR>
<TR>
<TD>Record Count</TD><TD>        </TD><TD><input type="checkbox" /></TD><TD><input type="checkbox" /></TD><TD><input type="checkbox" /></TD><TD><input type="checkbox" /></TD>

</TR>
<TR>
<TR>
</TR>
</Table>
<br>

<br>
<br>
</div>
<input type="submit" value="Back" name="_target3">
<input type="submit" value="Next" name="_target5">
</form:form>


