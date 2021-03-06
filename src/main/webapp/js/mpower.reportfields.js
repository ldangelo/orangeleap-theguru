$(document).ready(function() {
	/* This code block is your window.onload.  Please don't set window.onload directly. */

	initializeFieldScreen();

	checkForReturn('#fieldsDisplay');
});

function initializeFieldScreen() {
	$('#fieldGroups').find("option:first").attr('selected', true);
	updateDisplayedFields();
	cleanUpFieldTable('#report_fields_add');
	fillChartCalcOptions('#reportChartSettings\\[0\\]\\.reportChartSettingsSeries\\[0\\]\\.series');
	displayChartTypeWarning();
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
		fields.find('optgroup').attr('hidden', false);
	} else {
		fields.find('optgroup').attr('hidden', true);
		fields.find('optgroup[fieldgroupid=' + groupId + ']').attr('hidden', false);
	}
	var searchText = $('#fieldSearch').val();
	if (searchText != '') {
		fields.find('option').attr('hidden', false);
		$('#fields').find('option:not(option:Contains("' + searchText + '"))').attr('hidden', true);
	} else {
		fields.find('option').attr('hidden', false);
	}
	fieldsDisplay.empty();
	fieldsDisplay.append(fields.find('optgroup').clone());
	fieldsDisplay.find('optgroup[hidden=true]').remove();
	fieldsDisplay.find('option[hidden=true]').remove();
	fieldsDisplay.find("option:visible:first").attr('selected', true);
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
	fieldList.find('option[fieldid=' + fieldSelected.attr('fieldid') + ']').attr('selected', true);
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
	fieldRow.find('select[objectname$=fieldId]').focus();
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
	var yAxisSelect = $('#reportChartSettings\\[0\\]\\.reportChartSettingsSeries\\[0\\]\\.series');
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

		setOptionsEnabled(fieldTableRow, index);

		index++;
   	});

	fieldTable.attr('index',index);

	// reset the selected options
	xAxisSelect.find('option[value=' + xAxisFieldId + ']').attr('selected', true);
	yAxisSelect.find('option[value=' + yAxisFieldId + ']').attr('selected', true);

	// display the chart settings if any groups are selected
	if (fieldTable.find('input[objectname$=groupBy][checked]').length > 0)
		$('#chartSettings').fadeIn('fast');
	else
		$('#chartSettings').fadeOut('fast');
}

