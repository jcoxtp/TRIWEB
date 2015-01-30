<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 41	' User Registration Info Page
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
				oConn.Open strDbConnString
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
			oConn.Open strDbConnString
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
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td valign="top"><h1><%=strTextPageTitle%></h1></td>
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
	<tr><td valign="middle" colspan="2"><span class="headertext2"><%=strTextUserInformation%></span><br></td></tr>
	<tr>
	  	<td valign="middle" align="right" width="35%"><strong><%=Application("strTextUsername" & strLanguageCode)%>:</strong></td>
	  	<td valign="middle" width="65%"><%=UserName%><input type="hidden" name="txtUserName" id="txtUserName" MaxLength="50" Size="15" Value="<%=UserName%>"></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong><%=strTextFirstName%>:</strong></td>
	  	<td valign="middle"><input type="text" name="txtFirstName" id="txtFirstName" MaxLength="100" Size="50" Value="<%=FirstName%>"></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong><%=strTextLastName%>:</strong></td>
	  	<td valign="middle"><input type="text" name="txtLastName" id="txtLastName" MaxLength="100" Size="50" Value="<%=LastName%>"></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong><%=strTextEmailAddress%>:</strong></td>
	  	<td valign="middle"><input type="text" name="txtEmailAddress" id="txtEmailAddress" MaxLength="100" Size="50" Value="<%=EmailAddress%>"></td>
	</tr>
</table>
<span class="required">*&nbsp;<%=Application("strTextRequired" & strLanguageCode)%></span>
<br><br>
<!--#Include File="Include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="100%">
	<tr>
	  	<td valign="top"><%=strTextViewOur%> <a href="PrivacyPolicy.asp?res=<%=intResellerID%>"><%=Application("strTextPrivacyPolicy" & strLanguageCode)%></a></td>
	  	<td valign="top" align="right"><input type="submit" border="0" value="<%=strTextSaveChanges%>" id="add" name="add"></td>
	</tr>
</table>
</form>
</div>

    </div>
</body>
</html>
