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
' Name:		searchResults.asp 
' Purpose:	page to search results of a survey
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
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/reports_inc.asp"-->
<!--#INCLUDE FILE="Include/response_inc.asp"-->
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
	Dim boolActive
	Dim boolShowFreeText
	Dim intItemID
	Dim strResponse
	Dim intConditionType
	Dim intAnswerID
	Dim intCounter 
	Dim strItemResponse
	Dim strItemText
	Dim strConditionText
	Dim intPageNumber
	Dim intPageCount
	Dim intResultCount
	Dim strPagingURL
	Dim intResponse
	Dim intResponseID
	Dim boolShowResponse
	Dim intReportingPermission
	Dim boolIsOwner
	Dim boolDeleteCheckbox
	Dim boolScored
	Dim intHighScore
	Dim intLowScore
	Dim boolQuestionsExist
	Dim boolLogNTUser
	Dim strCategory
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",False)
	
	intSurveyID = cint(Request.QueryString("surveyID"))
	intReportingPermission = reports_getReportingLevel(intUserID, intUserType, intSurveyID)

	
%>
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_REPORTS)%>
<%	
	If survey_getOwnerID(intSurveyID) = intUserID Then
		boolIsOwner = True
	Else
		boolIsOwner = False
	End If
	
	If boolIsOwner = True or intUserType = SV_USER_TYPE_ADMINISTRATOR Then
		For intCounter = 0 To cint(Request.Form("responseCount"))
			If Request.Form("checkbox" & intCounter) = "on" Then
				Call response_deleteResponse(Request.Form("responseID" & intCounter))
			End If	
		Next
	End If
%>
	<span class="surveyTitle">Search Survey Results</span><br />
	<hr noshade color="#C0C0C0" size="2">

	<%=reports_reportSearchForm(intSurveyID, intUserID)%>
	
<%
	If utility_isPositiveInteger(intSurveyID) Then
		strSQL = "SELECT isScored, logNTUser " &_
				 "FROM usd_Survey " &_
				 "WHERE surveyID = " & intSurveyID
		Set rsResults = utility_getRecordset(strSQL)
		If rsResults.EOF Then
%>
			<p class="message">No Survey Found</p>
<%
		Else
			boolScored = cbool(rsResults("isScored"))
			boolLogNTUser = cbool(rsResults("logNTUser"))
		End If

		rsResults.Close
		
		If intReportingPermission = SV_REPORT_PERMISSION_FULL Then
			If boolScored = True Then
%>
				<form method="get" action="searchResults.asp">
					<span class="normalBold">Search By Score: </span>
					<span class="normal">From: <input type="text" name="lowScore" size="4" value="0"></input>
					To: <input type="text" name="highScore" size="4" value="0"></input>
					<input type="hidden" name="surveyID" value="<%=intSurveyID%>">
					<input type="hidden" name="submit" value="Search">
					<input type="image" src="images/button-search.gif" alt="Search" border="0">
				</form>
				<hr noshade color="#C0C0C0" size="2">
<%
			End If
		
			If utility_isPositiveInteger(intSurveyID) Then
%>
			<form method="get" action="searchResults.asp" name="frmSearch">
				<span class="normalBold">
						<%=common_helpLink("reports/searchByQuestion.asp",SV_SMALL_HELP_IMAGE)%>Search By Question:
				</span><%=survey_questionsDropdown(intSurveyID,"","","frmSearch","itemID", boolQuestionsExist,0)%>
<%
			If boolQuestionsExist = False Then
%>
				<span class="message">No questions exist in the select survey/page</span>
<%
			Else
%>
				<%=survey_conditionTypeDropdown(0)%>
				<select name="answerID"></select>
				<input type="text" name="response" size="20">
				<script language="javascript">
					<%=survey_answersDropdownJS(intSurveyID, "frmSearch", "answerID")%>
				</script>
<%
			End If
%>
			<input type="hidden" name="surveyID" value="<%=intSurveyID%>">
			<input type="hidden" name="submit" value="Search">
<%
			If boolQuestionsExist = True Then
