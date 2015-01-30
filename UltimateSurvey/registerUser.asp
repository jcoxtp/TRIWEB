<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		registerUser.asp 
' Purpose:	page for an administrator to register users
'
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
<!--#INCLUDE FILE="Include/inviteUsers_inc.asp"-->
<%
	Dim intNewUserType
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
	Dim intUserType
	Dim strCustomField1
	Dim strCustomField2
	Dim strCustomField3
	Dim arrAllGroups
	Dim arrUserGroups
	Dim intGroupArraySize
	Dim intArrayLooper
	Dim strGroupName
	Dim strUserGroups
	Dim arrGroupsChosen
	Dim strUserGroup
	Dim strSQL
	Dim rsResults
	
	Call user_loginNetworkUser()
	
	'Get the user info out of the session or cookie
	Call user_getSessionInfo("", intUserType, "","", "",True)
	
	If intUserType <> SV_USER_TYPE_ADMINISTRATOR Then
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
		intNewUserType = cint(Request.Form("userType"))
			
		strCustomField1 = Request.Form("customField1")
		strCustomField2 = Request.Form("customField2")
		strCustomField3 = Request.Form("customField3")	
		
		strUserGroups = Request.Form("groupsChosen")
		
		If len(trim(strUserGroups)) > 0 Then
			arrGroupsChosen = split(strUserGroups, ";" )
			intGroupArraySize = Ubound(arrGroupsChosen)
		Else 
			intGroupArraySize = 0
		End If
		
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
			Call user_addUser(strUsername, strPassword, intNewUserType, strFirstName, strLastName, _
				strEmail, strTitle, strCompany, strLocation, SV_LOGIN_TYPE_PASSWORD, "", strCustomField1, strCustomField2, strCustomField3, intUserIDOut)
			
			If user_groupsExist = True Then
				If utility_isPositiveInteger(intGroupArraySize) Then
					For intArrayLooper = 0 to intGroupArraySize
						strUserGroup = trim(arrGroupsChosen(intArrayLooper))
						If len(strUserGroup) > 0 Then
							Call user_addUserToGroup(strUserGroup, intUserIDOut)
							
							Call inviteUsers_updateSurveyPermissions(intUserIDOut, strUserGroup)
						End If
					Next	
				End If
			End If
			
			Response.Redirect("manageUsers.asp?message=" & SV_MESSAGE_USER_ADDED)

		End If
	End If
%>	
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType,SV_PAGE_TYPE_USERS)%>
<span class="breadcrumb" align="left">
		<a href="manageUsers.asp">All Users</a> >>
		Add User</a>
		</span><br /><br />
<span class="surveyTitle">Add User</span>
<br /><span class="normal">This page will allow you to add users that user a username/password combination
to access the application.<br />You may also add users that use network credentials to access the application.  To do so, click
"Add Network Users" above</span>
<hr noshade color="#C0C0C0" size="2">
<span class="message"><%=strError%></span>
<form method="post" action="registerUser.asp" name="frmUser">
	<table border="0" cellpadding="0" cellspacing="2" class="normal">
		<tr>
			<td class="normalBold-Big" width="200">
				Login Information
			</td>
			<td align="left" class="normalBold" width="150">
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
			<td align="left" class="normalBold" width="150">
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
			<td class="normalBold-Big" width="200">
				Contact Information
			</td>
			<td align="left" class="normalBold" width="150">
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
				User Type
				<%=common_requiredFlag()%>
			</td>
			<td>
				<select name="userType">
					<option value="<%=SV_USER_TYPE_CREATOR%>"
<%
					If intNewUserType = SV_USER_TYPE_CREATOR Then
%>
						selected
<%
					End If
%>
					>Create and Take</option>
					<option value="<%=SV_USER_TYPE_TAKE_ONLY%>"
<%
					If intNewUserType = SV_USER_TYPE_TAKE_ONLY Then
%>
						selected
<%
					End If
%>
					>Take Surveys</option>
					<option value="<%=SV_USER_TYPE_ADMINISTRATOR%>"
<%
					If intNewUserType = SV_USER_TYPE_ADMINISTRATOR Then
%>
						selected
<%
					End If
%>
					>Administrator</option>
				</select>	
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
						<input type="text" name="customField1" value="<%=strCustomField1%>">	
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
						<input type="text" name="customField2" value="<%=strCustomField2%>">	
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
						<input type="text" name="customField3" value="<%=strCustomField3%>">	
					</td>
				</tr>

<%
			End If
%>

	</table>
<%
If user_groupsExist = True Then

		Call user_groupListJavascript()
%>
		<hr noshade color="#C0C0C0" size="2">
		<table cellpadding="0" cellspacing="0" class="normal">
		<tr>
			<td class="normalBold-Big" width="200" valign="top">
				User Groups
			</td>
			<td>
		<table cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="normal">Available User Groups</td>
			<td>&nbsp;</td>
			<td class="normal">Current Groups For This User</td>
		</tr>
		<tr>
		<td valign="top">
		<select name="allGroups" size="2" style="WIDTH: 216px; height=300px;">
<%
			
		strSQL = "SELECT groupName FROM usd_userGroups ORDER BY groupName "
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then	
			arrAllGroups = rsResults.GetRows
			intGroupArraySize = (Ubound(arrAllGroups, 2) - LBound(arrAllGroups, 2)) + 1
			For intArrayLooper = 0 to intGroupArraySize - 1
				strGroupName = arrAllGroups(0,intArrayLooper)
%>
				<option value="<%=strGroupName%>"><%=strGroupName%></option>
<%			
			Next
		End If
		rsResults.Close
%>
		</select>
		</td>
		<td valign="top">
			<input type="submit" value="> " onclick="javascript:moveItemRight();return false;" id=submit2 name=submit2><br />
			<input type="submit" value="< " onclick="javascript:removeItem();return false;" id=submit1 name=submit1><br />
			
		</td>
		<td valign="top">
			<select name="userGroups" size="2" style="WIDTH: 216px; height=300px;"></select>
		</td>
		</tr>
		</table></td></tr></table>	
		
<%
End If
%>		
	
	<hr noshade color="#C0C0C0" size="2">
	<table>
		<tr>
			<td width="200">
				&nbsp;
			</td>
			<td>
				<input type="image" src="images/button-addUser.gif" alt="Add User" 
<%
				If user_groupsExist = True Then
%>				
				onclick="javascript:updateGroups();"
<%
				End If
%>				
				>
				<input type="hidden" name="submit" value="Add User">
				<input type="hidden" name="groupsChosen" value="">
			</td>
		</tr>
	</table>
</form>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

