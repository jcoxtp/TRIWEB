<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		register.asp 
' Purpose:	page to register for survey application
'
'
' Author:	    Ultimate Software Designs
' Date Written:	6/24/2002
' Modified:		
'
' Changes:
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim intUserType
	Dim strUsername
	Dim strPassword
	Dim strPasswordConfirm
	Dim strFirstName
	Dim strLastName
	Dim strEmail
	Dim strTitle
	Dim strCompany
	Dim strLocation
	Dim strError
	Dim strAction
	Dim intUserIDOut
	Dim strCustomField1
	Dim strCustomField2
	Dim strCustomField3
	Dim strGUID
	Dim strSQL
	Dim rsResults
	
	If SV_ALLOW_PUBLIC_REGISTRATION = False Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If
	
	strAction = Request.Form("submit")
	
	If strAction = "Add User" Then
		'get all values from form post
		strUsername = trim(Request.Form("username"))
		strPassword = trim(Request.Form("password"))
		strPasswordConfirm = trim(Request.Form("passwordConfirm"))
		strFirstName = trim(Request.Form("firstName"))
		strLastName = trim(Request.Form("lastName"))
		strEmail = trim(Request.Form("email"))
		strTitle = trim(Request.Form("title"))
		strCompany = trim(Request.Form("company"))
		strLocation = trim(Request.Form("location"))
		strCustomField1 = trim(Request.Form("customField1"))
		strCustomField2 = trim(Request.Form("customField2"))
		strCustomField3 = trim(Request.Form("customField3"))
		
		intUserType = SV_DEFAULT_USER_TYPE
				
		'check required values
		If strUsername = "" Then
			strError = strError & "Username is required.<br />"
		ElseIf user_usernameTaken(strUsername) = True Then
			strError = strError & "Username is already taken.<br />"
		End If
		If strPassword = "" Then
			strError = strError & "Password is required.<br />"
		ElseIf strPasswordConfirm = "" Then
			strError = strError & "You must confirm your password.<br />"
		ElseIf strPassword <> strPasswordConfirm Then
			strError = strError & "Your passwords do not match.<br />"
		End If
		
		If SV_EMAIL_REQUIRED = True Then
			If strEmail =  "" Then
				strError = strError & "Email address is required.<br />"
			ElseIf utility_isValidEmail(strEmail) = False Then
				strError = strError & "Your email address is invalid.<br />"
			End If
		End If
		
		'If no errors have been encountered
		If strError = "" Then
			Call user_addUser(strUsername, strPassword, intUserType, strFirstName, strLastName, _
				strEmail, strTitle, strCompany, strLocation, SV_LOGIN_TYPE_PASSWORD, "", strCustomField1, strCustomField2, strCustomField3, intUserIDOut)
				
			strGUID = utility_createGUID()
			
			strSQL = "UPDATE usd_surveyUser SET userGUID = " & utility_SQLEncode(strGUID, True) &_
					 " WHERE userID = " & intUserIDOut
			Call utility_executeCommand(strSQL)	
						
			Call user_setSessioninfo(intUserIDOut, intUserType, strUserName, SV_LOGIN_TYPE_PASSWORD, "true", strGUID)
								
			Response.Redirect("index.asp?message=" & SV_MESSAGE_USER_ADDED)
		End If
	End If
%>	
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(0,"")%>
<p class="surveyTitle">Enter New User Information</p>
<span class="message"><%=strError%></span>
<form method="post" action="register.asp" id=form1 name=form1>
	<hr noshade color="#C0C0C0" size="2">
	<table border="0" cellpadding="0" cellspacing="2" class="normal">
		<tr>
			<td class="normalBold-Big" width="200">
				Login Information
			</td>
			<td class="normalBold" width="150">
				Desired Username<%=common_requiredFlag()%>
			</td>
			<td>
				<input type="text" name="username" value="<%=strUsername%>">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" width="150">
				Desired Password<%=common_requiredFlag()%>
			</td>
			<td>
				<input type="password" name="password">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold" width="150">
				Confirm Password<%=common_requiredFlag()%>
			</td>
			<td>
				<input type="password" name="passwordConfirm">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table>
		<tr>
			<td class="normalBold-Big" width="200" width="150">
				Contact Information
			</td>
			<td class="normalBold">
				Email
<%
				If SV_EMAIL_REQUIRED = True Then
%>
				<%=common_requiredFlag()%>
<%
				End If
%>
			</td>
			<td>
				<input type="text" name="email" value="<%=strEmail%>">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold" width="150">
				First Name
			</td>
			<td>
				<input type="text" name="firstName" value="<%=strFirstName%>">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold" width="150">
				Last Name
			</td>
			<td>
				<input type="text" name="lastName" value="<%=strLastName%>">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold" width="150">
				Title
			</td>
			<td>
				<input type="text" name="title" value="<%=strTitle%>">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold" width="150">
				Company
			</td>
			<td>
				<input type="text" name="company" value="<%=strCompany%>">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold" width="150">
				Location
			</td>
			<td>
				<input type="text" name="location" value="<%=strLocation%>">
			</td>
		</tr>
<%
			If len(SV_CUSTOM_USER_FIELD_1) > 0 Then
%>
				<tr>
					<td>
						&nbsp;
					</td>
					<td class="normalBold" width="150">
						<%=SV_CUSTOM_USER_FIELD_1%>
					</td>
					<td>
						<input type="text" name="customField1" value="<%=strCustomField1%>" >	
					</td>
				</tr>

<%
			End If

			If len(SV_CUSTOM_USER_FIELD_2) > 0 Then
%>
				<tr>
					<td>
						&nbsp;
					</td>
					<td class="normalBold" width="150">
						<%=SV_CUSTOM_USER_FIELD_2%>
					</td>
					<td>
						<input type="text" name="customField2" value="<%=strCustomField2%>" >	
					</td>
				</tr>

<%
			End If

			If len(SV_CUSTOM_USER_FIELD_3) > 0 Then
%>
				<tr>
					<td>
						&nbsp;
					</td>
					<td class="normalBold" width="150">
						<%=SV_CUSTOM_USER_FIELD_3%>
					</td>
					<td>
						<input type="text" name="customField3" value="<%=strCustomField3%>" >	
					</td>
				</tr>

<%
			End If
%>
		
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table>
		<tr>
			<td width="200">
				&nbsp;
			</td>
			<td>
				<input type="image" src="images/button-register2.gif" alt="Register" border="0">
				<input type="hidden" name="submit" value="Add User">
			</td>
		</tr>
	</table>
</form>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

