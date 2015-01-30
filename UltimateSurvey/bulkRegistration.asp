<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
Server.ScriptTimeout = 6000
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/inviteUsers_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim intUserType
	Dim intUserID
	Dim strSQL
	Dim rsResults
	Dim intCounter
	Dim intUserCount
	Dim boolSendEmail
	Dim strEmailContent
	Dim strEmailSubject
	Dim intPermittedUserID
	Dim intSurveyType
	Dim intNewUserFields
	Dim strToAddress
	Dim strPassword
	Dim intUserIDOut
	Dim arrEmails
	Dim strEmails
	Dim intMaxCounter
	Dim strEmailBody
	Dim strUserEmail
	Dim boolBlockDuplicate
	Dim strFromAddress
	Dim strFieldText
	Dim boolEmail
	Dim intNewUserType
	Dim strMessage
	Dim strFailed
	Dim boolAdded
	Dim boolError
	Dim strError
	Dim strDomain
	Dim intLoginType
		
	Call user_loginNetworkUser()
	
	Call user_getSessionInfo(intUserID, intUserType,"","","",True)
	
		
	If intUserType <> SV_USER_TYPE_ADMINISTRATOR Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If
	
	boolError = False
	
	If Request.Form("submit") = "Submit" Then
				
		Dim intUsernamePosition
		Dim intPasswordPosition
		Dim intFirstNamePosition
		Dim intLastNamePosition
		Dim intEmailPosition
		Dim intTitlePosition
		Dim intCompanyPosition
		Dim intLocationPosition
		Dim strInfo
		Dim arrInfo
		Dim strFirstName
		Dim strLastName
		Dim strEmailAddress
		Dim strUsername
		Dim strLocation
		Dim strCompany
		Dim strTitle
		Dim strCustomUserField1
		Dim strCustomUserField2
		Dim strCustomUserField3
		Dim intCustomUserField1Position
		Dim intCustomUserField2Position
		Dim intCustomUserField3Position		
		Dim intNumberFieldsChosen
		Dim strUserGroup
		Dim intNewUserID
		Dim arrAllGroups
		Dim arrUserGroups
		Dim intGroupArraySize
		Dim intArrayLooper
		Dim strGroupName
		Dim strUserGroups
		Dim arrGroupsChosen

		intNewUserType = cint(Request.Form("userType"))		
		
		strFromAddress = trim(Request.Form("fromAddress"))
		strEmailSubject = trim(Request.Form("emailSubject"))
		strEmailContent = trim(Request.Form("emailBodyHeader"))
		strUserGroups = Request.Form("groupsChosen")
		
	
		If len(trim(strUserGroups)) > 0 Then
			arrGroupsChosen = split(strUserGroups, ";" )
			intGroupArraySize = Ubound(arrGroupsChosen)
		Else 
			intGroupArraySize = 0
		End If
				
		intNumberFieldsChosen = 0
		
		intLoginType = cint(request.Form("loginType"))
		strDomain = request.Form("domain")
		
		For intCounter = 1 to cint(Request.Form("numberFields"))
			strFieldText = trim(request.Form("field" & intCounter))
			Select Case strFieldText
				Case "User Name"
					intUsernamePosition = intCounter
					intNumberFieldsChosen = intNumberFieldsChosen + 1
				Case "Password"
					intPasswordPosition = intCounter
					intNumberFieldsChosen = intNumberFieldsChosen + 1
				Case "First Name"
					intFirstNamePosition = intCounter
					intNumberFieldsChosen = intNumberFieldsChosen + 1
				Case "Last Name"
					intLastNamePosition = intCounter
					intNumberFieldsChosen = intNumberFieldsChosen + 1
				Case "Email Address"
					intEmailPosition = intCounter
					intNumberFieldsChosen = intNumberFieldsChosen + 1
				Case "Title"
					intTitlePosition = intCounter
					intNumberFieldsChosen = intNumberFieldsChosen + 1
				Case "Company"
					intCompanyPosition = intCounter
					intNumberFieldsChosen = intNumberFieldsChosen + 1
				Case "Location"
					intLocationPosition = intCounter
					intNumberFieldsChosen = intNumberFieldsChosen + 1
				Case "customUserField1"
					intCustomUserField1Position = intCounter
					intNumberFieldsChosen = intNumberFieldsChosen + 1
				Case "customUserField2"
					intCustomUserField2Position = intCounter
					intNumberFieldsChosen = intNumberFieldsChosen + 1
				Case "customUserField3"
					intCustomUserField3Position = intCounter
					intNumberFieldsChosen = intNumberFieldsChosen + 1
			End Select 
		
		Next	
		
		
		On Error Resume Next
			
			arrEmails = split(Request.Form("emailAddresses"), vbCrlf)
		If Err.number <> 0 then
		
			strError = "Error: You entered too many rows. Please reduce the number of rows and try again" 
			
			boolError = True

		End If
		
	If Not boolError Then
		intMaxCounter = ubound(arrEmails)

		FOR intCounter = 0 TO intMaxCounter
			strInfo = trim(arrEmails(intCounter))
			
			arrInfo = split(strInfo,",")
			
			
			If len(strInfo) > 0 Then
				If ubound(arrInfo) <> (intNumberFieldsChosen - 1) Then
					strMessage = strMessage & "Line: " & strInfo & " not valid.<br />"
					strFailed = strFailed & strInfo & vbcrlf
				Else
					If utility_isPositiveInteger(intPasswordPosition) Then
						strPassword = trim(arrInfo(intPasswordPosition -1))
					ElseIf intLoginType = SV_LOGIN_TYPE_PASSWORD Then
						strPassword = user_generatePassword()
					End If

					If utility_isPositiveInteger(intFirstNamePosition) Then
						strFirstName = trim(arrInfo(intFirstNamePosition - 1))
					End If
			
					If utility_isPositiveInteger(intLastNamePosition) Then
						strLastName = trim(arrInfo(intLastNamePosition -1))
					End If
			
					If utility_isPositiveInteger(intEmailPosition) Then
						strEmailAddress = trim(arrInfo(intEmailPosition - 1))
					End If
			
					If utility_isPositiveInteger(intTitlePosition) Then
						strTitle = trim(arrInfo(intTitlePosition - 1))
					End If
			
					If utility_isPositiveInteger(intCompanyPosition) Then
						strCompany = trim(arrInfo(intCompanyPosition - 1))
					End If
			
					If utility_isPositiveInteger(intLocationPosition) Then
						strLocation = trim(arrInfo(intLocationPosition - 1))
					End If

					If utility_isPositiveInteger(intUsernamePosition) Then
						strUsername = trim(arrInfo(intUsernamePosition - 1))
					Else
						strUsername = strEmailAddress
					End If
			
					If utility_isPositiveInteger(intCustomUserField1Position) Then
						strCustomUserField1 = trim(arrInfo(intCustomUserField1Position - 1))
					End If

					If utility_isPositiveInteger(intCustomUserField2Position) Then
						strCustomUserField2 = trim(arrInfo(intCustomUserField2Position - 1))
					End If

					If utility_isPositiveInteger(intCustomUserField3Position) Then
						strCustomUserField3= trim(arrInfo(intCustomUserField3Position - 1))
					End If

					If utility_isValidEmail(strEmailAddress) = False and utility_isPositiveInteger(intEmailPosition) Then
						strMessage = strMessage & strEmailAddress & " is not a valid email address.  User not added.<br />"
						strFailed = strFailed & strInfo & vbcrlf
					ElseIf intLoginType = SV_LOGIN_TYPE_NETWORK and user_networkUserAdded(strUsername, strDomain) = True Then
						strMessage = strMessage & strUsername & " in " & strDomain & " is already in the system.<br />"
						strFailed = strFailed & strInfo & vbcrlf
					ElseIf user_usernameTaken(strUsername) = True Then
						strMessage = strMessage & strUsername & " is already a user in the system.  User not added.<br />"
						strFailed = strFailed & strInfo & vbcrlf
					ElseIf Request.Form("noDuplicateEmails") = "on" and user_emailExists(strEmailAddress) = True Then
						strMessage = strMessage & strEmailAddress & " is already an email address in the system.  User not added.<br />"
						strFailed = strFailed & strInfo & vbcrlf
					Else
				
						Call user_addUser(replace(strUsername,vbTab,""), strPassword, intNewUserType, strFirstName, strLastName, _
							strEmailAddress, strTitle, strCompany, strLocation, intLoginType, strDomain, strCustomUserField1, strCustomUserField2, strCustomUserField3, intNewUserID)

						boolAdded = True
			
						If Request.Form("sendEmail") = "on" Then
							Call utility_sendMail(strFromAddress, strEmailAddress, strEmailSubject, strEmailContent & vbcrlf & vbcrlf & "Username: " & strUserName & vbcrlf & "Password: " & strPassword)
						End If
				
						If len(trim(strUserGroups)) > 0 Then
							For intArrayLooper = 0 to intGroupArraySize
								strUserGroup = trim(arrGroupsChosen(intArrayLooper))
								If len(strUserGroup) > 0 Then
									Call user_addUserToGroup(strUserGroup, intNewUserID)
									Call inviteUsers_updateSurveyPermissions(intNewUser, strUserGroup)
								End If
							Next	
						End If			
					End If
				End If
			End If		
		NEXT	
		
		If len(trim(strMessage)) = 0 Then
			Response.Redirect("manageUsers.asp?message=" & SV_MESSAGE_USERS_ADDED)
		End If
				
	Else
		strFromAddress = SV_MAIN_EMAIL
		strEmailSubject = "You are registered with " & SV_SITENAME
		strEmailContent = "You have been registered with " & SV_SITENAME & ".  Please continue to " & SV_ROOT_PATH & "."
	End If
	
	intCounter = 0
	

	End If

	If not utility_isPositiveInteger(intNewUserType) Then
		intNewUserType = SV_DEFAULT_USER_TYPE
	End If

	
	boolEmail = False
