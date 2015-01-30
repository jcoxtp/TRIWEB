<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
Server.ScriptTimeout = 6000
'***********************************************************
' * Name:		surveyComplete.asp                         *
' * Purpose:	page to process the completion of a survey *
' **********************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/response_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/reports_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
Dim intUserType
Dim intUserID
Dim strSQL
Dim rsResults
Dim strSurveyTitle
Dim strDescription
Dim intSurveyType 
Dim strError
Dim intSurveyID
Dim boolIsActive
Dim intDelete
Dim intMoveItem
Dim intDirection
Dim intPageID
Dim strGUID
Dim intPageNumber
Dim intResponseID
Dim strCompletionMessage
Dim strCompletionRedirect
Dim intTimesTaken
Dim intPrivacyLevel
Dim strResultsEmail
Dim strScoreMessage
Dim boolScored
Dim intTemplateID
Dim boolUseStandardUI
Dim strHeader
Dim strFooter
Dim strBaseFont
Dim strTitleColor
Dim intTitleSize
Dim strSurveyDescriptionColor
Dim intSurveyDescriptionSize
Dim strBackgroundColor
Dim intEditResponseID
Dim boolUpdateDateCompleted
Dim intInviteID
Dim strUsersEmail
Dim boolEmailUser

Call user_loginNetworkUser()

'Get the userid and usertype out of the session or cookie
Call user_getSessionInfo(intUserID, intUserType, "","", "",False)

intSurveyID = cint(Request.QueryString("surveyID"))
intEditResponseID = Request.QueryString("editResponseID")

If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
	strGUID = Request.Cookies(SV_COOKIE_NAME & "survey" & intSurveyID)("userID" & intUserID & "responseGUID")
ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then
	strGUID = Session("survey" & intSurveyID & "responseGUID")
End If

intResponseID = response_getResponseInProgressID(strGUID, intUserID, intSurveyID)

If utility_isPositiveInteger(intEditResponseID) Then
	Call response_deleteResponse(intEditResponseID)
	boolUpdateDateCompleted = False
Else
	boolUpdateDateCompleted = True
End If

If utility_isPositiveInteger(intResponseID) Then
	Call response_commitResponse(intResponseID, boolUpdateDateCompleted)
	Call response_incrementSurveyResponses(intSurveyID)
	If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
		Response.Cookies(SV_COOKIE_NAME & "survey" & intSurveyID)("completedID") = intResponseID
		intInviteID = Request.Cookies(SV_COOKIE_NAME & "surveyID" & intSurveyID & "inviteID")
	ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then			
		Session("survey" & intSurveyID & "completedID") = intResponseID
		intInviteID = session("surveyID" & intSurveyID & "inviteID")
	End if
	If utility_isPositiveInteger(intInviteID) Then
		strSQL = "UPDATE usd_invitedList SET responded = 1 WHERE invitationID = " & intInviteID
		Call utility_executeCommand(strSQL)
	End If
End If

'' JT Added this functionality as a hack for CNL survey. This sends 
'' a copy of the response to the person that just took the survey...
'strSQL = "SELECT emailUser FROM usd_survey WHERE surveyID = " & intSurveyID
'Set rsResults = utility_getRecordset(strSQL)
'boolEmailUser = rsResults("emailUser")
'rsResults.Close
'Set rsResults = NOTHING
'If boolEmailUser = 1 and utility_isPositiveInteger(intResponseID) Then
'	strSQL = "SELECT email FROM usd_surveyUser WHERE userID = " & intUserID
'	Set rsResults = utility_getRecordset(strSQL)
'	strUsersEmail = rsResults("email")
'	Call response_sendResults(intResponseID, strUsersEmail)
'	rsResults.Close
'	Set rsResults = NOTHING
'End If

strSQL = "SELECT surveyTitle, surveyDescription, responsesPerUser, completionMessage, " &_
		 "completionRedirect, privacyLevel, resultsEmail, isScored, templateID " &_
		 "FROM usd_Survey " &_
		 "WHERE surveyID = " & intSurveyID
Set rsResults = utility_getRecordset(strSQL)
If utility_isPositiveInteger(rsResults("responsesPerUser")) Then
	If not utility_isPositiveInteger(intUserID) Then
		If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
			intTimesTaken = cint(Request.Cookies(SV_COOKIE_NAME & "survey" & intSurveyID)("timesTaken"))
		ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then
			intTimesTaken = Cint(Session("survey" & intSurveyID & "timesTaken"))
		End If
		If not utility_isPositiveInteger(intTimesTaken) Then
			intTimesTaken = 0 
		End If
		If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
			Response.Cookies(SV_COOKIE_NAME & "survey" & intSurveyID)("timesTaken") = intTimesTaken + 1
			Response.Cookies(SV_COOKIE_NAME & "survey" & intSurveyID).Expires = date() + 10000
		ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then
			Session("survey" & intSurveyID & "timesTaken") = intTimesTaken + 1
		End If
	End If
