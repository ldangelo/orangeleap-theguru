<%--
 Copyright (C) 2005 - 2007 JasperSoft Corporation.  All rights reserved.
 http://www.jaspersoft.com.

 Unless you have purchased a commercial license agreement from JasperSoft,
 the following license terms apply:

 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2 as published by
 the Free Software Foundation.

 This program is distributed WITHOUT ANY WARRANTY; and without the
 implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 See the GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, see http://www.gnu.org/licenses/gpl.txt
 or write to:

 Free Software Foundation, Inc.,
 59 Temple Place - Suite 330,
 Boston, MA  USA  02111-1307
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/spring.tld" prefix="spring" %>
<%@ taglib uri="/WEB-INF/jasperserver.tld" prefix="js"%>

<script src="scripts/RepositoryExplorer.js"></script>


<%-- ajaxResponseModel --%>

<script>
   currentReportOptionList = new Array();
</script>

<form name="frm" action="" method="post">
<table width='100%' valign='top' cellspacing='0px' cellpadding='0px' style='-moz-user-select: none;-khtml-user-select:none;' onselectstart="return false">
 <tr valign='top' bgcolor='#C5D1D9'>
  <td valign='middle'><INPUT TYPE=CHECKBOX NAME='toggleCheckBox' onclick='repositoryExplorer.toggleAllCheckBoxes(this)'></td>
  <td>&nbsp;</td><td valign='middle'><img src='images/clock.gif' title='<spring:message code="RM_BUTTON_SCHEDULE_REPORT" javaScriptEscape="true"/>' /></td>
  <td>&nbsp;</td>
  <td width='25%' height='25px' nowrap valign='middle' style='font-weight:bold'><spring:message code="RM_NAME" javaScriptEscape="true"/></td>
  <td>&nbsp;</td><td width='35%'  height='25px' nowrap valign='middle' style='font-weight:bold'><spring:message code="RM_DESCRIPTION" javaScriptEscape="true"/></td>
  <td>&nbsp;</td>
  <td width='15%' height='25px' nowarp valign='middle' style='font-weight:bold'><spring:message code="RM_TYPE" javaScriptEscape="true"/></td>
  <td>&nbsp;</td>
  <td width='25%'  height='25px' nowrap valign='middle' style='font-weight:bold'><spring:message code="RM_CREATION_DATE" javaScriptEscape="true"/></td>
 </tr>
 <tr>
  <td colspan='11' height='2px' bgcolor='#6C7C95'></td>
 </tr> 
 <script>
   var resourceCounter = 0;
 </script>
 <%
   int resourceCounter = 0;
 %>
 
 <%-- resource list starts here --%>
 <c:forEach var="resource" items="${ajaxResponseModel.rows}" varStatus="itStatus">
  
  <script>
    currentResourceList[resourceCounter] = '${resource.id}';
    currentResourceNameList[resourceCounter] = '${resource.hiddenName}';
    currentResourceType[resourceCounter] = '${resource.resourceType}';
    currentResourceWritable[resourceCounter] = '${resource.writable}';
    currentResourceDeletable[resourceCounter] = '${resource.deletable}';
    currentResourceTopOrOption[resourceCounter] = 'top';
    resourceCounter++;
    //makeDraggableItem(document.getElementById('movingItems'), document.getElementById('${resource.id}'));
  </script>
  <% resourceCounter++;  %>
  <tr NAME='resource_row' id='${resource.id}' class="${itStatus.count % 2 != 0 ? 'list_alternate' : 'list_default'}" onmousedown='javascript:repositoryExplorer.onResourceRowRightClickMouseDown(event, "${resource.id}")'>
   <td onclick="javascript:repositoryExplorer.clickOnResourceRowCheckBox(event, <%=resourceCounter%>, '${resource.id}');" valign='middle'><INPUT TYPE=CHECKBOX NAME='resource_checkbox' id='checkbox_${resource.id}' value='${resource.id}'></td><td onclick="javascript:repositoryExplorer.clickOnResourceRow(event, <%=resourceCounter%>, '${resource.id}');">&nbsp;</td>
   <td valign='middle' onclick="javascript:clickOnResourceRow(event, <%=resourceCounter%>, '${resource.id}');">
     <c:choose>
     <c:when test="${resource.scheduled == true}">
      <a href='javascript:repositoryExplorer.gotoSchedulingReport("${resource.id}", "report");'>
       <img src='images/clock.gif' border='0' title='<spring:message code="RM_BUTTON_SCHEDULE_REPORT" javaScriptEscape="true"/>' />
      </a>
     </c:when> 
     <c:when test="${resource.scheduled == false}">
      &nbsp;
     </c:when>
    </c:choose> 
   </td>
   <td>
    <c:choose>
     <c:when test="${resource.hasSavedOptions == true}">
       <a id="" href="javascript:expandToggleReportOptions('${resource.id}');" 
          title="<spring:message code='report.options.repository.tooltip.expand.options.list' javaScriptEscape='true'/>">
        <img id="${resource.id}_toggle" border="0" src="images/expand.gif" alt="<spring:message code='report.options.repository.tooltip.expand.options.list' javaScriptEscape='true'/>" />
      </a>
     
     </c:when>
    </c:choose>
    <c:choose>
     <c:when test="${resource.hasSavedOptions == false}">
        &nbsp;
     </c:when>
    </c:choose>
   </td>
   <td  onclick="javascript:repositoryExplorer.clickOnResourceRow(event, <%=resourceCounter%>, '${resource.id}');" height='25px' nowrap valign='middle' class='paddedcell'>
    <c:choose>
     <c:when test="${resource.resourceUrl == ''}">
      <div id='${resource.id}_name_value'>${resource.name}</div>
     </c:when> 
     <c:when test="${resource.resourceUrl != ''}">
       <c:if test="${resource.contentType == true}">
        <div><a class='repo' href="${resource.resourceUrl}" target="_new" id='${resource.id}_name_value'>${resource.name}</a></div>
       </c:if>
       <c:if test="${resource.contentType == false}">
        <div><a class='repo' href="${resource.resourceUrl}" id='${resource.id}_name_value'>${resource.name}</a></div>
       </c:if>
     </c:when>
    </c:choose>
   </td>
   <td onclick="javascript:repositoryExplorer.clickOnResourceRow(event, <%=resourceCounter%>, '${resource.id}');">&nbsp;</td>
   <td onclick="javascript:repositoryExplorer.clickOnResourceRow(event, <%=resourceCounter%>, '${resource.id}');" valign='middle' class='paddedcell'><div id='${resource.id}_desc_value'>${resource.description}</div></td>
   <td onclick="javascript:repositoryExplorer.clickOnResourceRow(event, <%=resourceCounter%>, '${resource.id}');">&nbsp;</td>
   <td onclick="javascript:repositoryExplorer.clickOnResourceRow(event, <%=resourceCounter%>, '${resource.id}');" valign='middle' class='paddedcell'><spring:message code='${resource.type}'/></td><td onclick="javascript:repositoryExplorer.clickOnResourceRow(event, <%=resourceCounter%>, '${resource.id}');">&nbsp;</td>
   <td onclick="javascript:repositoryExplorer.clickOnResourceRow(event, <%=resourceCounter%>, '${resource.id}');" valign='middle' class='paddedcell'><js:formatDate value="${resource.creationDate}"/></td>
  </tr>
  
