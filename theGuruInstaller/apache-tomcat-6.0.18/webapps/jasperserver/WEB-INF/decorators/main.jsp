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
<%@ taglib prefix="spring" uri="/spring" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %> 	
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://acegisecurity.org/authz" prefix="authz"%>
<decorator:usePage id="thePage" />
<c:set var="pageProperties" value="${thePage.properties}"/>
<c:choose>
    <c:when test="${pageProperties['meta.formName']!=null}"><c:set var="formName" value="${pageProperties['meta.formName']}"/></c:when>
    <c:otherwise><c:set var="formName" value="mainForm"/></c:otherwise>
</c:choose>
<c:choose>
    <c:when test="${pageProperties['meta.formMethod']!=null}"><c:set var="formMethod" value="${pageProperties['meta.formMethod']}"/></c:when>
    <c:otherwise><c:set var="formMethod" value="GET"/></c:otherwise>
</c:choose>
<c:set var="pageType" value="${pageProperties['meta.pageType']}"/>
<c:choose>
<c:when test="${pageType!='popup' and (empty param['decorate'] or param['decorate'] == 'yes')}">
    <html>
    <head>
      <title><spring:message code='jsp.main.title'/></title>
      <meta http-equiv="Content-Type" content="text/html; charset=${requestScope['com.jaspersoft.ji.characterEncoding']}">
      <link href="${pageContext.request.contextPath}/stylesheets/stylesheet.css" rel="stylesheet" type="text/css">
      <link href="${pageContext.request.contextPath}/stylesheets/dialog.css" rel="stylesheet" type="text/css">
      <link href="${pageContext.request.contextPath}/jpivot/table/mdxtable.css" rel="stylesheet" type="text/css">
      <link href="${pageContext.request.contextPath}/jpivot/navi/mdxnavi.css" rel="stylesheet" type="text/css">
      <link href="${pageContext.request.contextPath}/wcf/form/xform.css" rel="stylesheet" type="text/css">
      <link href="${pageContext.request.contextPath}/wcf/table/xtable.css" rel="stylesheet" type="text/css">
      <link href="${pageContext.request.contextPath}/wcf/tree/xtree.css" rel="stylesheet" type="text/css">
      <jsp:include page="/cal/calendar.jsp" flush="true"/>
      <script language=JavaScript src="${pageContext.request.contextPath}/scripts/jasperserver.js"></script>
      <script language=JavaScript src="${pageContext.request.contextPath}/scripts/ajax.js"></script>
      <script language=JavaScript src="${pageContext.request.contextPath}/scripts/common.js"></script>
      <script language=JavaScript src="${pageContext.request.contextPath}/scripts/common-utils.js"></script>
      <decorator:head />
    </head>

    <%-- NOTE: Edit the file JI-menu.xml to control menu items content --%>

    <body style="color: black; background-color: white; margin-left: 2px; margin-right: 2px; margin-top: 2px;">

    <!-- DYNAMICALLY GENERATED JAVASCRIPT TO SHOW POPDOWN MENUS FOR SUBITEMS -->
    <script>
      function initmenu(div_id) {
        var d = document.getElementById(div_id);
        <c:forEach varStatus="status" var="menuItem" items="<%= com.jaspersoft.jasperserver.war.common.SiteMenu.instance().getMenu().getSubItems() %>">
        <c:if test="${menuItem.hasSubItems}">
        if (document.getElementById('jsmenu${status.count}')) {
          document.getElementById('jsmenu${status.count}').style.display='none';
        }
        </c:if>
        </c:forEach>
        if (d) {d.style.display='block';}
      }
      
      
      function hideAllDropDowmMenu() {
        for (var i=0; i<5; i++) {
          var curDropDownMenu = document.getElementById("jsmenu" + i);
          if (curDropDownMenu) {
             curDropDownMenu.style.display = "none";
          }
        }
      }

      window.onload=initmenu;
    </script>

    <table id="mainTable" border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" valign="top">
      <tr onmouseover="hideAllDropDowmMenu()" onmouseout="hideAllDropDowmMenu()">
        <td valign="top" width="100%">
          <table bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0" width="100%" cols="5">
            <tr valign="top">
              <td colspan="5" bgcolor="#000033"><img src="${pageContext.request.contextPath}/images/pixel.gif" height="1"></td>
            </tr>
            <tr>
              <td style="border-left: 0px solid rgb(0, 0, 51);" valign="middle" align="left" width="150"><a href="http://www.jaspersoft.com/"><img src="${pageContext.request.contextPath}/images/orangeleap-logo.png" style="border: 0px solid rgb(153, 153, 153);" border="0" hspace="4" height="35" width="136"></a></td>
              
              <td colspan="2">&nbsp;
                  <authz:authorize ifNotGranted="ROLE_ANONYMOUS">
                    <spring:message code="jsp.main.welcome"/> 
                      <c:if test="<%= com.jaspersoft.jasperserver.api.metadata.user.service.impl.UserAuthorityServiceImpl.isUserSwitched() %>">
		      <%= ((com.jaspersoft.jasperserver.api.metadata.user.domain.User)com.jaspersoft.jasperserver.api.metadata.user.service.impl.UserAuthorityServiceImpl.getSourceAuthentication().getPrincipal()).getFullName() %>
		      <spring:message code="jsp.main.as"/>
                      </c:if>
		    <authz:authentication operation="fullName"/><spring:message code="jsp.main.exclamation.mark"/>
                    </authz:authorize>
              </td>

            </tr>
            <tr valign="top">
              <td colspan="5" bgcolor="#000033"><img src="${pageContext.request.contextPath}/images/pixel.gif" height="1"></td>
            </tr>
          </table>
        </td>
      </tr>

      <!-- CODE FOR HORIZONTAL MENU ITEMS -->
      <c:choose>
          <c:when test="${pageProperties['meta.noMenu']==null}">
                  <tr class="topNavGradient" valign="top">
                    <td width="100%" style="border-left: 1px solid rgb(0, 0, 51);">
                       <table cellpadding=0 cellspacing=2 cols="6" rows="1">
                            <tr>
