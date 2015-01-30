<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1	
'**************************************************************************************
'
' Name:		manageSurveys.asp
' Purpose:	page to view, search, and generally manage surveys
'**************************************************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/copySurvey_inc.asp"-->
<!--#INCLUDE FILE="Include/copy_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<!--#INCLUDE FILE="Include/copyItem_inc.asp"-->
<!--#INCLUDE FILE="Include/surveyCreation_inc.asp"-->
<%
	Dim intUserType
	Dim intPageCount
	Dim intResultCount
	Dim intPageNumber
	Dim intCounter
	Dim strSQL
	Dim strSearchText
	Dim strSearchType
	Dim rsResults
	Dim strPagingURL
	Dim intUserID
	Dim intSurveyID
	Dim intCopySurveyID
	Dim intDeleteSurveyID
	Dim intResponseCount
	Dim intMessage
	Dim strMessage
	Dim strOrderBy
	Dim strOrderByDirection
	Dim strSortingURL
	
	Call user_loginNetworkUser()
	
	'Get the user info out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)

	If utility_isPositiveInteger(intUserType) Then
		If intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
			Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
		End If
	Else
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	intMessage = Request.QueryString("message")
	If utility_isPositiveInteger(intMessage) Then
		If cint(intMessage) = SV_MESSAGE_SURVEY_DELETED Then
			strMessage = "Survey successfully deleted."
		End If
	End If
	
	intCopySurveyID = Request.QueryString("copySurveyID")
		
	If utility_isPositiveInteger(intCopySurveyID) Then
		Call copySurvey_copySurvey(intCopySurveyID, intUserID)
	End If
	
	strOrderBy = Request.QueryString("orderBy")
	strOrderByDirection = Request.QueryString("orderByDirection")
	
	If len(strOrderBy) = 0 Then
		strOrderBy = "surveyTitle"
	End If
	
	If len(strOrderByDirection) = 0 Then
		strOrderByDirection = "asc"
	End If
	
	strSQL = "SELECT surveyID, surveyType, username, surveyTitle, isActive, startDate, endDate, numberResponses " &_
			 "FROM usd_Survey S, usd_SurveyUser U  " &_
			 "WHERE S.ownerUserID = U.userID " 

	'Add search parameters if user trying to search
	strSearchText = trim(Request.QueryString("searchText"))
	strSearchType = Request.QueryString("searchType")
		
	If strSearchText <> "" Then
		strSQL = strSQL & " AND " & strSearchType & " like '%" &_
			 strSearchText & "%'"
	End If
	
	If intUserType = SV_USER_TYPE_CREATOR Then
		'If no where clause yet exists
		If inStr(1,strSQL,"WHERE") = 0 Then
			strSQL = strSQL & " WHERE "
		Else
			strSQL = strSQL & " AND " 
		End If
		strSQL = strSQL & "ownerUserID = " & intUserID
	End If
	
	strSQL = strSQL & " ORDER BY " & strOrderBy & " " & strOrderByDirection

	
	Set rsResults = Server.CreateObject("ADODB.Recordset")
	'set up record set for paging
	rsResults.CursorLocation = adUseClient
	rsResults.PageSize = SV_RESULTS_PER_PAGE
	rsResults.Open utility_ConvertSQL(strSQL), DB_CONNECTION
	intPageCount = rsResults.PageCount
	intResultCount = rsResults.RecordCount
	
	intPageNumber = Request.QueryString("pageNumber")
	
	If utility_isPositiveInteger(intPageNumber) Then
		intPageNumber = cint(intPageNumber)
	Else
		intPageNumber = 1
	End If
	
	If intPageCount < intPageNumber and intPageNumber <> 1 Then
		Response.Redirect("manageSurveys.asp?pageNumber=" & intPageCount & "&message=" & intMessage)
	End If
%>
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
	<span class="surveyTitle">Manage Surveys</span>
<%
	If len(trim(strMessage)) > 0 Then
%>
	<br /><span class="message"><%=strMessage%></span>
<%	
	End If
%>
	<form method="get" action="manageSurveys.asp" id=form1 name=form1>
		<hr noshade color="#C0C0C0" size="2">
		<table width="100%">
			<tr><td width="15%">
				<a href="createSurvey.asp">
				<img src="images/button-addNewSurvey.gif" alt="Add New Survey" border="0" width="125" height="17"></a>
			</td>
			</td>
			<td width="85%" align="right" nowrap>	
			<span class="normalBold">Search: </span>
			<input type="text" name="searchText">
			<select name="searchType">
				<option value="surveyTitle">Title</option>
				<option value="surveyDescription">Description</option>
			</select>
			<input type="hidden" name="submit" value="Search">
			<input type="image" src="images/button-search.gif" alt="Search" border="0">
			<a class="normalBold" href="manageSurveys.asp"><img src="images/button-cancelSearch.gif" alt="Cancel Search" border="0"></a>
			</td></tr></table>
		<hr noshade color="#C0C0C0" size="2">
	
	</form>
	

<%
	If not rsResults.EOF Then
		rsResults.AbsolutePage = intPageNumber
		strPagingURL = "manageSurveys.asp?searchType=" & strSearchType & "&searchText=" &_
						Server.UrlEncode(strSearchText)  & "&orderBy=" & strOrderBy & "&orderByDirection=" & strOrderByDirection
	
		strSortingURL = "manageSurveys.asp?searchType=" & strSearchType & "&searchText=" &_
				Server.UrlEncode(strSearchText) 
