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

function isMozilla() {
  return navigator.appName=="Netscape";
}

function isIE() {
  return navigator.appName=="Microsoft Internet Explorer";
}

function isIEVersion7Upwards() {
    if (isIE()) {
        var version = navigator.appVersion.split("MSIE");
        var version = parseFloat(version[1]);
        return version >= 7;
    }
    return false;
}

//
// deprecated - use getBoxOffsets() below
//
function getAbsoluteOffsets(thisObj) {
    var oLeft = thisObj.offsetLeft;
    var oTop = thisObj.offsetTop;
    var thisParent = thisObj.offsetParent;
    while (thisParent.tagName.toUpperCase() != "BODY" && thisParent.style.position != "absolute") {
        var oLeft = oLeft + thisParent.offsetLeft;
        var oTop = oTop + thisParent.offsetTop;
        thisParent = thisParent.offsetParent;
    }
    //add co-ords of absolute parent
    if (thisParent.style.position == "absolute") {
      oLeft = oLeft + thisParent.offsetLeft;
      oTop = oTop + thisParent.offsetTop;
    }
		if (isIE()) {
			//minor adjustment because IE handles offset slightly differently;
			//oLeft=oLeft+1;
			oTop=oTop+1;
		}
    return new Array(oLeft,oTop, oLeft + thisObj.offsetWidth, oTop + thisObj.offsetHeight);
}

//
// reimplemenation of above function
// but leaving original for now in case results vary slightly
//
function getBoxOffsets(thisObj) {
    if (document.getBoxObjectFor) {
       var box = document.getBoxObjectFor(thisObj);
       posLeft = box.x;
       posTop = box.y;
    }
    else if (thisObj.getBoundingClientRect) {
       var box = thisObj.getBoundingClientRect();
       posLeft = box.left;
       posTop = box.top;
    }
    return new Array(posLeft,posTop);
}


function getAbsoluteTopOffset(thisObj) {
    var oTop = thisObj.offsetTop;
    var thisParent = thisObj.offsetParent;
    while (thisParent.tagName.toUpperCase() != "BODY" && thisParent.style.position != "absolute") {
        var oTop = oTop + thisParent.offsetTop;
        thisParent = thisParent.offsetParent;
    }
    //add co-ords of absolute parent
    if (thisParent.style.position == "absolute") {
      oTop = oTop + thisParent.offsetTop;
    }
    if (isIE()) {
      //minor adjustment because IE handles offset slightly differently;
      oTop=oTop+1;
    }
    return oTop;
}

function getCell(clicked) {
	return getParentWithTagName(clicked,"TD");
}

function getParentDiv(clicked) {
	return getParentWithTagName(clicked,"DIV");
}

function getParentRow(clicked) {
	return getParentWithTagName(clicked,"TR");
}

function getParentTable(clicked) {
    return getParentWithTagName(clicked,"TABLE");
}

function getParentWithTagName(myElement,aTagName) {
	while(myElement.tagName!=aTagName) {
		myElement=myElement.parentNode;
		if(myElement.tagName=="BODY")
			return null;
	}
	return myElement;
}

function getElementWithIdAndTagAndParent(id,tagName,parentElem) {
  var elems = parentElem.getElementsByTagName(tagName);
  for (var i=0; i<elems.length; i++) {
    if (elems[i].getAttribute("id")==id)
      return elems[i];
  }
  return null;
}

function isDescendantOf(child, parent) {
	while(child.tagName != "BODY") {
		if (child==parent) {
			return true;
		}
		child = child.parentNode;
	}
	return false;
}

function getCellIndex(cell) {
	return cell.cellIndex;
}

function getRowIndex(row) {
	return row.rowIndex;
}

function isPointOverlayingObject(x,y,obj) {
	var offsets = getAbsoluteOffsets(obj);
	//window.status = offsets[0]+'-'+x+'-'+offsets[2]+'-'+offsets[1]+'-'+y+'-'+offsets[3];
	return x>offsets[0]&&x<offsets[2]&&y>offsets[1]&&y<offsets[3];
}


