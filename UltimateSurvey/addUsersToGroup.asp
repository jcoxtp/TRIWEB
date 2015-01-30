<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		addUsersToGroup.asp
' Purpose:	page to add current users to a group
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<!--#INCLUDE FILE="Include/inviteUsers_inc.asp"-->
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
	Dim intUserTypeFound
	Dim intUserFoundID
	Dim intNumberUsers
	Dim intMessage
	Dim strMessage
	Dim strDomain
	Dim intGroupID
	Dim strGroupName
	Dim strOrderBy
	Dim strOrderByDirection
	Dim strSortingURL
	Dim strArray
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo("", intUserType, "","", "",True)
	
	If intUserType <> SV_USER_TYPE_ADMINISTRATOR Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	intGroupID = Request.QueryString("groupID")
	
	strGroupName = user_getGroupName(intGroupID)

	intNumberUsers = Request.Form("numberUsers")
	If utility_isPositiveInteger(intNumberUsers) Then
		For intCounter = 1 to cint(intNumberUsers)
			intUserFoundID = Request.Form("userID" & intCounter)
			If Request.Form("addUserToGroup" & intCounter) =  "on" Then
				Call user_addUserToGroup(strGroupName, intUserFoundID)
				Call inviteUsers_updateSurveyPermissions(intUserFoundID, strGroupName)
			End If
		Next
		Response.Redirect("editGroup.asp?groupID=" & intGroupID & "&message=" & SV_MESSAGE_USERS_ADDED)
	End If
	
	strOrderBy = Request.QueryString("orderBy")
	strOrderByDirection = Request.QueryString("orderByDirection")
	
	If len(strOrderBy) = 0 Then
		strOrderBy = "username"
	End If
	
	If len(strOrderByDirection) = 0 Then
		strOrderByDirection = "asc"
	End If

	strSQL = "SELECT userID, username, networkDomain, usertype, email, firstName, lastName " &_
			 "FROM usd_SurveyUser " &_
			 "WHERE userID NOT IN(SELECT userID FROM usd_userGroupMap WHERE groupName = " & utility_SQLEncode(strGroupName, True)  & ")"
	'Add search parameters if user trying to search
	If Request.Querystring("submit") = "Search" Then
		strSearchText = Request.QueryString("searchText")
		strSearchType = Request.QueryString("searchType")
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
	
	strPagingURL = "addUsersToGroup.asp?groupID=" & intGroupID & "&searchType=" & strSearchType & "&searchText=" &_
				Server.UrlEncode(strSearchText) & "&orderBy=" & strOrderBy & "&orderByDirection=" & strOrderByDirection

	strSortingURL = "addUsersToGroup.asp?groupID=" & intGroupID & "&searchType=" & strSearchType & "&searchText=" &_
				Server.UrlEncode(strSearchText)
	If Request.QueryString("submit") = "Search" Then
		strSortingURL = strSortingURL & "&submit=Search"
		strPagingURL = strPagingURL & "&submit=Search"  
	End If
	
	If intPageNumber < 1 Then 
		intPageNumber = 1
	ElseIf intPageNumber > intPageCount Then
		Response.Redirect(strPagingURL & "&pageNumber=" & intPageCount)	
	End If

%>	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_USERS)%>
	<span class="breadcrumb" align="left">
		<a href="manageGroups.asp">All Groups</a> >>
		<a href="editGroup.asp?groupID=<%=intGroupID%>"><%=strGroupName%></a> >>
		Add Users
		</span><br />

	<span class="normalBold" align="left">
	<p class="surveyTitle">Add Users To "<%=strGroupName%>"<%=common_helpLink("users/manageUsers.asp",SV_SMALL_HELP_IMAGE)%></p>
	<span class="message"><%=strMessage%></span>
	<form method="get" action="addUsersToGroup.asp">
		<hr noshade color="#C0C0C0" size="2">
		<table width="100%"><tr><td width="15%">&nbsp;</td>
		<td align="right" width="85%" nowrap>
			<span class="normalBold">Search: </span>
			<input type="text" name="searchText">
			<select name="searchType">
				<option value="username">Username</option>
				<option value="email">Email Address</option>
				<option value="usertype">User Type</option>
				<option value="firstName">First Name</option>
				<option value="lastName">Last Name</option>
				<option value="networkDomain">Domain</option>
			</select>
			<input type="image" src="images/button-search.gif" alt="Search" border="0">
			<input type="hidden" name="groupID" value="<%=intGroupID%>">
			<input type="hidden" name="submit" value="Search">
			<a class="normalBold" href="addUsersToGroup.asp?groupID=<%=intGroupID%>"><img src="images/button-cancelSearch.gif" alt="Cancel Search" border="0"></a>
		</td></tr></table>
		<hr noshade color="#C0C0C0" size="2">
		</form>
