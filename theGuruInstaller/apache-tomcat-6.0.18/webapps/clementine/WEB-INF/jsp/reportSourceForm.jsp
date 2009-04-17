<%@ include file="/WEB-INF/jsp/include.jsp"%>
<script type='text/javascript' src='dwr/interface/ReportSubSourceService.js'></script>
<script type='text/javascript' src='dwr/interface/ReportSubSourceGroupService.js'></script>
<script type='text/javascript' src='dwr/engine.js'></script>
<script type='text/javascript' src='dwr/util.js'></script>


<script type="text/javascript">
 var $j = jQuery.noConflict();

	$j(document).ready( function() {
		updateSubSourceGroup();
	});

	function addSubSourceGroups(results) {
		//console.log(results);
		$j("#dataSubSourceGroupId").empty();

		for (ss in results) {
			var option = "<option value='" + results[ss].id + "'";
			if (results[ss].description != null)
				option += " title='" + results[ss].description + "'";
			else
				option += " title='" + results[ss].displayName + "'";
			option += '>' + results[ss].displayName + "</option>";
			$j("#dataSubSourceGroupId").append(option);						
		}
		$j('#dataSubSourceGroupId').find("option:first").attr('selected', 'true');
		$j('#dataSubSourceGroupId').find(
				"option[value=" + $j('#previousSubSourceGroupId').val() + "]").attr(
				'selected', 'true');		
		updateSubSource();
	}

	function updateSubSourceGroup() {
		var srcId = $j("#srcId").attr("value");

		ReportSubSourceGroupService.readSubSourceGroupsByReportSourceId(srcId,
				addSubSourceGroups);
		$j('#dataSubSourceGroupId').find("option:first").attr('selected', 'true');
		$j('#dataSubSourceGroupId').find(
				"option[value=" + $j('#previousSubSourceGroupId').val() + "]").attr(
				'selected', 'true');
	}
	
	function addSubSources(results) {
		//console.log(results);
		$j("#subSourceId").empty();

		for (ss in results) {
			var option = "";
			option = "<option value='" + results[ss].id + "'";
			if (results[ss].description != null)
				option += " title='" + results[ss].description + "'";
			else
				option += " title='" + results[ss].displayName + "'";			
			option += ">" + results[ss].displayName
			option += "</option>";
			$j("#subSourceId").append(option);
		}
		$j('#subSourceId').find("option:first").attr('selected', 'true');
		$j('#subSourceId').find(
				"option[value=" + $j('#previousSubSourceId').val() + "]").attr(
				'selected', 'true');		
	}

	function updateSubSource() {
		var groupId = $j('#dataSubSourceGroupId').find('option:selected').val();

		ReportSubSourceService.readSubSourcesByReportSubSourceGroupId(groupId,
				addSubSources);
		$j('#subSourceId').find("option:first").attr('selected', 'true');
		$j('#subSourceId').find(
				"option[value=" + $j('#previousSubSourceId').val() + "]").attr(
				'selected', 'true');	
	}

</script>

<form:form name="myform" method="post" commandName="reportsource">
	<h1>Report Wizard</h1>
	<jsp:include page="snippets/formerrors.jsp"/>
	<h2>Select a primary data source</h2>
	<hr width="100%" size=1 color="black">
	<form:select path="srcId" multiple="false" onchange="updateSubSourceGroup()">
		<form:options items="${reportsource.dataSources}" itemLabel="name"
			itemValue="id" />
	</form:select>
	<br>
	<br>
	<h2>Select a secondary data source</h2>
	<hr width="100%" size=1 color="black">
	<table>
		<tr>
			<th>Secondary Data Source Groups</th>
			<th>Secondary Data Sources</th>
		</tr>
		<tr>
			<td>
				<form:select path="dataSubSourceGroupId" size="15" onchange="updateSubSource()" >
				</form:select>
			</td>
			<td>
				<form:select path="subSourceId" size="15"  >
				</form:select>
			</td>
		</tr>
	</table>
	<br>
	<input type="hidden" id="previousSubSourceId"
		name="previousSubSourceId" value="${previousSubSourceId}" readonly="readonly"
		style="border: none;">
	<input type="hidden" id="previousSubSourceGroupId"
		name="previousSubSourceGroupId" value="${previousSubSourceGroupId}" readonly="readonly"
		style="border: none;">
	<div class="buttonposition"><jsp:include
		page="snippets/navbuttons.jsp" /></div>
</form:form>


