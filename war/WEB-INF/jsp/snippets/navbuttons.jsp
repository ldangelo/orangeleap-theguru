<%@ include file="/WEB-INF/jsp/include.jsp" %>

<input type="submit" value="Run Report" name="_finish">
<input type="button" value="Export Details" value="export">
<input type="button" value="Save As" value="save">
<input type="submit" value="Back" name="_target${page-1}">
<c:if test="${page < maxpages}">
<input type="submit" value="Next" name="_target${page+1}">
</c:if>