<%-- options starts --%>
<script>
   if (currentReportOptionList == null) {  
       currentReportOptionList = new Array();
   }
   currentReportOptionList['${resource.id}'] = "";
</script>
<c:choose>
 <c:when test="${resource.hasSavedOptions == true}">
 <c:forEach var="item" items="${ajaxResponseModel.rows}">   
  <c:if test="${resource.id == item.id}">
  <c:forEach var="options" items="${item.listOfOptions}" varStatus="optionsStatus">
  <script>
    currentResourceList[resourceCounter] = '${options.id}';
    currentResourceNameList[resourceCounter] = '${options.hiddenName}';
    currentResourceType[resourceCounter] = '${options.resourceType}';
    currentResourceWritable[resourceCounter] = '${options.writable}';
    currentResourceDeletable[resourceCounter] = '${options.deletable}';
    currentResourceTopOrOption[resourceCounter] = 'option';
    if (currentReportOptionList['${resource.id}'] != "") {
       currentReportOptionList['${resource.id}'] = currentReportOptionList['${resource.id}'] + ',' + '${options.id}';
    } else {
      currentReportOptionList['${resource.id}'] = '${options.id}';
    }
    resourceCounter++;
  </script> 
  <% resourceCounter++;  %>
  <tr NAME='resource_row' id='${options.id}' class="${optionsStatus.count % 2 != 0 ? 'list_option_alternate' : 'list_option_default'}" onmousedown='javascript:repositoryExplorer.onResourceRowRightClickMouseDown(event, "${options.id}")'  style="display:none">
   <td onclick="javascript:repositoryExplorer.clickOnResourceRowCheckBox(event, <%=resourceCounter%>, '${options.id}');" valign='middle'><INPUT TYPE=CHECKBOX NAME='resource_checkbox' id='checkbox_${options.id}' value='${options.id}'></td><td onclick="javascript:repositoryExplorer.clickOnResourceRow(event, <%=resourceCounter%>, '${options.id}');">&nbsp;</td>
   <td valign='middle' onclick="javascript:clickOnResourceRow(event, <%=resourceCounter%>, '${options.id}');">
     <c:choose>
     <c:when test="${options.scheduled == true}">
      <a href='javascript:repositoryExplorer.gotoSchedulingReport("${options.id}", "report_option");'>
       <img src='images/clock.gif' border='0' title='<spring:message code="RM_BUTTON_SCHEDULE_REPORT" javaScriptEscape="true"/>' />
      </a>
     </c:when> 
     <c:when test="${options.scheduled == false}">
      &nbsp;
     </c:when>
    </c:choose> 
   </td>
   <td>
        &nbsp;
   </td>
   <td  onclick="javascript:repositoryExplorer.clickOnResourceRow(event, <%=resourceCounter%>, '${options.id}');" height='25px' nowrap valign='middle' class='paddedcell'>
    <c:choose>
     <c:when test="${options.resourceUrl == ''}">
      <div id='${options.id}_name_value'>${options.name}</div>
     </c:when> 
     <c:when test="${options.resourceUrl != ''}">
       <div><a class='repo' href="${options.resourceUrl}" id='${options.id}_name_value'>&nbsp;&nbsp;&nbsp;${options.name}</a></div>
     </c:when>
    </c:choose>
   </td>
   <td onclick="javascript:repositoryExplorer.clickOnResourceRow(event, <%=resourceCounter%>, '${options.id}');">&nbsp;</td>
   <td onclick="javascript:repositoryExplorer.clickOnResourceRow(event, <%=resourceCounter%>, '${options.id}');" valign='middle' class='paddedcell'><div id='${options.id}_desc_value'>${options.description}</div></td>
   <td onclick="javascript:repositoryExplorer.clickOnResourceRow(event, <%=resourceCounter%>, '${options.id}');">&nbsp;</td>
   <td onclick="javascript:repositoryExplorer.clickOnResourceRow(event, <%=resourceCounter%>, '${options.id}');" valign='middle' class='paddedcell'><spring:message code='${options.type}'/></td><td onclick="javascript:repositoryExplorer.clickOnResourceRow(event, <%=resourceCounter%>, '${options.id}');">&nbsp;</td>
   <td onclick="javascript:repositoryExplorer.clickOnResourceRow(event, <%=resourceCounter%>, '${options.id}');" valign='middle' class='paddedcell'><js:formatDate value="${options.creationDate}"/></td>
  </tr>
  </c:forEach>
  </c:if>
 </c:forEach> 
 </c:when>
