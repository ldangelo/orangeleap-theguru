<%@ include file="/WEB-INF/jsp/include.jsp"%>
<script type='text/javascript' src='dwr/engine.js'></script>
<script type='text/javascript' src='dwr/util.js'></script>
<script type='text/javascript'
	src='dwr/interface/JasperServerService.js'></script>
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
    var username = jQuery("#username").attr("value");
    var password = jQuery("#password").attr("value");
    //console.log("Updating reports " + dtnode);

    //console.log("key = " + dtnode.data.key);
    jQuery("#reportPath").attr("value", dtnode.data.key);

    JasperServerService.setUserName(username);
    JasperServerService.setPassword(password);
    JasperServerService.list(dtnode.data.key,addReports);
  }

function updateTree(results) {
    var reportPath = jQuery("#reportPath").val();

    var childNode;
    //console.log(results);
    var username = jQuery("#username").attr("value");
    var password = jQuery("#password").attr("value");

    for (rs in results)
    {
	if (results[rs].wsType == "folder") {
	    if (results[rs].parentFolder == "/")
		var rootNode = jQuery("#treeview").dynatree("getRoot");
	    else
		var rootNode = jQuery("#treeview").dynatree("getTree").getNodeByKey(results[rs].parentFolder);

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
	if (reportPath != null && reportPath != '' && jQuery('#treeview').dynatree("getTree").selectKey(reportPath) != null) {
		jQuery('#treeview').dynatree("getTree").selectKey(reportPath).activate();
		updateReports(jQuery('#treeview').dynatree("getTree").selectKey(reportPath));
	}

  }

function preventInvalidReportNameCharacters() {
	var reportName = jQuery('#reportName');
	reportName.one("keydown",function(event){
		preventInvalidReportNameCharacters();
		if (event.keyCode == 220) // backslash
			return false;
	});
}

function removeInvalidReportNameCharacters() {
	var reportName = jQuery('#reportName');
	reportName.one("change",function(event){
		removeInvalidReportNameCharacters();
		reportName.val(reportName.val().replace('\\', ''));
	});
}

jQuery(function() {
    var username = jQuery("#username").attr("value");
    var password = jQuery("#password").attr("value");

    JasperServerService.setUserName(username);
    JasperServerService.setPassword(password);

    jQuery("#treeview").dynatree({
	imagePath: "skin/",
	onFocus: function(dtnode) { updateReports(dtnode); }
    });

    preventInvalidReportNameCharacters();
    removeInvalidReportNameCharacters();

    JasperServerService.list("/",updateTree);
});

function checkForReturn(e)
{
var keynum;
var keychar;
var numcheck;

if(window.event) // IE
  {
  keynum = e.keyCode;
  }
else if(e.which) // Netscape/Firefox/Opera
  {
  keynum = e.which;
  }

  // if the user has hit the return key then fire the click event on the submit button
  if (keynum == 13) {
//  	jQuery("#save").click();
  	return false;
	}

return true;
}

</script>

<form:form name="myform" method="post" commandName="reportsource">
	<form:hidden path="username" />
	<form:hidden path="password" />
	<jsp:include page="snippets/formerrors.jsp" />
	<div class="columns" style="width: 100%">
	<div class="column" style="width: 30%">Report Name:</div>
	<div class="column"><form:input path="reportName" size="64"
		tabindex="1" onkeypress="return checkForReturn(event)" /></div>
	<div class="clearColumns"></div>
	</div>

	<div class="columns" style="width: 100%">
	<div class="column" style="width: 30%">Report Description:</div>
	<div class="column"><form:input path="reportComment" size="64"
		tabindex="2" /></div>
	<form:hidden path="reportPath" />
	<div class="clearColumns"></div>
	</div>

	<div style="height: 20px;"></div>

	<div class="columns" style="width: 100%">
	<div class="column" style="width: 32%">
	<p></p>
	</div>
	<div class="column" style="width: 60%">

	<table class="tablesorter">
		<thead>
			<tr>
				<th class="header" style="width: 33%">Report Name</th>
				<th class="header">Report Description</th>
			</tr>
		</thead>
	</table>
	</div>
	<div class="clearColumns"></div>
	</div>

	<div class="columns" style="width: 100%">
	<div class="column Tree scroll" id="left" style="width: 30%">
	<div id="treeview">
	<ul></ul>
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

	<c:if test="${useReportAsSegmentation}">
	<div class="columns">
	<input type="checkbox" id="executeSegmentation" name="executeSegmentation">Execute segmentation job after saving</select>
	</div>
	</c:if>

	<div style="height: 20px;">
	<p></p>
	</div>
	<div class="columns" style="width: 100%">
	<div class="column" style="width: 50%">&nbsp; <!--      <button type="button">New Folder</button> -->
	</div>

	<input type="image" src="images/cancel_off.gif" value="Cancel"
		name="_target${reportsource.previousPage}" ALT="Cancel"
		onmouseover="this.src = 'images/cancel_on.gif';"
		onmouseout="this.src = 'images/cancel_off.gif';"> <input
		type="image" id="save" src="images/save_off.gif" value="Save"
		name="_target5" ALT="Save"
		onmouseover="this.src = 'images/save_on.gif';"
		onmouseout="this.src = 'images/save_off.gif';"> <input
		type="image" id="reportDataHiddenInput" name="_target0"
		value="Report Data" style="display: none"> <input
		type="image" id="reportFormatHiddenInput" name="_target1"
		value="Report Format" style="display: none"> <input
		type="image" id="reportContentHiddenInput" name="_target2"
		value="Report Content" style="display: none"> <input
		type="image" id="reportCriteriaHiddenInput" name="_target3"
		value="Report Criteria" style="display: none"> <input
		type="image" id="saveReportHiddenInput" name="_target4"
		value="Save Report" style="display: none"> <!--
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







