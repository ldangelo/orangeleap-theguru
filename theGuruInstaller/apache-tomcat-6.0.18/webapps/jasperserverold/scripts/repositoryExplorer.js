

// class for generic purpose for the Repository Explorer
function RepositoryExplorerUtil() {
}

RepositoryExplorerUtil.prototype.elem = function(id) {
   return document.getElementById(id);
}

RepositoryExplorerUtil.prototype.executeScript = function(containerId) {
   var container = this.elem(containerId);
   var allScripts = container.getElementsByTagName("script");
   for (var x=0; x<allScripts.length; x++) {
       eval(allScripts[x].innerHTML);
   }
}

RepositoryExplorerUtil.prototype.hideDialog = function(divId) {
    var dialogBox = this.elem(divId);
    dialogBox.style.display = 'none';
    //util.hideMenu(divId);
}



RepositoryExplorerUtil.prototype.hideMenu= function(id) {

    var obj = document.getElementById(id);
    var loc = getObjectLocation(id);
    obj.style.top = loc.y;
    obj.style.left = loc.x;
    nPixelFromTop = 0;
    currentTimeId = setInterval("closePopUpAnimation(" + id + ", " + obj.offsetWidth + ", " + obj.offsetHeight + ", " + loc.y + ", 5)", 10);


}

function getObjectLocation(id) {

    var obj = document.getElementById(id);

    var xPos = obj.offsetLeft;
    var yPos = obj.offsetTop;
    var tempEl = obj.offsetParent;
    while (tempEl != null) {
      	 xPos += tempEl.offsetLeft;
      	 yPos += tempEl.offsetTop;
    	 tempEl = tempEl.offsetParent;
    }

    return {x:xPos, y:yPos};

}

function closePopUpAnimation(obj, width, height, locationY, speed) {

  obj.style.position='absolute';
  obj.style.clip = 'rect(' + (speed + nPixelFromTop) +'px, ' + width + 'px, ' + height + 'px, 0px)';
  obj.style.top = parseInt(obj.style.top) - speed + 'px';
  nPixelFromTop += speed;
  if (nPixelFromTop >= height) {
     clearTimeout(currentTimeId);
     currentTimeId = null;
     obj.style.display = 'none';
     obj.style.clip = 'rect(0px, ' + width + 'px, ' + height + 'px, 0px)';
     nPixelFromTop = 0;
  }

}


// class for performing particular functionality for the Repository Explorer
function RepositoryExplorer() {
    document.body.oncontextmenu=this.suppressDefault;

    // actionStatus
    actionStatus['new_folder'] = new actionProperties('', 'new_folder', 'images/new_folder_enabled.gif', 'images/new_folder_disabled.gif', 'new_folder_menu', null);
    actionStatus['new_resource'] = new actionProperties('', 'new_resource', 'images/new_resource_enabled.gif','images/new_resource_disabled.gif', null, null);
    actionStatus['folder_permissions'] = new actionProperties('', 'folder_permissions', 'images/folder_permissions_enabled.gif', 'images/folder_permissions_disabled.gif', 'folder_permissions_menu', null);
    actionStatus['schedule'] = new actionProperties('', 'schedule', 'images/schedule_enabled.gif' ,'images/schedule_disabled.gif', null, 'schedule_menu');
    actionStatus['send_output'] = new actionProperties('', 'send_output', 'images/send_output_enabled.gif' ,'images/send_output_disabled.gif', null, 'send_output_menu');
    actionStatus['design'] = new actionProperties('', 'design', 'images/design_enabled.gif', 'images/design_disabled.gif', null, null);
    actionStatus['move_resource'] = new actionProperties('', 'move_resource', 'images/move_enabled.gif' ,'images/move_disabled.gif', null, null);
    actionStatus['copy_resource'] = new actionProperties('', 'copy_resource', 'images/copy_enabled.gif' ,'images/copy_disabled.gif', null, null);
    actionStatus['paste_resource'] = new actionProperties('', 'paste_resource', 'images/drop_here_enabled.gif' ,'images/drop_here_disabled.gif', null, null);
    actionStatus['delete'] = new actionProperties('', 'delete', 'images/delete_enabled.gif' ,'images/delete_disabled.gif', 'delete_menu_folder', 'delete_menu');
    actionStatus['properties'] = new actionProperties('', 'properties', 'images/properties_enabled.gif' ,'images/properties_disabled.gif', 'properties_menu_folder', 'properties_menu');
    actionStatus['edit'] = new actionProperties('', 'edit', 'images/edit_enabled.gif' ,'images/edit_disabled.gif', '');
    actionStatus['view'] = new actionProperties('', 'view', '' ,'', '');

    this.getRepositoryExplorerHandler = function() {
    	return function(evt,node) {
            this.repositoryExplorerHandler(evt, node);
    	}
    }

    this.getLaunchNewFolderDialog = function() {
         modalWinObj = renderHazeLayer(0, 0);
         this.launchNewFolderDialog();
    }

    this.getPopUpFolderMenu = function(repoExplorer) {
        return function(evt, node) {
            repoExplorer.popUpFolderMenu(evt, node);
        }
    }

    this.getGetBreadCrumb = function(url) {
        this.getBreadCrumb(url);
    }



    this.getUpdateRowStatus = function(wasChecked, checkBoxId, currentRowNumber, currentRow, currentRowId, control) {
           this.updateRowStatus(wasChecked, checkBoxId, currentRowNumber, currentRow, currentRowId, control);
    }

    this.getUpdateRowStatusForCheckBox = function(wasChecked, checkBoxId, currentRowNumber, currentRow, currentRowId) {
           this.updateRowStatusForCheckBox(wasChecked, checkBoxId, currentRowNumber, currentRow, currentRowId);
    }

}

RepositoryExplorer.prototype.suppressDefault = function() {
   return false;
}

RepositoryExplorer.prototype.showNewPropertyDropMenu = function(event) {


   util.hideDialog('delete_confirm_dialog');
   util.hideDialog('resource_property_dialog');
   util.hideDialog('folder_popup');
   util.hideDialog('resource_popup');
   util.hideDialog('create_folder_dialog');

   if (util.elem('add_resource_drop_down_first_level').style.display == 'block') {

     util.hideDialog('add_resource_drop_down_first_level');
     util.hideDialog('add_resource_drop_down_second_level');
     var newResourceButton = util.elem('new_resource_td_a');
     newResourceButton.style.display = 'none';
     newResourceButton.className = 'normalpx';
     newResourceButton.style.display = 'block';

   } else {

     // keep button pressed style
     var newResourceButton = util.elem('new_resource_td_a');
     newResourceButton.style.display = 'none';
     newResourceButton.className = 'normalpx_pressed';
     newResourceButton.style.display = 'block';

     var evt = event || window.event
     var propertyMenu = util.elem('add_resource_drop_down_first_level');

     // get button triangle location
     var buttonLocation = util.elem('new_resource_td_a');
     var buttonX = getBoxOffsets(buttonLocation)[0] + 33;
     var buttonY = getBoxOffsets(buttonLocation)[1] + 36;

     propertyMenu.position = 'absolute';
     propertyMenu.style.top = buttonY;
     propertyMenu.style.left = buttonX;
     propertyMenu.style.display = 'block';
   }
}


RepositoryExplorer.prototype.showSecondLevelMenu = function(event) {
   var evt = event || window.event
   var propertyMenu = util.elem('add_resource_drop_down_second_level');


   var otherElem = util.elem('larger_sign');
   var posX = getBoxOffsets(otherElem)[0] + (otherElem.offsetWidth / 2);

   var sep = util.elem('new_second_level_menu_sep_bar');
   var posY = getBoxOffsets(sep)[1] - 1;


   propertyMenu.position = 'absolute';
   propertyMenu.style.top = posY;
   propertyMenu.style.left = posX;
   propertyMenu.style.display = 'block';
}


RepositoryExplorer.prototype.showFolderTree = function() {

    currentFocus = 'tree';
    var panel = util.elem('left_panel');

    var initFolder = showFolder;
    if ((initFolder == "null") || (initFolder == "")) {
       initFolder = getRepositoryCookie('js_rm_ParentUri');
    }
    if ((initFolder == "null") || (initFolder == "")) {
       initFolder = '/reports';
    }

    if (!panel.treeSupport) {
        repositoryTree = new TreeSupport(treeName, 'repositoryExplorerTreeFoldersProvider', '/', this.ajaxErrorHandler, true);
        repositoryTree.backingBean = this;
        repositoryTree.urlGetNode = 'flow.html?_flowId=repositoryExplorerFlow&method=getNode'; // server url for 'getNode' method
        repositoryTree.urlGetChildren = 'flow.html?_flowId=repositoryExplorerFlow&method=getChildren'; // server url for 'getChildren' method
        if (lastSelectedNodeUri == null) {
           this.getBreadCrumb(initFolder);
           lastSelectedNodeUri = initFolder;
        } else {
           this.getBreadCrumb(lastSelectedNodeUri);
        }
        repositoryTree.showTreePrefetchNodes('left_panel', initFolder, RepositoryExplorer.showFolderTreeCallback, this.ajaxErrorHandler);

        // drag and drop support

        dragListener.registerAgent(repositoryTree.DEFAULT_DRAG_AGENT_NAME);
        dragListener.publishEvent(repositoryTree.DEFAULT_DRAG_AGENT_NAME, DragListener.DRAGGING_STARTED, folderDraggingStarted);
        dragListener.publishEvent(repositoryTree.DEFAULT_DRAG_AGENT_NAME, DragListener.DRAGGING, treeFolderDragging);
        dragListener.publishEvent(repositoryTree.DEFAULT_DRAG_AGENT_NAME, DragListener.DRAGGING_FINISHED, folderAndResourceDraggingFinished);
        dragListener.publishEvent(repositoryTree.DEFAULT_DRAG_AGENT_NAME, repositoryTree.DRAGGED_OVER_FOLDER_EVENT, draggedOnFolderNode);
        dragListener.publishEvent(repositoryTree.DEFAULT_DRAG_AGENT_NAME, repositoryTree.DRAGGED_OFF_FOLDER_EVENT, draggedOffFolderNode);
        var treeDragSupport = new TreeDragSupport(dragListener);
        treeDragSupport.draggedNodeZindex=2;
        treeDragSupport.canDragFolders=true;
        treeDragSupport.canDragOntoFolder=true;
        treeDragSupport.dragIconSrc='images/drag_folder.gif';
        treeDragSupport.dragAgentName=repositoryTree.DEFAULT_DRAG_AGENT_NAME;
        repositoryTree.dragSupport=treeDragSupport;
        //dragListener.setCurrentAgentName(repositoryTree.DEFAULT_DRAG_AGENT_NAME);

        currentFolderUri = initFolder;
        repositoryTree.treeFolderMouseDownHandler = function(that) {
            return function(evt, node) {
                if (lastSelectedNodeUri != node.param.uri) {
                    that.repositoryExplorerHandler(evt, node);
                }
                that.popUpFolderMenu(evt, node);
            };
        } (this);

        panel.treeSupport = repositoryTree;
        return;

    }

    var inputUri = 'reports';
    var node = panel.treeSupport.findLastLoadedNode(inputUri);
    if (node && node.getParam().uri != inputUri && !node.isLoaded()) {
       panel.treeSupport.getTreeNodeChildrenPrefetched(node, inputUri, RepositoryExplorer.showFolderTreeCallback, this.ajaxErrorHandler);
       return;
    }

    RepositoryExplorer.showFolderTreeCallback();
}

RepositoryExplorer.prototype.ajaxErrorHandler = function() {
    this.showMessageDialog(ajaxError, ajaxErrorHeader);
}

RepositoryExplorer.prototype.showMessageDialog = function(message, header) {
    alert(message);
    alert(header);
}

RepositoryExplorer.showFolderTreeCallback = function(event) {
    var panel = util.elem('left_panel');
    var initFolder = showFolder;
    if (initFolder == "null") {
       initFolder = getRepositoryCookie('js_rm_ParentUri');
    }
    if ((initFolder == "null") || (initFolder == "")) {
       initFolder = '/reports';
    }


    if (panel.treeSupport) {
       if ((lastSelectedNodeUri == null) || (lastSelectedNodeUri == "")) {
         panel.treeSupport.openAndSelectNode(initFolder, RepositoryExplorer.getOnOpenAction(panel.treeSupport));
         lastSelectedNodeUri = initFolder;
       } else {
         panel.treeSupport.openAndSelectNode(lastSelectedNodeUri, RepositoryExplorer.getOnOpenAction(panel.treeSupport));
       }
    }
    if (initFolder == '/') {
       var nodetitle = trees['Repository_Explorer'].rootNode;
	   nodetitle.addNodeToSelected(false);
	   repositoryTree.backingBean.repositoryExplorerHandler(event, nodetitle);
	}
}

RepositoryExplorer.prototype.repositoryExplorerHandler = function(event, node) {

    currentFocus = 'tree';
    setRepositoryCookie('js_rm_ParentUri', node.getParam().uri, 1);
    lastSelectedNodeUri = node.param.uri;
    lastSelectedNode = node;
    var panel = util.elem('left_panel');
    if (node.param.extra && node.param.extra.isWritable) {
        panel.reportFolder = node.param.uri;
    }
    currentResourceList = new Array();
    currentResourceNameList = new Array();
    currentResourceType = new Array();
    currentResourceWritable = new Array();
    currentResourceDeletable = new Array();
    currentResourceTopOrOption = new Array();
    // retrieving list of resources here given a folder, excluding folders
    var callback = function() {
      util.executeScript('right_panel');
    }

    var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=getResources' + '&FolderUri=' + node.getParam().uri;
    ajaxTargettedUpdate(urlString, 'right_panel', null, callback, baseErrorHandler);
    repositoryTree.backingBean.updateActionStatus();
}


RepositoryExplorer.prototype.getResources = function(pageNumber) {

    var callback = function() {
      util.executeScript('right_panel');
    }

    var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=getResources' + '&FolderUri=' + lastSelectedNodeUri + "&PageNumber=" + pageNumber;
    ajaxTargettedUpdate(urlString, 'right_panel', null, callback, baseErrorHandler);

}

RepositoryExplorer.prototype.getBreadCrumb = function(url) {
    var callbackForBreadCrumb = function() {
       var breadCrumbArray = eval("(" + util.elem('ajax_return_status').innerHTML.replace(/&amp;/g, '&').replace(/&gt;/g, '>') + ")");
       var breadCrumbPath = util.elem('fullUri');
       var createFolder = "";
       var htmlCode = "";
       for (var key in breadCrumbArray) {
           if (htmlCode == "") {
              htmlCode += breadCrumbArray[key];
           } else {
              htmlCode += " > " + breadCrumbArray[key];
           }
           // create folder
           createFolder += "/" + breadCrumbArray[key];
       }
       breadCrumbPath.innerHTML = (htmlCode);

       var createFolderDialog = util.elem('parent_folder_id');
       createFolderDialog.innerHTML = createFolder;
    }
    var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=getBreadCrumb' + '&FolderUri=' + url;
    ajaxTargettedUpdate(urlString, 'ajax_return_status', null, callbackForBreadCrumb, baseErrorHandler);
}


RepositoryExplorer.prototype.viewResource= function() {

   if (currentResourceList.length > 0) {
       for (var i=0; i<currentResourceList.length; i++) {
           var curItem = util.elem('checkbox_'+currentResourceList[i]);
           if (curItem.checked == true) {
              if (currentResourceType[i] == 'com.jaspersoft.jasperserver.api.metadata.jasperreports.domain.ReportUnit') {
                 location.href='flow.html?_flowId=viewReportFlow&standAlone=true&reportUnit=' + currentResourceList[i];
              } else if (currentResourceType[i] == 'com.jaspersoft.jasperserver.api.metadata.olap.domain.OlapUnit') {
                 location.href='olap/viewOlap.html?name=' + currentResourceList[i] + '&new=true&ParentFolderUri=' + lastSelectedNodeUri;
              } else if (currentResourceType[i] == 'com.jaspersoft.jasperserver.api.metadata.common.domain.ContentResource') {
                 var newWindow = window.open('fileview/fileview' + currentResourceList[i], '_blank');
                 newWindow.focus();
              } else if (currentResourceType[i] == 'com.jaspersoft.ji.adhoc.AdhocReportUnit') {
                 location.href='flow.html?_flowId=viewReportFlow&standAlone=true&reportUnit=' + currentResourceList[i];
              } else if (currentResourceType[i] == 'com.jaspersoft.ji.adhoc.DashboardResource') {
                 location.href='flow.html?_flowId=dashboardRuntimeFlow&dashboardResource=' + currentResourceList[i];
              }
           }
       }
   }

}


RepositoryExplorer.prototype.findFirstSelectedResource = function() {
      for (var i=0; i<currentResourceList.length; i++) {
          var curItem = util.elem('checkbox_'+currentResourceList[i]);
          if (curItem.checked == true) {
             return currentResourceList[i];
          }
      }
      return null;
}

