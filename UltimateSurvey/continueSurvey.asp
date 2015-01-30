<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		continueSurvey.asp 
' Purpose:	page to decide whether to continue or restart a survey
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
<!--#INCLUDE FILE="Include/response_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
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
	Dim intResponseInProgressID
	Dim strGUID
	Dim intPageNumber
	Dim intResponseID
	Dim boolItemsShown
	Dim intAction
	Dim intLastPageAnswered
	Dim intLastQuestionNumber
	
	Call user_loginNetworkUser()
	
	
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",False)
	
	intSurveyID = cint(Request.QueryString("surveyID"))
		
	If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
		strGUID = Request.Cookies(SV_COOKIE_NAME & "survey" & intSurveyID)("userID" & intUserID & "responseGUID")
	ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then
		strGUID = Session("survey" & intSurveyID & "responseGUID")
	End If		
		
	intResponseID = response_getResponseInProgressID(strGUID, intUserID, intSurveyID)
	
	If not utility_isPositiveInteger(intPageNumber) Then
		intPageNumber = 1
	End If
		
	strSQL = "SELECT surveyTitle, surveyDescription, allowContinue " &_
			 "FROM usd_Survey " &_
			 "WHERE surveyID = " & intSurveyID
	
	Set rsResults = utility_getRecordset(strSQL)

	If rsResults.EOF Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_UNKNOWN_ERROR)
	ElseIf cbool(rsResults("allowContinue")) = False Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_UNKNOWN_ERROR)
	Else
		intAction = cint(Request.QueryString("action"))
		Select Case intAction
			Case SV_ACTION_RESTART_SURVEY
				Call survey_deleteResponseInProgress(intResponseID)
				If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
					Response.Cookies(SV_COOKIE_NAME & "survey" & intSurveyID).expires = now()
				ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then
					Call user_clearSurveySessionInfo(intSurveyID)
				End If
					
				Response.Redirect("takeSurvey.asp?surveyID=" & intSurveyID & survey_getQueryString(intSurveyID))
			Case SV_ACTION_CONTINUE_SURVEY 
				intLastPageAnswered = response_getLastPageAnswered(intResponseID, intSurveyID)
				intLastQuestionNumber = response_getLastQuestionNumber(intResponseID)
				Response.Redirect("takeSurvey.asp?surveyID=" & intSurveyID & "&lastQuestionNumber=" & intLastQuestionNumber &_
									"&pageNumber=" & (intLastPageAnswered + 1))
		End Select
%>
	<%=header_htmlTop("white","")%>
	<%=header_writeHeader(intUserType,SV_PAGE_TYPE_SURVEYS)%>	
		<p class="surveyTitle">
			<%=rsResults("surveyTitle")%>
		</p>
		<p class="normal">
			<%=rsResults("surveyDescription")%>
		</p>
		<%
	
	rsResults.Close
	Set rsResults = NOTHING
%>
		<p class="heading">Would you like to continue this survey where you left off?</p>
		<p>
			<a class="normalBold"
				href="continueSurvey.asp?surveyID=<%=intSurveyID%>&action=<%=SV_ACTION_CONTINUE_SURVEY%>">
				Continue&nbsp;-&nbsp;Return to the last page you were working on to finish the survey.</a>
		</p>
		<p><!--
			<a class="normalBold"
				href="continueSurvey.asp?surveyID=<%=intSurveyID%>&action=<%=SV_ACTION_RESTART_SURVEY%><%=survey_getQueryString(intSurveyID)%>">
				Restart&nbsp;-&nbsp;This will clear all your previous answers and start you over on page 1.</a> -->
		</p>
<%	
	End If
			
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

