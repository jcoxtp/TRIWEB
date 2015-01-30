<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
Server.ScriptTimeout = 6000
'****************************************************
'
' Name:		sendInvitations.asp 
' Purpose:	page to send invitations to users permitted to take a survey
' Changes:
'****************************************************
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
	Dim intSurveyID
	Dim boolIsActive
	Dim intCounter
	Dim intUserCount
	Dim strSurveyTitle
	Dim boolSendEmail
	Dim strEmailContent
	Dim strEmailSubject
	Dim intInviteUserID
	Dim intSurveyType
	Dim intNewUserFields
	Dim strToAddress
	Dim strPassword
	Dim intUserIDOut
	Dim strDefaultURL
	Dim arrEmails
	Dim strEmails
	Dim intMaxCounter
	Dim strEmailBody
	Dim strUserEmail
	Dim boolBlockDuplicate
	Dim strFromAddress
	Dim strListName
	Dim strUserGroups
	Dim arrGroupsChosen
	Dim intGroupArraySize 
	Dim intInvitationID
	Dim intInvitedCount
	Dim strPopupHTML
	Dim strUsername
	Dim boolLoginInfo
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = cint(Request.QueryString("surveyID"))

	If not utility_isPositiveInteger(intUserID) Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	Else 
		If ((survey_getOwnerID(intSurveyID) <> intUserID) _
				and intUserType = SV_USER_TYPE_CREATOR) _
				or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
			Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
		End If
	End If

	intSurveyType = survey_getSurveyType(intSurveyID)
	
	
	If intSurveyType = SV_SURVEY_TYPE_RESTRICTED Then
		strSQL = "SELECT U.email, U.userID, U.username, U.pword " &_
				 "FROM usd_surveyUser U, usd_restrictedSurveyUsers RSU " &_
				 "WHERE U.userID = RSU.userID " &_
				 "AND RSU.invited = 0 " &_
				 "AND U.email IS NOT NULL" &_
				 " AND RSU.surveyID = " & intSurveyID &_
				 " AND RSU.isPermitted = 1"
	ElseIf intSurveyType = SV_SURVEY_TYPE_REGISTERED_ONLY Then
		strSQL = "SELECT email, userID, username, pword FROM usd_surveyUser WHERE email IS NOT NULL" &_
				 " AND userID NOT IN (SELECT userID FROM usd_response WHERE surveyID = " & intSurveyID & " AND completed = 1 AND userID IS NOT NULL)" &_
				 " AND email NOT IN(SELECT email FROM usd_invitedList WHERE surveyID = " & intSurveyID & ")"
	End If
	

	If Request.Form("submit") = "Submit" Then
		Call header_htmlTop("white","")
		Call header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)
%>
		<span class="breadcrumb" align="left">
		<a href="manageSurveys.asp">All Surveys</a> >>
		<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=survey_getSurveyTitle(intSurveyID)%></a> >>
		Send Invitations
		</span><br /><br />
