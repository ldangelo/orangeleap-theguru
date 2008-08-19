<%@ include file="/WEB-INF/jsp/include.jsp" %>

<form method="post">
		<h1>
			Report Wizard
		</h1>

<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">
<h2>${fgroup.name}</h2>
<table width="100%">
<tr>

<c:forEach var="f" items="${fgroup.fields}" varStatus="inner">
<c:if test="${f != null}">
      <input type=checkbox name="fieldGroups[${outer.count-1}].fields[${inner.count-1}].selected" <c:if test="${f.isDefault}">checked="checked"</c:if> />${f.displayName}
</c:if>
</c:forEach>
</tr></table>
<BR></c:forEach>

<Table>	
<TR>
</TR>


</Table>
<br>
<br>

<jsp:include page="snippets/navbuttons.jsp"/>
</form>


