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
' Name:		surveySearch.asp 
' Purpose:	page to view results of a survey
'
'
' Author:	    Ultimate Software Designs
' Date Written:	02/03/2003
' Modified:		
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
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
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
	
	strSQL = "SELECT surveyTitle, surveyDescription, numberResponses, isScored " &_
			 "FROM usd_survey " &_
			 "WHERE surveyID = " & intSurveyID
	
	rsResults.Open strSQL, DB_CONNECTION 
	strSurveyTitle = rsResults("surveyTitle")
	strSurveyDescription = rsResults("surveyDescription")
	intNumberResponses = rsResults("numberResponses")
	boolScored = cbool(rsResults("isScored"))
	rsResults.Close

	If not utility_isPositiveInteger(intLowScore) Then
		intLowScore = 0
	End If

	If not utility_isPositiveInteger(intHighScore) Then
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
		strSQL = "SELECT count(distinct(responseID)) as numberResponses " &_
				 "FROM usd_responseDetails RD " &_
				 reports_getItemSQL(intSurveyID, intDrilldownItemID, intConditionType, strResponse)
		rsResults.Open strSQL, DB_CONNECTION
		If not rsResults.EOF Then
			intNumberResponses = rsResults("numberResponses")
		End If
		rsResults.Close
	End If
	
	Call survey_updateResponseCount(intSurveyID)
	
	strAliasURL = "viewResults.asp?surveyID=" & intSurveyID & "&startPage=" & intStartPage & "&endPage=" & intEndPage &_
				  "&drilldownItemID=" & intDrillDownItemID & "&conditionType=" & intConditionType &_
				  "&response=" & strResponse & "&category=" & strCategory &_
				  "&highScore=" & intHighScore & "&lowScore=" & intLowScore & "&searchScore=" & boolPointSearch

	strResponsesURL = "viewResponses.asp?surveyID=" & intSurveyID &_
				  "&itemID=" & intDrillDownItemID & "&conditionType=" & intConditionType &_
				  "&response=" & strResponse & "&category=" & strCategory & "&answerID=" & intAnswerID &_
				  "&highScore=" & intHighScore & "&lowScore=" & intLowScore & "&searchScore=" & boolPointSearch

%> 
	<%=header_htmlTop("white","onload=""javascript:updateAnswers(" & intDrilldownItemID & ");frmSearch.answerID.value=" & intAnswerID & """")%>
	<%=header_writeHeader(intUserType, SV_PAGE_TYPE_REPORTS)%>
	
	<span class="breadcrumb" align="left">
		<a href="searchReports.asp">Search Results</a> >>
		<%=strSurveyTitle%>
	</span>
	<br /><br />
	<span class="surveyTitle">
		<%=strSurveyTitle%> - Search
	</span>
<%
	If len(strMessage) > 0 Then
%>
		<br /><span class="message"><%=strMessage%></span>
<%
	End If
%>

	<hr noshade color="#C0C0C0">
<%
		If intReportingPermission = SV_REPORT_PERMISSION_FULL Then
			If boolScored = True Then
%>
				
					<form method="get" action="viewResults.asp" name="frmPoints">
					<table width="50%" cellspacing="0" cellpadding="0" border="0">
					<tr valign="bottom">
						<td width="150" class="normalBold-Big" valign="bottom" colspan="2">Search By Score:</td>
					</tr>
					<tr valign="bottom">
						<td class="normal" valign="bottom" colspan="2">
							Use this to search based on the user's score.  You must specify a value in both fields.
						</td>
					</tr>
					<tr>
						<td valign="bottom">
							<span class="normal">From: <input type="text" name="lowScore" size="4" value="0" value="<%=intLowScore%>"></input>
							To: <input type="text" name="highScore" size="4" value="<%=intHighScore%>"></input>
							<input type="hidden" name="surveyID" value="<%=intSurveyID%>">
							<input type="hidden" name="submit" value="Search">
							<input type="image" src="images/button-graphResults.gif" alt="Graph Results" border="0" 
							onclick="javascript:frmPoints.action='viewResults.asp';" id=image1 name=image1>
							<input type="image" src="images/button-viewResponses.gif" alt="View Responses" border="0" 
							onclick="javascript:frmPoints.action='viewResponses.asp';" id=image2 name=image2>
							<input type="hidden" name="searchScore" value="True">
						</td>
					</tr>
					</table></form>
					<hr noshade color="#C0C0C0" size="2">
<%
			End If


%>
			
			<form method="get" action="xxxx" name="frmSearch">
			<table width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td class="normalBold-Big" width="150" valign="bottom"><br />Search By Value:</td>
			</tr>
			<tr valign="bottom">
						<td class="normal" valign="bottom" colspan="2">
							Use this to search based on the user's response to a question.
						</td>
					</tr>
			<tr>
				<td>

					<%=common_helpLink("reports/searchByQuestion.asp",SV_SMALL_HELP_IMAGE)%>
					<%=survey_questionsDropdown(intSurveyID,"","","frmSearch","drilldownItemID", False, intDrilldownItemID)%>
					<%=reports_searchConditionsDropdown(intConditionType)%>
					<select name="answerID"></select>
					<input type="text" name="response" size="20"
<%
				If not utility_isPositiveInteger(intAnswerID) Then
%>				
					value="<%=strResponse%>"
<%
				End If
%>				 
				 >
				<script language="javascript">
					<%=survey_answersDropdownJS(intSurveyID, "frmSearch", "answerID")%>
				</script>
					<input type="hidden" name="surveyID" value="<%=intSurveyID%>">
					<input type="hidden" name="submit" value="Search">
					<input type="image" src="images/button-graphResults.gif" alt="Graph Results" border="0" 
					onclick="javascript:frmSearch.action='viewResults.asp';">
					<input type="image" src="images/button-viewResponses.gif" alt="View Responses" border="0" 
					onclick="javascript:frmSearch.action='viewResponses.asp';">
				</td></tr></table></form>
<%
		
	End If
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