<c:forEach varStatus="status" var="menuItem" items="<%= com.jaspersoft.jasperserver.war.common.SiteMenu.instance().getMenu().getSubItems() %>">
	<c:set var="cellStyle" value='${menuItem.url==null?"padding-left:3px; FONT-WEIGHT:normal; FONT-SIZE:9pt; COLOR: #33333;  TEXT-DECORATION: none;":"padding-left:3px;"}'/>
  <authz:authorize ifAnyGranted="${menuItem.rolesStr}">
    <td id="href${status.count}" bgcolor="#ff9900" width="150" style="${cellStyle}" onMouseOver="javascript:initmenu(<c:if test="${menuItem.hasSubItems}">'jsmenu${status.count}'</c:if>);" nowrap><c:if test="${menuItem.url!=null}">
    <a class="topMenuLink" href="<c:url value="${menuItem.url}?${empty menuItem.servletParams ?'':'&'}curlnk=${status.count}"/>"></c:if>&nbsp;<spring:message code="${menuItem.name}"/><c:if test="${menuItem.url!=null}"></a></c:if></td>
  </authz:authorize>
</c:forEach>
                                <!-- defaultly add the 2 columns -->
                                <td width="150" onMouseOver="javascript:initmenu();" nowrap>&nbsp;</td>
                            </tr>
                       </table>
                    </td>
                  </tr>
          </c:when>
          <c:otherwise>
          </c:otherwise>
      </c:choose>
      <!-- END CODE FOR HORIZONTAL MENU ITEMS -->

      <tr>
          <td valign="top" width="100%" height="100%" style="border-left: 1px solid rgb(0, 0, 51);">
              <decorator:body />
          </td>
      </tr>
      <tr>
        <td style="border-left: 1px solid rgb(0, 0, 51); border-bottom: 1px solid rgb(0, 0, 51); background-color: rgb(114, 115, 110); vertical-align: middle;" height="25">
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
               <td align="center"><font class="fsmall" color="white"><spring:message code='decorators.main.copyright'/></font></td>
            </tr>
          </table>
        </td>
      </tr>
    </table>

    <!-- CODE FOR HZL MENU SUBMENU ITEMS -->
