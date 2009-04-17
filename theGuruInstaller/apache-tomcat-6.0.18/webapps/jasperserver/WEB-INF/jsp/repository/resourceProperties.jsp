<div id="resource_property_dialog" style='height: 100px; width: 413px;position:absolute;display:none;z-index:98'>
  <table style="height: 100px; width: 413px; vertical-align: top;" border="0" cellpadding="0" cellspacing="0" class="new_dialogtable" onmousedown="dialogOnMouseDown(event);">
    <tr><td>
      <table class="new_dialogcontent" style="height: 100%; width: 100%;">
         <td class="new_dialogcontent" valign="top" align="right"><input type="image" onmouseover="this.className='new_dialogXButtonHover'" onmouseout="this.className='new_dialogXButton'" class="new_dialogXButton" title='<spring:message code="button.close" javaScriptEscape="true"/>' src="images/x-button.gif" onclick='util.hideDialog("resource_property_dialog");removeOverlay(modalWinObj);'></td>
         <tr><td class="new_dialogcell" style="padding-bottom:5px;padding-top:1px;"><spring:message code="RM_RESOURCE_PROPERTIES" javaScriptEscape="true"/></td></tr>
         <tr><td class="new_dialogcell" height="100%" >
              <table class="new_dialoginsetframe" width="100%" height="100%" valign="top" cellspacing=3 cellpadding=0 onmousedown="cancelEventBubbling(event)">
              <tr>
                <td style="padding: 8px 14px;">
                  <table cellspacing=0 cellpadding=0>
                    <tr id='static_name'>
                      <td colspan="2" width="100%" style="padding-bottom: 4px; color:#000033"><spring:message code="RM_NAME" javaScriptEscape="true"/>:<br></td>
                    </tr>
                    <tr id='modifiable_name' style='display:none'>
                      <td colspan='2'><input id='modifiable_property_popup_name' name='modifiable_property_popup_name' type="text" tabindex="1"  value=""  class="new_tabletextfieldorlist" style="width:100%;"></td>
                    </tr>
                    <tr id='name_size_error' style='display:none'>
                     <td colspan="2" width="100%" class='ferror' nowrap><spring:message code="RE_INVALID_NAME_SIZE" javaScriptEscape="true"/></td>
                    </tr>
                    <tr id='read_only_name' style='display:none'>
                      <td style="padding-bottom: 10px;">Name:</td><td style="padding-bottom: 10px;"><div id='read_only_property_popup_name' name='read_only_property_popup_name' style="font-weight: bold;" > </div></td>
                    </tr>
                    <tr>
                      <td colspan="2"><div id='error_duplicate_resource_name' style="display:none;" class='ferror'><spring:message code="RM_EXIST_NAME_CHOOSE" javaScriptEscape="true"/></div></td>
                    </tr>
                    <tr id='static_description'>
                      <td colspan="2" valign="bottom" style="padding-bottom: 4px;color:#000033"><br><spring:message code="RM_DESCRIPTION" javaScriptEscape="true"/>:<br></td>
                    </tr>
                    <tr id='modifiable_description' style='display:none;'>
                      <td colspan="2" valign="bottom" style="padding-bottom: 10px;"><textarea id='modifiable_property_popup_description'  tabindex="2"  value=""  class="new_tabletextfieldorlist" style="width:337px;height:100px;white-space:nowrap;overflow:auto;" rows='4' cols='40' name='modifiable_property_popup_description'></textarea></td>
                    </tr>
                    <tr id='desc_size_error' style='display:none'>
                     <td colspan="2" width="100%" class='ferror' nowrap><spring:message code="RE_INVALID_DESC_SIZE" javaScriptEscape="true"/></td>
                    </tr>
                    <tr id='read_only_description' style='display:none;'>
                      <td style="padding-bottom: 20px;">Description:</td><td valign="bottom" style="padding-bottom: 20px;"><div id='read_only_property_popup_description'  style="font-weight: bold;" name='read_only_property_popup_description'></div></td>
                    </tr>
                    <tr>
                      <td width="30%" valign="bottom" style="padding-bottom: 10px;color:#000033"><spring:message code="RM_TYPE" javaScriptEscape="true"/>:&nbsp;</td><td align="left" valign="top"><div id="property_popup_type" style="font-weight: bold;" ></div></td>
                    </tr>
                    <tr>  
                      <td width="30%" valign="bottom" style="padding-bottom: 10px;color:#000033"><spring:message code="RM_CREATION_DATE" javaScriptEscape="true"/>:&nbsp;</td><td align="left" valign="top"><div id="property_popup_date" style="font-weight: bold;" ></div></td>
                    </tr>
                    <tr> 
                      <td width="30%" valign="bottom" style="padding-bottom: 10px;color:#000033"><spring:message code="RM_RESOURCE_ID" javaScriptEscape="true"/>:&nbsp;</td><td align="left" valign="top"><div id="property_popup_id" style="font-weight: bold;" ></div></td>
                    </tr>
                    <tr>
                      <td width="30%" valign="bottom" style="padding-bottom: 10px;color:#000033"><spring:message code="RM_RESOURCE_USER_ACCESS" javaScriptEscape="true"/>:&nbsp;</td><td align="left" valign="top"><div id="property_popup_access" style="font-weight: bold;" ></div></td>
                    </tr>
                  </table>
                </td>
              </tr>
              </table>
         </td></tr>
       <tr id='property_both_buttons'  style='display:none'><td class="new_dialogcell" align="center"  style="padding-bottom:8px;padding-top:8px;"><input id='property_both_button_ok' onmouseover="this.className='new_dialogbuttonhover'" onmouseout="this.className='new_dialogbutton'" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code="RM_BUTTON_OK" javaScriptEscape="true"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" class="new_dialogbutton" type="button" onclick="javascript:repositoryExplorer.savePropertyClicked()">&nbsp;&nbsp;&nbsp;&nbsp;
                <input onmouseover="this.className='new_dialogbuttonhover'" onmouseout="this.className='new_dialogbutton'" value="&nbsp;&nbsp;<spring:message code="RM_BUTTON_CANCEL" javaScriptEscape="true"/>&nbsp;&nbsp;" class="new_dialogbutton" type="button" onclick="util.hideDialog('resource_property_dialog');removeOverlay(modalWinObj);util.elem('left_panel').style.overflow = 'auto';util.elem('right_panel').style.overflow = 'auto'; ">&nbsp;
      </td></tr>
      
       <tr id='property_one_button'  style='display:none'><td class="new_dialogcell" align="center"  style="padding-bottom:8px;padding-top:8px;"><input id='property_single_button_ok' onmouseover="this.className='new_dialogbuttonhover'" onmouseout="this.className='new_dialogbutton'" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code="RM_BUTTON_OK" javaScriptEscape="true"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" class="new_dialogbutton" type="button" onclick="util.hideDialog('resource_property_dialog');removeOverlay(modalWinObj); ">&nbsp;&nbsp;&nbsp;&nbsp;
                      
      </td></tr>
      
      </table>
   </td></tr></table>
</div>
<div id='modify_word' style="display:none"><spring:message code="RM_PERMISSION_MODIFY" javaScriptEscape="true"/></div>
<div id='readonly_word' style="display:none"><spring:message code="RM_PERMISSION_READ_ONLY" javaScriptEscape="true"/></div>
<div id='delete_word' style="display:none"><spring:message code="RM_BUTTON_DELETE_RESOURCE" javaScriptEscape="true"/></div>
