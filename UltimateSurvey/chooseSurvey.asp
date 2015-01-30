<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'**************************************************************************************
'
' Name:		chooseSurvey.asp
' Purpose:	page to choose survey to take
'**************************************************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/response_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->

<%
	Dim intUserType
	Dim intResultCount
	Dim intPageNumber
	Dim intCounter
	Dim strSQL
	Dim strSearchText
	Dim strSearchType
	Dim rsResults
	Dim strPagingURL
	Dim intUserID
	Dim intPageCount
	Dim intResponsesPerUser
	Dim intUserResponses
	Dim boolMaxTimes
	Dim strSurveyTitle
	Dim intSurveyID
	Dim intTimesTaken
	Dim boolEditable
	Dim intLastResponseID
	Dim strOrderBy
	Dim strOrderByDirection
	Dim strSortingURL
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",False)

	strOrderBy = Request.QueryString("orderBy")
	strOrderByDirection = Request.QueryString("orderByDirection")
	
	If len(strOrderBy) = 0 Then
		strOrderBy = "surveyTitle"
	End If
	
	If len(strOrderByDirection) = 0 Then
		strOrderByDirection = "asc"
	End If

	strSQL = "SELECT surveyID, surveyTitle, responsesPerUser, editable " &_
			 "FROM usd_Survey " &_
			 " WHERE (isActive = 1 " &_
			 "AND (numberResponses < maxResponses OR maxResponses IS NULL ) " &_
			 "AND (startDate <= GETDATE() OR startDate IS NULL) " &_
			 "AND (endDate >= GETDATE() OR endDate IS NULL) "
	
	If not utility_isPositiveInteger(intUserType) Then
		strSQL = strSQL &  "AND surveyType = " & SV_SURVEY_TYPE_PUBLIC 
					
	Else
		 strSQL = strSQL & "AND ((surveyType <> " & SV_SURVEY_TYPE_RESTRICTED & ") " &_
				 "OR (surveyType = " & SV_SURVEY_TYPE_RESTRICTED & " AND " &_
				 "surveyID IN (SELECT surveyID FROM usd_restrictedSurveyUsers " &_
				 "WHERE userID = " & intUserID & " and isPermitted = 1)))" 
	End If

	If utility_isPositiveInteger(intUserID) Then
		strSQL = strSQL & " OR ownerUserID = " & intUserID
	End If
	
	strSQL = strSQL & ")"
	
	'Add search parameters if user trying to search
	strSearchText = trim(Request.QueryString("searchText"))
	strSearchType = Request.QueryString("searchType")
	
	If strSearchText <> "" Then
		strSQL = strSQL & " AND " & strSearchType & " like '%" &_
			 strSearchText & "%'"
	End If
	
	
	strSQL = strSQL & " ORDER BY " & strOrderBy & " " & strOrderByDirection
	
	Set rsResults = Server.CreateObject("ADODB.Recordset")
	'set up record set for paging
	rsResults.CursorLocation = adUseClient
	rsResults.PageSize = SV_RESULTS_PER_PAGE
	rsResults.Open utility_ConvertSQL(strSQL), DB_CONNECTION
	intPageCount = rsResults.PageCount
	intResultCount = rsResults.RecordCount
	
	intPageNumber = cint(Request.QueryString("pageNumber"))
	If intPageNumber < 1 Then 
		intPageNumber = 1
	End If


%>	
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
<span class="surveyTitle">Take A Survey</span>

	
	<form method="get" action="chooseSurvey.asp" id=form1 name=form1>
		<hr noshade color="#C0C0C0" size="2">
		<table width="100%">
		<tr><td width="15%">&nbsp;</td>
		<td width="85%" align="right" nowrap>
		<span class="normalBold">Search: </span>
		<input type="text" name="searchText" size="20">
		<select name="searchType">
			<option value="surveyTitle">Title</option>
			<option value="surveyDescription">Description</option>
		</select>
		<input type="image" src="images/button-search.gif" alt="Search" border="0">
		<input type="hidden" name="submit" value="Search">
		<a class="normalBold" href="chooseSurvey.asp">
			<img src="images/button-cancelSearch.gif" border="0"></a>
		</td></tr></table>
		<hr noshade color="#C0C0C0" size="2">
	</form>
	
<%
		strPagingURL = "chooseSurvey.asp?searchType=" & strSearchType & "&searchText=" &_
				Server.UrlEncode(strSearchText)  & "&orderBy=" & strOrderBy & "&orderByDirection=" & strOrderByDirection
		
		strSortingURL = "chooseSurvey.asp?searchType=" & strSearchType & "&searchText=" &_
				Server.UrlEncode(strSearchText)  

	If not rsResults.EOF Then
		rsResults.AbsolutePage = intPageNumber
		


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
		End If
%>
		<span class="normalBold"><%=intResultCount%> survey(s) found.</span>
<%
	End If
%>

		
				<table border="1" cellpadding="2" bordercolor="#CCCCCC" cellspacing="0" width="100%" ID="Table1">
			<tr bgcolor="black" class="tableHeader">
				<td valign="middle" class="gridheader">
					<%=common_orderByLinks("Survey Title", strOrderBy, strOrderByDirection, strSortingURL, "surveyTitle")%>	
				</td>
				<td valign="middle" class="gridheader" width="125">
					&nbsp;
				</td>
			</tr>
<%
			If rsResults.EOF Then
%>

				<%=common_tableRow(0)%>
				<td class="message" colspan="2">
					No surveys found...
				</td></tr>
<%
			Else
			
			Do while rsResults.AbsolutePage = intPageNumber and not rsResults.EOF
				intCounter = intCounter + 1
				intSurveyID = rsResults("surveyID")
				strSurveyTitle = rsResults("surveyTitle")
				intResponsesPerUser = rsResults("responsesPerUser") 
				boolEditable = cbool(rsResults("editable"))
				If utility_isPositiveInteger(intUserID) Then
					boolMaxTimes = response_respondedMaxTimes(intSurveyID, intUserID) 
					If boolEditable = True Then
						intLastResponseID = response_getLastResponse(intUserID, intSurveyID)
					End If
				Else 
				
					If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
						intTimesTaken = cint(Request.Cookies(SV_COOKIE_NAME & "survey" & intSurveyID)("timesTaken"))
					ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then
						intTimesTaken = Cint(Session("survey" & intSurveyID & "timesTaken"))
					End If	
									
					If intTimesTaken >= intResponsesPerUser Then
						boolMaxTimes = True
					Else
						boolMaxTimes = False
					End If
				End If
%>
				<%=common_tableRow(intCounter)%>
					<td>
<%
					If boolMaxTimes = False or intUserID = survey_getOwnerID(intSurveyID) Then
%>
						<a href="takeSurvey.asp?surveyID=<%=intSurveyID%>" class="normalBold">
							<%=strSurveyTitle%></a>
<%
					Else
%>
						<span class="normalBold"><%=strSurveyTitle%></span>
<%
					End If
%>
					</td>
					<td>
<%
					If utility_isPositiveInteger(intLastResponseID) Then
%>
						<a href="takeSurvey.asp?surveyID=<%=intSurveyID%>&editResponseID=<%=intLastResponseID%>">
							Edit Last Response</a>
<%
					Else
%>
						&nbsp;
<%
					End If
%>
				</tr>
<%
				rsResults.MoveNext
			Loop

	End If
	rsResults.Close
	Set rsResults = NOTHING
%>
</table>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->