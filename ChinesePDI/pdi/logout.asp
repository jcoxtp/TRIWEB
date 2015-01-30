<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/checklogin.asp" -->
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
<html><head><title>Logout</title></head><body></body></html>