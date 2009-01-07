<%@ include file="/WEB-INF/jsp/include.jsp"%>


<form method="post">
<h1>Report Wizard</h1>

<h2>Select the matrix report options</h2>
<hr width="100%" size=1 color="black">
<div class="columns">


	<Table id="report_matrixrows" class="tablesorter" bgcolor=#E0E0E0>
		<thead> 
			<th>Row Fields</th>
			<th>Sort order</th>
			<th></th>
		</thead>

       	<c:set var="rowIndex" scope="request" value="0"/>	
    	<c:forEach var="row" items="${matrixRows}" varStatus="outer">
			<c:set var="fieldId" scope="request" value="${row.fieldId}"/>
			<c:set var="sortOrder" scope="request" value="${row.sortOrder}"/>
			<c:if test="${(fieldId != null && fieldId != -1) || (sortOrder != null && sortOrder != 'ASC')}">
				<jsp:include page="/WEB-INF/jsp/reportMatrixFormRow.jsp" /></td>
				<c:set var="rowIndex" scope="request" value="${rowIndex + 1}"/>
			</c:if>
		</c:forEach>
		<c:set var="fieldId" scope="request" value="-1"/>
		<c:set var="sortOrder" scope="request" value=""/>
		<jsp:include page="/WEB-INF/jsp/reportMatrixFormRow.jsp" /></td>
	</Table>
	<br>
	<br>
	<Table id="report_matrixColumns" class="tablesorter" bgcolor=#E0E0E0>
		<thead> 
			<th>Column Fields</th>
			<th>Sort order</th>
			<th></th>
		</thead>

       	<c:set var="columnIndex" scope="request" value="0"/>	
    	<c:forEach var="column" items="${matrixColumns}" varStatus="outer">
			<c:set var="fieldId" scope="request" value="${column.fieldId}"/>
			<c:set var="sortOrder" scope="request" value="${column.sortOrder}"/>
			<c:if test="${(fieldId != null && fieldId != -1) || (sortOrder != null && sortOrder != 'ASC')}">
				<jsp:include page="/WEB-INF/jsp/reportMatrixFormColumn.jsp" /></td>
				<c:set var="columnIndex" scope="request" value="${columnIndex + 1}"/>
			</c:if>
		</c:forEach>
		<c:set var="fieldId" scope="request" value="-1"/>
		<c:set var="sortOrder" scope="request" value=""/>
		<jsp:include page="/WEB-INF/jsp/reportMatrixFormColumn.jsp" /></td>
	</Table>
	<br>
	<br>
	<Table id="report_matrixMeasure" class="tablesorter" bgcolor=#E0E0E0>
		<thead> 
			<th>Measure</th>
			<th>Operation</th>
		</thead>
		
		<TR rowIndex="0">
			<TD style="width:360px"><SELECT id="reportCrossTabFields.reportCrossTabMeasure"
				name="reportCrossTabFields.reportCrossTabMeasure"
				style="width:260px" >
				<option label="" value="-1" selected></option>
				<c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">
					<c:forEach var="f" items="${fgroup.fields}" varStatus="inner">
						<c:if test="${f != null }">
							<option label="${f.displayName}" value="${f.id}"
								<c:if test="${matrixMeasure == f.id}">selected="true"</c:if>
							>${f.displayName}</option>
						</c:if>
					</c:forEach>
				</c:forEach>
			</SELECT></TD>
			
			<TD style="width:390px"><SELECT id="reportCrossTabFields.reportCrossTabOperation"
				name="reportCrossTabFields.reportCrossTabOperation"
				style="width:260px" >
				<option value="SUM" <c:if test="${matrixOperation == 'SUM'}">selected="true"</c:if>>Sum</option>
				<option value="AVERAGE" <c:if test="${matrixOperation == 'AVERAGE'}">selected="true"</c:if>>Average</option>
				<option value="MAX" <c:if test="${matrixOperation == 'MAX'}">selected="true"</c:if>>Max</option>
				<option value="MIN" <c:if test="${matrixOperation == 'MIN'}">selected="true"</c:if>>Min</option>
				<option value="COUNT" <c:if test="${matrixOperation == 'COUNT'}">selected="true"</c:if>>Count</option>
			</SELECT></TD>
		</TR>
	</Table>
<br>

<br>
<br>
</div>
<jsp:include page="snippets/navbuttons.jsp" /></form>


