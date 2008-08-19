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
		      <option <c:if test="${page}=2}> selected="selected"</c:if>>Report Format</option>
		      <option>Select Columns</option>
		      <option>Summary Information</option>
		      <option>Order Columns</option>
		      <option>Filter Report</option>
		      <option>Run Report</option>
		    </select>
		  </c:if>
			      
		</li>

		<div class="clearBoth"></div>
		<ul class="secondaryNav">
		<li>
		Step ${page} of ${maxpages}
		</li>
<!--  			<li>
				<a href="personSearch.htm" class="${secondaryNav=='Search'?'active':''}">Search</a>
			</li>
			<li>
				<a href="person.htm" class="${secondaryNav=='Edit'?'active':''}">Edit</a>
			</li>
			<li>
				<a href="#">Codes</a>
			</li>
			<li>
				<a href="#">Correspond</a>
			</li>
			<li>
				<a href="#">Distribution Lists</a>
			</li>
			<li>
				<a href="#">Query Builder</a>
			</li>
		</ul>
-->		
		<div class="clearBoth"></div>
	</div>
	<div class="navRightCap"></div>

</div>