RepositoryExplorer.prototype.clickOnResourceRow = function(event, currentRowNumber, currentRowId) {

   util.elem('folder_popup').style.display = 'none';
   currentFocus = 'resourceList';
   var nodetitle = document.getElementById('title' + lastSelectedNode.id);
   nodetitle.className = 'treetitleOutOfFocus';
   var checkBoxId = util.elem('checkbox_' + currentRowId);
   var currentRow = util.elem(currentRowId);
   var wasChecked = checkBoxId.checked;


   if (event.ctrlKey) {
      repositoryTree.backingBean.getUpdateRowStatus(wasChecked, checkBoxId, currentRowNumber, currentRow, currentRowId, true);
      lastSelectedResource = repositoryTree.backingBean.findFirstSelectedResource();
   } else if (event.shiftKey) {
      var startIndex = null;
      var endIndex = null;
      for (var i=0; i<currentResourceList.length; i++) {
          var curItem = util.elem('checkbox_'+currentResourceList[i]);
          if ((curItem.checked == true) || (currentResourceList[i] == lastSelectedResource)) {
             if (startIndex == null) {
                startIndex = i;
             } else {
                endIndex = i;
             }
          }

      }
      if (endIndex == null) {
          endIndex = startIndex;
      }

      // clean up everything
      repositoryTree.backingBean.cleanUpAllRows();

      // make select of from startIndex to endIndex
      for (var i=startIndex; i<=endIndex; i++) {
          checkBoxId = util.elem('checkbox_' + currentResourceList[i]);
          currentRow = util.elem(currentResourceList[i]);
          checkBoxId.checked = true;
          currentRow.className = 'list_selected';
          lastSelectedResource = currentRowId;
      }

      // special case: when the last resource has option, select them as well for range selection
      var lastIndex = endIndex + 1;
      var endElement = util.elem('checkbox_' + currentResourceList[lastIndex]);
      while (endElement) {
          if (currentResourceType[lastIndex].indexOf('ReportOptions') != -1) {
             endElement.checked = true;
             currentRow = util.elem(currentResourceList[lastIndex]);
             currentRow.className = 'list_selected';
          } else {
             break;
          }
          lastIndex++;
          endElement = util.elem('checkbox_' + currentResourceList[lastIndex]);
      }

   } else { // no shift or event key is pressed

        repositoryTree.backingBean.cleanUpAllRows();
        repositoryTree.backingBean.getUpdateRowStatus(wasChecked, checkBoxId, currentRowNumber, currentRow, currentRowId, false);
        lastSelectedResource = repositoryTree.backingBean.findFirstSelectedResource();
   }


   // remove the focus from each cell

   //checkBoxId.focus();
   repositoryTree.backingBean.updateActionStatus();

}

RepositoryExplorer.prototype.clickOnResourceRowCheckBox = function(event, currentRowNumber, currentRowId) {

   util.elem('folder_popup').style.display = 'none';
   currentFocus = 'resourceList';
   var nodetitle = document.getElementById('title' + lastSelectedNode.id);
   nodetitle.className = 'treetitleOutOfFocus';

   var checkBoxId = util.elem('checkbox_' + currentRowId);
   var currentRow = util.elem(currentRowId);
   var wasChecked = checkBoxId.checked;


   if (event.ctrlKey) {
      repositoryTree.backingBean.getUpdateRowStatusForCheckBox(wasChecked, checkBoxId, currentRowNumber, currentRow, currentRowId);
      lastSelectedResource = repositoryTree.backingBean.findFirstSelectedResource();
   } else if (event.shiftKey) {
      //currentResourceList
      var startIndex = null;
      var endIndex = null;
      for (var i=0; i<currentResourceList.length; i++) {
          if ((currentResourceList[i] == currentRowId) || (currentResourceList[i] == lastSelectedResource)) {
             if (startIndex == null) {
                startIndex = i;
             } else {
                endIndex = i;
             }
          }
      }
      if (endIndex == null) {
          endIndex = startIndex;
      }

      // clean up everything
      //repositoryTree.backingBean.cleanUpAllRows();

      // make select of from startIndex to endIndex
      for (var i=startIndex; i<=endIndex; i++) {
          checkBoxId = util.elem('checkbox_' + currentResourceList[i]);
          currentRow = util.elem(currentResourceList[i]);
          checkBoxId.checked = true;
          currentRow.className = 'list_selected';
          lastSelectedResource = currentRowId;
      }

   } else { // no shift or event key is pressed
        //repositoryTree.backingBean.cleanUpAllRows();
        repositoryTree.backingBean.getUpdateRowStatusForCheckBox(wasChecked, checkBoxId, currentRowNumber, currentRow, currentRowId);
        lastSelectedResource = repositoryTree.backingBean.findFirstSelectedResource();
   }

   // remove the focus from each cell
   checkBoxId.focus();
   repositoryTree.backingBean.updateActionStatus();
}

RepositoryExplorer.prototype.updateRowStatus = function(wasChecked, checkBoxId, currentRowNumber, currentRow, currentRowId, control) {

/*
   if (wasChecked && control) {
     checkBoxId.checked = false;
     if (currentRowNumber % 2 != 0) {
        currentRow.className = 'list_alternate';
     } else {
        currentRow.className = 'list_default';
     }
   } else {
     checkBoxId.checked = true;
     currentRow.className = 'list_selected';
     lastSelectedResource = currentRowId;
   }
*/


   if (wasChecked && control) {
     checkBoxId.checked = false;
   } else {
     checkBoxId.checked = true;
     lastSelectedResource = currentRowId;
   }

   var currentTopLevelResource = 0;
   var currentOption = 0;
   if (currentResourceList) {
      for (var x=0; x<currentResourceList.length; x++) {
          var currentRow = document.getElementById(currentResourceList[x]);
          var currentRowCheckBox = document.getElementById('checkbox_'+currentResourceList[x]);
          if (currentResourceTopOrOption[x] == 'top') {
             if (currentRowCheckBox.checked == true) {
                currentRow.className = 'list_selected';
             } else {
                if (currentTopLevelResource % 2 != 0) {
                  currentRow.className = 'list_default';
                } else {
                  currentRow.className = 'list_alternate';
                }
             }
             currentTopLevelResource++;
             currentOption = 0;
          } else if (currentResourceTopOrOption[x] == 'option') {
             if (currentRowCheckBox.checked == true) {
                currentRow.className = 'list_selected';
             } else {
                if (currentOption % 2 != 0) {
                   currentRow.className = 'list_option_default';
                } else {
                   currentRow.className = 'list_option_alternate';
                }
             }
             currentOption++;
          }


      }
   }


  // find all selected and set it to list_selected
   if (currentResourceType) {
      if (currentResourceType.length > 0) {
          for (var i=0; i<currentResourceList.length; i++) {
              var curItem = util.elem('checkbox_'+currentResourceList[i]);
              if (curItem.checked == true) {
                 var trItem = util.elem(currentResourceList[i]);
                 trItem.className = 'list_selected';
              }
          }
      }
   }

}


RepositoryExplorer.prototype.updateRowStatusForCheckBox = function(wasChecked, checkBoxId, currentRowNumber, currentRow, currentRowId) {

   // find all selected and set it to list_selected
/*
   if (currentResourceType.length > 0) {
       for (var i=1; i<currentResourceList.length; i++) {
           var curItem = util.elem('checkbox_'+currentResourceList[i]);
           if (curItem.checked == true) {
              var trItem = util.elem(currentResourceList[i]);
              trItem.className = 'list_selected';
           } else {
              var trItem = util.elem(currentResourceList[i]);
              if (i % 2 != 0) {
	         trItem.className = 'list_alternate';
	      } else {
	         trItem.className = 'list_default';
              }
           }
       }
   }
*/
   var currentTopLevelResource = 0;
   var currentOption = 0;
   if (currentResourceList) {
      for (var x=0; x<currentResourceList.length; x++) {
          var currentRow = document.getElementById(currentResourceList[x]);
          var currentRowCheckBox = document.getElementById('checkbox_'+currentResourceList[x]);
          if (currentResourceTopOrOption[x] == 'top') {
             if (currentRowCheckBox.checked == true) {
                currentRow.className = 'list_selected';
             } else {
                if (currentTopLevelResource % 2 != 0) {
                  currentRow.className = 'list_default';
                } else {
                  currentRow.className = 'list_alternate';
                }
             }
             currentTopLevelResource++;
             currentOption = 0;
          } else if (currentResourceTopOrOption[x] == 'option') {
             if (currentRowCheckBox.checked == true) {
                currentRow.className = 'list_selected';
             } else {
                if (currentOption % 2 != 0) {
                   currentRow.className = 'list_option_default';
                } else {
                   currentRow.className = 'list_option_alternate';
                }
             }
             currentOption++;
          }


      }
   }
}

RepositoryExplorer.prototype.cleanUpAllRows = function() {
/*
   if (currentResourceList) {
      for (var x=0; x<currentResourceList.length; x++) {
          var currentRow = document.getElementById(currentResourceList[x]);
          var currentRowCheckBox = document.getElementById('checkbox_'+currentResourceList[x]);
          currentRowCheckBox.checked = false;
          if (x % 2 != 0) {
            currentRow.className = 'list_alternate';
          } else {
            currentRow.className = 'list_default';
          }
      }
   }
*/
   var currentTopLevelResource = 0;
   var currentOption = 0;
   if (currentResourceList) {
      for (var x=0; x<currentResourceList.length; x++) {
          var currentRow = document.getElementById(currentResourceList[x]);
          var currentRowCheckBox = document.getElementById('checkbox_'+currentResourceList[x]);
          currentRowCheckBox.checked = false;
          if (currentResourceTopOrOption[x] == 'top') {
             if (currentTopLevelResource % 2 != 0) {
                currentRow.className = 'list_default';
             } else {
                currentRow.className = 'list_alternate';
             }
             currentTopLevelResource++;
             currentOption = 0;
          } else if (currentResourceTopOrOption[x] == 'option') {
             if (currentOption % 2 != 0) {
                currentRow.className = 'list_option_default';
             } else {
                currentRow.className = 'list_option_alternate';
             }
             currentOption++;
          }
      }
   }

}

