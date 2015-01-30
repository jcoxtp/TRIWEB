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
' Name:		viewResponses.asp 
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
	Dim intResults
	Dim boolPointSearch
	Dim strGraphURL
	Dim boolUserInfoAvailable
	Dim rsResponse
	Dim strUserName
	Dim strOrderBy
	Dim strOrderByDirection
	Dim strSortingURL
	Dim strArray
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",False)
	
	intSurveyID = cint(Request.QueryString("surveyID"))
	intReportingPermission = reports_getReportingLevel(intUserID, intUserType, intSurveyID)
	
	Call survey_updateResponseCount(intSurveyID)
	
	intLowScore = Request.QueryString("lowScore")
	intHighScore = Request.QueryString("highScore")
	boolPointSearch = cbool(Request.QueryString("searchScore"))	
	intItemID = Request.QueryString("drillDownItemID")
	intConditionType = Request.QueryString("conditionType")
	intAnswerID = Request.QueryString("answerID")
	strResponse = Request.QueryString("response")
	strCategory = Request.QueryString("category")
	
	

	If not isNumeric(intLowScore) Then
		intLowScore = 0
	End If 
	If not isNumeric(intHighScore) Then
		intHighScore = 0
	End If 
	
			
	If utility_isPositiveInteger(intAnswerID) Then
		strResponse = response_getAnswerText(intAnswerID,"")
	Else
		intAnswerID = 0
	End If
	
	If not utility_isPositiveInteger(intItemID) Then
		intItemID = 0
	End If
					
	strGraphURL = "viewResults.asp?drilldownItemID=" & intItemID & "&conditionType=" & intConditionType &_
				  "&response=" & server.URLEncode(strResponse) & "&surveyID=" & intSurveyID & "&answerID=" & intAnswerID &_
				  "&lowScore=" & intLowScore & "&highScore=" & intHighscore & "&searchScore=" & boolPointSearch
		
	If not utility_isPositiveInteger(intConditionType) Then
		intConditionType = SV_CONDITION_EQUALS_ID
	End If

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

	If utility_isPositiveInteger(intSurveyID) Then
		strSQL = "SELECT surveyTitle, isScored, logNTUser, userInfoAvailable " &_
				 "FROM usd_Survey " &_
				 "WHERE surveyID = " & intSurveyID
		Set rsResults = utility_getRecordset(strSQL)
		If rsResults.EOF Then
%>
			<p class="message">No Survey Found</p>
<%
		Else
			strSurveyTitle = rsResults("surveyTitle")
			boolScored = cbool(rsResults("isScored"))
			boolLogNTUser = cbool(rsResults("logNTUser"))
			boolUserInfoAvailable = cbool(rsResults("userInfoAvailable"))
		End If

		rsResults.Close
%>
		<span class="breadcrumb" align="left">
		<a href="chooseReport.asp">Reports</a> >>
		<%=strSurveyTitle%>
	</span>
	<br /><br />
	<span class="surveyTitle"><%=strSurveyTitle%> - Responses</span><br />
<%
		If utility_isPositiveInteger(intConditionType) Then
			intConditionType = cint(intConditionType)
		End If
		
		strOrderBy = Request.QueryString("orderBy")
		strOrderByDirection = Request.QueryString("orderByDirection")

		If len(strOrderBy) = 0 Then
			strOrderBy = "dateCompleted"
		End If
	
		If len(strOrderByDirection) = 0 Then
			strOrderByDirection = "asc"
		End If 
		
		If utility_isPositiveInteger(intItemID) and (len(strResponse) > 0 or intConditionType = SV_CONDITION_DID_NOT_ANSWER or intConditionType = SV_CONDITION_ANSWERED) Then
			strSQL = "SELECT distinct(RD.responseID), username,dateCompleted " &_
						 " FROM (usd_ResponseDetails RD " &_
						 " LEFT JOIN usd_Response R " &_
						 " ON RD.responseID = R.responseID) " &_
						 "LEFT JOIN usd_surveyUser U ON R.userID = U.userID " 
						 
				strSQL = strSQL & " WHERE " & reports_getItemSQL(intSurveyID, intItemID, intConditionType, strResponse, intAnswerID)
				strSQL = strSQL & " AND R.surveyID = " & intSurveyID & " AND R.completed = 1 " 
				If strCategory <> "" Then
					strSQL = strSQL & "AND RD.matrixCategory = " & utility_SQLEncode(strCategory, True)
				End If
				strSQL = strSQL & " ORDER BY " & strOrderBy & " " & strOrderByDirection
							
				strItemText = survey_getItemText(intItemID)
				strConditionText = survey_getConditionTypeText(intConditionType)

		Else
			If boolPointSearch = True Then

				strSQL = "SELECT responseID, username " &_
						 "FROM usd_response R " &_
						 "LEFT OUTER JOIN usd_surveyUser U ON R.userID = U.userID " &_
						 "WHERE surveyID = " & intSurveyID &_
						 " AND completed = 1 " &_
						 " AND points >= " & intLowScore &_
						 " AND points <= " & intHighScore &_
						 " ORDER BY " & strOrderBy & " " & strOrderByDirection

			Else	
				strSQL = "SELECT responseID, username " &_
					 "FROM usd_response R " &_
					 "LEFT OUTER JOIN usd_surveyUser U ON R.userID = U.userID " &_
					 "WHERE surveyID = " & intSurveyID &_
					 " AND completed = 1 " &_
					 " ORDER BY " & strOrderBy & " " & strOrderByDirection
			End If
		End If
		
		
		intPageNumber = cint(Request.QueryString("pageNumber"))
		If intPageNumber < 1 Then 
			intPageNumber = 1
		End If


		Set rsResults = Server.CreateObject("ADODB.Recordset")
		'set up record set for paging
		rsResults.CursorLocation = adUseClient
		rsResults.PageSize = SV_RESULTS_PER_PAGE
		rsResults.Open utility_ConvertSQL(strSQL), DB_CONNECTION
		intPageCount = rsResults.PageCount
		intResultCount = rsResults.RecordCount
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
	
	If utility_isPositiveInteger(intItemID) and (len(strResponse) > 0 or intConditionType = SV_CONDITION_DID_NOT_ANSWER or intConditionType = SV_CONDITION_ANSWERED) Then
		If intConditionType <> SV_CONDITION_DID_NOT_ANSWER _
			and intConditionType <> SV_CONDITION_ANSWERED Then
