jQuery(document).ready(function()
   {
	/* This code block is your window.onload.  Please don't set window.onload directly. */

	// filter screen
	jQuery('#report_filters_add').find('table').fadeIn('fast');
	cleanUpFilterTable('#report_filters_add');

	jQuery('#report_filters_add').find("tr[index!=-1]").each(function() {
		var row = jQuery(this);
		var filterType = row.find('input:hidden[name*=filterType]').val();
		if (filterType != 4) {
			row.find(".deleteButton").click(function(){
					deleteFilterRow(jQuery(this).parent().parent().parent().parent().parent().parent());
			});
		} else {
			row.find('.deleteButton').attr("style", "cursor: auto;");
			row.find('.deleteButton').attr('src', 'images/icons/blankSpace.png');
		}
		row.find(".moveUpButton").click(function(){
			moveFilterRow(jQuery(this).parent().parent().parent().parent().parent().parent(), -1);
		}).show();
		row.find(".moveDownButton").click(function(){
			moveFilterRow(jQuery(this).parent().parent().parent().parent().parent().parent(), 1);
		}).show();
		row.find(".addButton").click(function(){
			insertFilterRow(jQuery(this).parent().parent().parent().parent().parent().parent());
		});
   	});
	if (jQuery('#sqlQuery').length > 0) {
		var targetOffset = jQuery('#showSqlQuerySpan').offset().top;
		scrollTo(0,targetOffset);

		jQuery('#dialog').jqm({overlay: 50, onShow: MPower.centerDialog}).jqDrag('.dragHandle');
		jQuery('#dialog').jqmShow();
	}
	// Validate for 2 decimal for money
	jQuery.validator.addMethod("money", function(value, element) {
	    return this.optional(element) || /^-?\$?(?:\d+|\d{1,3}(?:,\d{3})*)(?:\.\d{1,2}){0,1}$/.test(value);
	}, "Must be in the format 0.99");

	repopulateAJAXCustomFilters();
   }
);

var MPower = {
		centerDialog: function($hash) {
			var $dialog = $hash.w;
			var x = "-" + ($dialog.width() / 2) + "px";
			var y = "-" + ($dialog.height() / 2) + "px";
			$dialog.css("margin-left", x);
			$dialog.css("margin-top", y);
			$dialog.show();
		}
	}


function togglePromptForCriteriaTextBox(checkBox) {
	var promptForCriteria = jQuery(checkBox);
	if (promptForCriteria.attr('checked'))
		promptForCriteria.parent().parent().find("[objectname$=reportStandardFilter.criteria]").attr("disabled", "true");
	else
		promptForCriteria.parent().parent().find("[objectname$=reportStandardFilter.criteria]").removeAttr("disabled");
	applyMasks(promptForCriteria.parent().parent());
}


function populateCustomFilterRow(customFilterSelectId, selectedFiltersId) {
	var customFilterSelect = jQuery(customFilterSelectId);
	// Get the index and increment it
	var customFiltersIndexValue = parseInt(jQuery(selectedFiltersId).attr('index'));

	// Create a new row
	var row = jQuery('<tr />');
	var cell = jQuery('<td />');

	var findExp = new RegExp("{[0-9]*}","gi");
	var displayHtml = customFilterSelect.find("option:selected").attr('displayhtml');
	displayHtml = displayHtml.replace('></OPTION>','/>');
	cell.append(displayHtml.replace(findExp, ""));

	// Add hidden field for filter id
	var newInput = jQuery('<input type="hidden" />')
		.attr('objectname', 'reportFilters[INDEXREPLACEMENT].reportCustomFilter.customFilterDefinitionId')
		.attr('name', 'reportFilters[' + customFiltersIndexValue + '].reportCustomFilter.customFilterDefinitionId')
		.attr('id', 'reportFilters[' + customFiltersIndexValue + '].reportCustomFilter.customFilterDefinitionId')
		.val(customFilterSelect.val());
	cell.append(newInput);

	// Add hidden field for default display html
	newInput = jQuery('<input type="hidden" />')
		.attr('objectname', 'reportFilters[INDEXREPLACEMENT].reportCustomFilter.displayHtml')
		.attr('name', 'reportFilters[' + customFiltersIndexValue + '].reportCustomFilter.displayHtml')
		.attr('id', 'reportFilters[' + customFiltersIndexValue + '].reportCustomFilter.displayHtml')
		.val(displayHtml);
	cell.append(newInput);

	customFilterSelect.parent().replaceWith(cell);
	processCustomFilterAjaxRequests(cell);
	cleanUpFilterTable(selectedFiltersId);
}