<%
		Response.Write "</td></tr></table>"
		Response.Flush
		intInvitedCount = 0
		strFromAddress = trim(Request.Form("fromAddress"))
		intUserCount = cint(Request.Form("userCount")) 
		
		strEmailSubject = trim(Request.Form("emailSubject"))
		strEmailContent = trim(Request.Form("emailBodyHeader")) & vbcrlf &_
						   trim(Request.Form("emailBodyURL"))

	
		If intSurveyType = SV_SURVEY_TYPE_PUBLIC Then
			Set rsResults = server.CreateObject("ADODB.Recordset")
			
			strUserGroups = Request.Form("groupsChosen")
	
			If len(trim(strUserGroups)) > 0 Then
				arrGroupsChosen = split(strUserGroups, ";" )
				intGroupArraySize = Ubound(arrGroupsChosen)
		
				For intCounter = 0 to intGroupArraySize
					strListName = arrGroupsChosen(intCounter)
					
					strSQL = "SELECT email FROM usd_emailListDetails WHERE listName = " & utility_SQLEncode(strListName, True) 
					rsResults.Open strSQL, DB_CONNECTION
		
					If not rsResults.EOF Then
				
						Do until rsResults.EOF
			
							strUserEmail = rsResults("email")
							If utility_isValidEmail(strUserEmail) Then
				
								If inviteUsers_isInvited(intSurveyID, strUserEmail) = False Then
									Call inviteUsers_addInvitedEmail(intSurveyID, strUserEmail, intInvitationID)
									
									strEmailBody = replace(strEmailContent,"&invid=X","&invid=" & intInvitationID)
									Call utility_sendMail(strFromAddress, strUserEmail, _
														strEmailSubject, strEmailBody)
									intInvitedCount = intInvitedCount + 1
									Response.Write "<span class=""normal"">Invitation sent to: " & strUserEmail & "</span><br />"
									Response.Flush
								Else
									Response.Write "<span class=""normal"">" & strUserEmail & " was already invited.</span><br />"
									Response.Flush
								End If
							Else
								Response.Write "<span class=""normal"">" & strUserEmail & " is not a valid email address.</span><br />"
								Response.Flush
							End If
							rsResults.MoveNext
						Loop
					End If	
					rsResults.Close
				Next
			End If
		
			On Error Resume Next
			
			arrEmails = split(Request.Form("emailAddresses"), vbCrlf)
		If Err.number <> 0 then
		
			strError = "Error: You entered too many rows. Please reduce the number of rows and try again" 
			
			boolError = True

		Else
			
			intMaxCounter = ubound(arrEmails)
			
			If utility_isPositiveInteger(intMaxCounter) Then
			
				Response.Write "<span class=""normalBold"">Preparing to send " & intMaxCounter & " invitations.</span><br />"
				Response.Flush
			End If
				
			For intCounter = 0 TO intMaxCounter
				strEmailBody = ""
				strUserEmail = trim(arrEmails(intCounter))
				If utility_isValidEmail(strUserEmail) Then
					If inviteUsers_isInvited(intSurveyID, strUserEmail) = False Then
						Call inviteUsers_addInvitedEmail(intSurveyID, strUserEmail, intInvitationID)
						strEmailBody = replace(strEmailContent,"&invid=X","&invid=" & intInvitationID)
						Call utility_sendMail(strFromAddress, strUserEmail, strEmailSubject, strEmailBody)
						intInvitedCount = intInvitedCount + 1
						Response.Write "<span class=""normal"">Invitation sent to: " & strUserEmail & "</span><br />"
						Response.Flush
					Else	
						Response.Write "<span class=""normal"">" & strUserEmail & " was already invited.</span><br />"
									Response.Flush
					End If
				Else
					Response.Write "<span class=""normal"">" & strUserEmail & " is not a valid email address.</span><br />"
					Response.Flush
				End If		
			Next
			
		End If
		End If
	

	
		If Request.Form("inviteAllUsers") = "on" Then
			strSQL = "SELECT userID, email " &_
					 "FROM usd_SurveyUser"
			Set rsResults = utility_getRecordset(strSQL)
			If not rsResults.EOF Then
				Do until rsResults.EOF
					If intSurveyType = SV_SURVEY_TYPE_RESTRICTED Then
							Call inviteUsers_addRestrictedSurveyUser(intSurveyID, rsResults("userID"))
					End If
					strUserEmail = rsResults("email")
					If utility_isValidEmail(strUserEmail) and boolSendEmail = True Then
						If inviteUsers_isInvited(intSurveyID, strUserEmail) = False or boolBlockDuplicate = False Then
							Call inviteUsers_addInvitedEmail(intSurveyID, strUserEmail, intInvitationID)
							
							strEmailBody = replace(strEmailBody,"&invid=X","&invid=" & intInvitationID)
							Call utility_sendMail(strFromAddress, strUserEmail, _
												strEmailSubject, strEmailContent)
							
							intInvitedCount = intInvitedCount + 1
							Response.Write "<span class=""normal"">Invitation sent to: " & strUserEmail & "</span><br />"
							Response.Flush
							
						End If
					End If
					rsResults.MoveNext
				Loop
			End If	
			rsResults.Close
			Set rsResults = NOTHING
		End If
		
	
		
		If intSurveyType <> SV_SURVEY_TYPE_PUBLIC Then
					
		
			Set rsResults = utility_getRecordset(strSQL)
		
			If not rsResults.EOF Then
				If Request.Form("sendLoginInfo") = "on" Then
					boolLoginInfo = True
				Else
					boolLoginInfo = False
				End If
				
				Do until rsResults.EOF 
					strUserEmail = rsResults("email")
					intInviteUserID = rsResults("userID")
					strUsername = rsResults("username")
					strPassword = rsResults("pword")
					
					strEmailBody = strEmailContent
				
					If boolLoginInfo = True Then
						strEmailBody = strEmailBody & vbcrlf & vbcrlf &_
									  "Username: " & strUsername & vbcrlf &_
									  "Password: " & strPassword
					End If
					
					Call utility_sendMail(strFromAddress, strUserEmail, _
											strEmailSubject, strEmailBody)
				
					intInvitedCount = intInvitedCount + 1
					Response.Write "<span class=""normal"">Invitation sent to: " & strUserEmail & "</span><br />"
					Response.Flush
				
					If intSurveyType = SV_SURVEY_TYPE_RESTRICTED Then
						strSQL = "UPDATE usd_restrictedSurveyUsers SET invited = 1 WHERE userID = " & intInviteUserID & " AND surveyID = " & intSurveyID
						Call utility_executeCommand(strSQL)
					Else
						Call inviteUsers_addInvitedEmail(intSurveyID, strUserEmail, "")
					End If
					
					rsResults.MoveNext
				Loop
			End If
		End If
		
		Response.Write "<span class=""normalBold"">" & intInvitedCount & " invitations sent.</span>"
		Response.End
		
	End If
	
	intCounter = 0
	strSurveyTitle = survey_getSurveyTitle(intSurveyID)
	If intSurveyType = SV_SURVEY_TYPE_PUBLIC Then
		strDefaultURL = SV_ROOT_PATH & "takeSurvey.asp?surveyID=" & intSurveyID & "&invid=X"
	Else
		strDefaultURL = SV_ROOT_PATH & "login.asp?surveyID=" & intSurveyID
	End If

