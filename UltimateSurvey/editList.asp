<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		editList.asp
' Purpose:	page to edit email lists
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/response_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
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
	Dim intNumberUsers
	Dim intMessage
	Dim strMessage
	Dim strDomain
	Dim intDeleteListID
	Dim intListID
	Dim strListName
	Dim strDescription
	Dim intEmailCount
	Dim strEmailAddress
	Dim intDeleteCounter
	Dim strOrderBy
	Dim strOrderByDirection
	Dim strSortingURL

	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo("", intUserType, "","", "",True)
	
	If intUserType <> SV_USER_TYPE_ADMINISTRATOR Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	intListID = Request.querystring("listID")
	strListName = user_getEmailListName(intListID)
	
	intEmailCount = Request.Form("emailCount")
	If utility_isPositiveInteger(intEmailCount) Then
		For intCounter = 1 to cint(intEmailCount) 
			If Request.Form("delete" & intCounter) = "on" Then
				intDeleteCounter = intDeleteCounter + 1
				strEmailAddress = Request.Form("email" & intCounter)
				strSQL = "DELETE FROM usd_emailListDetails " &_
						 "WHERE listName = " & utility_SQLEncode(strListName, True) &_
						 " AND email = " & utility_SQLEncode(strEmailAddress, True) 
				Call utility_executeCommand(strSQL)
			End If
		Next
	End If

	If intDeleteCounter > 0 Then
		strMessage = "Deletion successful.  Number of addresses deleted: " & intDeleteCounter
	End If

	strOrderBy = request.QueryString("orderBy")
	strOrderByDirection = request.QueryString("orderByDirection")
	
	If len(strOrderBy) = 0 Then
		strOrderBy = "email"
	End If
	
	strSQL = "SELECT email " &_
			 "FROM usd_emailListDetails " &_
			 "WHERE listName = " & utility_SQLEncode(strListName, True)
	'Add search parameters if user trying to search
	If Request.Querystring("submit") = "Search" Then
		strSearchText = Request.QueryString("searchText")
		strSQL = strSQL & " AND email LIKE '%" & strSearchText & "%'"
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
	ElseIf intPageNumber > intPageCount Then
		rsResults.Close
		Set rsResults = NOTHING
		Response.Redirect("editList.asp?listID=" & intListID & "&pageNumber=" & intPageCount)
	End If

	strPagingURL = "editList.asp?listID=" & intListID & "&searchText=" &_
					Server.UrlEncode(strSearchText) & "&orderBy=" & strOrderBy & "&orderByDirection=" & strOrderByDirection

	strSortingURL = "editList.asp?listID=" & intListID & "&searchText=" &_
					Server.UrlEncode(strSearchText)


%>	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_USERS)%>
	<span class="breadcrumb" align="left">
			<a href="manageLists.asp">All Lists</a> >>
			<%=strListName%>
	</span><br /><br />

	<span class="surveyTitle">View/Edit "<%=strListName%>"</span><br />
	<span class="message"><%=strMessage%></span>
	<form method="get" action="editList.asp" id=form1 name=form1>
		<hr noshade color="#C0C0C0" size="2">
		<table width="100%">
		<tr><td width="15%">
			<a href="addAddressesToList.asp?listID=<%=intListID%>">
					<img src="images/button-addAddresses.gif" border="0" width="125" height="17"></a>
			</td>
			<td width="85%" align="right" nowrap>
				<span class="normalBold">Search: </span>
				<input type="text" name="searchText">
				<input type="image" src="images/button-search.gif" alt="Search" border="0">
				<input type="hidden" name="submit" value="Search">
				<input type="hidden" name="listID" value="<%=intListID%>">
				<a class="normalBold" href="editList.asp?listID=<%=intListID%>"><img src="images/button-cancelSearch.gif" alt="Cancel Search" border="0"></a>
			</td>
		</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
	</form>
	<form method="post" action="editList.asp?listID=<%=intListID%>&pageNumber=<%=intPageNumber%>" ID="Form2">
	
	
<%
	If not  rsResults.EOF Then
		rsResults.AbsolutePage = intPageNumber
		
	 ' If intResultCount > SV_RESULTS_PER_PAGE Then
%>
			
			<table width="100%" ID="Table2">
			 <tr>
			  <td width="30%"><span class="normalBold"><%=intResultCount%> addresses(s) found.</span></td>
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
			<td width="30%" align="right">&nbsp;</td>
			
			</tr></table>

			
<%
		'End If
	End If

%>
		
		<table border="1" cellpadding="2" bordercolor="#CCCCCC" cellspacing="0" width="100%" ID="Table1">
			<tr bgcolor="black" class="tableHeader">
				<td valign="middle" class="gridheader" align="center" width="30">
					Remove?
				</td>
				<td valign="middle" class="gridheader">
					<%=common_orderByLinks("Email Address", strOrderBy, strOrderByDirection, strSortingURL, "email")%>
				</td>
			</tr>

<%
			If rsResults.EOF Then
%>
				<%=common_tableRow(0)%>
					<td class="message" colspan="2">
						No addresses found...
					</td>
				</tr></table>
<%			
			Else
			
			intCounter = 0
			
			Do while rsResults.AbsolutePage = intPageNumber and not rsResults.EOF
				intCounter = intCounter + 1
				strEmailAddress = rsResults("email")
				
				
%>
				<%=common_tableRow(intCounter)%>
					<td class="griddata" align="center">
						<input type="checkbox" name="delete<%=intCounter%>">
						<input type="hidden" name="email<%=intCounter%>" value="<%=strEmailAddress%>">
					</td>
					<td class="griddata">
						<%=strEmailAddress%>
					</td>
				</tr>
<%
				rsResults.MoveNext
			Loop
%>
		</table>
		<br />
		<input type="hidden" name="emailCount" value="<%=intCounter%>">
		<input type="image" src="images/button-submit.gif" alt="Submit" border="0"
			onclick="javascript:return confirmAction('Are you sure you want to delete these email addresses from the list?');">
		
<%
	End If
%>
	</form>
<%
	rsResults.Close
	Set rsResults = NOTHING
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

