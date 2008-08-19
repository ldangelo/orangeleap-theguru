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
<select name="fieldOrder" size="10">
<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">

<c:forEach var="f" items="${fgroup.fields}" varStatus="inner">
<!--<c:if test="${f.selected}">-->
<option label="${f.displayName}" value="fieldGroups[${outer.count-1}].fields[${inner.count-1}]">${f.displayName}</option>
<!--</c:if>-->
</c:forEach>
</c:forEach>
			</select>
</td>
<td>
	<div class="text">Top</div>
	<div class="text"><input type="button" title="Top" alt="Top" onclick="" /></div>
	<div class "text">Up</div>
	<div class="text"><input type="button"  title="Up" alt="Up" /></div>
	<div class="text"><input type="button"  title="Down" alt="Down" /></div>
	<div class "text">Down</div>
	<div class="text"><input type="button"  title="Bottom" alt="Bottom" /></div>
	<div class "text">Bottom</div>
</td></Tr>
</table>
<br>
<br>
</div>
<jsp:include page="snippets/navbuttons.jsp"/>



</form>


