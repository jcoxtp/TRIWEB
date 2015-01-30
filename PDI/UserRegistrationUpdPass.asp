<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 40	' Update User Password Page
%>
<!--#Include file="Include/CheckLogin.asp" -->
<!--#Include file="Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
<!--<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>-->
	<!--#Include file="Include/HeadStuff.asp" -->
</head>
<body>
<!--#Include file="Include/TopBanner.asp" -->
    <div id="main">

<div id="maincontent">
<%
	'=========================================================================================
	' Initialize variables
	'=========================================================================================
		'Objects for database operations
		Dim oConn, oCmd, oRS
		
		'Pageflow related data
		Dim bFilledOutProperly : bFilledOutProperly = FALSE
		Dim bSubmitted	: bSubmitted = Request.Form ("txtSubmit")
		Dim strErrMsg
	
		'System data 
		Dim UserID, nCount
		UserId = Request.Cookies("UserID")
'		Response.Write(UserID & "<hr>")
	
		'Form Variables
		Dim Password, NewPassword, NewPasswordConfirm

	'=========================================================================================
	'  If this is a postback then 
	'		Receive and validate incomming form data
	'	Else this is the first time through 
	'		So, grab info from the db
	'=========================================================================================
		strErrMsg = ""
		If bSubmitted <> "" Then
			Password = Request.Form("txtPassword") : Password = Trim(Password)
			NewPassword = Request.Form("txtNewPassword") : NewPassword = Trim(NewPassword)
			NewPasswordConfirm = Request.Form("txtNewPasswordConfirm") : NewPasswordConfirm = Trim(NewPasswordConfirm)
				If Password = "" Then strErrMsg = "Please enter a value for: <strong>Password</strong><br>"
				If NewPassword = "" Then strErrMsg = "Please enter a value for: <strong>New Password</strong><br>"
				If NewPasswordConfirm <> NewPassword Then strErrMsg = strErrMsg &  "New Password and Retype New Password values do not match. Please try again.<br>"
				If Len(NewPassword) < 6 Then strErrMsg = strErrMsg & "New Password must be at least 6 characters in length.<br>"

			'-- Check for an error message ----------------
			If strErrMsg = "" Then
				bFilledOutProperly = TRUE
			End If

			'-- If the data is good - write to the database -------------------
			If bFilledOutProperly Then
				Set oConn = CreateObject("ADODB.Connection")
				Set oCmd = CreateObject("ADODB.Command")
				With oCmd
					.CommandText = "spRegistrationUpdPass"
					.CommandType = 4
					.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
					.Parameters.Append .CreateParameter("@UserID",3, 1,4, UserID)
					'-- User Info---------------------
					.Parameters.Append .CreateParameter("@Password",200, 1,50, Password)
					.Parameters.Append .CreateParameter("@NewPassword",200, 1,50, NewPassword)
				End With
				oConn.Open strDbConnString
				oCmd.ActiveConnection = oConn
				oCmd.Execute , , 128
			
				If oConn.Errors.Count < 1 Then
					Response.Redirect("UserRegistrationInfo.asp?res=" & intResellerID )
				Else
					Dim strError
					strError = FormatSQLError(Err.description)
					strErrMsg = strError
'					Response.Write ("@UserID = " & UserID & "<br>")
'					Response.Write ("@Password = " & Password & "<br>")
'					Response.Write ("@NewPassword = " & NewPassword & "<br>")
					Err.Clear
				End If
				Set oConn = Nothing
				Set oCmd = Nothing
			End If
	'=========================================================================================
		Else ' This is tied to the original--> If bSubmitted <> "" Then
	'=========================================================================================

			'-- Grab the data from the db ------------------------
			'-> this is password change functionality
			'-> as a security precaution we are going to make them enter their current password again

	'=========================================================================================
		End If ' Closes the original--> If bSubmitted <> "" Then
	'=========================================================================================

%>
<form name="thisForm" id="thisForm" method="post" action="UserRegistrationUpdPass.asp?res=<%=intResellerID%>">
<input type="hidden" name="txtSubmit" id="txtSubmit" value="1">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td valign="top"><h1><%=strTextUpdateRegistrationInformation%></h1></td>
		<td valign="top" align="right"><!--#Include file="Include/BackLink.asp" --></td>
	</tr>
</table>
<!--# Include File="Include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr><td valign="middle" colspan="2"><%=strTextPleaseEnterYourInformationInTheFieldsBelow%></td></tr>
<%
		If strErrMsg <> "" Then
			Response.Write("<tr><td valign=""middle"" colspan=""2"">")
			Response.Write("<span class=""errortext"">" & strErrMsg & "</span>")
			Response.Write("</td></tr>")
		End If
%>
	<tr>
	  	<td valign="middle" colspan="2">
	  		<span class="headertext2"><%=strTextUserInformation%></span><br>
	  	</td>
	</tr>
	<tr>
	  	<td valign="middle" align="right" width="35%"><span class="required">*&nbsp;</span><strong><%=strTextCurrentPassword%>:</strong></td>
	  	<td valign="middle" width="65%"><input type="password" name="txtPassword" id="txtPassword" MaxLength="50" Size="15" Value="<%=Password%>"></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong><%=strTextChooseANewPassword%>:</strong></td>
	  	<td valign="middle"><input type="password" name="txtNewPassword" id="txtNewPassword" MaxLength="50" Size="15" Value="<%=NewPassword%>">&nbsp;&nbsp;&nbsp;(Must be between 8-20 characters.)</td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong><%=strTextRetypeNewPassword%>:</strong></td>
	  	<td valign="middle"><input type="password" name="txtNewPasswordConfirm" id="txtNewPasswordConfirm" MaxLength="50" Size="15" Value="<%=NewPasswordConfirm%>"></td>
	</tr>
</table>
<span class="required">*&nbsp;<%=Application("strTextRequired" & strLanguageCode)%></span>
<!--#Include File="Include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="100%">
	<tr>
	  	<td valign="top"><%=strTextViewOur%> <a href="PrivacyPolicy.asp?res=<%=intResellerID%>"><%=Application("strtextPrivacyPolicy" & strLanguageCode)%></a></td>
	  	<td valign="top" align="right"><input type="submit" border="0" value="<%=strTextSaveChanges%>" id="add" name="add"></td>
	</tr>
</table>
</form>
</div>

    </div>
</body>
</html>
