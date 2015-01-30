<%@ Language=VBScript Codepage=65001 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Ross Main Page</title>
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
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="ProgId" content="VisualStudio.HTML">
		<meta name="Originator" content="Microsoft Visual Studio .NET 7.1">
		<link rel="stylesheet" href="Include/DefaultEN.css" type="text/css">
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
			<link rel="stylesheet" href="/RS/ross/Reseller.css" type="text/css">
	</HEAD>
	<body class="loginbody">
		<div id="CenterAll">
			<table border="0" cellspacing="0" cellpadding="0" width="768" height="680" style="BACKGROUND-IMAGE: url(/RS/Ross/BackgroundEN.jpg); BACKGROUND-REPEAT: no-repeat"
				ID="Table1">
				<tr>
					<td></td>
				</tr>
			</table>
			<div id="login_section01">
				<form name="thisForm1" id="thisForm1" method="post" action="UserRegistration.asp?res=18"
					target="_top">
					<input type="hidden" name="txtSubmit" value="0" ID="Hidden1">
					<table width="675" border="0" ID="Table2">
						<TR>
							<TD>&nbsp;</TD>
						</TR>
						<TR>
							<TD></TD>
						</TR>
						<tr align="center">
							<td>
								<input type="button" value="Click Here to Register for DISC Inventory" onClick="javascript:submit();"
									style="FONT-WEIGHT:bold;FONT-SIZE:18pt;WIDTH:650px;FONT-FAMILY:arial" ID="Button1" NAME="Button1">
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<TR>
							<TD></TD>
						</TR>
						<tr>
							<td align="center">
								<input type="button" value="Click Here to Redeem Selling Module" onClick="window.location='RossLogin.asp';"
									style="FONT-WEIGHT:bold;FONT-SIZE:18pt;WIDTH:650px;FONT-FAMILY:arial" ID="Button2" NAME="Button2">
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div id="login_form">
				<table border="0" cellspacing="0" cellpadding="0" width="100%" ID="Table3">
					<tr align="left">
						<td valign="middle" height="55">
							<span class="logintext">
								<strong>Returning Users: Please enter the personal username and password you 
									selected during your previous enrollment:</strong><br>
							</span>
							<span class="logintext">Forgot your UserName Or Password? <a class="loginform_link" href="emailusernamepswd.asp?res=18" target="_top">
									Have it sent to you</a>.</span>
						</td>
						<td valign="middle">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td valign="bottom" align="right">
							<table border="0" cellspacing="0" cellpadding="2" ID="Table4">
								<form name="thisForm" id="thisForm" method="post" action="login.asp?res=18" target="_top">
									<tr>
										<td valign="middle" align="right">
											<span class="logintext">
												<strong>Username:&nbsp;</strong></span>
										</td>
										<td valign="middle">
											<input name="txtUserName" class="loginform_field" type="text" size="15" maxlength="32"
												ID="Text1">
										</td>
									</tr>
									<tr>
										<td valign="middle" align="right">
											<span class="logintext">
												<strong>Password:&nbsp;</strong></span>
										</td>
										<td valign="middle">
											<input name="txtPassword" class="loginform_field" type="password" size="15" maxlength="32"
												ID="Password1">
										</td>
									</tr>
							</table>
						</td>
						<td valign="bottom" align="right">
							<input type="submit" value="Login" id="add" name="add"> <input type="hidden" name="txtSubmit" id="txtSubmit" value="1">
						</td>
					</tr>
				</table>
				</FORM>
			</div>
		</div>
	</body>
</HTML>
