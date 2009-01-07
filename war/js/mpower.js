$(document).ready(function() {	
	/* This code block is your window.onload.  Please don't set window.onload directly. */
	
	initializeMatrixScreen();
	rowCloner("#report_groupbyfields tr:last");
}
);

function rowCloner(selector) {
	$(selector).one("change",function(event){
		if(event.keyCode != 9) { // ignore tab
			addNewRow(selector);
		}
		rowCloner(selector);
	});
}

function callServer(name) {
    Hello.greet(name, callback);
}
function callback(data) {
    alert("AJAX Response:" + data);
}
function addNewRow(selector) {
	$(selector).find(".deleteButton").click(function(){
			deleteRow($(this).parent().parent());
		}).show();
	var newRow = $(selector).clone(true);
	newRow.find(".deleteButton").hide();
	var i = newRow.attr("rowindex");
	var j = parseInt(i) + 1;
	newRow.attr("rowindex",j);
	var findExp = new RegExp("\\["+i+"\\]","gi");

	newRow.find("input").each(function(){
		var field = $(this);
		var nameString = field.attr('name').replace(findExp, "["+j+"]");
		field.attr('name',nameString);
		field.val("");	
		var idString = field.attr('id').replace(findExp, "["+j+"]");
		field.attr('id',idString);		
	});
	
	newRow.find(":checkbox").each(function(){
		$(this).val("true");
	});

	newRow.find("select").each(function(){
		var field = $(this);
		var nameString = field.attr('name').replace(findExp, "["+j+"]");
		field.attr('name',nameString);
		var idString = field.attr('id').replace(findExp, "["+j+"]");
		field.attr('id',idString);				
	});

	newRow.removeClass("focused highlight");
	$(selector).parent().append(newRow);
}

function deleteRow(row) {
	if($(".tablesorter tbody tr").length > 1) {
		row.fadeOut("slow",function(){$(this).remove();})
	} else {
		alert("Sorry, you cannot delete that row since it's the only remaining row.")
	};
}

function checkBoxValidate(cb) {
	for (j = 0; j < 4; j++) {
		if (eval("document.myform.ckbox[" + j + "].checked") == true) {
			document.myform.ckbox[j].checked = false;
			if (j == cb) {
				document.myform.ckbox[j].checked = true;
			}
		}
	}
}

function SingleSelect(regex,current) {
	checked = current.checked;
	re = new RegExp(regex);
	for(i = 0; i < document.forms[0].elements.length; i++) {
		elm = document.forms[0].elements[i];
		if (elm.type == 'checkbox') {
			if (re.test(elm.name)) {
				elm.checked = false;
			}
		}
	}
	if (checked)
		current.checked = true;
}

function initializeMatrixScreen() {
	rowCloner("#report_matrixrows tr:last");
	rowCloner("#report_matrixColumns tr:last");
	$('#report_matrixrows').find(".deleteButton:visible").click(function(){
		deleteRow($(this).parent().parent());
	});
	$('#report_matrixColumns').find(".deleteButton:visible").click(function(){
		deleteRow($(this).parent().parent());
	});		
}
