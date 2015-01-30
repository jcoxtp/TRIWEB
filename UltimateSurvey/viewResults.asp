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
' Name:		viewResults.asp 
' Purpose:	page to view results of a survey
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
	Dim intCategoryID
	Dim intDrilldownItemID
	Dim boolAliases
	Dim strAliasURL
	Dim strResponsesURL
	Dim intHighScore
	Dim intLowScore
	Dim boolPointSearch
	Dim boolScored
	Dim boolFlash
	Dim boolPrint

	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",False)
	
	intSurveyID = Request.QueryString("surveyID")
	
	intConditionType = Request.QueryString("conditionType")
	intAnswerID = Request.QueryString("answerID")
	strResponse = Request.QueryString("response")
	intCategoryID = Request.QueryString("category")
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
	Else
		intConditionType = cint(intConditionType)
	End If

	If utility_isPositiveInteger(intAnswerID) Then
		strResponse = response_getAnswerText(intAnswerID,"")
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
		intStartPage = 0
	End If
	
	If not utility_isPositiveInteger(intEndPage) Then
		intEndPage = 1
	End If

	If Request.QueryString("print") = "true" Then
		boolPrint = True
		boolChange = False
	Else
		boolPrint = False
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
	ElseIf utility_isPositiveInteger(intDrillDownItemID) and (len(strResponse) > 0 or intConditionType = SV_CONDITION_DID_NOT_ANSWER or intConditionType = SV_CONDITION_ANSWERED) Then

			strSQL = "SELECT distinct(responseID) as numberResponses " &_
					 "FROM usd_responseDetails RD WHERE " &_
					 reports_getItemSQL(intSurveyID, intDrilldownItemID, intConditionType, strResponse, intAnswerID)
			rsResults.CursorLocation = adUseClient

				
			rsResults.Open strSQL, DB_CONNECTION
			If not rsResults.EOF Then
				intNumberResponses = rsResults.RecordCount
			End If
			rsResults.Close
		
	End If
	
	strAliasURL = "viewResults.asp?surveyID=" & intSurveyID & "&startPage=" & intStartPage & "&endPage=" & intEndPage &_
				  "&drilldownItemID=" & intDrillDownItemID & "&conditionType=" & intConditionType &_
				  "&response=" & strResponse & "&category=" & intCategoryID &_
				  "&highScore=" & intHighScore & "&lowScore=" & intLowScore & "&searchScore=" & boolPointSearch

	strResponsesURL = "viewResponses.asp?surveyID=" & intSurveyID &_
				  "&drilldownItemID=" & intDrillDownItemID & "&conditionType=" & intConditionType &_
				  "&response=" & strResponse & "&category=" & intCategoryID & "&answerID=" & intAnswerID &_
				  "&highScore=" & intHighScore & "&lowScore=" & intLowScore & "&searchScore=" & boolPointSearch
%> 
	<%=header_htmlTop("white","")%>
<%
	If boolPrint = False Then
%>
		<%=header_writeHeader(intUserType, SV_PAGE_TYPE_REPORTS)%>
		<span class="breadcrumb" align="left">
		<a href="chooseReport.asp">Reports</a> >>
		<%=strSurveyTitle%></span>
	</span>
<%
	Else
%>
		<%=header_padding%>
<%
	End If
%>	
	
	<br /><br />	
	<span class="surveyTitle"><%=strSurveyTitle%> - Summary Results</span>
<%
	If len(strMessage) > 0 and boolPrint = False Then
%>	
		<br /><span class="message"><%=strMessage%></span>
<%
	End If
%>	
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td bgcolor="#EFEFEF">

<%	
	If boolPointSearch = True Then
%>
		<span class="normalBold">You searched for: </span>
				<span class="normal">Score Between <%=intLowScore%> AND <%=intHighScore%><br />
<%

	End If
	
	
	If utility_isPositiveInteger(intDrilldownItemID) Then
		If intConditionType <> SV_CONDITION_DID_NOT_ANSWER _
			and intConditionType <> SV_CONDITION_ANSWERED Then
%>
				<span class="normalBold">You searched for: </span>
				<span class="normal"><%=survey_getItemText(intDrilldownItemID)%>&nbsp;
				<%=survey_getConditionTypeText(intConditionType)%>&nbsp;<%=strResponse%></span><br />
				
<%	
			Else
				
