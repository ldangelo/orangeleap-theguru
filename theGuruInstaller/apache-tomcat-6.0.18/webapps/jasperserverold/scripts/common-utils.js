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

var overlayObjectStack = new Array();

function pushOverlayObject(elementId, style, zIndex)
{
	var table = document.getElementById(elementId);
	var off = getAbsoluteOffsets(table);
	
	if (isInternetExplorer())
	{
		//render a trasnparent IFrame to hide selects
		var iframe = renderTransparentIFrame(off[0], off[1], off[2]-off[0], off[3]-off[1]);
		overlayObjectStack.push(iframe);
	}
	
	var overlayObject = renderOverlay(off[0], off[1], off[2]-off[0], off[3]-off[1], style);
	if (zIndex)
	{
		overlayObject.style.zIndex = zIndex;
	}
	overlayObjectStack.push(overlayObject);
}

function popOverlayObject()
{
	if (overlayObjectStack.length > 0)
	{
		var overlayObject = overlayObjectStack.pop();
		removeOverlay(overlayObject);
		
		if (isInternetExplorer() && overlayObjectStack.length > 0)
		{
			//remove the transparent IFrame
			removeOverlay(overlayObjectStack.pop());
		}
	}
}

function popAllOverlayObjects()
{
	while (overlayObjectStack.length > 0)
	{
		var overlayObject = overlayObjectStack.pop();
		removeOverlay(overlayObject);
	}
}

function selectAndFocusOn(id)
{
	var el = document.getElementById(id);
	el.select();
	el.focus();
}

function evaluateScripts(root)
{
	var rootEl;
	if (typeof(root) == "string")
	{
		rootEl = document.getElementById(root);
	}
	else
	{
		rootEl = root;
	}
	var scriptElems = rootEl.getElementsByTagName("script");
	for (var x = 0; x < scriptElems.length; ++x)
	{
		var scriptElem = scriptElems[x];
		if (scriptElem.text
			&& (!scriptElem.src || scriptElem.src == ""))
		{
			eval(scriptElem.text);
		}
	}
}

function isInternetExplorer()
{
	return navigator.userAgent.indexOf("MSIE") >= 0;
}

var IFRAME_MARGIN = 5;

function renderTransparentIFrame(left, top, width, height)
{
	var iframe = document.createElement("IFRAME");
	iframe.frameBorder = 0;
	iframe.style["filter"] = "alpha(opacity=0)";
	iframe.style.position = "absolute";
	iframe.style.left = left - IFRAME_MARGIN;
	iframe.style.top = top - IFRAME_MARGIN;
	iframe.style.width = width - 2*IFRAME_MARGIN;
	iframe.style.height = height - 2*IFRAME_MARGIN;
	document.body.appendChild(iframe);
	return iframe;
}
