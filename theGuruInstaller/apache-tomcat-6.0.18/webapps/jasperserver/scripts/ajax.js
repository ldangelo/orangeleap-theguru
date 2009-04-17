/*
 * Copyright (C) 2005 - 2007 JasperSoft Corporation. All rights reserved.
 * http://www.jaspersoft.com.
 * Licensed under commercial JasperSoft Subscription License Agreement
 */

/**
 *  @author Angus Croll
 *  Generic Ajax Utils
 */

/**
 *  @class Manages incoming Ajax requests and processes corresponding Ajax responses
 *  based on specified attributes.
 *  Responses are bound to to the instance of AjaxRequester created by the corresponing request
 *
 *  @constructor
 *  @param {String} url address for server request
 *  @param {Array} params [1]fillLocation [2]fromLocation [3]Array of callbacks
 *  @param {String} postData user data for posting - where applicable
 *  @return a new AjaxRequester instance
 *  @type AjaxRequester
 */
function AjaxRequester(url, params, postData) {
    this.url = url;
    this.params = params;
    this.xmlhttp = getXMLHTTP();
    var rsChangeFunction = this.processResponse(this);
    this.xmlhttp.onreadystatechange = rsChangeFunction;
    this.errorHandler = defaultErrorHandler;
    this.postData = postData;
}

/**
 * url address for server request
 * @type String
 */
AjaxRequester.prototype.url=null;

/**
 * [1]fillLocation [2]fromLocation [3]Array of callbacks
 * @type Array
 */
AjaxRequester.prototype.params=null;

/**
 * user data for posting - where applicable
 * @type String
 */
AjaxRequester.prototype.postData=null;

/**
 * the xmlhttp instance used by the requester
 * @type Object
 */
AjaxRequester.prototype.xmlhttp=null;

/**
 * a function to evaluate to trap errors
 * @type function
 */
AjaxRequester.prototype.errorHandler=null;


/**
 * Submit an ajax get request
 * @private
 * @return true if successful
 * @type boolean
 */
AjaxRequester.prototype.doGet = function() {
    if (this.xmlhttp) {
        this.xmlhttp.open("GET",this.url,true);
        this.xmlhttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
                this.xmlhttp.setRequestHeader( "If-Modified-Since", "Sat, 1 Jan 2000 00:00:00 GMT" );
        this.xmlhttp.send(null);
        return true;
    }
    return false;
}

/**
 * Submit an ajax post request
 * @private
 * @return true if successful
 * @type boolean
 */
AjaxRequester.prototype.doPost = function() {
    if (this.xmlhttp) {
        this.xmlhttp.open("POST",this.url,true);
        this.xmlhttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
        this.xmlhttp.send(this.postData);
        return true;
    }
    return false;
}

/**
 * Function to process the detected Ajax response
 * @param {AjaxRequester} the instance who's request we are processing
 * @private
 * @return the handler function
 * @type function
 */
AjaxRequester.prototype.processResponse = function(requester) {
    return (function() {
    if (requester.xmlhttp.readyState==4) {
        handleResponse(requester, requester.params);
        }
    });
}


/**
 * Set error handler for this requester
 * @param {function} the error handler function
 * @private
 */