Else
	If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
		Response.Cookies(SV_COOKIE_NAME & "survey" & intSurveyID).expires = now()
	ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then
		Call user_clearSurveySessionInfo(intSurveyID)
	End If
End If

strSurveyTitle = rsResults("surveyTitle")
strDescription = rsResults("surveyDescription")
strCompletionMessage = rsResults("completionMessage")
strCompletionRedirect = rsResults("completionRedirect")
intPrivacyLevel = rsResults("privacyLevel")
strResultsEmail = rsResults("resultsEmail")
boolScored = cbool(rsResults("isScored"))
intTemplateID = rsResults("templateID")
rsResults.Close
Set rsResults = NOTHING

strSQL = "SELECT header, footer, baseFont, backgroundColor, titleSize, titleColor, " &_
		 "surveyDescriptionSize, surveyDescriptionColor, useStandardUI " &_
		 "FROM usd_styleTemplates " &_
		 "WHERE templateID = " & intTemplateID

Set rsResults = utility_getRecordset(strSQL)
If not rsResults.EOF Then
	strHeader = rsResults("header")
	strFooter = rsResults("footer")
	strBaseFont = rsResults("baseFont")
	strBackgroundColor = rsResults("backgroundColor")
	intTitleSize = rsResults("titleSize")
	strTitleColor = rsResults("titleColor")
	intSurveyDescriptionSize = rsResults("surveyDescriptionSize")
	strSurveyDescriptionColor = rsResults("surveyDescriptionColor")
	boolUseStandardUI = cbool(rsResults("useStandardUI"))
End If

rsResults.Close
Set rsResults = NOTHING

If strResultsEmail <> "" and utility_isPositiveInteger(intResponseID) Then
	Call response_sendResults(intResponseID, strResultsEmail)
End If

If strCompletionRedirect <> "" Then 
	Response.Redirect(strCompletionRedirect)
End If

If not utility_isPositiveInteger(intResponseID) Then
	If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
		intResponseID = Request.Cookies(SV_COOKIE_NAME & "survey" & intSurveyID)("completedID")
	ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then
		intResponseID = Session("survey" & intSurveyID & "completedID")
	End If
End If

Call survey_updateResponseCount(intSurveyID)
%>

<%=header_htmlTop(strBackgroundColor,"")%>
<%
If not isNull(strHeader) Then
%>
		<%=strHeader%>
<%
End If

If boolUseStandardUI = True Then
	Call header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)
Else
	Call header_padding()
End If
%>
		<p>
			<font face="<%=strBaseFont%>" size="<%=intTitleSize%>" color="<%=strTitleColor%>">
					<%=strSurveyTitle%></font>
			<br />
			<font face="<%=strBaseFont%>" size="<%=intSurveyDescriptionSize%>" color="<%=strSurveyDescriptionColor%>">
				<%=strDescription%></font>
		</p>
		<font face="<%=strBaseFont%>" size="<%=intSurveyDescriptionSize%>" color="<%=strSurveyDescriptionColor%>">
			<%=strCompletionMessage%></font><br />
<%
		If boolScored = True Then
			Call response_getScoreMessages(intResponseID, intSurveyID)
		End If

		If (intPrivacyLevel <> SV_PRIVACY_LEVEL_PRIVATE) or (survey_getOwnerID(intSurveyID) = cint(intUserID)) Then
			If not utility_isPositiveInteger(intUserID) Then
%>
			<a class="normalBold" href="viewResultsNoHeader.asp?surveyID=<%=intSurveyID%>">
				<img src="images/button-viewResults.gif" alt="View Results" border="0"></a>&nbsp;&nbsp;
			
<%
			Else
%>
			<a class="normalBold" href="viewResults.asp?surveyID=<%=intSurveyID%>">
				<img src="images/button-viewResults.gif" alt="View Results" border="0"></a>&nbsp;&nbsp;
			
<%
			End If
		End If

		If (utility_isPositiveInteger(intResponseID) _
			 and intPrivacyLevel <> SV_PRIVACY_LEVEL_PRIVATE) or cint(intUserID) = survey_getOwnerID(intSurveyID) Then
%>
			<a class="normalBold" 
					href="viewResponseDetails.asp?responseID=<%=intResponseID%>">
					<img src="images/button-reviewResponse.gif" alt="Review Response" border="0"></a>&nbsp;&nbsp;
		
<%
		End If

		If cint(intUserID) = survey_getOwnerID(intSurveyID) Then
%>
					<a class="normalBold" href="deleteResponse.asp?surveyID=<%=intSurveyID%>&responseID=<%=intResponseID%>"
					onclick="javascript:return confirmAction('Are you sure you want to delete this response?');">
						<img src="images/button-deleteResponse.gif" alt="Delete Response" border="0"></a>&nbsp;

<%
		End If
If boolUseStandardUI = True Then
%>
	
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

<%
Else
	Call header_bottomPadding()
End If

If len(strFooter) > 0 Then
%>
	<%=strFooter%>
<%
End If
%>
