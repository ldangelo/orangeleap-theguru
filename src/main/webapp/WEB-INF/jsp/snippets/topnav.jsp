<%@ include file="/WEB-INF/jsp/include.jsp" %>

<script type="text/javascript">
function submitForm() {
	//$("#target").hide();
    var t = $("#currentWizardStep").attr("value");
    var btn = $("#target");
    console.log(t);
    
	$("#target").attr("name",t);

	console.log($("#target").attr("name"));
	$("#target").attr("id",t);	
	btn.click();
	return true;
	}
	
	$(function() {
		$("#target").hide();
	});
</script>
<div class="topnav">
	<form:select path="reportsource.currentWizardStep" multiple="false" onchange="submitForm()"	>
	<form:options items="${reportsource.reportWizardSteps}" itemLabel="description" itemValue="targetName" />
    </form:select>
    <input type="submit" id="target" name="target"> 
</div>