AjaxRequester.prototype.setErrorHandler = function(errorHandler) {
    this.errorHandler = errorHandler;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
// AjaxRequester: End
///////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
// Global Space: Start
///////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
// Response Handling
///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Delegate to handler for ajax response
 * @param {AjaxRequester} the active requester instance
 * @param {Array} parameters bundled with the request
 * @private
 */
function handleResponse(requester, params) {
    try {
        if (checkForErrors(requester))
            return;
        requester.responseHandler(requester, params);
    } finally {
        //reset waiting cursor
        if (requester.responseHandler != doNothing)
            ajaxRequestEnded();
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// Response Handler Functions
///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Default handler for responses triggered by targetted ajax requests
 * @private
 * @param {AjaxRequester} requester the active requester instance
 * @param {Array} params parameters bundled with the request
 */
function targettedResponseHandler(requester, params) {
    var xmlhttp = requester.xmlhttp;

    //sanity check
    if (!xmlhttp.responseText) {
        window.status="server retrieval failed";
        return;
    }

    var fillLocation = params[0];
    var fromLocation = params[1];
    var postFillAction = params[2];
    var toLoc = document.getElementById(fillLocation);

    toLoc.innerHTML="";
    if (fromLocation) {
        //we only want part ofthe retrieved content so isolate it
        var fromSource = document.createElement("DIV");
        fromSource.id="temp";

        fromSource.innerHTML=xmlhttp.responseText;

        document.body.insertBefore(fromSource, document.body.firstChild);

        fromSource.style.display='none';
        var fromLoc = document.getElementById(fromLocation);

        document.body.removeChild(fromSource);

        if (toLoc.tagName=="TABLE") {
            copyTable(fromLoc,toLoc);
        } else {
            toLoc.appendChild(fromLoc);
        }

    } else {
        //we want all the retrieved content - throw it all in
        toLoc.innerHTML = xmlhttp.responseText;
    }
    if (postFillAction) {
        if (typeof(postFillAction) == 'string') {
            eval(postFillAction);
        } else {
            postFillAction();
        }
    }
}

/**
 * Special handler for when we want to overwrite entire page with response
 * @param {AjaxRequester} the active requester instance
 * @param {Array} parameters bundled with the request
 * @private
 */
var clobberingResponseHandler = function(requester, params) {
    document.body.innerHTML = requester.xmlhttp.responseText;
}



/////////////////////////////////////////////////////////////////////////////////////////
// Public API starts Here....
// Please do not amend exisiting signatures but feel free to extend the API as required
/////////////////////////////////////////////////////////////////////////////////////////

/**
 * Send an ajax request with this URL and update the entire page with the response
 * @param {String} url of the request
 */
function ajaxClobberredUpdate(url) {
    ajaxUpdate(url,clobberingResponseHandler);
}

/**
 * Send an ajax request with this URL and update the targetContainer  with the sourceContainer container of the response DOM
 * Optionally execute the post fill action as a callback following response processing
 * @param {String} url the url of the request
 * @param {String} targetContainer id indicating where to dump html response
 * @param {String} sourceContainer id indicating which part of the html response to use
 * @param {Array} postFillAction JS functions to evaluate after ajax update
 * @param {function} errorHandler a function to evaluate to trap errors
 * @param {String} postData user data for posting - where applicable
 */
function ajaxTargettedUpdate(url,targetContainer,sourceContainer,postFillAction,errorHandler,postData) {
    ajaxUpdate(url,targettedResponseHandler,targetContainer,sourceContainer,postFillAction,errorHandler,postData);
}

/**
 * Send an ajax request with this URL but don't return any content to the sender
 * Optionally execute the post fill action as a callback following response processing
 * @param {String} url the url of the request
 * @param {String} targetContainer id indicating where to dump html response
 * @param {String} sourceContainer id indicating which part of the html response to use
 * @param {Array} postFillAction JS functions to evaluate after ajax update
 * @param {function} errorHandler a function to evaluate to trap errors
 * @param {String} postData user data for posting - where applicable
 */
function ajaxNonReturningUpdate(url,targetContainer,sourceContainer,postFillAction,errorHandler,postData) {
    ajaxUpdate(url,null, targetContainer,sourceContainer,postFillAction,errorHandler,postData);
}

/**
 * Submit the form and replace entire page
 * @param {String} form name of the form
 * @param {String} url the url of the request
 * @param {String} extraPostData form data for posting
 * @param {String} targetContainer id indicating where to dump html response
 * @param {String} sourceContainer id indicating which part of the html response to use
 * @param {Array} postFillAction JS functions to evaluate after ajax update
 * @param {function} errorHandler a function to evaluate to trap errors
 */
function ajaxClobberedFormSubmit(form, url, extraPostData, targetContainer, sourceContainer, postFillAction, errorHandler)
{
  var postData = getPostData(form, extraPostData);
  postData = appendPostData(postData, extraPostData);
    ajaxUpdate(url, clobberingResponseHandler, targetContainer, sourceContainer, postFillAction, errorHandler, postData);
}

/**
 * Submit the form and update the targetContainer  with the sourceContainer container of the response DOM
 * @param {String} form name of the form
 * @param {String} url the url of the request
 * @param {String} extraPostData form data for posting
 * @param {String} targetContainer id indicating where to dump html response
 * @param {String} sourceContainer id indicating which part of the html response to use
 * @param {Array} postFillAction JS functions to evaluate after ajax update
 * @param {function} errorHandler a function to evaluate to trap errors
 */
function ajaxTargettedFormSubmit(form, url, extraPostData, targetContainer, sourceContainer, postFillAction, errorHandler)
{
  var postData = getPostData(form, extraPostData);
  postData = appendPostData(postData, extraPostData);
    ajaxUpdate(url, targettedResponseHandler, targetContainer, sourceContainer, postFillAction, errorHandler, postData);
}

////////////////////////////////////////////////////////////////////////////////
// ...Public API ends Here....
////////////////////////////////////////////////////////////////////////////////

/**
 * @private
 */
//dummy response handler for non returning case
function doNothing() {
}

/**
 * Wrapper for AjaxRequester
 * @private
 * @param {String} url the url of the request
 * @param {function} responseHandler the designated response handler
 * @param {String} fillLocation id indicating where in the DOM to dump ajax response
 * @param {String} fromLocation id indicating which part of the ajax response to use
 * @param {Array} postFillAction JS functions to evaluate after ajax update
 * @param {function} errorHandler the designated error handler
 * @param {String} postData user data for posting - where applicable
 */
function ajaxUpdate(url,responseHandler,fillLocation,fromLocation,postFillAction,errorHandler,postData) {
  if (!responseHandler) {
    responseHandler = doNothing; //non returning request
  }
  if (responseHandler != doNothing) {
    ajaxRequestStarted();
  }
  var requester = new AjaxRequester(url, [fillLocation,fromLocation,postFillAction], postData);
  requester.responseHandler = responseHandler;
  if (errorHandler) {
    requester.errorHandler = errorHandler;
  }
  if (requester.xmlhttp) {
    if (postData) {
      requester.doPost();
    } else {
      requester.doGet();
    }
  }
}

/**
 * @private
 */
function checkForErrors(requester) {
    var errorHandler = requester.errorHandler;
    return errorHandler(requester.xmlhttp);
}

/**
 * @private
 */
var defaultErrorHandler = function() {
    return false;
}

/**
 * @private
 */
function getPostData(form, extraPostData)
{
  if (typeof form == 'string')
  {
    form = document.forms[form];
  }

  var data = "";
  for (var i = 0; i < form.elements.length; ++i)
  {
  	var element = form.elements[i];
  	if (element.name && !(extraPostData && extraPostData[element.name]))
  	{
	  data = appendFormInput(data, element);
  	}
  }

  return data;
}

/**
 * @private
 */
function appendPostData(postData, extraPostData)
{
  for (name in extraPostData)
  {
    postData = appendFormValue(postData, name, extraPostData[name]);
  }
  return postData;
}

/**
 * @private
 */
function appendFormInput(data, element)
{
  if (element.name)
  {
    var value;
    var append = false;
    switch (element.type)
    {
      case "checkbox":
      case "radio":
        append = element.checked;
        value = element.value;
        break;
      case "hidden":
      case "password":
      case "text":
      case "Textarea":
        append = true;
        value = element.value;
        break;
      case "select-one":
      case "select-multiple":
        value = new Array();
        for (var i = 0; i < element.options.length; ++i)
        {
          var option = element.options[i];
          if (option.selected)
          {
            append = true;
            value.push(option.value);
          }
        }
        break;
    }

    if (append)
    {
      if (value.pop)
      {
        while (value.length > 0)
        {
          data = appendFormValue(data, element.name, value.pop());
        }
      }
      else
      {
        data = appendFormValue(data, element.name, value);
      }
    }
  }

  return data;
}

/**
 * @private
 */
function appendFormValue(data, name, value)
{
  if (data.length > 0)
  {
    data += "&";
  }
  data += name + "=" + encodeURIComponent(value);
  return data;
}

/**
 * @private
 */
function baseErrorHandler(ajaxAgent)
{
  var sessionTimeout = ajaxAgent.getResponseHeader("LoginRequested");
  if (sessionTimeout)
  {
        var newloc ='.';
        document.location = newloc;
        return true;
    }

    var isErrorPage = ajaxAgent.getResponseHeader("JasperServerError");
    if (isErrorPage)
    {
      showErrorPopup(ajaxAgent);
      return true;
    }

    return false;
}

var ERROR_POPUP_DIV = "jsErrorPopup";
var ERROR_POPUP_CONTENTS = "errorPopupContents";
var ERROR_POPUP_BACK_BUTTON = "errorBack";
var ERROR_POPUP_CLOSE_BUTTON = "errorPopupCloseButton";

/**
 * @private
 */
function showErrorPopup(ajaxAgent)
{
  var errorPopupContents = document.getElementById(ERROR_POPUP_CONTENTS);
  errorPopupContents.innerHTML = ajaxAgent.responseText;

  var backButton = document.getElementById(ERROR_POPUP_BACK_BUTTON);
  if (backButton)
  {
    backButton.style.visibility = "hidden";
  }

  var errorPopup = document.getElementById(ERROR_POPUP_DIV);
  errorPopup.style.display = "block";
  centerLayer(errorPopup);
  pushOverlayObject("mainTable", "haze", 98);
  focusOn(ERROR_POPUP_CLOSE_BUTTON);
}

/**
 * @private
 */
function hideErrorPopup()
{
  popOverlayObject();
  var errorPopup = document.getElementById(ERROR_POPUP_DIV);
  errorPopup.style.display = "none";
}

/**
 * @private
 */
////////////////////////////////////////////////////////////////////////////////
// XMLHTTP
////////////////////////////////////////////////////////////////////////////////
//
// standard function to obtain an xmlhttp instance regardless of platform
//
function getXMLHTTP() {
    var alerted;
    var xmlhttp;
    /*@cc_on @*/
    /*@if (@_jscript_version >= 5)
    // JScript gives us Conditional compilation, we can cope with old IE versions.
      try {
      xmlhttp=new ActiveXObject("Msxml2.XMLHTTP")
    } catch (e) {
        try {
            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP")
        } catch (E) {
            alert("You must have Microsofts XML parsers available")
        }
    }
    @else
        alert("You must have JScript version 5 or above.")
        xmlhttp=false
        alerted=true
    @end @*/
    if (!xmlhttp && !alerted) {
    // Non ECMAScript Ed. 3 will error here (IE<5 ok), nothing I can
    // realistically do about it, blame the w3c or ECMA for not
    // having a working versioning capability in  <SCRIPT> or
    // ECMAScript.
        try {
            xmlhttp = new XMLHttpRequest();
        } catch (e) {
            alert("You need a browser which supports an XMLHttpRequest Object.\nMozilla build 0.9.5 has this Object and IE5 and above, others may do, I don't know, any info jim@jibbering.com")
        }
    }
    return xmlhttp
}

var ajaxRequestCount = 0;

/**
 * @private
 */
function ajaxRequestStarted()
{
    ++ajaxRequestCount;
    document.body.style.cursor = "wait";
}

/**
 * @private
 */
 function ajaxRequestEnded()
{
    if (ajaxRequestCount <= 1)
    {
        document.body.style.cursor = "default";
        ajaxRequestCount = 0;
    }
    else
    {
        --ajaxRequestCount;
    }
}