// Note assumes obj display is NOT none
function centerLayer(obj) {
  obj.style.left=((getWindowWidth()-parseInt(obj.clientWidth))/2)+getScrollLeft();
  obj.style.top=((getWindowHeight()-parseInt(obj.clientHeight))/2)+getScrollTop();
}

function getWindowWidth() {
	if (isMozilla())
		return innerWidth;
  return document.body.clientWidth;
}

function getWindowHeight() {
  if (isMozilla())
		return innerHeight;
  return document.body.clientHeight;
}

function scrollXToMiddle(theBody) {
  //scroll to half the difference between page width and window width (if any)
  var excess = theBody.scrollWidth-getWindowWidth();
  if (excess>0)
    theBody.scrollLeft=excess/2;
}

function getScrollLeft() {
    if (isMozilla()) {
        return window.scrollX;
    }
    return document.body.scrollLeft;
}

function getScrollTop() {
    if (isMozilla()) {
        return window.scrollY;
    }
	return document.body.scrollTop;
}

//left, top, width, height are optional overrides
function fitObjectIntoScreen(obj, thisLeft, thisTop, thisWidth, thisHeight) {
    var l = thisLeft ? parseInt(thisLeft) : parseInt(obj.style.left);
    var t = thisTop ? parseInt(thisTop) : parseInt(obj.style.top);
    var w = thisWidth ? parseInt(thisWidth) : parseInt(obj.style.width);
    var h = thisHeight ? parseInt(thisHeight) : parseInt(obj.style.height);
	var sl = getScrollLeft();
	var st = getScrollTop();
	var sw = getWindowWidth();
	var sh = getWindowHeight();

    //scrollbar adjustment
    w = w + 20;
    h = h + 20;

	if (t + h > st + sh) t = st + sh - h;
	if (t < st) t = st;
	if (l + w > sl + sw) l = sl + sw - w;
	if (l < sl) l = sl;

	obj.style.left = l + "px";
	obj.style.top = t + "px";
}

//haze out the entire usable page
function renderHazeLayer(left,top) {
  var theBody = document.body;
  return renderOverlay(left,top,theBody.scrollWidth,theBody.scrollHeight,'haze')
}

function renderImageOverCursor(imgId, event) {
	var img = document.getElementById(imgId);
	img.style.display="block";
	img.style.left=event.clientX;
	img.style.top=event.clientY;
}

function hideImageOverCursor(imgId) {
	var img = document.getElementById(imgId);
	img.style.display="none";
}


function renderOverlay(left,top,width,height,style) {
	var overlayObject = document.createElement("DIV");
	overlayObject.className=style;
	overlayObject.style.position="absolute";
	//overlayObject.style.zIndex=80;
	overlayObject.style.left=left;
	overlayObject.style.top=top;
	overlayObject.style.width=width;
	overlayObject.style.height=height;
	document.body.appendChild(overlayObject);

	return overlayObject;
}

function removeOverlay(overlayObject) {
	if (overlayObject && overlayObject.parentNode) {
        overlayObject.parentNode.removeChild(overlayObject);
	}
    if (overlayObject) {
        overlayObject = null;
	}
}

function getEvent(e) {
  return (e != null) ? e : window.event;
}

function enterKeyHit(evt) {
		var charCode = whichKeyHit(evt)
    if (charCode == 13 || charCode == 3)
        return true;
    return false;
}

function whichKeyHit(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.charCode) ? evt.charCode :
        ((evt.which) ? evt.which : evt.keyCode);
		return charCode;
}

function isCtrlHeld(e) {
    return !!(e ? e.ctrlKey:event.ctrlKey);
}

function toggleDisplay(elem) {
	if (elem.style.display=="none")
		elem.style.display="block";
	else
		elem.style.display="none";
}

function cancelEventBubbling(e)
{
	var e = e?e:event;
	e.cancelBubble = true;
	if (e.stopPropagation) e.stopPropagation();
}

function focusOn(id) {
	document.getElementById(id).focus();
}

function trim(thisStr) {
 // skip leading and trailing whitespace
 // and return everything in between
  thisStr=thisStr.replace(/^\s*(.*)/, "$1");
  thisStr=thisStr.replace(/(.*?)\s*$/, "$1");
  return thisStr;
}