%>
	<%=header_htmlTop("white","")%>
	<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
	
	<span class="breadcrumb" align="left">
	<a href="manageSurveys.asp">All Surveys</a> >>
	<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=survey_getSurveyTitle(intSurveyID)%></a> >>
	Send Invitations
	</span><br /><br />
	
	<p class="surveyTitle">Invite Users<%=common_helpLink("surveys/inviteUsers.asp",SV_SMALL_HELP_IMAGE)%></p>
<%
	If utility_checkForRecords(strSQL) = True or intSurveyType <> SV_SURVEY_TYPE_RESTRICTED Then
%>
	
	<form method="post" action="sendInvitations.asp?surveyID=<%=intSurveyID%>" name="frmUser" id="frmUser">
	<hr noshade color="#C0C0C0" size="2">
			<table class="normal" cellpadding="0" cellspacing="0" name="tblEmail" id="tblEmail">
				<tr>
					<td class="normalBold-Big" width="200" valign="top">
						Email Message Options
					</td>
					<td valign="top">
						From Address (Some addresses may be refused by server.
						Please double check to make sure email was sent)<br />
						<input name="fromAddress" value="<%=SV_MAIN_EMAIL%>" size="50" type="text">
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td valign="top">
						Email Subject<br />
						<input type="text" name="emailSubject" size="70" 
						value="Invitation To Take Survey at <%=SV_SITENAME%>">
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td valign="top">
						Email Body (Changing the URL is not suggested)<br />
						<textarea name="emailBodyHeader" cols="70" rows="5">You have been invited to take the survey "<%=strSurveyTitle%>" at <%=SV_SITENAME%>.  Please proceed to <%=strDefaultURL%>
						</textarea>
					</td>
				</tr>
<%
	If intSurveyType <> SV_SURVEY_TYPE_PUBLIC Then
%>
		<tr>
			<td>
				&nbsp;
			</td>
			<td valign="top">
				<input type="checkbox" name="sendLoginInfo" checked>Include login information in emails.		
			</td>
		</tr>
<%
	End If
%>
		</table>


<%
	
	If intSurveyType <> SV_SURVEY_TYPE_PUBLIC Then
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
			strPopupHTML = "<html><head><title>Addresses To Invite</title><link rel=stylesheet href=Include/Stylesheets/ultimateAppsStyles.css type=text/css /></head>" &_ 
						"</body><span class=normal>"
			Do until rsResults.EOF

				strPopupHTML = strPopupHTML & rsResults("email") & "<br>"
		
				rsResults.MoveNext
			Loop
			strPopupHTML = strPopupHTML & "</span></body</html>"
%>
		<table class="normal" cellpadding="0" cellspacing="0">
				<tr>
					<td class="normal" width="200" valign="top">&nbsp;</td><td>
		<a class="normal" href="#" onclick="addressesPopup('<%=strPopupHTML%>');">Show Addresses</a>
			</td></tr></table>