function repopulateAJAXCustomFilters() {
	jQuery('#report_filters_add').find('tr[index!=-1]').each(function() {
		var filterTableRow = jQuery(this);
		processCustomFilterAjaxRequests(filterTableRow);
	});
}

function processCustomFilterAjaxRequests(customFilterCell) {
	var cell = jQuery(customFilterCell);
	cell.find("select[populateSelectOptions='AJAX']").each(function() {
		var select = jQuery(this);
		var requestType = jQuery(this).attr('requestType');
		var criteriaArray = {};
		var cont = true;
		var index = 0;
		while (cont) {
			index++;	
			var criteriaName = select.attr("criteria" + index + "Name");
			var criteriaValue = select.attr("criteria" + index + "Value");
			if (criteriaName != null && criteriaValue != null) {
				criteriaArray[criteriaName] = criteriaValue;
			} else {
				cont = false;
			}
		}
		OrangeLeapService.getOrangeLeapDataAsSelectOptions(requestType, criteriaArray, function(options) { jQuery(select).find('option').remove(); jQuery(select).append(options); });
	});
}

function cloneFilterRow(filterSelectId, selectedFiltersId) {
	var filterSelect = jQuery(filterSelectId);
	var filterValue = filterSelect.find("option:selected").val();
	var filterTable;
	if (filterValue == 1) {
		// Add Standard Filter
		filterTable = jQuery("#report_standard_filters").clone(true);
		addNewFilterRow(filterTable, selectedFiltersId, 1, '#report_filters_add', true);
	}
	else if (filterValue == 2) {
		// Add Custom Filter
		filterTable = jQuery("#report_custom_filters").clone(true);
		addNewFilterRow(filterTable, selectedFiltersId, 2, '#report_filters_add', true);
	}
	else if (filterValue == 3) {
		// Add Group
		filterTable = jQuery("#report_filter_group_begin").clone(true);
		addNewFilterRow(filterTable, selectedFiltersId, 3, '#report_filters_add', true);
		filterTable.parent().parent().find("table").attr('bgcolor','#C0C0C0');
		filterTable = jQuery("#report_filter_group_end").clone(true);
		addNewFilterRow(filterTable, selectedFiltersId, 4, '#report_filters_add', true);
		filterTable.parent().parent().find("table").attr('bgcolor','#C0C0C0');
	}
	filterSelect.val(0);
}

function insertFilterRow(filterRowSelector) {
	var filterRow = jQuery(filterRowSelector);
	var filterType =  filterRow.find('[objectname$=filterType]').val();
	var filterTable;
	if (filterType == 1) {
		// Add Standard Filter
		filterTable = jQuery("#report_standard_filters").clone(true);

		//
		// because selected options don't clone we need to walk through the select on the old row
		// and select them properly on the new row...
		selectedOperator = jQuery('select',filterRow).each(function() {
			var select = jQuery(this);
			jQuery('option:selected',jQuery(this)).each(function() {
				jQuery("select[objectname=" + select.attr('objectname') + "]",filterTable).val(jQuery(this).val());
			});
		});

		inputOperator = jQuery('input',filterRow).each(function() {
			var input = jQuery(this);
			//jQuery('option:selected',jQuery(this)).each(function() {
				jQuery("input[objectname=" + input.attr('objectname') + "]",filterTable).val(jQuery(this).val());
				jQuery("input[objectname=" + input.attr('objectname') + "]",filterTable).attr('checked', jQuery(this).attr('checked'));
		});

		addNewFilterRow(filterTable, '#report_filters_add', 1, filterRow, false);
	}
	else if (filterType == 2) {
		// Add Custom Filter
		filterTable = jQuery("#report_custom_filters").clone(true);
		addNewFilterRow(filterTable, '#report_filters_add', 2, filterRow, false);
	}
	else if (filterType == 3) {
		// Add Group
		filterTable = jQuery("#report_filter_group_end").clone(true);
		addNewFilterRow(filterTable, '#report_filters_add', 4, filterRow, false);
		filterTable.parent().parent().find("table").attr('bgcolor','#C0C0C0');
		filterTable = jQuery("#report_filter_group_begin").clone(true);
		addNewFilterRow(filterTable, '#report_filters_add', 3, filterRow, false);
		filterTable.parent().parent().find("table").attr('bgcolor','#C0C0C0');
	}
}

