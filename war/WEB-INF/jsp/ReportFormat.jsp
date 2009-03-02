<%@ include file="/WEB-INF/jsp/include.jsp" %>
<tiles:insertDefinition name="base">
	<tiles:putAttribute name="browserTitle" value="Search People" />
	<tiles:putAttribute name="primaryNav" value="Orange Leap Reports Wizard" />
	<tiles:putAttribute name="secondaryNav" value="Search" />
	<tiles:putAttribute name="mainContent" type="string">
		<div class="content760 mainForm test">
			<jsp:include page="reportFormatForm.jsp"/>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
