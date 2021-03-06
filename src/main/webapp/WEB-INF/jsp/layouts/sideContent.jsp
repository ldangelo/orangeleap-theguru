<%@ include file="/WEB-INF/jsp/include.jsp" %>
<tiles:useAttribute name="sidebarNav" ignore="true" />
<div class="sideBar">
	<div class="wrapper">
		<div class="innerContent" style="height:600px;">
			<h3>
				Search People
			</h3>
			<form method="post" action="personSearch.htm">
				<input size="18" id="sidebarsearch" name="lastName" />
				<input type="submit" value="Go" />
			</form>
			<a style="font-size:10px;" href="personSearch.htm">Advanced Search</a>
			<br />
			<br />
			<c:if test="${viewingAccount && sidebarNav != null}">
				<h3>
					Person Options
				</h3>
				<div class="accountOptions">
					<a class="${sidebarNav=='Profile'?'active':''}" href="person.htm?personId=${person.id}">Profile</a>
					<a class="${sidebarNav=='Enter Gift'?'active':''}" href="gift.htm?personId=${person.id}">Enter Gift</a>
					<a class="${sidebarNav=='Gift History'?'active':''}" href="giftList.htm?personId=${person.id}">Gift History</a>
					<a href="#">Addresses</a>
					<a href="#">Billing</a>
					<a href="#">Account Statement</a>
					<a href="#">Codes</a>
					<a href="#">Notes</a>
					<a href="#">Dates</a>
					<a href="#">Pledges</a>
					<a href="#">Relationships</a>
					<a href="#">Subscriptions</a>
				</div>
			</c:if>
<!-- 			<h3>
				My Tasks
			</h3>
			<div class="myTasks">
				<a href="#">Due Today <span href="#" class="taskCount">(1)</span></a>
				<a href="#">New Tasks <span href="#" class="taskCount">(3)</span></a>
				<a href="#">All Tasks (9)</a>
			</div> 
-->
		</div>
	</div>
</div>