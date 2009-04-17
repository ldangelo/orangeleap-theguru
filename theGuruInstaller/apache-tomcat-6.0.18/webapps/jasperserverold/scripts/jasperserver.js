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


function showDiv(divId)
{
	var div = document.getElementById(divId);
	
    var width = document.body.clientWidth;
    var height = document.body.clientHeight;

    var x = width /2 - parseInt(div.style.width)/2;
    var y;
    if (div.style.height)
    {
    	y = height/2 - parseInt(div.style.height)/2;
    }
    else
    {
	    y = height/4;
    }
    
    div.style.top = y + "px";
    div.style.left = x + "px";
    
    div.style.display= 'block';
}

function hideDiv(divId)
{
	var div = document.getElementById(divId)
    div.style.display= 'none';
    return true;
}

function borderImage(which, color)
{
	//if IE 4+ or NS 6+
	if (document.all||document.getElementById)
	{
		which.style.borderColor=color
	}
}

function resetRadio(radio)
{
	var changed = false;
	if (radio.length)
	{
		for (var i = 0; i < radio.length; ++i)
		{
			if (radio[i].checked)
			{
				radio[i].checked = false;
				changed = true;
			}
		}
	}
	else
	{
		if (radio.checked)
		{
			radio.checked = false;
			changed = true;
		}
	}
	return changed;
}
