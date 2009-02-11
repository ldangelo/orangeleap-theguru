$(document).ready(function()
   {	
	/* This code block is your window.onload.  Please don't set window.onload directly. */
	/*
	// filter screen 
	$('#report_filters_add').find('table').fadeIn('fast');
	cleanUpFilterTable('#report_filters_add');
	
	$('#report_filters_add').find("tr[index!=-1]").each(function() {
		var row = $(this);		
		var filterType = row.find('input:hidden[name*=filterType]').val();
		if (filterType != 4) {
			row.find(".deleteButton").click(function(){
					deleteFilterRow($(this).parent().parent().parent().parent().parent().parent());
			});
		} else {
			row.find('.deleteButton').attr("style", "cursor: auto;");
			row.find('.deleteButton').attr('src', 'images/icons/blankSpace.png');			
		}
		row.find(".moveUpButton").click(function(){
			moveFilterRow($(this).parent().parent().parent().parent().parent().parent(), -1);
		}).show();
		row.find(".moveDownButton").click(function(){
			moveFilterRow($(this).parent().parent().parent().parent().parent().parent(), 1);
		}).show();
		row.find(".addButton").click(function(){
			insertFilterRow($(this).parent().parent().parent().parent().parent().parent());
		});		
   	});
	*/
	
	
   }
);



function fillCalcOptions(fieldSelectId) {
	var fieldSelect = $(fieldSelectId);
	var filterRow = fieldSelect.parent().parent();
	var calculation =  $("[id$=calculation]");
	if (fieldSelect.find("option:selected").attr('fieldType') == "MONEY")
		calculation.find("option[moneyonly=true]").show();
	else
	{
		calculation.find("option[moneyonly=true]").hide();
		if (calculation.find("option:selected").attr('moneyonly') == "true")
		{
			calculation.val(calculation.find('option:visible:first').val());
		}		
	}
	
}


