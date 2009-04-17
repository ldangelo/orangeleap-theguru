/*
 * Copyright (C) 2005 - 2007 JasperSoft Corporation.  All rights reserved.
 * http://www.jaspersoft.com.
 *
 * Unless you have purchased a commercial license agreement from JasperSoft,
 * the following license terms apply:
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as published by
 * the Free Software Foundation.
 *
 * This program is distributed WITHOUT ANY WARRANTY; and without the
 * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/licenses/gpl.txt
 * or write to:
 *
 * Free Software Foundation, Inc.,
 * 59 Temple Place - Suite 330,
 * Boston, MA  USA  02111-1307
 */

var closeToRepository = false;

function exportReport(type)
{
	setBlankFormTarget();
	setTimeout('setSelfFormTarget()', 500);
	document.viewReportForm.output.value="" + type;
	document.viewReportForm._eventId_export.click();
}

function setBlankFormTarget()
{
	document.viewReportForm.target='_blank';
}

function setSelfFormTarget()
{
	document.viewReportForm.target='_self';
}

function backToInputControlsPage()
{
	document.viewReportForm._eventId_back.click();
}

function closeViewReport(parentFolderUri)
{
	document.viewReportForm._eventId_close.click();
}

function showInputControlsDialog(auto)
{
	closeToRepository = Boolean(auto);
	showDiv('inputControlsContainer');
}

function inputControlsDialogCancel()
{
	if (closeToRepository)
	{
		closeViewReport();
	}
	else
	{
		cancelInputControlsDialog();
	}
}

function cancelInputControlsDialog()
{
	hideInputControlsDialog();
	var url = "flow.html?_flowExecutionKey=" + document.inputControlsFrm._flowExecutionKey.value
		+ "&_eventId=revertToSaved"
		+ "&decorate=no";
	ajaxTargettedUpdate(url, "inputControlsContainer", null, "inputValuesUpdated();", baseErrorHandler);
}

function hideInputControlsDialog()
{
	hideDiv('inputControlsContainer');
}

function setInputValues(postAction)
{
	var postCall = postAction ? ("inputValuesUpdated(); if (!hasInputValuesErrors()) { " + postAction + " };") : null;
	var extraParams = {"_eventId": "setInputValues", "decorate" : "no"};
	ajaxTargettedFormSubmit("inputControlsFrm", "flow.html", extraParams, "inputControlsContainer", null, postCall, baseErrorHandler);
}

function inputValuesUpdated()
{
	evaluateScripts("inputControlsContainer");
}

function hasInputValuesErrors()
{
	var errorsEl = document.getElementById("_inputValuesErrors");
	return errorsEl.value == "true";
}

function refreshReport()
{
	var url = "flow.html?_flowExecutionKey=" + document.inputControlsFrm._flowExecutionKey.value
		+ "&_eventId=refreshReport&decorate=no&ParentFolderUri=" + document.inputControlsFrm.ParentFolderUri.value;
	ajaxTargettedUpdate(url, "reportContainer", "reportContained", "reportRefreshed()", baseErrorHandler);
}

function reportRefreshed()
{
	closeToRepository = false;
	copyReportFlowExecutionKey();
}

function copyReportFlowExecutionKey()
{
	if (document.inputControlsFrm)
	{
		document.inputControlsFrm._flowExecutionKey.value = viewReportFlowExecutionKey();
	}
}

function copyControlsFlowExecutionKey()
{
	if (document.viewReportForm)
	{
		document.viewReportForm._flowExecutionKey.value = inputControlsFlowExecutionKey();
	}
}

function submitInputValues()
{
	setInputValues("refreshReport();hideInputControlsDialog();");
}

function applyInputValues()
{
	setInputValues("refreshReport()");
}

function viewReportFlowExecutionKey()
{
	return document.viewReportForm._flowExecutionKey.value;
}

function inputControlsFlowExecutionKey()
{
	return document.inputControlsFrm._flowExecutionKey.value;
}

function navigateToReportPage(page)
{
	var url = "flow.html?_flowExecutionKey=" + viewReportFlowExecutionKey()
		+ "&_eventId=navigate&pageIndex=" + page
		+ "&decorate=no";
	ajaxTargettedUpdate(url, "reportContainer", "reportContained", "copyReportFlowExecutionKey()", baseErrorHandler);
}

function navigateToDashboardReportPage(page)
{
    var url = "flow.html?_flowExecutionKey=" + viewReportFlowExecutionKey()
        + "&_eventId=navigate&pageIndex=" + page
        + "&decorate=no"
        + "&viewAsDashboardFrame=true";
    ajaxTargettedUpdate(url, "reportContainer", "reportContained", "copyReportFlowExecutionKey()", baseErrorHandler);
}

function inputControlsDialogReset()
{
	var url = "flow.html?_flowExecutionKey=" + document.inputControlsFrm._flowExecutionKey.value
		+ "&_eventId=resetToDefaults"
		+ "&decorate=no";
	ajaxTargettedUpdate(url, "inputControlsContainer", null, "inputValuesUpdated()", baseErrorHandler);
}

function submitTopInputValues()
{
	setInputValues("refreshReport();");
}

function isTopControlsPanelShown()
{
	return document.getElementById("topInputControlsPanel").style.display != "none";
}

function hideTopControlsPanel()
{
	document.getElementById("topInputControlsPanel").style.display = "none";
	document.getElementById("topControlsHideImg").style.display = "none";
	document.getElementById("topControlsShowImg").style.display = "inline";
	document.getElementById("topControlsHideSpan").style.display = "none";
	document.getElementById("topControlsShowSpan").style.display = "inline";
}

function showTopControlsPanel()
{
	document.getElementById("topInputControlsPanel").style.display = "";
	document.getElementById("topControlsShowImg").style.display = "none";
	document.getElementById("topControlsHideImg").style.display = "inline";
	document.getElementById("topControlsShowSpan").style.display = "none";
	document.getElementById("topControlsHideSpan").style.display = "inline";
}

function toggleTopControlsPanel()
{
	if (isTopControlsPanelShown())
	{
		var url = "flow.html?_flowExecutionKey=" + document.inputControlsFrm._flowExecutionKey.value
			+ "&_eventId=toggleTopControls"
			+ "&decorate=no";
		ajaxTargettedUpdate(url, "inputControlsContainer", null, "inputValuesUpdated();hideTopControlsPanel();copyControlsFlowExecutionKey();", baseErrorHandler);
	}
	else
	{
		var url = "flow.html?_flowExecutionKey=" + document.inputControlsFrm._flowExecutionKey.value
			+ "&_eventId=toggleTopControls"
			+ "&decorate=no";
		ajaxTargettedUpdate(url, "inputControlsContainer", null, "inputValuesUpdated();showTopControlsPanel();copyControlsFlowExecutionKey();", baseErrorHandler);
	}
}
