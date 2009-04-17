var folderDragging = false;
var folderDraggingEvent = null;
var isRunningDragging = false;
var currentCtrlPressed = false; 

document.body.onmouseup = function() {
   var ghostDiv = util.elem('dnd_single_resource');
   ghostDiv.style.display = 'none';   
   ghostDiv = util.elem('dnd_multiple_resources'); 
   ghostDiv.style.display = 'none'; 

}

function registerDragAndDrop(event) {
   
   dragListener.registerAgent("dnd_single_resource");
   dragListener.publishEvent("dnd_single_resource", DragListener.DRAGGING_STARTED, resourceDraggingStarted);
   dragListener.publishEvent("dnd_single_resource", DragListener.DRAGGING, resourceDragging);
   dragListener.publishEvent("dnd_single_resource", DragListener.DRAGGING_FINISHED, folderAndResourceDraggingFinished);  
   dragListener.publishEvent("dnd_single_resource", repositoryTree.DRAGGED_OVER_FOLDER_EVENT, draggedOnFolderNode);  
   dragListener.publishEvent("dnd_single_resource", repositoryTree.DRAGGED_OFF_FOLDER_EVENT, draggedOffFolderNode);    
   
   
   var evt = event || Window.event;
   dragListener.setCurrentAgentName('dnd_single_resource');
   new Dragger(event, util.elem('dnd_single_resource'), true, true, 3, dragListener);

}

function resourceDraggingStarted(event) {
 
   folderDragging = false;
   folderDraggingEvent = false;
   isRunningDragging = true;
   objectPerformed = 'resource'; 
   
   var evt = event || window.event;


   if (repositoryTree.backingBean.moreThanOrEqualToOneResourceSelected()) {
      repositoryTree.backingBean.markClipBoard();
      if (repositoryTree.backingBean.atOnlyOneResourceSelected()) {
         singleOrMultipleItems = 'single';
         // single resource icon
         var singleDiv = util.elem('dnd_single_resource'); 
         singleDiv.style.position = "absolute";
         singleDiv.style.top = evt.clientY + 3;
         singleDiv.style.left = evt.clientX + 3; 
         singleDiv.style.display = 'block';  
      } else {
         // double resource icon
         singleOrMultipleItems = 'multiple';
         // single resource icon
         var multipleDiv = util.elem('dnd_multiple_resources'); 
         multipleDiv.style.position = "absolute";
         multipleDiv.style.top = evt.clientY + 3;
         multipleDiv.style.left = evt.clientX + 3; 
         multipleDiv.style.display = 'block';        
      }
   } else {
      util.elem('repository_explorer_div').className = 'default';
      return;
   }
   
      // change mouse pointer
   if (evt.ctrlKey) {
      util.elem('repository_explorer_div').className = 'copy_cursor';
   } else {
      util.elem('repository_explorer_div').className = 'move_cursor';
   }
   
}

