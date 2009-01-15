$(document).ready(function()
   {	
	/* This code block is your window.onload.  Please don't set window.onload directly. */
	
	// filter screen 
	$('#report_filters_add').find('table').fadeIn('fast');
	cleanUpFilterTable('#report_filters_add');
	
	$('#report_filters_add').find("tr[index]").each(function() {
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
   }
);

function togglePromptForCriteriaTextBox(checkBox) {
	var promptForCriteria = $(checkBox);
	if (promptForCriteria.attr('checked'))
		promptForCriteria.parent().parent().find("[objectname$=reportStandardFilter.criteria]").attr("disabled", "true");
	else
		promptForCriteria.parent().parent().find("[objectname$=reportStandardFilter.criteria]").removeAttr("disabled");
}


function populateCustomFilterRow(customFilterSelectId, selectedFiltersId) {
	var customFilterSelect = $(customFilterSelectId);
	// Get the index and increment it
	var customFiltersIndexValue = parseInt($(selectedFiltersId).attr('index'));	
	
	// Populate the new row with the details from the select box
	var customFilterText = customFilterSelect.find("option:selected").text()
	
	// Create a new row
	var row = $('<tr />');
	var criteriaCount = 0;
	var customFilterTextIndex = customFilterText.indexOf('[');
	var cell = $('<td />');

	var findExp = new RegExp("{[0-9]*}","gi");
	var displayHtml = customFilterSelect.find("option:selected").attr('displayhtml');
	cell.append(displayHtml.replace(findExp, ""));

	// Add hidden field for filter id
	var newInput = $('<input type="hidden" />')
		.attr('objectname', 'reportFilters[INDEXREPLACEMENT].reportCustomFilter.customFilterId')
		.attr('name', 'reportFilters[' + customFiltersIndexValue + '].reportCustomFilter.customFilterId')
		.attr('id', 'reportFilters[' + customFiltersIndexValue + '].reportCustomFilter.customFilterId')
		.val(customFilterSelect.val());
	cell.append(newInput);
	
	// Add hidden field for default display html 
	newInput = $('<input type="hidden" />')
		.attr('objectname', 'reportFilters[INDEXREPLACEMENT].reportCustomFilter.displayHtml')
		.attr('name', 'reportFilters[' + customFiltersIndexValue + '].reportCustomFilter.displayHtml')
		.attr('id', 'reportFilters[' + customFiltersIndexValue + '].reportCustomFilter.displayHtml')
		.val(displayHtml);
	cell.append(newInput);
	
	customFilterSelect.parent().replaceWith(cell);
	cleanUpFilterTable(selectedFiltersId);
}

function cloneFilterRow(filterSelectId, selectedFiltersId) {
	var filterSelect = $(filterSelectId);
	var filterValue = filterSelect.find("option:selected").val();
	var filterTable;
	if (filterValue == 1) {
		// Add Standard Filter
		filterTable = $("#report_standard_filters").clone(true);
		addNewFilterRow(filterTable, selectedFiltersId, 1, '#report_filters_add', true);
	}
	else if (filterValue == 2) {
		// Add Custom Filter
		filterTable = $("#report_custom_filters").clone(true);
		addNewFilterRow(filterTable, selectedFiltersId, 2, '#report_filters_add', true);
	}
	else if (filterValue == 3) {
		// Add Group
		filterTable = $("#report_filter_group_begin").clone(true);
		addNewFilterRow(filterTable, selectedFiltersId, 3, '#report_filters_add', true);
		filterTable.parent().parent().find("table").attr('bgcolor','#C0C0C0');
		filterTable = $("#report_filter_group_end").clone(true);
		addNewFilterRow(filterTable, selectedFiltersId, 4, '#report_filters_add', true);
		filterTable.parent().parent().find("table").attr('bgcolor','#C0C0C0');
	}
	filterSelect.val(0);
}

function insertFilterRow(filterRowSelector) {
	var filterRow = $(filterRowSelector);
	var filterType =  filterRow.find('[objectname$=filterType]').val();
	var filterTable;
	if (filterType == 1) {
		// Add Standard Filter
		filterTable = $("#report_standard_filters").clone(true);
		addNewFilterRow(filterTable, '#report_filters_add', 1, filterRow, false);
	}
	else if (filterType == 2) {
		// Add Custom Filter
		filterTable = $("#report_custom_filters").clone(true);
		addNewFilterRow(filterTable, '#report_filters_add', 2, filterRow, false);
	}
	else if (filterType == 3) {
		// Add Group
		filterTable = $("#report_filter_group_end").clone(true);
		addNewFilterRow(filterTable, '#report_filters_add', 4, filterRow, false);
		filterTable.parent().parent().find("table").attr('bgcolor','#C0C0C0');
		filterTable = $("#report_filter_group_begin").clone(true);
		addNewFilterRow(filterTable, '#report_filters_add', 3, filterRow, false);
		filterTable.parent().parent().find("table").attr('bgcolor','#C0C0C0');
	}
}

function addNewFilterRow(filterTable, selectedFiltersId, filterType, appendToSelector, append) {
	var appendTo = $(appendToSelector);
	var selectedFilters = $(selectedFiltersId);
	if (filterTable != null) {
		var i = parseInt(selectedFilters.attr('index'));
		var j = i + 1;
		selectedFilters.attr('index',j);
		// id on this table doesn't matter as long as it doesn't conflict with the original
		filterTable.attr('id', filterTable.attr('id') + j);
		filterTable.removeClass("focused highlight");

		var row = $('<tr />');
		row.attr('index', j);
		var cell = $('<td />');
		var operatorOptions = $('#report_filters_operator').clone();
		operatorOptions.attr('id', operatorOptions.attr('id') + j);
		operatorOptions.fadeIn("fast");
		cell.append(operatorOptions);
		row.append(cell);

		cell = $('<td />');
		filterTable.fadeIn("fast")
		cell.append(filterTable);
		row.append(cell);

		cell = $('<td />');
		operatorOptions = $('#report_filters_action').clone();
		operatorOptions.attr('id', operatorOptions.attr('id') + j);
		operatorOptions.fadeIn("fast");
		cell.append(operatorOptions);
		row.append(cell);				

		if (append)
			appendTo.append(row);
		else
			appendTo.after(row);
		row.fadeIn("fast")
		if (filterType != 4) {
			row.find(".deleteButton").click(function(){
					deleteFilterRow($(this).parent().parent().parent().parent().parent().parent());
			});
		} else {
			row.find('.deleteButton').attr("style", "cursor: auto;");
			row.find('.deleteButton').attr('src', 'images/icons/blankSpace.png');
			row.find('.addButton').attr("style", "cursor: auto;");
			row.find('.addButton').attr('src', 'images/icons/blankSpace.png');			
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
	}
	cleanUpFilterTable(selectedFilters);
}

function deleteFilterRow(filterRow) {
	var filterType = filterRow.find('input:hidden[name*=filterType]').val();
	
	if (filterType == "3") {
		// Begin Group - delete the end group
		var filterTable = $(filterRow).parent().parent();
		var foundRow = false;
		var groupCount = 0;
		filterTable.find("tr[index]").each(function() {
			var row = $(this);
			if (filterRow.attr('id') == row.attr('id')) {
				foundRow = true;
			}
			if (foundRow && row.find('input:hidden[name*=filterType]').val() == 3) 
				groupCount++;
			if (foundRow && row.find('input:hidden[name*=filterType]').val() == 4) 
				groupCount--;			
			if (foundRow && row.find('input:hidden[name*=filterType]').val() == 4 && groupCount == 0) {
				row.fadeOut("fast",function(){
					$(this).remove();
					cleanUpFilterTable('#report_filters_add');
				});
				return false;
			}
	   	});		
	}
	filterRow.fadeOut("fast",function(){
		$(this).remove();
		cleanUpFilterTable('#report_filters_add');
	});
}

function moveFilterRow(filterRow, moveBy) {
	var filterRow = $(filterRow);
	var index = parseInt(filterRow.attr('index'));
	var newIndex = index + moveBy;
	var filterTable = $(filterRow).parent().parent();

	if (newIndex >= 0) {
		filterTable.find("tr[index]").each(function() {
			var row = $(this);
			if (parseInt(row.attr('index')) == newIndex) {
				row.attr('index', index);
				return false;
			}			
	   	});
		filterRow.attr('index', newIndex)
	}
	
	sortFilterTable(filterTable);
	cleanUpFilterTable(filterTable);
}

function sortFilterTable(filterTableSelector) {
	var filterTable = $(filterTableSelector);
	var rows = filterTable.find('tr[index]').get();
	
    rows.sort(function(a, b) {
      var keyA = parseInt($(a).attr('index'));
      var keyB = parseInt($(b).attr('index'));
      if (keyA < keyB) return -1;
      if (keyA > keyB) return 1;
      return 0;
    });
    
    $.each(rows, function(index, row) {
    	filterTable.children('tbody').append(row);
   	});	
}

function cleanUpFilterTable(filterTableSelector) {
	var filterTable = $(filterTableSelector);
	var rows = filterTable.find('tr[index]').get();
	var index = 0;
	var groupCount = 0;
	var beginGroup = false;
	var firstRow = true;
	filterTable.find("tr[index]").each(function() {
		var filterTableRow = $(this);
		if (beginGroup || firstRow) {
			filterTableRow.find('select[objectname$=operator]').attr("disabled", true);
			if (beginGroup)
				beginGroup = false;
			if (firstRow)
				firstRow = false;
		} else {
			filterTableRow.find('select[objectname$=operator]').removeAttr("disabled");			
		}		
		filterTableRow.attr('index', index);
		filterTableRow.attr('id', 'filterTable' + index);
		filterTableRow.attr('name', 'filterTable' + index);
		cleanUpFilterTableProcessRow(filterTableRow, index)
		if (filterTableRow.find('input:hidden[name*=filterType]').val() == 3) {
			beginGroup = true;
			filterTableRow.find('#beginGroupLabel').html(replicateString('<img src="images/icons/blankSpace.png"/>><img src="images/icons/blankSpace.png"/>', groupCount) + 'Begin Group');
			groupCount++;
		}
		if (filterTableRow.find('input:hidden[name*=filterType]').val() == 4) {
			filterTableRow.find('select[name*=operator]').attr("disabled", true);	
			groupCount--;
			filterTableRow.find('#endGroupLabel').html(replicateString('<img src="images/icons/blankSpace.png"/>><img src="images/icons/blankSpace.png"/>', groupCount) + 'End Group');
		}		
		index++;	
   	});
	filterTable.attr('index',index);
}

function replicateString(string, number) {
	var result = '';
	while (number > 0) {
		result = result + string;
		number--;
	}
	return result;
}

function cleanUpFilterTableProcessRow(filterRow, index) {
	var row = $(filterRow);
	var findExp = new RegExp("\\[INDEXREPLACEMENT\\]","gi");
	row.find("input[objectname]").each(function(){
		var field = $(this);
		var nameString = field.attr('objectname').replace(findExp, "["+index+"]");
		field.attr('name',nameString);
		var idString = field.attr('objectname').replace(findExp, "["+index+"]");
		field.attr('id',idString);		
	});

	row.find("select[objectname]").each(function(){
		var field = $(this);
		var nameString = field.attr('objectname').replace(findExp, "["+index+"]");
		field.attr('name',nameString);
		var idString = field.attr('objectname').replace(findExp, "["+index+"]");
		field.attr('id',idString);				
	});	
}

function filterCriteria(fieldSelectId) {
	var fieldSelect = $(fieldSelectId);
	var filterRow = fieldSelect.parent().parent();
	var comparison = filterRow.find("select[objectname*=comparison]");
	if (fieldSelect.find("option:selected").attr('fieldType') == "DATE")
		comparison.find("optgroup[dateonly=true]").show();
	else
	{
		if (comparison.find("option:selected").attr('dateonly') == "true")
		{
			comparison.val(1);
			displayPromptForCriteriaOptions(comparison)
		}
		comparison.find("optgroup[dateonly=true]").hide();
	}
}

function displayPromptForCriteriaOptions(comparisonSelectId) {
	var comparison = $(comparisonSelectId);
	var filterRow = comparison.parent().parent();
	if (comparison.find("option:selected").attr('dateonly') == "true") {
		filterRow.find("[objectname$=promptForCriteria]").attr("disabled", "true");
		filterRow.find("[objectname$=reportStandardFilter.criteria]").attr("disabled", "true");
	}
	else {
		var promptForCriteria = filterRow.find("[objectname$=promptForCriteria]"); 
		promptForCriteria.removeAttr("disabled");
		if (promptForCriteria.attr('checked'))
			filterRow.find("[objectname$=reportStandardFilter.criteria]").attr("disabled", "true");
		else
			filterRow.find("[objectname$=reportStandardFilter.criteria]").removeAttr("disabled");
	}	
}

function updateRowCountInput(rowCountSelector) {
	var rowCount = $(rowCountSelector).find('option:selected').val();
	var rowCountInput = $('#rowCount');
	rowCountInput.val(rowCount);
	if (rowCount == '') {
		rowCountInput.removeAttr('style');
		rowCountInput.val('100');
		rowCountInput.select();
	} else {
		rowCountInput.attr('style', 'display: none;');
	}
}