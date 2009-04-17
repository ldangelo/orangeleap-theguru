/**
 * TreeSupport is a convenient wrapper for Tree to use it with JasperServer.
 * You can extend it to change parameters and/or look and feel
 * @param {String} treeName unique name for the tree on the page
 * @param {String} providerId Tree Data Provider id
 * @param {String} rootUri uri for the root of this tree
 *   (usually '/' but could be something like '/area/node' if this tree is supposed
 *   to show only particular branch from the data structure)
 * @param {Function} treeErrorHandlerFn optional function to be called if error occurs
 * @param {Function} treeDragSupport - needed to make dragging from or to tree work (see below for API)
 */



/////////////////////////////
// Constructor
/////////////////////////////

function TreeSupport(treeName, providerId, rootUri, treeErrorHandlerFn, showRoot, dragSupport) {

    // Constants
    //possible values for showLines
    this.WHEN_FOLDERS_VISIBLE = 'whenFoldersVisible';
    this.ALWAYS = 'always';
    this.NEVER = 'never';

    this.NODE_DRAGGING_INDICATOR = 'nodeDraggingIndicator';
    this.NODE_DRAGGING_INDICATOR_TEXT = 'nodeDraggingIndicatorText';

    // instance variables
    this.treeName = treeName;
    this.providerId = providerId;
    this.rootUri = rootUri;
    this.treeErrorHandlerFn = treeErrorHandlerFn;

    this.tree = null;
    this.inInit = true;

    //if you want selection zone to span entire tree width, explicitly set this to true
    this.selectionSpansTreeWidth = false; //default

    //default
    this.showLines = this.ALWAYS;

    // default types
    // used to separate folders from leaves
    // if TreeSupport extended, could be used to assign different icons based on type
    this.Types = {
      folderType: 'com.jaspersoft.jasperserver.api.metadata.common.domain.Folder'
    };

    // default icons
    this.closedGif = 'images/treeimages/folder_closed.gif';
    this.openGif = 'images/treeimages/folder_open.gif';
    this.pageIcon = 'images/treeimages/page16x16.gif';
    this.userIcon = 'images/treeimages/user_16x16.gif';
    this.helpIcon = 'images/treeimages/help_16x16.gif';

    this.waitIcon = 'images/spinner_moz.gif';

    // default ajax related values
    this.ajaxBufferId = 'ajaxbuffer'; // id of a DIV elements that receives server response
    this.nodeTextId = 'treeNodeText'; // id of a text element that contains JSONized tree
    this.urlGetNode = 'flow.html?_flowId=treeFlow&method=getNode&test=true'; // server url for 'getNode' method
    this.urlGetChildren = 'flow.html?_flowId=treeFlow&method=getChildren&test=true'; // server url for 'getChildren' method
    this.urlGetMessage = 'flow.html?_flowId=treeFlow&method=getMessage&test=true'; // server url for 'getChildren' method

    // click event hooks
    this.onNodeClick = null; // assign your function(treeNode, event) if you need to overwrite the default behaviour
    this.onNodeDoubleClick = null; // assign your function(treeNode, event) if you need to overwrite the default behaviour

    // multiselect
    this.multiSelectEnabled = false;



    /////////////////////////////////////
    // dragging related variables
    // (if you require drag support, please pass treeDragSupport argument in ctor and include drag.js)
    /////////////////////////////////////

    //(see DragListener in drag.js)

    //this dragging agent
    this.DEFAULT_DRAG_AGENT_NAME="tree";

    //standard drag events that act on a tree - to be registered by third party drag agents
    this.DRAGGED_OVER_FOLDER_EVENT="overFolder";
    this.DRAGGED_OVER_LEAF_EVENT="overLeaf";
    this.DRAGGED_OFF_FOLDER_EVENT="offFolder";
    this.DRAGGED_OFF_LEAF_EVENT="offLeaf";

    this.dragSupport=dragSupport;
    this.dragger=null;
    this.draggingObject=null;
    this.draggedOverNode=null;

    this.dragSignificantMoveThreshold = 3; //default

    this.nodeOverlays = new Array();

    //////////////////////////////////////
    // HTML templates
    //////////////////////////////////////


    this.NODE_DRAGGING_TEMPLATE =
        '<table>' +
            '<tr>' +
                '<td><img id="treeDragIcon" style="vertical-align:middle"></td>' +
                '<td></td>' +
            '</tr>' +
        '</table>';

    /////////////////////////////////////
    // methods
    /////////////////////////////////////

    /**
     * Loads tree from server and renders it into given container.
     * Calls user callback at the end.
     * depth controls how many levels of children to prefetch at this load
     * @type Asynchronous method
     * @param {String} containerId
     * @param {Number} depth
     * @param {Function} userCallbackFn
     * @param {Function} errorCallbackFn
     */
    this.showTree = function (containerId, depth, userCallbackFn, errorCallbackFn) {
        var url = this.urlGetNode + '&provider=' + providerId + '&uri=' + rootUri + '&depth=' + depth;
        this._showTree(containerId, url, userCallbackFn, errorCallbackFn);
    }

    /**
     * Loads tree from the server and renders it into given container.
     * Calls user callback at the end.
     * prefetchedListStr controls which tree branches to prefetch at this load
     * @type Asynchronous method
     * @param {String} containerId DOM id for container element where to render a tree
     * @param {String} prefetchedListStr comma separated uris to prefetch (example: '/reports/samples,/adhoc/topics')
     * @param {Function} userCallbackFn optional user function object to call after tree gets loaded and rendered
     * @param {Function} errorCallbackFn optional user error handler function to call if error occured
     */
    this.showTreePrefetchNodes = function (containerId, prefetchedListStr, userCallbackFn, errorCallbackFn) {
        var url = this.urlGetNode + '&provider=' + providerId + '&uri=' + rootUri;
        if (prefetchedListStr) {
            url += '&prefetch=' + prefetchedListStr;
        }
        this._showTree(containerId, url, userCallbackFn, errorCallbackFn);
    }

    this._showTree = function (containerId, url, userCallbackFn, errorCallbackFn) {

        this.inInit = true;

        if (!rootUri) {
            rootUri = '/';
        }

        var callback = function(obj, ci, uc, ec) {
            return function() {
                return obj.showTreeCallback(ci, uc, ec);
            }
        }(this, containerId, userCallbackFn, errorCallbackFn);

        ajaxTargettedUpdate(
            url,
            this.ajaxBufferId,
            null,
            callback
        );

        var div = document.getElementById(containerId);
        div.innerHTML = '<img src="' + this.waitIcon + '">';

    }

    this.showTreeCallback = function (containerId, userCallbackFn, errorCallbackFn) {

        // get JSONized Node
        var div = document.getElementById(this.nodeTextId);
        if (div == null) {
            if (errorCallbackFn) {
                errorCallbackFn();
            }
            return;
        }

        var rootObj = window.eval('(' + div.innerHTML.replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>') + ')');

        // clean AJAX buffer
        div = document.getElementById(this.ajaxBufferId);
        div.innerHTML = '';

        // build the tree
        var root = this.processNode(rootObj);

        if (this.showLines == this.WHEN_FOLDERS_VISIBLE) {
            this.showLines = this.hasVisibleFolders(rootObj);
        } else {
            this.showLines = this.ALWAYS;
        }

        this.tree = new Tree(this.treeName, root, this.providerId, 'images/tree', showRoot, this.selectionSpansTreeWidth, this.showLines);
        this.tree.resortTree();
        this.tree.resetStates();
        if (this.onNodeClick) {
            this.tree.onNodeClick = this.onNodeClick;
        }
        if (this.onNodeDoubleClick) {
            this.tree.onNodeDoubleClick = this.onNodeDoubleClick;
        }
        this.tree.multiSelectEnabled = this.multiSelectEnabled;

        div = document.getElementById(containerId);
        var ary = trees[this.treeName].renderTree();
        div.innerHTML = '';
        div.appendChild(ary[0]);
        div.appendChild(ary[1]);

        this.inInit = false;

        if (userCallbackFn) {
            userCallbackFn();
        }
    }

    /**
     * Renders tree into a given container
     * @param {Object} containerId DOM id for a container to render tree to
     */
    this.renderTree = function (containerId) {
        div = document.getElementById(containerId);
        var ary = trees[this.treeName].renderTree();
        div.innerHTML = '';
        div.appendChild(ary[0]);
        div.appendChild(ary[1]);
        this.flushNodeOverlays();
    }

    /**
     * internally used method to turn server model into javascript tree model
     * Be advised of the power of 'extra' property of server node object.
     * You can set there pretty much anything and therefore customize you tree behaviour.
     * TreeNode is available in node handlers which you may assign as callback functions to your code
     * @param {Object} metaNode server node
     */
    this.processNode = function (metaNode) {
        var param = {};
        param.id = metaNode.id;
        param.type = metaNode.type;
        param.uri = metaNode.uri;
        param.fontStyle = metaNode.fontStyle;
        param.fontWeight = metaNode.fontWeight;
        param.fontColor = metaNode.fontColor;
        param.extra = metaNode.extra;

        var localRoot = new TreeNode(metaNode.label, this.getIconForNode(metaNode), param, metaNode.order);
        localRoot.setHandler(this.getHandlerForNode(metaNode));
        localRoot.setHandlerWhenIconSelected(this.getHandlerForNodeIcon(metaNode));
        localRoot.setMouseDownHandler(this.getMouseDownHandlerForNode(metaNode));
        localRoot.setMouseUpHandler(this.getMouseUpHandlerForNode(metaNode));
        localRoot.setDragHandler(this.getDragHandlerForNode(this,metaNode));
        localRoot.setMouseOverHandler(this.getMouseOverHandlerForNode(this,metaNode));
        localRoot.setMouseOutHandler(this.getMouseOutHandlerForNode(this,metaNode));
        localRoot.setHasChilds(this.isFolderMetaNode(metaNode));
        localRoot.setStartEditHandler(this.getStartEditHandlerForNode(metaNode));
        localRoot.setEndEditHandler(this.getEndEditHandlerForNode(metaNode));

        localRoot.setIcon2(this.getSecondIconForNode(localRoot));
        if (metaNode.tooltip) {
            localRoot.setTooltip(metaNode.tooltip);
        }
        localRoot.setIconTooltip(this.getIconTooltip(localRoot));

        localRoot.addOpenEventListener(
            function(obj) {
                return function(nodeId) {
                    obj.openNodeHandler(nodeId);
                }
            } (this)
        );

        var ch = metaNode.children;
        if (ch != null) {
            var len = ch.length;
            if (len == 0) {
                localRoot.setHasChilds(false);
            } else {
                for (var i = 0; i < len; i++) {
                    var chNodeObj = ch[i];
                    var chTreeNode = this.processNode(chNodeObj);
                    localRoot.addChild(chTreeNode);
                }
            }
            localRoot.setIsLoaded(true);
        }
        return localRoot;
    }


    /**
     * Returns folder icon for folders, page icon for leaves.
     * It is a good candidate to be overwritten to customize icons based on a node type
     * @param {Object} node TreeNode instance
     */
    this.getIconForNode = function (node) {
        if (node.type == this.Types.folderType) {
            return new Array(this.closedGif,this.openGif);
        } else {
            return this.pageIcon;
        }
    }

    this.getIconTooltip = function(node) {
        return null;
    }

    /**
     * Defalut implementation. Overwrite to show the second icon
     */
    this.getSecondIconForNode = function(node) {
        return null;
    }

    this.openNodeHandler = function (nodeId){
        var node = nodes[nodeId];
        if (node && !node.isLoaded()) {
            this.getTreeNodeChildren(node, null, this.treeErrorHandlerFn);
        }
    }

    this.getHandlerForNode = function (node) {
        if (this.isFolderMetaNode(node)) {
            return this.treeFolderHandler;
        } else {
            return this.treeLeafHandler;
        }
    }

    this.getHandlerForNodeIcon = function (node) {
        if (this.isFolderMetaNode(node)) {
            return this.treeFolderHandlerWhenIconSelected;
        } else {
            return this.treeLeafHandlerWhenIconSelected;
        }
    }

    this.getMouseDownHandlerForNode = function (node) {
        if (this.isFolderMetaNode(node)) {
            return this.treeFolderMouseDownHandler;
        } else {
            return this.treeLeafMouseDownHandler;
        }
    }

    this.getMouseUpHandlerForNode = function (node) {
        if (this.isFolderMetaNode(node)) {
            return this.treeFolderMouseUpHandler;
        } else {
            return this.treeLeafMouseUpHandler;
        }
    }

    this.getStartEditHandlerForNode = function (node) {
        if (this.isFolderMetaNode(node)) {
            return this.startEditFolderHandler;
        } else {
            return this.startEditLeafHandler;
        }
    }

    this.getEndEditHandlerForNode = function (node) {
        if (this.isFolderMetaNode(node)) {
            return this.endEditFolderHandler;
        } else {
            return this.endEditLeafHandler;
        }
    }

    this.isFolderMetaNode = function (node) {
        return (node.type == this.Types.folderType);
    }

    /**
     * Default empty handler for a folder
     * @param {Object} node TreeNode instance clicked
     */
    this.treeFolderHandler = function (evt,node) {
    }

    /**
     * Default empty handler for a leaf
     * @param {Object} node TreeNode instance clicked
     */
    this.treeLeafHandler = function (evt,node) {
    }

    /**
     * Default handler for a folder icon - same as node
     * @param {Object} node TreeNode instance clicked
     */
    this.treeFolderHandlerWhenIconSelected = function (evt,node) {
        return this.treeFolderHandler;
    }

    /**
     * Default handler for a leaf icon - same as node
     * @param {Object} node TreeNode instance clicked
     */
    this.treeLeafHandlerWhenIconSelected = function (evt,node) {
        return this.treeLeafHandler;
    }

    /**
     * Default empty handler for a folder on mousedown
     * @param {Object} node TreeNode instance mousedowned upon
     */
    this.treeFolderMouseDownHandler = function (evt,node) {
    }

    /**
     * Default empty handler for a leaf on mousedown
     * @param {Object} node TreeNode instance mousedowned upon
     */
    this.treeLeafMouseDownHandler = function (evt,node) {
    }

    /**
     * Default empty handler for a folder on mouseup
     * @param {Object} node TreeNode instance mouseupped upon
     */
    this.treeFolderMouseUpHandler = function (evt,node) {
    }

    /**
     * Default empty handler for a leaf on mouseup
     * @param {Object} node TreeNode instance mouseupped upon
     */
    this.treeLeafMouseUpHandler = function (evt,node) {
    }

    /**
     * Default empty handler for a folder on start edit name
     * @param {Object} node TreeNode instance edit upon
     */
    this.startEditFolderHandler = function (evt, node) {
    }
    /**
     * Default empty handler for a leaf on start edit name
     * @param {Object} node TreeNode instance edit upon
     */
    this.startEditLeafHandler = function (evt, node) {
    }

    /**
     * Default empty handler for a folder on end edit name
     * @param {Object} node TreeNode instance edit upon
     */
    this.endEditFolderHandler = function (evt, node) {
    }
    /**
     * Default empty handler for a leaf on end edit name
     * @param {Object} node TreeNode instance edit upon
     */
    this.endEditLeafHandler = function (evt, node) {
    }

    /**
     * handler for a node on drag
     * @param {Object} treeSupport - the tree
     * @param {Object} node - TreeNode  moused over
     */
    this.getDragHandlerForNode = function(treeSupport,node) {

        var forFolder = treeSupport.isFolderMetaNode(node);
        var draggedNodeIsSelected = false;

        return function (evt,node) {

            var selObjs = treeSupport.tree.selectedNodes;
            var overlay = null;
            var refNodes = [];

            if (selObjs.length > 0) {
                var nodeNum = 0;
                for (var i = 0; i < selObjs.length; i++) {
                    var thisNode = selObjs[i];
                    var isFolder = treeSupport.isNodeAFolder(thisNode);
                    if ((isFolder && treeSupport.supportsFolderDragging()) || (!isFolder && treeSupport.supportsLeafDragging())) {
                        refNodes.push(thisNode);
                        nodeNum++;
                    }
                    if (thisNode == node) {
                        draggedNodeIsSelected = true;
                    }
                }
                if (nodeNum > 0) {
                    overlay = treeSupport.createNodeOverlay(evt,node);
                    //always set the label now that we are re-using old overlays
                    var tds = overlay.getElementsByTagName('TD');
                    if (tds && tds.length > 1) {
                        var label;
                        if (nodeNum > 1) {
                            label = TreeSupport.TREE_NN_ITEMS_SELECTED.replace('%%', nodeNum);
                        } else {
                            label = draggedNodeIsSelected ? overlay.defaultText : " " + selObjs[0].name;
                        }
                        tds[1].innerHTML = label;
                    }
                }
            }

            if (overlay != null) {
                treeSupport.draggingObject = overlay;
                treeSupport.draggingOverNode = null;
                treeSupport.getDragListener().setCurrentAgentName(treeSupport.getDragAgentName());
                treeSupport.dragger = new Dragger(
                    evt,
                    [overlay],
                    true,
                    true,
                    treeSupport.dragSignificantMoveThreshold,
                    treeSupport.getDragListener());
                //treeSupport.dragger.cleanUpUtil = treeSupport.dragger.clearDraggingObjects;
                treeSupport.dragger.cleanUpUtil = cleanUpDraggingObjects(treeSupport);
                treeSupport.draggingObject.referencedNodes = refNodes;
            }
            return false;
        }
    }

    /**
     * handler for moving mouse over of a node
     * @param {Object} treeSupport - the tree
     * @param {Object} node - TreeNode  moused over
     */
    this.getMouseOverHandlerForNode = function(treeSupport,node) {

        var forFolder = treeSupport.isFolderMetaNode(node);

        //Is special handler supplied?....
        if(forFolder && treeSupport.mouseOverFolderHandler) {
            return treeSupport.mouseOverFolderHandler
        }
        if(!forFolder && treeSupport.mouseOverLeafHandler) {
            return treeSupport.mouseOverLeafHandler
        }


        //If not use this default implementaion which supports dragging over...
        return function (evt,node) {
            if (treeSupport.isAnyoneDragging()) {
                //first perform standard drag over processing required by all trees
                if (treeSupport.interestedInDragOver(treeSupport,node, forFolder)) {
                    treeSupport.draggedOverNode=node;
                }
                //now notify drag Listener, if any, for local processing
                if (treeSupport.hasDragListener()) {
                    var dragEvent = forFolder ? treeSupport.DRAGGED_OVER_FOLDER_EVENT : treeSupport.DRAGGED_OVER_LEAF_EVENT;
                    treeSupport.getDragListener().notify(dragEvent);
                }


            }
        }
    }

    /**
     * handler for moving mouse out of a node
     * @param {Object} treeSupport - the tree
     * @param {Object} node - TreeNode  moused out
     */
    this.getMouseOutHandlerForNode = function(treeSupport,node) {
        var forFolder = treeSupport.isFolderMetaNode(node);

        //Is special handler supplied?....
        if(forFolder && treeSupport.mouseOutFolderHandler) {
            return treeSupport.mouseOutFolderHandler
        }
        if(!forFolder && treeSupport.mouseOutLeafHandler) {
            return treeSupport.mouseOutLeafHandler
        }

        //If not use this default implementaion which supports dragging over...
        return function (evt,node) {
            if (treeSupport.isAnyoneDragging()) {
                //first notify drag Listener, if any, for local processing
                if (treeSupport.hasDragListener()) {
                    var dragEvent = forFolder ? treeSupport.DRAGGED_OFF_FOLDER_EVENT : treeSupport.DRAGGED_OFF_LEAF_EVENT;
                    treeSupport.getDragListener().notify(dragEvent);
                }
                //now perform standard drag over processing required by all trees
                if (treeSupport.interestedInDragOver(treeSupport,node, forFolder)) {
                    treeSupport.draggedOverNode=null;
                }
            }
        }
    }

    /**
     * Are we set up to accept drag onto nodes?
     */
    this.interestedInDragOver = function(treeSupport,node, forFolder) {
        return (forFolder && treeSupport.supportsDraggingOntoFolder()) ||
            (!forFolder && treeSupport.supportsDraggingOntoLeaf());
    }



    /**
     * Dynamically loads children for the node
     * @param {Object} parentNode TreeNode instance
     * @param {Function} userCallbackFn optional user function
     * @param {Function} errorCallbackFn optional error handler function
     */
    this.getTreeNodeChildren = function (parentNode, userCallbackFn, errorCallbackFn) {

        var uri = parentNode.getParam().uri;

        var callback = function(obj, ni, uc, ec) {
            return function() {
                return obj.getTreeNodeChildrenCallback(ni, uc, ec);
            }
        }(this, parentNode.getID(), userCallbackFn, errorCallbackFn);

        ajaxTargettedUpdate(
            this.urlGetChildren + '&provider=' + this.providerId + '&uri=' + uri,
            this.ajaxBufferId,
            null,
            callback
        );

        if (!this.inInit) {
            //var waitNode = new TreeNode('', this.waitIcon, null);
            //parentNode.addChild(waitNode);
            //parentNode.refreshNode();

            parentNode.setIcon(this.waitIcon);
            var img = document.getElementById('iconimage' + parentNode.getID());
            img.src = this.waitIcon;
        }

    }

    this.getTreeNodeChildrenCallback = function (parentNodeId, userCallbackFn, errorCallbackFn) {

        var div = document.getElementById(this.nodeTextId);
        if (div == null) {
            if (errorCallbackFn) {
                errorCallbackFn();
            }
            return;
        }
        var ns = window.eval('(' + div.innerHTML.replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>') + ')');
        div = document.getElementById(this.ajaxBufferId);
        div.innerHTML = '';

        var parentNode = nodes[parentNodeId];
        parentNode.resetChilds();
        parentNode.setIcon(this.getIconForNode(parentNode.param));
        var img = document.getElementById('iconimage' + parentNode.getID());
        img.src = parentNode.getIcon();
        var len = ns.length;
        if (len == 0) {
            parentNode.setHasChilds(false);
        } else {
            for (var i = 0; i < len; i++) {
                var node = this.processNode(ns[i]);
                parentNode.addChild(node);
            }
        }

        parentNode.setIsLoaded(true);
        parentNode.refreshNode();

        if (userCallbackFn) {
            userCallbackFn();
        }
    }

    /**
     * Dynamically loads children for a given node.
     * Makes sure that all requested nodes get prefetched.
     * Nodes to be prefetched have to have parentNode as a common (grand*)parent
     * @param {Object} parentNode parent TreeNode
     * @param {String} prefetchedListStr comma separated URIs to be prefetched
     * @param {Function} userCallbackFn optional user callback function
     * @param {Function} errorCallbackFn optional error handler function
     */
    this.getTreeNodeChildrenPrefetched = function (parentNode, prefetchedListStr, userCallbackFn, errorCallbackFn) {

        var uri = parentNode.getParam().uri;

        var url = this.urlGetNode + '&provider=' + this.providerId + '&uri=' + uri;
        if (prefetchedListStr) {
            url += '&prefetch=' + prefetchedListStr;

        }
        var callback = function(obj, ni, uc, ec) {
            return function() {
                return obj.getTreeNodeChildrenPrefetchedCallback(ni, uc, ec);
            }
        }(this, parentNode.getID(), userCallbackFn, errorCallbackFn);

        ajaxTargettedUpdate(
            url,
            this.ajaxBufferId,
            null,
            callback
        );

        if (!this.inInit) {
            //var waitNode = new TreeNode('', this.waitIcon, null);
            //parentNode.addChild(waitNode);
            //parentNode.refreshNode();

            parentNode.setIcon(this.waitIcon);
            var img = document.getElementById('iconimage' + parentNode.getID());
            img.src = this.waitIcon;
        }

    }

    this.getTreeNodeChildrenPrefetchedCallback = function (parentNodeId, userCallbackFn, errorCallbackFn) {

        var div = document.getElementById(this.nodeTextId);
        if (div == null) {
            if (errorCallbackFn) {
                errorCallbackFn();
            }
            return;
        }
        var n = window.eval('(' + div.innerHTML.replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>') + ')');
        div = document.getElementById(this.ajaxBufferId);
        div.innerHTML = '';

        var parentNode = nodes[parentNodeId];
        parentNode.resetChilds();
        parentNode.setIcon(this.getIconForNode(parentNode.param));
        if (n.children) {
            for (var i = 0; i < n.children.length; i++) {
                var node = this.processNode(n.children[i]);
                parentNode.addChild(node);
            }
        }

        parentNode.setIsLoaded(true);
        parentNode.refreshNode();

        if (userCallbackFn) {
            userCallbackFn();
        }
    }

    /**
     * Expands the tree up to a given node, and then select it
     * @param {String} uriStr node URI
     * @param {Function} fnAction optional action to be called
     */
    this.openAndSelectNode = function(uriStr, fnAction) {
        var fn = function(node) {
            if (node.parent) {
                var tree = trees[node.getTreeId()];
                if (tree && tree.rootNode != node.parent && tree.getState(node.parent.id) == 'closed') {
                    node.parent.handleNode();
                }
            }
            node.addNodeToSelected(false);
        };

        this.processNodePath(uriStr, fn);

        // scroll tree container to make selected node visible
        var tree = this.tree;
        if (tree) {
            var selectedNode = tree.getSelectedNode();
            if (selectedNode) {
                var rootNodeId = 'node' + tree.rootNode.getID();
                var rootNodeElement = document.getElementById(rootNodeId);
                var container = rootNodeElement.parentNode;
                var selectedNodeId = 'node' + selectedNode.id;
                var selectedNodeElement = document.getElementById(selectedNodeId);
                if (container) {
                    var ch = container.clientHeight;
                    var cw = container.clientWidth;
                    var cst = container.scrollTop;
                    var csl = container.scrollLeft;
                    var nt = selectedNodeElement.offsetTop;
                    var nl = selectedNodeElement.offsetLeft;
                    var nh = selectedNodeElement.clientHeight;
                    var nw = selectedNodeElement.clientWidth;
                    if (nt > (cst + ch)) { // node is below
                        container.scrollTop = nt - (ch / 2 - nh / 2);
                    } else if ((nt + nh) < cst) { // node is above
                        container.scrollTop = nt - (ch / 2 - nh / 2);
                    }
                    if (nl > (csl + cw)) { // node is out left
                        container.scrollLeft = nl - (cw / 2 - nw / 2);
                    } else if ((nl + nw) < csl) { // node is out right
                        container.scrollTop = nl - (cw / 2 - nw / 2);
                    }
                }
            }
        }

        if (fnAction) {
            fnAction();
        }
    }

    this.processNodePath = function(uriStr, fnForNode) {

        var path = uriStr.split('/');
        var node = this.tree.rootNode;
        var i;

        for (i = 0; i < path.length; i++) {
            if (!path[i]) {
                continue;
            }
            node = this.findNodeChildByMetaName(node, path[i]);
            if (!node) {
                return;
            }
            fnForNode(node);
        }

    }

    /**
     * Returns TreeNode which is last node in node hierarchical chain for a given uri
     * If returned node corresponds to uriStr, it means no more server requests needed
     * If it corresponds to parent (grand-parent, etc.), the value shows existing root
     * from which the rest should be requested from server
     * Example: uriStr='/area/subarea/dept/prod1', return is TreeNode with uri '/area/subarea'.
     * It means, we need to load children of 'subarea' and children of 'dept' from server
     *
     * @param {Object} uriStr
     */
    this.findLastLoadedNode = function(uriStr) {
        var nodeHolder = { node: null };
        var fn = function(holder) {
            return function(node) {
                holder.node = node;
            }
        }(nodeHolder);

        this.processNodePath(uriStr, fn);

        return nodeHolder.node;
    }

    this.findNodeChildByMetaName = function (node, name) {
        if (node.hasChilds()) {
            for (var i = 0; i < node.childs.length; i++) {
                if (node.childs[i].param.id == name) {
                    return node.childs[i];
                }
            }
        }
        return null;
    }

    this.isNodeAFolder = function(node) {
        return node.param.type == this.Types.folderType;
    }

    this.hasVisibleFolders = function(rootObj) {
        if (showRoot) {
            return true;
        }

        var children = rootObj.children;

        if (children) {
            for (var i = 0; i < children.length; i++) {
                var grandchildren = rootObj.children[i].children;
                if (grandchildren && grandchildren.length>0) {
                    return true;
                }
            }
        }

        return false;
    }

    /////////////////////////////////////////////////////////////////////
    // Dragging Support
    /////////////////////////////////////////////////////////////////////

    this.getDragListener = function () {
        if (this.dragSupport) {
            return this.dragSupport.dragListener;
        } else {
            return null;
        }
    }

    this.hasDragListener = function () {
        return this.getDragListener() != null;
    }

    this.getDraggedObject = function () {
        if (this.dragger && this.dragger.draggingObjs) {
            return this.dragger.draggingObjs[0];
        } else {
            return null;
        }
    }

    this.getDraggedObjects = function () {
        if (this.dragger && this.dragger.draggingObjs) {
            return this.dragger.draggingObjs;
        } else {
            return null;
        }
    }

    this.getDragAgentName = function () {
        if (this.dragSupport) {
            return this.dragSupport.dragAgentName ? this.dragSupport.dragAgentName : this.DEFAULT_DRAG_AGENT_NAME;
        } else {
            return this.DEFAULT_DRAG_AGENT_NAME;
        }
    }

    this.getDraggedNodeZIndex = function () {
        if (this.dragSupport) {
            return this.dragSupport.draggedNodeZIndex;
        } else {
            return 0;
        }
    }

    this.supportsLeafDragging = function () {
        return this.dragSupport && this.dragSupport.canDragLeaves;
    }

    this.supportsFolderDragging = function () {
        return this.dragSupport && this.dragSupport.canDragFolders;
    }

    this.supportsDraggingOntoLeaf = function () {
        return this.dragSupport && this.dragSupport.canDragOntoLeaf;
    }

    this.supportsDraggingOntoFolder = function () {
        return this.dragSupport && this.dragSupport.canDragOntoFolder;
    }

    this.hideIconWhileDragging = function() {
        return this.dragSupport && this.dragSupport.hideIconWhileDragging;
    }

    // set the draggingObject translution
    this.setTranslucent = function(evt, node) {
        node.style.MozOpacity = "0.75";
        node.style.filter = "alpha(opacity=70)";

    }

    //clone the selected node for dragging
    this.createNodeOverlay = function (evt,node) {

        var thisNodeOverlay = document.getElementById(this.NODE_DRAGGING_INDICATOR + node.id);

        if (!thisNodeOverlay) {
            var e = evt?evt:event;
            var nodeDiv = document.getElementById('node'+node.id);
            var nodeIcon = document.getElementById('iconimage'+node.id);
            var nodeSpan = document.getElementById('title'+node.id);

            var nt = evt.clientY+3+getScrollTop();
            var nl = evt.clientX+3+getScrollLeft();

            var nh = nodeDiv.clientHeight;
            //var nw = iconAndLabelSpan.clientWidth;

            thisNodeOverlay = document.createElement('DIV');
            thisNodeOverlay.style.position = "absolute";
            thisNodeOverlay.style.display = "none";
            thisNodeOverlay.innerHTML = this.NODE_DRAGGING_TEMPLATE;

            disableSelection(thisNodeOverlay);
            thisNodeOverlay.style.top=nt;
            thisNodeOverlay.style.left=nl;
            thisNodeOverlay.id = this.NODE_DRAGGING_INDICATOR + node.id;
            thisNodeOverlay.setAttribute("node_id",node.id);
            var thisIcon = thisNodeOverlay.getElementsByTagName('IMG')[0];
            thisIcon.id = 'treeDragIcon';

            if (!this.hideIconWhileDragging()) {
                thisIcon.src=this.dragSupport.dragIconSrc == null ? nodeIcon.src : this.dragSupport.dragIconSrc;
                thisIcon.style.verticalAlign=nodeIcon.style.verticalAlign;
            } else {
                thisIcon.style.display="none";
            }
            var thisText = thisNodeOverlay.getElementsByTagName('TD')[1];
            thisText.id = this.NODE_DRAGGING_INDICATOR_TEXT + node.id;
            thisText.className="treetitle";
            thisText.style.verticalAlign=nodeSpan.style.verticalAlign;
            // not sure why we need the leading space - tried to copy nanotrees html but....
            //nodeSpan.innerText ? thisText.innerText= ' ' + nodeSpan.innerText : thisText.textContent=' ' + nodeSpan.textContent;
            thisText.innerHTML = ' ' + nodeSpan.innerHTML;
            thisNodeOverlay.defaultText = thisText.innerHTML;

            thisNodeOverlay.className="overlay";
            thisNodeOverlay.style.zIndex=this.getDraggedNodeZIndex();

            this.nodeOverlays[this.nodeOverlays.length] = thisNodeOverlay;
            document.body.appendChild(thisNodeOverlay);
        }

        return thisNodeOverlay;
    };

    this.flushNodeOverlays = function() {
        for (index in this.nodeOverlays) {
            var thisNodeOverlay = this.nodeOverlays[index];
            if (thisNodeOverlay) {
                if (thisNodeOverlay.parentNode) {
                    thisNodeOverlay.parentNode.removeChild(thisNodeOverlay);
                }
                thisNodeOverlay = null;
            }
        }
        this.nodeOverlays = new Array();
    }

    this.isAnyoneDragging = function() {
        return this.hasDragListener() && this.getDragListener().isDragging();
    }

    this.isTreeDragging = function() {
        if (this.hasDragListener()) {
            var dragAgent = this.getDragListener().getCurrentAgentName();
            return dragAgent == this.getDragAgentName();
        }
    }




    ///////////////////////////////////////////
    // Message system support
    ///////////////////////////////////////////

    this.getMessage = function (messageId, userCallbackFn, errorCallbackFn) {

        var url = this.urlGetMessage + '&messageId=' + messageId;

        var callback = function(obj, uc, ec) {
            return function() {
                return obj.getMessageCallback(uc, ec);
            }
        }(this, userCallbackFn, errorCallbackFn);

        ajaxTargettedUpdate(
            url,
            this.ajaxBufferId,
            null,
            callback
        );

    }

    this.getMessageCallback = function (userCallbackFn, errorCallbackFn) {

        var div = document.getElementById(this.ajaxBufferId);
        if (div == null) {
            if (errorCallbackFn) {
                errorCallbackFn();
            }
            return;
        }

        // clean AJAX buffer
        var text = trim(div.innerHTML);
        div.innerHTML = '';

        if (userCallbackFn) {
            userCallbackFn(text);
        }
    }

    if (TreeSupport.TREE_NN_ITEMS_SELECTED == null) {
        var callback = function(text) {
            TreeSupport.TREE_NN_ITEMS_SELECTED = text;
        };
        this.getMessage('TREE_NN_ITEMS_SELECTED', callback, null);
    }

} // TreeSupport

//////////////////////////////////////////////////////////////////////////////////
// TreeDragSupport
// object passed as an argument to TreeSupport if dragging required
//////////////////////////////////////////////////////////////////////////////////

function TreeDragSupport(dragListener,canDragLeaves,canDragFolders,canDragOntoLeaves,canDragOntoFolders,hideIconWhileDragging,dragAgentName,dragIcon) {
    this.dragListener=dragListener;
    this.draggedNodeZIndex=1;
    this.canDragLeaves=!!canDragLeaves;
    this.canDragFolders=!!canDragFolders;
    this.canDragOntoLeaves=!!canDragOntoLeaves;
    this.canDragOntoFolders=!!canDragOntoFolders;
    this.hideIconWhileDragging=!!hideIconWhileDragging;
    this.dragAgentName=dragAgentName;
    this.dragIconSrc=dragIcon;
}

var cleanUpDraggingObjects = function(treeSupport) {
    return function() {
        treeSupport.flushNodeOverlays();
        treeSupport.dragger.clearDraggingObjects();
    }
}