function resourceDragging(event) {

   var evt = event || window.event;

   
   if (singleOrMultipleItems != null) {
      if (singleOrMultipleItems == 'single') {
         if (evt.ctrlKey || (!repositoryTree.draggedOverNode) || repositoryTree.draggedOverNode.param.extra.isWritable && ((objectPerformed == 'tree') || (!repositoryTree.backingBean.atLeastOneResourceNotDeletable()))) {
            var ghostDiv = null;
            if (currentDragIcon == null) {
               ghostDiv = util.elem('dnd_single_resource'); 
            } else {
               ghostDiv = currentDragIcon;
            }
            ghostDiv.style.position = 'absolute';
            ghostDiv.style.top = evt.clientY + 3 + 'px';
            ghostDiv.style.left = evt.clientX + 3 + 'px';   
            ghostDiv.style.display = 'block';          
         } else {
            var ghostDiv = util.elem('dnd_not_allowed'); 
            ghostDiv.style.position = 'absolute';
            ghostDiv.style.top = evt.clientY + 3 + 'px';
            ghostDiv.style.left = evt.clientX + 3 + 'px';   
            ghostDiv.style.display = 'block';  
            util.elem('dnd_single_resource').style.display = 'none';
            util.elem('dnd_multiple_resources').style.display = 'none';
         }
      } else {
         // double resource icon
         if (evt.ctrlKey || (!repositoryTree.draggedOverNode) || repositoryTree.draggedOverNode.param.extra.isWritable && ((objectPerformed == 'tree') || (!repositoryTree.backingBean.atLeastOneResourceNotDeletable()))) {
            var ghostDiv = null;
            if (currentDragIcon == null) {
               ghostDiv = util.elem('dnd_multiple_resources'); 
            } else {
               ghostDiv = currentDragIcon;
            }        
            ghostDiv.style.position = 'absolute';
            ghostDiv.style.top = evt.clientY + 3 + 'px';
            ghostDiv.style.left = evt.clientX + 3 + 'px';   
            ghostDiv.style.display = 'block';        
         } else {
            var ghostDiv = util.elem('dnd_not_allowed'); 
            ghostDiv.style.position = 'absolute';
            ghostDiv.style.top = evt.clientY + 3 + 'px';
            ghostDiv.style.left = evt.clientX + 3 + 'px';   
            ghostDiv.style.display = 'block';  
            util.elem('dnd_single_resource').style.display = 'none';
            util.elem('dnd_multiple_resources').style.display = 'none';        
         }
      }
   } else {
      if (util.elem('repository_explorer_div').className != 'default') {
         util.elem('repository_explorer_div').className = 'default';
      }
      if (clipBoard == '') {
         util.elem('dnd_single_resource').style.display = 'none';
         util.elem('dnd_multiple_resources').style.display = 'none';
         util.elem('dnd_single_folder').style.display = 'none';
         util.elem('dnd_not_allowed').style.display = 'none';
      }
      return;
   }
   
   
   if (evt.ctrlKey) {
      if (util.elem('repository_explorer_div').className != 'copy_cursor') {
         util.elem('repository_explorer_div').className = 'copy_cursor';      
      }
   } else {
      if (util.elem('repository_explorer_div').className != 'move_cursor') {
         util.elem('repository_explorer_div').className = 'move_cursor';  
      }
   }
   
   // take care after esc key is pressed
   if (clipBoard == '') {
      util.elem('dnd_single_resource').style.display = 'none';
      util.elem('dnd_multiple_resources').style.display = 'none';
      util.elem('dnd_single_folder').style.display = 'none';
      util.elem('dnd_not_allowed').style.display = 'none';
   }

}


function resourceDraggingFinished(event) {
 
 //alert('resourceDraggingFinished');
 
      var evt = event || window.event;
      var ghostDiv = util.elem('dnd_single_resource');
      ghostDiv.style.display = 'none';   
      ghostDiv = util.elem('dnd_multiple_resources'); 
      ghostDiv.style.display = 'none';      
}


function folderDraggingStarted(event, node) {
  
   objectPerformed = 'tree'; 
   isRunningDragging = true;
   // change mouse pointer
   var evt = event || window.event;
   if (evt.ctrlKey) {
      util.elem('repository_explorer_div').className = 'copy_cursor';
   } else {
      util.elem('repository_explorer_div').className = 'move_cursor';
   }
   repositoryTree.setTranslucent(event, repositoryTree.draggingObject);
   folderDragging = true;
   folderDraggingEvent = event || window.event;
   repositoryTree.backingBean.markClipBoard();
   if (repositoryTree.draggingObject) {
      repositoryTree.draggingObject.getElementsByTagName('td')[1].innerHTML = '';
   }
}

function treeFolderDragging(event, node) {
   var evt = event || window.event;
   if (evt.ctrlKey) {
      if (util.elem('repository_explorer_div').className != 'copy_cursor') {
         util.elem('repository_explorer_div').className = 'copy_cursor';      
      }
   } else {
      if (util.elem('repository_explorer_div').className != 'move_cursor') {
         util.elem('repository_explorer_div').className = 'move_cursor';  
      }
   }
}

