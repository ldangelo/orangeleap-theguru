<form action='javascript:repositoryExplorer.saveOKClicked(repositoryExplorer);'>
<div id="create_folder_dialog" style='height: 139px; width: 263px;position:absolute;display:none;z-index:98'>
  <table style="height: 139px; width: 263px; vertical-align: top;" border="0" cellpadding="0" cellspacing="0" class="new_dialogtable" onmousedown="dialogOnMouseDown(event);">
    <tr><td>
      <table class="new_dialogcontent" style="height: 100%; width: 100%;" cellspacing=7>
         <tr nowrap><td nowrap  style="padding-bottom:0px;padding-top:5px; font-weight:bold"><spring:message code="RM_ADD_SUBFOLDER" javaScriptEscape="true"/></td></tr>
         <tr><td class="new_dialogcontent" height="100%" >
              <table align='center' class="new_dialoginsetframe" width="100%" height="100%" valign="top" cellspacing=0 cellpadding=0 onmousedown="cancelEventBubbling(event)">
              <tr>
                <td style="padding: 15px 10px;">
                  <table cellspacing=0 cellpadding=0 align='center'>
                    <tr>
                      <td class="new_dialogcontent" colspan="2" valign="bottom" style="padding-bottom: 2px; color:#000033"><br><spring:message code="RM_NEW_FOLDER_NAME" javaScriptEscape="true"/>:<br></td>
                    </tr>
                    <tr>
                      <td class="new_dialogcontent" colspan="2"><input id='new_folder_name' type="text" tabindex="2" size='40' maxlength='100' value='<spring:message code="RM_NEW_FOLDER" javaScriptEscape="true"/>'  class="new_tabletextfieldorlist"  ></td>
                    </tr>
                    <tr>
                      <td class="new_dialogcontent" colspan="2"><div id='error_duplicate_folder_name' style="display:none;" class='ferror'><spring:message code="RM_EXIST_NAME" javaScriptEscape="true"/></div></td>
                    </tr>
                    <tr>
                      <td class="new_dialogcontent" colspan="2"><div id='error_null_folder_name' style="display:none;" class='ferror'><spring:message code="RM_NULL_FOLDER_NAME" javaScriptEscape="true"/></div></td>
                    </tr>
                    <tr>
                      <td class="new_dialogcontent" colspan="2" height='15px'></td>
                    </tr>
                  </table>
                </td>
              </tr>
              </table>
         </td></tr>
       <tr><td class="new_dialogcell" align="center"><input onmouseover="this.className='new_dialogbuttonhover'" onmouseout="this.className='new_dialogbutton'" value="&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code="RM_BUTTON_OK" javaScriptEscape="true"/>&nbsp;&nbsp;&nbsp;&nbsp;" class="new_dialogbutton" type="button" onclick="repositoryExplorer.saveOKClicked(repositoryExplorer)">&nbsp;&nbsp;&nbsp;&nbsp;
                <input onmouseover="this.className='new_dialogbuttonhover'" onmouseout="this.className='new_dialogbutton'" value="&nbsp;<spring:message code="RM_BUTTON_CANCEL" javaScriptEscape="true"/>&nbsp;" class="new_dialogbutton" type="button" onclick="util.hideDialog('create_folder_dialog'); removeOverlay(modalWinObj);util.elem('left_panel').style.overflow = 'auto';util.elem('right_panel').style.overflow = 'auto';">&nbsp;
      </td></tr>
      </table>
   </td></tr></table>
   <div id='parent_folder_id' style='font-weight: bold; display:none'></div>
</div>
</form>