RepositoryExplorer.prototype.updateActionStatus = function() {

   var onlyOneReportSelected = repositoryTree.backingBean.isOnlyOneReportSelected();
   var onlyOneResourceSelected = repositoryTree.backingBean.atOnlyOneResourceSelected();
   var onlyOneAdhocOrDashboardOrDataDefinerSelected = repositoryTree.backingBean.isOnlyOneAdhocOrDashboardOrDataDefinerSelected();
   var largerThanOneResourceSelected = repositoryTree.backingBean.moreThanOrEqualToOneResourceSelected()
   var checkAtLeastOneResourceNotDeletable = repositoryTree.backingBean.atLeastOneResourceNotDeletable();
   var checkAtLeastOneResourceNotWritable = repositoryTree.backingBean.atLeastOneResourceNotWritable();
   var sameParentFolder = repositoryTree.backingBean.isSameParentFolder();

   var folderPopUpMenuGroupZeroCount = 0;
   var folderPopUpMenuGroupOneCount = 0;
   var folderPopUpMenuGroupTwoCount = 0;
   var folderPopUpMenuGroupThreeCount = 0;

   var resourcePopupMenuGroupZeroCount = 0;
   var resourcePopupMenuGroupOneCount = 0;
   var resourcePopupMenuGroupTwoCount = 0;
   var resourcePopupMenuGroupThreeCount = 0;
   var resourcePopupMenuGroupFourCount = 0;

   // create folder
   if (lastSelectedNode.param.extra.isWritable && (moveOrCopy == '')) {
      this.changeActionPropertiesStatus('new_folder', true, true, false);
      var tdObj = util.elem(actionStatus['new_folder'].id+'_td');
      tdObj.onclick = getLaunchNewFolderDialogFunc;
      var tdObjA = util.elem(actionStatus['new_folder'].id+'_td_a');
      tdObjA.className = 'normalpx';
      util.elem('new_folder_menu').style.display = '';
      folderPopUpMenuGroupZeroCount++;

   } else {
      this.changeActionPropertiesStatus('new_folder', false, false, false);
      var tdObj = util.elem(actionStatus['new_folder'].id+'_td');
      tdObj.onclick = null;
      var tdObjA = util.elem(actionStatus['new_folder'].id+'_td_a');
      tdObjA.className = '';
      util.elem('new_folder_menu').style.display = 'none';
   }

   // add new resources
   if (lastSelectedNode.param.extra.isWritable && (moveOrCopy == '')) {
      this.changeActionPropertiesStatus('new_resource', true, true, false);
      var tdObj = util.elem(actionStatus['new_resource'].id+'_td');
      if (!!tdObj) {
         tdObj.onclick = getShowNewPropertyDropMenu;
      }
      var tdObjA = util.elem(actionStatus['new_resource'].id+'_td_a');
      if (!!tdObjA) {
         tdObjA.className = 'normalpx';
      }
   } else {
      this.changeActionPropertiesStatus('new_resource', false, false, false);
      var tdObj = util.elem(actionStatus['new_resource'].id+'_td');
      if (!!tdObj) {
         tdObj.onclick = null;
      }
      var tdObjA = util.elem(actionStatus['new_resource'].id+'_td_a');
      if (!!tdObjA) {
         tdObjA.className = '';
      }
   }


   // folder permission
   var tdObj = util.elem(actionStatus['folder_permissions'].id+'_td');
   if (!!tdObj) {
      tdObj.onclick = getGotoRolePermission;
   }
   if (currentFocus == 'tree') {
      if (moveOrCopy != '') {
        this.changeActionPropertiesStatus('folder_permissions', false, false, false);
        var folderMenuPermission = util.elem('folder_permissions_menu');
        if (folderMenuPermission) {
           folderMenuPermission.style.display = 'none';

        }
      } else {
        this.changeActionPropertiesStatus('folder_permissions', true, true, false);
        var folderMenuPermission = util.elem('folder_permissions_menu');
        if (folderMenuPermission) {
           folderMenuPermission.style.display = '';
           folderPopUpMenuGroupZeroCount++;
        }

      }
   } else {
      this.changeActionPropertiesStatus('folder_permissions', true, true, false);
   }



   // scheduling report
   if (onlyOneReportSelected && onlyOneResourceSelected && (moveOrCopy == '')) {
      this.changeActionPropertiesStatus('schedule', true, false, true);
      var tdObj = util.elem(actionStatus['schedule'].id+'_td');
      tdObj.onclick = getGotoSchedulingReport;
      var tdObjA = util.elem(actionStatus['schedule'].id+'_td_a');
      tdObjA.className = 'normalpx';

      // pop-up menu
      var scheduleMenuItem = util.elem('schedule_menu');
      scheduleMenuItem.style.color = '#043A66';
      scheduleMenuItem.onmouseover= function() {
           var scheduleMenuItem1 = util.elem('schedule_menu');
           scheduleMenuItem1.style.backgroundColor = '#993200';
           scheduleMenuItem1.style.color='#FCF1DD';
         }
      scheduleMenuItem.onmouseout= function() {
           var scheduleMenuItem2 = util.elem('schedule_menu');
           scheduleMenuItem2.style.backgroundColor = '#FCF1DD';
           scheduleMenuItem2.style.color='#043A66';
         }

      scheduleMenuItem.onclick = getGotoSchedulingReport;
      // show the row
      util.elem('schedule_td_popup').style.display = '';
      util.elem('schedule_menu').style.display = '';
      resourcePopupMenuGroupOneCount++;

   } else {
      this.changeActionPropertiesStatus('schedule', false, false, false);
      var tdObj = util.elem(actionStatus['schedule'].id+'_td');
      tdObj.onclick = null;
      var tdObjA = util.elem(actionStatus['schedule'].id+'_td_a');
      tdObjA.className = '';

      // pop-up menu
      var scheduleMenuItem = util.elem('schedule_menu');
      scheduleMenuItem.style.color = '#CDAE9F';
      scheduleMenuItem.onmouseover=null;
      scheduleMenuItem.onmouseout=null;
      scheduleMenuItem.onclick = null;
      // hide the row
      util.elem('schedule_td_popup').style.display = 'none';
      util.elem('schedule_menu').style.display = 'none';
   }

   // Run in background
   if (onlyOneReportSelected && onlyOneResourceSelected && (moveOrCopy == '')) {
      this.changeActionPropertiesStatus('send_output', true, false, true);
      var tdObj = util.elem(actionStatus['send_output'].id+'_td');
      tdObj.onclick = getGotoReportJob;
      var tdObjA = util.elem(actionStatus['send_output'].id+'_td_a');
      tdObjA.className = 'normalpx';

      // pop-up menu
      var sentoutputMenuItem = util.elem('send_output_menu');
      sentoutputMenuItem.style.color = '#043A66';
      sentoutputMenuItem.onmouseover= function() {
           var sentoutputMenuItem1 = util.elem('send_output_menu');
           sentoutputMenuItem1.style.backgroundColor = '#993200';
           sentoutputMenuItem1.style.color='#FCF1DD';
         }
      sentoutputMenuItem.onmouseout= function() {
           var sentoutputMenuItem2 = util.elem('send_output_menu');
           sentoutputMenuItem2.style.backgroundColor = '#FCF1DD';
           sentoutputMenuItem2.style.color='#043A66';
         }
      sentoutputMenuItem.onclick = getGotoReportJob;
      util.elem('send_output_td_popup').style.display = '';
      util.elem('send_output_menu').style.display = '';
      resourcePopupMenuGroupOneCount++;

   } else {
      this.changeActionPropertiesStatus('send_output', false, false, false);
      var tdObj = util.elem(actionStatus['send_output'].id+'_td');
      tdObj.onclick = null;
      var tdObjA = util.elem(actionStatus['send_output'].id+'_td_a');
      tdObjA.className = '';

      // pop-up menu
      var sentoutputMenuItem = util.elem('send_output_menu');
      sentoutputMenuItem.style.color = '#CDAE9F';
      sentoutputMenuItem.onmouseover=null;
      sentoutputMenuItem.onmouseout=null;
      sentoutputMenuItem.onclick = null;
      util.elem('send_output_td_popup').style.display = 'none';
      util.elem('send_output_menu').style.display = 'none';
   }




   //design
   if (js_edition == 'PRO' && (moveOrCopy == '')) {
      if (onlyOneResourceSelected && onlyOneAdhocOrDashboardOrDataDefinerSelected) {
          this.changeActionPropertiesStatus('design', true, false, false);
          var tdObj = util.elem(actionStatus['design'].id+'_td');
          tdObj.onclick = repositoryTree.backingBean.designEditor;
          var tdObjA = util.elem(actionStatus['design'].id+'_td_a');
          tdObjA.className = 'normalpx';

          // pop-up menu
          var designMenuItem = util.elem('open_in_design_menu');
          designMenuItem.style.color = '#043A66';
          designMenuItem.onmouseover= function() {
              var designMenuItem1 = util.elem('open_in_design_menu');
              designMenuItem1.style.backgroundColor = '#993200';
              designMenuItem1.style.color='#FCF1DD';
          }
          designMenuItem.onmouseout= function() {
              var designMenuItem2 = util.elem('open_in_design_menu');
              designMenuItem2.style.backgroundColor = '#FCF1DD';
              designMenuItem2.style.color='#043A66';
          }
          designMenuItem.onclick = repositoryTree.backingBean.designEditor;
          util.elem('open_in_design_td_popup').style.display = '';
          util.elem('open_in_design_menu').style.display = '';
          resourcePopupMenuGroupOneCount++;

      } else {
          this.changeActionPropertiesStatus('design', false, false, false);
          var tdObj = util.elem(actionStatus['design'].id+'_td');
          tdObj.onclick = null;
          var tdObjA = util.elem(actionStatus['design'].id+'_td_a');
          tdObjA.className = '';

          // pop-up menu
          var designMenuItem = util.elem('open_in_design_menu');
          designMenuItem.style.color = '#CDAE9F';
          designMenuItem.onmouseover = null;
          designMenuItem.onmouseout = null;
          designMenuItem.onclick = null;
          util.elem('open_in_design_td_popup').style.display = 'none';
          util.elem('open_in_design_menu').style.display = 'none';

      }
   } else if (js_edition == 'OS') {
      util.elem('design_td').style.display = 'none';
   }


   // move
   if (currentFocus == 'tree') {
      if ((lastSelectedNodeUri != '/') && (lastSelectedNode.param.extra.isWritable) && ((clipBoard == '') || (moveOrCopy == 'move'))) {
         util.elem('move_resource_td').onclick = repositoryTree.backingBean.moveUri;
         this.changeActionPropertiesStatus('move_resource', true, false, false);
         util.elem('move_menu_folder').style.display = '';
         util.elem('move_menu_folder').onclick = repositoryTree.backingBean.moveUri;
         var tdObjA = util.elem(actionStatus['move_resource'].id+'_td_a');
         if (clipBoard == '') {
            tdObjA.className = 'normalpx';
         }
         if (clipBoard == '') {
            util.elem('move_menu_div').style.display = 'block';
            util.elem('cancel_move_menu_div').style.display = 'none';
            util.elem('move_menu').style.display = 'block';
            util.elem('cancel_move_menu').style.display = 'none';
         } else {
            util.elem('move_menu_div').style.display = 'none';
            util.elem('cancel_move_menu_div').style.display = 'block';
            util.elem('move_menu').style.display = 'none';
            util.elem('cancel_move_menu').style.display = 'block';
         }
         folderPopUpMenuGroupOneCount++;
      } else {
         util.elem('move_resource_td').onclick = null;
         this.changeActionPropertiesStatus('move_resource', false, false, false);
         var tdObjA = util.elem(actionStatus['move_resource'].id+'_td_a');
         tdObjA.className = '';
         util.elem('move_menu_folder').style.display = 'none';
         util.elem('move_menu_folder').onclick = '';
      }
   } else {
      if (((!checkAtLeastOneResourceNotWritable) && (largerThanOneResourceSelected) && (moveOrCopy == '')) || (moveOrCopy == 'move')) {
         util.elem('move_resource_td').onclick = repositoryTree.backingBean.moveUri;
         this.changeActionPropertiesStatus('move_resource', true, true, true);
         util.elem('move_menu_resource').style.display = '';
         util.elem('move_menu_resource').onclick = repositoryTree.backingBean.moveUri;
         var tdObjA = util.elem(actionStatus['move_resource'].id+'_td_a');
         if (clipBoard == '') {
            tdObjA.className = 'normalpx';
         }
         if (clipBoard == '') {
            util.elem('move_menu_div').style.display = 'block';
            util.elem('cancel_move_menu_div').style.display = 'none';
            util.elem('move_menu').style.display = 'block';
            util.elem('cancel_move_menu').style.display = 'none';
         } else {
            util.elem('move_menu_div').style.display = 'none';
            util.elem('cancel_move_menu_div').style.display = 'block';
            util.elem('move_menu').style.display = 'none';
            util.elem('cancel_move_menu').style.display = 'block';
         }
         resourcePopupMenuGroupTwoCount++;
      } else {
         util.elem('move_resource_td').onclick = null;
         this.changeActionPropertiesStatus('move_resource', false, false, false);
         var tdObjA = util.elem(actionStatus['move_resource'].id+'_td_a');
         tdObjA.className = '';
         util.elem('move_menu_resource').style.display = 'none';
         util.elem('move_menu_resource').onclick = '';
      }
   }

   // copy copy_td
   if (currentFocus == 'tree') {
      if ((lastSelectedNodeUri != '/') && ((clipBoard == '') || (moveOrCopy == 'copy'))) {
         util.elem('copy_resource_td').onclick = repositoryTree.backingBean.copyUri;
         this.changeActionPropertiesStatus('copy_resource', true, false, false);
         util.elem('copy_menu_folder').style.display = '';
         util.elem('copy_menu_folder').onclick = repositoryTree.backingBean.copyUri;
         var tdObjA = util.elem(actionStatus['copy_resource'].id+'_td_a');
         if (clipBoard == '') {
            tdObjA.className = 'normalpx';
         }
         if (clipBoard == '') {
            util.elem('copy_menu_div').style.display = 'block';
            util.elem('cancel_copy_menu_div').style.display = 'none';
            util.elem('copy_menu').style.display = 'block';
            util.elem('cancel_copy_menu').style.display = 'none';
         } else {
            util.elem('copy_menu_div').style.display = 'none';
            util.elem('cancel_copy_menu_div').style.display = 'block';
            util.elem('copy_menu').style.display = 'none';
            util.elem('cancel_copy_menu').style.display = 'block';
         }
         folderPopUpMenuGroupOneCount++;
      } else {
         util.elem('copy_resource_td').onclick = null;
         this.changeActionPropertiesStatus('copy_resource', false, false, false);
         var tdObjA = util.elem(actionStatus['copy_resource'].id+'_td_a');
         tdObjA.className = '';
         util.elem('copy_menu_folder').style.display = 'none';
         util.elem('copy_menu_folder').onclick = '';
      }
   } else {
      if ((largerThanOneResourceSelected && (moveOrCopy == '')) || (moveOrCopy == 'copy')) {
         util.elem('copy_resource_td').onclick = repositoryTree.backingBean.copyUri;
         this.changeActionPropertiesStatus('copy_resource', true, true, true);
         util.elem('copy_menu_resource').style.display = '';
         util.elem('copy_menu_resource').onclick = repositoryTree.backingBean.copyUri;
         var tdObjA = util.elem(actionStatus['copy_resource'].id+'_td_a');
         if (clipBoard == '') {
            tdObjA.className = 'normalpx';
         }
         if (clipBoard == '') {
            util.elem('copy_menu_div').style.display = 'block';
            util.elem('cancel_copy_menu_div').style.display = 'none';
            util.elem('copy_menu').style.display = 'block';
            util.elem('cancel_copy_menu').style.display = 'none';
         } else {
            util.elem('copy_menu_div').style.display = 'none';
            util.elem('cancel_copy_menu_div').style.display = 'block';
            util.elem('copy_menu').style.display = 'none';
            util.elem('cancel_copy_menu').style.display = 'block';
         }
         resourcePopupMenuGroupTwoCount++;
      } else {
         util.elem('copy_resource_td').onclick = null;
         this.changeActionPropertiesStatus('copy_resource', false, false, false);
         var tdObjA = util.elem(actionStatus['copy_resource'].id+'_td_a');
         tdObjA.className = '';
         util.elem('copy_menu_resource').style.display = 'none';
         util.elem('copy_menu_resource').onclick = '';
      }
   }


   // paste
   if (currentFocus == 'tree') {
      if ((lastSelectedNode.param.extra.isWritable) && (clipBoard != '') && (!sameParentFolder)) {
         util.elem('paste_resource_td').onclick = repositoryTree.backingBean.launchPasteConfirmDialog;
         this.changeActionPropertiesStatus('paste_resource', true, false, false);
         var tdObjA = util.elem(actionStatus['paste_resource'].id+'_td_a');
         tdObjA.className = 'normalpx';
         util.elem('drop_here_folder').style.display = '';
         util.elem('drop_here_folder').onclick = repositoryTree.backingBean.launchPasteConfirmDialog;
         if (moveOrCopy == 'move') {
            util.elem('paste_menu_div').innerHTML = util.elem('move_here_string').innerHTML;
            util.elem('paste_resource').title = util.elem('move_here_string').innerHTML;
         } else {
            util.elem('paste_menu_div').innerHTML = util.elem('copy_here_string').innerHTML;
            util.elem('paste_resource').title = util.elem('copy_here_string').innerHTML;
         }
         folderPopUpMenuGroupOneCount++;
      } else {
         util.elem('paste_resource_td').onclick = null;
         this.changeActionPropertiesStatus('paste_resource', false, false, false);
         var tdObjA = util.elem(actionStatus['paste_resource'].id+'_td_a');
         tdObjA.className = '';
         util.elem('drop_here_folder').style.display = 'none';
         util.elem('drop_here_folder').onclick = '';
         util.elem('paste_resource').title = '';
      }
   } else {
         util.elem('paste_resource_td').onclick = null;
         this.changeActionPropertiesStatus('paste_resource', false, false, false);
         var tdObjA = util.elem(actionStatus['paste_resource'].id+'_td_a');
         tdObjA.className = '';
         util.elem('paste_menu_resource').style.display = 'none';
         util.elem('paste_menu_resource').onclick = '';
         //util.elem('paste_resource').title
         resourcePopupMenuGroupTwoCount++;
   }



   // delete

   if (((largerThanOneResourceSelected && (currentFocus != 'tree') && (!checkAtLeastOneResourceNotDeletable)) ||
       ((currentFocus == 'tree') && (lastSelectedNodeUri != '/') && (lastSelectedNode.param.extra.isRemovable))) && (moveOrCopy == '')) {
      this.changeActionPropertiesStatus('delete', true, false, true);
      var tdObj = util.elem(actionStatus['delete'].id+'_td');
      tdObj.onclick = repositoryTree.backingBean.launchDelete;
      var tdObjA = util.elem(actionStatus['delete'].id+'_td_a');
      tdObjA.className = 'normalpx'

      // pop-up menu
      var propertiesMenuItem = util.elem('delete_menu');
      propertiesMenuItem.style.color = '#043A66';
      propertiesMenuItem.onmouseover= function() {
           var propertiesMenuItem1 = util.elem('delete_menu');
           propertiesMenuItem1.style.backgroundColor = '#993200';
           propertiesMenuItem1.style.color='#FCF1DD';
         }
      propertiesMenuItem.onmouseout= function() {
           var propertiesMenuItem2 = util.elem('delete_menu');
           propertiesMenuItem2.style.backgroundColor = '#FCF1DD';
           propertiesMenuItem2.style.color='#043A66';
         }
      propertiesMenuItem.onclick = repositoryTree.backingBean.launchDelete;
      propertiesMenuItem.style.display = 'block';
      folderPopUpMenuGroupTwoCount++;
      resourcePopupMenuGroupThreeCount++;

   } else {
      this.changeActionPropertiesStatus('delete', false, false, false);
      var tdObj = util.elem(actionStatus['delete'].id+'_td');
      tdObj.onclick = null;
      var tdObjA = util.elem(actionStatus['delete'].id+'_td_a');
      tdObjA.className = ''

      // pop-up menu
      var sebtoutputMenuItem = util.elem('delete_menu');
      sebtoutputMenuItem.style.color = '#CDAE9F';
      sebtoutputMenuItem.onmouseover=null;
      sebtoutputMenuItem.onmouseout=null;
      sebtoutputMenuItem.onclick = null;
      sebtoutputMenuItem.style.display = 'none';


   }

   if (((!lastSelectedNode.param.extra.isRemovable) || (lastSelectedNodeUri == '/')) || (moveOrCopy != '')) {
      util.elem('delete_menu_folder').style.display = 'none';
   } else {
      util.elem('delete_menu_folder').style.display = '';
   }





   // properties
   if ((onlyOneResourceSelected || (currentFocus == 'tree')) && (moveOrCopy == '')) {
      this.changeActionPropertiesStatus('properties', true, false, true);
      var tdObj = util.elem(actionStatus['properties'].id+'_td');
      tdObj.onclick = gotoLaunchProperties;
      var tdObjA = util.elem(actionStatus['properties'].id+'_td_a');
      tdObjA.className = 'normalpx'

      // pop-up menu
      var propertiesMenuItem = util.elem('properties_menu');
      propertiesMenuItem.style.color = '#043A66';
      propertiesMenuItem.onmouseover= function() {
           var propertiesMenuItem1 = util.elem('properties_menu');
           propertiesMenuItem1.style.backgroundColor = '#993200';
           propertiesMenuItem1.style.color='#FCF1DD';
         }
      propertiesMenuItem.onmouseout= function() {
           var propertiesMenuItem2 = util.elem('properties_menu');
           propertiesMenuItem2.style.backgroundColor = '#FCF1DD';
           propertiesMenuItem2.style.color='#043A66';
         }
      propertiesMenuItem.onclick = gotoLaunchProperties;

      (util.elem('properties_td_popup')).style.display = '';
      (util.elem('properties_menu')).style.display = '';

      var folderMenuProperty = util.elem('properties_menu_folder');
      if (folderMenuProperty) {
         folderMenuProperty.style.display = '';
      }
      folderPopUpMenuGroupThreeCount++;
      resourcePopupMenuGroupFourCount++;

   } else {
      this.changeActionPropertiesStatus('properties', false, false, false);
      var tdObj = util.elem(actionStatus['properties'].id+'_td');
      tdObj.onclick = null;
      var tdObjA = util.elem(actionStatus['properties'].id+'_td_a');
      tdObjA.className = ''

      // pop-up menu
      var sebtoutputMenuItem = util.elem('properties_menu');
      sebtoutputMenuItem.style.color = '#CDAE9F';
      sebtoutputMenuItem.onmouseover=null;
      sebtoutputMenuItem.onmouseout=null;
      sebtoutputMenuItem.onclick = null;
      (util.elem('properties_td_popup')).style.display = 'none';
      (util.elem('properties_menu')).style.display = 'none';

      var folderMenuProperty = util.elem('properties_menu_folder');
      if (folderMenuProperty) {
         folderMenuProperty.style.display = 'none';
      }

   }

   // view popup menu
   if (repositoryTree.backingBean.shouldViewEnabled() && (moveOrCopy == '')) {
      util.elem('view_td').style.display = '';
      resourcePopupMenuGroupZeroCount++;
   } else {
      util.elem('view_td').style.display = 'none';
   }


   // edit wizard
   if ((((currentFocus != 'tree') && onlyOneResourceSelected && repositoryTree.backingBean.excludeType() && (!checkAtLeastOneResourceNotWritable)) ||
        ((currentFocus == 'tree') && (lastSelectedNodeUri != '/'))) && (moveOrCopy == '')) {
   
   
 //  if ((((onlyOneResourceSelected || (currentFocus == 'tree')) && (repositoryTree.backingBean.excludeType()) && (lastSelectedNodeUri != '/')) &&
 //      (!checkAtLeastOneResourceNotWritable)) && (moveOrCopy == '')) {
      this.changeActionPropertiesStatus('edit', true, false, true);
      var tdObj = util.elem(actionStatus['edit'].id+'_td');
      if (!!tdObj) {
         tdObj.onclick = repositoryTree.backingBean.editObject;
      }
      var tdObjA = util.elem(actionStatus['edit'].id+'_td_a');
      if (!!tdObjA) {
         tdObjA.className = 'normalpx'
      }
      // pop-up menu
      var propertiesMenuItem = util.elem('edit_menu');
      if (!!propertiesMenuItem) {
         propertiesMenuItem.style.color = '#043A66';
         propertiesMenuItem.onmouseover= function() {
           var propertiesMenuItem1 = util.elem('edit_menu');
           propertiesMenuItem1.style.backgroundColor = '#993200';
           propertiesMenuItem1.style.color='#FCF1DD';
         }
         propertiesMenuItem.onmouseout= function() {
           var propertiesMenuItem2 = util.elem('edit_menu');
           propertiesMenuItem2.style.backgroundColor = '#FCF1DD';
           propertiesMenuItem2.style.color='#043A66';
         }
         propertiesMenuItem.onclick = repositoryTree.backingBean.editObject;
      }
      var editPopupCheck = util.elem('edit_td_popup')
      if (editPopupCheck) {
         editPopupCheck.style.display = '';
         util.elem('edit_menu').style.display = '';
         resourcePopupMenuGroupZeroCount++;
      }

   } else {
      this.changeActionPropertiesStatus('edit', false, false, false);
      var tdObj = util.elem(actionStatus['edit'].id+'_td');
      if (!!tdObj) {
         tdObj.onclick = null;
      }
      var tdObjA = util.elem(actionStatus['edit'].id+'_td_a');
      if (!!tdObjA) {
         tdObjA.className = ''
      }

      // pop-up menu
      var sebtoutputMenuItem = util.elem('edit_menu');
      if (!!sebtoutputMenuItem) {
         sebtoutputMenuItem.style.color = '#CDAE9F';
         sebtoutputMenuItem.onmouseover=null;
         sebtoutputMenuItem.onmouseout=null;
         sebtoutputMenuItem.onclick = null;
      }
      var editPopupCheck = util.elem('edit_td_popup')
      if (editPopupCheck) {
         editPopupCheck.style.display = 'none';
         util.elem('edit_menu').style.display = 'none';
      }
   }

   // report wizard
   if ((currentFocus != 'tree') && onlyOneResourceSelected && repositoryTree.backingBean.excludeType() && (!checkAtLeastOneResourceNotWritable)) {
	   var tdObj = util.elem('wizard_td');
	      
	   var selectedResources = document.getElementsByName('resource_checkbox');
	   var resources = '';
	   var uri= '';
	   for (var i=0; i<selectedResources.length; i++) {
		   if (selectedResources[i].checked == true) {
			   uri = selectedResources[i].value;
			   break;
		   }		      
	   }
	      
	   if (uri.indexOf("THEGURU_") > 0) {
		   util.elem('reporturi').value = uri;
	      
		   // pop-up menu
		   var propertiesMenuItem = util.elem('edit_guru_menu');
		   if (!!propertiesMenuItem) {
			   propertiesMenuItem.style.color = '#043A66';
			   propertiesMenuItem.onmouseover= function() {
				   var propertiesMenuItem1 = util.elem('edit_guru_menu');
				   propertiesMenuItem1.style.backgroundColor = '#993200';
				   propertiesMenuItem1.style.color='#FCF1DD';
			   }
			   propertiesMenuItem.onmouseout= function() {
				   var propertiesMenuItem2 = util.elem('edit_guru_menu');
				   propertiesMenuItem2.style.backgroundColor = '#FCF1DD';
				   propertiesMenuItem2.style.color='#043A66';
			   }
			   propertiesMenuItem.onclick = tdObj.onclick;
		   }
		   var editPopupCheck = util.elem('edit_guru_td_popup')
		   if (editPopupCheck) {
			   editPopupCheck.style.display = '';
			   util.elem('edit_guru_menu').style.display = '';
			   resourcePopupMenuGroupZeroCount++;
		   }	    	  
	   } else {
		   util.elem('reporturi').value = '';
		   // pop-up menu
		   var sebtoutputMenuItem = util.elem('edit_guru_menu');
		   if (!!sebtoutputMenuItem) {
			   sebtoutputMenuItem.style.color = '#CDAE9F';
			   sebtoutputMenuItem.onmouseover=null;
			   sebtoutputMenuItem.onmouseout=null;
			   sebtoutputMenuItem.onclick = null;
		   }
		   var editPopupCheck = util.elem('edit_guru_menu')
		   if (editPopupCheck) {
			   editPopupCheck.style.display = 'none';
			   util.elem('edit_guru_menu').style.display = 'none';
		   }
	   }
   } else {
	   util.elem('reporturi').value = '';
	   // pop-up menu
	   var sebtoutputMenuItem = util.elem('edit_guru_menu');
	   if (!!sebtoutputMenuItem) {
		   sebtoutputMenuItem.style.color = '#CDAE9F';
		   sebtoutputMenuItem.onmouseover=null;
		   sebtoutputMenuItem.onmouseout=null;
		   sebtoutputMenuItem.onclick = null;
	   }
	   var editPopupCheck = util.elem('edit_guru_menu')
	   if (editPopupCheck) {
		   editPopupCheck.style.display = 'none';
		   util.elem('edit_guru_menu').style.display = 'none';
	   }
   }   
   
   // access grant schema and domain
   if (js_edition == 'PRO') {
      util.elem('access_grant_schema_td').style.display = '';
      util.elem('sl_datasource_td').style.display = '';

   } else {
      util.elem('access_grant_schema_td').style.display = 'none';
      util.elem('sl_datasource_td').style.display = 'none';
   }

   // resource popup assign permissions
   var permissionMenu = util.elem('resource_permissions_menu');
   if (permissionMenu) {
      if (onlyOneResourceSelected && (moveOrCopy == '')) {
         util.elem('resource_permissions_menu').style.display = '';
         resourcePopupMenuGroupFourCount++;
      } else {
         util.elem('resource_permissions_menu').style.display = 'none';
      }
   }


   // update folder pop up menu seperators
   if (folderPopUpMenuGroupZeroCount > 0) {
      util.elem('folder_popup_sep0').style.display = '';
   } else {
      util.elem('folder_popup_sep0').style.display = 'none';
   }

   if (folderPopUpMenuGroupOneCount > 0) {
      util.elem('folder_popup_sep1').style.display = '';
      util.elem('folder_popup_sep2').style.display = '';
      util.elem('folder_popup_sep3').style.display = '';
   } else {
      util.elem('folder_popup_sep1').style.display = 'none';
      util.elem('folder_popup_sep2').style.display = 'none';
      util.elem('folder_popup_sep3').style.display = 'none';
   }

   if (folderPopUpMenuGroupTwoCount > 0) {
      util.elem('folder_popup_sep4').style.display = '';
      util.elem('folder_popup_sep5').style.display = '';
      util.elem('folder_popup_sep6').style.display = '';
   } else {
      util.elem('folder_popup_sep4').style.display = 'none';
      util.elem('folder_popup_sep5').style.display = 'none';
      util.elem('folder_popup_sep6').style.display = 'none';
   }

   if (folderPopUpMenuGroupThreeCount > 0) {
      util.elem('folder_popup_sep7').style.display = '';
      util.elem('folder_popup_sep8').style.display = '';
      util.elem('folder_popup_sep9').style.display = '';
   } else {
      util.elem('folder_popup_sep7').style.display = 'none';
      util.elem('folder_popup_sep8').style.display = 'none';
      util.elem('folder_popup_sep9').style.display = 'none';
   }

   // update resource pop up menu seperators
   if (resourcePopupMenuGroupZeroCount > 0) {
      util.elem('resource_sep0').style.display = '';
   } else {
      util.elem('resource_sep0').style.display = 'none';
   }

   if (resourcePopupMenuGroupOneCount > 0) {
      util.elem('resource_sep1').style.display = '';
   } else {
      util.elem('resource_sep1').style.display = 'none';
   }

   if (resourcePopupMenuGroupTwoCount > 0) {
      util.elem('resource_sep2').style.display = '';
   } else {
      util.elem('resource_sep2').style.display = 'none';
   }

   if (resourcePopupMenuGroupThreeCount > 0) {
      util.elem('resource_sep3').style.display = '';
      util.elem('resource_sep4').style.display = '';
      util.elem('resource_sep5').style.display = '';
   } else {
      util.elem('resource_sep3').style.display = 'none';
      util.elem('resource_sep4').style.display = 'none';
      util.elem('resource_sep5').style.display = 'none';
   }

   if (resourcePopupMenuGroupFourCount > 0) {
      util.elem('resource_sep6').style.display = '';
   } else {
      util.elem('resource_sep6').style.display = 'none';
   }


}


