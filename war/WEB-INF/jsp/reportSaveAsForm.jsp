<%@ include file="/WEB-INF/jsp/include.jsp"%>
<script type='text/javascript' src='dwr/engine.js'></script>
<script type='text/javascript' src='dwr/util.js'></script>
<script type='text/javascript' src='dwr/interface/JasperServerService.js'></script>
<script type='text/javascript' src='js/ui.core.js'></script>
<script type='text/javascript' src='js/jquery.dynatree.js'></script>

<script type="text/javascript">
  var cellFuncs = [
      function(data) { return data.label; },
      function(data) { return data.description; }
  ];
  
function addReports(results) {
    console.log ("results " + results);
    dwr.util.removeAllRows("reports");
    
    
    var reports = new Array();
    for (ds in results) {
	if (results[ds].wsType == "reportUnit") {
     	    reports.push(results[ds]);
	}
    }
    dwr.util.addRows("reports",reports,cellFuncs);
    
    }


function updateReports(dtnode) {
    console.log("Updating reports " + dtnode);
    
    console.log("key = " + dtnode.data.key);
    $("#reportPath").attr("value", dtnode.data.key);
    JasperServerService.list(dtnode.data.key,addReports);
  }

function updateTree(results) {
    var childNode;
    console.log(results);
    
    
    
    for (rs in results)
    {
	if (results[rs].wsType == "folder") {
	    if (results[rs].parentFolder == "/") 
		var rootNode = $("#treeview").dynatree("getRoot");
	    else
		var rootNode = $("#treeview").dynatree("getTree").getNodeByKey(results[rs].parentFolder);
	    
	    
	    childNode = rootNode.append({
		title: results[rs].label,
		isFolder: true,
		key: results[rs].uriString
	    });
	    
	    //
	    // updateTree childnode
	    JasperServerService.list(results[rs].uriString,updateTree);
	}
    }
  }

$(function() {
    
    $("#treeview").dynatree({
	imagePath: "skin/",
	onFocus: function(dtnode) { updateReports(dtnode); }
    });
    
    JasperServerService.list("/",updateTree);
    
  });

</script>

<form:form name="myform" method="post" commandName="reportsource">
  <div class="columns" style="width: 100%">
    <div class="column" style="width: 30%">Report Name:      </div>
    <div class="column" ><form:input path="reportName" size="64"/></div>
    <div class="clearColumns"></div>
  </div>
  
  <div class="columns" style="width: 100%">
    <div class="column" style="width: 30%">Report Description:</div>
    <div class="column"><form:input path="reportComment" size="64"/></div>
    <form:hidden path="reportPath" />
    <div class="clearColumns"></div>
  </div>
  
  <div style="height: 20px;"></div>
  
  <div class="columns" style="width: 100%">
    <div class="column" style="width: 32%"><p></p></div>
    <div class="column" style="width: 60%">
      
      <table class="tablesorter">
	<thead>
	  <tr>
	    <th class="header">Report Name</th><th class="header"> Report Description</th>
	  </tr>
	</thead>
      </table>
    </div>
    <div class="clearColumns"></div>
  </div>
  
  <div class="columns" style="width: 100%">
    <div class="column Tree scroll" id="left" style="width: 30%">
      <div id="treeview"><ul></ul>
      </div>
    </div>
    
    <div class="column scroll" style="width: 60%;">
      <table>
	
	<tbody id="reports">
	</tbody>
      </table>
    </div>
    <div class="clearColumns"></div>
  </div>
  
  
  
  <div style="height: 20px;"><p></p></div>
  <div class="columns" style="width: 100%">
    <div class="column" style="width: 50%">
      &nbsp;
<!--      <button type="button">New Folder</button> -->
    </div>
    <div class="column" style="width: 10%">
      <button type="submit" name="_target10">Cancel</button>
    </div>
    <div class="column" style="width: 10%">
      <button type="submit" name="_target11">Save<button>
    </div>
    <div class="clearColumns"></div>
  </div>
</form:form>