<%
		End If
		
		rsResults.Close
		Set rsResults = NOTHING
	ElseIf intSurveyType = SV_SURVEY_TYPE_PUBLIC Then
		Call user_groupListJavascript()
		strSQL = "SELECT listName FROM usd_emailLists ORDER BY listName"
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
			
%>
		<hr noshade color="#C0C0C0" size="2">
			<table><tr>
			<td width="200" class="normalBold-Big" valign="top">Email Lists</td>
			<td>
			<select name="allGroups" size="2" style="WIDTH: 216px; height=300px;">
<%
			Do until rsResults.EOF
				strListName = rsResults("listName")
%>
				<option value="<%=strListName%>"><%=strListName%></option>
<%
				rsResults.MoveNext
			Loop
%>
			</select></td>
			<td valign="top">
			<input type="submit" value="> " onclick="javascript:moveItemRight();return false;" id=submit2 name=submit2><br />
			<input type="submit" value="< " onclick="javascript:removeItem();return false;" id=submit1 name=submit1><br />
			</td>
			<td><select name="userGroups" size="2" style="WIDTH: 216px; height=300px;"></select></td></tr></table>
			
				
<%			
		End If
%>
		<hr noshade color="#C0C0C0" size="2">
			<table><tr>
			<td width="200" class="normalBold-Big" valign="top">Email Addresses</td>
			<td valign="top">
				<textarea name="emailAddresses" cols="70" rows="15"></textarea>
			</td></tr></table>
<%
	
	End If

	Else
%>
		<span class="normal">There are no users to invite.  Either all users with permission have been invited, or all or some of
		the users do not have an email address to send an invitation to.
	
<%
	
	If intSurveyType = SV_SURVEY_TYPE_RESTRICTED Then
		strSQL = "SELECT U.email " &_
				 "FROM usd_surveyUser U, usd_restrictedSurveyUsers RSU " &_
				 "WHERE U.userID = RSU.userID " &_
				 " AND U.userID NOT IN(SELECT userID FROM usd_response WHERE completed = 1 AND surveyID = " & intSurveyID & ")" &_
				 " AND U.email IS NOT NULL"
	ElseIf intSurveyType = SV_SURVEY_TYPE_REGISTERED_ONLY Then
		strSQL = "SELECT U.email FROM usd_surveyUser U WHERE U.userID NOT IN(SELECT userID FROM usd_response " &_
				 "WHERE surveyID = " & intSurveyID & " AND completed = 1)"	
	Else
		strSQL = "SELECT email, invitationID " &_
				 "FROM usd_invitedList " &_
				 "WHERE surveyID = " & intSurveyID & " AND responded = 0"
	End If	
	
	If utility_checkForRecords(strSQL) = True Then
%>		
		
		If you have sent some invitations already, you may want to <a href="sendReminders.asp?surveyID=<%=intSurveyID%>">Send Reminders</a>.
<%
	Else
%>
		All invited users have taken the survey.
<%		
	End If
%>
		</span>
<%	
	End If
	

%>
			<hr noshade color="#C0C0C0" size="2">
						<table cellpadding="0" cellspacing="0" ID="Table1">
				<tr>
					<td width="200">
						&nbsp;
					</td>
					<td>
						<input type="image" src="images/button-inviteUsers.gif" alt="Invite Users" border="0" 
<%
						If intSurveyType = SV_SURVEY_TYPE_PUBLIC Then
%>
							onclick="javascript:updateGroups();
<%
						End If
						
						If survey_isActive(intSurveyID) = False Then
%>
							return confirmAction('This survey is not active.  Are you sure you want to send invitations?');
<%
						End If
%>						
						 " id=image1 name=image1>
						 <input type="hidden" name="groupsChosen" value="" ID="Hidden1">
						<input type="hidden" name="submit" value="Submit" ID="Hidden2">
					</td>
				</tr>
			</table><br /></form>

<!--#INCLUDE FILE="Include/footer_inc.asp"-->

<script language="javascript">
	function addressesPopup(html)
	{
		var newPopup=window.open("","PopupWindow","height=600,width=600,toolbar=0,status=0,menubar=0,scrollbars=1,resizable=1,location=0");
		var popContent=html;
		newPopup.document.write(popContent);
		newPopup.focus();
		
	}

</script>
