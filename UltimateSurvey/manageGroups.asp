<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		manageGroups.asp
' Purpose:	page to view, search, and generally manage user groups
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
	Dim intDeleteGroupID
	Dim intGroupID
	Dim strGroupName
	Dim strDescription
	Dim strOrderBy
	Dim strOrderByDirection
	Dim strSortingURL
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo("", intUserType, "","", "",True)
	
	If intUserType <> SV_USER_TYPE_ADMINISTRATOR Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	
	intDeleteGroupID = Request.QueryString("deleteGroupID")
	
	If utility_isPositiveInteger(intDeleteGroupID) Then
		strSQL = "DELETE FROM usd_userGroupMap WHERE groupName = (SELECT groupName FROM usd_userGroups WHERE groupID = " & intDeleteGroupID & ")"
		Call utility_executeCommand(strSQL) 
		
		strSQL = "DELETE FROM usd_userGroups WHERE groupID = " & intDeleteGroupID
		Call utility_executeCommand(strSQL) 
		
		strMessage = "Group successfully deleted."
	
	End If

	strOrderBy = Request.QueryString("orderBy")
	strOrderByDirection = Request.QueryString("orderByDirection")
	
	If len(strOrderBy) = 0 Then
		strOrderBy = "groupName"
	End If
	
	If len(strOrderByDirection) = 0 Then
		strOrderByDirection = "asc"
	End If


	strSQL = "SELECT groupID, groupName, description " &_
			 "FROM usd_userGroups "
	'Add search parameters if user trying to search
	If Request.Querystring("submit") = "Search" Then
		strSearchText = Request.QueryString("searchText")
		strSearchType = Request.QueryString("searchType")
		strSQL = strSQL & " WHERE " & strSearchType & " like '%" &_
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

	strPagingURL = "manageGroups.asp?searchType=" & strSearchType & "&searchText=" &_
					Server.UrlEncode(strSearchText) & "&orderBy=" & strOrderBy & "&orderByDirection=" & strOrderByDirection
					
	strSortingURL = "manageGroups.asp?searchType=" & strSearchType & "&searchText=" &_
					Server.UrlEncode(strSearchText)
%>	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_USERS)%>
	<span class="surveyTitle">User Groups</span><br />
	<span class="message"><%=strMessage%></span><br />
	<form method="get" action="manageGroups.asp" id=form1 name=form1>
		<hr noshade color="#C0C0C0" size="2">
		<table width="100%">
			<tr><td width="15%">
				<a href="editUserGroup.asp">
					<img src="images/button-addNewGroup.gif" alt="Add New Group" width="125" height="17" border="0"></a>&nbsp;&nbsp;
				</td>
				<td width="85%" align="right" nowrap>
			<span class="normalBold">Search: </span>
			<input type="text" name="searchText">
			<select name="searchType">
				<option value="groupName">Group Name</option>
				<option value="description">Description</option>
			</select>
			<input type="image" src="images/button-search.gif" alt="Search" border="0">
			<input type="hidden" name="submit" value="Search">
			<a class="normalBold" href="manageGroups.asp"><img src="images/button-cancelSearch.gif" alt="Cancel Search" border="0"></a>
			</td></tr></table>
		<hr noshade color="#C0C0C0" size="2">
		</form>
<%
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
			<td width="30%" align="right"><span class="normalBold"><%=intResultCount%> user(s) found.</span></td>
			
			</tr></table>

			
<%
		End if
	End If
	
%>
		
		
		<table border="1" cellpadding="2" bordercolor="#CCCCCC" cellspacing="0" width="100%" ID="Table1">
			<tr bgcolor="black" class="tableHeader">
				<td valign="middle" class="gridheader">
					<%=common_orderByLinks("Group Name", strOrderBy, strOrderByDirection, strSortingURL, "groupName")%>
				</td>
				<td valign="middle" class="gridheader">
					Description
				</td>
				<td valign="middle" class="gridheader" align="center">
					Users
				</td>
				<td valign="middle" class="gridheader" align="center" width="280">
					Actions
				</td>
			</tr>
<%
		If rsResults.EOF Then
%>
			<%=common_tableRow(0)%>
				<td colspan="4" class="message">
					No groups found...
				</td>
			</tr>

<%		
		Else
			intCounter = 0
			
			Do while rsResults.AbsolutePage = intPageNumber and not rsResults.EOF
				intCounter = intCounter + 1
				intGroupID = rsResults("groupID")
				strGroupName = rsResults("groupName")
				strDescription = rsResults("description")
				
%>
				<%=common_tableRow(intCounter)%>
					<td class="normalBold">
						<%=strGroupName%></a>&nbsp;
					</td>
					<td class="griddata">
						<%=strDescription%>&nbsp;
					</td>
					<td  class="griddata" align="center">
						<%=user_getGroupUserCount(strGroupName)%>&nbsp;
					</td>
					<td  class="griddata" align="center" width="280">
						<a href="editGroup.asp?groupID=<%=intGroupID%>">
							<img src="images/button-viewEdit.gif" alt="View/Edit" width="90" height="17" border="0"></a>
						<a href="editUserGroup.asp?groupID=<%=intGroupID%>"><img src="images/button-properties.gif" alt="Properties" border="0"></a>
						<a href="manageGroups.asp?deleteGroupID=<%=intGroupID%>"
							onclick="javascript:confirmAction('Are you sure you want to delete this group?');"><img src="images/button-delete-large.gif" alt="Delete" border="0"></a>
					</td>
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