%>
	<%=header_htmlTop("white","")%>
	<%=header_writeHeader(intUserType, SV_PAGE_TYPE_USERS)%>
	<form method="post" action="bulkRegistration.asp" name="frmUser">
<%
	If boolAdded = True Then
%>
		<span class="message">Users have successfully been added.</span><br />
<%
	End If
%>
			<span class="message"><%=strError%></span><br>
			<span class="message"><%=strMessage%></span>
			<hr noshade color="#C0C0C0" size="2">
			<table cellpadding="0" cellspacing="0" class="normal">
				<tr>
					<td class="normalBold-Big" width="200">
						User Type
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
			</table>
			<hr noshade color="#C0C0C0" size="2">
			<table cellpadding="0" cellspacing="0" class="normal" ID="Table1">
				<tr>
					<td class="normalBold-Big" width="200">
						Login Type
					</td>
					<td class="normal" valign="baseline">
						<input type="radio" name="loginType" value="<%=SV_LOGIN_TYPE_PASSWORD%>" checked>
						Username/Password
					</td>
					<td class="normal" valign="baseline">
						<input type="radio" name="loginType" value="<%=SV_LOGIN_TYPE_NETWORK%>">
						Network Authentication
					</td>
					<td class="normal" valign="baseline">
						&nbsp;&nbsp;&nbsp;&nbsp;Domain: <input type="text" name="domain">
						<%=common_helpLinkText("users/networkUsers.asp","(Network User Information)")%>
					</td>
				</tr>
			</table>

			<hr noshade color="#C0C0C0" size="2">
			<table cellpadding="0" cellspacing="0" class="normal">
				<tr>
					<td class="normalBold-Big" width="200" valign="top">
						Enter User Information
					</td>
					<td class="normal">
						Please enter user information in the following format, with a line break between each user:<br />
						
