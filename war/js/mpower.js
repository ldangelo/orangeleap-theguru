$(document).ready(function()
   {


	
	rowCloner("#report_filters tr:last");
	
	$("#report_filters td .deleteButton").click(function(){
		deleteRow($(this).parent().parent());
	});

   }
);

function rowCloner(selector) {
	$(selector).one("keyup",function(event){
		if(event.keyCode != 9) { // ignore tab
			addNewRow();
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
function addNewRow() {
	$(".tablesorter tr:last .deleteButton").show();
	var newRow = $(".tablesorter tr:last").clone(true);
	newRow.find(".deleteButton").hide();
	var i = newRow.attr("rowindex");
	var j = parseInt(i) + 1;
	newRow.attr("rowindex",j);
	console.log(j);
	var findExp = new RegExp("\\["+i+"\\]","gi");

	newRow.find("input").each(function(){
		var field = $(this);
		var nameString = field.attr('name').replace(findExp, "["+j+"]");
		console.log(nameString);
		field.attr('name',nameString);
		field.val("");
	});

	newRow.find("select").each(function(){
		var field = $(this);
		var nameString = field.attr('name').replace(findExp, "["+j+"]");
		console.log(nameString);
		field.attr('name',nameString);
	});

	newRow.removeClass("focused highlight");
	$(".tablesorter").append(newRow);
	$("#report_filters td .deleteButton").click(function(){
		deleteRow($(this).parent().parent());
	});
}

function deleteRow(row) {
	if($(".tablesorter tbody tr").length > 1) {
		row.fadeOut("slow",function(){$(this).remove();})
	} else {
		alert("Sorry, you cannot delete that row since it's the only remaining row.")
	};
}