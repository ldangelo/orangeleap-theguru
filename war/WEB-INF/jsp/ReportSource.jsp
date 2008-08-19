<%@ include file="/WEB-INF/jsp/include.jsp" %>

<tiles:insertDefinition name="base">
	<tiles:putAttribute name="browserTitle" value="MPower Reports Wizard" />
	<tiles:putAttribute name="primaryNav" value="MPowerOpen Reports Wizard" />
	<tiles:putAttribute name="secondaryNav" value="Search" />
	<tiles:putAttribute name="mainContent" type="string">
		<div class="content760 mainForm test">
			<jsp:include page="reportSourceForm.jsp"/>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
