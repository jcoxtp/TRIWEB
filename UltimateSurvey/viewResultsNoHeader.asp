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
' Name:		viewResultsNoHeader.asp 
' Purpose:	page to view results of a survey, with no header and menus
'
'
' Changes:
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/reports_inc.asp"-->
<!--#INCLUDE FILE="Include/response_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<%
	Dim intUserType
	Dim intUserID
	Dim intSurveyID
	Dim boolShowFreeText
	Dim boolDrilldown
	Dim intPrivacyLevel
	Dim intOwnerID
	Dim intMessage
	Dim strMessage
	Dim intReportingPermission
	Dim strSQL
	Dim rsResults
	Dim intCounter
	Dim intPageNumber
	Dim intMaxPageNumber
	Dim strSurveyTitle
	Dim strSurveyDescription
	Dim intNumberResponses
	Dim intEditGraphTypeID
	Dim intGraphType
	Dim boolChange
	Dim intStartPage
	Dim intEndPage
	Dim strPages
	Dim intItemID
	Dim intConditionType
	Dim intAnswerID
	Dim strResponse
	Dim strCategory
	Dim intDrilldownItemID
	Dim boolAliases
	Dim strAliasURL
	Dim strResponsesURL
	Dim intHighScore
	Dim intLowScore
	Dim boolPointSearch
	Dim boolScored
	Dim boolFlash
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
	Dim intCategoryID

	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",False)
	
	
	
	intSurveyID = Request.QueryString("surveyID")
	
	intConditionType = Request.QueryString("conditionType")
	intAnswerID = Request.QueryString("answerID")
	strResponse = Request.QueryString("response")
	strCategory = Request.QueryString("category")
	intDrillDownItemID = Request.QueryString("drilldownItemID")
	boolAliases = cbool(Request.QueryString("aliases"))
	intHighScore = Request.QueryString("highScore")
	intLowScore = Request.QueryString("lowScore")
	boolPointSearch = cbool(Request.QueryString("searchScore"))	
	
	If Request.QueryString("flash") = "" Then
		If SV_DEFAULT_REPORT_TYPE = SV_REPORT_TYPE_GRAPHS Then
			boolFlash = True
		Else
			boolFlash = False
		End If
	ElseIf Request.QueryString("flash") = "True" Then
		boolFlash = True
	Else
		boolFlash = False
	End If
		
		
	If not utility_isPositiveInteger(intConditionType) Then
		intConditionType = SV_CONDITION_EQUALS_ID
	End If

	If utility_isPositiveInteger(intAnswerID) Then
		strResponse = response_getAnswerText(intAnswerID)
	Else
		intAnswerID = 0
	End If
	
	If not utility_isPositiveInteger(intDrilldownItemID) Then
		intDrilldownItemID = 0
	End If
	
	Call survey_updateResponseCount(intSurveyID)
	
	intEditGraphTypeID = Request.QueryString("editGraphType")
	If utility_isPositiveInteger(intEditGraphTypeID) Then
		intGraphType = Request.QueryString("graphType")
		strSQL = "UPDATE usd_surveyItem " &_
				 "SET graphType = " & intGraphType &_
				 " WHERE itemID = " & intEditGraphTypeID
	
		Call utility_executeCommand(strSQL)
	End If
	
	If ((survey_getOwnerID(intSurveyID) = intUserID) and intUserType = SV_USER_TYPE_CREATOR) _
		or intUserType = SV_USER_TYPE_ADMINISTRATOR Then
			boolChange = True 
	Else
			boolChange = False
	End If
	
	If Request.QueryString("pageNumber") = "" Then
		intPageNumber = -1
	Else
		intPageNumber = cint(Request.QueryString("pageNumber"))
	End If

	strSQL = "SELECT max(pageID) as maxID FROM usd_surveyItem WHERE surveyID = " & intSurveyID
	Set rsResults = utility_getRecordset(strSQL)
	If rsResults.EOF Then
		intMaxPageNumber = 0
	Else
		intMaxPageNumber = rsResults("maxID")
	End If	
	rsResults.Close
	
	strPages = Request.QueryString("pages")

	intStartPage = Request.QueryString("startPage")
	intEndPage = Request.QueryString("endPage")
	
	If not utility_isPositiveInteger(intStartPage) Then
		intStartPage = 1
	End If
	
	If not utility_isPositiveInteger(intEndPage) Then
		intEndPage = 1
	End If

	
	
	intReportingPermission = reports_getReportingLevel(intUserID, intUserType, intSurveyID)
	
	Select Case intReportingPermission 
		Case SV_REPORT_PERMISSION_DENIED
			Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
		Case SV_REPORT_PERMISSION_FULL
			boolDrilldown = True
		Case SV_REPORT_PERMISSION_SUMMARY
			boolDrilldown = False
	End Select
	
	intMessage = cint(Request.QueryString("message"))
	
	Select Case intMessage
		Case SV_MESSAGE_RESPONSE_DELETED
			strMessage = "Response successfully deleted."
	End Select	
	
	strSQL = "SELECT surveyTitle, surveyDescription, numberResponses, isScored, templateID " &_
			 "FROM usd_survey " &_
			 "WHERE surveyID = " & intSurveyID
	
	rsResults.Open strSQL, DB_CONNECTION 
	strSurveyTitle = rsResults("surveyTitle")
	strSurveyDescription = rsResults("surveyDescription")
	intNumberResponses = rsResults("numberResponses")
	boolScored = cbool(rsResults("isScored"))
	intTemplateID = rsResults("templateID")
	rsResults.Close

	If not isNumeric(intLowScore) Then
		intLowScore = 0
	End If

	If not isNumeric(intHighScore) Then
		intHighScore = 0
	End If
	
	If boolPointSearch = True Then
		strSQL = "SELECT count(responseID) as numberResponses " &_
				 "FROM usd_response " &_
				 "WHERE points >= " & intLowScore &_
				 " AND points <= " & intHighScore &_
				 " AND surveyID = " & intSurveyID &_
				 " AND completed = 1"
		rsResults.Open strSQL, DB_CONNECTION
		If not rsResults.EOF Then
			intNumberResponses = rsResults("numberResponses")
		End If
		rsResults.Close
	ElseIf utility_isPositiveInteger(intDrillDownItemID) and len(strResponse) > 0 Then

			strSQL = "SELECT distinct(responseID) as numberResponses " &_
					 "FROM usd_responseDetails RD " &_
					 reports_getItemSQL(intSurveyID, intDrilldownItemID, intConditionType, strResponse)
			rsResults.CursorLocation = adUseClient
			rsResults.Open strSQL, DB_CONNECTION
			If not rsResults.EOF Then
				intNumberResponses = rsResults.RecordCount
			End If
			rsResults.Close
		
	End If
	
	strAliasURL = "viewResults.asp?surveyID=" & intSurveyID & "&startPage=" & intStartPage & "&endPage=" & intEndPage &_
				  "&drilldownItemID=" & intDrillDownItemID & "&conditionType=" & intConditionType &_
				  "&response=" & strResponse & "&category=" & strCategory &_
				  "&highScore=" & intHighScore & "&lowScore=" & intLowScore & "&searchScore=" & boolPointSearch

	strResponsesURL = "viewResponses.asp?surveyID=" & intSurveyID &_
				  "&drilldownItemID=" & intDrillDownItemID & "&conditionType=" & intConditionType &_
				  "&response=" & strResponse & "&category=" & strCategory & "&answerID=" & intAnswerID &_
				  "&highScore=" & intHighScore & "&lowScore=" & intLowScore & "&searchScore=" & boolPointSearch
				  
	strSQL = "SELECT header, footer, baseFont, backgroundColor, titleSize, titleColor, " &_
			 "surveyDescriptionSize, surveyDescriptionColor, useStandardUI " &_
			 "FROM usd_styleTemplates " &_
			 "WHERE templateID = " & intTemplateID 
	
	rsResults.Open strSQL
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
	
%> 
	<%=header_htmlTop("white","")%>
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

	If intMaxPageNumber = 1 Then
		intPageNumber = 1 
	End If

	If not utility_isPositiveInteger(intMaxPageNumber) Then
%>
		<span class="message">There are no questions to view reports for</span>
<%
	Else
		Call reports_displayResults(intSurveyID, intStartPage, intMaxPageNumber, boolShowFreeText, boolDrilldown, _
				boolChange, intDrillDownItemID, intConditionType, strResponse, strCategory, boolAliases, intLowScore, _
				intHighScore, False, True,0)
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