function getCellAtColumn(cells,columnIndex) {
  columnCount = 0;
  for (i=0;i<cells.length;i++) {
    columnCount += cells.colspan;
    if (columnCount>=columnIndex)
      return cells[i];
  }
  return null;
}

// columnIndex indicates which column (within the supplied rows) we are interested in
function getCellAtRow(rows,columnIndex,rowIndex) {
  rowCount = 0;
  for (i=0;i<rows.length;i++) {
    var thisCell = rows[i].cells[columnIndex];
    rowCount += thisCell.rowspan;
    if (rowCount>=rowIndex)
      thisCell;
  }
  return null;
}

//fromT and toT can be TABLE or TBODY
function copyTable(fromT,toT,paramsAreTBody) {
    var toBody=paramsAreTBody?toT:toT.firstChild;
    var copyRows = fromT.rows;
    clearTable(toT);
    for (i=0;i<copyRows.length;i++) {
        var copiedRow = copyRows[i].cloneNode(true)
        if (document.all) {
            toBody.insertBefore(copiedRow,null);
        } else {
            toT.appendChild(copiedRow);
        }
    }
}

function clearTable(myTable) {
    if (document.all) {
        while(myTable.rows[0]) {
          myTable.deleteRow(0);
        }
    } else {
        myTable.innerHTML = "";
    }
}

function startsWith(string1,string2) {
  return string1.indexOf(string2)==0;
}


function getTextAfterUnderscore(theText) {
  return getTextAfterSubstring(theText,'_')
}

function getTextBeforeUnderscore(theText) {
  return getTextBeforeSubstring(theText,'_')
}

function getTextAfterSubstring(theText,theSubstring) {
  var ssIndex = (theText.toLowerCase()).indexOf(theSubstring.toLowerCase());
  if (ssIndex==-1)
    return null;
  else
    return theText.substring(ssIndex+theSubstring.length);
}

function getTextBeforeSubstring(theText,theSubstring) {
  var ssIndex = (theText.toLowerCase()).indexOf(theSubstring.toLowerCase());
  if (ssIndex==-1)
    return theText;
  else
    return theText.substring(0,ssIndex);
}

//used to smother an event
function popEvent(e) {
    cancelEventBubbling(e?e:event);
}

function removeTrailingSlash(theString) {
    var lastChar = theString.substring(theString.length-1);
    if (lastChar == '/') {
        return theString.substring(0,theString.length-1);
    } else {
        return theString;
    }
}

function removeChars(theString, charArray) {
    var i=0;
    for (i;i<charArray.length;i++) {
        while (theString.indexOf(charArray[i])>-1) {
            theString = theString.replace(charArray[i],"");
        }
    }
    return theString;
}

//
// replaces all instances of str1 in str with str2
// note: assumes str2 does not contain str1!
//
function replaceAll(str,str1,str2) {
    while (str.indexOf(str1)>-1) {
        str = str.replace(str1,str2);
    }
    return str;
}

function fadeInOrOut(id, opacStart, opacEnd, millisecDelay) {
    //speed for each frame
    var speed = Math.round(millisecDelay / 100);
    var timer = 0;

    //determine the direction for the blending, if start and end are the same nothing happens
    if(opacStart > opacEnd) {
        for(i = opacStart; i >= opacEnd; i--) {
            setTimeout("changeOpac(" + i + ",'" + id + "')",(timer * speed));
            timer++;
        }
    } else if(opacStart < opacEnd) {
        for(i = opacStart; i <= opacEnd; i++)
            {
            setTimeout("changeOpac(" + i + ",'" + id + "')",(timer * speed));
            timer++;
        }
    }
}

//change the opacity for different browsers
function changeOpac(opacity, id) {
    var object = document.getElementById(id).style;
    object.opacity = (opacity / 100);
    object.MozOpacity = (opacity / 100);
    object.KhtmlOpacity = (opacity / 100);
    object.filter = "alpha(opacity=" + opacity + ")";
}

function launchNewWindow(url) {
    window.open(url);
}

