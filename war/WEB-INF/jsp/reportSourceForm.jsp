<%@ include file="/WEB-INF/jsp/include.jsp"%>
<script type='text/javascript' src='dwr/engine.js'></script>
<script type='text/javascript' src='dwr/util.js'></script>
<script type='text/javascript'
	src='dwr/interface/ReportSubSourceService.js'></script>

<script type="text/javascript">
	function addSubSources(results) {
		//console.log(results);
		$("#subSourceId").empty();

		for (ss in results) {
			$("#subSourceId").append(
					"<option value='" + results[ss].id + "'>"
							+ results[ss].displayName + "</option>");
		}
		$('#subSourceId').find("option:first").attr('selected', 'true')
		$('#subSourceId').find(
				"option[value=" + $('#originalSubSourceId').val() + "]").attr(
				'selected', 'true');
	}

	function updateSubSource() {
		var srcId = $("#srcId").attr("value");

		ReportSubSourceService.readSubSourcesByReportSourceId(srcId,
				addSubSources);
		$('#subSourceId').find(
				"option[value=" + $('#originalSubSourceId').val() + "]").attr(
				'selected', 'true');
	}

	function updateOriginalSubSourceId() {
		$('#originalSubSourceId').val($('#subSourceId').find("option:selected").val());
	}
	
	$( function() {
		updateSubSource();
	});
</script>

<form:form name="myform" method="post" commandName="reportsource">
	<h1>Report Wizard</h1>
	<h2>Select a primary data source</h2>
	<hr width="100%" size=1 color="black">
	<form:select path="srcId" multiple="false" onchange="updateSubSource()">
		<form:options items="${reportsource.dataSources}" itemLabel="name"
			itemValue="id" />
	</form:select>
	<br>
	<br>
	<h2>Select a secondary data source</h2>
	<hr width="100%" size=1 color="black">
	
	<form:select path="subSourceId" size="15" onchange="updateOriginalSubSourceId()" >
	</form:select>
	<br>
	<input type="hidden" id="originalSubSourceId"
		name="originalSubSourceId" value="${subSourceId}" readonly="readonly"
		style="border: none;">
	<div class="buttonposition"><jsp:include
		page="snippets/navbuttons.jsp" /></div>
</form:form>


