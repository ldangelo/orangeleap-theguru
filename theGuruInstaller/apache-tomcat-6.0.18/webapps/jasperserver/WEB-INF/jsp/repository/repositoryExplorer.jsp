<%--
 Copyright (C) 2005 - 2007 JasperSoft Corporation.  All rights reserved.
 http://www.jaspersoft.com.

 Unless you have purchased a commercial license agreement from JasperSoft,
 the following license terms apply:

 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2 as published by
 the Free Software Foundation.

 This program is distributed WITHOUT ANY WARRANTY; and without the
 implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 See the GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, see http://www.gnu.org/licenses/gpl.txt
 or write to:

 Free Software Foundation, Inc.,
 59 Temple Place - Suite 330,
 Boston, MA  USA  02111-1307
--%>
<html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/spring" prefix="spring"%>
<%@ taglib uri="/WEB-INF/jasperserver.tld" prefix="js" %>
<%@ taglib uri="http://acegisecurity.org/authz" prefix="authz"%>

<head>
<%-- <link href="adhoc/stylesheets/styles.css" type="text/css" rel="stylesheet"> --%>
<link href="stylesheets/std_treelook.css" type="text/css" rel="stylesheet">
<link href="stylesheets/dialog.css" type="text/css" rel="stylesheet">
<link href="stylesheets/stylesheet.css" type="text/css" rel="stylesheet">

</head>
<body>

<script src="scripts/ajax.js"></script>
<script src="scripts/nanotree.js"></script>
<script src="scripts/treesupport.js"></script>
<script src="scripts/repositoryExplorer.js"></script>
<script src="scripts/common.js"></script>
<script src="scripts/edition.js"></script>
<script src="scripts/drag.js"></script>
<script src="scripts/repositoryExplorerDragAndDrop.js"></script>


<div id='repository_explorer_div'>
<table border="0"  cellspacing="0px" cellpadding="0px" height='54'>
 <tr nowrap>
 <td>&nbsp;&nbsp;&nbsp;
  <table nowrap>
   <tr nowrap>
   
    <td>
      &nbsp;&nbsp;&nbsp;
    </td>

    <td style="cursor: pointer; horizontal-align:center" width='50' height='50' onclick='' id='new_folder_td' align="center">
     <a href='#' class='normalpx' id='new_folder_td_a'><img src="images/new_folder_enabled.gif" border='0' title='<spring:message code="RM_BUTTON_NEW_FOLDER" javaScriptEscape="true"/>' id='new_folder' /></a>
    </td>
    
    <authz:authorize ifAllGranted="ROLE_ADMINISTRATOR">
     <td style="cursor: pointer;" width='50' height='50' onclick='' id='new_resource_td'  align="center">
      <a href='#' class='normalpx' id='new_resource_td_a'><img src="images/new_resource_enabled.gif" border='0' title='<spring:message code="RM_BUTTON_ADD_RESOURCE" javaScriptEscape="true"/>' id='new_resource' /></a>
     </td>
    </authz:authorize>

    <authz:authorize ifAllGranted="ROLE_ADMINISTRATOR">
     <td style="cursor: pointer;" width=50' height='50' onclick='' id='folder_permissions_td'  align="center">
      <a href='#' class='normalpx' id='folder_permissions_td_a'><img src="images/folder_permissions_enabled.gif" border='0' title='<spring:message code="RM_BUTTON_FOLDER_PERMISSION" javaScriptEscape="true"/>' id='folder_permissions' /></a>
     </td>
    </authz:authorize>
    
    <td>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </td>

    <td style="cursor: pointer;" width='50' height='50' onClick='' id='schedule_td' align="center">
     <a href='#' class='normalpx' id='schedule_td_a'><img src="images/schedule_enabled.gif" border='0' title='<spring:message code="RM_BUTTON_SCHEDULE_REPORT" javaScriptEscape="true"/>' id='schedule' /></a>
    </td>

    <td style="cursor: pointer;" width='50' height='50' onClick='' id='send_output_td' align="center">  
     <a href='#' class='normalpx' id='send_output_td_a'><img src="images/send_output_enabled.gif" border='0' title='<spring:message code="RM_BUTTON_RUN_IN_BACKGROUND" javaScriptEscape="true"/>' id='send_output' /></a>
    </td>
    
    <td style="cursor: pointer;" width='50' height='50' onClick='' id='design_td' align="center">  
     <a href='#' class='normalpx' id='design_td_a'><img src="images/design_enabled.gif" border='0' title='<spring:message code="RM_BUTTON_DESIGN" javaScriptEscape="true"/>' id='design' /></a>
    </td>    
    
    <td>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </td>

    <td style="cursor: pointer;" width='50' height='50' align="center" id='move_resource_td' align='center'>
     <a href='#' class='normalpx' id='move_resource_td_a'><img src="images/move_enabled.gif" border='0' title='<spring:message code="RM_BUTTON_MOVE_RESOURCE" javaScriptEscape="true"/>' id='move_resource' class='normalpx'/></a>
    </td>

    <td style="cursor: pointer;" width='50' height='50'  align="center" id='copy_resource_td' align='center'>
     <a href='#' class='normalpx' id='copy_resource_td_a'><img src="images/copy_enabled.gif" border='0' title='<spring:message code="RM_BUTTON_COPY_RESOURCE" javaScriptEscape="true"/>' id='copy_resource'  class='normalpx'/></a>
    </td>

    <td style="cursor: pointer;" width='50' height='50'  align="center" id='paste_resource_td' align='center'>
     <a href='#' class='normalpx' id='paste_resource_td_a'><img src="images/drop_here_enabled.gif"  border='0' title='<spring:message code="RM_BUTTON_PASTE_RESOURCE" javaScriptEscape="true"/>' id='paste_resource' class='normalpx'/></a>
    </td>

    <td style="cursor: pointer;" width='50'  height='50' onClick='' id='delete_td' align="center">
     <a href='#' class='normalpx' id='delete_td_a'><img src="images/delete_enabled.gif" border='0' title='<spring:message code="RM_BUTTON_DELETE_RESOURCE" javaScriptEscape="true"/>' id='delete' /></a>
    </td>

    <td>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </td>

    <td style="cursor: pointer;" width='50'  height='50' onclick='' id='properties_td' align="center">
     <a href='#' class='normalpx' id='properties_td_a'><img src="images/properties_enabled.gif" border='0' title='<spring:message code="RM_BUTTON_PROPERTIES" javaScriptEscape="true"/>' id='properties' /></a>
    </td>

    <authz:authorize ifAllGranted="ROLE_ADMINISTRATOR">
     <td style="cursor: pointer;" width='50' height='50' align="center"  id='edit_td'>
      <a href='#' class='normalpx' id='edit_td_a'><img src="images/edit_enabled.gif" border='0' title='<spring:message code="RM_BUTTON_WIZARD" javaScriptEscape="true"/>' id='edit' /></a>
     </td>
    </authz:authorize>

	<%
	String contextPrefix = System.getProperty("contextPrefix");
	if (contextPrefix == null) contextPrefix = "";
	pageContext.setAttribute("contextPrefix",contextPrefix);
	%>

     <td style="cursor: pointer;" width='50' height='50' align="center" id="wizard_td" onclick="util.elem('wizard_icon').click();">
