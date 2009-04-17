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

function hideShowStackTrace()
{
	var stackTraceDiv;
	var stackTraceDivTitle;

	if(document.getElementById)
	{
		stackTraceDiv = document.getElementById('excptrace');
		stackTraceDivTitle = document.getElementById('excptracetitle');
	}
	else if(document.layers)
	{
		stackTraceDiv = document.layers['excptrace'];
		stackTraceDivTitle = document.layers['excptracetitle'];
	}
	else
	{
		stackTraceDiv = document.all.excptrace;
		stackTraceDivTitle = document.all.excptracetitle;
	}
	hideShow(stackTraceDiv,stackTraceDivTitle);
}

function hideShow(stackTrace,stackTraceTitle)
{
	var hideButton = document.fmJsErrPage._eventId_HideShow;
	if(stackTrace.style.display == "none")
	{
		stackTrace.style.display = "block";
		stackTraceTitle.style.display = "block";
		hideButton.value = document.fmJsErrPage.hideStackTrace.value;
	}
	else
	{
		stackTrace.style.display = "none";
		stackTraceTitle.style.display = "none";
		hideButton.value = document.fmJsErrPage.showStackTrace.value;
	}
}	