%>
				<span class="normalBold">You searched for: </span>
				<span class="normal"><%=survey_getItemText(intItemID)%>&nbsp;
				<%=survey_getConditionTypeText(intConditionType)%>&nbsp;<%=strResponse%></span><br />
				
<%	
			Else
%>
				<span class="normalBold">You searched for: </span>
				<span class="normal">User&nbsp;<%=strConditionText%>&nbsp;"<%=strItemText%>"	
				</span><br />
				
<%
			End If
		End If
%>
				<span class="normalBold">Number of Responses:</span>
				<span class="normal"><%=intResultCount%></span><br />
				<span class="normalBold">Report Time:</span>
				<span class="normal"><%=now()%></span><br />
			</td>

		</tr>
	</table>
<%

			
		If rsResults.EOF Then
%>
			<p class="message"> No Results Found</p>
<%
		Else
			intResults = rsResults.RecordCount
			rsResults.AbsolutePage = intPageNumber
			
			strPagingURL = "viewResponses.asp?drilldownItemID=" & intItemID & "&conditionType=" & intConditionType &_
						   "&answerID=" & intAnswerID & "&response=" & server.urlEncode(strResponse) &_
						   "&surveyID=" & intSurveyID & "&category=" & server.URLEncode(strCategory) &_
						   "&highScore=" & intHighScore & "&lowScore=" & intLowScore  &_
						   "&searchScore=" & cstr(boolPointSearch) & "&orderBy=" & strOrderBy & "&orderByDirection=" & strOrderByDirection

			strSortingURL = "viewResponses.asp?drilldownItemID=" & intItemID & "&conditionType=" & intConditionType &_
						   "&answerID=" & intAnswerID & "&response=" & server.URLEncode(strResponse) &_
						   "&surveyID=" & intSurveyID & "&category=" & server.URLEncode(strCategory) &_
						   "&highScore=" & intHighScore & "&lowScore=" & intLowScore  &_
						   "&searchScore=" & cstr(boolPointSearch)


		If intResultCount > SV_RESULTS_PER_PAGE Then
%>
			<p align="center"><table><tr><td>
<%
		
		'paging links
		If intPageNumber > 1 Then
%>
			
			<a class="normalBold" 
				href="<%=strPagingURL%>&pageNumber=1"><< First</a>
			&nbsp;
			<a class="normalBold" 
				href="<%=strPagingURL%>&pageNumber=<%=intPageNumber - 1%>">< Prev</a>
			
<%
		Else
%>
			<span class="greyedText"><< First&nbsp;< Prev</span>
<%
		End If
%>
			</td><td>&nbsp;<span class="normalBold">Page</span>&nbsp;</td><td>

<%
		If intPageNumber < intPageCount Then
%>
			<a  class="normalBold" 
				href="<%=strPagingURL%>&pageNumber=<%=intPageNumber + 1%>">
				Next ></a>
			&nbsp;
			<a  class="normalBold" 
				href="<%=strPagingURL%>&pageNumber=<%=intPageCount%>">Last >></a>
<%
		Else
%>
			<span class="greyedText">Next >&nbsp;Last >></span>
<%
		End If
%>
			</td></tr></table></p>
<%
		End if
%>
			<br /><a href="<%=strGraphURL%>&flash=True"><img src="images/button-graphResults.gif" alt="Graph Results" border="0"></a>
			<a href="<%=strGraphURL%>&flash=False"><img src="images/button-viewStatistics.gif" alt="View Statistics" border="0"></a>
			<br />
			<form method="post" name="frmResponses">
			<%=common_basicTabletag%>

				<tr class="tableHeader" bgcolor="black">
					<td width="50" class="gridheader" valign="middle">
						Response
					</td>