function getIFrameDocument(iFrame) {
    var doc = iFrame.contentWindow || iFrame.contentDocument;
    if (doc.document) {
        doc = doc.document;
    }
    return doc;
}

function boxesOverlap(leftA, topA, rightA, bottomA,leftB, topB, rightB, bottomB) {
    return !((topA>bottomB) || (bottomA<topB) || (leftA>rightB) || (rightA<leftB));
}

/**
 * if no protocol specified assume http://
 */
function checkURLProtocol(urlString, enforcePrefix) {
    if (!enforcePrefix) {
        return urlString;
    }
    if (startsWith(urlString,"/")) {
        //relative URL
        return urlString.substring(1);
    }

    var commonProtocols = new Array("http://","file://","mailto://","ftp://");
    for (var i in commonProtocols) {
        if (startsWith(urlString,commonProtocols[i])) {
            return urlString;
        }
    }
    //no protocol specified so assume http://
    return commonProtocols[0] + urlString;
}

/**
 * do we use a '?'or an '&' or nothing?
 */
function getSymbolToAppendNextParam(urlSoFar) {
    var lastChar = urlSoFar.substring(urlSoFar.length-1)
    if ((lastChar == '?')||(lastChar == '&')) {
        return "";
    }
    if (urlSoFar.indexOf('?')>-1) {
        return "&";
    } else {
        return "?";
    }

}


//
// blinking things is an array
//
function simpleBlink(blinkingThings, blinkTime, numberOfBlinks) {

    for (index in blinkingThings) {
        var blinkingThing = blinkingThings[index];
        blinkingThing.style.display = "none";
    }

    var count = 0;

    function toggleBlink() {
        var firstBlinkingThing = blinkingThings[0];
        if (firstBlinkingThing.style.display == "none") {
            for (index in blinkingThings) {
                var blinkingThing = blinkingThings[index];
                blinkingThing.style.display = "block";
            }
        } else {
            for (index in blinkingThings) {
                var blinkingThing = blinkingThings[index];
                blinkingThing.style.display = "none";
            }
            count++;
        }
        if (count>numberOfBlinks) {
            clearInterval(blinker);
            for (index in blinkingThings) {
                var blinkingThing = blinkingThings[index];
                blinkingThing.style.display = "block";
            }
        }
    }

    var blinker = window.setInterval(toggleBlink,blinkTime);

}

//
// blinking things is an array
//
function blinkWithClasses(blinkingThings, oldClassName, blinkClassName, finalClassName, blinkTime, numberOfBlinks) {

    for (index in blinkingThings) {
        var blinkingThing = blinkingThings[index];
        blinkingThing.className = oldClassName;
    }

    var count = 0;

    function toggleBlink() {
        var firstBlinkingThing = blinkingThings[0];
        if (firstBlinkingThing.className == oldClassName) {
            for (index in blinkingThings) {
                var blinkingThing = blinkingThings[index];
                blinkingThing.className = blinkClassName;
            }
        } else {
            for (index in blinkingThings) {
                var blinkingThing = blinkingThings[index];
                blinkingThing.className = oldClassName;
            }
            count++;
        }
        if (count>numberOfBlinks) {
            clearInterval(blinker);
            for (index in blinkingThings) {
                var blinkingThing = blinkingThings[index];
                blinkingThing.className = finalClassName
            }
        }
    }

    var blinker = window.setInterval(toggleBlink,blinkTime);

}

/////////////////////////////////////////////////////////////////////////////////////
// monitors for run requests, and only invokes function after specified quiet time
/////////////////////////////////////////////////////////////////////////////////////

function BusyMonitor(waitTime,theFunction) {
    this.waitTime = waitTime;
    this.theFunction = theFunction;
    this.timer = null;
}

BusyMonitor.prototype.run = function() {
    if (this.timer != null) {
        //recent activity - so start a new timeout
        clearTimeout(this.timer);
    }
    this.timer = setTimeout(this.theFunction,this.waitTime);
}

function doNothing() {
    //what it says
}

////////////////////////////////////////
// next two methods are reciprocal...
////////////////////////////////////////
var inputElementTemplate;
var labelElementTemplate;
var editingLabel;

