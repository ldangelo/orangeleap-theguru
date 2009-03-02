<%@ include file="/WEB-INF/jsp/include.jsp" %>

<tiles:insertDefinition name="base">
	<tiles:putAttribute name="browserTitle" value="Orange Leap Wizard" />
	<tiles:putAttribute name="primaryNav" value="Orange Leap Reports Wizard" />
	<tiles:putAttribute name="secondaryNav" value="Search" />
	<tiles:putAttribute name="mainContent" type="string">
		<div id="formContent" class="content760 mainForm test">
			<jsp:include page="reportSaveAsForm.jsp"/>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