function folderAndResourceDraggingFinished(event) {
    var evt = event || window.event;
    if (lastSelectedNode != repositoryTree.draggedOverNode) {
       unhightlightTreeRow();
    }
    util.elem('repository_explorer_div').className = 'default'; 
    var ghostDiv = util.elem('dnd_single_resource');
    ghostDiv.style.display = 'none';   
    ghostDiv = util.elem('dnd_multiple_resources'); 
    ghostDiv.style.display = 'none'; 
    ghostDiv = util.elem('dnd_not_allowed');
    ghostDiv.style.display = 'none';
    
    if (clipBoard == '') {
       singleOrMultipleItems=null;
       currentDragIcon=null;
       moveOrCopy = '';
       objectPerformed = ''; 
       return;    
    }
    if ((util.elem('repoOptions').innerHTML.toLowerCase().indexOf('true') != -1) && (passPermissionAndRuleTest(currentCtrlPressed))) {
       currentCtrlPressed = evt.ctrlKey;
       repositoryTree.backingBean.launchDragAndDropPasteConfirmDialog(evt.ctrlKey);
       return;
    }
    folderAndResourceDraggingFinishedAction(event);
}


function folderAndResourceDraggingFinishedAction(ctrlPressed) {
 


    if ((!repositoryTree.draggedOverNode) || (!passPermissionAndRuleTest(currentCtrlPressed))) {
       var ghostDiv = util.elem('dnd_single_resource');
       ghostDiv.style.display = 'none';   
       ghostDiv = util.elem('dnd_multiple_resources'); 
       ghostDiv.style.display = 'none'; 
       ghostDiv = util.elem('dnd_not_allowed');
       ghostDiv.style.display = 'none';
       singleOrMultipleItems=null;
       currentDragIcon=null;
       clipBoard = '';
       moveOrCopy = '';
       objectPerformed = ''; 
       return;
    }


    if (folderDragging == false) {
       if (currentCtrlPressed) {
       
          var folderCallback = function() {
              clipBoard = '';
              moveOrCopy = '';
              objectPerformed = ''; 
              // remove highlight
              var nodetitle = document.getElementById('title' + repositoryTree.draggedOverNode.id);
              nodetitle.className = 'treetitle';
              var returnResults = window.eval('(' + util.elem('ajax_return_status').innerHTML + ')');
              if (returnResults.status != 'SUCCESS') {     
                 var moveCopyErrorDiv = util.elem('move_or_copy_error_dialog'); 
                 util.elem('rm_error_move').style.display = 'none';
                 util.elem('rm_error_copy').style.display = '';
                 modalWinObj = renderHazeLayer(0, 0);
                 centerLayer(moveCopyErrorDiv);
                 moveCopyErrorDiv.style.display = 'block'; 
              }         
              
          }      
          var urlString ='flow.html?_flowId=repositoryExplorerFlow&method=copyResource' + '&sourceUri=' + encodeURIComponent(encodeURIComponent(clipBoard)) + 
                         '&destUri=' + encodeURIComponent(encodeURIComponent(repositoryTree.draggedOverNode.param.uri));
                
          ajaxTargettedUpdate(urlString, 'ajax_return_status', null, folderCallback, baseErrorHandler);   
          
       } else {
        
          var folderCallback = function() {
              clipBoard = '';
              moveOrCopy = '';
              objectPerformed = ''; 
              
              var returnResults = window.eval('(' + util.elem('ajax_return_status').innerHTML + ')');
              if (returnResults.status != 'SUCCESS') {     
                 var moveCopyErrorDiv = util.elem('move_or_copy_error_dialog'); 
                 util.elem('rm_error_move').style.display = 'none';
                 util.elem('rm_error_copy').style.display = '';
                 modalWinObj = renderHazeLayer(0, 0);
                 centerLayer(moveCopyErrorDiv);
                 moveCopyErrorDiv.style.display = 'block'; 
              } else {

                 if (currentCtrlPressed) {
                 } else {
                    //alert('resource drag finished pure!'); 
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
     
                    var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=getResources' + '&FolderUri=' + encodeURIComponent(encodeURIComponent(lastSelectedNodeUri));
                    ajaxTargettedUpdate(urlString, 'right_panel', null, callback, baseErrorHandler);
                 }   
                 repositoryTree.backingBean.updateActionStatus();   
              
                 } 
          }               
          var urlString ='flow.html?_flowId=repositoryExplorerFlow&method=moveResource' + '&sourceUri=' + encodeURIComponent(encodeURIComponent(clipBoard)) + 
                         '&destUri=' + encodeURIComponent(encodeURIComponent(repositoryTree.draggedOverNode.param.uri));
                
          ajaxTargettedUpdate(urlString, 'ajax_return_status', null, folderCallback, baseErrorHandler); 
      
       }
   } else if ((folderDragging == true) && (clipBoard != '')) {
      folderDragging = false;
      folderDraggingEvent = false;
      //alert(clipBoard);
      //alert(node.name);
       if (currentCtrlPressed) {
          var folderCallback = function() {
              // create new clone node
              var returnResults = window.eval('(' + util.elem('ajax_return_status').innerHTML + ')');
              if (returnResults.status == 'SUCCESS') { 

                 var state = trees['Repository_Explorer'].getState(repositoryTree.draggedOverNode.id);
                 if (state == 'open') {
                    var getNodeCallBack = function() {
                       // addChild, render tree, and then select
                       var returnStatus = util.elem('treeNodeText').innerHTML;
                       var n = window.eval('(' + returnStatus + ')');
                       var newNode = repositoryTree.processNode(n);
                       repositoryTree.draggedOverNode.addChild(newNode);  
                       repositoryTree.draggedOverNode.haschilds = true;
                       repositoryTree.tree.resetSelected();
                       repositoryTree.renderTree('left_panel'); 
                       var rememberLastNode = lastSelectedNode;
                       rememberLastNode.addNodeToSelected(false);
                       lastSelectedNode = rememberLastNode;
                       lastSelectedNodeUri = lastSelectedNode.getParam().uri
                       util.elem('treeNodeText').innerHTML = '';   
                       clipBoard = '';
                       moveOrCopy = '';
                       objectPerformed = '';     
                       repositoryTree.backingBean.getBreadCrumb(lastSelectedNodeUri);     
                       repositoryTree.backingBean.updateActionStatus();  
                    }
          
          
                    var lastNodeUri;
                    if ((lastSelectedNodeUri == '/') || (repositoryTree.draggedOverNode.param.uri == '/')) {
                       lastNodeUri = '';
                    } else {
                       lastNodeUri = repositoryTree.draggedOverNode.param.uri;
                    }
                    var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=getNode' + '&provider=repositoryExplorerTreeFoldersProvider' + '&uri=' + returnResults.id;
                    ajaxTargettedUpdate(urlString, 'ajax_return_status', null, getNodeCallBack, baseErrorHandler);
      
                  } else {
                    repositoryTree.draggedOverNode.isloaded = false;
                    repositoryTree.draggedOverNode.handleNode();  
                    clipBoard = '';
                    moveOrCopy = '';
                    objectPerformed = '';       
                  }   
               } else {
                  var moveCopyErrorDiv = util.elem('move_or_copy_error_dialog'); 
                  util.elem('rm_error_move').style.display = 'none';
                  util.elem('rm_error_copy').style.display = '';
                  modalWinObj = renderHazeLayer(0, 0);
                  centerLayer(moveCopyErrorDiv);
                  moveCopyErrorDiv.style.display = 'block';               
               
               }    
          }      
          var urlString ='flow.html?_flowId=repositoryExplorerFlow&method=copyFolder' + '&sourceUri=' + clipBoard + 
                         '&destUri=' + repositoryTree.draggedOverNode.param.uri;
                
          ajaxTargettedUpdate(urlString, 'ajax_return_status', null, folderCallback, baseErrorHandler);   
       } else {
          var folderCallback = function() {
              var returnResults = window.eval('(' + util.elem('ajax_return_status').innerHTML + ')');
              if (returnResults.status == 'SUCCESS') { 
              
              
                 // create new clone node
                 var state = trees['Repository_Explorer'].getState(repositoryTree.draggedOverNode.id);               
                 if (state == 'open') {
                    var getNodeCallBack = function() {
                       // addChild, render tree, and then select
                       var returnStatus = util.elem('treeNodeText').innerHTML;
                       var n = window.eval('(' + returnStatus + ')');
                       var newNode = repositoryTree.processNode(n);
                       repositoryTree.draggedOverNode.addChild(newNode);  
                       repositoryTree.draggedOverNode.haschilds = true;
                       repositoryTree.tree.resetSelected();
                       repositoryTree.renderTree('left_panel'); 
                       var rememberLastNode = lastSelectedNode;
                       rememberLastNode.addNodeToSelected(false);
                       lastSelectedNode = rememberLastNode;
                       lastSelectedNodeUri = lastSelectedNode.getParam().uri
                       util.elem('treeNodeText').innerHTML = '';   
                       clipBoard = '';
                       moveOrCopy = '';
                       objectPerformed = '';       
                       // remove old node
                       var parentNode = lastSelectedNode.getParent();
                       repositoryTree.tree.resetSelected();
                       parentNode.removeChild(lastSelectedNode);
                       parentNode.refreshNode();
                       lastSelectedNode = newNode;
                       lastSelectedNodeUri = newNode.param.uri; 
                       newNode.addNodeToSelected(true); 
                       repositoryTree.backingBean.getBreadCrumb(lastSelectedNodeUri);   
                       repositoryTree.backingBean.updateActionStatus();                
                    }
          
          
                    var lastNodeUri;
                    if ((lastSelectedNodeUri == '/') || (repositoryTree.draggedOverNode.param.uri == '/')) {
                       lastNodeUri = '';
                    } else {
                       lastNodeUri = repositoryTree.draggedOverNode.param.uri;

                    }
                    var urlString = 'flow.html?_flowId=repositoryExplorerFlow&method=getNode' + '&provider=repositoryExplorerTreeFoldersProvider' + '&uri=' + lastNodeUri + '/' + clipBoard.substr(clipBoard.lastIndexOf('/')+1); 
                    ajaxTargettedUpdate(urlString, 'ajax_return_status', null, getNodeCallBack, baseErrorHandler);    
                  } else {
                    repositoryTree.draggedOverNode.isloaded = false;
                    repositoryTree.draggedOverNode.handleNode();  
                    clipBoard = '';
                    moveOrCopy = '';
                    objectPerformed = '';
                    // remove old node
                    var parentNode = lastSelectedNode.getParent();
                    parentNode.handleNode();
                    parentNode.isloaded = false;
                    parentNode.handleNode();  
                    lastSelectedNode = parentNode;
                    lastSelectedNodeUri = parentNode.param.uri;  
                    lastSelectedNode.addNodeToSelected(true); 
                    repositoryTree.backingBean.getBreadCrumb(lastSelectedNodeUri);   
                    repositoryTree.backingBean.updateActionStatus();  
                  }            

               } else {
                    var moveCopyErrorDiv = util.elem('move_or_copy_error_dialog'); 
                    util.elem('rm_error_move').style.display = 'none';
                    util.elem('rm_error_copy').style.display = '';
                    modalWinObj = renderHazeLayer(0, 0);
                    centerLayer(moveCopyErrorDiv);
                    moveCopyErrorDiv.style.display = 'block';               
               
               }
             
          }     
          var urlString ='flow.html?_flowId=repositoryExplorerFlow&method=moveFolder' + '&sourceUri=' + encodeURIComponent(encodeURIComponent(clipBoard)) + 
                         '&destUri=' + encodeURIComponent(encodeURIComponent(repositoryTree.draggedOverNode.param.uri));
                
          ajaxTargettedUpdate(urlString, 'ajax_return_status', null, folderCallback, baseErrorHandler);      
       }      
      
   }

   folderDraggingEvent = null;
   folderDragging = false;
   isRunningDragging = false;
   currentCtrlPressed = false;
   //clipBoard = '';
   moveOrCopy = '';
   objectPerformed = '';
   singleOrMultipleItems = null;
   currentDragIcon=null;
   //repositoryTree.draggedOverNode = null;
   util.hideDialog('paste_confirm_dialog');
   if (modalWinObj) {
      removeOverlay(modalWinObj);
   }
}



