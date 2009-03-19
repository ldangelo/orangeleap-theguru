<%@ include file="/WEB-INF/jsp/include.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"">
    
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
	<head>
		<title>The Guru - <tiles:getAsString name="browserTitle"/></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<tiles:insertAttribute name="headContent" />
	</head>


	<body>
	
		<div class="bodyContent">
			<tiles:useAttribute name="primaryNav" />
			<tiles:useAttribute name="secondaryNav" />
			<tiles:useAttribute name="sidebarNav" ignore="true" />
			<tiles:insertAttribute name="navigation">
				<tiles:putAttribute name="primaryNav" value="${primaryNav}" />
				<tiles:putAttribute name="secondaryNav" value="${secondaryNav}" />					
			</tiles:insertAttribute>
			<div class="clearBoth"></div>
			<tiles:insertAttribute name="mainContent" />
			<div class="clearBoth"></div>
			<tiles:insertAttribute name="footer" />
		</div>
	</body>
</html>