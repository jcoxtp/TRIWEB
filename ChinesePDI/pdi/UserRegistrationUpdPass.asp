<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/common.asp" -->
<% pageID = "" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Update Registration Info</title>
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
<div id="maincontent">
<%'=======================================================================================================
on error resume next

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
				oConn.Open strDBaseConnString
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
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr> 
	  	<td valign="top">
			<h1>Update Registration Information</h1>
			Please enter your information in the fields below, and click "Save Changes" at the bottom of this page.
	  	</td>
		<td valign="top" align="right"><!--#INCLUDE FILE="include/back_link.asp" --></td>
	</tr>
	<%
		If strErrMsg <> "" Then
			Response.Write("<tr><td valign=""middle"" colspan=""2"">")
			Response.Write("<span class=""errortext"">" & strErrMsg & "</span>")
			Response.Write("</td></tr>")
		End If 
	%>
</table>
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr> 
	  	<td valign="middle" colspan="2">
	  		<span class="headertext2">User Information</span><br>
	  	</td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right" width="35%"><span class="required">*&nbsp;</span><strong>Current Password:</strong></td>
	  	<td valign="middle" width="65%"><input type="password" name="txtPassword" id="txtPassword" MaxLength="50" Size="15" Value="<%=Password%>"></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong>Choose a New Password:</strong></td>
	  	<td valign="middle"><input type="password" name="txtNewPassword" id="txtNewPassword" MaxLength="50" Size="15" Value="<%=NewPassword%>">&nbsp;&nbsp;&nbsp;(Must be at least 6 characters)</td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong>Retype New Password:</strong></td>
	  	<td valign="middle"><input type="password" name="txtNewPasswordConfirm" id="txtNewPasswordConfirm" MaxLength="50" Size="15" Value="<%=NewPasswordConfirm%>"></td>
	</tr>
</table>
<span class="required">*&nbsp;Required</span>
<!--#INCLUDE FILE="include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="100%">
	<tr>
	  	<td valign="top">View our <a href="PrivacyPolicy.asp?res=<%=intResellerID%>">Privacy Policy</a></td>
	  	<td valign="top" align="right"><input type="submit" border="0" value="Save Changes" id="add" name="add"></td>
	</tr>
</table>
</form>
</div>
</body>
</html>
