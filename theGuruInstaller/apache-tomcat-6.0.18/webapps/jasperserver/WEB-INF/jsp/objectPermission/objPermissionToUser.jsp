<%-- Copyright (C) 2005 - 2007 JasperSoft Corporation. All rights reserved.
     http://www.jaspersoft.com. Unless you have purchased a commercial license
     agreement from JasperSoft, the following license terms apply: This program
     is free software; you can redistribute it and/or modify it under the terms
     of the GNU General Public License version 2 as published by the Free
     Software Foundation. This program is distributed WITHOUT ANY WARRANTY; and
     without the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
     PURPOSE. See the GNU General Public License for more details. You should
     have received a copy of the GNU General Public License along with this
     program; if not, see http://www.gnu.org/licenses/gpl.txt or write to: Free
     Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA USA
     02111-1307--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/jasperserver.tld" prefix="js"%>
<%@ taglib uri="/spring" prefix="spring"%>
<%@ page errorPage="/WEB-INF/jsp/JSErrorPage.jsp"%>
<html>
  <head>
    <title>
      <spring:message code="jsp.objPermissionToUser.title"/>
    </title>
    <meta name="pageHeading"
          content='<spring:message code="jsp.objPermissionToUser.title"/>'></meta>
  </head>
  
  <script type="text/javascript">
  
      var listOfObjectNames = new Array();
      var objectIndex = 0;
      
      
      function js_hookActions() {
          for (var i=0; i<listOfObjectNames.length; i++) {
             var prevName = "prev" + listOfObjectNames[i];
             var curName = listOfObjectNames[i];
             var prevValue = document.getElementById(prevName).value;
             var curValue = document.getElementById(curName).value;
        
             if (prevValue != curValue) {
                if (confirm("<spring:message code="jsp.objPermission.cancelMove" javaScriptEscape="true"/>")) {
                   document.forms[0].goToPageAndSave.click();
                } else {
                   return true;
                }
             }
          }
          return true;
      }
  
  </script>
  
  <body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0"><form name="frm"
                                                                            method="post"
                                                                            action="">
      <table width="100%" border="0" cellpadding="15" cellspacing="0">
        <tr>
          <td width="100%">
            <table border="0" width="100%" cellpadding="0" cellspacing="0">
              <tr align="center">
                <td  class="fsectionFix">
                  <spring:message code="jsp.objPermissionToUser.title"/>
                </td>
              </tr>
              <tr>
                <td align="center" style="font-size:5px;">&nbsp;</td>
              </tr>
              <tr>
                <td align="center">
                  <a href="javascript:document.frm.resource.value='${param.resource}';document.getElementById('rolePermissions').click();">
                    <span class="tabTitleFix"><spring:message code="jsp.objPermission.byRole"/></span>
                  </a>
                  &nbsp;&nbsp;|<span class="tabTitleFix currentTab">&nbsp;&nbsp;
                  <spring:message code="jsp.objPermission.byUser"/></span>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr align="center">
          <td>
            <c:if test="${!empty users}">
              <table width="50%">
                <tr>
                  <td width="50%" nowrap="nowrap">
                    <div>
                      <spring:message code="jsp.objPermission.resourceId"/>:&nbsp;&nbsp;<b>${resource.URIString}</b>
                    </div>
                    <input type="hidden" name="resource" class="fnormal"
                           value="${resource.URIString}" size="33"
                           readonly="readonly"/>
                  </td>
                </tr>
                <tr align="right">
                  <td nowrap="nowrap">
                    <input type="submit" class="fnormal" name="_eventId_back"
                           value='<spring:message code="button.ok"/>'/>
                    <input type="submit" class="fnormal" name="_eventId_cancel"
                           value='<spring:message code="button.cancel"/>'/>
                    <input type="submit" class="fnormal" name="_eventId_setPermission"
                           value='<spring:message code="button.apply"/>'/>
                  </td>
                </tr>
                <tr>
                  <td>
                    <table border="0" width="100%" cellpadding="1" cellspacing="0"  class="formtable">
                      <tr class="fheader">
                        <td class="tableheadercell nonBoldHeader" width="75%" align="left">
                          <spring:message code="jsp.objPermissionToUser.userName"/>
                        </td>
                        <td class="tableheadercell nonBoldHeader" width="25%" align="left">
                          <spring:message code="jsp.objPermissionToRole.permissionLevel"/>
                        </td>
                      </tr>
                      <js:paginator items="${users}" page="${currentPage}">
                        <c:forEach items="${paginatedItems}" var="user"
                                   varStatus="status">

                         
                    <c:set var="permission" value="${permissions[user]}" scope="request"/>

