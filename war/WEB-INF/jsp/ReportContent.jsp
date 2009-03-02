<%@ include file="/WEB-INF/jsp/include.jsp" %>
<tiles:insertDefinition name="base">
	<tiles:putAttribute name="browserTitle" value="Orange Leap Reports Wizard" />
	<tiles:putAttribute name="primaryNav" value="Orange Leap Reports Wizard" />
	<tiles:putAttribute name="secondaryNav" value="Search" />
	<tiles:putAttribute name="mainContent" type="string">
		<div class="content760 mainForm test">
			<c:if test='${reportType != "matrix" }'>
				<jsp:include page="reportColumnsForm.jsp"/>
			</c:if>
			<c:if test='${reportType == "matrix" }'>
				<jsp:include page="reportMatrixForm.jsp"/>
			</c:if>			
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