%>
				<input type="image" src="images/button-search.gif" alt="Search" border="0" id=image1 name=image1>
<%
			End If
		End If
%>
		</form>

			<hr noshade color="#C0C0C0" size="2">
<%		
			intItemID = Request.QueryString("itemID")
			intConditionType = Request.QueryString("conditionType")
			intAnswerID = Request.QueryString("answerID")
			strResponse = Request.QueryString("response")
			strCategory = Request.QueryString("category")
		
			If not utility_isPositiveInteger(intConditionType) Then
				intConditionType = SV_CONDITION_EQUALS_ID
			End If

			If utility_isPositiveInteger(intItemID) Then
				If utility_isPositiveInteger(intAnswerID) Then
					strResponse = response_getAnswerText(intAnswerID)
				End If
		
				strSQL = "SELECT distinct(RD.responseID) " &_
						 " FROM usd_ResponseDetails RD " &_
						 " INNER JOIN usd_Response R " &_
						 " ON RD.responseID = R.responseID "
				strSQL = strSQL & reports_getItemSQL(intSurveyID, intItemID, intConditionType, strResponse)
				strSQL = strSQL & " AND R.surveyID = " & intSurveyID & " AND R.completed = 1 " 
				If strCategory <> "" Then
					strSQL = strSQL & "AND RD.matrixCategory = " & utility_SQLEncode(strCategory, True)
				End If
				strSQL = strSQL & " ORDER by RD.responseID "
							
				strItemText = survey_getItemText(intItemID)
				strConditionText = survey_getConditionTypeText(intConditionType)
		
				intConditionType = cint(intConditionType)
	
			If intConditionType <> SV_CONDITION_DID_NOT_ANSWER _
				and intConditionType <> SV_CONDITION_ANSWERED Then
%>
				<span class="normalBold">
					<%=strItemText%>
				</span>&nbsp
				<span class="message">	
						<%=strConditionText%>
				</span>&nbsp
				<span class="normalBold">
					<%=strResponse%>
				</span>
<%	
			Else
%>
				<span class="message">
					User&nbsp;<%=strConditionText%>
					
				</span>&nbsp
				<span class="normalBold">
					<%=strItemText%>	
				</span>&nbsp
				
<%
			End If

		Else
			intHighScore = Request.QueryString("highScore")
			If utility_isPositiveInteger(intHighScore) Then
				intLowScore = Request.QueryString("lowScore")
				If not utility_isPositiveInteger(intLowScore) Then
					intLowScore = 0
				End If 
				strSQL = "SELECT responseID " &_
						 "FROM usd_response " &_
						 "WHERE surveyID = " & intSurveyID &_
						 " AND completed = 1 " &_
						 " AND points >= " & intLowScore &_
						 " AND points <= " & intHighScore &_
						 " ORDER BY responseID" 
%>
				<p class="normalBold">Score Between <span class="message"><%=intLowScore%></span> AND
				<span class="message"><%=intHighScore%></span></p>
<%
			Else	
	
				strSQL = "SELECT responseID " &_
					 "FROM usd_response " &_
					 "WHERE surveyID = " & intSurveyID &_
					 " AND completed = 1 " &_
					 "ORDER BY responseID "
			End If
		End If

		intPageNumber = cint(Request.QueryString("pageNumber"))
		If intPageNumber < 1 Then 
			intPageNumber = 1
		End If

		rsResults.PageSize = SV_RESULTS_PER_PAGE
		rsResults.Open utility_ConvertSQL(strSQL), DB_CONNECTION
	
		If rsResults.EOF Then
%>
			<p class="message"> No Results Found</p>
<%
		Else
%>
			<form method="post">
			<table class="normal" width="100%" border="0" cellpadding="3" cellspacing="0">

				<tr class="tableHeader" bgcolor="black" height="25">
					<td width="150">
						Response ID
					</td>
					<td>
						User name
					</td>
<%
					If boolLogNTUser = True Then
%>
						<td>
							Network Username
						</td>
<%
					End If

					If boolScored = True Then
%>
						<td>
							Score
						</td>
<%
					End If
