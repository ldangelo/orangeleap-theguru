<%@ include file="/WEB-INF/jsp/include.jsp" %>
<tiles:insertDefinition name="base">
	<tiles:putAttribute name="browserTitle" value="Report Criteria" />
	<tiles:putAttribute name="primaryNav" value="The Guru" />
	<tiles:putAttribute name="secondaryNav" value="Search" />
	<tiles:putAttribute name="mainContent" type="string">
		<div class="content760 mainForm test">
			<jsp:include page="reportFilterForm.jsp"/>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
