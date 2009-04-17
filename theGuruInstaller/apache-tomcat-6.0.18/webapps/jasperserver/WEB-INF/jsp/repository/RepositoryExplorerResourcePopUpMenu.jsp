

<div style='position:absolute;display:none' id='resource_popup'>
    
   <table border='0'  cellspacing="0">
    <tr>
     <td valign="top" style="background-image: url(images/popup-top-left.gif); background-repeat: no-repeat; width:8px;height:10px">
     </td>
     <td style="background-image: url(images/popup-top-middle.gif); background-repeat: repeat;height:5px; vertical-align:bottom" align='center'>
     </td>         
     <td valign="top" style="background-image: url(images/popup-top-right.gif); background-repeat: no-repeat; width:9px">
     </td>
    </tr>
    
    <tr>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" align='center' style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat;height:5px">
      <span style="font-style:italic;color:#993200 ;line-height:60%;" id='resource_popup_header'><spring:message code="RM_RESOURCE_MENU" javaScriptEscape="true"/></span>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>    
    
    <tr id='resource_sep0'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat;">
         <div style='font-size:5px'>&nbsp;</div>
         <div style='border-top: 1px solid #B37150; font-size:1px'></div>
         <div style='border-top: 1px solid #FFFFFF; font-size:1px'></div>
         <div style='font-size:5px'>&nbsp;</div>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>   
  
    <tr id="view_td" style="cursor: pointer" onclick='javascript:util.hideDialog("resource_popup");repositoryExplorer.viewResource();'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
      <div id="view_menu" onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">
       <spring:message code="RM_RESOURCE_POPUP_VIEW" javaScriptEscape="true"/>
      </div>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>  
  
    <authz:authorize ifAllGranted="ROLE_ADMINISTRATOR">
    <tr id="edit_td_popup" style="cursor: pointer" onclick='javascript:util.hideDialog("resource_popup");'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
      <div id="edit_menu" onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">
       <spring:message code="RM_BUTTON_WIZARD" javaScriptEscape="true"/>
      </div>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr> 
    </authz:authorize>

    <authz:authorize ifAllGranted="ROLE_USER">
    <tr id="edit_guru_td_popup" style="cursor: pointer" onclick='javascript:util.hideDialog("resource_popup");'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
      <div id="edit_guru_menu" onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">
       <spring:message code="RM_BUTTON_REPORTWIZARD" javaScriptEscape="true"/>
      </div>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr> 
    </authz:authorize>

    <tr id='resource_sep1'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat;">
         <div id='run_top_space' style='font-size:5px'>&nbsp;</div>
         <div id='sep1' style='border-top: 1px solid #B37150; font-size:1px'></div>
         <div id='sep2' style='border-top: 1px solid #FFFFFF; font-size:1px'></div>
         <div id='run_bottom_space' style='font-size:5px'>&nbsp;</div>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>  
     
    
    
    <tr id="schedule_td_popup" style="cursor: pointer; display:none" onclick=''>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
      <div id="schedule_menu" onmouseover="" onmouseout="">       
       <spring:message code="RM_BUTTON_SCHEDULE_REPORT" javaScriptEscape="true"/>
      </div> 
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>     
    

    
    <tr id="send_output_td_popup" style="cursor: pointer; display:none" onclick=''>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
      <div id="send_output_menu" onmouseover="" onmouseout="">       
       <spring:message code="RM_BUTTON_RUN_IN_BACKGROUND" javaScriptEscape="true"/>
      </div> 
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr> 
     
    <tr id="open_in_design_td_popup" style="cursor: pointer; display:none" onclick=''>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
      <div id="open_in_design_menu" onmouseover="" onmouseout="">       
       <spring:message code="RM_BUTTON_DESIGN" javaScriptEscape="true"/>
      </div> 
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>
    
    
    <tr id='resource_sep2'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat;">
         <div id='run_top_space' style='font-size:5px'>&nbsp;</div>
         <div id='sep1' style='border-top: 1px solid #B37150; font-size:1px'></div>
         <div id='sep2' style='border-top: 1px solid #FFFFFF; font-size:1px'></div>
         <div id='run_bottom_space' style='font-size:5px'>&nbsp;</div>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>   

    <tr id="paste_menu_resource" style="cursor: pointer;" onclick='javascript:util.hideDialog("resource_popup");'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
      <div id="paste_menu" onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">
       <spring:message code="RM_BUTTON_PASTE_RESOURCE" javaScriptEscape="true"/>
      </div>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>  


    <tr id="move_menu_resource" style="cursor: pointer;" onclick='javascript:util.hideDialog("resource_popup");'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
      <div id="move_menu" onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">
       <spring:message code="RM_BUTTON_MOVE_RESOURCE" javaScriptEscape="true"/>
      </div>
      <div id="cancel_move_menu" onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">
       <spring:message code="RM_BUTTON_CANCEL_MOVE_RESOURCE" javaScriptEscape="true"/>
      </div>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr> 

    <tr id="copy_menu_resource" style="cursor: pointer;" onclick='javascript:util.hideDialog("resource_popup");'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
      <div id="copy_menu" onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">
       <spring:message code="RM_BUTTON_COPY_RESOURCE" javaScriptEscape="true"/>
      </div>
      <div id="cancel_copy_menu" onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">
       <spring:message code="RM_BUTTON_CANCLE_COPY_RESOURCE" javaScriptEscape="true"/>
      </div>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr> 

 
    <tr id="resource_sep3">
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat;height:5px">
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>    
    
    
    <tr id="resource_sep4">
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat;">
         <div style='border-top: 1px solid #B37150; font-size:1px'></div>
         <div style='border-top: 1px solid #FFFFFF; font-size:1px'></div>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>   
    
    <tr id="resource_sep5">
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat;height:5px">
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>  
    
    
    <tr id="delete_td" style="cursor: pointer" onclick=''>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
      <div id="delete_menu" onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">
       <spring:message code="RM_BUTTON_DELETE_RESOURCE" javaScriptEscape="true"/>
      </div>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>
    
    <tr id='resource_sep6'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat;">
         <div id='prun_top_space' style='font-size:5px'>&nbsp;</div>
         <div id='psep1' style='border-top: 1px solid #B37150; font-size:1px;'></div>
         <div id='psep2' style='border-top: 1px solid #FFFFFF; font-size:1px;'></div>
         <div id='prun_bottom_space' style='font-size:5px'>&nbsp;</div>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>  
    
    <authz:authorize ifAllGranted="ROLE_ADMINISTRATOR">    
     <tr id="resource_permissions_menu" style="cursor: pointer" onclick='javascript:util.hideDialog("resource_popup");repositoryTree.backingBean.resourceRolePermission();'>
      <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
      </td>
      <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
       <div onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">
        <spring:message code="RM_FOLDER_POPUP_ASSIGN_PERMISSIONS" javaScriptEscape="true"/>
       </div> 
      </td>         
      <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
      </td>
     </tr>    
    </authz:authorize>   
  
    
    
    <tr id="properties_td_popup" style="cursor: pointer" onclick=''>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
      <div id="properties_menu" onmouseover="" onmouseout="">
       <spring:message code="RM_BUTTON_PROPERTIES" javaScriptEscape="true"/>
      </div> 
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>    
   

    
    
    
    <tr>
     <td valign="top" style="background-image: url(images/popup-bottom-left.gif); background-repeat: no-repeat; width:8px;height:11px">
     </td>
     <td valign="top" style="background-image: url(images/popup-bottom-middle.gif); background-repeat: repeat; height:5px">
     </td>     
     <td valign="top" style="background-image: url(images/popup-bottom-right.gif); background-repeat: no-repeat; width:9px">
     </td>
    </tr> 
    
   </table>
</div>