<c:if test="${pageProperties['meta.noMenu']==null}">
  <c:forEach varStatus="status" var="menuItem" items="<%= com.jaspersoft.jasperserver.war.common.SiteMenu.instance().getMenu().getSubItems() %>">
    <authz:authorize ifAnyGranted="${menuItem.rolesStr}">
      <c:if test="${menuItem.hasSubItems}">
        <div id="jsmenu${status.count}" class="topMenuDiv" style="left: ${(status.index*156) + 1}px" onMouseOver="initmenu('jsmenu${status.count}');" onMouseOut="initmenu();">
          <table cellspacing="0" align="left" valign="middle" cols="1" class="topMenuTable">
              <c:forEach items="${menuItem.subItems}" var="subItem">
	       <authz:authorize ifAnyGranted="${subItem.rolesStr}">
	       	<c:if test="${subItem.servletParams ne '_flowId=olapViewListFlow' && (fn:indexOf(subItem.url, 'flush.html') == -1)  && (fn:indexOf(subItem.url, 'properties.html') == -1)}">
               <tr>
                <td id="href${status.count}" class="topMenuItem"><a class="fwhite" href="<c:url value="${subItem.url}?${subItem.servletParams}${empty subItem.servletParams ? '' : '&'}curlnk=${status.count}"/>">&nbsp;<spring:message code="${subItem.name}"/></a></td>
               </tr>
            </c:if>
               </authz:authorize>
              </c:forEach>
          </table>
        </div>
      </c:if>
    </authz:authorize>
  </c:forEach>
</c:if>
    <!-- END CODE FOR HZL MENU SUBMENU ITEMS -->

    <!-- JAVASCRIPT FOR HIGHLIGHTING THE APPROPRIATE MENU HEADER -->
    <script>
      var linkobject = null;
      var currlinkvalue = "${param.curlnk}";
      for(ix = 1; ix <= <%= com.jaspersoft.jasperserver.war.common.SiteMenu.instance().getMenu().getSubItems().length %>; ix++) {
        linkobject = document.getElementById("href"+ix);
        if(linkobject) {
          if(currlinkvalue == ix) {
            linkobject.style.background="#ff9900";
          } else {
            linkobject.style.background="#ff9900";
          }
        }
      }

    </script>

<authz:authorize ifAnyGranted="ROLE_ADMINISTRATOR">
<%
	com.jaspersoft.jasperserver.war.common.HeartbeatBean heartbeat = (com.jaspersoft.jasperserver.war.common.HeartbeatBean)
			application.getAttribute("heartbeatBean");
	if (heartbeat != null && heartbeat.haveToAskForPermissionNow())
	{
%>
	<jsp:include page="../jsp/heartbeatOptin.jsp"/>
<%
	}
%>
</authz:authorize>

    </body>
    </html>
    </c:when>

    <c:otherwise>
        <html>
            <head>
                <title><spring:message code='decorators.main.title'/></title>
                <meta http-equiv="Content-Type" content="text/html; charset=${requestScope['com.jaspersoft.ji.characterEncoding']}">
                <link href="${pageContext.request.contextPath}/stylesheets/stylesheet.css" rel="stylesheet" type="text/css">
                <decorator:head />
            </head>
            <body style="color: black; background-color: white; margin-left: 2px; margin-right: 2px; margin-top: 2px;">
                <decorator:body />
            </body>
        </html>
    </c:otherwise>
</c:choose>

