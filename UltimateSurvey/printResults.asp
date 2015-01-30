<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		printResults.asp 
' Purpose:	page to print results of a survey
'
'
' Author:	    Ultimate Software Designs
' Date Written:	10/07/2002
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
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
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
	Dim intStartPage
	Dim intEndPage
	Dim intMaxPageNumber
	Dim strSurveyTitle
	Dim strSurveyDescription
	Dim intNumberResponses
	Dim boolChange
	Dim intConditionType
	Dim intAnswerID
	Dim strResponse
	Dim strCategory
	Dim intDrilldownItemID
	Dim boolAliases
	Dim intLowScore
	Dim intHighScore
	Dim boolPointSearch
	Dim boolFlash
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",False)
	
	intSurveyID = Request.QueryString("surveyID")
	
	intConditionType = Request.QueryString("conditionType")
	intAnswerID = Request.QueryString("answerID")
	strResponse = Request.QueryString("response")
	strCategory = Request.QueryString("category")
	intDrillDownItemID = Request.QueryString("drilldownItemID")
	intLowScore = Request.QueryString("lowScore")
	intHighScore = Request.QueryString("highScore")
	boolPointSearch = cbool(Request.QueryString("searchScore"))	
	
	If Request.QueryString("aliases") = "True" Then
		boolAliases = True
	Else
		boolAliases = False
	End If
	
	If not utility_isPositiveInteger(intConditionType) Then
		intConditionType = SV_CONDITION_EQUALS_ID
	End If

	If utility_isPositiveInteger(intAnswerID) Then
		strResponse = response_getAnswerText(intAnswerID)
	End If
	
	If Request.QueryString("flash") = "True" Then
		boolFlash = True
	Else
		boolFlash = False
	End If
	
	intStartPage = Request.QueryString("startPage")
	intEndPage = Request.QueryString("endPage")
	
	
	
	intReportingPermission = reports_getReportingLevel(intUserID, intUserType, intSurveyID)
	
	Select Case intReportingPermission 
		Case SV_REPORT_PERMISSION_DENIED
			Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End Select

	boolDrilldown = False	
		
	boolChange = False

	strSQL = "SELECT surveyTitle, surveyDescription, numberResponses " &_
			 "FROM usd_survey " &_
			 "WHERE surveyID = " & intSurveyID
	
	Set rsResults = utility_getRecordset(strSQL) 
	strSurveyTitle = rsResults("surveyTitle")
	strSurveyDescription = rsResults("surveyDescription")
	intNumberResponses = rsResults("numberResponses")
	rsResults.Close
	
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
		strSQL = "SELECT count(distinct(RD.responseID)) as numberResponses " &_
				 "FROM usd_responseDetails RD " &_
				 "INNER JOIN usd_response R " &_
				 "ON RD.responseID = R.responseID " &_
				 reports_getItemSQL(intSurveyID, intDrilldownItemID, intConditionType, strResponse) &_
				 "AND R.completed = 1"
		rsResults.Open strSQL, DB_CONNECTION
		If not rsResults.EOF Then
			intNumberResponses = rsResults("numberResponses")
		End If
		rsResults.Close
	End If
%> 
	<%=header_htmlTop("white","")%>
	<table width="100%" cellpadding="5" cellspacing="0">
		<tr>
			<td>
				
				<p class="normalBold-Large">
					<%=strSurveyTitle%>
				</p>
				<p class="normal">
					<span class="normalBold">Description: </span><%=strSurveyDescription%>
				</p>
				<p class="normal">
					<span class="normalBold">Total Responses: </span><%=intNumberResponses%>
				</p>
				<p class="normal">
					<span class="normalBold">Report Time: </span><%=now()%>
				</p>
				<p class="normal">
					<span class="normalBold">Report For: </span>
						Pages <%=intStartPage%> to <%=intEndPage%>
				</p>
<%
		If boolPointSearch = True Then
%>	
			<span class="normalBold">You searched for: </span>
			<span class="normal">Score Between <%=intLowScore%> AND <%=intHighScore%><br /><br />
<%

		End If
		
		If utility_isPositiveInteger(intDrilldownItemID) and len(strResponse) > 0 Then
			If intConditionType <> SV_CONDITION_DID_NOT_ANSWER _
				and intConditionType <> SV_CONDITION_ANSWERED Then
%>
				<span class="normalBold">You searched for: </span>
				<span class="normal"><%=survey_getItemText(intDrilldownItemID)%>&nbsp;
				<%=survey_getConditionTypeText(intConditionType)%>&nbsp;<%=strResponse%></span><br /><br />
				
<%	
			Else
%>
				<span class="normalBold">You searched for: </span>
				<span class="normal">User&nbsp;<%=strConditionText%>&nbsp;"<%=strItemText%>"	
				</span><br /><br />
				
<%
			End If
		End If

			Call reports_displayResults(intSurveyID, intStartPage, intEndPage, boolShowFreeText, boolDrilldown, boolChange, _
					intDrillDownItemID, intConditionType, strResponse, strCategory, boolAliases, _
					intLowScore, intHighScore, boolPointSearch, boolFlash)
%>
			</td>
		</tr>
	</table>


