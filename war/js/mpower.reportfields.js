$(document).ready(function() {	
	/* This code block is your window.onload.  Please don't set window.onload directly. */

	initializeFieldScreen();
});

function initializeFieldScreen() {
	$('#fieldGroups').find("option:first").attr('selected', 'true');
	updateDisplayedFields();
	cleanUpFieldTable('#report_fields_add');
	$('#report_fields_add').find("tr[index!=-1]").each(function() {
		var row = $(this);		
		row.find(".deleteButton").click(function(){
				deleteFieldRow($(this).parent().parent());
		});
		row.find(".moveUpButton").click(function(){
			moveFieldRow($(this).parent().parent(), -1);
		});
		row.find(".moveDownButton").click(function(){
			moveFieldRow($(this).parent().parent(), 1);
		});		
   	});	
}

function updateDisplayedFields() {
	var groupId = $('#fieldGroups').find("option:selected").attr('groupid');
	var fields = $('#fields'); 
	var fieldsDisplay = $('#fieldsDisplay');
	if (groupId == -1) {
		fields.find('optgroup').attr('hidden', 'false');
	} else {
		fields.find('optgroup').attr('hidden', 'true');
		fields.find('optgroup[fieldgroupid=' + groupId + ']').attr('hidden', 'false');
	}
	var searchText = $('#fieldSearch').val();
	if (searchText != '') {
		fields.find('option').attr('hidden', 'false');
		$('#fields').find('option:not(option:Contains("' + searchText + '"))').attr('hidden', 'true');
	} else {
		fields.find('option').attr('hidden', 'false');
	}
	fieldsDisplay.empty();
	fieldsDisplay.append(fields.find('optgroup').clone());
	fieldsDisplay.find('optgroup[hidden=true]').remove();
	fieldsDisplay.find('option[hidden=true]').remove();
	fieldsDisplay.find("option:visible:first").attr('selected', 'true');
}

function addReportField(fieldSelector) {
	var fieldSelected = $(fieldSelector).find('option:selected');
	var fieldSource = $('#report_fields_source tr:last').clone();
	var selectedFields = $('#report_fields_add');
	var index = parseInt(selectedFields.attr('index'));
	selectedFields.attr('index', index + 1);
	fieldSource.attr('index', index);
	fieldSource.attr('id', fieldSource.attr('id') + index);
	fieldSource.attr('name', fieldSource.attr('name') + index);
	var fieldList = fieldSource.find('select[objectname$=fieldId]');
	fieldList.find('option[fieldid=' + fieldSelected.attr('fieldid') + ']').attr('selected','true');
	selectedFields.append(fieldSource);
	fieldSource.fadeIn('fast');
	fieldSource.find(".deleteButton").click(function(){
		deleteFieldRow($(this).parent().parent())});
	fieldSource.find(".moveUpButton").click(function(){
		moveFieldRow($(this).parent().parent(), -1);});
	fieldSource.find(".moveDownButton").click(function(){
		moveFieldRow($(this).parent().parent(), 1);});
	cleanUpFieldTable('#report_fields_add');
}

function deleteFieldRow(fieldRow) {
	fieldRow.fadeOut("fast",function(){
		$(this).remove();
		cleanUpFieldTable('#report_fields_add');
	});
}

function deleteAllFieldRows() {
	$('#report_fields_add').find('tr[index!=-1]').fadeOut("fast",function(){
		$(this).remove();
	});
	cleanUpFieldTable('#report_fields_add');	
}

function moveFieldRow(fieldRow, moveBy) {
	var fieldRow = $(fieldRow);
	var index = parseInt(fieldRow.attr('index'));
	var newIndex = index + moveBy;
	var fieldTable = $(fieldRow).parent().parent();

	if (newIndex >= 0) {
		fieldTable.find("tr[index!=-1]").each(function() {
			var row = $(this);
			if (parseInt(row.attr('index')) == newIndex) {
				row.attr('index', index);
				return false;
			}			
	   	});
		fieldRow.attr('index', newIndex)
	}
	
	sortFieldTable(fieldTable);
}

function sortFieldTable(fieldTableSelector) {
	var fieldTable = $(fieldTableSelector);
	var rows = fieldTable.find('tr[index!=-1]').get();
	
    rows.sort(function(a, b) {
      var keyA = parseInt($(a).attr('index'));
      var groupA = $(a).find('input[objectname$=groupBy]').attr('checked') == true;
      var keyB = parseInt($(b).attr('index'));
      var groupB = $(b).find('input[objectname$=groupBy]').attr('checked') == true;
      if (groupA && !groupB) return -1;
      if (!groupA && groupB) return 1;
      if (keyA < keyB) return -1;
      if (keyA > keyB) return 1;
      return 0;
    });

    $.each(rows, function(index, row) {
    	fieldTable.children('tbody').append(row);
   	});	
    
    cleanUpFieldTable(fieldTable);
}