function switchLabelToInput(parentCell,onBlurFunction,onKeyDownFunction) {
	if (!inputElementTemplate)
		inputElementTemplate = document.createElement("INPUT");
	var thisInput = inputElementTemplate.cloneNode(false);
	thisInput.type="text";
	thisInput.value=parentCell.textContent?parentCell.textContent:parentCell.innerText;
	if(thisInput.value=='undefined')
		thisInput.value='';
  thisInput.tabIndex=1;
  thisInput.onmouseup=popEvent;
	thisInput.onblur=onBlurFunction;
	thisInput.onkeydown=onKeyDownFunction;
	thisInput.style.width=Math.max(parentCell.offsetWidth,50);
	parentCell.innerHTML='';
	parentCell.appendChild(thisInput);
	thisInput.focus();
	thisInput.select();
	thisInput.setAttribute('id','editingLabel');
	editingLabel = 'editingLabel';
}

//assumes input was created by switchLabelToInput() above
function returnInputToLabel(parentCell) {
	var thisInputElem = parentCell.firstChild;
	thisInputElem.onblur=doNothing;
	var inputValue = thisInputElem.value?thisInputElem.value:'';
	parentCell.innerHTML=inputValue;
	editingLabel = false;
}

//////////////////////////
// Prevent Selection on element
//////////////////////////
function disableSelection(target){
  if (typeof target.onselectstart!="undefined") //IE route
    target.onselectstart=function(){return false}
  else if (typeof target.style.MozUserSelect!="undefined") //Firefox route
    target.style.MozUserSelect="none"
  else //All other route (ie: Opera)
    ;//target.onmousedown=function(){return false}
  target.style.cursor = "default"
}


function disableSelectionWithoutCursorStyle(target){
  if (typeof target.onselectstart!="undefined") //IE route
    target.onselectstart=function(){return false}
  else if (typeof target.style.MozUserSelect!="undefined") //Firefox route
    target.style.MozUserSelect="none"
  else //All other route (ie: Opera)
    ;//target.onmousedown=function(){return false}
}


function enableSelection(target){
  if (typeof target.onselectstart!="undefined") //IE route
    target.onselectstart=function(){return true}
  else if (typeof target.style.MozUserSelect!="undefined") //Firefox route
    target.style.MozUserSelect="all"
  else //All other route (ie: Opera)
    ;//target.onmousedown=function(){return false}
  target.style.cursor = "default"
}

/////////////////////////////
// Ajax related
/////////////////////////////

function recognizeScripts(containerObj) {
  var scripts = containerObj.getElementsByTagName('SCRIPT');
  if (scripts != null) {
    for (var i = 0; i < scripts.length; i++) {
      var script = scripts[i];
      window.eval(script.text);
    }
  }
}


////////////////////////////
// Mouse event handlers
////////////////////////////

var movingObj = null;
var dialogX = -1;
var dialogY = -1;

function findContainerDiv(child) {
  while (!child.style || child.style.position != 'absolute') {
    child = child.parentNode;
    if (child == null) return null;
  }
  return child;
}

function dialogOnMouseDown(event) {
  var e = (event != null) ? event : window.event;
  if (e.button == (window.event != null) ? 1 : 0) {
    dialogX = e.clientX;
    dialogY = e.clientY;
    document.onmousemove = dialogDocOnMouseMove;
    document.onmouseup = dialogDocOnMouseUp;
  }
  movingObj = findContainerDiv( window.event ? event.srcElement: e.target );
}

function dialogDocOnMouseMove(event) {
  if (movingObj) {
    var e = (event != null) ? event : window.event;
    var x = e.clientX;
    var y = e.clientY;
    if (dialogX >= 0 && dialogY >= 0) {
      var dx = x - dialogX;
      var dy = y - dialogY;
      var l = dx + parseInt(movingObj.style.left);
      var t = dy + parseInt(movingObj.style.top);
      movingObj.style.left = l + "px";
      movingObj.style.top = t + "px";
    }
    dialogX = x;
    dialogY = y;
  }
}

