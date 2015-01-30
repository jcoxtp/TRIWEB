<%
If Request.Cookies("login") <> "1" Then
	Response.Redirect("login.asp?res=" & intResellerID)
End If
%>
