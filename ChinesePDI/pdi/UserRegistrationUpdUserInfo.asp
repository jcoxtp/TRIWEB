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
		Dim UserName
		Dim FirstName, LastName, EmailAddress

	'=========================================================================================
	'  If this is a postback then 
	'		Receive and validate incomming form data
	'	Else this is the first time through 
	'		So, grab info from the db
	'=========================================================================================
		strErrMsg = ""
		If bSubmitted <> "" Then
			'-- User Info---------------------
			UserName = Request.Form("txtUserName") : UserName = Trim(UserName)
			FirstName = Request.Form("txtFirstName") : FirstName = Trim(FirstName)
				If FirstName = "" Then strErrMsg = strErrMsg & "Please enter a value for: <strong>First Name</strong><br>"
			LastName = Request.Form("txtLastName") : LastName = Trim(LastName)
				If LastName = "" Then strErrMsg = strErrMsg & "Please enter a value for: <strong>Last Name</strong><br>"
			EmailAddress = Request.Form("txtEmailAddress") : EmailAddress = Trim(EmailAddress)
				If EmailAddress = "" Then strErrMsg = strErrMsg & "Please enter a value for: <strong>Email Address</strong><br>"
				If InStr(1,CStr(EmailAddress),"@",1) = 0 Then strErrMsg = strErrMsg & "Please enter a proper email address"
				If InStr(1,CStr(EmailAddress),".",1) = 0 Then strErrMsg = strErrMsg & "Please enter a proper email address"

			'-- Check for an error message ----------------
			If strErrMsg = "" Then
				bFilledOutProperly = TRUE
			End If

			'-- If the data is good - write to the database -------------------
			If bFilledOutProperly Then
				Set oConn = CreateObject("ADODB.Connection")
				Set oCmd = CreateObject("ADODB.Command")
				With oCmd
					.CommandText = "spRegistrationUpdUserInfo"
					.CommandType = 4
					.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
					.Parameters.Append .CreateParameter("@UserID",3, 1,4, UserID)
					'-- User Info---------------------
					.Parameters.Append .CreateParameter("@FirstName",200, 1,100, FirstName)
					.Parameters.Append .CreateParameter("@LastName",200, 1,100, LastName)
					.Parameters.Append .CreateParameter("@EmailAddress",200, 1,100, EmailAddress)
				End With
				oConn.Open strDBaseConnString
				oCmd.ActiveConnection = oConn
				oCmd.Execute , , 128
			
				If oConn.Errors.Count < 1 Then
					Response.Cookies("FirstName") = FirstName
					Response.Cookies("LastName") = LastName
					Response.Redirect("UserRegistrationInfo.asp?res=" & intResellerID )
				Else
					Dim strError
					strError = FormatSQLError(Err.description)
					If InStr(1,strError,"DUPEMAIL") <> 0 Then
						strErrMsg = "The email address entered already exists for a registered user in the system. Please try again."
					Else
						strErrMsg = strError
'						Response.Write ("@UserID = " & UserID & "<br>")
'						Response.Write ("@FirstName = " & FirstName & "<br>")
'						Response.Write ("@LastName = " & LastName & "<br>")
'						Response.Write ("@EmailAddress = " & EmailAddress & "<br>")
					End If
					Err.Clear
				End If
				Set oConn = Nothing
				Set oCmd = Nothing
			End If
	'=========================================================================================
		Else ' This is tied to the original--> If bSubmitted <> "" Then
	'=========================================================================================
			'-- Grab the data from the db ------------------------
			Set oConn = CreateObject("ADODB.Connection")
			Set oCmd = CreateObject("ADODB.Command")
			Set oRs = CreateObject("ADODB.Recordset")
			With oCmd
				.CommandText = "spRegistrationGet"
				.CommandType = 4
				.Parameters.Append .CreateParameter("@UserID", 3, 1, 4, UserId)
			End With
			oConn.Open strDBaseConnString
			oCmd.ActiveConnection = oConn
			Set oRs = oCmd.Execute
	
			If oConn.Errors.Count > 0 or oRs.EOF then
				'bad stuff happened - complain
			End If

			UserName = oRs("UserName")
			FirstName = oRs("FirstName")
			LastName = oRs("LastName") 
			EmailAddress = oRs("EmailAddress")

	'=========================================================================================
		End If ' Closes the original--> If bSubmitted <> "" Then
	'=========================================================================================

%>
<form name="thisForm" id="thisForm" method="post" action="UserRegistrationUpdUserInfo.asp?res=<%=intResellerID%>">
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
	  	<td valign="middle" align="right" width="35%"><strong>Username:</strong></td>
	  	<td valign="middle" width="65%"><%=UserName%><input type="hidden" name="txtUserName" id="txtUserName" MaxLength="50" Size="15" Value="<%=UserName%>"></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong>First Name:</strong></td>
	  	<td valign="middle"><input type="text" name="txtFirstName" id="txtFirstName" MaxLength="100" Size="50" Value="<%=FirstName%>"></td>
	</tr>			
	<tr> 
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong>Last Name:</strong></td>
	  	<td valign="middle"><input type="text" name="txtLastName" id="txtLastName" MaxLength="100" Size="50" Value="<%=LastName%>"></td>
	</tr>		
	<tr> 
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong>Email Address:</strong></td>
	  	<td valign="middle"><input type="text" name="txtEmailAddress" id="txtEmailAddress" MaxLength="100" Size="50" Value="<%=EmailAddress%>"></td>
	</tr>
</table>
<span class="required">*&nbsp;Required</span>
<br><br>
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
