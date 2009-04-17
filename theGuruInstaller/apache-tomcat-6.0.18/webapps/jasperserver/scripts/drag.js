//////////////////////////////////////////////////////////
// Drag.js
// Generic drag objects and functions
// Note: Not yet utilized by all dragging in Jasperserver
// Author: Angus Croll
//////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////
// Drag Listener
// Co-ordinates drag callbacks
// Plug dragging agents, actions and events in here
// agent - source of current dragging, e.g. 'tree'
// event - something that happens during drag, e.g. 'mouseOverColumn', 'mouseOutGroup' 'draggingStarted'
// action - function we want to trigger based on the agent-action combination
//////////////////////////////////////////////////////////

function DragListener() {
    this.agents = [];
    this.currentAgentName = null;
    this.dragger;
}

//standard events
DragListener.DRAGGING_STARTED = 'draggingStarted';
DragListener.DRAGGING_FINISHED = 'draggingFinished';
DragListener.DRAGGING = 'dragging';


DragListener.prototype.registerAgent = function(agentName) {
    this.agents[agentName] = new Array();
}

DragListener.prototype.publishEvent = function(agentName,event,action) {
    this.agents[agentName][event] = action;
}

DragListener.prototype.notify = function(dragListenerEvent,browserEvent) {
    var currentAgent = this.agents[this.currentAgentName];
    if (currentAgent) {
        var thisAction = currentAgent[dragListenerEvent];
        if (thisAction) {
            var draggingObjs = this.dragger ? this.dragger.draggingObjs : null;
            thisAction(browserEvent,draggingObjs);
        }
    }
}

//any dragging going on right now?
DragListener.prototype.isDragging = function() {
    return this.currentAgentName != null;
}

DragListener.prototype.setCurrentAgentName = function(agentName) {
    this.currentAgentName = agentName;
}

DragListener.prototype.getCurrentAgentName = function() {
    return this.currentAgentName;
}

//////////////////////////////////////////////////////////
// Dragger
// Drags anything......
// -evt is current event that triggered drag
// -draggingObjs are all objects being dragged whether or not the mouse is over them (multi-select)
// -originalObjX,originalObjY are co-ordiantes of draggingObj before dragging starts
// -originalMouseX,originalMouseY are co-ordiantes of mouse before dragging starts
// -dragsX,dragsY are booleans - can we drag horizontally, can we drag vertically
// -dragListener - see above. If no dragListener used then no callbacks
// -sigMove is the number of pixels user must move mouse before we consider drag initiated
//////////////////////////////////////////////////////////

function Dragger(evt,draggingObjs,dragsX,dragsY,sigMove,dragListener,cleanUpUtil) {

    var evt = evt?evt:event;

    this.originalX = new Array();
    this.originalY = new Array();

    this.draggingObjs = draggingObjs;
    this.dragsX = dragsX;
    this.dragsY = dragsY;
    this.sigMove = sigMove;
    this.dragListener = dragListener;
    this.cleanUpUtil = cleanUpUtil;

    if (this.dragListener) {
        this.dragListener.dragger = this;
    }

    for (var i=0; i<draggingObjs.length; i++) {
        this.originalX[i] = parseInt(draggingObjs[i].style.left);
        this.originalY[i] = parseInt(draggingObjs[i].style.top);
    }

    this.mouseX=evt.clientX;
    this.mouseY=evt.clientY;
    this.isDragging=false;

    this.initDragger(evt);

}

var invokeDragging = function(dragger) {
    return function(event) {
        dragger.dragging(event);
    }
}

var invokeDraggingFinished = function(dragger) {
    return function(event) {
        dragger.draggingFinished(event);
    }
}

Dragger.prototype.addAnotherDraggingObject = function(evt,draggingObj) {
    var evt = evt?evt:event;

    this.draggingObjs[this.draggingObjs.length] = draggingObj;
    this.originalX[this.originalX.length]  = parseInt(draggingObj.style.left);
    this.originalY[this.originalY.length] = parseInt(draggingObj.style.top);

    this.initDragger(evt);

}

Dragger.prototype.initDragger = function(evt) {
    this.isDragging=false;

    this.mouseX=evt.clientX;
    this.mouseY=evt.clientY;

    document.onmousemove = invokeDragging(this);
    document.onmouseup = invokeDraggingFinished(this);
}

Dragger.prototype.dragging = function(evt) {

    var e = evt?evt:event;

    var movedSignificantly = false;
    var xDiff=0;
    var yDiff=0;

    if (this.dragsX) {
        var xDiff = e.clientX-this.mouseX;
        movedSignificantly = Math.abs(xDiff)>this.sigMove;
    }

    if (this.dragsY) {
        var yDiff = e.clientY-this.mouseY;
        movedSignificantly = movedSignificantly || Math.abs(yDiff)>this.sigMove;
    }

    if (!this.isDragging && movedSignificantly) {
        this.isDragging=true;
        if (this.dragListener) {
            this.dragListener.notify(DragListener.DRAGGING_STARTED,evt);
        }
        for (i=0; i<this.draggingObjs.length; i++) {
            this.draggingObjs[i].style.display="block";
        }
    }

    if (this.isDragging) {
        if (xDiff) {
            for (i=0; i<this.draggingObjs.length; i++) {
                this.draggingObjs[i].style.left=parseInt(this.originalX[i] + xDiff);
            }
        }
        if (yDiff) {
            for (i=0; i<this.draggingObjs.length; i++) {
                this.draggingObjs[i].style.top=parseInt(this.originalY[i] + yDiff);
            }
        }
        if (xDiff || yDiff) {
            this.dragListener.notify(DragListener.DRAGGING,evt);
        }
    }
}

Dragger.prototype.draggingFinished = function(evt) {

    document.onmousemove='default';
    document.onmouseup='default';

    if (this.isDragging) {
        this.isDragging = false;

        //generic housekeeping for this drag host
        if (this.cleanUpUtil) {
            this.cleanUpUtil();
        }

        if (this.dragListener) {
            this.dragListener.notify(DragListener.DRAGGING_FINISHED,evt);
            this.dragListener.setCurrentAgentName(null);
        }
    } else {
        if (this.dragListener) {
            this.dragListener.setCurrentAgentName(null);
        }
    }
}

Dragger.prototype.clearDraggingObjects = function() {
    for (var i=0; i<this.draggingObjs.length; i++) {
        var thisOne = this.draggingObjs[i];
        if (thisOne) {
            if (thisOne.parentNode) {
                thisOne.parentNode.removeChild(thisOne);
            }
            thisOne = null;
        }
    }
}