<!--      <a href='/clementine/ReportWizard.htm' class='normalpx' id='edit_td_a'><img src="images/wizard_icon.png" border='0' title='<spring:message code="RM_BUTTON_REPORTWIZARD" javaScriptEscape="true"/>' id='Report Wizard' /></a>-->
         <form id="reportsource" method="post" action="/${contextPrefix}clementine/ReportWizard.htm" name="myform">
            <input type="hidden" id="reporturi" name="reporturi" />
            <input type="hidden" id="username" name="username" value=<authz:authentication operation="username"/> />
            <input type="hidden" id="password" name="password" value=<authz:authentication operation="password"/> />
            <input id="wizard_icon" type="image" src="images/wizard_icon.png" name="_target0" />
         </form>
 
     </td>
    
   </tr>
  </table>
 </td>
</tr>
</table>

<table style="border-width: 1px 0px 0px 1px;
	border-spacing: 2px;
                border-paddling: 0px;
	border-style: outset outset outset outset;
	border-color: #999999;
	border-collapse: collapse;
	background-color: white" width="99%"  align="center" cellspacing="0px" cellpadding="0px">
<tr>
<td>
<table width="100%" cellspacing="0px" cellpadding="0px">
<tr>
<td style="background:url(images/gold-gradient.gif) repeat-x" height="30px">
<div style="font-size:12px"><b>&nbsp;&nbsp;<spring:message code="RM_FOLDERS" javaScriptEscape="true"/></b></div>
</td>
<td style="background:url(images/gold-gradient.gif) repeat-x" height="30px">
<B><nobr><span><spring:message code="RM_CONTENT" javaScriptEscape="true"/>: </span><span style="font-size:12px" id='fullUri'></span></nobr></B>
</td>
</tr>


<tr>
<td style="border-width: 0px 0px 0px 0px;
	border-spacing: 2px;
	border-style: outset outset outset outset;
	border-color: #993200 #993200 #993200 #993200;
	border-collapse: collapse;
	background-color: white;
                padding: 0px 0px 0px 0px;" width="230" valign="top">
<table width="100%"  cellpadding=0 cellspacing=0 id="repo_outside_table">
	<tr>
		<td width="5" style="border-left:solid 0px #939200;border-top:solid 1px #FFCC99;border-bottom:solid 1px #FFCC99;" >&nbsp;</td>
		<td style="border-top:solid 1px #CCCCCC;border-bottom:solid 1px #CCCCCC;padding-bottom:5px;">
			<table height="100%" width="230" style="border:solid 1px #CCCCCC;border-left:none;border-top:none;">
				<tr><td valign="top">
				 <div id="left_panel" style='overflow:auto'></div>
				</td></tr>
			</table>
		</td>
		<td width="5" style="border-right:solid 1px #CCCCCC;border-bottom:solid 1px #CCCCCC;" >&nbsp;</td>

	</tr>
