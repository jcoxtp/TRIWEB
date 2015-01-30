<%@ Language=VBScript %>
<% Response.Buffer = TRUE %>
<!--#Include FILE="Include/Common.asp" -->
<%
on error resume next
Dim bSubmitted, strErrMsg
bSubmitted = Request.Form ("txtSubmit")
strErrMsg = Request.QueryString("bSuccess")

if bSubmitted <> "" then 
	Dim UserName : UserName = Request.Form("txtUserName")
	Dim Password : Password = Request.Form("txtPassword")
	
	Dim oConn, oCmd, oRs
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	With oCmd
	     .CommandText = "sel_TRUser_login"
	     .CommandType = 4
	     .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	     .Parameters.Append .CreateParameter("@UserName", 200, 1, 50, UserName)
	     .Parameters.Append .CreateParameter("@Password", 200, 1, 50, Password)
	End With

	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1

	If oConn.Errors.Count < 1 Then
		' reset the cookies first
		ResetCookies
		If oRs("LoginResults") = 1 Then
			Response.Cookies("Login") = 1
			Response.Cookies("UserID") = oRs("UserID")
			Response.Cookies("UserName") = oRs("UserName")
			'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			'If CompanyID is null in UserInfo table, firstname and lastname comes back null.  
			'If so, go get the firstname and lastname. Otherwise use the values from the stored proc.
			'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			If ISNULL(oRs("FirstName")) or oRs("FirstName") = "" Then
				strSQL = "select firstname, lastname from userinfo a, truser b where a.userinfoid = b.userinfoid and b.userid = " & oRs("UserID")
				Response.Cookies("FirstName") = oConn.Execute (strSQL).fields(0).value
				Response.Cookies("LastName") = oConn.Execute (strSQL).fields(1).value
			Else 
				Response.Cookies("FirstName") = oRs("FirstName")
				Response.Cookies("LastName") = oRs("LastName")
			End If
			Response.Cookies("NoPDIPurch") = oRs("NoPDIPurch")
			Response.Cookies("IsProfileMgr") = oRs("IsProfileMgr")
			Response.Cookies("IsFinancialsViewer") = oRs("IsFinancialsViewer")
			If ISNULL(oRs("CompanyID")) Then
				Response.Cookies("CompanyID") = ""
			Else
				Response.Cookies("CompanyID") = oRs("CompanyID")
			End If
			If ISNULL(oRs("CompanyName")) Then
				Response.Cookies("CompanyName") = ""
			Else
				Response.Cookies("CompanyName") = oRs("CompanyName")
			End If
			Response.Cookies("UserTypeID") = oRs("UserTypeID")
			Response.Redirect("main.asp?res=" & intResellerID)
		Else
			' just in case we want to provide custom login error messages
			' in the future I have separated the different replies from the 
			' stored procedure
			' right now the only custom message is that the user is inactive
			If InStr(1,oRs("CustomErrMsg"),"INVALIDPASSWORD") <> 0 Then
				strErrMsg = "Login Failed. Please Try Again"
			ElseIf InStr(1,oRs("CustomErrMsg"),"NOSUCHUSER") <> 0 Then
				strErrMsg = "Login Failed. Please Try Again"
			ElseIf InStr(1,oRs("CustomErrMsg"),"USERINACTIVE") <> 0 Then
				strErrMsg = "This user name is inactive. Please Try Again"
			Else
				strErrMsg = "Login Failed. Please Try Again"
			End If
		End If
	Else
		Response.Write "<BR><BR>Transaction Failed<BR><BR>"
		Response.Write Err.description
		Err.Clear
	End If
End If
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Welcome to the DISC Profile System&reg;</title>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
	<!--#Include FILE="Include/HeadStuff.asp" -->
</head>
<body class="loginbody">
<div id="CenterAll">
	<table border="0" cellspacing="0" cellpadding="0" width="768" height="800" style="background-image: url('/RS/<%=SitePathName%>/background.jpg'); background-repeat:no-repeat;">
		<tr><td></td></tr>
	</table>
	<% Select Case intResellerID %>
	<% Case 2 %>
		<!--#Include file="LoginBodyDreamGiver.asp" -->
	<% Case 10 %>
		<!--#Include file="LoginBodyRadioStation1.asp" -->
	<% Case Else %>
		<!--#Include file="LoginBodyNormal.asp" -->
	<% End Select %>
</div>
</body>
</html>