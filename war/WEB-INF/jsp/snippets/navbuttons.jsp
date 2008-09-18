<%@ include file="/WEB-INF/jsp/include.jsp" %>

<div class="addbuttonposition">
<table>
<tr>
<td align="Left" width=360>
<c:if test="${page > 1}">
<input type="image" src="images/run_report_off.gif" value="Run Report" ALT="Run Report" name="_target12" onmouseover="this.src = 'images/run_report_on.gif';" onmouseout="this.src = 'images/run_report_off.gif';">
<input type="image" src="images/export_details_off.gif" value="Export Details" name="_target11" ALT="Export" onmouseover="this.src = 'images/export_details_on.gif';" onmouseout="this.src = 'images/export_details_off.gif';">
<input type="image" src="images/save_as_off.gif" value="Save As" name="_target8" ALT="Save" onmouseover="this.src = 'images/save_as_on.gif';" onmouseout="this.src = 'images/save_as_off.gif';">
</c:if>
</td>

<td align="Right" width=360>
<c:if test="${page == 0}">
<input type="image" src="images/cancel_off.gif" value="Cancel" name="_cancel" ALT="Cancel" onmouseover="this.src = 'images/cancel_on.gif';" onmouseout="this.src = 'images/cancel_off.gif';">
</c:if>

<c:if test="${page > 0}">
<input type="image" src="images/back_off.gif" value="Back" ALT="Back" name="_target${page-1}" onmouseover="this.src = 'images/back_on.gif';" onmouseout="this.src = 'images/back_off.gif';">
</c:if>

<c:if test="${page < maxpages}">
<input type="image" src="images/next_off.gif"  value="Next" ALT="Next" name="_target${page+1}" onmouseover="this.src = 'images/next_on.gif';" onmouseout="this.src = 'images/next_off.gif';">
</c:if>
</tr>
</td>
</table>
</div>


