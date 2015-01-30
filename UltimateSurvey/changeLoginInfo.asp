<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'************************************************************************************
'
' Name:		changeLoginInfo.asp
' Purpose:	allows user to change username, password, and other user information
'
'
' Author:	    Ultimate Software Designs
' Date Written:	6/24/2002
' Modified:		
'
' Changes:
'************************************************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim strOldPassword
	Dim strNewPassword
	Dim strNewPasswordConfirm
	Dim strError
	Dim strCurrentPassword
	Dim intUserID
	Dim intUserType
	Dim strUsername
	Dim strSQL
	Dim rsResults
	Dim strEmail
	Dim strFirstName
	Dim strLastName
	Dim strTitle
	Dim strCompany
	Dim strLocation
	Dim intLoginType
	Dim strNetworkDomain
	Dim strCustomField1
	Dim strCustomField2
	Dim strCustomField3
	
	Call user_loginNetworkUser()
	
		'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "",intLoginType, "",True)

	If not utility_isPositiveInteger(intUserType) Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If


	
	If Request.Form("submit") = "Change" Then
		strOldPassword = trim(Request.Form("oldPassword"))
		strNewPassword = trim(Request.Form("newPassword"))
		strNewPasswordConfirm = trim(Request.Form("newPasswordConfirm"))
		strCurrentPassword = user_getUserPassword(intUserID)
		strUsername = trim(Request.Form("username"))
		strEmail = trim(Request.Form("email"))
		strFirstName = trim(Request.Form("firstName"))
		strLastName = trim(Request.Form("lastName"))
		strTitle = trim(Request.Form("title"))
		strCompany = trim(Request.Form("company"))
		strLocation = trim(Request.Form("location"))
		strNetworkDomain = trim(Request.Form("networkDomain"))
		strCustomField1 = trim(Request.Form("customField1"))
		strCustomField2 = trim(Request.Form("customField2"))
		strCustomField3 = trim(Request.Form("customField3"))
		
		If intLoginType = SV_LOGIN_TYPE_NETWORK Then
			strSQL = "UPDATE usd_surveyUser " &_
			 "SET email = " & utility_SQLEncode(strEmail, True) &_
			 ",firstName = " & utility_SQLEncode(strFirstName, True) &_
			 ",lastName = " & utility_SQLEncode(strLastName, True) &_
			 ",title = " & utility_SQLEncode(strTitle, True) &_
			 ",company = " & utility_SQLEncode(strcompany, True) &_
			 ",location = " & utility_SQLEncode(strLocation, True) &_
			 ",customField1 = " & utility_SQLEncode(strCustomField1,True) &_
			 ",customField2 = " & utility_SQLEncode(strCustomField2,True) &_
			 ",customField3 = " & utility_SQLEncode(strCustomField3,True) &_
			 " WHERE userID = " & intUserID
			Call utility_executeCommand(strSQL)	 
			Response.Redirect("index.asp?message=" & SV_MESSAGE_LOGIN_INFO_CHANGED)
		Else
				
			If len(strUsername) = 0 Then
				strError = "Please enter user name.<br />"
			ElseIf len(strOldPassword) = 0 Then
				strError = "Please enter current password.<br />"
			ElseIf strOldPassword <> strCurrentPassword Then
				strError = "The current password you entered is incorrect.<br />"
			ElseIf len(strNewPassword) = 0 and len(strNewPasswordConfirm) <> 0 Then
				strError = "Please enter new password.<br />"
			ElseIf len(strNewPasswordConfirm) = 0 and len(strNewPassword) <> 0 Then
				strError = "Please confirm new password.<br />"
			ElseIf strNewPassword <> strNewPasswordConfirm Then
				strError = "Passwords do not match.<br />"
			ElseIf strNewPassword = strCurrentPassword Then
				strError = "New password cannot match old password.<br />"
			End If
		
			If SV_EMAIL_REQUIRED = True Then
				If strEmail = "" Then
					strError = strError & "Email address is required."
				ElseIf utility_isValidEmail(strEmail) = False Then
					strError = strError & "Email address is invalid."
				End If
			End If
		
			If strError = "" Then
				If len(strNewPassword) = 0 Then
					Call user_changeLoginInfo(intUserID, strUsername, strCurrentPassword)
				Else
					Call user_changeLoginInfo(intUserID, strUsername, strNewPassword)
				End If
				Call user_changeUserInfo(intUserID, strEmail, strFirstName, strLastName, strTitle, strCompany, strLocation, strNetworkDomain, _
											strCustomField1, strCustomField2, strCustomField3)
				
				Response.Redirect("index.asp?message=" & SV_MESSAGE_LOGIN_INFO_CHANGED)
			End If 
		End If
	End If

	
	strSQL = "SELECT username, email, firstName, lastName, title, location, company, networkDomain, customField1, customField2, customField3 " &_
			 "FROM usd_surveyUser " &_
			 "WHERE userID = " & intUserID
	Set rsResults = utility_getRecordset(strSQL)
