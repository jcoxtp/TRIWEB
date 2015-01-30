<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 11	' Email Forgotten Password Page
%>
<!--#Include file="Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
	<!--#Include file="Include/HeadStuff.asp" -->
</head>
<body>
<!--#Include file="Include/TopBanner.asp" -->
    <div id="main">
<div id="maincontent">
<%
	' --------------------------------------------------------------------------------------
	' Created By: David Brackin
	' Creation Date: Wednesday, May 29, 2002  09:07:35
	' Purpose: This ASP page calls the stored procedure sel_UserInfo_EmailAddr using ADO.
	' --------------------------------------------------------------------------------------
	
	Dim strHost
	Dim Mail
	Dim bSubmitted
	bSubmitted = Request.Form("txtSubmit")
	Dim bFilledOutProperly, strErrMsg
	Dim EmailAddress
	
	bFilledOutProperly = FALSE
	bSubmitted = TRIM(bSubmitted)
	
	If bSubmitted <> "" Then
		  EmailAddress = Request.Form("txtEmailAddress")
	Elseif Request.QueryString("Eml") <> "" Then
		EmailAddress = Request.QueryString("Eml")
		bSubmitted = 1 
	End If
	
	EmailAddress = Trim(EmailAddress)
	If bSubmitted <> "" Then
		  If EmailAddress = "" Then
				 strErrMsg = "Please enter a value for: <strong>Email Address</strong>"
		  Else
				 bFilledOutProperly = True
		  End If
	End If
	
	If bSubmitted <> "" AND bFilledOutProperly Then
		Dim oConn
		Dim oCmd
		Dim oRs
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
		With oCmd
			  .CommandText = "sel_UserInfo_EmailAddr"
			  .CommandType = 4
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			  .Parameters.Append .CreateParameter("@EmailAddress",200, 1,100, EmailAddress)
		End With
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
		If oConn.Errors.Count < 1 Then
			If oRs.EOF = True Then
				' [SM] Commented out the line below and added the line underneath it
				'Response.Write "<br><br><span class='titletext'>Your email address was not found. Please check your entry and try again.</span><br><br>"
				strErrMsg = strTextErrorYourEmailAddressWasNotFound
			Else
				' send the user the email that contains the user name and password
			'	Dim JMail
			'	Set JMail = Server.CreateObject("JMail.SMTPMail") 
			'	JMail.ServerAddress = "www.pdiprofile.com:25" ' change this to your mail server
			'	JMail.Sender = "DISC@pdiprofile.com" 'here type in your email address
			'	JMail.SenderName = "Team Resources / Triaxia Partners"
			'	JMail.Subject = "Login Information for PDI Website" 
			'	JMail.AddRecipient(Cstr(EmailAddress)) 'here type in your email address again
			'	' [SM] Commented out the line below and added the line underneath it
			'	'JMail.HTMLBody = "Here is your login information for <a href='http://www.pdiprofile.com'>www.pdiprofile.com</a><br><br>UserName:" & oRs("UserName") & "<br><br>Password:" & oRs("Password")
			'	JMail.Body = strTextHereIsYourLoginInformation & VbCrLf & VbCrLf & strTextUsername & ": " & oRs("UserName") & VbCrLf & Application("strTextPassword" & strLanguageCode) & ": " & oRs("Password") & VbCrLf & VbCrLf & strTextYouMayLogInToTheWebsiteUsing & ". " & VbCrLf & VbCrLf & "Regards," & VbCrLf & "Team Resources, Inc. / Triaxia Partners, Inc." & VbCrLf & "1.800.214.3917. Server Config: " & JMail.ServerAddress
			'	JMail.Priority = 3
			'	JMail.Execute

				Dim JMail
				Set JMail = Server.CreateObject("JMail.Message")
				JMail.Logging = true
				JMail.Silent = true
				JMail.From = "DISC@pdiprofile.com"
				JMail.FromName = "DISC"
				JMail.MailServerUserName = "DISC"
				JMail.MailServerPassword = "s3rv3r pa33word!"
				JMail.AddRecipient CStr(EmailAddress)
				JMail.Subject = "Login Information for PDI Website"
				JMail.Body = strTextHereIsYourLoginInformation & VbCrLf & VbCrLf & strTextUsername & ": " & oRs("UserName") & VbCrLf & Application("strTextPassword" & strLanguageCode) & ": " & oRs("Password") & VbCrLf & VbCrLf & strTextYouMayLogInToTheWebsiteUsing & ". " & VbCrLf & VbCrLf & "Regards," & VbCrLf & "Team Resources, Inc. / Triaxia Partners, Inc." & VbCrLf & "1.800.214.3917."
				

				If JMail.Send("www.pdiprofile.com:25") Then
					' [SM] Added following line and modified the line underneath it
					Response.Write "<h2>" & strTextThanks &"!</h2>" & VbCrLf & VbCrLf
					Response.Write "<p>" & strTextYourUsernameAndPasswordHaveBeenSent & "</p>" & VbCrLf & VbCrLf
					Response.Write "<p>" & strTextWhenYouHaveRetrievedYourUserInformation & ".</p>"
				Else
					Response.Write "There was an error. Mail Server Error:<br>"
					Response.Write JMail.Log
				End If
				Set oConn = Nothing
				Set oCmd = Nothing
				Set oRs = Nothing
				Response.End
			End if
		Else
			  strErrMsg = Err.description
			  Err.Clear
		End If
	End If
	' [SM] I disabled the following lines and added a modified version below
	'If strErrMsg <> "" Then
		  'Response.Write "<br>"
		  'Response.Write strErrMsg
		  'Response.Write "<br><br>"
	'End If
	%>
	
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td valign="top"><h1><%=strTextForgotUserNameOrPassword%>?</h1>
			</td>
			
			<td valign="top" align="right"><!--#Include file="Include/BackLink.asp" -->
			</td>
		</tr>
	</table>

	<p><%=strTextPleaseEnterTheEmailAddressYouSubmitted%></p>
	
	<form name="thisForm" id="thisForm" method="post" action="EmailUsernamePswd.asp?res=<%=intResellerID%>">
	<input type="hidden" name="txtSubmit" id="txtSubmit" value="1">
	<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	
		<tr> 
			<td valign="middle">&nbsp;</td>
			<td valign="middle">
				<%
				If strErrMsg <> "" Then
					Response.Write "<span class=""errortext"">" & strErrMsg & "</span>"
				Else
					Response.Write "&nbsp;"
				End If %>
			</td>
		</tr>
		<tr>
			<td valign="middle" align="right" width="25%"><strong><%=strTextEmailAddress%>:</strong></td>
			<td valign="middle" width="75%"><input type="text" name="txtEmailAddress" id="txtEmailAddress" maxlength="100" Size="50" value="<%=EmailAddress%>"></td>
		</tr>
		<tr> 
			<td valign="middle" align="center" colspan="2"><input type="Submit" value="<%=Application("strTextSubmit" & strLanguageCode)%>" border="0" name="Add" id="Add"></td>
		</tr>
			
	</table>
	</form>

</div>

    </div>
</body>
</html>
