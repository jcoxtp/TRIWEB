<%@ Language=VBScript %>
<!--#Include FILE="Include/CheckLogin.asp" -->
<%
Dim intResellerID
intResellerID = Request.Form("ResellerID")
If intResellerID = "" Then
	intResellerID = Request.QueryString("res")
End If
If intResellerID = "" Then
	intResellerID = 1
End If

Dim expirationDate
expirationDate = #January 01, 1980#

Response.Cookies("CompanyID").Expires = expirationDate
Response.Cookies("CompanyName").Expires = expirationDate
Response.Cookies("FirstName").Expires = expirationDate
Response.Cookies("LastName").Expires = expirationDate
Response.Cookies("Login").Expires = expirationDate
Response.Cookies("NoPDIPurch").Expires = expirationDate
Response.Cookies("URLInfo").Expires = expirationDate
Response.Cookies("fileNameInfo").Expires = expirationDate
Response.Cookies("qcompleted").Expires = expirationDate
Response.Cookies("UserID").Expires = expirationDate
Response.Cookies("UserName").Expires = expirationDate
Response.Cookies("UserType").Expires = expirationDate
Response.Cookies("UserTypeID").Expires = expirationDate

Response.Redirect "login.asp?res=" & intResellerID
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head><title>Logout</title>
<META Http-Equiv="Cache-Control" Content="no-cache"/>
<META Http-Equiv="Pragma" Content="no-cache"/>
<META Http-Equiv="Expires" Content="0"/>
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
</head><body>
    <h2>Redirecting...</h2>
       </body></html>