%>
	<%=header_htmlTop("white","")%>
	<%=header_writeHeader(intUserType,SV_PAGE_TYPE_MYINFO)%>
	<span class="surveyTitle">Edit Login Info</span>
	<hr noshade color="#C0C0C0" size="2">
	<span class="message"><%=strError%></span>
	<form method="post">
<%
	If intLoginType = SV_LOGIN_TYPE_PASSWORD Then
%>
		<table class="normal">
			<tr>
				<td class="normalBold-Big" width="200">
					Login Information
				</td>
				<td width="150" align="left" class="normalBold">
					Username<%=common_requiredFlag()%>
				</td>
				<td>
					<input type="text" name="username" size="30"
						value="<%=rsResults("username")%>">
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td width="150" align="left" class="normalBold">
					Current Password<%=common_requiredFlag()%>
				</td>
				<td>
					<input type="password" name="oldPassword" size="30">
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td width="150" align="left" class="normalBold">
					New Password
				</td>
				<td>
					<input type="password" name="newPassword" size="30">
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td width="150" align="left" class="normalBold">
					Confirm New Password
				</td>
				<td>
					<input type="password" name="newPasswordConfirm" size="30">
				</td>
			</tr>
		</table>
		<table class="normal">
			<tr>
				<td width="200">
					&nbsp;
				</td>
				<td>
					**Password will remain the same if you leave 'New Password' and 
					'Confirm New Password' blank.
				</td>
			</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
<%
		End If
%>		

		<table class="normal">
			<tr>
				<td class="normalBold-Big" width="200">
					Contact Information
				</td>
				<td width="150" align="left" class="normalBold">
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
					<input type="text" name="email" size="30" value="<%=rsResults("email")%>">
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td width="150" align="left" class="normalBold">
					First Name
				</td>
				<td>
					<input type="text" name="firstName" size="30" value="<%=rsResults("firstName")%>">
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td width="150" align="left" class="normalBold">
					Last Name
				</td>
				<td>
					<input type="text" name="lastName" size="30" value="<%=rsResults("lastName")%>">
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td width="150" align="left" class="normalBold">
					Title
				</td>
				<td>
					<input type="text" name="title" size="30" value="<%=rsResults("title")%>">
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td width="150" align="left" class="normalBold">
					Company
				</td>
				<td>
					<input type="text" name="company" size="30" value="<%=rsResults("company")%>">
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td width="150" align="left" class="normalBold">
					Location
				</td>
				<td>
					<input type="text" name="location" size="30" value="<%=rsResults("location")%>">
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
						<input type="text" name="customField1" value="<%=rsResults("customField1")%>" size="30">	
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
						<input type="text" name="customField2" value="<%=rsResults("customField2")%>" size="30">	
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
						<input type="text" name="customField3" value="<%=rsResults("customField3")%>" size="30">	
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
					<input type="hidden" name="networkDomain" value="<%=rsResults("networkDomain")%>">
					<input type="image" src="images/button-submitChanges.gif" alt="Submit Changes" border="0"
					onclick="javascript:return confirmAction('Are you sure you want to edit your information?');">
					<input type="hidden" name="submit" value="Change">
				</td>
			</tr>
		</table>
	</form>
<%
	rsResults.Close
	Set rsResults = NOTHING
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

	
	