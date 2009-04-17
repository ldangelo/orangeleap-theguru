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

<%@ page import="java.io.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page language="java" isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="/spring" %>
<%@page import="com.jaspersoft.jasperserver.api.JSException"%>
<%@page import="com.jaspersoft.jasperserver.api.JSExceptionWrapper"%>
<%@page import="org.acegisecurity.AccessDeniedException"%>
<%@page import="org.springframework.webflow.conversation.NoSuchConversationException"%>

<%

    response.setHeader("JasperServerError", "true");

    Log log = LogFactory.getLog(this.getClass());

    Throwable ex = null;
    if(exception == null) {
        ex = request.getAttribute("stateException") != null ? (Exception) request.getAttribute("stateException") : (Exception) request.getAttribute("exception"); //from controllers or swf action
    }else {
        ex = (Throwable) exception;
    }
    if(ex != null &&
            !(ex instanceof JSException || ex instanceof AccessDeniedException || ex instanceof NoSuchConversationException) &&
            ex.getCause() != null){
        ex = (Throwable)ex.getCause();
    }
%>
<html>
<head>
<script language=JavaScript src="${pageContext.request.contextPath}/scripts/error.js"></script>
<title><spring:message code='jsp.JSErrorPage.title'/></title>
</head>
<body>
<form name="fmJsErrPage" method="post">
<input type="hidden" name="hideStackTrace" value="<spring:message code='jsp.JSErrorPage.hide.stacktrace'/>"/>
<input type="hidden" name="showStackTrace" value="<spring:message code='jsp.JSErrorPage.show.stacktrace'/>"/>
<input type="hidden" name="folderPath" value="${param.folderPath}"/>

<table cellpadding="8" cellspacing="0" width="100%" cols="4" border="0">
  <tr>
    <td colspan="4" class="fsection">
        <strong><spring:message code='jsp.JSErrorPage.errorMsg'/></strong>:&nbsp;
    </td>
  </tr>
  <tr>
    <td colspan="4">
        <% if(ex != null){
            if(ex instanceof JSException) {
                JSException jse = (JSException)ex;
                if(jse.isWrapperObject()){
                    if(jse.getCause()!= null && jse.getCause() instanceof AccessDeniedException){
            %>
                        <spring:message code="jsexception.access.denied"/>
            <%
                    }else if(jse.getCause()!= null && jse.getCause() instanceof NoSuchConversationException){
            %>
                        <spring:message code="jsexception.unable.to.complete.request"/>
            <%
                    }else if (jse instanceof JSExceptionWrapper && jse.getCause() != null &&
                            jse.getCause() instanceof JSException && !((JSException)jse.getCause()).isWrapperObject()){
                        jse = (JSException)jse.getCause();
            %>
                    <spring:message code='<%= jse.getMessage() %>' arguments='<%= jse.getArgs() %>' htmlEscape="true"/>
            <%
                    }else{
            %>
                        <spring:message code="jsexception.default.message"/>
                    <%}
                }else {%>
                    <spring:message code='<%= jse.getMessage() %>' arguments='<%= jse.getArgs() %>'/>
            <%  }
            }else if(ex instanceof AccessDeniedException){
            %>
                <spring:message code="jsexception.access.denied"/>

            <%}else if(ex instanceof NoSuchConversationException){%>

                <spring:message code="jsexception.unable.to.complete.request"/>
            <%
            }else{ %>
                <spring:message code="jsexception.default.message"/>
            <%}
        }else{%>
            <spring:message code="jsexception.default.message"/>
        <%}%>
   </td>
  </tr>
  <tr>
    <td colspan="4" height="8"></td>
  </tr>
  <tr>
    <td colspan="4">&nbsp;
        <input type="button" name="_eventId_HideShow" class="fnormal" value="<spring:message code='jsp.JSErrorPage.show.stacktrace'/>" onclick="javascript: hideShowStackTrace();"/>
        <c:if test="${not empty flowExecutionKey}">
            <input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
        </c:if>
        <c:if test="${not empty param.parentFlow}">
            <input type="hidden" name="_flowId" value="${param.parentFlow}"/>
        </c:if>
        <c:if test="${empty param.parentFlow}">
            <input type="hidden" name="_flowId" value="${flowId}"/>
        </c:if>
        
        <%  if(!(ex instanceof NoSuchConversationException)) { %>   <!-- BUG 10599 -->
          <c:if test="${not (conditionallyDisableBackButton and flowExecutionContext.activeSession.root and empty flowScope.prevForm)}">
            <input type="submit" id="errorBack" name="_eventId_backFromErrorPage" class="fnormal" value="<spring:message code='button.back'/>"/>
          </c:if>
        <%  }  %>
    </td>
  </tr>
  <tr>
    <td colspan="4" class="fsection">
    <div id="excptracetitle" style="overflow:auto; display:none">
        <b><spring:message code='jsp.JSErrorPage.errorTrace'/></b>:&nbsp;
    </div>
    </td>
  </tr>
  <tr>
    <td colspan="4">
        <div id="excptrace" style="top:3; height:270; overflow:auto; display:none">
            <%-- stackTrace --%>
<%
        Throwable e = ex;
      while (e != null) {
          pageContext.setAttribute("exceptionMessage", e.toString());

          StringWriter stackTraceWriter = new StringWriter();
          e.printStackTrace(new PrintWriter(stackTraceWriter));
          pageContext.setAttribute("exceptionStackTrace", stackTraceWriter.getBuffer());

        log.error("", e);
%>      
        <h3><c:out value="${exceptionMessage}"/></h3>
        <pre><c:out value="${exceptionStackTrace}"/></pre>
<%
        Throwable prev = e;
        e = e.getCause();
        if (e == prev)
          break;
      }
%>
        </div>
    </td>
  </tr>
  <tr>
    <td colspan="4" height="8"></td>
  </tr>
</table>

</form>
</body>
</html>
