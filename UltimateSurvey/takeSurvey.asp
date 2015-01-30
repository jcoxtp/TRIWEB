<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
'Response.CacheControl = "no-cache"
'Response.AddHeader "Pragma", "no-cache"
'Response.Expires = -2
'****************************************************
'
' Name:		takeSurvey.asp 
' Purpose:	page to begin taking a survey
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
<!--#INCLUDE FILE="Include/itemDisplay_inc.asp"-->
<!--#INCLUDE FILE="Include/response_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<%
	Dim intUserType
	Dim intUserID
	Dim strSQL
	Dim rsResults
	Dim strSurveyTitle
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
	Dim boolShowProgress
	Dim strSurveyDescription
	Dim boolAllowContinue
	Dim intLastPageNumber
	Dim boolLogNTUser
	Dim boolNumberLabels
	Dim intLastQuestionNumber
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
	Dim intQuestionSize
	Dim strQuestionColor
	Dim intQuestionDescriptionSize
	Dim strQuestionDescriptionColor
	Dim intAnswerSize
	Dim strAnswerColor
	Dim intEditResponseID
	Dim boolEditing
	Dim boolAdminEditing
	Dim strOddRowColor
	Dim strEvenRowColor
	Dim strHeaderColor
	Dim intInviteID
	Dim intNextPageID

	Call user_loginNetworkUser()

	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",False)

	intSurveyID = cint(Request.QueryString("surveyID"))
	intPageNumber = cint(Request.QueryString("pageNumber"))
	intLastQuestionNumber = Request.QueryString("lastQuestionNumber")

	If not utility_isPositiveInteger(intLastQuestionNumber) Then
		intLastQuestionNumber = 0
	Else
		intLastQuestionNumber = cint(intLastQuestionNumber)
	End If

	intEditResponseID = Request.QueryString("editResponseID")

	If utility_isPositiveInteger(intEditResponseID) Then
		boolEditing = True
	Else
		boolEditing = False
	End If

	If Request.QueryString("adminEditing") = "true" Then
		boolAdminEditing = True
	Else
		boolAdminEditing = False
	End If

	If survey_surveyAvailable(intSurveyID, intUserID, boolEditing) = False Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_SURVEY_UNAVAILABLE)
	End If

	intInviteID = Request.QueryString("invid")
	If utility_isPositiveInteger(intInviteID) Then
		If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
			Response.Cookies(SV_COOKIE_NAME & "surveyID" & intSurveyID & "inviteID") = intInviteID
		ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then
			Session("surveyID" & intSurveyID & "inviteID") = intInviteID
		End If
	End If

	strSQL = "SELECT surveyTitle, surveyDescription, allowContinue, showProgress, logNTUser, numberLabels, templateID " &_
			 "FROM usd_Survey " &_
			 "WHERE surveyID = " & intSurveyID
	Set rsResults = utility_getRecordset(strSQL)

	strSurveyTitle = rsResults("surveyTitle")
	strSurveyDescription = rsResults("surveyDescription")
	boolAllowContinue = cbool(rsResults("allowContinue"))
	boolShowProgress = cbool(rsResults("showProgress"))
	boolLogNTUser = cbool(rsResults("logNTUser"))
	boolNumberLabels = cbool(rsResults("numberLabels"))
	intTemplateID = rsResults("templateID")

	rsResults.Close

	strSQL = "SELECT templateName, header, footer, baseFont, backgroundColor, titleSize, titleColor, " &_
			 "surveyDescriptionSize, surveyDescriptionColor, questionSize, questionColor, " &_
			 "questionDescriptionSize, questionDescriptionColor, answerSize, answerColor, " &_
			 "useStandardUI, oddRowColor, evenRowColor, headerColor " &_
			 "FROM usd_styleTemplates " &_
			 "WHERE templateID = " & intTemplateID

	rsResults.Open strSQL, DB_CONNECTION

	strHeader = rsResults("header")
	strFooter = rsResults("footer")
	strBaseFont = rsResults("baseFont")
	strBackgroundColor = rsResults("backgroundColor")
	intTitleSize = rsResults("titleSize")
	strTitleColor = rsResults("titleColor")
	intSurveyDescriptionSize = rsResults("surveyDescriptionSize")
	strSurveyDescriptionColor = rsResults("surveyDescriptionColor")
	intQuestionSize = rsResults("questionSize")
	strQuestionColor = rsResults("questionColor")
	intQuestionDescriptionSize = rsResults("questionDescriptionSize")
	strQuestionDescriptionColor = rsResults("questionDescriptionColor")
	intAnswerSize = rsResults("answerSize")
	strAnswerColor = rsResults("answerColor")
	boolUseStandardUI = cbool(rsResults("useStandardUI"))
	strOddRowColor = rsResults("oddRowColor")
	strEvenRowColor = rsResults("evenRowColor")
	strHeaderColor = rsResults("headerColor")

	Set rsResults = NOTHING
	If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
		strGUID = Request.Cookies(SV_COOKIE_NAME & "survey" & intSurveyID)("userID" & intUserID & "responseGUID")
	ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then
		strGUID = Session("survey" & intSurveyID & "responseGUID")
	End If

	intResponseID = response_getResponseInProgressID(strGUID, intUserID, intSurveyID)

	If not utility_isPositiveInteger(intResponseID) Then
		Call response_startResponse(intSurveyID, intUserID, intResponseID, strGUID, boolLogNTUser, boolAdminEditing, intEditResponseID)

		If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
			Response.Cookies(SV_COOKIE_NAME & "survey" & intSurveyID)("userID" & intUserID & "responseGUID") = strGUID
			Response.Cookies(SV_COOKIE_NAME & "survey" & intSurveyID).Expires = dateAdd("yyyy",1,date())
		ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then
			Session("survey" & intSurveyID & "responseGUID") = strGUID
		End If
	End If

	If not utility_isPositiveInteger(intPageNumber) Then
		Dim intItemID
		Dim intItemType
		Dim strVariableName
		Dim strResponse
		If boolAllowContinue = True Then
			If response_responseStarted(intResponseID) Then
				Dim strQueryString
				strQueryString = survey_getQuerystring(intSurveyID)
				Response.Redirect("continueSurvey.asp?surveyID=" & intSurveyID & strQueryString)
			End If
		End If
		If utility_isPositiveInteger(intEditResponseID) Then
			Call response_copyHiddenFields(intEditResponseID, intResponseID)
		Else
				strSQL = "SELECT itemID,itemType, variableName FROM usd_surveyItem WHERE surveyID = " & intSurveyID &_
						" AND pageID = 0"
				Set rsResults = utility_getRecordset(strSQL)
				If not rsResults.EOF Then
					Do until rsResults.EOF
						intItemID = rsResults("itemID")
						intItemType = rsResults("itemType")
						strVariableName = rsResults("variableName")
						Select Case intItemType
							Case SV_HIDDEN_FIELD_TYPE_QUERYSTRING
								strResponse = Request.QueryString(strVariableName)
							Case SV_HIDDEN_FIELD_TYPE_COOKIE
								strResponse = Request.Cookies(strVariableName)
							Case SV_HIDDEN_FIELD_TYPE_SESSION
								strResponse = session(strVariableName)
						End Select
						strSQL = "DELETE FROM usd_responseDetails WHERE responseID = " & intResponseID & " AND itemID = " & intItemID
						Call utility_executeCommand(strSQL)
						Call response_addResponse(intResponseID, intItemID, strResponse, True, False, 0, 0, 0, 0)
						rsResults.MoveNext
					Loop
					intNextPageID = response_getNextPage(0, intResponseID)
					If intNextPageID > 1 Then
						Response.Redirect("takeSurvey.asp?surveyID=" & intSurveyID & "&pageNumber=" & intNextPageID)
					End If
				End If
				rsResults.Close
				Set rsResults = NOTHING
		End If
		intPageNumber = 1
	End If

	If response_checkConditions("", intPageNumber, intSurveyID, intResponseID) = False Then
		If intPageNumber = survey_getLastPageID(intSurveyID) Then
			Response.Redirect("surveyComplete.asp?surveyID=" & intSurveyID)
		Else
			Response.Redirect("takeSurvey.asp?surveyID=" & intSurveyID &_
								 "&pageNumber=" & (intPageNumber + 1))
		End If
	End If
