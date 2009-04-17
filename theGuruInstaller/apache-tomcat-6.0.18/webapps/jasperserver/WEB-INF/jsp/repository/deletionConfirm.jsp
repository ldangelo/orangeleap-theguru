

<div id="delete_confirm_dialog" style='height: 139px; width: 263px;position:absolute;display:none;z-index:98'>
<table width="100%" height="100%" >
<tr><td align="center">
  <table style="width: 100%; vertical-align: top;" border="0" cellpadding="0" cellspacing="0" class="new_dialogtable">
         <tr><td colspan=3 class="new_dialogcell" height="40" valign="bottom" align="left" nowrap><span class="new_confirmText" id='delete_msg_header'><spring:message code="RM_DELETE_CONFIRM_MSG" javaScriptEscape="true"/></span></td>
         </tr>
         <tr><td colspan=3 class="new_dialogcell"  valign="middle" align="left"><span class="new_confirmText" id='delete_msg_header_details'><ul></ul></span></td>
         </tr>         
         
		<tr height="1" >
		 <td class="new_dialogcell" width="5%"></td>
		 <td class="new_dialogcell new_confirmDarkBar"><img src="resources/px.gif" height=1 width=80%></td>
	         <td class="new_dialogcell" width="5%"></td>
		</tr>
		<tr height="4" >
		 <td class="new_dialogcell" width="5%"></td>
		 <td class="new_dialogcell new_confirmLightBar" ><img src="resources/px.gif" height=1 width=80%></td>
		 <td class="new_dialogcell" width="5%"></td>
		</tr>
       <tr><td colspan=3  class="new_dialogcell" align="center" valign="top"  style="padding-bottom:10px;padding-top:8px;"><input id='delete_yes_button' value="&nbsp;&nbsp;&nbsp;<spring:message code="RM_YES" javaScriptEscape="true"/>&nbsp;&nbsp;&nbsp;" onmouseover="this.className='new_dialogbuttonhover'" onmouseout="this.className='new_dialogbutton'" class="new_dialogbutton" type="button" onclick="javascript:repositoryExplorer.deleteSelectedResources()">&nbsp;&nbsp;&nbsp;&nbsp;
                <input onmouseover="this.className='new_dialogbuttonhover'" onmouseout="this.className='new_dialogbutton'" value="&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code="RM_NO" javaScriptEscape="true"/>&nbsp;&nbsp;&nbsp;&nbsp;" class="new_dialogbutton" type="button" onclick="javascript:util.hideDialog('delete_confirm_dialog');removeOverlay(modalWinObj);">&nbsp;

      </td></tr>
      </table>
   </td></tr></tbody></table>
   
</div>