<b><%
						For intCounter = 1 to cint(Request.Form("numberFields"))
							strFieldText = trim(request.Form("field" & intCounter))
%><input type="hidden" name="field<%=intCounter%>" value="<%=strFieldText%>"><%
							
							Select Case strFieldText
								Case "customUserField1"
									strFieldText = SV_CUSTOM_USER_FIELD_1
								Case "customUserField2"
									strFieldText = SV_CUSTOM_USER_FIELD_2
								Case "customUserField3"
									strFieldText = SV_CUSTOM_USER_FIELD_3
								Case "Email Address"
									boolEmail = True
							End Select
							
							If len(strFieldText) > 0 Then
								If intCounter > 1 Then
									Response.Write ", " & strFieldText
								Else
									Response.Write strFieldText
								End If
							End If

						Next	
%></b>						
						<br><br>
					</td>

					
				<tr>
					<td>
						&nbsp;
					</td>
					<td>
						<span class="normalBold">Note: Approximately 1500 users can be registered in each batch.</span><br>
						
						<textarea name="emailAddresses" rows="20" cols="100"><%=strFailed%></textarea>
					</td>
				</tr>
			</table>	
<%
	If boolEmail = True Then
%>
			<hr noshade color="#C0C0C0" size="2">
			<table class="normal" cellpadding="0" cellspacing="0">
				<tr>
					<td class="normalBold-Big" width="200" valign="top">
						Validation Options
					</td>
					<td class="normalBold">
						<input type="checkbox" name="noDuplicateEmails"
