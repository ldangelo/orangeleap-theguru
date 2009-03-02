<%@ include file="/WEB-INF/jsp/include.jsp"%>

<tiles:insertDefinition name="base">
	<tiles:putAttribute name="browserTitle" value="Orange Leap Reports Wizard" />
	<tiles:putAttribute name="primaryNav" value="Orange Leap Reports Wizard" />
	<tiles:putAttribute name="secondaryNav" value="Search" />
	<tiles:putAttribute name="mainContent" type="string">
		<div class="content760 mainForm test">
			<c:choose>
				<c:when test='${userFound}'>
					<jsp:include page="reportSourceForm.jsp" />
				</c:when>
				<c:otherwise>
					<%
					String contextPrefix = System.getProperty("contextPrefix");
					if (contextPrefix == null) contextPrefix = "";
					pageContext.setAttribute("contextPrefix",contextPrefix);
					%>
					<c:redirect url="../${contextPrefix}jasperserver" />
				</c:otherwise>
			</c:choose>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
