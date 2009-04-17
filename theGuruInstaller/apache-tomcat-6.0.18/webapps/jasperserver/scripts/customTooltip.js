var customTooltip = {};
customTooltip.TOOLTIP_ID="custTooltip";

function showCustomTooltip(evt, tipText, tipWidth, tipColor, tipBgColor){
    //cleanup old one just in case
    hideCustomTooltip(evt);


    //make a new one
    var evt = evt ? evt : window.event;
    var myTooltip = document.getElementById('customTooltipTemplate').cloneNode(true);
    if (!tipText) {
        myTooltip.style.display = "none";
    } else {
        myTooltip.style.display = "block";
    }

    myTooltip.setAttribute('id',customTooltip.TOOLTIP_ID);
    var myTooltipTable = myTooltip.getElementsByTagName('TABLE')[0];
    var myTooltipCell = myTooltip.getElementsByTagName('TD')[0];
    if (tipWidth) {
        myTooltip.style.width = tipWidth;
    }
    if (tipBgColor) {
        myTooltip.style.backgroundColor = tipBgColor;
        myTooltipTable.style.backgroundColor = tipBgColor;
    }
    if (tipColor) {
        myTooltipCell.style.color = tipColor;
    }
    myTooltipCell.innerHTML = tipText;
    myTooltip.style.left = evt.clientX + getScrollLeft();
    myTooltip.style.top = evt.clientY + getScrollTop() + 5;
    document.body.appendChild(myTooltip);
    fitObjectIntoScreen(
        myTooltip,
        myTooltip.style.left,
        myTooltip.style.top,
        myTooltipCell.offsetWidth,
        myTooltipCell.offsetHeight);
}

function updateCustomTooltip(text){
    var myTooltip = document.getElementById(customTooltip.TOOLTIP_ID);
    if (myTooltip) {
        var myTooltipCell = myTooltip.getElementsByTagName('TD')[0];
        myTooltipCell.innerHTML = text;
        myTooltip.style.display = "block";
        fitObjectIntoScreen(
            myTooltip,
            myTooltip.style.left,
            myTooltip.style.top,
            myTooltipCell.offsetWidth,
            myTooltipCell.offsetHeight);
    }
}

function hideCustomTooltip(evt){
    var evt = evt ? evt : window.event;
    var newTarget = evt.explicitOriginalTarget ? getParentDiv(evt.explicitOriginalTarget) : null;

    //not if we are hovering over tooltip itself (FF only)
    if (newTarget && newTarget.getAttribute("id")==customTooltip.TOOLTIP_ID) {
        return;
    }

    var myTooltip = document.getElementById(customTooltip.TOOLTIP_ID);
    if (myTooltip) {
        if (myTooltip.parentNode) {
            myTooltip.parentNode.removeChild(myTooltip);
        }
        myTooltip = null;
    }
}


