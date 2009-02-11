<%@ include file="/WEB-INF/jsp/include.jsp"%>
<script type="text/javascript" src="js/mpower.reportmatrix.js"></script>

<form method="post">
<h1>Report Wizard</h1>

<h2>Select the matrix report options</h2>
<hr width="100%" size=1 color="black">
<div class="columns">
	<br>
	<table class="tablesorter">
		<thead>
			<th>Step 1.   Select Rows</th>
			<th>Step 2.   Select Columns</th>
			<th>Step 3.   Select Measure</th>
</thead>
		<tr>
			<td><img height="87" width="203" src="images/reportmatrixstyle_row.gif" alt="Matrix Report" title="Matrix Report"/> </td>
			<td><img height="87" width="203" src="images/reportmatrixstyle_column.gif" alt="Matrix Report" title="Matrix Report"/> </td>
			<td><img height="87" width="203" src="images/reportmatrixstyle_measure.gif" alt="Matrix Report" title="Matrix Report"/> </td>
		</tr>
	</table>
	<Table id="report_matrixrows" class="tablesorter" bgcolor=#E0E0E0 onmouseout="$('#matrix_preview td').css('backgroundColor','white');" onmouseover="$('#matrix_preview td[celltype=row]').css('backgroundColor','red')" >
		<tr rowindex="-1" > 
			<th>Select Rows</th>
			<th>Sort order</th>
			<th></th>
		</tr>

       	<c:set var="rowIndex" scope="request" value="0"/>	
    	<c:forEach var="row" items="${matrixRows}" varStatus="outer">
			<c:set var="fieldId" scope="request" value="${row.fieldId}"/>
			<c:set var="sortOrder" scope="request" value="${row.sortOrder}"/>
			<c:if test="${(fieldId != null && fieldId != -1) || (sortOrder != null && sortOrder != 'ASC')}">
				<jsp:include page="/WEB-INF/jsp/reportMatrixFormRow.jsp" />
				<c:set var="rowIndex" scope="request" value="${rowIndex + 1}"/>
			</c:if>
		</c:forEach>
		<c:set var="fieldId" scope="request" value="-1"/>
		<c:set var="sortOrder" scope="request" value=""/>
		<jsp:include page="/WEB-INF/jsp/reportMatrixFormRow.jsp" />
	</Table>
	<br>
	
	<Table id="report_matrixColumns" class="tablesorter" bgcolor=#E0E0E0 onmouseout="$('#matrix_preview td').css('backgroundColor','white');" onmouseover="$('#matrix_preview td[celltype=column]').css('backgroundColor','red')" >
		<tr rowindex="-1" > 
			<th>Select Columns</th>
			<th>Sort order</th>
			<th></th>
		</tr>

       	<c:set var="columnIndex" scope="request" value="0"/>	
    	<c:forEach var="column" items="${matrixColumns}" varStatus="outer">
			<c:set var="fieldId" scope="request" value="${column.fieldId}"/>
			<c:set var="sortOrder" scope="request" value="${column.sortOrder}"/>
			<c:if test="${(fieldId != null && fieldId != -1) || (sortOrder != null && sortOrder != 'ASC')}">
				<jsp:include page="/WEB-INF/jsp/reportMatrixFormColumn.jsp" />
				<c:set var="columnIndex" scope="request" value="${columnIndex + 1}"/>
			</c:if>
		</c:forEach>
		<c:set var="fieldId" scope="request" value="-1"/>
		<c:set var="sortOrder" scope="request" value=""/>
		<jsp:include page="/WEB-INF/jsp/reportMatrixFormColumn.jsp" />
	</Table>
	<br>
	
	<Table id="report_matrixMeasure" class="tablesorter" bgcolor=#E0E0E0 onmouseout="$('#matrix_preview td').css('backgroundColor','white');" onmouseover="$('#matrix_preview td[celltype=measure]').css('backgroundColor','red');" >
		<tr rowindex="-1" > 
			<th>Select Measure</th>
			<th>Operation</th>
		</tr>

       	<c:set var="measureIndex" scope="request" value="0"/>	
    	<c:forEach var="measure" items="${matrixMeasures}" varStatus="outer">
			<c:set var="fieldId" scope="request" value="${measure.fieldId}"/>
			<c:set var="calculation" scope="request" value="${measure.calculation}"/>
			<c:if test="${(fieldId != null && fieldId != -1) || (sortOrder != null && sortOrder != 'ASC')}">
				<jsp:include page="/WEB-INF/jsp/reportMatrixFormMeasure.jsp" />
				<c:set var="measureIndex" scope="request" value="${measureIndex + 1}"/>
			</c:if>
		</c:forEach>
		<c:if test="${measureIndex == 0}">
			<c:set var="fieldId" scope="request" value="-1"/>
			<c:set var="sortOrder" scope="request" value=""/>
			<jsp:include page="/WEB-INF/jsp/reportMatrixFormMeasure.jsp" /> 
		</c:if>
	</Table>

<br>
</div>
<jsp:include page="snippets/navbuttons.jsp" /></form>