<%
	If not rsResults.EOF Then
		rsResults.AbsolutePage = intPageNumber
		
	'  If intResultCount > SV_RESULTS_PER_PAGE Then
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
		'End If
	End If
%>
		
		
		<table border="1" cellpadding="2" bordercolor="#CCCCCC" cellspacing="0" width="100%" ID="Table1">
		<form method="post" action="<%=strPagingURL%>&pageNumber=<%=intPageNumber%>" name="frmPermissions">
			<tr bgcolor="black" class="tableHeader">
				<td align="center" valign="middle" align="center" class="gridheader" width="75">
					Add<%=common_checkAllLink("checkedArray","document.forms.frmPermissions.checkedAll")%>
				</td>
				<td valign="middle" class="gridheader" width="200">
					<%=common_orderByLinks("Username", strOrderBy,strOrderByDirection, strSortingURL, "username")%>
				</td>
				<td valign="middle" class="gridheader" width="150">
					<%=common_orderByLinks("Domain", strOrderBy, strOrderByDirection, strSortingURL, "networkDomain")%>
				</td>
				<td valign="middle" class="gridheader" width="100">
					<%=common_orderByLinks("User Type", strOrderBy, strOrderByDirection, strSortingURL, "usertype")%>
				</td>
				<td valign="middle" class="gridheader" width="200">
					<%=common_orderByLinks("Email", strOrderBy, strOrderByDirection, strSortingURL, "email")%>
				</td>
				<td valign="middle" class="gridheader" width="100">
					<%=common_orderByLinks("First Name", strOrderBy, strOrderByDirection, strSortingURL, "firstName")%>
				</td>
				<td valign="middle" class="gridheader">
					<%=common_orderByLinks("Last Name", strOrderBy, strOrderByDirection, strSortingURL, "lastName")%>
				</td>
	
			</tr>
<%
			If rsResults.EOF Then
%>
				<%=common_tableRow(0)%>
				<td class="message" colspan="7">No users found...</td>
				</tr>
				</table>
<%
			Else
			
			intCounter = 0
			
			strArray = "new Array("
			
			Do while rsResults.AbsolutePage = intPageNumber and not rsResults.EOF
				intCounter = intCounter + 1
				intUserFoundID = rsResults("userID")
				intUserTypeFound = rsResults("userType")

				If intCounter > 1 Then
					strArray = strArray & ","
				End If

				strArray = strArray & "document.forms.frmPermissions.addUserToGroup" & intCounter
%>
				<%=common_tableRow(intCounter)%>
					<td class="griddata" align="center" width="75">
						<input type="checkbox" name="addUserToGroup<%=intCounter%>">
							<input type="hidden" name="userID<%=intCounter%>" value="<%=intUserFoundID%>">
					
					</td>
					<td class="griddata" width="200">
						<%=rsResults("userName")%>&nbsp;
					</td>
					<td class="griddata" width="150">
						<%=rsResults("networkDomain")%>&nbsp;
					</td>
					<td  class="griddata" width="100"> 
<%
					Select Case intUserTypeFound
						Case SV_USER_TYPE_TAKE_ONLY
%>
							Take Surveys Only
<%
						Case SV_USER_TYPE_CREATOR
%>
							Take and Create
<%						
						Case SV_USER_TYPE_ADMINISTRATOR
%>
							Administrator
<%
					End Select
%>
					&nbsp;</td>
					<td  class="griddata" width="200">
						<%=rsResults("email")%>&nbsp;
					</td>
					<td class="griddata" width="100">
						<%=rsResults("firstName")%>&nbsp;
					</td>
					<td class="griddata">
						<%=rsResults("lastName")%>&nbsp;
					</td>
				</tr>
<%
				rsResults.MoveNext
			Loop
%>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<input type="hidden" name="numberUsers" value="<%=intCounter%>">
		<input type="image" src="images/button-submit.gif" alt="Submit" border="0" onclick="return confirmAction('Are you sure you want to add these users to this group?');"
		>
		<input type="hidden" name="checkedAll" value="0">
		<script language="javascript">
			<!--
			checkedArray = <%=strArray%>);
			-->
		</script>
		</form>
<%
	End If
	rsResults.Close
	Set rsResults = NOTHING
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->
