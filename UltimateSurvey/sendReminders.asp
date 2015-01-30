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
	Dim intSurveyID
	Dim boolIsActive
	Dim intCounter
	Dim intUserCount
	Dim strSurveyTitle
	Dim boolSendEmail
	Dim strEmailContent
	Dim strEmailSubject
	Dim intPermittedUserID
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
	Dim intInvitationID
	Dim intInvitedCount
	Dim strPopupHTML
	Dim boolLoginInfo
	Dim strUsername
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = cint(Request.QueryString("surveyID"))

	If ((survey_getOwnerID(intSurveyID) <> intUserID) _
			and intUserType = SV_USER_TYPE_CREATOR) _
			or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	
	
	intSurveyType = survey_getSurveyType(intSurveyID)
	
	If intSurveyType = SV_SURVEY_TYPE_RESTRICTED Then
		strSQL = "SELECT U.email, U.username, U.pword " &_
				 "FROM usd_surveyUser U, usd_restrictedSurveyUsers RSU " &_
				 "WHERE U.userID = RSU.userID " &_
				 " AND U.userID NOT IN(SELECT userID FROM usd_response WHERE completed = 1 AND surveyID = " & intSurveyID & " AND userID IS NOT NULL)" &_
				 " AND U.email IS NOT NULL" &_
				 " AND RSU.surveyID = " & intSurveyID &_
				 " AND RSU.isPermitted = 1"
	ElseIf intSurveyType = SV_SURVEY_TYPE_REGISTERED_ONLY Then
		strSQL = "SELECT U.email, U.username, U.pword FROM usd_surveyUser U WHERE U.userID NOT IN(SELECT userID FROM usd_response " &_
				 "WHERE surveyID = " & intSurveyID & " AND completed = 1 AND userID IS NOT NULL)"	&_
				 " AND U.email IS NOT NULL"
	Else
		strSQL = "SELECT email, invitationID " &_
				 "FROM usd_invitedList " &_
				 "WHERE surveyID = " & intSurveyID & " AND responded = 0"
	End If
	
	
	
	If Request.Form("submit") = "Submit" Then
		intInvitedCount = 0
		Call header_htmlTop("white","")
		Call header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)
		Response.Flush
%>
		<span class="breadcrumb" align="left">
	<a href="manageSurveys.asp">All Surveys</a> >>
	<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=survey_getSurveyTitle(intSurveyID)%></a> >>
	Send Reminders
	</span><br /><br />
<%		
		strFromAddress = trim(Request.Form("fromAddress"))
		intUserCount = cint(Request.Form("userCount")) 
		
		strEmailSubject = trim(Request.Form("emailSubject"))
		strEmailContent = trim(Request.Form("emailBodyHeader")) & vbcrlf &_
						   trim(Request.Form("emailBodyURL"))
		If intSurveyType <> SV_SURVEY_TYPE_PUBLIC Then
			strEmailContent = strEmailContent & vbcrlf & vbcrlf & "You will have to log in to gain access to "  &_
									"this survey."
		End If
	
	
		If Request.Form("sendLoginInfo") = "on" Then
			boolLoginInfo = True
		Else
			boolLoginInfo = False
		End If
		
		Set rsResults = Server.CreateObject("ADODB.Recordset")
		rsResults.CursorLocation = adUseClient
		rsResults.Open utility_ConvertSQL(strSQL), DB_CONNECTION
		Response.Write "<span class=""normalBold"">Preparing to send " & rsResults.RecordCount & " reminders.  Please do not stop or refresh the page.</span><br />"
		If not rsResults.EOF Then
			Do until rsResults.EOF
				strEmailBody = ""
				strToAddress = rsResults("email")
				If strToAddress <> "" Then
							strEmailBody = strEmailContent
									
							If intSurveyType = SV_SURVEY_TYPE_PUBLIC Then
								intInvitationID = rsResults("invitationID")
								strEmailBody = replace(strEmailBody,"&invid=X","&invid=" & intInvitationID)
								
							End If
							
							If boolLoginInfo = True Then
								strUsername = rsResults("username")
								strPassword = rsResults("pword")
								
								strEmailBody = strEmailBody & vbcrlf & vbcrlf &_
									  "Username: " & strUsername & vbcrlf &_
									  "Password: " & strPassword
							End If
							
							Call utility_sendMail(strFromAddress, strToAddress, _
													strEmailSubject, strEmailBody)
							Response.Write "<span class=""normal"">Reminder sent to: " & strToAddress & ".</span><br />"
							intInvitedCount = intInvitedCount + 1
				End If
				rsResults.MoveNext
			Loop
		End If
		rsResults.Close
		Set rsResults = NOTHING
		Response.Write "<span class=""normalBold"">" & intInvitedCount & " reminders sent.</span><br />"
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
	Send Reminders
	</span><br /><br />
	
	<p class="surveyTitle">Send Reminders<%=common_helpLink("surveys/inviteUsers.asp",SV_SMALL_HELP_IMAGE)%></p>
	<hr noshade color="#C0C0C0" size="2">
<%
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
%>
	<form method="post" action="sendReminders.asp?surveyID=<%=intSurveyID%>" id=form1 name=form1>
	
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
						value="Reminder To Take Survey at <%=SV_SITENAME%>">
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td valign="top">
						Email Body <br />
						<textarea name="emailBodyHeader" cols="90" rows="5">This is a reminder to take the survey "<%=strSurveyTitle%>" at <%=SV_SITENAME%>.  Please proceed to <%=strDefaultURL%>
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
			
			strPopupHTML = "<html><head><title>Addresses To Remind</title><link rel=stylesheet href=Include/Stylesheets/ultimateAppsStyles.css type=text/css /></head>" &_ 
						"</body><span class=normal>"
			Do until rsResults.EOF

				strPopupHTML = strPopupHTML & utility_JavascriptEncode(rsResults("email")) & "<br>"
		
				rsResults.MoveNext
			Loop
			strPopupHTML = strPopupHTML & "</span></body</html>"
%>

			<table class="normal" cellpadding="0" cellspacing="0" ID="Table1">
				<tr>
					<td class="normal" width="200" valign="top">&nbsp;</td><td>
		<a class="normal" href="#" onclick="addressesPopup('<%=strPopupHTML%>');">Show Addresses</a>
			</td></tr></table>
			<hr noshade color="#C0C0C0" size="2">

			<table cellpadding="0" cellspacing="0">
				<tr>
					<td width="200">
						&nbsp;
					</td>
					<td>
						<input type="image" src="images/button-send.gif" alt="Send" border="0">
						<input type="hidden" name="submit" value="Submit">
					</td>
				</tr>
			</table>
		</form>

<%

	Else	
%>
		<span class="normal">Everyone invited has taken the survey.  No reminders can be sent.</span>
<%
	End If
	
		rsResults.Close
		Set rsResults = NOTHING
'	End If

%>

	
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
