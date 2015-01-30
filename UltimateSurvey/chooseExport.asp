<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'**************************************************************************************
'
' Name:		chooseExport.asp
' Purpose:	page to choose survey to export
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
	Dim boolMaxTimes
	Dim strSurveyTitle
	Dim intSurveyID
	Dim boolActive
	Dim intNumberResponses
	Dim strOrderBy
	Dim strOrderByDirection
	Dim strSortingURL
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",False)
	
	
%>	
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_REPORTS)%>
<span class="surveyTitle">Export Survey Results</span><br />
<span class="normal">Choose a survey to export its results to a .CSV file.  This will allow you to view and manipulate
the survey results in Excel, SPSS, or any other reporting program.</span>
<%
	
	strOrderBy = Request.QueryString("orderBy")
	strOrderByDirection = Request.QueryString("orderByDirection")
	
	If len(strOrderBy) = 0 Then
		strOrderBy = "surveyTitle"
	End If
	
	If len(strOrderByDirection) = 0 Then
		strOrderByDirection = "asc"
	End If

	strSQL = "SELECT surveyID, surveyTitle, isActive, numberResponses " &_
			 "FROM usd_Survey " 
	
	If intUserType <> SV_USER_TYPE_ADMINISTRATOR Then
			 strSQL = strSQL & "WHERE ((isActive = 1 and privacyLevel = " & SV_PRIVACY_LEVEL_DETAILS & ") " 
			If intUserType = SV_USER_TYPE_CREATOR Then
			 	strSQL = strSQL &  "OR ownerUserID = " & intUserID 
			End If
			strSQL = strSQL & ") "
	End If
		
	'Add search parameters if user trying to search
	strSearchText = trim(Request.QueryString("searchText"))
	strSearchType = Request.QueryString("searchType")
	
	If strSearchText <> "" Then
		If instr(1, strSQL, "WHERE") = 0 Then
			strSQL = strSQL & "WHERE " 
		Else
			strSQL = strSQL & "AND " 
		End If	
	
		strSQL = strSQL & strSearchType & " like '%" & strSearchText & "%'"
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

	<form method="get" action="chooseExport.asp">
		<hr noshade color="#C0C0C0" size="2">
		<table width="100%"><tr><td width="!5%">&nbsp;</td>
		<td width="85%" align="right" nowrap>
		<span class="normalBold">Search: </span>
		<input type="text" name="searchText" size="20">
		<select name="searchType">
			<option value="surveyTitle">Title</option>
			<option value="surveyDescription">Description</option>
		</select>
		<input type="image" src="images/button-search.gif" alt="Search" border="0">
		<input type="hidden" name="submit" value="Search">
		<a class="normalBold" href="chooseExport.asp">
			<img src="images/button-cancelSearch.gif" alt="Cancel Search" border="0"></a>
		</td></tr></table>
		<hr noshade color="#C0C0C0" size="2">
	</form>
<%
		strPagingURL = "chooseExport.asp?searchType=" & strSearchType & "&searchText=" &_
				Server.UrlEncode(strSearchText) & "&orderBy=" & strOrderBy & "&orderByDirection=" & strOrderByDirection  
				
		strSortingURL = "chooseExport.asp?searchType=" & strSearchType & "&searchText=" &_
				Server.UrlEncode(strSearchText)  
	If not rsResults.EOF Then
		rsResults.AbsolutePage = intPageNumber
		

				
		If intResultCount > SV_RESULTS_PER_PAGE Then
%>
			<table width="100%" ID="Table2">
			 <tr>
			  <td width="30%">&nbsp;</td>
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
			<span class="normalBold"><%=intResultCount%> survey(s) found.</span>
			</td>
			
			</tr></table>
<%
		End If
	End If
%>

		<table border="1" cellpadding="2" bordercolor="#CCCCCC" cellspacing="0" width="100%" ID="Table1">
			<tr bgcolor="black" class="tableHeader">
				<td valign="middle" class="gridheader" width="550">
					<%=common_orderByLinks("Survey Title", strOrderBy, strOrderByDirection, strSortingURL, "surveyTitle")%>	
				</td>
			
				<td valign="middle" class="gridheader" width="150" align="right">
					<%=common_orderByLinks("Response Count", strOrderBy, strOrderByDirection, strSortingURL, "numberResponses")%>	
				</td>
				<td valign="middle" class="gridheader" align="center">
					<%=common_orderByLinks("Active?", strOrderBy, strOrderByDirection, strSortingURL, "isActive")%>	
				</td>
				<td valign="middle" class="gridheader" width="75" align="center">
					Actions
				</td>
			</tr>
<%
		If rsResults.EOF Then
%>
			<%=common_tableRow(0)%>
				<td class="message" colspan="4">
						No surveys found...
				</td>
			</tr>

<%
		Else		

			Do while rsResults.AbsolutePage = intPageNumber and not rsResults.EOF
				intCounter = intCounter + 1
				intSurveyID = rsResults("surveyID")
				strSurveyTitle = rsResults("surveyTitle")
				boolActive = cbool(rsResults("isActive"))	
				intNumberResponses = rsResults("numberResponses")			
%>
				<%=common_tableRow(intCounter)%>
					<td class="normalBold" width="550">
						<%=strSurveyTitle%>
					</td>
					
					<td align="right" class="griddata" width="150">
						<%=intNumberResponses%>&nbsp;
					</td>					
					
					<td class="griddata" align="center">
				<%
					If boolActive = True Then
%>
						Active
<%
					Else
%>
						Inactive
<%
					End If
%>
					</td>
				
					<td align="middle" class="griddata" width="75" nowrap>
						<a href="exportExcel.asp?surveyID=<%=intSurveyID%>"><img src="images/button-reportsexport.gif" border="0" width="65" height="17"></a>
					</td>

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