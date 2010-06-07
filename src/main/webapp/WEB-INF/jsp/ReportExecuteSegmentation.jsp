<%@ include file="/WEB-INF/jsp/include.jsp" %>

<tiles:insertDefinition name="base">
	<tiles:putAttribute name="browserTitle" value="Segmentation Results" />
	<tiles:putAttribute name="primaryNav" value="The Guru" />
	<tiles:putAttribute name="secondaryNav" value="Search" />
	<tiles:putAttribute name="mainContent" type="string">
		<div id="formContent" class="content760 mainForm test">
			<jsp:include page="reportSegmentationExecutionResultsForm.jsp"/>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
