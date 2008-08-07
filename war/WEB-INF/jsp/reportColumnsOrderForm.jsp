<%@ include file="/WEB-INF/jsp/include.jsp" %>


<form:form method="post" commandName="reportsource">
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
				<c:forEach var="rds"
					items="${reportsource.reportDataSource.subSources}">
					<c:forEach var="fgroup" items="${rds.fieldGroups}">

						<c:forEach var="field" items="${fgroup.fields}">
							<c:if test="${field.isDefault}">
								<option value="$field.id">${field.displayName}</option>
							</c:if>
						</c:forEach>

					</c:forEach>
				</c:forEach>
			</select>
</td>
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
<input type="submit" value="Back" name="_target3">
<input type="submit" value="Run" name="_finish">


</form:form>


