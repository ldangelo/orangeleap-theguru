	<%@ include file="/WEB-INF/jsp/include.jsp" %>
	<form:errors path="*">
	<div class="globalFormErrors">
		<h5>The following errors need correction:</h5>
		<ul>
			<c:forEach items="${messages}" var="message">
				<li><c:out value='${message}'/></li>
			</c:forEach>
		</ul>
	</div>
</form:errors>