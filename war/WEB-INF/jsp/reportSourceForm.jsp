<%@ include file="/WEB-INF/jsp/include.jsp" %>
<script type='text/javascript' src='dwr/engine.js'></script>
<script type='text/javascript' src='dwr/util.js'></script>
<script type='text/javascript' src='dwr/interface/ReportSubSourceService.js'></script>

<script type="text/javascript">
function addSubSources(results) {
//console.log(results);
      $("#subSourceId").empty();

      for (ss in results) {
         $("#subSourceId").append("<option value='" + results[ss].id + "'>" + results[ss].displayName + "</option>");
      }
  $("#subSourceId option:first").attr("selected","selected");
}

function updateSubSource() {
  var srcId = $("#srcId").attr("value");

  ReportSubSourceService.readSubSourcesByReportSourceId(srcId,addSubSources);
  

}

$(function() {
updateSubSource();


});

</script>

<form:form name="myform" method="post" commandName="reportsource">
<h2>Select a primary data source</h2>
<br>
<form:select path="srcId" multiple="false" onchange="updateSubSource()">
<form:options items="${reportsource.dataSources}" itemLabel="name" itemValue="id"/>
</form:select>
<br>
<h2>Select a secondary data source</h2>
<br>
<form:select path="subSourceId" size="15">
</form:select>
<br>



<div class="buttonposition">
<jsp:include page="snippets/navbuttons.jsp" />
</div>
</form:form>


