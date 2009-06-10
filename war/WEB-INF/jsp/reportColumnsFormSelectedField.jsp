<%@ include file="/WEB-INF/jsp/include.jsp"%>
<tr index="${fieldIndex}" id="fieldRow" name="fieldRow">
	<td>
		<select objectname="reportSelectedFields[INDEXREPLACEMENT].fieldId" style="width: 260px"
			onchange="setOptionsEnabled($(this).parent().parent());">
			<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer"><optgroup label="${fgroup.name}"><c:forEach var="f" items="${fgroup.fields}" varStatus="inner"><c:if test="${f != null}"><option value=${f.id} fieldgroup=${fgroup.id} fieldid=${f.id} fieldtype=${f.fieldType}<c:if test="${(currentField != null) && (currentField.fieldId == f.id)}">selected="true"</c:if>>${f.displayName}</option></c:if></c:forEach></optgroup></c:forEach>
		</select>
	</td>
	<td align=center>
		<select objectname="reportSelectedFields[INDEXREPLACEMENT].sortOrder">
			<option value=""<c:if test="${(currentField != null) && (currentField.sortOrder == '')}">selected="true"</c:if>>None</option>
			<option value="ASC"<c:if test="${(currentField != null) && (currentField.sortOrder == 'ASC')}">selected="true"</c:if>>Asc</option>
			<option value="DESC"<c:if test="${(currentField != null) && (currentField.sortOrder == 'DESC')}">selected="true"</c:if>>Desc</option>
		</select>
	</td>
	<td align=center> <input value="true" onclick="sortFieldTable('#report_fields_add');" objectname="reportSelectedFields[INDEXREPLACEMENT].groupBy" type="checkbox"<c:if test="${(currentField != null) && (currentField.groupBy == true)}">checked="true"</c:if>/></td>
	<td align=center> <input value="true" objectname="reportSelectedFields[INDEXREPLACEMENT].count" type="checkbox"<c:if test="${(currentField != null) && (currentField.count == true)}">checked="true"</c:if>/></td>
	<td align=center> <input value="true" objectname="reportSelectedFields[INDEXREPLACEMENT].max" type="checkbox"<c:if test="${(currentField != null) && (currentField.max == true)}">checked="true"</c:if>/></td>
	<td align=center> <input value="true" objectname="reportSelectedFields[INDEXREPLACEMENT].min" type="checkbox"<c:if test="${(currentField != null) && (currentField.min == true)}">checked="true"</c:if>/></td>
	<td align=center> <input value="true" objectname="reportSelectedFields[INDEXREPLACEMENT].sum" fieldtype="summary" type="checkbox"<c:if test="${(currentField != null) && (currentField.sum == true)}">checked="true"</c:if>/></td>
	<td align=center> <input value="true" objectname="reportSelectedFields[INDEXREPLACEMENT].average" fieldtype="summary" type="checkbox"<c:if test="${(currentField != null) && (currentField.average == true)}">checked="true"</c:if>/></td>
	<td align=center>
		<img class="deleteButton" src="images/icons/deleteRow.png" style="cursor: pointer;" />
		<img class="moveUpButton" src="images/filterUp.gif"	style="cursor: pointer;" />
		<img class="moveDownButton"	src="images/filterDown.gif" style="cursor: pointer;" />
	</td>
</tr>