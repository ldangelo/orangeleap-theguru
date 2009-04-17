<%@ page import="com.jaspersoft.jasperserver.war.dto.StringOption"%>
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

<%@ page language="java" contentType="text/html" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title><spring:message code="jsp.jndiPropsForm.title"/></title>
 <script>
    function jumpTo(pageTo){
    document.forms[0].jumpToPage.value=pageTo;
    document.forms[0].jumpButton.click();
    }
 </script>
</head>
    
<body>

<FORM name="fmJNDIProps" action="" method="post">
<table width="100%" border="0" cellpadding="20" cellspacing="0">
  <tr valign="top">
<c:if test='${masterFlow == "reportUnit"}'>
<c:choose>
<c:when test='${dataResource.parentType == "reportUnit"}'>
    <td width="1">
<table width="100%" border="0" cellpading="0" cellspacing="0">
  <tr><td nowrap="true"><a class="wizard_menu" href="javascript:jumpTo('reportNaming');"><spring:message code="jsp.reportWizard.naming"/></a></td></tr>
  <tr><td nowrap="true"><a class="wizard_menu" href="javascript:jumpTo('jrxmlUpload');"><spring:message code="jsp.reportWizard.jrxml"/></a></td></tr>
  <tr><td nowrap="true"><a class="wizard_menu" href="javascript:jumpTo('resources');"><spring:message code="jsp.reportWizard.resources"/></a></td></tr>
  <tr><td nowrap="true"><a class="wizard_menu_current" href="javascript:jumpTo('dataSource');"><spring:message code="jsp.reportWizard.dataSource"/></a></td></tr>
  <tr><td nowrap="true"><a class="wizard_menu" href="javascript:jumpTo('query');"><spring:message code="jsp.reportWizard.query"/></a></td></tr>
  <tr><td nowrap="true"><a class="wizard_menu" href="javascript:jumpTo('customization');"><spring:message code="jsp.reportWizard.customization"/></a></td></tr>
</table>
    </td>
</c:when>
<c:otherwise>
    <td width="1">
<table width="100%" border="0" cellpading="0" cellspacing="0">
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.naming"/></span></td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.jrxml"/></span></td></tr>
  <tr><td nowrap="true">
  <c:choose>
  <c:when test='${masterFlowStep == "resources"}'>
    <a class="wizard_menu_current" href="javascript:document.forms[0]._eventId_Cancel.click();"><spring:message code="jsp.reportWizard.resources"/></a>  
  </c:when>
  <c:otherwise>
    <span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.resources"/></span>  
  </c:otherwise>
  </c:choose>
  </td></tr>
  <tr><td nowrap="true">
  <c:choose>
  <c:when test='${masterFlowStep == "dataSource"}'>
    <a class="wizard_menu_current" href="javascript:document.forms[0]._eventId_Cancel.click();"><spring:message code="jsp.reportWizard.dataSource"/></a>  
  </c:when>
  <c:otherwise>
    <span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.dataSource"/></span>  
  </c:otherwise>
  </c:choose>
  </td></tr>
  <tr><td nowrap="true">
  <c:choose>
  <c:when test='${masterFlowStep == "query"}'>
    <a class="wizard_menu_current" href="javascript:document.forms[0]._eventId_Cancel.click();"><spring:message code="jsp.reportWizard.query"/></a>  
  </c:when>
  <c:otherwise>
    <span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.query"/></span>  
  </c:otherwise>
  </c:choose>
  </td></tr>
  <tr><td nowrap="true"><span class="wizard_menu_disabled"><spring:message code="jsp.reportWizard.customization"/></span></td></tr>
</table>
    </td>
