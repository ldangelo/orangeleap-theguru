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
	<div class="text"><a href="javascript:moveTop(document.getElementById('fieldOrder'));updateList(document.getElementById('fieldOrder'), document.getElementById('fieldOrderList'));"><img src="images/top.gif" alt="Top" class="doubleArrowUp" title="Top"/></a>
	<div class="text"><a href="javascript:moveUp(document.getElementById('fieldOrder'));updateList(document.getElementById('fieldOrder'), document.getElementById('fieldOrderList'));"><img src="images/up.gif" alt="Top" class="arrowUp" title="Up"/></a>
	<div class="text"><a href="javascript:moveDown(document.getElementById('fieldOrder'));updateList(document.getElementById('fieldOrder'), document.getElementById('fieldOrderList'));"><img src="images/down.gif" alt="Top" class="arrowDown" title="Down"/></a>
	<div class="text"><a href="javascript:moveBottom(document.getElementById('fieldOrder'));updateList(document.getElementById('fieldOrder'), document.getElementById('fieldOrderList'));"><img src="images/bottom.gif" alt="Top" class="doubleArrowDown" title="Bottom"/></a>
</td></Tr>
</table>
<input type="hidden" id="fieldOrderList" name="reportColumnOrder" value="" readonly="readonly" style="border: none;"></dd>
<br>
<br>
</div>
<jsp:include page="snippets/navbuttons.jsp"/>
</form>