</table>
</td>
<td style="border-width:1px 0px 0px 0px;
	border-spacing: 2px;
                border-padding: 0px;
	border-style: solid solid solid solid; 
	border-color: #CCCCCC #CCCCCC #CCCCCC #CCCCCC;
	border-collapse: collapse;
	background-color: white;
                padding: 4px 3px 0px 4px ;"  valign="top" onmousedown="javascript:repositoryExplorer.bringUpResourcePopUpMenu(event);repositoryExplorer.checkDragAndDrop(event)">
<div id="right_panel" style='overflow:auto'></div>
</td>
</tr>
</table>
</td>
</tr>
</table>
</div>

<div id="ajaxbuffer" style="display:none"></div>
<div id="ajax_return_status" style="display:none"></div>
<div id="repoOptions" style="display:none"></div>

<%@ include file="RepositoryExplorerFolderPopUpMenu.jsp" %>
<%@ include file="RepositoryExplorerResourcePopUpMenu.jsp" %>
<%@ include file="deleteResourceError.jsp" %>
<%@ include file="deletionConfirm.jsp" %>
<%@ include file="resourceProperties.jsp" %>
<%@ include file="addNewResourceDropDownMenu.jsp" %>
<%@ include file="createFolderDialog.jsp" %>
<%@ include file="pasteConfirmDialog.jsp" %>
<%@ include file="moveOrCopyError.jsp" %>
<%@ include file="dragAndDrop.jsp" %>
<%@ include file="missingParentDialog.jsp" %>
<%@ include file="missingObjectDialog.jsp" %>


<script>

var showFolder = decodeURIComponent('<%=request.getParameter("showFolder")%>');
var lastSelectedResource = null;
var lastSelectedNodeUri = null;
var lastSelectedNode = null;
var currentFocus = "tree";
var currentResourceList = null;
var currentResourceNameList = null;
var currentResourceType = null;
var currentResourceWritable = null;
var currentResourceDeletable = null;
var currentResourceTopOrOption = null;
var currentReportOptionList = null;
var repositoryTree = null;
var modalWinObj = null;
var actionStatus = new Array();
var treeName = 'Repository_Explorer';
var util = new RepositoryExplorerUtil();
// the current move/copy resource uri
var moveOrCopy = '';
var clipBoard = '';
var clipBoardDisplayName = '';
var objectPerformed = '';
var dragListener = new DragListener();
document.onkeypress = onKeyPressAction;
var repositoryExplorer = new RepositoryExplorer();
var singleOrMultipleItems = null;
var currentDragIcon = null;
repositoryExplorer.showFolderTree();


function resizeWindow() {
      var leftDiv = util.elem('left_panel');
      var rightDiv = util.elem('right_panel');
      leftDiv.style.height = document.body.clientHeight - 255 + 'px';  
      leftDiv.style.width = 230 + "px"; 
      rightDiv.style.height = document.body.clientHeight - 255 + 'px';   
      var outsideTable = util.elem('repo_outside_table');
      outsideTable.style.height = document.body.clientHeight - 255 + 'px';    
}
resizeWindow();
window.onresize = resizeWindow;
disableSelectionWithoutCursorStyle(util.elem('left_panel'));
disableSelectionWithoutCursorStyle(util.elem('folder_popup'));
disableSelectionWithoutCursorStyle(util.elem('resource_popup'));

var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=getConfirmationOption';
ajaxTargettedUpdate(urlString, 'repoOptions', null, null, baseErrorHandler);


</script>
<div id='move_string' style="display:none"><spring:message code="RM_BUTTON_MOVE_RESOURCE" javaScriptEscape="true"/></div>
<div id='cancel_move_string' style="display:none"><spring:message code="RM_BUTTON_CANCEL_MOVE_RESOURCE" javaScriptEscape="true"/></div>
<div id='copy_string' style="display:none"><spring:message code="RM_BUTTON_COPY_RESOURCE" javaScriptEscape="true"/></div>
<div id='cancel_copy_string' style="display:none"><spring:message code="RM_BUTTON_CANCLE_COPY_RESOURCE" javaScriptEscape="true"/></div>
<div id='copy_here_string' style="display:none"><spring:message code="RM_BUTTON_COPY_HERE" javaScriptEscape="true"/></div>
<div id='move_here_string' style="display:none"><spring:message code="RM_BUTTON_MOVE_HERE" javaScriptEscape="true"/></div>
<div id='resource_header_strings' style="display:none"><spring:message code="RM_RESOURCES_MENU" javaScriptEscape="true"/></div>
<div id='resource_header_string' style="display:none"><spring:message code="RM_RESOURCE_MENU" javaScriptEscape="true"/></div>



</body>
</html>
