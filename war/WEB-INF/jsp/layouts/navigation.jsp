<%@ include file="/WEB-INF/jsp/include.jsp" %>
<tiles:useAttribute name="primaryNav" />
<tiles:useAttribute name="secondaryNav" />
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

<div id="navmain">
	<div class="navLeftCap"></div>

<div class="container">
	<ul class="primaryNav">
		<li>
		  <c:if test="${page > 2}">
		  Jump to Step		    
		    <select>
		      <option>Report Format</option>
		      <option>Select Columns</option>
		      <option>Summary Information</option>
		      <option>Order Columns</option>
		      <option>Filter Report</option>
		      <option>Run Report</option>
		    </select>
		  </c:if>
</li>

<c:choose>
<c:when test="${page == 0}">
	 Step ${page} of ${maxpages}: Select report type
</c:when>

<c:when test="${page == 1}">
	 Step ${page} of ${maxpages}: Select report sub-type
</c:when>

<c:when test="${page == 2}">
	 Step ${page} of ${maxpages}: Select report format
</c:when>

<c:when test="${page == 3}">
	 Step ${page} of ${maxpages}: Select report columns
</c:when>

<c:when test="${page == 4}">
	 Step ${page} of ${maxpages}: Select information to summarize
</c:when>

<c:when test="${page == 5}">
	 Step ${page} of ${maxpages}: Order report columns
</c:when>


<c:when test="${page == 6}">
	 Step ${page} of ${maxpages}: Select report criteria
</c:when>





</c:choose>


</ul>	
		<div class="clearBoth"></div>
	</div>
	<div class="navRightCap"></div>
</div>
