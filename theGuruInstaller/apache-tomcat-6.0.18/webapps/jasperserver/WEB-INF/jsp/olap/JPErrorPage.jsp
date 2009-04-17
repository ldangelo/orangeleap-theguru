<%@ page isErrorPage="true" %>
<HTML>
<HEAD><TITLE>JPivot Error Page</TITLE></HEAD>
<BODY>
<H2>Exception Information</H2>
<TABLE>

<tr>
<td>Exception Class:</td>
<td><%= exception.getClass() %></td>
</tr>

<tr>
<td>Message:</td>
<td><%= exception.getMessage() %></td>
</tr>

<tr>
<td><A HREF="javascript:history.back()">Back</A></td>
</tr>

</TABLE>
</BODY>
</HTML>


 