function cleanUpFieldTable(fieldTableSelector) {
	// Get the currently selected x and y axis field id values
	var xAxisSelect = $('#reportChartSettings\\[0\\]\\.fieldIdx');
	var xAxisFieldId = xAxisSelect.find('option:selected').attr('value');
	xAxisSelect.find('option').remove();
	var yAxisSelect = $('#reportChartSettings\\[0\\]\\.fieldIdy');
	var yAxisFieldId = yAxisSelect.find('option:selected').attr('value');
	yAxisSelect.find('option').remove();

	var fieldTable = $(fieldTableSelector);
	var index = 0;
	var groupCount = 0;
	var beginGroup = false;
	var firstRow = true;
	
	fieldTable.find("tr[index!=-1]").each(function() {
		var fieldTableRow = $(this);
		fieldTableRow.attr('index', index);
		fieldTableRow.attr('id', 'fieldRow' + index);
		fieldTableRow.attr('name', 'fieldRow' + index);
		var findExp = new RegExp("\\[INDEXREPLACEMENT\\]","gi");

		fieldTableRow.find("input[objectname!='']").each(function(){
			var field = $(this);
			var nameString = field.attr('objectname').replace(findExp, "["+index+"]");
			field.attr('name',nameString);
			var idString = field.attr('objectname').replace(findExp, "["+index+"]");
			field.attr('id',idString);		
		});

		fieldTableRow.find("select[objectname!='']").each(function(){
			var field = $(this);
			var nameString = field.attr('objectname').replace(findExp, "["+index+"]");
			field.attr('name',nameString);
			var idString = field.attr('objectname').replace(findExp, "["+index+"]");
			field.attr('id',idString);				
		});

		setOptionsEnabled(fieldTableRow);

		index++;	
   	});
	
	fieldTable.attr('index',index);

	// reset the selected options
	xAxisSelect.find('option[value=' + xAxisFieldId + ']').attr('selected', 'true');
	yAxisSelect.find('option[value=' + yAxisFieldId + ']').attr('selected', 'true');
	
	// display the chart settings if any groups are selected
	if (fieldTable.find('input[objectname$=groupBy][checked]').length > 0)
		$('#chartSettings').fadeIn('fast');
	else
		$('#chartSettings').fadeOut('fast');
}

function setOptionsEnabled(rowSelector) {
	var fieldRow = $(rowSelector);
	var field = fieldRow.find('select[objectname$=fieldId]'); 
	if (fieldRow.find('input[objectname$=groupBy]').attr('checked')) {
		fieldRow.find('input[objectname$=count]').attr('disabled', 'true');
		fieldRow.find('input[objectname$=sum]').attr('disabled', 'true');
		fieldRow.find('input[objectname$=average]').attr('disabled', 'true');
		// add the group by field to the x axis chart options
		$('#reportChartSettings\\[0\\]\\.fieldIdx').append(field.find('option:selected').clone(true));
	} else {
		//fieldRow.find('input [objectname$=count]').removeAttr('disabled');
		fieldRow.find('input[objectname$=count]').attr('disabled','true');
		fieldRow.find('input[objectname$=sum]').removeAttr('disabled');
		fieldRow.find('input[objectname$=average]').removeAttr('disabled');		
		if (field.find('option:selected').attr('fieldtype') != 'MONEY') {
			fieldRow.find('input[fieldtype=summary]').attr('disabled', 'true');
			fieldRow.find('select[fieldtype=summary]').attr('disabled', 'true');
		} else {
			fieldRow.find('input[fieldtype=summary]').removeAttr('disabled');
			fieldRow.find('select[fieldtype=summary]').removeAttr('disabled');
			fieldRow.find('input[objectname$=max]').removeAttr('disabled');
			fieldRow.find('input[objectname$=min]').removeAttr('disabled');
	    }
		$('#reportChartSettings\\[0\\]\\.fieldIdy').append(field.find('option:selected[fieldtype="MONEY"]').clone(true));		
	}
}

jQuery.extend(jQuery.expr[':'], {
    Contains : "jQuery(a).text().toUpperCase().indexOf(m[3].toUpperCase())>=0"
 }); 