function addNewFilterRow(filterTable, selectedFiltersId, filterType, appendToSelector, append) {
	var appendTo = jQuery(appendToSelector);
	var selectedFilters = jQuery(selectedFiltersId);
	if (filterTable != null) {
		var i = parseInt(selectedFilters.attr('index'));
		var j = i + 1;
		selectedFilters.attr('index',j);
		// id on this table doesn't matter as long as it doesn't conflict with the original
		filterTable.attr('id', filterTable.attr('id') + j);
		filterTable.removeClass("focused highlight");

		var row = jQuery('<tr />');
		row.attr('index', j);
		var cell = jQuery('<td />');
		var operatorOptions = jQuery('#report_filters_operator').clone();
		operatorOptions.attr('id', operatorOptions.attr('id') + j);
		operatorOptions.fadeIn("fast");
		cell.append(operatorOptions);
		row.append(cell);

		cell = jQuery('<td />');
		filterTable.fadeIn("fast")
		cell.append(filterTable);
		row.append(cell);

		cell = jQuery('<td />');
		operatorOptions = jQuery('#report_filters_action').clone();
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
					deleteFilterRow(jQuery(this).parent().parent().parent().parent().parent().parent());
			});
		} else {
			row.find('.deleteButton').attr("style", "cursor: auto;");
			row.find('.deleteButton').attr('src', 'images/icons/blankSpace.png');
			row.find('.addButton').attr("style", "cursor: auto;");
			row.find('.addButton').attr('src', 'images/icons/blankSpace.png');
		}
		row.find(".moveUpButton").click(function(){
			moveFilterRow(jQuery(this).parent().parent().parent().parent().parent().parent(), -1);
		}).show();
		row.find(".moveDownButton").click(function(){
			moveFilterRow(jQuery(this).parent().parent().parent().parent().parent().parent(), 1);
		}).show();
		row.find(".addButton").click(function(){
			insertFilterRow(jQuery(this).parent().parent().parent().parent().parent().parent());
		});
	}
	cleanUpFilterTable(selectedFilters);
}

function deleteFilterRow(filterRow) {
	var filterType = filterRow.find('input:hidden[name*=filterType]').val();

	if (filterType == "3") {
		// Begin Group - delete the end group
		var filterTable = jQuery(filterRow).parent().parent();
		var foundRow = false;
		var groupCount = 0;
		filterTable.find("tr[index!=-1]").each(function() {
			var row = jQuery(this);
			if (filterRow.attr('id') == row.attr('id')) {
				foundRow = true;
			}
			if (foundRow && row.find('input:hidden[name*=filterType]').val() == 3)
				groupCount++;
			if (foundRow && row.find('input:hidden[name*=filterType]').val() == 4)
				groupCount--;
			if (foundRow && row.find('input:hidden[name*=filterType]').val() == 4 && groupCount == 0) {
				row.fadeOut("fast",function(){
					jQuery(this).remove();
					cleanUpFilterTable('#report_filters_add');
				});
				return false;
			}
	   	});
	}
	filterRow.fadeOut("fast",function(){
		jQuery(this).remove();
		cleanUpFilterTable('#report_filters_add');
	});
}