function draggedOnFolderNode(event) {
    var evt = event || window.event;
    
    
    if (!folderDragging) {
       if (repositoryTree.draggingObject) {
          repositoryTree.draggingObject.style.display = 'none';
       }
    }
    if (!passPermissionAndRuleTest(evt)) {
       currentDragIcon = util.elem('dnd_not_allowed');
       if (repositoryTree.draggingObject) {
          if (repositoryTree.draggingObject.getElementsByTagName('img')[0].src != 'images/no_drop.gif') {
             repositoryTree.draggingObject.getElementsByTagName('img')[0].src = 'images/no_drop.gif';
          }
       }

       var ghostDiv = util.elem('dnd_single_resource');
       ghostDiv.style.display = 'none';   
       ghostDiv = util.elem('dnd_multiple_resources'); 
       ghostDiv.style.display = 'none'; 
    } else {
       if (singleOrMultipleItems == 'single') {
          currentDragIcon = util.elem('dnd_single_resource');
       } if (singleOrMultipleItems == 'multiple') {
          currentDragIcon = util.elem('dnd_multiple_resources');
       } if (singleOrMultipleItems == null) {
         // folder dragging
         var ghostDiv = util.elem('dnd_not_allowed'); 
         ghostDiv.style.display = 'none'; 
         currentDragIcon = util.elem('dnd_single_folder');
         if (repositoryTree.draggingObject) {
            if (repositoryTree.draggingObject.getElementsByTagName('img')[0].src != 'images/drag_folder.gif') {
               repositoryTree.draggingObject.getElementsByTagName('img')[0].src = 'images/drag_folder.gif';
            }
         }
       }
     
    }
    if (lastSelectedNode != repositoryTree.draggedOverNode) {
       highlightTreeRow();
    }
}