<%
	If boolIsOwner = True or intUserType = SV_USER_TYPE_ADMINISTRATOR Then
%>
					<td class="gridheader" valign="middle" width="70">&nbsp;</td>
<%
			
	End If		
			If boolUserInfoAvailable = True Then
%>
					<td class="gridheader" width="200" valign="middle">
						<%=common_orderByLinks("Username",strOrderBy,strOrderByDirection, strSortingURL, "userName")%>
					</td>
<%
					If boolLogNTUser = True Then
%>
						<td class="gridheader" width="200" valign="middle">
							Network Username
						</td>
<%
					End If

			End If

					If boolScored = True Then
%>
						<td class="gridheader" width="75" valign="middle">
							<%=common_orderByLinks("Score",strOrderBy,strOrderByDirection, strSortingURL, "points")%>
						</td>
<%
					End If
%>
					<td class="gridheader" width="125" valign="middle">
						<%=common_orderByLinks("Completed",strOrderBy,strOrderByDirection, strSortingURL, "dateCompleted")%>
					</td>
					<td class="gridheader" valign="middle">
						<%=common_orderByLinks("User IP",strOrderBy, strOrderByDirection, strSortingURL, "userIP")%>
					</td>
<%
					If boolIsOwner = True or intUserType = SV_USER_TYPE_ADMINISTRATOR Then
						boolDeleteCheckbox = True
%>
						<td class="gridheader" align="center" width="75" valign="middle">
							Delete?<%=common_checkAllLink("checkedArray","document.forms.frmResponses.checkedAll")%>
						</td>
<%
					End If
%>
				</tr>
				
<%
				strArray = "new Array("
				
				intCounter = 0
				Do while rsResults.AbsolutePage = intPageNumber and not rsResults.EOF
					intResponseID = rsResults("responseID")
					strUsername = rsResults("username")
					intCounter = intCounter + 1
				
					If intCounter > 1 Then
						strArray = strArray & ","
					End If		
					
					strArray = strArray & "document.forms.frmResponses.checkbox" & intCounter

						strSQL = "SELECT userID, NTUser, points, dateCompleted, userIP " &_
							 "FROM usd_Response " &_
							 "WHERE responseID = " & intResponseID &_
							 " AND completed = 1"

						Set rsResponse = utility_getRecordset(strSQL)
						If not rsResponse.EOF Then
							intUserID = rsResponse("userID")
%>
					<%=common_tableRow(intCounter)%>
						<td width="50" class="normalBold" width="100" valign="middle">
							<a class="normalBold" 
								href="viewResponseDetails.asp?responseID=<%=intResponseID%>&surveyID=<%=intSurveyID%>">
								<%=intResponseID%></a>
						</td>
						
<%
	If boolIsOwner = True or intUserType = SV_USER_TYPE_ADMINISTRATOR Then
%>
<td class="griddata" width="70" valign="middle" align="left"><a class="normalBold" href="takeSurvey.asp?surveyID=<%=intSurveyID%>&editResponseID=<%=intResponseID%>&adminEditing=true" onclick="javascript:return confirmAction('Are you sure you want to edit this response?');"><img src="images/button-editResponse.gif" alt="Edit Response" border="0"></a></td>
<%
	End If

	If boolUserInfoAvailable = True Then
%>					
						<td class="griddata" width="200" valign="middle">
							<%=strUsername%>&nbsp;
						</td>
<%
						If boolLogNTUser = True Then
%>
							<td class="griddata" width="200" valign="middle">
								<%=rsResponse("NTUser")%>&nbsp;
							</td>
<%
						End If							
						
						End If
						
						If boolScored = True Then
%>
							<td class="griddata" width="75" valign="middle">
								<%=rsResponse("points")%>
							</td>
<%
						End If
%>
						<td class="griddata" width="125" valign="middle">
							<%=rsResponse("dateCompleted")%>&nbsp;
						</td>
						<td class="griddata" valign="middle">
							<%=rsResponse("userIP")%>
						</td>
<%
					If boolDeleteCheckbox = True Then
%>
						<td class="griddata" align="center" valign="middle" width="75">
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
							<input type="image" src="images/button-deleteResponses.gif" alt="Delete Responses" border="0"
							onclick="javascript:return confirmAction('Do you really want to delete all selected responses?');">
							<input type="hidden" name="delete" value="Delete Selected Responses">
								
							<input type="hidden" name="responseCount" value="<%=intCounter%>">
							<input type="hidden" name="drilldownItemID" value="<%=intItemID%>">
							<input type="hidden" name="conditionType" value="<%=intConditionType%>">
							<input type="hidden" name="response" value="<%=strResponse%>">
							<input type="hidden" name="answerID" value="<%=intAnswerID%>">
							<input type="hidden" name="surveyID" value="<%=intSurveyID%>">
							<input type="hidden" name="checkedAll" value="0">
						</td>
					</tr>
				</table>
				<script language="javascript">
					<!--
					checkedArray = <%=strArray%>);
					-->
				</script>
<%
			End If
%>
		
		</form>
<%
	End If
	rsResults.Close
	Set rsResults = NOTHING
		
		
	End If	
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->