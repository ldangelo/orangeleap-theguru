<%@ include file="/WEB-INF/jsp/include.jsp" %>


<form method="post">
		<h1>
			Report Wizard
		</h1>

		<h2>
		Report Column Order
		</h2>
<div class="columns">
<table>
<Tr><td>
	<select id="fieldOrder" name="fieldOrder" size="10">
		<c:forEach var="f" items="${fields}" varStatus="inner">
			<option id=${f.id}>${f.displayName}</option>
		</c:forEach>
	</select>
</td>
<td>
	<div class="text">Top</div>
	<div class="text"><input type="button" title="Top" alt="Top" onclick="moveTop(document.getElementById('fieldOrder'));updateList(document.getElementById('fieldOrder'), document.getElementById('fieldOrderList'));" /></div>
	<div class "text">Up</div>
	<div class="text"><input type="button"  title="Up" alt="Up" onclick="moveUp(document.getElementById('fieldOrder'));updateList(document.getElementById('fieldOrder'), document.getElementById('fieldOrderList'));" /></div>
	<div class="text"><input type="button"  title="Down" alt="Down" onclick="moveDown(document.getElementById('fieldOrder'));updateList(document.getElementById('fieldOrder'), document.getElementById('fieldOrderList'));" /></div>
	<div class "text">Down</div>
	<div class="text"><input type="button"  title="Bottom" alt="Bottom" onclick="moveBottom(document.getElementById('fieldOrder'));updateList(document.getElementById('fieldOrder'), document.getElementById('fieldOrderList'));" /></div>
	<div class "text">Bottom</div>
</td></Tr>
</table>
<input type="hidden" id="fieldOrderList" name="reportColumnOrder" value="" readonly="readonly" style="border: none;"></dd>
<br>
<br>
</div>
<jsp:include page="snippets/navbuttons.jsp"/>
</form>