function draggedOffFolderNode(event) {
    
    var ghostDiv = util.elem('dnd_not_allowed');
    ghostDiv.style.display = 'none'; 
    currentDragIcon = null;   
    if (lastSelectedNode != repositoryTree.draggedOverNode) {
       unhightlightTreeRow();
    }
    //if (util.elem('treeDragIcon')) {
    //   util.elem('treeDragIcon').src = 'images/drag_folder.gif';
    //}
    
}


function highlightTreeRow() {
    if ((repositoryTree.draggedOverNode) && (clipBoard != '')) {
        var nodeDiv = document.getElementById("title" + repositoryTree.draggedOverNode.id);
        nodeDiv.className = 'treetitle list_selected_out_of_focus_for_folder';
    }
}


function unhightlightTreeRow() {

    if(repositoryTree.draggedOverNode) {
        var nodeDiv = document.getElementById("title" + repositoryTree.draggedOverNode.id);
        if (nodeDiv) {
           nodeDiv.className = 'treetitle';
        }
    }
}

function passPermissionAndRuleTest(ctrlPressed) {

    var evt = folderDraggingEvent || window.event;



    // not writable
    if (repositoryTree.draggedOverNode) {
       if (!repositoryTree.draggedOverNode.param.extra.isWritable) {
          return false;
       }
    }
    
    // not to the same parent
    if (singleOrMultipleItems == null) {
       // for folder
       if (lastSelectedNode.getParent() == repositoryTree.draggedOverNode) {
          return false;
       }
       if (repositoryTree.draggedOverNode) {
          if (lastSelectedNode.param.uri == repositoryTree.draggedOverNode.param.uri) {
             return false;
          }
       }
    } else {
       // for resource(s)
       if (lastSelectedNode == repositoryTree.draggedOverNode) {
          return false;
       }
       
    }
 

    // not allow to copy or move the root
    if (folderDraggingEvent) {
       if (lastSelectedNodeUri == '/') {
          return false;
       }   
    }

    
    // can't move to below children for move
    if (folderDraggingEvent && (!folderDraggingEvent.ctrlKey)) {
       if (repositoryTree.draggedOverNode && (repositoryTree.draggedOverNode.param.uri.length > lastSelectedNodeUri.length)) {
          if ((repositoryTree.draggedOverNode.param.uri.substr(0, lastSelectedNodeUri.length+1)) == (lastSelectedNodeUri + '/')) {
             return false;
          }
       }
    }
    
    // can't move a non-movable object
    if (repositoryTree.draggingObject && repositoryTree.draggingObject.referencedNodes[0]) {
       if (!repositoryTree.draggingObject.referencedNodes[0].param.extra.isWritable && (!folderDraggingEvent.ctrlKey)) {
          return false;
       }
    }
 
 


    return true;
}

