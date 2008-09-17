<%@ include file="/WEB-INF/jsp/include.jsp" %>

<div class="addbuttonposition">
<table>
<tr>
<td align="Left" width=360>
<c:if test="${page > 1}">
<input type="image" src="images/run_report_off.gif" value="Run Report" ALT="Run Report" name="_target12" onmouseover="this.src = 'images/run_report_on.gif';" onmouseout="this.src = 'images/run_report_off.gif';">
<input type="image" src="images/save_as_off.gif" value="Save As" name="_target8" ALT="Save" onmouseover="this.src = 'images/save_as_on.gif';" onmouseout="this.src = 'images/save_as_off.gif';">
</c:if>
</td>
</tr>
</td>
</table>
</div>


