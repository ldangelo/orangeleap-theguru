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
<%@ taglib uri="/spring" prefix="spring"%>
<%@taglib uri="/WEB-INF/jasperserver.tld" prefix="js" %>

<c:set var="maxMultiSelectSize" value="7"/>

<input type="hidden" name="report" value="${param.report}"/>
<table cellpadding="1" cellspacing="0" border="0">
	<c:forEach items="${requestScope.wrappers}" var="wrapper">
		<c:set value="${wrapper.inputControl}" var="control" scope="page"/>
		<c:set value="${inputNamePrefix}${control.name}" var="inputName"/>
		<c:set value="${readOnlyForm or control.readOnly}" var="readOnly"/>
		<c:if test="${!control.visible}">
			<input type="hidden" name="<c:out value="${inputName}"/>" value="${wrapper.formattedValue}"/>
		</c:if>
		<c:if test="${control.visible}">
		<tr>
			<c:choose>
				<c:when test="${control.type == 1}">  <%-- Boolean : InputControl.TYPE_BOOLEAN --%>
					<td align="right" nowrap="nowrap"><js:inputControlLabel control="${wrapper}"/>&nbsp;</td>
					<td>
                      <input type="checkbox" name="<c:out value="${inputName}"/>" class="fnormal" <c:if test="${readOnly}">disabled</c:if> <c:if test="${wrapper.value}">checked</c:if>
                      	onchange="${onInputChange}"/>
					</td>
				</c:when>
				<c:when test="${control.type == 2}">  <%-- Single value : InputControl.TYPE_SINGLE_VALUE --%>
					<td align="right" nowrap="nowrap"><js:inputControlLabel control="${wrapper}"/>&nbsp;</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${control.dataType.localResource.type == 3}">
								<js:calendarInput name="${inputName}" value="${wrapper.formattedValue}"
									formatPattern="${requestScope.calendarDatePattern}"
									readOnly="${readOnly}" time="false"
									imageTipMessage="jsp.defaultParametersForm.pickDate"
									onchange="${onInputChange}"/>
							</c:when>
							<c:when test="${control.dataType.localResource.type == 4}">
								<js:calendarInput name="${inputName}" value="${wrapper.formattedValue}"
									formatPattern="${requestScope.calendarDatetimePattern}"
									readOnly="${readOnly}"
									imageTipMessage="jsp.defaultParametersForm.pickDate"
									onchange="${onInputChange}"/>
							</c:when>
							<c:otherwise>
								<input type="text" name="<c:out value="${inputName}"/>" id="<c:out value="${inputName}"/>" class="fnormal" value="<c:out value="${wrapper.formattedValue}"/>" <c:if test="${readOnly}">disabled</c:if>
									onchange="${onInputChange}"/>
							</c:otherwise>
						</c:choose>
					</td>
				</c:when>

				<c:when test="${control.type == 3}">  <%-- Single value selected from list: InputControl.TYPE_SINGLE_SELECT_LIST_OF_VALUES --%>
					<td align="right" nowrap="nowrap"><js:inputControlLabel control="${wrapper}"/>	&nbsp;</td>
					<td>
						<select name="<c:out value="${inputName}"/>" class="fnormal" <c:if test="${readOnly}">disabled</c:if>
							onchange="${onInputChange}">
							<c:if test="${!control.mandatory}"><option value="" <c:if test="${wrapper.value}">selected</c:if>/></c:if>
							<c:forEach items="${control.listOfValues.localResource.values}" var="item">
								<option value="<c:out value="${item.value}"/>" <c:if test="${wrapper.value == item.value}">selected</c:if>><c:out value="${item.label}"/></option>
							</c:forEach>
						</select>
					</td>
				</c:when>

				<c:when test="${control.type == 6}">  <%-- Multi value selected from list: InputControl.TYPE_MULTI_SELECT_LIST_OF_VALUES --%>
					<td align="right" nowrap="nowrap"><js:inputControlLabel control="${wrapper}"/>&nbsp;</td>
					<td>
						<select name="<c:out value="${inputName}"/>" class="fnormal" multiple="multiple"
							<c:choose>
								<c:when test="${wrapper.collectionSize le maxMultiSelectSize}">
									size="${wrapper.collectionSize}"
								</c:when>
								<c:otherwise>
									size="${maxMultiSelectSize}"
								</c:otherwise>
							</c:choose>
							<c:if test="${readOnly}">disabled</c:if>
							onchange="${onInputChange}"
						>
							<c:forEach items="${control.listOfValues.localResource.values}" var="item">
								<option value="<c:out value="${item.value}"/>"
									<c:if test="${wrapper.collectionValueIndicator[item.value]}">selected="selected"</c:if>
								><c:out value="${item.label}"/></option>
							</c:forEach>
						</select>
					</td>
				</c:when>

				<c:when test="${control.type == 4}">  <%-- Single value selected from list created from a query: InputControl.TYPE_SINGLE_SELECT_QUERY --%>
					<td align="right" nowrap="nowrap"><js:inputControlLabel control="${wrapper}"/>	&nbsp;</td>
					<td>
						<select name="<c:out value="${inputName}"/>" class="fnormal" <c:if test="${readOnly}">disabled</c:if>
							onchange="${onInputChange}">
							<c:if test="${!control.mandatory}"><option value="" /></c:if>
							<c:forEach items="${wrapper.queryResults}" var="item" varStatus="status">
								<option value="<c:out value="${item.key}"/>" <c:if test="${item.key == wrapper.value}">selected</c:if>><c:out value="${item.value[1]}"/></option>
							</c:forEach>
						</select>
					</td>
				</c:when>

				<c:when test="${control.type == 7}">  <%-- Multi value selected from list created from a query: InputControl.TYPE_MULTI_SELECT_QUERY --%>
					<td align="right" nowrap="nowrap"><js:inputControlLabel control="${wrapper}"/>&nbsp;</td>
					<td>
						<select name="<c:out value="${inputName}"/>" class="fnormal" multiple="multiple"
							<c:choose>
								<c:when test="${wrapper.collectionSize le maxMultiSelectSize}">
									size="${wrapper.collectionSize}"
								</c:when>
								<c:otherwise>
									size="${maxMultiSelectSize}"
								</c:otherwise>
							</c:choose>
							<c:if test="${readOnly}">disabled</c:if>
							onchange="${onInputChange}"
						>
							<c:forEach items="${wrapper.queryResults}" var="item" varStatus="status">
								<option value="<c:out value="${item.key}"/>"
									<c:if test="${wrapper.collectionValueIndicator[item.value[0]]}">selected="selected"</c:if>
								><c:out value="${item.value[1]}"/></option>
							</c:forEach>
						</select>
					</td>
				</c:when>

				<c:when test="${control.type == 8}">  <%-- InputControl.TYPE_SINGLE_SELECT_LIST_OF_VALUES_RADIO --%>
					<td align="right" nowrap="nowrap"><js:inputControlLabel control="${wrapper}"/>&nbsp;</td>
					<td>
						<c:forEach items="${control.listOfValues.localResource.values}" var="item" varStatus="it">
							<c:if test="${it.count > 1}">
					</td>
		</tr>
		<tr>
					<td align="right">&nbsp;</td>
					<td>
							</c:if>
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td>
										<input type="radio" name="<c:out value="${inputName}"/>" value="<c:out value="${item.value}"/>" class="fnormal"
											<c:if test="${wrapper.value == item.value}">checked="checked"</c:if>
											<c:if test="${readOnly}">disabled="disabled"</c:if>
											onchange="${onInputChange}"
										/>
									</td>
									<td>&nbsp;</td>
									<td>
										<c:out value="${item.label}"/>
									</td>
									<c:if test="${it.count == 1 and !control.mandatory}">
										<td>&nbsp;&nbsp;&nbsp;</td>
										<td>
											<input type="button" value="<spring:message code="button.reset"/>" class="fnormal"
												onclick="if (resetRadio(this.form.${inputName})) { ${onInputChange}; }"/>
										</td>
									</c:if>
								</tr>
							</table>
						</c:forEach>
					</td>
				</c:when>

				<c:when test="${control.type == 9}">  <%-- InputControl.TYPE_SINGLE_SELECT_QUERY_RADIO --%>
					<td align="right" nowrap="nowrap"><js:inputControlLabel control="${wrapper}"/>&nbsp;</td>
					<td>
						<c:forEach items="${wrapper.queryResults}" var="item" varStatus="it">
							<c:if test="${it.count > 1}">
					</td>
		</tr>
		<tr>
					<td align="right">&nbsp;</td>
					<td>
							</c:if>
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td>
										<input type="radio" name="<c:out value="${inputName}"/>" value="<c:out value="${item.key}"/>" class="fnormal"
											<c:if test="${wrapper.value == item.key}">checked="checked"</c:if>
											<c:if test="${readOnly}">disabled="disabled"</c:if>
											onchange="${onInputChange}"
										/>
									</td>
									<td>&nbsp;</td>
									<td>
										<c:out value="${item.value[1]}"/>
									</td>
									<c:if test="${it.count == 1 and !control.mandatory}">
										<td>&nbsp;&nbsp;&nbsp;</td>
										<td>
											<input type="button" value='<spring:message code="button.reset"/>' class="fnormal"
												onclick="if (resetRadio(this.form.${inputName})) { ${onInputChange}; }"/>
										</td>
									</c:if>
								</tr>
							</table>
						</c:forEach>
					</td>
				</c:when>

				<c:when test="${control.type == 10}">  <%-- InputControl.TYPE_MULTI_SELECT_LIST_OF_VALUES_CHECKBOX --%>
					<td align="right" nowrap="nowrap"><js:inputControlLabel control="${wrapper}"/>&nbsp;</td>
					<td>
						<c:forEach items="${control.listOfValues.localResource.values}" var="item" varStatus="it">
							<c:if test="${it.count > 1}">
					</td>
		</tr>
		<tr>
					<td align="right">&nbsp;</td>
					<td>
							</c:if>
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td>
										<input type="checkbox" name="<c:out value="${inputName}"/>" value="<c:out value="${item.value}"/>" class="fnormal"
											<c:if test="${readOnly}">disabled="disabled"</c:if>
											<c:if test="${wrapper.collectionValueIndicator[item.value]}">checked="checked"</c:if>
											onchange="${onInputChange}"
										/>
									</td>
									<td>&nbsp;</td>
									<td>
										<c:out value="${item.label}"/>
									</td>
								</tr>
							</table>
						</c:forEach>
					</td>
				</c:when>

				<c:when test="${control.type == 11}">  <%-- InputControl.TYPE_MULTI_SELECT_QUERY_CHECKBOX --%>
					<td align="right" nowrap="nowrap"><js:inputControlLabel control="${wrapper}"/>&nbsp;</td>
					<td>
						<c:forEach items="${wrapper.queryResults}" var="item" varStatus="it">
							<c:if test="${it.count > 1}">
					</td>
		</tr>
		<tr>
					<td align="right">&nbsp;</td>
					<td>
							</c:if>
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td>
										<input type="checkbox" name="<c:out value="${inputName}"/>" value="<c:out value="${item.key}"/>" class="fnormal"
											<c:if test="${readOnly}">disabled="disabled"</c:if>
											<c:if test="${wrapper.collectionValueIndicator[item.value[0]]}">checked="checked"</c:if>
											onchange="${onInputChange}"
										/>
									</td>
									<td>&nbsp;</td>
									<td>
										<c:out value="${item.value[1]}"/>
									</td>
								</tr>
							</table>
						</c:forEach>
					</td>
				</c:when>

				<c:otherwise>
					<td align="right" nowrap="nowrap"><c:out value="${control.label}"/>&nbsp;</td><td><b><spring:message code="jsp.defaultParametersForm.notImplemented"/></b></td>
				</c:otherwise>

			</c:choose>
		</tr>
		</c:if>

		<c:if test="${wrapper.errorMessage!=null}">
		<tr>
			<td>&nbsp;</td>
			<td><span class="ferror"><c:out value="${wrapper.errorMessage}"/></span></td>
		</tr>
		</c:if>
	</c:forEach>
</table>
