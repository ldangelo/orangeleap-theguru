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
    //console.log ("results " + results);
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
    var username = $("#username").attr("value");
    var password = $("#password").attr("value");
    //console.log("Updating reports " + dtnode);
    
    //console.log("key = " + dtnode.data.key);
    $("#reportPath").attr("value", dtnode.data.key);

    JasperServerService.setUserName(username);
    JasperServerService.setPassword(password);
    JasperServerService.list(dtnode.data.key,addReports);
  }

function updateTree(results) {
    var childNode;
    //console.log(results);
    var username = $("#username").attr("value");
    var password = $("#password").attr("value");
    
    
    
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
	    JasperServerService.setUserName(username);
	    JasperServerService.setPassword(password);
	    JasperServerService.list(results[rs].uriString,updateTree);
	}
    }
  }

function preventInvalidReportNameCharacters() {
	var reportName = $('#reportName'); 
	reportName.one("keydown",function(event){
		preventInvalidReportNameCharacters();
		if (event.keyCode == 222) // quotes
			return false;
	});
}

function removeInvalidReportNameCharacters() {
	var reportName = $('#reportName');
	reportName.one("change",function(event){
		removeInvalidReportNameCharacters();
		reportName.val(reportName.val().replace('\'', '').replace('\"', ''));
	});
}

$(function() {
    var username = $("#username").attr("value");
    var password = $("#password").attr("value");

    $("#treeview").dynatree({
	imagePath: "skin/",
	onFocus: function(dtnode) { updateReports(dtnode); }
    });
    
    JasperServerService.setUserName(username);
    JasperServerService.setPassword(password);
    JasperServerService.list("/",updateTree);

    preventInvalidReportNameCharacters();
    removeInvalidReportNameCharacters();
  });

</script>

<form:form name="myform" method="post" commandName="reportsource">
<form:hidden path="username"/>
<form:hidden path="password"/>

  <div class="columns" style="width: 100%">
    <div class="column" style="width: 30%">Report Name:      </div>
    <div class="column" ><form:input id="reportName" path="reportName" size="64" tabindex="1"/></div>
    <div class="clearColumns"></div>
  </div>
  
  <div class="columns" style="width: 100%">
    <div class="column" style="width: 30%">Report Description:</div>
    <div class="column"><form:input path="reportComment" size="64" tabindex="2"/></div>
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

<input type="image" src="images/cancel_off.gif" value="Cancel" name="_target${reportsource.previousPage}" ALT="Cancel" onmouseover="this.src = 'images/cancel_on.gif';" onmouseout="this.src = 'images/cancel_off.gif';">
<input type="image" src="images/save_off.gif" value="Save" name="_target5" ALT="Save" onmouseover="this.src = 'images/save_on.gif';" onmouseout="this.src = 'images/save_off.gif';">

<input type="image" id="reportDataHiddenInput" name="_target0" value="Report Data" style="display:none" >
<input type="image" id="reportFormatHiddenInput" name="_target1" value="Report Format" style="display:none" >
<input type="image" id="reportContentHiddenInput" name="_target2" value="Report Content" style="display:none" >
<input type="image" id="reportCriteriaHiddenInput" name="_target3" value="Report Criteria" style="display:none" >
<input type="image" id="saveReportHiddenInput" name="_target4" value="Save Report" style="display:none" >

<!--
    <div class="column" style="width: 10%">
      <button type="submit" name="_target${previousPage +1}" tabindex="4">Cancel</button>
    </div>
    <div class="column" style="width: 10%">
      <button type="submit" name="_target5" tabindex="3">Save<button>
    </div>
    -->
    <div class="clearColumns"></div>
  </div>
</form:form>







