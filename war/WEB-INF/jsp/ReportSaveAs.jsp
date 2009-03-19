<%@ include file="/WEB-INF/jsp/include.jsp" %>

<tiles:insertDefinition name="base">
	<tiles:putAttribute name="browserTitle" value="Save Report" />
	<tiles:putAttribute name="primaryNav" value="The Guru" />
	<tiles:putAttribute name="secondaryNav" value="Search" />
	<tiles:putAttribute name="mainContent" type="string">
		<div id="formContent" class="content760 mainForm test">
			<jsp:include page="reportSaveAsForm.jsp"/>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