function dialogDocOnMouseUp(event) {
  movingObj = null;
  dialogX = -1;
  dialogY = -1;
  document.onmousemove = null;
  document.onmouseup = null;
  document.onmouseout = null;
}

function animatedMove(movingThing, fromX, fromY, toX, toY, stepSize) {
    var xOffset = Math.abs(toX-fromX);
    var yOffset = Math.abs(toY-fromY);
    var biggerOffset = Math.max(xOffset,yOffset);

    //if no step size then auto size it so there are 20 steps
    if (!stepSize) {
        stepSize = biggerOffset/20;
    }

    var increments = biggerOffset/stepSize;
    var count=0;

    if ((fromX==toX)&&(fromY==toY)) {
        //nothing to do
        return;
    }

    var xStep = xOffset/increments;
    var yStep = yOffset/increments;

    function moveIt() {
        if (count<increments) {
            count++;
            movingThing.style.left = parseInt(movingThing.style.left) + xStep;
            movingThing.style.top = parseInt(movingThing.style.top) + yStep;
            setTimeout(moveIt,0);
        } else {
            //finish off
            movingThing.style.left = toX;
            movingThing.style.top = toY;
        }
    }

    moveIt();

}

//
// this one fires of a series of increments at fized intervals
// theoretecially this should iron out browser delays
//
function animatedMoveFixedTimer(movingThing, fromX, fromY, toX, toY, stepSize) {
    var xOffset = Math.abs(toX-fromX);
    var yOffset = Math.abs(toY-fromY);
    var biggerOffset = Math.max(xOffset,yOffset);

    //if no step size then auto size it so there are 20 steps
    if (!stepSize) {
        stepSize = biggerOffset/20;
    }

    var increments = biggerOffset/stepSize;
    var count=0;

    if ((fromX==toX)&&(fromY==toY)) {
        //nothing to do
        return;
    }

    var xStep = xOffset/increments;
    var yStep = yOffset/increments;


    function moveIt() {
        movingThing.style.left = parseInt(movingThing.style.left) + xStep;
        movingThing.style.top = parseInt(movingThing.style.top) + yStep;
    }

    for (count; count<increments; count++) {
        setTimeout(moveIt,10*count);
    }

    //finish off
    //movingThing.style.left = toX;
    //movingThing.style.top = toY;

}


///////////////////////////////
// Keyboard event related
///////////////////////////////

// Contains all key codes
Keys = new Object();

