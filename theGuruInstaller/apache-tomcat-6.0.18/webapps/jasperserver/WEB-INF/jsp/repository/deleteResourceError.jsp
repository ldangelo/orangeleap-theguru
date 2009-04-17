<div id="delete_resource_error_dialog" style='height: 139px; width: 463px;position:absolute;display:none;z-index:98'>
  <table style="height: 139px; width: 463px; vertical-align: top;" border="0" cellpadding="0" cellspacing="0" class="dialogtable" onmousedown="dialogOnMouseDown(event);">
    <tr><td>
      <table class="dialogcontent" style="height: 100%; width: 100%;">
         <tr><td class="dialogcell" style="padding-bottom:5px;padding-top:15px;"><div class='ferror'><spring:message code="eventType.1.label" javaScriptEscape="true"/>:</div></td></tr>
         <tr><td class="dialogcell" height="100%" >
              <table class="dialoginsetframe" width="100%" height="100%" valign="top" cellspacing=3 cellpadding=0 onmousedown="cancelEventBubbling(event)">
              <tr>
                <td style="padding: 8px 14px;">
                  <table cellspacing=0 cellpadding=0>
                    <tr>
                      <td colspan="2" width="100%" style="padding-bottom: 4px;"><spring:message code="jsp.flowRemoveError.errorMsg2" javaScriptEscape="true"/><br></td>
                    </tr>
                    <tr>
                      <td colspan="2" id="delete_error_list">              
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              </table>
         </td></tr>
       <tr><td class="dialogcell" align="center"  style="padding-bottom:8px;padding-top:8px;">
                <input onmouseover="this.className='insidebuttonhover'" onmouseout="this.className='insidebutton'" 
                value="&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code="RM_BUTTON_OK" javaScriptEscape="true"/>&nbsp;&nbsp;&nbsp;&nbsp;" class="insidebutton" type="button" 
                onclick="javascript:util.hideDialog('delete_resource_error_dialog');removeOverlay(modalWinObj);">&nbsp;
      </td></tr>
      </table>
   </td></tr></table>
</div>