%>
					<td>
						Completed
					</td>
					<td>
						User IP
					</td>
<%
					If boolIsOwner = True or intUserType = SV_USER_TYPE_ADMINISTRATOR Then
						boolDeleteCheckbox = True
%>
						<td>
							Delete?
						</td>
<%
					End If
%>
				</tr>
				
<%
				intCounter = 0
				Do until rsResults.EOF
					intResponseID = rsResults("responseID")
					boolShowResponse = True
					If intConditionType = SV_CONDITION_GREATER_THAN_ID or intConditionType = SV_CONDITION_LESS_THAN_ID Then
						intResponse = response_getResponseByID(intResponseID, intItemID)
						If not (isNumeric(intResponse) and isNumeric(strResponse)) Then
							boolShowResponse = False
						Else
							If intConditionType = SV_CONDITION_GREATER_THAN_ID Then
								If intResponse <= strResponse Then
									boolShowResponse = False
								End If
							ElseIf intConditionType = SV_CONDITION_LESS_THAN_ID Then
								If intResponse >= strResponse Then
									boolShowResponse = False
								End If
							End If
						End If
					End If
				
					If boolShowResponse = True Then	
						intCounter = intCounter + 1
						
						Dim rsResponse
						Dim strUserName
						strSQL = "SELECT userID, NTUser, points, dateCompleted, userIP " &_
							 "FROM usd_Response " &_
							 "WHERE responseID = " & intResponseID &_
							 " AND completed = 1"

						Set rsResponse = utility_getRecordset(strSQL)
						If not rsResponse.EOF Then
							intUserID = rsResponse("userID")
%>
					<%=common_tableRow(intCounter)%>
						<td width="150">
							<a class="normalBold" 
								href="viewResponseDetails.asp?responseID=<%=intResponseID%>&surveyID=<%=intSurveyID%>">
								<%=intResponseID%></a>
						</td>
						<td>
<%
							If utility_isPositiveInteger(intUserID) Then
%>
								<%=user_getUsername(intUserID)%>
<%
							Else
%>
								&nbsp;
<%
							End If
%>
						</td>
<%
						If boolLogNTUser = True Then
%>
							<td>
								<%=rsResponse("NTUser")%>
							</td>
<%
						End If							
						
						If boolScored = True Then
%>
							<td>
								<%=rsResponse("points")%>
							</td>
<%
						End If
%>
						<td>
							<%=rsResponse("dateCompleted")%>
						</td>
						<td>
							<%=rsResponse("userIP")%>
						</td>
<%
					If boolDeleteCheckbox = True Then
%>
						<td>
							<input type="checkbox" name="checkbox<%=intCounter%>">
							<input type="hidden" name="responseID<%=intCounter%>" value="<%=intResponseID%>">
						</td>
<%
					End If
%>
					</tr>
<%
				
				End If
				rsResponse.Close
				Set rsResponse = NOTHING
				End If
				rsResults.MoveNext
			Loop		
%>
			</table>
<%
			If boolIsOwner = True or intUserType = SV_USER_TYPE_ADMINISTRATOR Then
%>
				<hr noshade color="#C0C0C0" size="2">
				<table>
					<tr>
						<td>
							<input type="image" src="images/button-deleteResponses.gif" border="0">
							<input type="hidden" name="delete" value="Delete Selected Responses"
								onclick="javascript:return confirmAction('Are you sure you want to delete all selected responses?');">
							<input type="hidden" name="responseCount" value="<%=intCounter%>">
							<input type="hidden" name="itemID" value="<%=intItemID%>">
							<input type="hidden" name="conditionType" value="<%=intConditionType%>">
							<input type="hidden" name="response" value="<%=strResponse%>">
							<input type="hidden" name="answerID" value="<%=intAnswerID%>">
							<input type="hidden" name="surveyID" value="<%=intSurveyID%>">
						</td>
					</tr>
				</table>
<%
			End If
%>
		
		</form>
<%
	End If
	rsResults.Close
	Set rsResults = NOTHING
		
		
	End If	

	End If
%><!--#INCLUDE FILE="Include/footer_inc.asp"-->