<%                             
             // need to do it in Java since EL language doesn't support bit operations
             Integer permission = (Integer)request.getAttribute("permission");
             int numPermission = permission.intValue() & 0xff;
             int numInheritedPermission = ((permission.intValue() & 0x100) >> 8) % 2;
             int numRemoveInheritedPermission = ((permission.intValue() & 0xfe00) >> 9);
             request.setAttribute("permission", new Integer(numPermission));
             request.setAttribute("inheritedPermission", new Integer(numInheritedPermission));
             request.setAttribute("removeInheritedPermission", new Integer(numRemoveInheritedPermission));
%>
                    
                          <tr <c:if test="${status.count % 2 == 1}">class="tableoddrow"</c:if>>
                            <td class="paddedcell" align="left">
                              <b><a href="javascript:document.getElementById('userName').value='${user.username}';document.getElementById('viewEditUser').click();">
                                  <c:out value="${user.username}"></c:out>
                                </a></b>
                              <%-- input type="submit"
                                   name="_eventId_viewEditRole"
                                   id="viewEditRole" class="fnormal" value=''
                                   onclick="document.frm.roleName.value='${role.roleName}';"
                                   style="visibility:hidden;"/> <input
                                   type="submit" name="_eventId_setPermission"
                                   class="fnormal" value='<spring:message
                                   code="jsp.objPermission.button.setPermission"/>'
                                   onclick="document.frm.roleName.value='${role.roleName}';"
                                   style="visibility:hidden;"/--%>
                            </td>
                            <td class="paddedcell" align="right">
                              <%-- by default set the permission already
                                   assigned to the role else blank option--%>
                              <input type="hidden"
                               name="prevpermission_${user.username}"
                               id="prevpermission_${user.username}"
                               <c:choose>
                                     <c:when test="${inheritedPermission == 1}">
	                                   value="${removeInheritedPermission == 0 ? 256 : removeInheritedPermission * 512}"
                                     </c:when>
                                     <c:otherwise>
	                                   value="${permission}"
                                     </c:otherwise>
                               </c:choose>/>
                              <script type="text/javascript">     
                                  listOfObjectNames[objectIndex++] = 'permission_'+'${user.username}';
                              </script>                                
                              <select name="permission_${user.username}"
                                      id="permission_${user.username}"
                                      class="listandtextcontrol">
                          <option <c:choose>
                                     <c:when test="${inheritedPermission == 1}">
	                                   value="256"
                                     </c:when>
                                     <c:otherwise>
	                                   value="0"
                                     </c:otherwise>
                                  </c:choose>
                                  <c:if test="${(permission == 0) || ((removeInheritedPermission == 0) && (inheritedPermission == 1))}">selected</c:if> 
                                  <c:if test="${(((inheritedPermission == 1) && (removeInheritedPermission == 0)) || ((inheritedPermission == 0) && (removeInheritedPermission == 0)))}"> class="italic"</c:if>>
                                  <spring:message code="jsp.objPermission.permission.noAccess"/>
                                  <c:if test="${(((inheritedPermission == 1) && (removeInheritedPermission == 0)) || ((inheritedPermission == 0) && (removeInheritedPermission == 0)))}">*</c:if>
                          </option>                          
                          
                          <option <c:choose>
                                     <c:when test="${inheritedPermission == 1}">
	                                   value="512"
                                     </c:when>
                                     <c:otherwise>
	                                   value="1"
                                     </c:otherwise>
                                  </c:choose>
                                  <c:if test="${(permission == 1) || ((removeInheritedPermission == 1) && (inheritedPermission == 1))}">selected</c:if> 
                                  <c:if test="${(removeInheritedPermission == 1) && (permission ne 1)}"> class="italic"</c:if>>
                                  <spring:message code="jsp.objPermission.permission.administer"/>
                                  <c:if test="${(removeInheritedPermission == 1) && (permission ne 1)}">*</c:if>
                          </option>
                          <option <c:choose>
                                     <c:when test="${inheritedPermission == 1}">
	                                   value="1024"
                                     </c:when>
                                     <c:otherwise>
	                                   value="2"
                                     </c:otherwise>
                                  </c:choose>
                                  <c:if test="${(permission == 2) || ((removeInheritedPermission == 2) && (inheritedPermission == 1))}">selected</c:if> 
                                  <c:if test="${(removeInheritedPermission == 2) && (permission ne 2)}"> class="italic"</c:if>>
                                  <spring:message code="jsp.objPermission.permission.read"/>
                                  <c:if test="${(removeInheritedPermission == 2) && (permission ne 2)}">*</c:if>
                          </option>
                          <option <c:choose>
                                     <c:when test="${inheritedPermission == 1}">
	                                   value="9216"
                                     </c:when>
                                     <c:otherwise>
	                                   value="18"
                                     </c:otherwise>
                                  </c:choose>
                                  <c:if test="${(permission == 18) || ((removeInheritedPermission == 18) && (inheritedPermission == 1))}">selected</c:if> 
                                  <c:if test="${(removeInheritedPermission == 18) && (permission ne 18)}"> class="italic"</c:if>>
                                  <spring:message code="jsp.objPermission.permission.delete"/>
                                  <c:if test="${(removeInheritedPermission == 18) && (permission ne 18)}">*</c:if>
                          </option>
                          <option <c:choose>
                                     <c:when test="${inheritedPermission == 1}">
	                                   value="15360"
                                     </c:when>
                                     <c:otherwise>
	                                   value="30"
                                     </c:otherwise>
                                  </c:choose>
                                  <c:if test="${(permission == 30) || ((removeInheritedPermission == 30) && (inheritedPermission == 1))}">selected</c:if> 
                                  <c:if test="${(removeInheritedPermission == 30) && (permission ne 30)}"> class="italic"</c:if>>
                                  <spring:message code="jsp.objPermission.permission.readWriteDelete"/>
                                  <c:if test="${(removeInheritedPermission == 30) && (permission ne 30)}">*</c:if>
                          </option>
                              </select>
                            </td>
                          </tr>
                          <c:remove var="permission"/>
                        </c:forEach>
                        <tr  class="fheader"><td class="tablefootercell nonBoldHeader">
                         <js:paginatorLinks/>
                        </td><td class="tablefootercell nonBoldHeader">&nbsp;</td></tr>
                      </js:paginator>
                   
                    </table> 
                  </td>
                </tr>
                <tr>
                  <td>
                    <table border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td align="right" nowarp="nowarp" width="10%" >
                           <input type="submit" class="fnormal" name="_eventId_back"
                                  value='<spring:message code="button.ok"/>'/>
                           <input type="submit" class="fnormal" name="_eventId_cancel"
                                  value='<spring:message code="button.cancel"/>'/>
                           <input type="submit" class="fnormal" name="_eventId_setPermission"
                                  value='<spring:message code="button.apply"/>'/>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td>
                    <table border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td align="left" nowrap="nowrap" width="100%" class="italic">
                          * 
                            <spring:message code="jsp.objPermission.inheritedPermission"/>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>                
              </table>
            </c:if>
          </td>
          <td width="25%">&nbsp;</td>
        </tr>
        </table>
        <input type="hidden" name="_flowExecutionKey"
               value="${flowExecutionKey}"/>
        <input type="hidden" name="userName" id="userName" value=""/>
        <!--<input type="hidden" name="resourceUri" value=""/>-->
        <input type="submit" class="fnormal" name="_eventId_rolePermissions"
               id="rolePermissions" value="edit" style="visibility:hidden;"/>
        <input type="submit" name="_eventId_viewEditUser"
               id="viewEditUser" class="fnormal" value='<spring:message code="jsp.objPermission.button.viewEdit"/>'
               onclick=""
               style="visibility:hidden;"/> 
        <input type="submit" name="_eventId_setPermission" id="viewEditUser"
               class="fnormal" value='<spring:message code="jsp.objPermission.button.setPermission"/>'
               onclick=""
               style="visibility:hidden;"/>
        <input type="submit" name="_eventId_goToPageAndSave" id="goToPageAndSave" value="edit" style="visibility:hidden;"/>     
    </form></body>
</html>

 