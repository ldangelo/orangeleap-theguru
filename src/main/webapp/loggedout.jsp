<html>
<head>
</head>

	    <body>
	       
	        <iframe id="casLogout" src="/<%= System.getProperty("contextPrefix") %>cas/logout" height="0" width="100%" style="display: none"></iframe>
	        <%@ include file="/clearcookies.jsp"%>
	        <script>
	        window.location.href="index.htm";
	        </script>
 	    </body>
	    
</html>