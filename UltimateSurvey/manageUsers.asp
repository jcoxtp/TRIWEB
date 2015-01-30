<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		manageUsers.asp
' Purpose:	page to view, search, and generally manage users
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
	Dim intUserTypeFound
	Dim intUserFoundID
	Dim intNumberUsers
	Dim intMessage
	Dim strMessage
	Dim strDomain
	Dim strPassword
	Dim strOrderByDirection
	Dim strOrderBy
	Dim strSortingURL
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo("", intUserType, "","", "",True)
	
	If intUserType <> SV_USER_TYPE_ADMINISTRATOR Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	

	intNumberUsers = Request.Form("numberUsers")
	If utility_isPositiveInteger(intNumberUsers) Then
		For intCounter = 1 to cint(intNumberUsers)
			If Request.Form("deleteUser" & intCounter) = "on" Then
				Call user_deleteUser(Request.Form("userID" & intCounter))
			End If 
			If Request.Form("deleteResponses" & intCounter) = "on" Then
				Call user_deleteUserResponses(Request.Form("userID" & intCounter))
			End If 
		Next
	End If

	intMessage = Request.QueryString("message")
	If utility_isPositiveInteger(intMessage) Then
		Select Case cint(intMessage)
			Case SV_MESSAGE_USER_ADDED
				strMessage = "User Successfully Added."
			Case SV_MESSAGE_USER_TYPE_EDITED
				strMessage = "User Successfully Edited."
			Case SV_MESSAGE_NETWORKUSERS_ADDED
				strMessage = "Network Users Successfully Added."
			Case SV_MESSAGE_USERS_ADDED
				strMessage = "Users Successfully Added."
		End Select
	End If
	
	strOrderBy = Request.QueryString("orderBy")
	strOrderByDirection = Request.QueryString("orderByDirection")
	
	If len(strOrderBy) = 0 Then
		strOrderBy = "username"
	End If

	strSQL = "SELECT userID, username, pword, networkDomain, usertype, email, firstName, lastName " &_
			 "FROM usd_SurveyUser "
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
	
	strPagingURL = "manageUsers.asp?searchType=" & strSearchType & "&searchText=" &_
				Server.UrlEncode(strSearchText) & "&orderBy=" & strOrderBy & "&orderByDirection=" & strOrderByDirection
		
	strSortingURL = "manageUsers.asp?searchType=" & strSearchType & "&searchText=" &_
				Server.UrlEncode(strSearchText)
	
	If Request.QueryString("submit") = "Search" Then
		strPagingURL = strPagingURL & "&submit=Search"
		strSortingURL = strSortingURL & "&submit=Search"
	End If

		
	intPageNumber = cint(Request.QueryString("pageNumber"))
	If intPageNumber < 1 Then 
		intPageNumber = 1
	ElseIf intPageNumber > intPageCount Then
		Response.Redirect(strPagingURL & "&pageNumber=" & intPageCount)		
	End If

%>	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_USERS)%>
	<span class="surveyTitle">Manage Users<%=common_helpLink("users/manageUsers.asp",SV_SMALL_HELP_IMAGE)%></span><br />
	<span class="message"><%=strMessage%></span>
	<form method="get" action="manageusers.asp">
		<hr noshade color="#C0C0C0" size="2">
	
		<table width="100%" border="0"><tr><td width="15%">
			<span class="navLinks">
			<a href="registerUser.asp">
				<img src="images/button-addNewUser.gif" alt="Add New User" border="0" width="125" height="17"></a>&nbsp;&nbsp;
			</td>
			<td width="85%" align="right" nowrap>
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
			<input type="hidden" name="submit" value="Search">
			<a class="normalBold" href="manageUsers.asp"><img src="images/button-cancelSearch.gif" alt="Cancel Search" border="0"></a>
			</td></tr></table>
			<hr noshade color="#C0C0C0" size="2">

		</form>
<%
	If not rsResults.EOF Then
		rsResults.AbsolutePage = intPageNumber
		
	 ' If intResultCount > SV_RESULTS_PER_PAGE Then
