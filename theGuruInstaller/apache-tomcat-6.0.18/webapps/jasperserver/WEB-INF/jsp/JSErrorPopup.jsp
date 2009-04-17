<%--
 Copyright (C) 2005 - 2007 JasperSoft Corporation.  All rights reserved.
 http://www.jaspersoft.com.

 Unless you have purchased a commercial license agreement from JasperSoft,
 the following license terms apply:

 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2 as published by
 the Free Software Foundation.

 This program is distributed WITHOUT ANY WARRANTY; and without the
 implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 See the GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, see http://www.gnu.org/licenses/gpl.txt
 or write to:

 Free Software Foundation, Inc.,
 59 Temple Place - Suite 330,
 Boston, MA  USA  02111-1307
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="/spring" %>

<table style="height: 550px; width: 750px; vertical-align: top;" border="0" cellpadding="0" cellspacing="0" class="dialogtable">
	<tr><td>
		<table class="dialogcontent" style="height: 100%; width: 100%;">
			<tr>
				<td id="errorPopupContents" class="dialogcell" style="padding-bottom:5px;padding-top:15px;" align="center" valign="top">
				</td>
			</tr>
			<tr height="30px">
				<td class="dialogcell" align="center" style="padding-bottom:8px;padding-top:8px;">
					<input id="errorPopupCloseButton" value="<spring:message code="button.close"/>" class="fnormal" type="button" onclick="hideErrorPopup()"/>
				</td>
			</tr>
		</table>
	</td></tr>
</table>
