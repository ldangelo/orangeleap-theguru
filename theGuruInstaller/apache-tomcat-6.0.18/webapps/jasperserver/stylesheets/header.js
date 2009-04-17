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

window.onerror = null;

var menuActive = 0;
var onLayer;
var timeOn = null;
var useMenu = 0;

var hide  = true;

rollovers = 1;

function clearBox(box) {
 if(box.value==box.defaultValue) {
    box.value = "";
 }
}

function preloadimages() {
if (rollovers) {
n1 = new Image(); 
n1.src ="./uiparts/nav_company_1.gif";
n2 = new Image(); 
n2.src ="./uiparts/nav_customers_1.gif";
n3 = new Image(); 
n3.src ="./uiparts/nav_home_1.gif";
n4 = new Image(); 
n4.src ="./uiparts/nav_news_1.gif";
n5 = new Image(); 
n5.src ="./uiparts/nav_partners_1.gif";
n6 = new Image();
n6.src ="./uiparts/nav_products_1.gif";
n7 = new Image();
n7.src ="./uiparts/nav_resource_1.gif";
n8 = new Image();
n8.src ="./uiparts/nav_services_1.gif";

}
}

function am(name) {
	if (rollovers) {
		document [name].src = "./uiparts/nav_" + name + "_1.gif";
	}
}
function dm2(name) {
	if (rollovers) {
		document [name].src = "./uiparts/nav_" + name + "_0.gif";
	}
}

function dm(name) {
	if (rollovers) {
		document [name].src = "./uiparts/nav_" + name + "_0.gif";
	}
	btnTimer();
}

function setLyr(obj,lyr)
{
	am(lyr);
	lyr = 'menu_'+lyr;
	if (timeOn != null) {
		clearTimeout(timeOn);
		hideLayer(onLayer);
	}
  
	var newX = findPosX(obj);
	var newY = findPosY(obj);
	if (lyr == 'testP') newY -= 50;
	var x = new getObj(lyr);
	x.style.top = newY + 'px';

	onLayer = lyr;
}

function findPosX(obj)
{
	var curleft = 0;
	if (obj.offsetParent)
	{
		while (obj.offsetParent)
		{
			curleft += obj.offsetLeft
			obj = obj.offsetParent;
		}
	}
	else if (obj.x)
		curleft += obj.x;
	return curleft;
}

function findPosY(obj)
{
	var curtop = 0;
	var printstring = '';
	if (obj.offsetParent)
	{
		while (obj.offsetParent)
		{
			printstring += ' element ' + obj.tagName + ' has ' + obj.offsetTop;
			curtop += obj.offsetTop
			obj = obj.offsetParent;
		}
	}
	else if (obj.y)
		curtop += obj.y;
	return curtop;
}


function getObj(name)
{
	if (document.getElementById)
	{
		this.obj = document.getElementById(name);
		this.style = document.getElementById(name).style;
		document.getElementById(name).style.visibility = "visible";
	}
	else if (document.all)
	{
		this.obj = document.all[name];
		this.style = document.all[name].style;
		document.all[name].style.visibility = "visible";
	}
	else if (document.layers)
	{
	if (document.layers[name])
	{
		this.obj = document.layers[name];
		this.style = document.layers[name];
		document.layers[name].visibility = "show";
	}
	else
	{
		this.obj = document.layers.testP.layers[name];
	this.style = document.layers.testP.layers[name];
	}
	}
}

// Hide the given layer
function hideLayer(layerName) {
  if (menuActive == 0) {
    if (document.getElementById) {
      document.getElementById(layerName).style.visibility = "hidden";
    } else if (document.layers) {
      document.layers[layerName].visibility = "hidden";
    } else if (document.all) {
      document.all[layerName].style.visibility = "hidden";
    }
  }
}

// Timer for button mouse out
function btnTimer() {
  timeOn = setTimeout("btnOut()", 400);
}

// Button mouse out
function btnOut(layerName) {
	if (menuActive == 0) {
		hideLayer(onLayer);
		hideLayer(onLayer);
	}
}

// Menu mouse over
function menuOver(itemName) {
	clearTimeout(timeOn);
	 menuActive = 1;
}

// Menu mouse out
function menuOut(itemName) {
	menuActive = 0;
	timeOn = setTimeout("hideLayer(onLayer)", 1000);
}



function demoView(pageURL) {
	newWindow = window.open(pageURL, "Demo" ,"statusbar=no,menubar=no,location=no,scrollbars=no,toolbar=no,directories=no,resizable=yes,width=800,height=600")
newWindow.focus()
}

function demoViewTwo(pageURL) {
	newWindow = window.open(pageURL, "Demo" ,"statusbar=no,menubar=yes,location=no,scrollbars=yes,toolbar=no,directories=no,resizable=yes,width=800,height=600")
newWindow.focus()
}

function openImage(theURL, winName, features) {
	window.open(theURL, winName, features);
}

//below code cameron

function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}

//expand collapse


function showMoreAnything(blocknum, isOpen) {
hid = ('hide' + (blocknum));
unhid = ('click' + (blocknum));
if( document.getElementById ) {
if( document.getElementById(hid).style.display ) {
if( isOpen != 0 ) {
document.getElementById(hid).style.display = "block";
document.getElementById(unhid).style.display = "none";
} else { 
document.getElementById(hid).style.display = "none";
document.getElementById(unhid).style.display = "block"; 
}
} else { 
location.href = isOpen;
return true; 
}
} else { 
location.href = isOpen;
return true; 
}
}




