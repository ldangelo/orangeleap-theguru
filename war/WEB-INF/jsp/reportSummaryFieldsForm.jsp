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
<TD>Record Count</TD><TD>        </TD><TD><input type="checkbox" name="recordCount"/></TD><TD></TD><TD></TD><TD></TD>

</TR>
<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">


<c:forEach var="f" items="${fgroup.fields}" varStatus="inner">
<c:if test="${f.canBeSummarized}">
<TR>
<TD>${f.displayName}</TD><TD></TD>
<TD><input type=checkbox name="fieldGroups[${outer.count-1}].fields[${inner.count-1}].performSummary" onClick="javascript:SingleSelect('^(fieldGroups).*(${outer.count-1}).*(fields).*(${inner.count-1}).*', this)"/></TD>
<TD><input type=checkbox name="fieldGroups[${outer.count-1}].fields[${inner.count-1}].average" onClick="javascript:SingleSelect('^(fieldGroups).*(${outer.count-1}).*(fields).*(${inner.count-1}).*', this)"/></TD>
<TD><input type=checkbox name="fieldGroups[${outer.count-1}].fields[${inner.count-1}].largestValue" onClick="javascript:SingleSelect('^(fieldGroups).*(${outer.count-1}).*(fields).*(${inner.count-1}).*', this)"/></TD>
<TD><input type=checkbox name="fieldGroups[${outer.count-1}].fields[${inner.count-1}].smallestValue" onClick="javascript:SingleSelect('^(fieldGroups).*(${outer.count-1}).*(fields).*(${inner.count-1}).*', this)"/></TD>
</TR>
</c:if>
</c:forEach>
</c:forEach>

<TR>
</TR>
</Table>
<br>

<br>
<br>
</div>
<jsp:include page="snippets/navbuttons.jsp"/>
</form:form>


