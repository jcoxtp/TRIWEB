<%@ Language=VBScript Codepage=65001 %>
<%
' Set initial critical page parameters
	Response.Buffer = True
	'On Error Resume Next
	intPageID = 1	' Login Page
%>
<!--#Include file="Include/Common.asp" -->
<%
Dim bSubmitted, strErrMsg
bSubmitted = Request.Form ("txtSubmit")
strErrMsg = Request.QueryString("bSuccess")

If bSubmitted <> "" Then
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
			If IsNull(oRs("FirstName")) or oRs("FirstName") = "" Then
				strSQL = "select firstname, lastname from userinfo a, truser b where a.userinfoid = b.userinfoid and b.userid = " & oRs("UserID")
				Response.Cookies("FirstName") = oConn.Execute (strSQL).fields(0).value
				Response.Cookies("LastName") = oConn.Execute (strSQL).fields(1).value
			Else 
				Response.Cookies("FirstName") = oRs("FirstName")
				Response.Cookies("LastName") = oRs("LastName")
			End If
			Response.Cookies("UserID") = oRs("UserID")
			Response.Cookies("NoPDIPurch") = oRs("NoPDIPurch")
			Response.Cookies("IsProfileMgr") = oRs("IsProfileMgr")
			Response.Cookies("IsFinancialsViewer") = oRs("IsFinancialsViewer")
			If IsNull(oRs("CompanyID")) Then
				Response.Cookies("CompanyID") = ""
			Else
				Response.Cookies("CompanyID") = oRs("CompanyID")
			End If
			If IsNull(oRs("CompanyName")) Then
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
				strErrMsg = "<br><br>" & strTextLoginFailedPleaseTryAgain
			ElseIf InStr(1,oRs("CustomErrMsg"),"NOSUCHUSER") <> 0 Then
				strErrMsg = "<br><br>" & strTextLoginFailedPleaseTryAgain
			ElseIf InStr(1,oRs("CustomErrMsg"),"USERINACTIVE") <> 0 Then
				strErrMsg = "<br><br>" & strTextThisUserNameIsInactivePlease
			Else
				strErrMsg = "<br><br>" & strTextLoginFailedPleaseTryAgain
			End If
		End If
	Else
		Response.Write "<br><br>" & strTextTransactionFailedPleaseContactSiteAdmin & "<br><br>"
		Response.Write Err.Description
		Err.Clear
	End If
End If
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%>&reg;</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="Include/Default<%=strLanguageCode%>.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
	<!--#Include File="Include/HeadStuff.asp" -->
</head>
<%	Select Case intResellerID
		Case 2, 10, 11 %>
		<!-- #Include File = "LoginBodyRadioStation1.asp" -->
<% 		Case Else
		If strSiteType = "Focus3" Then %>
			<!-- #Include File = "LoginBodyFocus3b.asp" -->
		<% Else %>	
			<!-- #Include File = "LoginBodyNormal.asp" -->
<%		End If
	End Select %>
</div>
</body>
</html>