<%
						If request.form("noDuplicateEmails") = "on" Then
%>
							checked
<%
						End if
%>
						>
						Prevent duplicate addresses<span class="normal">(Check this box to disallow duplicate email addresses in the system.)</span>
					</td>
				</tr>
			</table>
			
			<hr noshade color="#C0C0C0" size="2">
			<table class="normal" cellpadding="0" cellspacing="0">
				<tr>
					<td class="normalBold-Big" width="200" valign="top">
						Email Message Options
					</td>
					<td class="normalBold">
						<input type="checkbox" name="sendEmail" onclick="javascript:toggle('tblEmail')">
						Send email to each new user? <span class="normal">(Check this box to enable email and display options.)</span>
					</td>
				</tr>
			</table>
			<table class="normal" cellpadding="0" cellspacing="0" style="display:none" name="tblEmail" id="tblEmail">
				<tr>
					<td colspan="2">
						&nbsp;
					</td>
				<tr>
					<td width="200">
						&nbsp;
					</td>
					<td valign="top">
						<span class="normalBold">From Address</span> (Some addresses may be refused by server.
						Please double check to make sure email was sent)<br />
						<input name="fromAddress" value="<%=strFromAddress%>" size="50" type="text">
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td valign="top">
						<span class="normalBold">Email Subject</span><br />
						<input type="text" name="emailSubject" size="70" 
						value="<%=strEmailSubject%>">
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td valign="top">
						<span class="normalBold">Email Body</span><br />
						<textarea name="emailBodyHeader" cols="100" rows="10"><%=strEmailContent%></textarea>
					</td>
				</tr>
			</table>
<%
End If

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
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td width="200">
						&nbsp;
					</td>
					<td>
						<input type="image" src="images/button-submit.gif" alt="Submit" border="0" onclick="
<%
					If user_groupsExist() = True Then
%>						
						javascript:updateGroups();
<%
					End If
%>						
						">
						<input type="hidden" name="numberFields" value="<%=intCounter%>">
						<input type="hidden" name="groupsChosen" value="">
						<input type="hidden" name="submit" value="Submit">
					</td>
				</tr>
			</table>
			
		
		</form>

					
<!--#INCLUDE FILE="Include/footer_inc.asp"-->
<script language="javascript">
	function checkForm()
	{
		if (document.frmUser.loginType[1].checked)
		{
			if (document.frmUser.domain.value == '')
			{
				alert('Please specify a domain name or choose the Username/Password login type');
				return false;
			}
			else
			{
			return true;
			}
		}
		else
		{
			return true;
		}
	}
</script>