%>
				<span class="normalBold">You searched for: </span>
				<span class="normal">User&nbsp;<%=survey_getConditionTypeText(intConditionType)%>&nbsp;"<%=survey_getItemText(intDrilldownItemID)%>"	
				</span><br />
				
<%
			End If
		End If
%>
				<span class="normalBold">Number of Responses:</span>
				<span class="normal"><%=intNumberResponses%></span><br />
				<span class="normalBold">Report Time:</span>
				<span class="normal"><%=now()%></span><br />
			</td>
			<td bgcolor="#EFEFEF" align="right">
<%
	If boolPrint = False Then
%>	
				<span class="normal">
					<form method="get" action="viewResults.asp" id=form1 name=form1>
						Pages
						<input type="hidden" name="surveyID" value="<%=intSurveyID%>">
						<input type="hidden" name="drilldownItemID" value="<%=intDrilldownItemID%>">
						<input type="hidden" name="conditionType" value="<%=intConditionType%>">
						<input type="hidden" name="response" value="<%=strResponse%>">
						<input type="hidden" name="category" value="<%=intCategoryID%>">
						<input type="hidden" name="answerID" value="<%=intAnswerID%>">
						<input type="hidden" name="highScore" value="<%=intHighScore%>">
						<input type="hidden" name="lowScore" value="<%=intLowScore%>">
						<input type="hidden" name="searchScore" value="<%=boolPointSearch%>">
						<input type="hidden" name="flash" value="<%=boolFlash%>">
						<input type="text" size="4" value="<%=intStartPage%>" name="startPage">
						to:
						<input type="text" size="4" value="<%=intEndPage%>" name="endPage"> of <%=intMaxPageNumber%>
						<input type="image" src="images/button-change.gif" alt="Change" border="0" id=image1 name=image1>
					</form>
<%
	Else
%>
		&nbsp;
<%
	End If
%>

				</span>
			</td>
		</tr>
	</table>

<%
	If intMaxPageNumber = 1 Then
		intPageNumber = 1 
	End If

	If not utility_isPositiveInteger(intMaxPageNumber) Then
%>
		<span class="message">There are no questions to view reports for</span>
<%
	ElseIf intNumberResponses = 0 Then
%>
		<span class="message">No Responses</span>
<%
	
	Else
		If boolPrint = False Then
%>		
			<br /><a href="<%=strResponsesURL%>"><img src="images/button-viewResponses.gif" alt="View Responses" border="0"></a>
	<a href="viewResults.asp?print=true&surveyID=<%=intSurveyID%>&flash=<%=cstr(boolFlash)%>&startPage=<%=intStartPage%>&endPage=<%=intEndPage%>&drilldownItemID=<%=intDrillDownItemID%>&conditionType=<%=intConditionType%>&response=<%=strResponse%>&category=<%=intCategoryID%>&aliases=<%=boolAliases%>&lowScore=<%=intLowScore%>&highScore=<%=intHighScore%>&searchScore=<%=boolPointSearch%>">
		<img src="images/button-printableVersion.gif" border="0" alt="Printable Version"></a>
<%
					If boolAliases = True Then
%>
						<a href="<%=strAliasURL%>&aliases=false&flash=<%=cstr(boolFlash)%>"><img src="images/button-viewFullText.gif" alt="View Full Text" border="0"></a>
<%
					Else
%>
						<a href="<%=strAliasURL%>&aliases=true&flash=<%=cstr(boolFlash)%>"><img src="images/button-viewAliases.gif" alt="View Aliases" border="0"></a>
<%
					End If
					
					If boolFlash = False Then
%>
						<a href="<%=strAliasURL%>&aliases=<%=cstr(boolAliases)%>&flash=True"><img src="images/button-graphResults.gif" alt="Graph Results" border="0"></a>						
<%
					Else
%>
						<a href="<%=strAliasURL%>&aliases=<%=cstr(boolAliases)%>&flash=False"><img src="images/button-viewStatistics.gif" alt="View Statistics" border="0"></a>
<%
					End If

		End If

%>
	<hr noshade color="#C0C0C0" size="2">
	
<%

		
		Call reports_displayResults(intSurveyID, intStartPage, intEndPage, boolShowFreeText, boolDrilldown, _
				boolChange, intDrillDownItemID, intConditionType, strResponse, intCategoryID, boolAliases, intLowScore, _
				intHighScore, boolPointSearch, boolFlash, intAnswerID)
	End If
%>
		
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

