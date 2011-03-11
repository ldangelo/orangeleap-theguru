<%@ include file="/WEB-INF/jsp/include.jsp"%>

<tiles:insertDefinition name="base">
	<tiles:putAttribute name="browserTitle" value="Orange Leap Reports Wizard" />
	<tiles:putAttribute name="primaryNav" value="Orange Leap Reports Wizard" />
	<tiles:putAttribute name="secondaryNav" value="Search" />
	<tiles:putAttribute name="mainContent" type="string">

		<form:form name="myform" method="post" commandName="reportsource">
			<div class="buttonposition"></div>
<br>
<p align="center">
					<%
					String contextPrefix = System.getProperty("contextPrefix");
					if (contextPrefix == null) contextPrefix = "";
					pageContext.setAttribute("contextPrefix",contextPrefix);
					%>

			<iframe
				src="/${contextPrefix}jasperserver/flow.html?_flowId=reportPreviewJobFlow&reportUnitURIRequest=${reportPath}&standAlone=false&ParentFolderUri=/reports/Clementine/Temp"
				width="97%" height="700px" onload="hideJasperMenuRows();"> </iframe>
</p>
			<input type="image" id="reportDataHiddenInput" name="_target0"
				value="Report Data" style="display: none">
			<input type="image" id="reportFormatHiddenInput" name="_target1"
				value="Report Format" style="display: none">
			<input type="image" id="reportContentHiddenInput" name="_target2"
				value="Report Content" style="display: none">
			<input type="image" id="reportCriteriaHiddenInput" name="_target3"
				value="Report Criteria" style="display: none">
			<input type="image" id="saveReportHiddenInput" name="_target4"
				value="Save Report" style="display: none">
			<jsp:include page="snippets/navbuttons.jsp" />
		</form:form>
	</tiles:putAttribute>
</tiles:insertDefinition>
