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
<%@ taglib prefix="spring" uri="/spring" %>
<%@ taglib uri="sitemesh-decorator" prefix="decorator" %>
 <decorator:usePage id="myPage" />
 <html>
 <head>
 <title>Raz's Site -
    <decorator:title default="<spring:message code='decorators.metadata.welcome'/>" />
 </title>
 <decorator:head />
 </head>

 <body>
 <h1><decorator:title default="<spring:message code='decorators.metadata.welcome'/>" /></h1>
 <h3>
 <a href="mailto:<decorator:getProperty property="meta.author" 
            default="staff@example.com" />">
 <decorator:getProperty property="meta.author"
              default="<spring:message code='decorators.metadata.metaAuthor'/>" />
 </a></h3><hr />
 <decorator:body />
 <p><small>
    (<a href="?printable=true">printable version</a>)
    </small>
 </p>
 </body>
 </html>