Keys.DOM_VK_BACK_SPACE = 8;
Keys.DOM_VK_ENTER = 13;
Keys.DOM_VK_PAGE_UP = 33;
Keys.DOM_VK_DOWN = 40;
Keys.DOM_VK_INSERT = 45;
Keys.DOM_VK_DELETE = 46;
Keys.DOM_VK_0 = 48;
Keys.DOM_VK_9 = 57;
Keys.DOM_VK_NUMPAD0 = 96;
Keys.DOM_VK_NUMPAD9 = 105;
Keys.DOM_VK_DECIMAL = 110;
Keys.DOM_VK_COMMA = 188;
Keys.DOM_VK_PERIOD = 190;
Keys.DOM_VK_CANCEL = 3;
Keys.DOM_VK_HELP = 6;
Keys.DOM_VK_TAB = 9;
Keys.DOM_VK_CLEAR = 12;
Keys.DOM_VK_RETURN = 13;
Keys.DOM_VK_SHIFT = 16;
Keys.DOM_VK_CONTROL = 17;
Keys.DOM_VK_ALT = 18;
Keys.DOM_VK_PAUSE = 19;
Keys.DOM_VK_CAPS_LOCK = 20;
Keys.DOM_VK_ESCAPE = 27;
Keys.DOM_VK_SPACE = 32;
Keys.DOM_VK_PAGE_DOWN = 34;
Keys.DOM_VK_END = 35;
Keys.DOM_VK_HOME = 36;
Keys.DOM_VK_LEFT = 37;
Keys.DOM_VK_UP = 38;
Keys.DOM_VK_RIGHT = 39;
Keys.DOM_VK_PRINTSCREEN = 44;
Keys.DOM_VK_1 = 49;
Keys.DOM_VK_2 = 50;
Keys.DOM_VK_3 = 51;
Keys.DOM_VK_4 = 52;
Keys.DOM_VK_5 = 53;
Keys.DOM_VK_6 = 54;
Keys.DOM_VK_7 = 55;
Keys.DOM_VK_8 = 56;
Keys.DOM_VK_SEMICOLON = 59;
Keys.DOM_VK_EQUALS = 61;
Keys.DOM_VK_A = 65;
Keys.DOM_VK_B = 66;
Keys.DOM_VK_C = 67;
Keys.DOM_VK_D = 68;
Keys.DOM_VK_E = 69;
Keys.DOM_VK_F = 70;
Keys.DOM_VK_G = 71;
Keys.DOM_VK_H = 72;
Keys.DOM_VK_I = 73;
Keys.DOM_VK_J = 74;
Keys.DOM_VK_K = 75;
Keys.DOM_VK_L = 76;
Keys.DOM_VK_M = 77;
Keys.DOM_VK_N = 78;
Keys.DOM_VK_O = 79;
Keys.DOM_VK_P = 80;
Keys.DOM_VK_Q = 81;
Keys.DOM_VK_R = 82;
Keys.DOM_VK_S = 83;
Keys.DOM_VK_T = 84;
Keys.DOM_VK_U = 85;
Keys.DOM_VK_V = 86;
Keys.DOM_VK_W = 87;
Keys.DOM_VK_X = 88;
Keys.DOM_VK_Y = 89;
Keys.DOM_VK_Z = 90;
Keys.DOM_VK_CONTEXT_MENU = 93;
Keys.DOM_VK_NUMPAD1 = 97;
Keys.DOM_VK_NUMPAD2 = 98;
Keys.DOM_VK_NUMPAD3 = 99;
Keys.DOM_VK_NUMPAD4 = 100;
Keys.DOM_VK_NUMPAD5 = 101;
Keys.DOM_VK_NUMPAD6 = 102;
Keys.DOM_VK_NUMPAD7 = 103;
Keys.DOM_VK_NUMPAD8 = 104;
Keys.DOM_VK_MULTIPLY = 106;
Keys.DOM_VK_ADD = 107;
Keys.DOM_VK_SEPARATOR = 108;
Keys.DOM_VK_SUBTRACT = 109;
Keys.DOM_VK_SUBTRACT_UNDERSCORE_IE = 189;
Keys.DOM_VK_DIVIDE = 111;
Keys.DOM_VK_F1 = 112;
Keys.DOM_VK_F2 = 113;
Keys.DOM_VK_F3 = 114;
Keys.DOM_VK_F4 = 115;
Keys.DOM_VK_F5 = 116;
Keys.DOM_VK_F6 = 117;
Keys.DOM_VK_F7 = 118;
Keys.DOM_VK_F8 = 119;
Keys.DOM_VK_F9 = 120;
Keys.DOM_VK_F10 = 121;
Keys.DOM_VK_F11 = 122;
Keys.DOM_VK_F12 = 123;
Keys.DOM_VK_F13 = 124;
Keys.DOM_VK_F14 = 125;
Keys.DOM_VK_F15 = 126;
Keys.DOM_VK_F16 = 127;
Keys.DOM_VK_F17 = 128;
Keys.DOM_VK_F18 = 129;
Keys.DOM_VK_F19 = 130;
Keys.DOM_VK_F20 = 131;
Keys.DOM_VK_F21 = 132;
Keys.DOM_VK_F22 = 133;
Keys.DOM_VK_F23 = 134;
Keys.DOM_VK_F24 = 135;
Keys.DOM_VK_NUM_LOCK = 144;
Keys.DOM_VK_SCROLL_LOCK = 145;
Keys.DOM_VK_SLASH = 191;
Keys.DOM_VK_BACK_QUOTE = 192;
Keys.DOM_VK_OPEN_BRACKET = 219;
Keys.DOM_VK_BACK_SLASH = 220;
Keys.DOM_VK_CLOSE_BRACKET = 221;
Keys.DOM_VK_QUOTE = 222;
Keys.DOM_VK_META = 224;