function moveFilterRow(filterRow, moveBy) {
	var filterRow = jQuery(filterRow);
	var index = parseInt(filterRow.attr('index'));
	var newIndex = index + moveBy;
	var filterTable = jQuery(filterRow).parent().parent();

	if (newIndex >= 0) {
		filterTable.find("tr[index!=-1]").each(function() {
			var row = jQuery(this);
			if (parseInt(row.attr('index')) == newIndex) {
				row.attr('index', index);
				return false;
			}
	   	});
		filterRow.attr('index', newIndex)
	}

	sortFilterTable(filterTable);
	cleanUpFilterTable(filterTable);
	filterRow.find('select[objectname$=fieldId]').focus();
}

function sortFilterTable(filterTableSelector) {
	var filterTable = jQuery(filterTableSelector);
	var rows = filterTable.find('tr[index!=-1]').get();

    rows.sort(function(a, b) {
      var keyA = parseInt(jQuery(a).attr('index'));
      var keyB = parseInt(jQuery(b).attr('index'));
      if (keyA < keyB) return -1;
      if (keyA > keyB) return 1;
      return 0;
    });

    $.each(rows, function(index, row) {
    	filterTable.children('tbody').append(row);
   	});
}

function cleanUpFilterTable(filterTableSelector) {
	var filterTable = jQuery(filterTableSelector);
	var reportIsSegmentation = jQuery('#useReportAsSegmentation').attr('checked');
	var index = 0;
	var groupCount = 0;
	var beginGroup = false;
	var firstRow = true;
	filterTable.find('tr[index!=-1]').each(function() {
		var filterTableRow = jQuery(this);
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
		cleanUpFilterTableProcessRow(filterTableRow, index);
		filterCriteria(filterTableRow.find('[objectname$=fieldId]'), reportIsSegmentation);
		applyMasks(filterTableRow);
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

function applyMasks(filterTableRowSelector) {
	var filterRow = jQuery(filterTableRowSelector);
	var fieldtype = filterRow.find('select[objectname$=fieldId]').find('option:selected').attr('fieldtype');
	filterRow.find('input[objectname$=criteria]').attr('fieldtype', fieldtype);
	filterRow.find('input').unmask();
	filterRow.find('input[fieldtype=DATE]').mask('99/99/9999');

	//filterRow.find('input[fieldtype=MONEY]').mask('$.');

	Date.format = 'mm/dd/yyyy';
	// do not process custom filter rows
	filterRow.find('input').datepicker('destroy');
	filterRow.find('input[fieldtype=DATE]').datepicker({showOn: 'button', buttonImage: 'images/icons/calendar.png', buttonImageOnly: true, onClose : function(dateText, inst) {jQuery(this).valid();}});

	var criteria = filterRow.find("[objectname$=reportStandardFilter.criteria]");
	criteria.removeAttr('class');
	var promptForCriteria = filterRow.find("[objectname$=promptForCriteria]");
	if (!promptForCriteria.attr('checked') && !criteria.attr('disabled')) {
		filterRow.find('input[fieldtype=DATE]').attr('class','date required');
		filterRow.find('input[fieldtype=INTEGER]').attr('class','digits required');
		filterRow.find('input[fieldtype=DOUBLE]').attr('class','digits required');
		filterRow.find('input[fieldtype=MONEY]').attr('class','money required');
	} else {
		criteria.removeClass('required');
	}
	var filterRowInputFields = filterRow.find('input');
	if (filterRowInputFields.length > 0)
		filterRowInputFields.valid();
	filterRow.find('input[fieldtype=DATE]').addClass('hasDatepicker');
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
	var row = jQuery(filterRow);
	var findExp = new RegExp("\\[INDEXREPLACEMENT\\]","gi");
	row.find("input[objectname]").each(function(){
		var field = jQuery(this);
		var nameString = field.attr('objectname').replace(findExp, "["+index+"]");
		field.attr('name',nameString);
		var idString = field.attr('objectname').replace(findExp, "["+index+"]");
		field.attr('id',idString);
	});

	row.find("select[objectname!=]").each(function(){
		var field = jQuery(this);
		if (field.attr('objectname') != null) {
			var nameString = field.attr('objectname').replace(findExp, "["+index+"]");
			field.attr('name',nameString);
			var idString = field.attr('objectname').replace(findExp, "["+index+"]");
			field.attr('id',idString);
		}
	});
}

function filterCriteria(fieldSelectId, reportIsSegmentation) {
	if (reportIsSegmentation == null) {
		reportIsSegmentation = jQuery('#useReportAsSegmentation').attr('checked');
	}
 	var fieldSelect = jQuery(fieldSelectId);
	var filterRow = fieldSelect.parent().parent();
	var baseComparison = jQuery('#baseComparisonSelect');
	var comparison = filterRow.find('select[objectname*=comparison]');
	var comparisonValue = comparison.val();
	comparison.empty();
	comparison.append(baseComparison.find("option:not([dateonly=true])").clone());
	comparison.append(baseComparison.find("optgroup[dateonly=true]").clone());
	if (fieldSelect.find('option:selected').attr('fieldType') != 'DATE') {
		if (comparison.find('option:selected').attr('dateonly') == 'true')
		{
			comparison.val(1);
		}
		comparison.find('[dateonly=true]').remove();
	}
	if (comparison.find('option[value=' + comparisonValue + ']').length > 0)
		comparison.val(comparisonValue);
	displayPromptForCriteriaOptions(comparison, reportIsSegmentation);
}

function displayPromptForCriteriaOptions(comparisonSelectId, reportIsSegmentation) {
	var comparison = jQuery(comparisonSelectId);
	var filterRow = comparison.parent().parent();
	var promptForCriteria = filterRow.find("[objectname$=promptForCriteria]");
	if (reportIsSegmentation) {
		promptForCriteria.attr('disabled', true);
		promptForCriteria.attr('checked', false);
		if (comparison.find("option:selected").attr('dateonly') == "true"
		// has any value
		|| comparison.find("option:selected").val() == 11) {
			filterRow.find("[objectname$=reportStandardFilter.criteria]").attr("disabled", "true");
		} else {
			filterRow.find("[objectname$=reportStandardFilter.criteria]").removeAttr("disabled");
		}
	} else if (comparison.find("option:selected").attr('dateonly') == "true"
		// has any value
		|| comparison.find("option:selected").val() == 11) {
		promptForCriteria.attr("disabled", "true");
		filterRow.find("[objectname$=reportStandardFilter.criteria]").attr("disabled", "true");
	}
	else {
		promptForCriteria.removeAttr("disabled");
		if (promptForCriteria.attr('checked'))
			filterRow.find("[objectname$=reportStandardFilter.criteria]").attr("disabled", "true");
		else
			filterRow.find("[objectname$=reportStandardFilter.criteria]").removeAttr("disabled");
	}
	applyMasks(promptForCriteria.parent().parent());
}

function updateRowCountInput(rowCountSelector) {
	var rowCount = jQuery(rowCountSelector).find('option:selected').val();
	var rowCountInput = jQuery('#rowCount');
	rowCountInput.val(rowCount);
	if (rowCount == '') {
		rowCountInput.removeAttr('style');
		rowCountInput.val('100');
		rowCountInput.select();
	} else {
		rowCountInput.attr('style', 'display: none;');
	}
}

function showSqlQueryClick() {
	var targetOffset = jQuery('#showSqlQuerySpan').offset().top;
	scrollTo(0,targetOffset);
	jQuery('#showSqlQuery').attr('checked', 'true');
	triggerClick(document.getElementById('reportCriteriaHiddenInput'));
}

function toggleUseReportAsSegmentation(useReportAsSegmentation) {
	if (jQuery('#useReportAsSegmentation').attr('checked')) {
		jQuery('#segmentationTypeDiv').show();
	} else {
		jQuery('#segmentationTypeDiv').hide();
	}
	cleanUpFilterTable('#report_filters_add');
}