</c:choose>  
      
<%-- options ends --%>   
  
 </c:forEach>
<c:choose>
 <c:when test="${ajaxResponseModel.size eq '0'}">
   <tr>
    <td height='25'></td>
   <tr>
   <tr NAME='resource_row' id='${resource.id}' class='list_default'>
    <td colspan='11' align='center'> <spring:message code="RM_NO_RESOURCES" javaScriptEscape="true"/>
    </td>
   </tr>
 </c:when>
</c:choose>

</table> 

<table width='100%' valign='top' cellspacing='0px' cellpadding='0px'>
 <tr>
  <td align="center">
   <c:choose>
    <c:when test="${ajaxResponseModel.totalPages > 1}">
       <table border="0">
        <tr align="center">
         <td>
          <c:choose>
	       <c:when test="${ajaxResponseModel.currentPageNumber == 1}">
            <img src="images/first-d.gif">
           </c:when>
	       <c:otherwise>
		    <div onClick='javascript:repositoryExplorer.getResources(0);'>
             <img src="images/first.gif" title="<spring:message code='RM_PAGINATION_FIRST'  javaScriptEscape='true'/>" class="imageborder" onMouseover="borderImage(this,'#C0C0C0')" onMouseout="borderImage(this,'white')"> 
            </div>                
	       </c:otherwise>
          </c:choose>
         </td>
         <td>
          <c:choose>
	       <c:when test="${ajaxResponseModel.currentPageNumber == 1}">
            <img src="images/prev-d.gif">
           </c:when>
	       <c:otherwise>
		    <div onClick='javascript:repositoryExplorer.getResources(${ajaxResponseModel.currentPageNumber-2});'>
             <img src="images/prev.gif" title="<spring:message code='RM_PAGINATION_PREVIOUS' javaScriptEscape='true'/>" class="imageborder" onMouseover="borderImage(this,'#C0C0C0')" onMouseout="borderImage(this,'white')"> 
            </div>               
	       </c:otherwise>
          </c:choose>
         </td>
         <td class="navFont">
          <nobr>Page ${ajaxResponseModel.currentPageNumber} of ${ajaxResponseModel.totalPages}</nobr>
         </td>
         <td>
          <c:choose>
	       <c:when test="${ajaxResponseModel.currentPageNumber == ajaxResponseModel.totalPages}">
            <img src="images/next-d.gif">
           </c:when>
	       <c:otherwise>
		    <div onClick='javascript:repositoryExplorer.getResources(${ajaxResponseModel.currentPageNumber});'>
             <img src="images/next.gif" title="<spring:message code='RM_PAGINATION_NEXT' javaScriptEscape='true'/>" class="imageborder" onMouseover="borderImage(this,'#C0C0C0')" onMouseout="borderImage(this,'white')"> 
            </div>                
	       </c:otherwise>
          </c:choose>
         </td>
         <td>
          <c:choose>
	       <c:when test="${ajaxResponseModel.currentPageNumber == ajaxResponseModel.totalPages}">
            <img src="images/last-d.gif">
           </c:when>
	       <c:otherwise>
		    <div onClick='javascript:repositoryExplorer.getResources(${ajaxResponseModel.totalPages-1});'>
             <img src="images/last.gif" title="<spring:message code='RM_PAGINATION_LAST' javaScriptEscape='true'/>" class="imageborder" onMouseover="borderImage(this,'#C0C0C0')" onMouseout="borderImage(this,'white')"> 
            </div>                
	       </c:otherwise>
          </c:choose>
         </td>
        </tr>
       </table>
    </c:when>
   </c:choose>           
  </td>
 </tr>
</table>

 </form>
