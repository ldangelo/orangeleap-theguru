<%@ include file="/WEB-INF/jsp/include.jsp" %>
<tiles:useAttribute name="primaryNav" />
<tiles:useAttribute name="secondaryNav" />
<!--
<div id="banner">
	<ol>
		<li>
			<span id="greeting">Logged in as RSMITH</span>
		</li>
		<li>
			<a href="#">Your Account</a>
		</li>
		<li>
			<a href="#">Help</a>
		</li>
		<li>
			<a href="#">Logout</a>
		</li>
	</ol>
</div>
-->
<div id="navmain">
	<div class="navLeftCap"></div>

<div class="container">
	<ul class="primaryNav">

<li>
	<a onclick="triggerClick(document.getElementById('saveReportHiddenInput'));">Save Report</a>
</li>

<li>
	<a onclick="triggerClick(document.getElementById('reportCriteriaHiddenInput'));">Report Criteria</a>
</li>

<li>
	<a onclick="triggerClick(document.getElementById('reportContentHiddenInput'));">Report Content</a>
</li>

<li>
	<a onclick="triggerClick(document.getElementById('reportFormatHiddenInput'));">Report Format</a>
</li>

<li>
	<a onclick="triggerClick(document.getElementById('reportDataHiddenInput'));">Report Data</a>
</li>
</ul>
<c:choose>
<c:when test="${page == 0}">
	 Step ${page+1} of ${maxpages+1}: Select report data source
</c:when>

<c:when test="${page == 1}">
	 Step ${page+1} of ${maxpages+1}: Select report format
</c:when>

<c:when test="${page == 2}">
	 Step ${page+1} of ${maxpages+1}: Select report content
</c:when>

<c:when test="${page == 3}">
	 Step ${page+1} of ${maxpages+1}: Select report criteria
</c:when>

<c:when test="${page == 4}">
	 Step ${page+1} of ${maxpages+1}: Save report
</c:when>
</c:choose>


	
		<div class="clearBoth"></div>
	</div>
	<div class="navRightCap"></div>
</div>