function setOptionsEnabled(rowSelector, index) {
	var fieldRow = $(rowSelector);
	var field = fieldRow.find('select[objectname$=fieldId]');
	if (fieldRow.find('input[objectname$=groupBy]').attr('checked')) {
		//fieldRow.find('input[objectname$=count]').attr('disabled', true);
		if (field.find('option:selected').attr('fieldtype') != 'MONEY') {
			fieldRow.find('input[objectname$=sum]').attr('disabled', true);
			fieldRow.find('input[objectname$=average]').attr('disabled', true);
		}
		// add the group by field to the x axis chart options
		if(index ==0) {
			$('#reportChartSettings\\[0\\]\\.fieldIdx').append(field.find('option:selected').clone(true));
			var fieldType = field.find('option:selected').attr('fieldtype');
			if (fieldType != 'MONEY' && fieldType != 'INTEGER' && fieldType != 'DOUBLE') {
				var currentChartType = $('#reportChartSettings\\[0\\]\\.chartType').find('option:selected').attr('value');
				if (currentChartType == 'Scatter' || currentChartType == 'XYArea'
				|| currentChartType == 'XYBar' || currentChartType == 'XYLine') {
					$('#reportChartSettings\\[0\\]\\.chartType').val($('#reportChartSettings\\[0\\]\\.chartType').find('option:visible:first').val());
				}
				// hide Scatter, XY Area, XY Bar, & XY Line
				$('#reportChartSettings\\[0\\]\\.chartType').find("option[value='Scatter']").hide();
				$('#reportChartSettings\\[0\\]\\.chartType').find("option[value='XYArea']").hide();
				$('#reportChartSettings\\[0\\]\\.chartType').find("option[value='XYBar']").hide();
				$('#reportChartSettings\\[0\\]\\.chartType').find("option[value='XYLine']").hide();
			} else {
				$('#reportChartSettings\\[0\\]\\.chartType').find("option[value='Scatter']").show();
				$('#reportChartSettings\\[0\\]\\.chartType').find("option[value='XYArea']").show();
				$('#reportChartSettings\\[0\\]\\.chartType').find("option[value='XYBar']").show();
				$('#reportChartSettings\\[0\\]\\.chartType').find("option[value='XYLine']").show();
			}
			if (fieldType != 'DATE') {
				var currentChartType = $('#reportChartSettings\\[0\\]\\.chartType').find('option:selected').attr('value');
				if (currentChartType == 'TimeSeries') {
					$('#reportChartSettings\\[0\\]\\.chartType').val($('#reportChartSettings\\[0\\]\\.chartType').find('option:visible:first').val());
				}
				// hide Time Series chart type
				$('#reportChartSettings\\[0\\]\\.chartType').find("option[value='TimeSeries']").hide();
				$('#reportChartSettings\\[0\\]\\.chartType').find("option[value='XYArea']").hide();
				$('#reportChartSettings\\[0\\]\\.chartType').find("option[value='XYBar']").hide();
				$('#reportChartSettings\\[0\\]\\.chartType').find("option[value='XYLine']").hide();
			} else {
				$('#reportChartSettings\\[0\\]\\.chartType').find("option[value='TimeSeries']").show();
			}			
		}
	} else {
		//fieldRow.find('input [objectname$=count]').removeAttr('disabled');
		//fieldRow.find('input[objectname$=count]').attr('disabled', true);
		fieldRow.find('input[objectname$=sum]').removeAttr('disabled');
		fieldRow.find('input[objectname$=average]').removeAttr('disabled');
		if (field.find('option:selected').attr('fieldtype') != 'MONEY' && field.find('option:selected').attr('fieldtype') != 'INTEGER' ) {
			fieldRow.find('input[fieldtype=summary]').attr('disabled', true);
			fieldRow.find('select[fieldtype=summary]').attr('disabled', true);
		} else {
			fieldRow.find('input[fieldtype=summary]').removeAttr('disabled');
			fieldRow.find('select[fieldtype=summary]').removeAttr('disabled');
			fieldRow.find('input[objectname$=max]').removeAttr('disabled');
			fieldRow.find('input[objectname$=min]').removeAttr('disabled');
	    }
		$('#reportChartSettings\\[0\\]\\.reportChartSettingsSeries\\[0\\]\\.series').append(field.find('option:selected').clone(true));
	}
	fillChartCalcOptions('#reportChartSettings\\[0\\]\\.reportChartSettingsSeries\\[0\\]\\.series');
}

function fillChartCalcOptions(fieldSelectId) {
	var fieldSelect = $(fieldSelectId);
	var filterRow = fieldSelect.parent().parent();
	var calculation =  $("[id$=operation]");
	var fieldType = fieldSelect.find("option:selected").attr('fieldType');
	if (fieldType == 'MONEY' || fieldType == 'INTEGER' || fieldType == 'DOUBLE')
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

function checkForReturn(selector)
{
	$(selector).one("keypress",function(event){
		if(event.keyCode == 13) { // ignore tab
			addReportField(selector);
		}
		checkForReturn(selector);
	});
}

function displayChartTypeWarning() {
	var currentChartType = $('#reportChartSettings\\[0\\]\\.chartType').find('option:selected').attr('value');
	if (currentChartType == 'Scatter' || currentChartType == 'XYArea'
	|| currentChartType == 'XYBar' || currentChartType == 'XYLine'
	|| currentChartType == 'TimeSeries') {
		alert('The selected chart type does not support NULL values for the Category (x-axis) field.  Please make sure to add criteria to the report that requires the select Category field to have a value ("has any value" comparison).');
	}
}

$.expr[':'].Contains = function(obj, index, meta, stack){
	return (obj.textContent || obj.innerText || jQuery(obj).text() || '').toLowerCase().indexOf(meta[3].toLowerCase()) >= 0;
};