%>
			<table width="100%">
			 <tr>
			  <td width="30%"><span class="normalBold"><%=intResultCount%> survey(s) found.</span></td>
			  <td width="40%" align="center">
			
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
				&nbsp;<span class="normalBold">Page</span>&nbsp;

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
			</td>
			<td width="30%" align="right">
			<span class="normalBold">&nbsp;</span>
			</td>
			
			</tr></table>
<%
		End If
%>
		
		<table border="1" cellpadding="2" bordercolor="#CCCCCC" cellspacing="0" width="100%" ID="Table1">
			<tr bgcolor="black" class="tableHeader">
				<td valign="middle" class="gridheader" width="300">
					<%=common_orderByLinks("Survey Title", strOrderBy, strOrderByDirection, strSortingURL, "surveyTitle")%>
				</td>
				<td valign="middle" class="gridheader" width="100">
					<%=common_orderByLinks("Survey Type", strOrderBy, strOrderByDirection, strSortingURL, "surveyType")%>
				</td>
<%
				If intUserType = SV_USER_TYPE_ADMINISTRATOR Then
%>
				<td valign="middle" align="right" class="gridheader" width="200">
					<%=common_orderByLinks("Owner", strOrderBy, strOrderByDirection, strSortingURL, "username")%>
				</td>
<%
				End If
%>
				<td valign="middle" align="right" class="gridheader" width="100">
					<%=common_orderByLinks("Responses", strOrderBy, strOrderByDirection, strSortingURL, "numberResponses")%>
				</td>

				<td valign="middle" align="center" class="gridheader" width="75">
					<%=common_orderByLinks("Active", strOrderBy, strOrderByDirection, strSortingURL, "isActive")%>
				</td>
				<td valign="middle" align="right" class="gridheader" width="100">
					<%=common_orderByLinks("Start Date", strOrderBy, strOrderByDirection, strSortingURL, "startDate")%>
				</td>
				<td valign="middle" align="right" class="gridheader" width="100">
					<%=common_orderByLinks("End Date",strOrderBy, strOrderByDirection, strSortingURL, "endDate")%>
				</td>
				<td valign="middle" align="center" class="gridheader" width="190">
					Actions
				</td>
			</tr>
<%
		If rsResults.EOF Then
		
%>
			<%=common_tableRow(0)%>
				<td colspan="
<%
				If intUserType = SV_USER_TYPE_ADMINISTRATOR Then
%>
					8
<%
				Else
%>			
					7				
<%
				End If
%>
					" class="message">No surveys found...</td>
				</tr>
<%
		Else
			Do while rsResults.AbsolutePage = intPageNumber and not rsResults.EOF
				intCounter = intCounter + 1
				intSurveyID = rsResults("surveyID")
				intResponseCount = rsResults("numberResponses")
%>
				<%=common_tableRow(intCounter)%>
					<td width="300">
						<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>" class="normalBold">
							<%=rsResults("surveyTitle")%></a>
					</td>
			
					<td class="griddata" width="100">
						&nbsp;<%=survey_getSurveyTypeText(rsResults("surveyType"))%>
					</td>
<%
				If intUserType = SV_USER_TYPE_ADMINISTRATOR Then
%>
					<td class="griddata" align="right" width="200">
						<%=rsResults("username")%>
					</td>
<%
				End If
%>
					<td class="griddata" align="right" width="100">
						&nbsp;
<%		
						If Utility_IsPositiveInteger(intResponseCount) Then
%>
							<%=intResponseCount%>
<%						
						Else						
%>
							0
<%
						End If
%>

					</td>					
					<td  class="griddata" align="center" width="75">
					<span style="font-weight: bold">
<%
						If rsResults("isActive") = 1 Then
%>
							Yes
<%
						Else
%>
							No
<%
						End If
%>
						</span>
					</td>
					<td class="griddata" align="right" width="100">
						<%=rsResults("startDate")%>&nbsp;
					</td>
					<td class="griddata" align="right" width="100">
						<%=rsResults("endDate")%>&nbsp;
					</td>
					<td  width="190" align="center" nowrap>
						<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><img src="images/button-manage.gif" alt="Manage" border="0" height="17" width="65" vspace="0"></a>
						<a href="manageSurveys.asp?copySurveyID=<%=intSurveyID%>&pageNumber=
<%
						If intCounter = SV_RESULTS_PER_PAGE Then
%>
							<%=intPageNumber + 1%>
<%
						Else
%>
							<%=intPageNumber%>
<%
						End If
%>						
						
						"
						onclick="return confirmAction('Are you sure you want to copy this survey?');"
						><img src="images/button-surveycopy.gif" alt="Copy" border="0" height="17" width="55" vspace="0"></a>
						<a href="deleteSurvey.asp?surveyID=<%=intSurveyID%>&pageNumber=<%=intPageNumber%>"
						onclick="return confirmAction('Are you sure you want to delete this survey?');"
						><img src="images/button-surveydelete.gif" alt="Delete" border="0" height="17" width="55" vspace="0"></a></td>
				</tr>
<%
				rsResults.MoveNext
			Loop
	End If
%>
		</table>
<%	
	rsResults.Close
	Set rsResults = NOTHING
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

