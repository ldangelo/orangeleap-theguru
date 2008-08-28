<%@ include file="/WEB-INF/jsp/include.jsp" %>

<c:if test="${page > 1}">
<input type="image" src="images/run_report_off.gif" value="Run Report" ALT="Finish" name="_finish">
<input type="image" src="images/export_details_off.gif" value="Export Details" ALT="Export">
<input type="image" src="images/save_as_off.gif" value="Save As" ALT="Save">
<input type="image" src="images/back_off.gif" value="Back" ALT="Back" name="_target${page-1}">
</c:if>
<c:if test="${page < maxpages}">
<input type="image" src="images/next_off.gif"  value="Next" ALT="Next" name="_target${page+1}">
</c:if>


<c:if test="${page == 0}">
<input type="image" src="images/cancel_off.gif" value="Cancel" name="_cancel" ALT="Save">
</c:if>


<c:if test="${page == 1}">
<input type="image" src="images/back_off.gif" value="Back" ALT="Back" name="_target${page-1}">
</c:if>
