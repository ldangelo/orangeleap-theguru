<%@ include file="/WEB-INF/jsp/include.jsp" %>


<form:form method="post" commandName="rreportFormat">
		<h1>
			Report Wizard
		</h1>

		<h2>
		Report Column Order
		</h2>
<div class="columns">
<table>
<Tr><td>
<SELECT size="10" style="width:275px;">
		<OPTION>First Name</OPTION>
		<OPTION>Last Name</OPTION>>
		<OPTION>Middle Name</OPTION>>
		<OPTION>Address 1</OPTION>>
		<OPTION>Address 2</OPTION>>
		<OPTION>City</OPTION>>
		<OPTION>State</OPTION>>
		</SELECT></td>
<td>
	<div class="text">Top</div>
	<div class="text"><input type="button" title="Top" alt="Top" /></div>
	<div class "text">Up</div>
	<div class="text"><input type="button"  title="Up" alt="Up" /></div>
	<div class="text"><input type="button"  title="Up" alt="Up" /></div>
	<div class "text">Down</div>
	<div class="text"><input type="button"  title="Up" alt="Up" /></div>
	<div class "text">Bottom</div>
</td></Tr>
</table>
<br>
<br>
</div>
<input type="submit" value="Back" name="_target4">
<input type="submit" value="Next" name="_target6">


</form:form>


