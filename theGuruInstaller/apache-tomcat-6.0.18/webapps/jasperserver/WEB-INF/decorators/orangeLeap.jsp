<%@ taglib prefix="spring" uri="/spring" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %> 	
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://acegisecurity.org/authz" prefix="authz"%>
<html>
	<head>
		<title><spring:message code='jsp.main.title'/></title>
    	<decorator:head />
    </head>
    <body class="orangeleap" >
		<decorator:body />
    </body>
</html>

