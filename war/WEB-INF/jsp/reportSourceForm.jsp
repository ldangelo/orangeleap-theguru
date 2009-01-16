<%@ include file="/WEB-INF/jsp/include.jsp"%>
<script type='text/javascript'
	src='dwr/interface/ReportSubSourceService.js'></script>
<script type='text/javascript' src='dwr/engine.js'></script>
<script type='text/javascript' src='dwr/util.js'></script>


<script type="text/javascript">
 var $j = jQuery.noConflict();

	$j(document).ready( function() {
		updateSubSource();
	});
	function addSubSources(results) {
		//console.log(results);
		$j("#subSourceId").empty();

		for (ss in results) {
			$j("#subSourceId").append(
					"<option value='" + results[ss].id + "'>"
							+ results[ss].displayName + "</option>");
		}
		$j('#subSourceId').find("option:first").attr('selected', 'true')
		$j('#subSourceId').find(
				"option[value=" + $j('#originalSubSourceId').val() + "]").attr(
				'selected', 'true');
	}

	function updateSubSource() {
		var srcId = $j("#srcId").attr("value");

		ReportSubSourceService.readSubSourcesByReportSourceId(srcId,
				addSubSources);
		$j('#subSourceId').find(
				"option[value=" + $j('#originalSubSourceId').val() + "]").attr(
				'selected', 'true'); 
	}

	function updateOriginalSubSourceId() {
		$j('#originalSubSourceId').val($j('#subSourceId').find("option:selected").val());
	}
	

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