%>
			
			<table width="100%" ID="Table2">
			 <tr>
			  <td width="30%"><span class="normalBold"><%=intResultCount%> user(s) found.</span></td>
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
		<form method="post" action="<%=strPagingURL%>&pageNumber=<%=intPageNumber%>" ID="Form2" name="frmUsers">
			<tr bgcolor="black" class="tableHeader">
				<td valign="middle" class="gridheader" width="250">
					<%=common_orderByLinks("Username",strOrderBy,strOrderByDirection,strSortingURL,"username")%>
				</td>
				<td valign="middle" class="gridheader" width="150">
					<%=common_orderByLinks("Password",strOrderBy,strOrderByDirection,strSortingURL,"pword")%>
				</td>
				<td valign="middle" class="gridheader" width="150">
					<%=common_orderByLinks("Domain",strOrderBy,strOrderByDirection,strSortingURL,"networkDomain")%>
				</td>
				<td valign="middle" class="gridheader" width="100" nowrap>
					<%=common_orderByLinks("User Type",strOrderBy,strOrderByDirection,strSortingURL,"usertype")%>
				</td>
				<td valign="middle" class="gridheader" width="200">
					<%=common_orderByLinks("Email",strOrderBy,strOrderByDirection,strSortingURL,"email")%>
				</td>
				<td valign="middle" class="gridheader" width="100">
					<%=common_orderByLinks("First Name",strOrderBy,strOrderByDirection,strSortingURL,"firstname")%>
				</td>
				<td valign="middle" class="gridheader" width="100">
					<%=common_orderByLinks("Last Name",strOrderBy,strOrderByDirection,strSortingURL,"lastname")%>
				</td>
				<td align="center" valign="middle" class="gridheader" width="150" nowrap>
					Delete User?<%=common_checkAllLink("userArray","document.frmUsers.checkedAllUsers")%>
				</td>
				<td align="center" valign="middle" class="gridheader" nowrap>
					Delete Responses?<%=common_checkAllLink("deleteArray","document.frmUsers.checkedAllDeletes")%>
				</td>
			</tr>
<%
			Dim strUserArray
			Dim strDeleteArray
			
			strUserArray = "new Array("
			strDeleteArray = "new Array("
			
			If rsResults.EOF Then
%>
				<%=common_tableRow(0)%>
					<td colspan="8" class="message">
						No Users Found
					</td>
				</tr>
				</table>
<%
	
			Else
			intCounter = 0
			

			
			Do while rsResults.AbsolutePage = intPageNumber and not rsResults.EOF
				intCounter = intCounter + 1
				intUserFoundID = rsResults("userID")
				intUserTypeFound = rsResults("userType")
				
				If intCounter > 1 Then 
					strUserArray = strUserArray & ","
					strDeleteArray = strDeleteArray & ","
				End If
				
				strUserArray = strUserArray & "document.forms.frmUsers.deleteUser" & intCounter 
				strDeleteArray = strDeleteArray & "document.forms.frmUsers.deleteResponses" & intCounter 

%>
				<%=common_tableRow(intCounter)%>
					<td width="250">
						<a href="viewUser.asp?userID=<%=rsResults("userID")%>" class="normalBold">
							<%=rsResults("userName")%></a>&nbsp;
					</td>
					<td class="griddata" width="150">
						<%=rsResults("pword")%>&nbsp;
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
					<td class="griddata" width="100">
						<%=rsResults("lastName")%>&nbsp;
					</td>
					
					<td align="center" width="150">
						<input type="checkbox" name="deleteUser<%=intCounter%>">
						<input type="hidden" name="userID<%=intCounter%>" value="<%=intUserFoundID%>">
					</td>
					<td align="center">
						<input type="checkbox" name="deleteResponses<%=intCounter%>">
					</td>
				</tr>
<%
				rsResults.MoveNext
			Loop
%>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<input type="hidden" name="numberUsers" value="<%=intCounter%>">
		<input type="image" src="images/button-deleteSelected.gif" alt="Delete Selected" border="0" value="Delete Selected Users/Responses"
		onclick="return confirmAction('Are you sure you want to deleted the selected users and/or responses?');"
		>
		
		<input type="hidden" name="checkedAllUsers" value="0">
		<input type="hidden" name="checkedAllDeletes" value="0">	
<%
	End If
%>
	</form>
	<script language="javascript">
		<!--
		userArray = <%=strUserArray%>);
		deleteArray = <%=strDeleteArray%>);

		-->
		</script>	
<%	
	rsResults.Close
	Set rsResults = NOTHING
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