RepositoryExplorer.prototype.shouldViewEnabled = function() {

    var count = 0;
    var foundViewResource = false;
    if (currentResourceList && (currentResourceList.length > 0)) {
       for (var i=0; i<currentResourceList.length; i++) {
           var curItem = util.elem('checkbox_'+currentResourceList[i]);
           if (curItem.checked == true) {
              count++;
              if (count > 1) {
                 return false;
              }
              if ((currentResourceType[i] == 'com.jaspersoft.jasperserver.api.metadata.jasperreports.domain.ReportUnit') ||
                  (currentResourceType[i] == 'com.jaspersoft.jasperserver.api.metadata.common.domain.ContentResource') ||
                  (currentResourceType[i] == 'com.jaspersoft.jasperserver.api.metadata.olap.domain.OlapUnit') ||
                  (currentResourceType[i] == 'com.jaspersoft.ji.adhoc.DashboardResource') ||
                  (currentResourceType[i] == 'com.jaspersoft.ji.adhoc.AdhocReportUnit')) {
                 foundViewResource = true;
              }
           }
       }
    }
    if (count == 0) {
       return false;
    }

    if ((count == 1) && (foundViewResource)) {
       return true;
    }
}

RepositoryExplorer.prototype.toggleAllCheckBoxes = function(myself) {

   if (myself.checked) {
      for (var i=0; i<currentResourceList.length; i++) {
         var curItem = util.elem('checkbox_'+currentResourceList[i]);
         var curRow = util.elem(currentResourceList[i]);
         curItem.checked = true;
         curRow.className = 'list_selected';
      }
   } else {
      var currentTopLevelResource = 0;
      var currentOption = 0;
      if (currentResourceList) {
         for (var x=0; x<currentResourceList.length; x++) {
             var currentRow = document.getElementById(currentResourceList[x]);
             var currentRowCheckBox = document.getElementById('checkbox_'+currentResourceList[x]);
             currentRowCheckBox.checked = false;
             if (currentResourceTopOrOption[x] == 'top') {
                if (currentTopLevelResource % 2 != 0) {
                   currentRow.className = 'list_default';
                } else {
                   currentRow.className = 'list_alternate';
                }
                currentTopLevelResource++;
                currentOption = 0;
             } else if (currentResourceTopOrOption[x] == 'option') {
                if (currentRowCheckBox.checked == true) {
                   currentRow.className = 'list_selected';
                } else {
                   if (currentOption % 2 != 0) {
                      currentRow.className = 'list_option_default';
                   } else {
                      currentRow.className = 'list_option_alternate';
                   }
                }
                currentOption++;
             }
         }
      }
   }
   repositoryTree.backingBean.updateActionStatus();
}

RepositoryExplorer.prototype.launchNewFolderDialog = function() {

    util.hideDialog('add_resource_drop_down_first_level');
    var newResourceButton = util.elem('new_resource_td_a');
    if (newResourceButton) {
       newResourceButton.className = 'normalpx';
    }
    util.hideDialog('add_resource_drop_down_second_level');
    util.hideDialog('delete_confirm_dialog');
    util.hideDialog('resource_property_dialog');
    util.hideDialog('folder_popup');
    util.hideDialog('resource_popup');

    var nullFolderName = util.elem('error_null_folder_name');
    nullFolderName.style.display = 'none';

    util.elem('left_panel').style.overflow = 'hidden';
    util.elem('right_panel').style.overflow = 'hidden';

    modalWinObj = renderHazeLayer(0, 0);

    var callbackForNewFolderName = function() {
        var createFolderDiv = util.elem('create_folder_dialog');
        createFolderDiv.style.display = 'block';
        centerLayer(createFolderDiv);
        util.elem('new_folder_name').value = (util.elem('ajax_return_status').innerHTML).replace(/\n/g, '').replace(/^\s*/, "").replace(/\s*$/, "");
        util.elem('new_folder_name').select();
        util.elem('new_folder_name').focus();

        var errorMsg = util.elem('error_duplicate_folder_name');
        errorMsg.style.display = 'none';
    }

    var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=getNewFolderName' + '&FolderUri=' + lastSelectedNodeUri;
    ajaxTargettedUpdate(urlString, 'ajax_return_status', null, callbackForNewFolderName, baseErrorHandler);
}

RepositoryExplorer.prototype.getSelectedResource = function() {

       var selectedResources = document.getElementsByName('resource_checkbox');
       for (var i=0; i<selectedResources.length; i++) {
        if (selectedResources[i].checked == true) {
           return selectedResources[i].value;
        }
       }
       return null;

}

RepositoryExplorer.prototype.excludeType = function() {

       var selectedResources = document.getElementsByName('resource_checkbox');
       for (var i=0; i<selectedResources.length; i++) {
        if (selectedResources[i].checked == true) {
           if (currentResourceType[i] == 'com.jaspersoft.jasperserver.api.metadata.common.domain.ContentResource') {
              return false;
           }
           if (currentResourceType[i] == 'com.jaspersoft.ji.adhoc.DashboardResource') {
              return false;
           }
        }
       }
       return true;
}

RepositoryExplorer.prototype.getSelectedType = function() {

       var selectedResources = document.getElementsByName('resource_checkbox');
       for (var i=0; i<selectedResources.length; i++) {
           if (selectedResources[i].checked == true) {
              return currentResourceType[i];
           }
       }
       return null;
}