%>
<%=header_htmlTop(strBackgroundColor, "")%>
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

<%
	If boolShowProgress = True Then
		intLastPageNumber =  survey_getLastPageID(intSurveyID)
%>
		<br /><span class="normalBold">
			Page <%=intPageNumber%> of <%=intLastPageNumber%>
		</span>
<% End If %>

<% If intSurveyID = 1 Then %>
<script language="javascript">
	if (navigator.appVersion.indexOf('MSIE 5.5')!=-1) {
		document.write("<BR><BR><B><I>The browser that you are using, Internet Explorer 5.5, contains some bugs which could impede the performance of this survey application. It is recommended that you upgrade to a newer version. You can do this by clicking <a href='http://www.microsoft.com/downloads/details.aspx?FamilyID=1e1550cb-5e5d-48f5-b02b-20b602228de6&displaylang=en' target='_blank'>here</a>. Or, you can click on TOOLS and WINDOWS UPDATE from your IE menu.</I></B>");
	}
</script>
<% End If%>

	</p>
	<font face="<%=strBaseFont%>" size="<%=intSurveyDescriptionSize%>" color="<%=strSurveyDescriptionColor%>">
		<%=strSurveyDescription%></font>
	<%
		Call response_outputItems(intSurveyID, intPageNumber, intResponseID,  _
						intLastQuestionNumber, boolNumberLabels, intQuestionSize, strQuestionColor, _
						intQuestionDescriptionSize, strQuestionDescriptionColor, intAnswerSize, strAnswerColor, _
						strBaseFont, boolEditing, intEditResponseID, strOddRowColor, strEvenRowColor, strHeaderColor)

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

