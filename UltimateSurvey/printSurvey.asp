<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
'Response.CacheControl = "no-cache"
'Response.AddHeader "Pragma", "no-cache"
'Response.Expires = -1
'****************************************************
'
' Name:		printSurvey.asp 
' Purpose:	page to print a survey
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
	Dim intLastPage
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = cint(Request.QueryString("surveyID"))
	
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
	
	rsResults.Close
	
	strSQL = "SELECT top 1 pageID FROM usd_surveyItem WHERE surveyID = " & intSurveyID &_
			 " ORDER BY pageID DESC"
	
	rsResults.Open strSQL, DB_CONNECTION
	
	If not rsResults.EOF Then
		intLastPage = rsResults("pageID")
	End If 
	
	rsResults.Close
	Set rsResults = NOTHING

		
%>
<%=header_htmlTop(strBackgroundColor, "onload=javascript:window.print();window.close();")%>
<%

	If not isNull(strHeader) Then
%>
		<%=strHeader%>
<%
	End If

If not boolUseStandardUI = True Then
	Call header_padding()
End If
%>
	<p>
		<font face="<%=strBaseFont%>" size="<%=intTitleSize%>" color="<%=strTitleColor%>">
		<%=strSurveyTitle%></font>
	
	</p>
	<font face="<%=strBaseFont%>" size="<%=intSurveyDescriptionSize%>" color="<%=strSurveyDescriptionColor%>">
		<%=strSurveyDescription%></font>
<%
		
	For intPageNumber = 1 to intLastPage

	If boolShowProgress = True Then
		intLastPageNumber =  survey_getLastPageID(intSurveyID)
%>
		<br /><span class="normalBold">
			Page <%=intPageNumber%> of <%=intLastPageNumber%>
		</span>
<%
	End If
			Call response_outputItemsToPrint(intSurveyID, intPageNumber, intResponseID, boolItemsShown, _
					intLastQuestionNumber, boolNumberLabels, intQuestionSize, strQuestionColor, _
					intQuestionDescriptionSize, strQuestionDescriptionColor, intAnswerSize, strAnswerColor, _
					strBaseFont, boolEditing, intEditResponseID, strOddRowColor, strEvenRowColor, strHeaderColor)
		
			%><p STYLE="page-break-before: always"></p><%
		Next

		Call header_bottomPadding()

	If len(strFooter) > 0 Then
%>
		<%=strFooter%>
<%
	End If
%>