RepositoryExplorer.prototype.launchProperties = function() {

    util.hideDialog('add_resource_drop_down_first_level');
    var newResourceButton = util.elem('new_resource_td_a');
    if (newResourceButton) {
       newResourceButton.className = 'normalpx';
    }
    util.hideDialog('add_resource_drop_down_second_level');
    util.hideDialog('create_folder_dialog');
    util.hideDialog('delete_confirm_dialog');
    util.hideDialog('folder_popup');
    util.hideDialog('resource_popup');
    util.elem('name_size_error').style.display = 'none';
    util.elem('desc_size_error').style.display = 'none';
    modalWinObj = renderHazeLayer(0, 0);

    var dup = util.elem('error_duplicate_resource_name');
    dup.style.display = 'none';
    var uri = "/";
    if (currentFocus == 'tree') {
       uri = lastSelectedNodeUri;
    } else {
       // focus on the resource list, assuming only one is selected, otherwise this operation will not be enabled
       var selectedResources = document.getElementsByName('resource_checkbox');
       var resources = '';
       for (var i=0; i<selectedResources.length; i++) {
        if (selectedResources[i].checked == true) {
           uri = selectedResources[i].value;
           break;
        }
       }
    }

    // get property of the selected object

    var callbackForProperties = function() {
        // resolve json and then populate the property popup
        var returnValue = util.elem('ajax_return_status').innerHTML.replace(/\n/g, ' ');

        // object
        if (returnValue.indexOf("MISSING_RESOURCE") != -1) {
           if (currentFocus == 'tree') {
              // remove the node
              var rememberLastSelectedNodeUri = lastSelectedNodeUri;
              var parentUriArray = lastSelectedNodeUri.split("/");
              parentUriArray[parentUriArray.length-1] = '';
              var parentString = parentUriArray.join("/");
              if (parentString == "/") {
                 lastSelectedNodeUri = '/';
                 lastSelectedNode = lastSelectedNode.parent;
                 repositoryTree.backingBean.getGetBreadCrumb(lastSelectedNodeUri);
                 lastSelectedNode.handleNode();
                 lastSelectedNode.isloaded = false;
                 lastSelectedNode.handleNode();
                 lastSelectedNode.addNodeToSelected(false);
                 repositoryTree.backingBean.launchMissingResourceDialog(rememberLastSelectedNodeUri, 'folder');
                 removeOverlay(modalWinObj);
                 util.hideDialog('resource_property_dialog');
                 util.elem('left_panel').style.overflow = 'auto';
                 util.elem('right_panel').style.overflow = 'auto';
                 removeOverlay(modalWinObj);
                 return;
              }

              var panel = util.elem('left_panel');
              lastSelectedNodeUri = lastSelectedNode.parent.param.uri;
              lastSelectedNode = lastSelectedNode.parent;
              lastSelectedNode.handleNode();
              lastSelectedNode.isloaded = false;
              lastSelectedNode.handleNode();
              if (panel.treeSupport) {
                 panel.treeSupport.openAndSelectNode(parentString, RepositoryExplorer.getOnOpenAction(panel.treeSupport));
              }
              lastSelectedNodeUri = parentString;
              repositoryTree.backingBean.getGetBreadCrumb(lastSelectedNodeUri);
              repositoryTree.backingBean.updateActionStatus();
              repositoryTree.backingBean.launchMissingResourceDialog(rememberLastSelectedNodeUri, 'folder');
              util.hideDialog('resource_property_dialog');
              util.elem('left_panel').style.overflow = 'auto';
              util.elem('right_panel').style.overflow = 'auto';
              removeOverlay(modalWinObj);
              return;
           } else {
              // refresh the resource list
              repositoryTree.backingBean.getGetBreadCrumb(lastSelectedNodeUri);
              repositoryTree.backingBean.updateActionStatus();
              repositoryTree.backingBean.launchMissingResourceDialog(lastSelectedResource, 'resource');
              repositoryTree.backingBean.getResources(0);
              util.hideDialog('resource_property_dialog');
              util.elem('left_panel').style.overflow = 'auto';
              util.elem('right_panel').style.overflow = 'auto';
              removeOverlay(modalWinObj);
              return;
           }
        }

        var data = eval("(" + (util.elem('ajax_return_status')).innerHTML.replace(/\n/g, ' ').replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>') + ")");

        if ((data['writable'] == 'true') && ((currentFocus != 'tree') || (lastSelectedNodeUri != '/'))) {
          // name
          var staticName = util.elem('static_name');
          staticName.style.display = '';
          var name = util.elem('modifiable_property_popup_name');
          name.value = data['label'].replace(/\&amp;/g,'&').replace(/\&lt;/g,'<').replace(/\&gt;/g,'>');
          var nameTR = util.elem('modifiable_name');
          nameTR.style.display = '';
          var otherNameTR = util.elem('read_only_name');
          otherNameTR.style.display = 'none';


          // desc
          var staticDesc = util.elem('static_description');
          staticDesc.style.display = '';
          var desc = util.elem('modifiable_property_popup_description');
          desc.value = data['description'].replace(/\&amp;/g,'&').replace(/\&lt;/g,'<').replace(/\&gt;/g,'>');
          var descTR = util.elem('modifiable_description');
          descTR.style.display = '';
          var otherDescTR = util.elem('read_only_description');
          otherDescTR.style.display = 'none';

          var buttons = util.elem('property_both_buttons');
          buttons.style.display = '';
          var otherButton = util.elem('property_one_button');
          otherButton.style.display = 'none';
          util.elem('property_both_button_ok').focus();


        } else {
          // name
          var staticName = util.elem('static_name');
          staticName.style.display = 'none';
          var name = util.elem('read_only_property_popup_name');
          name.innerHTML = data['label'].replace(/\&amp;/g,'&').replace(/\&lt;/g,'<').replace(/\&gt;/g,'>');
          var nameTR = util.elem('read_only_name');
          nameTR.style.display = '';
          var otherNameTR = util.elem('modifiable_name');
          otherNameTR.style.display = 'none';

          // desc
          var staticDesc = util.elem('static_description');
          staticDesc.style.display = 'none';
          var desc = util.elem('read_only_property_popup_description');
          desc.innerHTML = data['description'].replace(/\&amp;/g,'&').replace(/\&lt;/g,'<').replace(/\&gt;/g,'>');

          var descTR = util.elem('read_only_description');
          descTR.style.display = '';
          var otherDescTR = util.elem('modifiable_description');
          otherDescTR.style.display = 'none';


          var buttons = util.elem('property_both_buttons');
          buttons.style.display = 'none';
          var otherButton = util.elem('property_one_button');
          otherButton.style.display = '';
          util.elem('property_single_button_ok').focus();

        }

        var type = util.elem('property_popup_type');
        type.innerHTML=data['type'];
        var creationDate = util.elem('property_popup_date');
        creationDate.innerHTML=data['date'];
        var id = util.elem('property_popup_id');
        id.innerHTML=data['name'];
        var perm = util.elem('property_popup_access');
        var permissionList = '';
        var readOnlyWord = util.elem('readonly_word');
        var modifyWord = util.elem('modify_word');
        var deleteWord = util.elem('delete_word');

        if (data['writable'] == 'true') {
           permissionList += modifyWord.innerHTML;
        } else {
           permissionList += readOnlyWord.innerHTML;
        }
        if (data['deletable'] == 'true') {
           permissionList += ', ';
           permissionList += deleteWord.innerHTML;
        }
        perm.innerHTML= permissionList;

    }

    var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=getResourceProperties' + '&resourceUri=' + encodeURIComponent(encodeURIComponent(uri));
    ajaxTargettedUpdate(urlString, 'ajax_return_status', null, callbackForProperties, baseErrorHandler);

    util.elem('left_panel').style.overflow = 'hidden';
    util.elem('right_panel').style.overflow = 'hidden';

    var propertyPopup = util.elem('resource_property_dialog');
    propertyPopup.style.display = 'block';
    centerLayer(propertyPopup);
    propertyPopup.style.top = 160+"px";
}

RepositoryExplorer.prototype.createFolder = function() {

    var newFolderName = util.elem('new_folder_name').value;
    var newDescription = '';  // not exposing the description field
    var generatedId = '';
    var rememberLastSelectedNodeUri = lastSelectedNodeUri;

    var callbackForCreateFolder = function() {
        // check if the parent still there
        var checkParentExistence = ((util.elem('ajax_return_status')).innerHTML).replace(/\n/g, '');
        if (checkParentExistence.indexOf("JSResourceNotFoundException") != -1) {
           // remove the node from tree and tell the user about the missing of parent node

           var parentUriArray = lastSelectedNodeUri.split("/");
           parentUriArray[parentUriArray.length-1] = '';
           var parentString = parentUriArray.join("/");
           if (parentString == "/") {
              lastSelectedNodeUri = '/';
              lastSelectedNode = lastSelectedNode.parent;
              repositoryTree.backingBean.getGetBreadCrumb(lastSelectedNodeUri);
              lastSelectedNode.handleNode();
              lastSelectedNode.isloaded = false;
              lastSelectedNode.handleNode();
              lastSelectedNode.addNodeToSelected(false);
              repositoryTree.backingBean.launchMissingParentDialog(rememberLastSelectedNodeUri);
              removeOverlay(modalWinObj);
              return;
           }
           var panel = util.elem('left_panel');
           lastSelectedNodeUri = lastSelectedNode.parent.param.uri;
           lastSelectedNode = lastSelectedNode.parent;
           lastSelectedNode.handleNode();
           lastSelectedNode.isloaded = false;
           lastSelectedNode.handleNode();
           if (panel.treeSupport) {
              panel.treeSupport.openAndSelectNode(parentString, RepositoryExplorer.getOnOpenAction(panel.treeSupport));
           }
           lastSelectedNodeUri = parentString;
           repositoryTree.backingBean.getGetBreadCrumb(lastSelectedNodeUri);
           repositoryTree.backingBean.updateActionStatus();
           repositoryTree.backingBean.launchMissingParentDialog(rememberLastSelectedNodeUri);
           return;

        }


        var state = trees['Repository_Explorer'].getState(lastSelectedNode.getID());
        if (state == 'open') {

           var lastNodeUri;
           if (lastSelectedNodeUri == '/') {
              lastNodeUri = '';
           } else {
              lastNodeUri = lastSelectedNodeUri;
           }
           var returnStatus = ((util.elem('ajax_return_status')).innerHTML).replace(/\n/g, '');
           var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=getNode' + '&provider=repositoryExplorerTreeFoldersProvider' + '&uri=' + lastNodeUri + '/' + returnStatus;
           ajaxTargettedUpdate(urlString, 'ajax_return_status', null, getNodeCallBack, baseErrorHandler);

        } else {
           lastSelectedNode.isloaded = false;
           lastSelectedNode.handleNode();
        }
    }

    var getNodeCallBack = function() {
           // addChild, render tree, and then select
           var returnStatus = util.elem('treeNodeText').innerHTML;
           var n = window.eval('(' + returnStatus.replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>') + ')');
           var newNode = repositoryTree.processNode(n);
           lastSelectedNode.addChild(newNode);
           lastSelectedNode.haschilds = true;
           repositoryTree.tree.resetSelected();
           repositoryTree.renderTree('left_panel');
           var rememberLastNode = lastSelectedNode;
           rememberLastNode.addNodeToSelected(false);
           lastSelectedNode = rememberLastNode;
           lastSelectedNodeUri = lastSelectedNode.getParam().uri
           util.elem('ajax_return_status').innerHTML = '';

    }

    var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=createFolder' + '&FolderUri=' + lastSelectedNodeUri + '&FolderName=' + encodeURIComponent(encodeURIComponent(newFolderName)) + '&FolderDescription=' + encodeURIComponent(encodeURIComponent(newDescription));
    ajaxTargettedUpdate(urlString, 'ajax_return_status', null, callbackForCreateFolder, baseErrorHandler);
}

RepositoryExplorer.prototype.launchMissingParentDialog = function(missingParentUri) {
    util.elem('missing_parent_uri').innerHTML = missingParentUri;
    util.elem('missing_parent_dialog').style.display = 'block';
    centerLayer(util.elem('missing_parent_dialog'));
}

RepositoryExplorer.prototype.launchMissingResourceDialog = function(missingUri, type) {
    util.elem('missing_object_uri').innerHTML = missingUri;
    util.elem('missing_object_dialog').style.display = 'block';
    centerLayer(util.elem('missing_object_dialog'));
}


RepositoryExplorer.prototype.saveOKClicked = function() {

    var dup = util.elem('error_duplicate_folder_name');
    dup.style.display = 'none';
    var nullFolderName = util.elem('error_null_folder_name');
    nullFolderName.style.display = 'none';


    var newFolderName = util.elem('new_folder_name').value;
    if (newFolderName.replace(/^\s*/, "") == '') {
       util.elem('error_null_folder_name').style.display = 'block';
       return;
    }


    // check if display name already exists, if so, give inline error message
    var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=doesFolderExist' + '&FolderUri=' + encodeURIComponent(encodeURIComponent(lastSelectedNodeUri)) + '&FolderName=' + encodeURIComponent(encodeURIComponent(newFolderName));
    var callbackForCheckFolderExistence = function() {
        var returnStatus = ((util.elem('ajax_return_status')).innerHTML).replace(/\n/g, '');
        if (returnStatus.indexOf('DUPLICATE_DISPLAY_NAME') != -1) {
           dup.style.display = 'block';
           return;
        }
        repositoryTree.backingBean.createFolder();
        util.hideDialog('create_folder_dialog');
        removeOverlay(modalWinObj);
        util.elem('left_panel').style.overflow = 'auto';
        util.elem('right_panel').style.overflow = 'auto';
    }

    ajaxTargettedUpdate(urlString, 'ajax_return_status', null, callbackForCheckFolderExistence, baseErrorHandler);

}

RepositoryExplorer.prototype.getParentUri = function(lastSelectedNodeUriIn) {

   // if in the top level, then return "/"
   if (lastSelectedNodeUriIn.lastIndexOf("/") == 0) {
      return "/";
   }
   return lastSelectedNodeUriIn.substr(0, lastSelectedNodeUriIn.lastIndexOf("/"));
}

RepositoryExplorer.prototype.savePropertyClicked = function() {


    // validation  0 < name < 100, 0<= description description < 250
    var nameValueForSize = util.elem('modifiable_property_popup_name').value.length;
    if ((nameValueForSize == 0) || (nameValueForSize > 100)) {
       util.elem('name_size_error').style.display = '';
       return;
    }

    var descValueForSize = util.elem('modifiable_property_popup_description').value.length;;
    if (descValueForSize > 250) {
       util.elem('desc_size_error').style.display = '';
       return;
    }

    var data = eval("(" + (util.elem('ajax_return_status')).innerHTML + ")");
    if (data['writable'] != 'true') {
       util.hideDialog('resource_property_dialog');
       util.elem('left_panel').style.overflow = 'auto';
       util.elem('right_panel').style.overflow = 'auto';
       removeOverlay(modalWinObj);
       return;
    }


    var labelProperty = util.elem('modifiable_property_popup_name').value;
    var descProperty = util.elem('modifiable_property_popup_description').value;
    var idProperty = util.elem('property_popup_id').innerHTML;

    // check if display name already exists, if so, give inline error message
    var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=updateResourceProperties' + '&label=' + encodeURIComponent(encodeURIComponent(labelProperty)) + '&desc=' + encodeURIComponent(encodeURIComponent(descProperty))
                    + '&id=' + escape(idProperty) + '&folderUri=';

    if (currentFocus == 'tree') {
       urlString += escape(this.getParentUri(lastSelectedNodeUri));
    } else {
       urlString += escape(lastSelectedNodeUri);
    }
    var callbackForUpdateResourceProperties = function() {
        var returnStatus = ((util.elem('ajax_return_status')).innerHTML).replace(/\n/g, '');
        if (returnStatus.indexOf('DUPLICATE_LABEL_ERROR') != -1) {
           var dup = util.elem('error_duplicate_resource_name');
           dup.style.display = 'block';
           return;
        }

        if (returnStatus.indexOf("MISSING_RESOURCE") != -1) {
           if (currentFocus == 'tree') {
              // remove the node
              var rememberLastSelectedNodeUri = lastSelectedNodeUri;
              var parentUriArray = lastSelectedNodeUri.split("/");
              parentUriArray[parentUriArray.length-1] = '';
              var parentString = parentUriArray.join("/");
              if (parentString == "/") {
                 lastSelectedNodeUri = '/';
                 lastSelectedNode = lastSelectedNode.parent;
                 repositoryTree.backingBean.getGetBreadCrumb(lastSelectedNodeUri);
                 lastSelectedNode.handleNode();
                 lastSelectedNode.isloaded = false;
                 lastSelectedNode.handleNode();
                 lastSelectedNode.addNodeToSelected(false);
                 repositoryTree.backingBean.launchMissingResourceDialog(rememberLastSelectedNodeUri, 'folder');
                 removeOverlay(modalWinObj);
                 util.hideDialog('resource_property_dialog');
                 util.elem('left_panel').style.overflow = 'auto';
                 util.elem('right_panel').style.overflow = 'auto';
                 removeOverlay(modalWinObj);
                 return;
              }

              var panel = util.elem('left_panel');
              lastSelectedNodeUri = lastSelectedNode.parent.param.uri;
              lastSelectedNode = lastSelectedNode.parent;
              lastSelectedNode.handleNode();
              lastSelectedNode.isloaded = false;
              lastSelectedNode.handleNode();
              if (panel.treeSupport) {
                 panel.treeSupport.openAndSelectNode(parentString, RepositoryExplorer.getOnOpenAction(panel.treeSupport));
              }
              lastSelectedNodeUri = parentString;
              repositoryTree.backingBean.getGetBreadCrumb(lastSelectedNodeUri);
              repositoryTree.backingBean.updateActionStatus();
              repositoryTree.backingBean.launchMissingResourceDialog(rememberLastSelectedNodeUri, 'folder');
              util.hideDialog('resource_property_dialog');
              util.elem('left_panel').style.overflow = 'auto';
              util.elem('right_panel').style.overflow = 'auto';
              removeOverlay(modalWinObj);
              return;
           } else {
              // refresh the resource list
              repositoryTree.backingBean.getGetBreadCrumb(lastSelectedNodeUri);
              repositoryTree.backingBean.updateActionStatus();
              repositoryTree.backingBean.launchMissingResourceDialog(lastSelectedResource, 'resource');
              repositoryTree.backingBean.getResources(0);
              util.hideDialog('resource_property_dialog');
              util.elem('left_panel').style.overflow = 'auto';
              util.elem('right_panel').style.overflow = 'auto';
              removeOverlay(modalWinObj);
              return;
           }

        }


        util.hideDialog('resource_property_dialog');
        if (currentFocus == 'tree') {
           (util.elem('title'+lastSelectedNode.id)).innerHTML = labelProperty.replace(/</g, '&lt;');
           lastSelectedNode.name = labelProperty;
           // update breadcrumb
           repositoryTree.backingBean.getBreadCrumb(lastSelectedNodeUri);

        } else {
           // update resource row
           var updateName = util.elem(lastSelectedResource+'_name_value');
           var updateDesc = util.elem(lastSelectedResource+'_desc_value');
           updateName.innerHTML = labelProperty;
           updateDesc.innerHTML = descProperty;
           // update array to have the updated name

           var selectedResources = document.getElementsByName('resource_checkbox');
           for (var i=0; i<selectedResources.length; i++) {
              if (selectedResources[i].checked == true) {
                 currentResourceNameList[i] = labelProperty;
              }
           }

        }
        util.elem('left_panel').style.overflow = 'auto';
        util.elem('right_panel').style.overflow = 'auto';
        removeOverlay(modalWinObj);
    }

    ajaxTargettedUpdate(urlString, 'ajax_return_status', null, callbackForUpdateResourceProperties, baseErrorHandler);
}


RepositoryExplorer.prototype.popUpFolderMenu = function(event, node) {
    util.elem('resource_popup').style.display = 'none';
    currentFocus = 'tree';
    var nodetitle = document.getElementById('title' + lastSelectedNode.id);
    nodetitle.className = 'treetitleselectedfocused';
    util.elem('folder_popup').style.display='none';
    util.hideDialog('add_resource_drop_down_first_level');
    var newResourceButton = util.elem('new_resource_td_a');
    if (!!newResourceButton) {
       newResourceButton.className = 'normalpx';
    }
    util.hideDialog('add_resource_drop_down_second_level');
    ///node.selectNode();
    lastSelectedNodeUri = node.getParam().uri;
    if ((event.which == 3) || (event.button == 2)){
       var resourcePopUpDiv = util.elem('resource_popup');
       resourcePopUpDiv.style.display='none';
       var popUpDiv = util.elem('folder_popup');
       popUpDiv.style.top = event.clientY;
       popUpDiv.style.left = event.clientX;
       popUpDiv.style.display = 'block';
    }
    repositoryTree.backingBean.getGetBreadCrumb(lastSelectedNodeUri);
    repositoryTree.backingBean.updateActionStatus();
    blurSelectedResource();
}

RepositoryExplorer.prototype.deleteFolder = function() {
  var callbackForDeleteFolder = function() {

        util.hideDialog('delete_confirm_dialog');
        var returnStatus = ((util.elem('ajax_return_status')).innerHTML).replace(/\n/g, '');
        if (returnStatus.substr(0, 2) != 'OK') {
              // remove the node
              var rememberLastSelectedNodeUri = lastSelectedNodeUri;
              var parentUriArray = lastSelectedNodeUri.split("/");
              parentUriArray[parentUriArray.length-1] = '';
              var parentString = parentUriArray.join("/");
              if (parentString == "/") {
                 lastSelectedNodeUri = '/';
                 lastSelectedNode = lastSelectedNode.parent;
                 repositoryTree.backingBean.getGetBreadCrumb(lastSelectedNodeUri);
                 lastSelectedNode.handleNode();
                 lastSelectedNode.isloaded = false;
                 lastSelectedNode.handleNode();
                 lastSelectedNode.addNodeToSelected(false);
                 repositoryTree.backingBean.launchMissingResourceDialog(rememberLastSelectedNodeUri, 'folder');
                 removeOverlay(modalWinObj);
                 util.hideDialog('resource_property_dialog');
                 util.elem('left_panel').style.overflow = 'auto';
                 util.elem('right_panel').style.overflow = 'auto';
                 removeOverlay(modalWinObj);
                 return;
              }

              var panel = util.elem('left_panel');
              lastSelectedNodeUri = lastSelectedNode.parent.param.uri;
              lastSelectedNode = lastSelectedNode.parent;
              lastSelectedNode.handleNode();
              lastSelectedNode.isloaded = false;
              lastSelectedNode.handleNode();
              if (panel.treeSupport) {
                 panel.treeSupport.openAndSelectNode(parentString, RepositoryExplorer.getOnOpenAction(panel.treeSupport));
              }
              lastSelectedNodeUri = parentString;
              repositoryTree.backingBean.getGetBreadCrumb(lastSelectedNodeUri);
              repositoryTree.backingBean.updateActionStatus();
              repositoryTree.backingBean.launchMissingResourceDialog(rememberLastSelectedNodeUri, 'folder');
              util.hideDialog('resource_property_dialog');
              util.elem('left_panel').style.overflow = 'auto';
              util.elem('right_panel').style.overflow = 'auto';
              removeOverlay(modalWinObj);
              return;
        }



        var parentUriArray = toBeDeletedfolderUri.split("/");
        parentUriArray[parentUriArray.length-1] = '';
        var parentString = parentUriArray.join("/");
        if (parentString != "/") {
           parentString = parentString.substr(0, parentString.length-1);
        } else {
           //repositoryTree.showTreePrefetchNodes('left_panel', '/', null, this.ajaxErrorHandler);
           //var panel = util.elem('left_panel');
           //if (panel.treeSupport) {
           //  panel.treeSupport.openAndSelectNode(parentString);
           //}
           lastSelectedNodeUri = '/';
           lastSelectedNode = lastSelectedNode.parent;
           repositoryTree.backingBean.getGetBreadCrumb(lastSelectedNodeUri);
           lastSelectedNode.handleNode();
           lastSelectedNode.isloaded = false;
           lastSelectedNode.handleNode();
           lastSelectedNode.addNodeToSelected(false);
           removeOverlay(modalWinObj);
           return;
        }
        var panel = util.elem('left_panel');
        lastSelectedNodeUri = lastSelectedNode.parent.param.uri;
        lastSelectedNode = lastSelectedNode.parent;
        lastSelectedNode.handleNode();
        lastSelectedNode.isloaded = false;
        lastSelectedNode.handleNode();
        if (panel.treeSupport) {
           panel.treeSupport.openAndSelectNode(parentString, RepositoryExplorer.getOnOpenAction(panel.treeSupport));
        }
        lastSelectedNodeUri = parentString;
        repositoryTree.backingBean.getGetBreadCrumb(lastSelectedNodeUri);
        repositoryTree.backingBean.updateActionStatus();
        removeOverlay(modalWinObj);
  }
  var toBeDeletedfolderUri = lastSelectedNodeUri;
  var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=deleteFolder' + '&FolderUri=' + encodeURIComponent(encodeURIComponent(toBeDeletedfolderUri));
  ajaxTargettedUpdate(urlString, 'ajax_return_status', null, callbackForDeleteFolder, baseErrorHandler);
  util.hideDialog('delete_confirm_dialog');

}

RepositoryExplorer.prototype.gotoRolePermission = function() {
  location.href='flow.html?_flowId=objectPermissionToRoleFlow&resource=' + lastSelectedNodeUri + '&ParentFolderUri=' + lastSelectedNodeUri + '&curlnk=3';
}

RepositoryExplorer.prototype.resourceRolePermission = function() {
  location.href='flow.html?_flowId=objectPermissionToRoleFlow&resource=' + repositoryExplorer.getSelectedResource() + '&ParentFolderUri=' + lastSelectedNodeUri+ '&curlnk=3';
}



RepositoryExplorer.prototype.createReport= function() {
    location.href='flow.html?_flowId=reportUnitFlow&ParentFolderUri=' + lastSelectedNodeUri;
}

RepositoryExplorer.prototype.createImage= function() {
    location.href='flow.html?_flowId=fileResourceFlow&ParentFolderUri=' + lastSelectedNodeUri;
}

RepositoryExplorer.prototype.createDataSource= function() {
    location.href='flow.html?_flowId=reportDataSourceFlow&ParentFolderUri=' + lastSelectedNodeUri;
}


RepositoryExplorer.prototype.createSLDataSource= function() {
    location.href='flow.html?_flowId=createSLDatasourceFlow&ParentFolderUri=' + lastSelectedNodeUri;
}


RepositoryExplorer.prototype.gotoSchedulingReport = function(uri, type) {

    if (type == null) {
       if (repositoryExplorer.getSelectedType().indexOf('ReportUnit') != -1) {
          if (uri == null) {
             location.href='flow.html?_flowId=reportSchedulingFlow&reportUnitURI=' + lastSelectedResource+ '&ParentFolderUri=' + lastSelectedNodeUri;
          } else {
             location.href='flow.html?_flowId=reportSchedulingFlow&reportUnitURI=' + uri+ '&ParentFolderUri=' + lastSelectedNodeUri;
          }
       } else if (repositoryExplorer.getSelectedType().indexOf('ReportOption') != -1) {
          if (uri == null) {
             location.href='flow.html?_flowId=reportSchedulingFlow&reportOptionsURI=' + lastSelectedResource+ '&ParentFolderUri=' + lastSelectedNodeUri;
          } else {
             location.href='flow.html?_flowId=reportSchedulingFlow&reportOptionsURI=' + uri+  '&ParentFolderUri=' + lastSelectedNodeUri;
          }
       }
    } else {
       if (type == 'report') {
          if (uri == null) {
             location.href='flow.html?_flowId=reportSchedulingFlow&reportUnitURI=' + lastSelectedResource+ '&ParentFolderUri=' + lastSelectedNodeUri;
          } else {
             location.href='flow.html?_flowId=reportSchedulingFlow&reportUnitURI=' + uri+ '&ParentFolderUri=' + lastSelectedNodeUri;
          }
       } else if (type == 'report_option') {
          if (uri == null) {
             location.href='flow.html?_flowId=reportSchedulingFlow&reportOptionsURI=' + lastSelectedResource+ '&ParentFolderUri=' + lastSelectedNodeUri;
          } else {
             location.href='flow.html?_flowId=reportSchedulingFlow&reportOptionsURI=' + uri+  '&ParentFolderUri=' + lastSelectedNodeUri;
          }
       }
    }
}

RepositoryExplorer.prototype.createQuery= function() {
    location.href='flow.html?_flowId=queryFlow&ParentFolderUri=' + lastSelectedNodeUri;
}


RepositoryExplorer.prototype.createResourceBundle= function() {
    location.href='flow.html?_flowId=fileResourceFlow&ParentFolderUri=' + lastSelectedNodeUri;
}

RepositoryExplorer.prototype.createFont= function() {
    location.href='flow.html?_flowId=fileResourceFlow&ParentFolderUri=' + lastSelectedNodeUri;
}

RepositoryExplorer.prototype.createJRXMLFile= function() {
    location.href='flow.html?_flowId=fileResourceFlow&ParentFolderUri=' + lastSelectedNodeUri;
}

RepositoryExplorer.prototype.createJAR= function() {
    location.href='flow.html?_flowId=fileResourceFlow&ParentFolderUri=' + lastSelectedNodeUri;
}

RepositoryExplorer.prototype.createInputControl= function() {
    location.href='flow.html?_flowId=inputControlsFlow&ParentFolderUri=' + lastSelectedNodeUri;
}

RepositoryExplorer.prototype.createDataType= function() {
    location.href='flow.html?_flowId=dataTypeFlow&ParentFolderUri=' + lastSelectedNodeUri;
}

RepositoryExplorer.prototype.createListOfValues= function() {
    location.href='flow.html?_flowId=listOfValuesFlow&ParentFolderUri=' + lastSelectedNodeUri;
}

RepositoryExplorer.prototype.createAnalysisView= function() {
    location.href='flow.html?_flowId=olapUnitFlow&ParentFolderUri=' + lastSelectedNodeUri;
}

RepositoryExplorer.prototype.createOLAPClientConnection= function() {
    location.href='flow.html?_flowId=olapClientConnectionFlow&ParentFolderUri=' + lastSelectedNodeUri;
}

RepositoryExplorer.prototype.createOLAPSchema= function() {
    location.href='flow.html?_flowId=fileResourceFlow&ParentFolderUri=' + lastSelectedNodeUri;
}

RepositoryExplorer.prototype.createMondrianXMLASource= function() {
    location.href='flow.html?_flowId=mondrianXmlaSourceFlow&ParentFolderUri=' + lastSelectedNodeUri;
}

RepositoryExplorer.prototype.createAccessGrantSchema= function() {
    location.href='flow.html?_flowId=fileResourceFlow&ParentFolderUri=' + lastSelectedNodeUri;
}

RepositoryExplorer.prototype.gotoReportJob= function() {
    if (repositoryExplorer.getSelectedType().indexOf('ReportUnit') != -1) {
       location.href='flow.html?_flowId=reportJobFlow&isNewModeRequest=true&isRunNowModeRequest=true&reportUnitURIRequest=' +
                     lastSelectedResource + '&ParentFolderUri=' + lastSelectedNodeUri;
    } else if (repositoryExplorer.getSelectedType().indexOf('ReportOption') != -1) {
       location.href='flow.html?_flowId=reportJobFlow&isNewModeRequest=true&isRunNowModeRequest=true&reportOptionsURI=' +
                     lastSelectedResource +
                     //'&reportUnitURIRequest=' + repositoryTree.backingBean.findParent(lastSelectedResource) +
                      '&ParentFolderUri=' + lastSelectedNodeUri;
    }
}

RepositoryExplorer.prototype.findParent = function(optionUri) {
    for (var x in currentReportOptionList) {
        if (currentReportOptionList[x].indexOf(optionUri) != -1) {
           return x;
        }
    }
    return null;
}


RepositoryExplorer.prototype.editObject= function() {
    if (currentFocus == 'tree') {
       repositoryExplorer.editFolder();
    } else {
       for (var i=0; i<currentResourceList.length; i++) {
           var curItem = util.elem('checkbox_'+currentResourceList[i]);
           if (curItem.checked == true) {
              switch (currentResourceType[i]) {
                 case 'com.jaspersoft.jasperserver.api.metadata.jasperreports.domain.ReportUnit':
                   repositoryExplorer.editReportUnit();
                   break;
                 case 'com.jaspersoft.jasperserver.api.metadata.jasperreports.domain.JdbcReportDataSource':
                   repositoryExplorer.editJdbcReportDataSource();
                   break;
                 case 'com.jaspersoft.jasperserver.api.metadata.jasperreports.domain.JndiJdbcReportDataSource':
                   repositoryExplorer.editJNDIReportDataSource();
                   break;
                 case 'com.jaspersoft.jasperserver.api.metadata.jasperreports.domain.CustomReportDataSource':
                   repositoryExplorer.editCustomReportDataSource();
                   break;
                 case 'com.jaspersoft.jasperserver.api.metadata.common.domain.Query':
                   repositoryExplorer.editQuery();
                   break;
                 case 'com.jaspersoft.jasperserver.api.metadata.common.domain.InputControl':
                   repositoryExplorer.editInputControl();
                   break;
                 case 'com.jaspersoft.jasperserver.api.metadata.common.domain.ListOfValues':
                   repositoryExplorer.editLOV();
                   break;
                 case 'com.jaspersoft.jasperserver.api.metadata.common.domain.DataType':
                   repositoryExplorer.editDataType();
                   break;
                 case 'com.jaspersoft.jasperserver.api.metadata.common.domain.ContentResource':
                   // do nothing, no wizard exist
                   break;
                 case 'com.jaspersoft.jasperserver.api.metadata.olap.domain.OlapUnit':
                   repositoryExplorer.editOlapUnit();
                   break;
                 case 'com.jaspersoft.jasperserver.api.metadata.olap.domain.MondrianConnection':
                   repositoryExplorer.editMondrianConnection();
                   break;
                 case 'com.jaspersoft.ji.ja.security.domain.SecureMondrianConnection':
                   repositoryExplorer.editMondrianConnection();
                   break;
                 case 'com.jaspersoft.jasperserver.api.metadata.olap.domain.XMLAConnection':
                   repositoryExplorer.editXMLAConnection();
                   break;
                 case 'com.jaspersoft.jasperserver.api.metadata.olap.domain.MondrianXMLADefinition':
                   repositoryExplorer.editMondrianXMLADefinition();
                   break;
                 case 'com.jaspersoft.jasperserver.api.metadata.jasperreports.domain.BeanReportDataSource':
                   repositoryExplorer.editBeanReportDataSource();
                   break;
                 case 'com.jaspersoft.ji.adhoc.DashboardResource':
                   repositoryExplorer.editDashboard();
                   break;
                 case 'com.jaspersoft.ji.adhoc.AdhocReportUnit':
                   repositoryExplorer.editAdhocReport();
                   break;
                 case 'com.jaspersoft.ji.report.options.metadata.ReportOptions':
                   repositoryExplorer.editReportOption();
                   break;
                 case 'com.jaspersoft.jasperserver.api.metadata.common.domain.FileResource':
                   repositoryExplorer.editFileResource();
                   break;
                 case 'com.jaspersoft.commons.semantic.datasource.SemanticLayerDataSource':
                   repositoryExplorer.editSLDataSource();
                   break;
                 case 'com.jaspersoft.commons.semantic.DataDefinerUnit':
                   repositoryExplorer.editReportUnit();
                   break;
                 default:
                   break;
              }
              break;
           }
       }
    }
}




RepositoryExplorer.prototype.editFolder= function() {
    location.href='flow.html?_flowId=editFolderFlow&CurrentFolder='+lastSelectedNodeUri+'&isEdit=true&ParentFolderUri=' + lastSelectedNodeUri;
}

RepositoryExplorer.prototype.editReportUnit= function() {
    location.href='flow.html?_flowId=reportUnitFlow&selectedResource='+repositoryExplorer.getSelectedResource()+'&ParentFolderUri='+lastSelectedNodeUri;
}

RepositoryExplorer.prototype.editJdbcReportDataSource= function() {
    location.href='flow.html?_flowId=reportDataSourceFlow&resource='+repositoryExplorer.getSelectedResource()+'&ParentFolderUri='+lastSelectedNodeUri;
}

RepositoryExplorer.prototype.editJNDIReportDataSource= function() {
    location.href='flow.html?_flowId=reportDataSourceFlow&resource='+repositoryExplorer.getSelectedResource()+'&ParentFolderUri='+lastSelectedNodeUri;
}

RepositoryExplorer.prototype.editCustomReportDataSource= function() {
    location.href='flow.html?_flowId=reportDataSourceFlow&resource='+repositoryExplorer.getSelectedResource()+'&ParentFolderUri='+lastSelectedNodeUri;
}

RepositoryExplorer.prototype.editQuery= function() {
    location.href='flow.html?_flowId=queryFlow&currentQuery='+repositoryExplorer.getSelectedResource()+'&isEdit=true'+'&ParentFolderUri='+lastSelectedNodeUri;
}

RepositoryExplorer.prototype.editInputControl= function() {
    location.href='flow.html?_flowId=inputControlsFlow&resource='+repositoryExplorer.getSelectedResource()+'&ParentFolderUri='+lastSelectedNodeUri;
}


RepositoryExplorer.prototype.editLOV= function() {
    location.href='flow.html?_flowId=listOfValuesFlow&resource='+repositoryExplorer.getSelectedResource()+'&isEdit=edit'+'&ParentFolderUri='+lastSelectedNodeUri;
}

RepositoryExplorer.prototype.editDataType= function() {
    location.href='flow.html?_flowId=dataTypeFlow&resource='+repositoryExplorer.getSelectedResource()+'&isEdit=edit'+'&ParentFolderUri='+lastSelectedNodeUri;
}

RepositoryExplorer.prototype.editOlapUnit= function() {
    location.href='flow.html?_flowId=olapUnitFlow&resource='+repositoryExplorer.getSelectedResource()+'&isEdit=edit'+'&ParentFolderUri='+lastSelectedNodeUri;
}

RepositoryExplorer.prototype.editMondrianConnection= function() {
    location.href='flow.html?_flowId=olapClientConnectionFlow&selectedResource='+repositoryExplorer.getSelectedResource()+'&isEdit=edit&ParentFolderUri='+lastSelectedNodeUri;
}

RepositoryExplorer.prototype.editXMLAConnection= function() {
    location.href='flow.html?_flowId=olapClientConnectionFlow&selectedResource='+repositoryExplorer.getSelectedResource()+'&isEdit=edit&ParentFolderUri='+lastSelectedNodeUri;
}

RepositoryExplorer.prototype.editMondrianXMLADefinition= function() {
    location.href='flow.html?_flowId=mondrianXmlaSourceFlow&selectedResource='+repositoryExplorer.getSelectedResource()+'&isEdit=edit&ParentFolderUri='+lastSelectedNodeUri;
}

RepositoryExplorer.prototype.editBeanReportDataSource= function() {
    location.href='flow.html?_flowId=reportDataSourceFlow&resource='+repositoryExplorer.getSelectedResource()+'&ParentFolderUri='+lastSelectedNodeUri;
}


RepositoryExplorer.prototype.editFileResource= function() {
    location.href='flow.html?_flowId=fileResourceFlow&selectedResource='+repositoryExplorer.getSelectedResource()+'&ParentFolderUri='+lastSelectedNodeUri;
}


RepositoryExplorer.prototype.editSLDataSource= function() {
    location.href='flow.html?_flowId=createSLDatasourceFlow&uri=' + lastSelectedResource + '&ParentFolderUri=' + lastSelectedNodeUri;
}

RepositoryExplorer.prototype.editDataDefinerUnit= function() {
    location.href='flow.html?_flowId=queryBuilderFlow&uri=' + lastSelectedResource + '&ParentFolderUri=' + lastSelectedNodeUri;
}


RepositoryExplorer.prototype.editDashboard = function() {
    location.href='flow.html?_flowId=dashboardDesignerFlow&resource=' + repositoryExplorer.getSelectedResource() + '&createNew=true&ParentFolderUri='+lastSelectedNodeUri;
}

RepositoryExplorer.prototype.editAdhocReport = function() {
    location.href='flow.html?_flowId=reportUnitFlow&selectedResource='+repositoryExplorer.getSelectedResource()+'&ParentFolderUri='+lastSelectedNodeUri;
}

RepositoryExplorer.prototype.editReportOption = function() {
    location.href='flow.html?_flowId=reportOptionsEditFlow&reportOptionsURI='+repositoryExplorer.getSelectedResource()+'&ParentFolderUri='+lastSelectedNodeUri;
}



RepositoryExplorer.prototype.getAdhocReportEditor = function() {
    location.href='flow.html?_flowId=adhocFlow&resource=' + repositoryExplorer.getSelectedResource()+'&ParentFolderUri='+lastSelectedNodeUri;
}

RepositoryExplorer.prototype.designEditor = function() {
    var type = repositoryExplorer.getSelectedType();
    if (type == 'com.jaspersoft.ji.adhoc.AdhocReportUnit') {
       repositoryExplorer.getAdhocReportEditor();
    } else if (type == 'com.jaspersoft.ji.adhoc.DashboardResource') {
       repositoryExplorer.editDashboard();
    } else if (type == 'com.jaspersoft.commons.semantic.DataDefinerUnit') {
       repositoryExplorer.editDataDefinerUnit();
    }

}


RepositoryExplorer.prototype.onResourceRowRightClickMouseDown = function(event, objId) {

    var evt = event || window.event;
    if ((evt.which == 3) || (evt.button == 2)) {
       var tgt = evt.target || window.srcElement;
       var checkBoxElem = util.elem('checkbox_' + objId);
       if (checkBoxElem.checked == false) {
          repositoryTree.backingBean.cleanUpAllRows();
       }
       checkBoxElem.checked = true;
    }
    lastSelectedResource = objId;
}



RepositoryExplorer.prototype.checkDragAndDrop = function(event) {
    registerDragAndDrop(event);
}



RepositoryExplorer.prototype.bringUpResourcePopUpMenu = function(event) {

    var evt = event || window.event;
    currentFocus = 'resourceList';
    // change tree highlight color
    var nodetitle = document.getElementById('title' + lastSelectedNode.id);
    nodetitle.className = 'treetitleOutOfFocus';
    // change resource highlight color
    if (currentResourceType && (currentResourceType.length > 0)) {
       for (var i=0; i<currentResourceList.length; i++) {
           var curItem = util.elem('checkbox_'+currentResourceList[i]);
           if (curItem.checked == true) {
              var trItem = util.elem(currentResourceList[i]);
              trItem.className = 'list_selected';
           }
       }
    }
    util.elem('folder_popup').style.display = 'none';
//    repositoryTree.backingBean.updateActionStatus();
    util.elem('resource_popup').style.display='none';
    util.hideDialog('add_resource_drop_down_first_level');
    var newResourceButton = util.elem('new_resource_td_a');
    if (newResourceButton) {
       newResourceButton.className = 'normalpx';
    }
    util.hideDialog('add_resource_drop_down_second_level');
    var selectedResources = document.getElementsByName('resource_checkbox');

    for (var i=0; i<selectedResources.length; i++) {
        if (selectedResources[i].checked == true) {
           break;
        }
        if (i == (selectedResources.length-1)) {
           repositoryTree.backingBean.updateActionStatus();
           return;
        }
    }

    if (!currentResourceList) {
       repositoryTree.backingBean.updateActionStatus();
       return;
    }
    if (currentResourceList.length == 0) {
       repositoryTree.backingBean.updateActionStatus();
       return;
    }
    var onlyOneResource = repositoryTree.backingBean.atOnlyOneResourceSelected();
    if (onlyOneResource) {
       util.elem('resource_popup_header').innerHTML = util.elem('resource_header_string').innerHTML;
    } else {
       util.elem('resource_popup_header').innerHTML = util.elem('resource_header_strings').innerHTML;
    }

    if ((evt.which == 3) || (evt.button == 2)) {
       var folderPopUpDiv = util.elem('folder_popup');
       folderPopUpDiv.style.display = 'none';
       var popUpDiv = util.elem('resource_popup');
       if (evt.pageX || evt.pageY) {
          popUpDiv.style.top = evt.pageY;
          popUpDiv.style.left = evt.pageX;
       } else if (evt.clientX || evt.clientY) {
          popUpDiv.style.top = evt.clientY + document.body.scrollTop + document.documentElement.scrollTop;
          popUpDiv.style.left = evt.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
       }
       popUpDiv.style.display = 'block';
    }
    repositoryTree.backingBean.updateActionStatus();
}


RepositoryExplorer.prototype.launchDeleteResourceConfirm = function() {

    modalWinObj = renderHazeLayer(0, 0);
    var listDiv = util.elem('delete_msg_header_details');
    var listOfResources = '<ul>';

    if (currentResourceNameList.length > 0) {
       for (var i=0; i<currentResourceNameList.length; i++) {
           var curItem = util.elem('checkbox_'+currentResourceList[i]);
           if (curItem.checked == true) {
              listOfResources += '<li>' + currentResourceNameList[i] + '</li>'
           }
       }
    }

    listOfResources += '</ul>';

    listDiv.innerHTML = listOfResources;
    var deleteConfirmDiv = util.elem('delete_confirm_dialog');
    //util.elem('delete_yes_button').focus();
    deleteConfirmDiv.style.display = 'block';
    centerLayer(deleteConfirmDiv);

}

RepositoryExplorer.prototype.launchDelete = function() {

    util.hideDialog('add_resource_drop_down_first_level');
    var newResourceButton = util.elem('new_resource_td_a');
    if (newResourceButton) {
       newResourceButton.className = 'normalpx';
    }
    util.hideDialog('add_resource_drop_down_second_level');
    util.hideDialog('create_folder_dialog');
    util.hideDialog('resource_property_dialog');
    util.hideDialog('folder_popup');
    util.hideDialog('resource_popup');

    if (currentFocus == 'tree') {
       repositoryTree.backingBean.launchDeleteFolderConfirm();
    } else {
       repositoryTree.backingBean.launchDeleteResourceConfirm();
    }
}



RepositoryExplorer.prototype.launchDeleteFolderConfirm = function() {
    modalWinObj = renderHazeLayer(0, 0);
    var listDiv = util.elem('delete_msg_header_details');
    listDiv.innerHTML = '<ul><li>' + lastSelectedNode.name  + '</li><ul>';
    var deleteConfirmDiv = util.elem('delete_confirm_dialog');
    deleteConfirmDiv.style.display = 'block';
    util.elem('delete_yes_button').focus();
    centerLayer(deleteConfirmDiv);

}

RepositoryExplorer.prototype.deleteSelectedResources = function() {
    if (currentFocus == 'tree') {
       this.deleteFolder();
    } else {
       this.deleteResources();
    }

}


RepositoryExplorer.prototype.deleteResources = function() {
    var selectedResources = document.getElementsByName('resource_checkbox');
    var resources = '';
    for (var i=0; i<selectedResources.length; i++) {
        if (selectedResources[i].checked == true) {
           if (resources != '') {
              resources = resources + ',';
           }
           resources = resources + selectedResources[i].value;
        }
    }

    var callbackForDeleteResources = function() {
        lastSelectedResource = null;
        currentResourceList = new Array();
        currentResourceNameList = new Array();
        currentResourceType = new Array();
        currentResourceWritable = new Array();
        currentResourceDeletable = new Array();
        currentResourceTopOrOption = new Array();
        var returnStatus = ((util.elem('ajax_return_status')).innerHTML).replace(/\n/g, '');
        var callback = function() {
           util.executeScript('right_panel');
        }

        var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=getResources' + '&FolderUri=' + lastSelectedNodeUri;
        ajaxTargettedUpdate(urlString, 'right_panel', null, callback, baseErrorHandler);

        util.hideDialog('delete_confirm_dialog');
        if (returnStatus.substr(0, 5) == 'ERROR') {
           // prompt user what didn't get deleted
           repositoryTree.backingBean.launchDeleteErrorDialog(returnStatus);
        }
        removeOverlay(modalWinObj);
        repositoryTree.backingBean.updateActionStatus();

    }

    var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=deleteResources' + '&ResourceList=' + encodeURIComponent(encodeURIComponent(resources));
    ajaxTargettedUpdate(urlString, 'ajax_return_status', null, callbackForDeleteResources, baseErrorHandler);
}

RepositoryExplorer.prototype.launchDeleteErrorDialog = function(resourceList) {
    util.elem('delete_error_list').innerHTML =
    (util.elem('ajax_return_status').innerHTML.replace(/,/g, ' ')).substr(9) ;

    var deleteErrorDiv = util.elem('delete_resource_error_dialog');
    deleteErrorDiv.style.display = 'block';
    centerLayer(deleteErrorDiv);
}

RepositoryExplorer.prototype.launchDeleteFolderErrorDialog = function() {

    var deleteErrorDiv = util.elem('delete_resource_error_dialog');
    deleteErrorDiv.style.display = 'block';
    centerLayer(deleteErrorDiv);
}



RepositoryExplorer.prototype.isOnlyOneReportSelected = function() {

    var count = 0;
    if (currentResourceType && (currentResourceType.length > 0)) {
       for (var i=0; i<currentResourceList.length; i++) {
           var curItem = util.elem('checkbox_'+currentResourceList[i]);
           if (curItem.checked == true) {
              if ((currentResourceType[i].indexOf('ReportUnit') != -1) || (currentResourceType[i].indexOf('ReportOption') != -1)) {
                 count++;
              }
           }
       }
    }
    if (count == 1) {
       return true;
    } else {
       return false;
    }
}

RepositoryExplorer.prototype.atOnlyOneResourceSelected = function() {

    var count = 0;
    if (currentResourceList) {
       for (var i=0; i<currentResourceList.length; i++) {
           var curItem = util.elem('checkbox_'+currentResourceList[i]);
           if (curItem.checked == true) {
              count++;
           }
       }
    }
    if (count == 1) {
       return true;
    } else {
       return false;
    }
}


RepositoryExplorer.prototype.isOnlyOneAdhocOrDashboardOrDataDefinerSelected = function() {

    if (currentResourceList) {
       for (var i=0; i<currentResourceList.length; i++) {
           var curItem = util.elem('checkbox_'+currentResourceList[i]);
           if (curItem.checked == true) {
              if ((currentResourceType[i] == 'com.jaspersoft.ji.adhoc.DashboardResource') ||
                  (currentResourceType[i] == 'com.jaspersoft.ji.adhoc.AdhocReportUnit') || 
                  (currentResourceType[i] == 'com.jaspersoft.commons.semantic.DataDefinerUnit')) {
                 return true;
              }
           }
       }
    }
    return false;
}


RepositoryExplorer.prototype.moreThanOrEqualToOneResourceSelected = function() {

    var count = 0;
    if (currentResourceList) {
       for (var i=0; i<currentResourceList.length; i++) {
           var curItem = util.elem('checkbox_'+currentResourceList[i]);
           if (curItem.checked == true) {
              count++;
           }
       }
    }
    if (count >= 1) {
       return true;
    } else {
       return false;
    }
}


RepositoryExplorer.prototype.atLeastOneResourceNotDeletable = function() {

    for (var i=0; i<currentResourceDeletable.length; i++) {
        var curItem = util.elem('checkbox_'+currentResourceList[i]);
        if (curItem.checked == true) {
           if (currentResourceDeletable[i] == 'false') {
              return true;
           }
        }
    }
    return false;
}

RepositoryExplorer.prototype.isSameParentFolder = function() {

    if (clipBoard == '') {
       return false;
    }

    var firstResource = clipBoard.split(",")[0];

    // take care of root parent node
    if (lastSelectedNodeUri == '/') {
       if (firstResource.lastIndexOf("/") == 0) {
          return true;
       }
    } else {
       if (firstResource.substr(0, Math.max(firstResource.lastIndexOf("/"), 1)) == lastSelectedNodeUri) {
          return true;
       }
    }
    return false;
}


RepositoryExplorer.prototype.atLeastOneResourceNotWritable = function() {
    for (var i=0; i<currentResourceWritable.length; i++) {
        var curItem = util.elem('checkbox_'+currentResourceList[i]);
        if (curItem.checked == true) {
           if (currentResourceWritable[i] == 'false') {
              return true;
           }
        }
    }
    return false;
}



RepositoryExplorer.prototype.getReportOptions = function() {
    if (js_edition == 'PRO') {
       // get list of report options
    }
}


RepositoryExplorer.prototype.moveUri = function() {

     // unpress move button
     if (moveOrCopy == 'move') {
        clipBoard = '';
        moveOrCopy = '';
        objectPerformed = '';
        util.hideDialog("folder_popup");
        util.hideDialog("resource_popup");
        var moveButtonStatus = util.elem('move_resource_td_a');
        moveButtonStatus.className = 'normalpx';
        util.elem('repository_explorer_div').className = 'default';
        repositoryTree.backingBean.updateActionStatus();
        util.elem('move_resource').title = util.elem('move_string').innerHTML;
        return;
     }
     util.elem('move_resource').title = util.elem('cancel_move_string').innerHTML;
     util.elem('repository_explorer_div').className = 'move_cursor';
     document.body.className = 'move_cursor';
     moveOrCopy = 'move';
     repositoryTree.backingBean.markClipBoard();
     if (currentFocus == 'tree') {
        objectPerformed = 'tree';
     } else {
        objectPerformed = 'resource';
     }
     util.hideDialog("folder_popup");
     util.hideDialog("resource_popup");
     var moveButtonStatus = util.elem('move_resource_td_a');
     moveButtonStatus.className = 'normalpx_pressed';
     repositoryTree.backingBean.updateActionStatus();

}

RepositoryExplorer.prototype.copyUri = function() {
     // unpress move button
     if (moveOrCopy == 'copy') {
        clipBoard = '';
        moveOrCopy = '';
        objectPerformed = '';
        util.hideDialog("folder_popup");
        util.hideDialog("resource_popup");
        var copyButtonStatus = util.elem('copy_resource_td_a');
        copyButtonStatus.className = 'normalpx';
        util.elem('repository_explorer_div').className = 'default';
        repositoryTree.backingBean.updateActionStatus();
        util.elem('copy_resource').title = util.elem('copy_string').innerHTML;
        return;
     }
     util.elem('copy_resource').title = util.elem('cancel_copy_string').innerHTML;
     util.elem('repository_explorer_div').className = 'copy_cursor';
     moveOrCopy = 'copy';
     repositoryTree.backingBean.markClipBoard();
     if (currentFocus == 'tree') {
        objectPerformed = 'tree';
     } else {
        objectPerformed = 'resource';
     }
     util.hideDialog("folder_popup");
     util.hideDialog("resource_popup");
     var copyButtonStatus = util.elem('copy_resource_td_a');
     copyButtonStatus.className = 'normalpx_pressed';
     repositoryTree.backingBean.updateActionStatus();
}


RepositoryExplorer.prototype.markClipBoard = function() {
    clipBoard = '';
    clipBoardDisplayName = '';
    if (currentFocus == 'tree') {
       clipBoard = lastSelectedNodeUri;
       clipBoardDisplayName = lastSelectedNode.param.id;
    } else { // resource
       if (currentResourceType.length > 0) {
          for (var i=0; i<currentResourceList.length; i++) {
              var curItem = util.elem('checkbox_'+currentResourceList[i]);
              if (curItem.checked == true) {
                 if (clipBoard == '') {
                    if ((moveOrCopy == 'move') && (currentResourceType[i] == 'com.jaspersoft.ji.report.options.metadata.ReportOptions')) {
                    } else {
                       clipBoard = currentResourceList[i];
                       clipBoardDisplayName = currentResourceNameList[i];
                    }
                 } else {
                    if ((moveOrCopy == 'move') && (currentResourceType[i] == 'com.jaspersoft.ji.report.options.metadata.ReportOptions')) {
                    } else {
                       clipBoard = clipBoard + ',' + currentResourceList[i];
                       clipBoardDisplayName = clipBoardDisplayName + ',' + currentResourceNameList[i];
                    }
                 }
              }
          }
       }
    }
}


RepositoryExplorer.prototype.launchDragAndDropPasteConfirmDialog = function(ctrlPressed) {

    if (util.elem('repoOptions').innerHTML.toLowerCase().indexOf('true') == -1) {
       moveCopyConfirmOK(ctrlPressed);
       return;
    }



    var uriListCallback = function() {
        var friendlyUriList = new Array();
        friendlyUriList = eval("(" + util.elem('ajax_return_status').innerHTML.replace(/&amp;/g, '&').replace(/&gt;/g, '>') + ")");

        util.elem('folder_popup').style.display = 'none';
        modalWinObj = renderHazeLayer(0, 0);
        var copyHeaderDiv = util.elem('paste_msg_header_copy');
        var moveHeaderDiv = util.elem('paste_msg_header_move');
        if (!ctrlPressed) {
           copyHeaderDiv.style.display = 'none';
           moveHeaderDiv.style.display = '';
        } else {
           copyHeaderDiv.style.display = '';
           moveHeaderDiv.style.display = 'none';
        }

        var newParentFolder = util.elem('paste_new_directory');
        newParentFolder.innerHTML = friendlyUriList['0'];

        var listDiv = util.elem('paste_msg_header_details');
        var listOfResources = '<ul>';

        if (objectPerformed == 'tree') {
           listOfResources = '<BR><li>' + friendlyUriList['1'] + '</li><BR>'
        } else {
           var i = 1;
           while (friendlyUriList[''+i]) {
               listOfResources += '<li>' + friendlyUriList[''+i] + '</li>';
               i++;
           }

        }

        listOfResources += '</ul>';

        listDiv.innerHTML = listOfResources;
        var pasteConfirmDiv = util.elem('paste_confirm_dialog');
        pasteConfirmDiv.style.display = 'block';
        centerLayer(pasteConfirmDiv);
    }

    var type = null;
    if (objectPerformed == 'tree') {
        type = 'folder';
    } else {
        type = 'resource';
    }
    if (!repositoryTree.draggedOverNode) {
       singleOrMultipleItems=null;
       currentDragIcon=null;
       moveOrCopy = '';
       objectPerformed = '';
       clipBoard = '';
       return;
    }
    var urlString ='flow.html?_flowId=repositoryExplorerFlow&method=getUriDisplayLabelList' + '&uriList=' + encodeURIComponent(encodeURIComponent(repositoryTree.draggedOverNode.param.uri)) + ',' + encodeURIComponent(encodeURIComponent(clipBoard)) + '&type=' + type;
    ajaxTargettedUpdate(urlString, 'ajax_return_status', null, uriListCallback, baseErrorHandler);


}



RepositoryExplorer.prototype.launchPasteConfirmDialog = function(ctrlPressed) {

    var uriListCallback = function() {
        var friendlyUriList = new Array();
        friendlyUriList = eval("(" + util.elem('ajax_return_status').innerHTML.replace(/&amp;/g, '&').replace(/&gt;/g, '>') + ")");

        util.elem('folder_popup').style.display = 'none';
        modalWinObj = renderHazeLayer(0, 0);
        var copyHeaderDiv = util.elem('paste_msg_header_copy');
        var moveHeaderDiv = util.elem('paste_msg_header_move');
        if (moveOrCopy == 'move') {
           copyHeaderDiv.style.display = 'none';
           moveHeaderDiv.style.display = '';
        } else {
           copyHeaderDiv.style.display = '';
           moveHeaderDiv.style.display = 'none';
        }

        var newParentFolder = util.elem('paste_new_directory');
        newParentFolder.innerHTML = friendlyUriList['0'];

        var listDiv = util.elem('paste_msg_header_details');
        var listOfResources = '<ul>';

        if (objectPerformed == 'tree') {
           listOfResources = '<BR><li>' + friendlyUriList['1'] + '</li><BR>'
        } else {
           var i = 1;
           while (friendlyUriList[''+i]) {
               listOfResources += '<li>' + friendlyUriList[''+i] + '</li>';
               i++;
           }

        }

        listOfResources += '</ul>';

        listDiv.innerHTML = listOfResources;
        var pasteConfirmDiv = util.elem('paste_confirm_dialog');
        pasteConfirmDiv.style.display = 'block';
        centerLayer(pasteConfirmDiv);
    }

    var type = null;
    if (objectPerformed == 'tree') {
        type = 'folder';
    } else {
        type = 'resource';
    }
    var urlString ='flow.html?_flowId=repositoryExplorerFlow&method=getUriDisplayLabelList' + '&uriList=' + encodeURIComponent(encodeURIComponent(lastSelectedNodeUri)) + ',' + encodeURIComponent(encodeURIComponent(clipBoard)) + '&type=' + type;
    ajaxTargettedUpdate(urlString, 'ajax_return_status', null, uriListCallback, baseErrorHandler);


}





RepositoryExplorer.prototype.pasteUri = function() {

   var getNodeCallBack = function() {
        // addChild, render tree, and then select
        var returnStatus = util.elem('treeNodeText').innerHTML;
        var n = window.eval('(' + returnStatus + ')');
        var newNode = repositoryTree.processNode(n);
        lastSelectedNode.addChild(newNode);
        lastSelectedNode.haschilds = true;
        repositoryTree.tree.resetSelected();
        repositoryTree.renderTree('left_panel');
        var rememberLastNode = lastSelectedNode;
        rememberLastNode.addNodeToSelected();
        lastSelectedNode = rememberLastNode;
        lastSelectedNodeUri = lastSelectedNode.getParam().uri
        util.elem('ajax_return_status').innerHTML = '';
        clipBoard = '';
        moveOrCopy = '';
        objectPerformed = '';
        repositoryTree.backingBean.updateActionStatus();
    }


    var folderCallback = function() {
       var returnResults = window.eval('(' + util.elem('ajax_return_status').innerHTML + ')');
       if (returnResults.status == 'SUCCESS') {
        // if success...

        if (objectPerformed == 'tree') {
           // if it's "move", remove the old one from the tree
           if (moveOrCopy == 'move') {
              var newParentNode = lastSelectedNode;
              // remove from the old position
              var oldNodeParent = repositoryTree.findLastLoadedNode(clipBoard).parent;
              var toBeRemovedNode = repositoryTree.findNodeChildByMetaName(oldNodeParent, clipBoardDisplayName);

              if (trees['Repository_Explorer'].getState(oldNodeParent.id) == 'open') {
                 oldNodeParent.removeChild(toBeRemovedNode);
                 oldNodeParent.refreshNode();
              } else {
                 oldNodeParent.isloaded = false;
                 oldNodeParent.handleNode();
              }
           }

           // update the newly modified parent
           var state = trees['Repository_Explorer'].getState(lastSelectedNode.getID());
           if (state == 'open') {
              var lastNodeUri;
              if (lastSelectedNodeUri == '/') {
                 lastNodeUri = '';
              } else {
                 lastNodeUri = lastSelectedNodeUri;
              }
              var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=getNode' +
                              '&provider=repositoryExplorerTreeFoldersProvider' + '&uri=' +
                              returnResults.id;
              ajaxTargettedUpdate(urlString, 'ajax_return_status', null, getNodeCallBack, baseErrorHandler);

           } else {
              lastSelectedNode.isloaded = false;
              lastSelectedNode.handleNode();
              clipBoard = '';
              moveOrCopy = '';
              objectPerformed = '';
              repositoryTree.backingBean.updateActionStatus();
           }

        } else {
           // refresh right_panel
           currentResourceList = new Array();
           currentResourceNameList = new Array();
           currentResourceType = new Array();
           currentResourceWritable = new Array();
           currentResourceDeletable = new Array();
           currentResourceTopOrOption = new Array();
           // retrieving list of resources here given a folder, excluding folders
           var callback = function() {
              util.executeScript('right_panel');
              clipBoard = '';
              moveOrCopy = '';
              objectPerformed = '';
              repositoryTree.backingBean.updateActionStatus();
           }

           var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=getResources' + '&FolderUri=' + lastSelectedNodeUri;
           ajaxTargettedUpdate(urlString, 'right_panel', null, callback, baseErrorHandler);
           repositoryTree.backingBean.updateActionStatus();
        }
       } else {
          var moveCopyErrorDiv = util.elem('move_or_copy_error_dialog');
          if (moveOrCopy == 'copy') {
             util.elem('rm_error_move').style.display = 'none';
             util.elem('rm_error_copy').style.display = '';
          } else if (moveOrCopy == 'move') {
             util.elem('rm_error_move').style.display = '';
             util.elem('rm_error_copy').style.display = 'none';
          }
          modalWinObj = renderHazeLayer(0, 0);
          centerLayer(moveCopyErrorDiv);
          moveCopyErrorDiv.style.display = 'block';
       }
    }

    var resourceCallback = function() {
        clipBoard = '';
        moveOrCopy = '';
        objectPerformed = '';
        repositoryTree.backingBean.updateActionStatus();
    }

    if (objectPerformed == 'tree') {
       var urlString = null;
       if (moveOrCopy == 'copy') {
          urlString ='flow.html?_flowId=repositoryExplorerFlow&method=copyFolder' + '&sourceUri=' + clipBoard +
                     '&destUri=' + lastSelectedNodeUri;
       } else {
          urlString ='flow.html?_flowId=repositoryExplorerFlow&method=moveFolder' + '&sourceUri=' + clipBoard +
                     '&destUri=' + lastSelectedNodeUri;
       }
       ajaxTargettedUpdate(urlString, 'ajax_return_status', null, folderCallback, baseErrorHandler);
    } else {
       var urlString = null;
       if (moveOrCopy == 'copy') {
          urlString ='flow.html?_flowId=repositoryExplorerFlow&method=copyResource' + '&sourceUri=' + clipBoard +
                     '&destUri=' + lastSelectedNodeUri;
       } else {
          urlString ='flow.html?_flowId=repositoryExplorerFlow&method=moveResource' + '&sourceUri=' + clipBoard +
                     '&destUri=' + lastSelectedNodeUri;
       }
       ajaxTargettedUpdate(urlString, 'ajax_return_status', null, folderCallback, baseErrorHandler);
    }
    util.elem('repository_explorer_div').className = 'normal_cursor';
    var copyButtonStatus = util.elem('copy_resource_td_a');
    copyButtonStatus.className = 'normalpx';
    var moveButtonStatus = util.elem('move_resource_td_a');
    moveButtonStatus.className = 'normalpx';
    util.elem('copy_resource').title = util.elem('copy_string').innerHTML;
    util.elem('move_resource').title = util.elem('move_string').innerHTML;

}


function getLaunchNewFolderDialogFunc() {
    repositoryTree.backingBean.launchNewFolderDialog();
}


function getGotoSchedulingReport() {
    util.hideDialog("folder_popup");
    util.hideDialog("resource_popup");
    repositoryExplorer.gotoSchedulingReport();
}


function getGotoReportJob() {
    repositoryExplorer.gotoReportJob();
}


function getGotoProperties() {
    repositoryExplorer.launchProperties();
}


function gotoLaunchProperties() {
    util.hideDialog("folder_popup");
    util.hideDialog('resource_popup');
    repositoryExplorer.launchProperties();
}

function getLaunchDeleteFolderConfirm() {
    util.hideDialog("folder_popup");
    util.hideDialog("resource_popup");
    repositoryExplorer.launchDeleteFolderConfirm();
}

function getShowNewPropertyDropMenu(event) {
    util.hideDialog("folder_popup");
    util.hideDialog("resource_popup");
    repositoryExplorer.showNewPropertyDropMenu(event);
}

function getGotoRolePermission() {
    repositoryExplorer.gotoRolePermission();
}


RepositoryExplorer.prototype.changeActionPropertiesStatus = function(id, buttonStatus, folderMenuStatus, resourceMenuStatus) {
    if (buttonStatus) {
       var tdObj = util.elem(actionStatus[id].id+'_td');
       var img = util.elem(actionStatus[id].id);
       if (img) {
          img.src = actionStatus[id].enabledIcon;
          //img.title = actionStatus[id].name;
          img.className = 'normalpx';
          tdObj.style.cursor="pointer"
       }

    } else {
       var tdObj = util.elem(actionStatus[id].id+'_td');
       var img = util.elem(actionStatus[id].id);
       if (img) {
          img.src = actionStatus[id].disabledIcon;
          //img.title = '';
          img.className = "";
          tdObj.style.cursor="default"
       }
    }

    if (actionStatus[id].folderMenuId != null) {
       if (folderMenuStatus) {
          var folderMenu = util.elem(actionStatus[id].folderMenuId);
          if (folderMenu) {
             folderMenu.style.cursor="pointer"
          }
       } else {
          var folderMenu = util.elem(actionStatus[id].folderMenuId);
          if (folderMenu) {
             folderMenu.style.cursor="default"
          }
       }
    }
    if (actionStatus[id].resourceMenuId != null) {
       if (resourceMenuStatus) {
          var resourceMenu = util.elem(actionStatus[id].resourceMenuId);
          if (resourceMenu) {
             resourceMenu.style.cursor="pointer"
          }
       } else {
          var resourceMenu = util.elem(actionStatus[id].resourceMenuId);
          if (resourceMenu) {
             resourceMenu.style.cursor="default"
          }
       }
    }

}

function actionProperties(name, id, enabledIcon ,disabledIcon, folderMenuId, resourceMenuId) {
    this.name = name;
    this.id = id;
    this.enabledIcon = enabledIcon;
    this.disabledIcon = disabledIcon;
    this.folderMenuId = folderMenuId;
    this.resourceMenuId = resourceMenuId;
}

function onKeyPressAction(evt) {

      var keyCode  = (window.event) ? event.keyCode : evt.keyCode;
      var Esc = (window.event) ?  27 : evt.DOM_VK_ESCAPE
      if(keyCode == Esc) {
         util.hideDialog('create_folder_dialog');
         util.hideDialog('resource_property_dialog');
         util.hideDialog('delete_confirm_dialog');
         util.hideDialog('folder_popup');
         util.hideDialog('resource_popup');
         util.hideDialog('add_resource_drop_down_first_level');
         util.hideDialog('paste_confirm_dialog');
         util.hideDialog('dnd_single_resource');
         util.hideDialog('dnd_multiple_resources');
         util.hideDialog('dnd_single_folder');
         if (repositoryTree.draggingObject) {
           repositoryTree.draggingObject.style.display = 'none';
         }
         var newResourceButton = util.elem('new_resource_td_a');
         if (newResourceButton) {
            newResourceButton.className = 'normalpx';
         }
         util.hideDialog('add_resource_drop_down_second_level');
         util.elem('repository_explorer_div').className = 'normal_cursor';
         clipBoard = '';
         moveOrCopy = '';
         objectPerformed = '';
         singleOrMultipleItems = null;
         currentDragIcon=null;
         repositoryTree.draggedOverNode = null;
         var moveButtonStatus = util.elem('move_resource_td_a');
         moveButtonStatus.className = 'normalpx';
         var copyButtonStatus = util.elem('copy_resource_td_a');
         copyButtonStatus.className = 'normalpx';
         repositoryTree.backingBean.updateActionStatus();
         util.elem('move_resource').title = util.elem('move_string').innerHTML;
         util.elem('copy_resource').title = util.elem('copy_string').innerHTML;
         if (modalWinObj) {
            removeOverlay(modalWinObj);
         }

      }

}

function blurSelectedResource() {

    if (currentResourceType.length > 0) {
       for (var i=0; i<currentResourceList.length; i++) {
           var curItem = util.elem('checkbox_'+currentResourceList[i]);
           if (curItem.checked == true) {
              var trItem = util.elem(currentResourceList[i]);
              trItem.className = 'list_selected_out_of_focus';
           }
       }
    }

}

function setRepositoryCookie(cookieName, cookieValue, nHr) {

     var today = new Date();
     var expire = new Date();
     if (nHr==null) {
         nHr=1;
     }
     expire.setTime(today.getTime() + 3600000*nHr);
     document.cookie = cookieName + "=" + escape(cookieValue) + ";expires=" + expire.toGMTString();

}


function getRepositoryCookie(cookieName)
{

     if (document.cookie.length>0) {
        c_start=document.cookie.indexOf(cookieName + "=");
        if (c_start!=-1) {
           c_start=c_start + cookieName.length+1;
           c_end=document.cookie.indexOf(";",c_start);
           if (c_end==-1) {
              c_end=document.cookie.length;
           }
           return unescape(document.cookie.substring(c_start,c_end));
        }
     }

     return "null";
}

RepositoryExplorer.getOnOpenAction = function(treeSupport) {
    return function() {
        var node = treeSupport.tree.getSelectedNode();
        if (node) {
            treeSupport.backingBean.repositoryExplorerHandler(null, node);
        }
    };
}

function expandToggleReportOptions(currentId) {

      var listOfOptions = currentReportOptionList[currentId].split(",");
      if (listOfOptions.length > 0) {
         var firstOption = util.elem(listOfOptions[0]);
         if (firstOption.style.display == 'none') {
            for (var i=0; i<listOfOptions.length;i++) {
                var curItem = document.getElementById(listOfOptions[i]);
                curItem.style.display = '';
                var curImg = document.getElementById(currentId + '_toggle');
                curImg.src = 'images/collapse.gif';
            }
         } else {
            for (var i=0; i<listOfOptions.length;i++) {
                var curItem = document.getElementById(listOfOptions[i]);
                curItem.style.display = 'none';
                var curImg = document.getElementById(currentId + '_toggle');
                curImg.src = 'images/expand.gif';
            }
         }
      }

}

function backToNormalState() {

      util.elem('repository_explorer_div').className = 'normal_cursor';
      clipBoard = '';
      moveOrCopy = '';
      objectPerformed = '';
      var moveButtonStatus = util.elem('move_resource_td_a');
      moveButtonStatus.className = 'normalpx';
      var copyButtonStatus = util.elem('copy_resource_td_a');
      copyButtonStatus.className = 'normalpx';
      repositoryTree.backingBean.updateActionStatus();
}

function moveCopyConfirmOK(ctrlPressed) {
    if (isRunningDragging) {
       folderAndResourceDraggingFinishedAction(!ctrlPressed);
    } else {
       repositoryExplorer.pasteUri();
       util.hideDialog('paste_confirm_dialog');
       util.hideDialog('folder_popup');
       util.hideDialog('resource_popup');
       if (modalWinObj) {
          removeOverlay(modalWinObj);
       }
    }
    isRunningDragging = false;
    singleOrMultipleItems = null;
}


function moveCopyConfirmCancel() {
       clipBoard = '';
       moveOrCopy = '';
       objectPerformed = '';
       singleOrMultipleItems = null;
       currentDragIcon=null;
       repositoryTree.draggedOverNode = null;
       util.hideDialog('paste_confirm_dialog');
       util.hideDialog('folder_popup');
       util.hideDialog('resource_popup');
       util.elem('repository_explorer_div').className = 'normal_cursor';
       backToNormalState();
       if (modalWinObj) {
          removeOverlay(modalWinObj);
       }
       isRunningDragging = false;
       singleOrMultipleItems = null;
}



