$(document).ready(function()
   {	
	/* This code block is your window.onload.  Please don't set window.onload directly. */
	
   }
);



function fillCalcOptions(fieldSelectId) {
	var fieldSelect = $(fieldSelectId);
	var filterRow = fieldSelect.parent().parent();
	var calculation =  $("[id$=calculation]");
	calculation.find("option").hide();
	if (fieldSelect.find("option:selected").attr('fieldType') == "NONE"){
		calculation.find("option[none=true]").show();
		calculation.find("option[none=false]").hide();
	}
	else if (fieldSelect.find("option:selected").attr('fieldType') == "STRING"){
		calculation.find("option[string=true]").show();
		calculation.find("option[string=false]").hide();
	}
	else if (fieldSelect.find("option:selected").attr('fieldType') == "INTEGER"){
		calculation.find("option[numeric=true]").show();
		calculation.find("option[numeric=false]").hide();
	}
	else if (fieldSelect.find("option:selected").attr('fieldType') == "DOUBLE"){
		calculation.find("option[numeric=true]").show();
		calculation.find("option[numeric=false]").hide();
	}
	else if (fieldSelect.find("option:selected").attr('fieldType') == "DATE"){
		calculation.find("option[date=true]").show();
		calculation.find("option[date=false]").hide();
	}
	else if (fieldSelect.find("option:selected").attr('fieldType') == "MONEY"){
		calculation.find("option[numeric=true]").show();
		calculation.find("option[numeric=false]").hide();
	}
	else if (fieldSelect.find("option:selected").attr('fieldType') == "BOOLEAN"){
		calculation.find("option[boolean=true]").show();
		calculation.find("option[boolean=false]").hide();
	}
	
	if (!calculation.find('option[value=' + calculation.val() + ']').is(':visible'))
	{
		calculation.val(calculation.find('option:visible:first').val());
	}	
}