</c:otherwise>
</c:choose>
</c:if>
    <td>
            <table border="0" cellpadding="1" cellspacing="0" align="center">
                <tr>
                    <td>&nbsp;</td>
                    <td><span class="fsection"><spring:message code="${dataResource.customDatasourceLabel}"/></span></td>
                </tr>
                <tr><td colspan="2">&nbsp;</td></tr>
                <spring:bind path="dataResource.reportDataSource.name">
                    <tr align="center">
                        <td align="right">* <spring:message code="label.name"/>&nbsp;</td>
                        <td align="left"><input maxlength="100" name="${status.expression}" type="text" class="fnormal" size="40" <c:if test='${dataResource.aloneEditMode}'>disabled="true"</c:if> value="${status.value}"></td>
                    </tr>
                    <c:if test="${status.error}">
                    <tr>
                        <td>&nbsp;</td>
                        <td><span class="ferror">${status.errorMessage}</span></td>
                    </tr>
                    </c:if>
                </spring:bind>
                <spring:bind path="dataResource.reportDataSource.label">
                    <tr align="center">
                        <td align="right">* <spring:message code="label.label"/>&nbsp;</td>
                        <td align="left"><input maxlength="100" name="${status.expression}" type="text" class="fnormal" size="40" value="${status.value}"></td>
                    </tr>
                    <c:if test="${status.error}">
                    <tr>
                        <td>&nbsp;</td>
                        <td><span class="ferror">${status.errorMessage}</span></td>
                    </tr>
                    </c:if>
                </spring:bind>
                <spring:bind path="dataResource.reportDataSource.description">
					<tr>
						<td align="right" valign="top"><spring:message code="label.description"/>&nbsp;</td>
						<td align="left"><textarea name="${status.expression}" rows="5" cols="28" class="fnormal"><c:out value='${status.value}'/></textarea></td>
					</tr>
					<c:if test="${status.error}">
					<tr>
						<td>&nbsp;</td>
						<td><span class="ferror">${status.errorMessage}</span></td>
					</tr>
					</c:if>
                </spring:bind>
                <tr><td colspan="2">&nbsp;</td></tr>
                <c:forEach var="prop" items="${dataResource.customProperties}">
	                <spring:bind path="dataResource.reportDataSource.propertyMap[${prop.name}]">
	                    <tr>
	                        <td align="right">* <spring:message code="${prop.label}"/>&nbsp;</td>
	                        <td>
	                        	<c:choose>
	                        		<c:when test="${prop.textWidth != null && prop.textHeight != null}">
		                        		<textarea name="${status.expression}" rows="${prop.textHeight}" cols="${prop.textWidth}" class="fnormal"><c:out value='${status.value}'/></textarea>
	                        		</c:when>
	                        		<c:otherwise>
		                        		<input maxlength="100" name="${status.expression}" type="text" class="fnormal" size="40" value="${status.value}">
		                        	</c:otherwise>
	                        	</c:choose>
	                        </td>
	                    </tr>
	                    <c:if test="${status.error}">
	                    <tr>
	                        <td>&nbsp;</td>
	                        <td><span class="ferror">${status.errorMessage}</span></td>
	                    </tr>
	                    </c:if>
	                </spring:bind>
                </c:forEach>
<c:if test="${dataResource.subflowMode}">
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
				<tr>
					<td>
						<c:choose>
							<c:when test="${dataResource.editMode || dataResource.source=='CONTENT_REPOSITORY' && dataResource.reportDataSource.parentFolder!=null}">${dataResource.reportDataSource.parentFolder}</c:when>
							<c:otherwise> 
								<spring:bind path="dataResource.reportDataSource.parentFolder">
									<select name="${status.expression}" class="fnormal" onClick="document.forms[0].CONTENT_REPOSITORY.click();">
					
					<%-- bug #9008: like 'jdbcpropsform.jsp', the following is needed to specify a resource folder --%>
					
										<c:forEach items="${dataResource.allFolders}" var="folder">
											<option name="${folder}" 
												<c:if test='${status.value==folder}'>selected="true"</c:if>>${folder}
											</option>
										</c:forEach>
						
									</select>	                        
								</spring:bind>
								<c:if test="${status.error}"><BR><span class="ferror">${status.errorMessage}</span></c:if>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
</c:if>
			  <!-- TODO test hook
                <tr>
                	<td colspan="2">&nbsp;</td>
                </tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<input type="submit" class="fnormal" name="_eventId_testDataSource" value="<spring:message code="jsp.testConnection"/>"/>
						<c:if test="${requestScope['connection.test'] != null}">
							<c:if test="${requestScope['connection.test'] == true}">
								<spring:message code="jsp.testConnection.successful"/>
							</c:if>
							<c:if test="${requestScope['connection.test'] == false}">
								<spring:message code="jsp.testConnection.failed"/>
							</c:if>
						</c:if>
					</td>
				</tr>
			  -->
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr>
                    <td>&nbsp;</td>
                    <td>
                        <input type="submit" class="fnormal" name="_eventId_Cancel" value="<spring:message code="button.cancel"/>"/>&nbsp;
                        <c:if test="${!dataResource.aloneEditMode}">
                            <input type="submit" class="fnormal" name="_eventId_Back" value="<spring:message code="button.back"/>">&nbsp;
                        </c:if>
                        <c:choose>
                            <c:when test='${dataResource.subflowMode || dataResource.mode==0}'>
                                <input type="submit" class="fnormal" name="_eventId_Next" value="<spring:message code="button.next"/>">
                                <c:if test='${dataResource.parentType == "reportUnit"}'><input type="submit" class="fnormal" name="_eventId_Finish" value="<spring:message code="button.finish"/>"></c:if>
                            </c:when>
                            <c:otherwise>
                                <input type="submit" class="fnormal" name="_eventId_Save" value="<spring:message code="button.save"/>">
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </table>
            <input type="hidden" name="jumpToPage">
            <input type="submit" class="fnormal" style="visibility:hidden;" value="" name="_eventId_Jump" id="jumpButton">
            <input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
    </td>
  </tr>
</table>
</FORM>

</body>

</html>
