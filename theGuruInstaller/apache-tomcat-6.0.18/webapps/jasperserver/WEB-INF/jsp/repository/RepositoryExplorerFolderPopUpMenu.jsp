

<div style='position:absolute;display:none' id='folder_popup'>
    
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
      <span style="font-style:italic;color:#993200 ;line-height:60%;"><spring:message code="RM_FOLDER_MENU" javaScriptEscape="true"/></span>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>    
    
    <tr id='folder_popup_sep0'>
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
    
    
    <tr id="new_folder_menu" style="cursor: pointer" onclick='javascript:util.hideDialog("folder_popup");getLaunchNewFolderDialogFunc();'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
      <div onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">
       <spring:message code="RM_FOLDER_POPUP_ADD_FOLDER" javaScriptEscape="true"/>
      </div>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>
    
    
    <authz:authorize ifAllGranted="ROLE_ADMINISTRATOR">    
     <tr id="folder_permissions_menu" style="cursor: pointer" onclick='javascript:util.hideDialog("folder_popup");repositoryExplorer.gotoRolePermission();'>
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
    
    
     <tr id='folder_popup_sep1'>
      <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
      </td>
      <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat;height:5px">
      </td>         
      <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
      </td>
     </tr>    
    
    
     <tr id='folder_popup_sep2'>
      <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
      </td>
      <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat;">
          <div style='border-top: 1px solid #B37150; font-size:1px'></div>
          <div style='border-top: 1px solid #FFFFFF; font-size:1px'></div>
      </td>         
      <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
      </td>
     </tr>   
    
     <tr id='folder_popup_sep3'>
      <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
      </td>
      <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat;height:5px">
      </td>         
      <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
      </td>
     </tr>   
    

    <tr id="drop_here_folder" style="cursor: pointer;" onclick=''>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
      <div id="paste_menu_div"  onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">       
       <spring:message code="RM_BUTTON_PASTE_RESOURCE" javaScriptEscape="true"/>
      </div> 
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr> 
     
 
    <tr id="move_menu_folder" style="cursor: pointer;" onclick=''>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
      <div id="move_menu_div" onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">       
       <spring:message code="RM_BUTTON_MOVE_RESOURCE" javaScriptEscape="true"/>
      </div> 
      <div id="cancel_move_menu_div" onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">       
       <spring:message code="RM_BUTTON_CANCEL_MOVE_RESOURCE" javaScriptEscape="true"/>
      </div>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>  
    
 
 
    <tr id="copy_menu_folder" style="cursor: pointer;" onclick=''>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
      <div id="copy_menu_div" onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">       
       <spring:message code="RM_BUTTON_COPY_RESOURCE" javaScriptEscape="true"/>
      </div> 
      <div id="cancel_copy_menu_div" onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">       
       <spring:message code="RM_BUTTON_CANCLE_COPY_RESOURCE" javaScriptEscape="true"/>
      </div> 
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>   
 

    
    
    <tr id='folder_popup_sep4'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat;height:5px">
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>    
    
    
    <tr id='folder_popup_sep5'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat;">
         <div style='border-top: 1px solid #B37150; font-size:1px'></div>
         <div style='border-top: 1px solid #FFFFFF; font-size:1px'></div>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>   
    
    <tr id='folder_popup_sep6'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat;height:5px">
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>   
     
    
    
    <tr id="delete_menu_folder" style="cursor: pointer" onclick='javascript:util.hideDialog("folder_popup");repositoryExplorer.launchDeleteFolderConfirm();'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
      <div onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">       
       <spring:message code="RM_BUTTON_DELETE_RESOURCE" javaScriptEscape="true"/>
      </div> 
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr> 


    <tr id='folder_popup_sep7'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat;height:5px">
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>    
    
    
    <tr id='folder_popup_sep8'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat;">
         <div style='border-top: 1px solid #B37150; font-size:1px'></div>
         <div style='border-top: 1px solid #FFFFFF; font-size:1px'></div>
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>   
    
    <tr id='folder_popup_sep9'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat;height:5px">
     </td>         
     <td valign="top" style="background-image: url(images/popup-center-right.gif); background-repeat: repeat; width:9px;height:1px">
     </td>
    </tr>  

    
    <tr id="properties_menu_folder" style="cursor: pointer" onclick='javascript:util.hideDialog("folder_popup");repositoryExplorer.launchProperties();'>
     <td valign="top" style="background-image: url(images/popup-center-left.gif); background-repeat: repeat;">
     </td>
     <td valign="top" style="background-image: url(images/popup-center-middle.gif); background-repeat: repeat; color:#043A66">
      <div onmouseover="javascript:this.style.backgroundColor='#993200';this.style.color='#FCF1DD'" onmouseout="javascript:this.style.backgroundColor='#FCF1DD';this.style.color='#043A66'">       
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



