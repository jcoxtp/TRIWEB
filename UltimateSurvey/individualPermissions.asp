<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		individualPermissions.asp
' Purpose:	page to manage permissions for individual users for a particular survey
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
	Dim intSurveyID
	Dim intUserID
	Dim strOrderBy
	Dim strOrderByDirection
	Dim strSortingURL
	Dim strAllowArray
	Dim strDenyArray
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = Request.QueryString("surveyID")
	
	
	If not utility_isPositiveInteger(intUserID) Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	Else
		If ((survey_getOwnerID(intSurveyID) <> intUserID) _
				and intUserType = SV_USER_TYPE_CREATOR) _
				or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
			Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
		End If
	End If
	

	intNumberUsers = Request.Form("numberUsers")
	If utility_isPositiveInteger(intNumberUsers) Then
		For intCounter = 1 to cint(intNumberUsers)
			intUserFoundID = Request.Form("userID" & intCounter)
			If Request.Form("allow" & intCounter) = "on" Then
				Call inviteUsers_setUserPermission(intUserFoundID, intSurveyID, True, SV_PERMISSION_TYPE_INDIVIDUAL)
				strMessage = "User permissions successfully edited."
			ElseIf Request.Form("deny" & intCounter) = "on" Then
				Call inviteUsers_setUserPermission(intUserFoundID, intSurveyID, False, SV_PERMISSION_TYPE_INDIVIDUAL)
				strMessage = "User permissions successfully edited."
			End If
		Next
	End If


	strOrderBy = Request.QueryString("orderBy")
	strOrderByDirection = Request.QueryString("orderByDirection")
	
	If len(strOrderBy) = 0 Then
		strOrderBy = "networkDomain"
	End If
	
	If len(strOrderByDirection) = 0 Then
		strOrderByDirection = "asc"
	End If

	strSQL = "SELECT userID, username, networkDomain, usertype, email, firstName, lastName " &_
			 "FROM usd_SurveyUser " &_
			 "WHERE userID NOT IN(SELECT userID FROM usd_restrictedSurveyUsers WHERE surveyID = " & intSurveyID & ")"
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
	If intPageNumber < 1 Then 
		intPageNumber = 1
	ElseIf intPageNumber > intPageCount Then
		Response.Redirect("individualPermissions.asp?surveyID=" & intSurveyID & "&searchType=" & strSearchType & "&searchText=" &_
							Server.URLEncode(strSearchText) & "&pageNumber=" & intPageCount)
		
	End If

	strPagingURL = "individualPermissions.asp?surveyID=" & intSurveyID & "&searchType=" & strSearchType & "&searchText=" &_
					Server.UrlEncode(strSearchText) & "&orderBy=" & strOrderBy & "&orderByDirection=" & strOrderByDirection
	
	strSortingURL = "individualPermissions.asp?surveyID=" & intSurveyID & "&searchType=" & strSearchType & "&searchText=" &_
					Server.UrlEncode(strSearchText)
%>	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
		<span class="breadcrumb" align="left">
	<a href="manageSurveys.asp">All Surveys</a> >>
	<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=survey_getSurveyTitle(intSurveyID)%></a> >>
	<a href="surveySecurity.asp?surveyID=<%=intSurveyID%>">Survey Security</a> >>
	Add Users
	</span><br /><br />		<p class="surveyTitle">Add Users</p>
	<span class="normal">You may select to allow or deny permission for each individual user to take a survey.  These permissions
	override permissions based on any groups that the user may be in.  Not selecting a user indicates that the user may only 
	take the survey if given permission based on group.</span>
	<br /><span class="message"><%=strMessage%></span>
	<form method="get" action="individualPermissions.asp">
		<hr noshade color="#C0C0C0" size="2">
		<table width="100%"><tr><td width="15%">&nbsp;</td>
		<td width="15%" align="right" nowrap>
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
			<input type="hidden" name="surveyID" value="<%=intSurveyID%>">
			<input type="hidden" name="submit" value="Search">
			<a class="normalBold" href="individualPermissions.asp?surveyID=<%=intSurveyID%>"><img src="images/button-cancelSearch.gif" alt="Cancel Search" border="0"></a>
		</td></tr></table>
		<hr noshade color="#C0C0C0" size="2">
		</form>
<%
	If rsResults.EOF Then
%>
		<span class="message">No Users Found</span>
<%
	Else
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
%>
		
		
		<table border="1" cellpadding="2" bordercolor="#CCCCCC" cellspacing="0" width="100%" ID="Table1">
		<form method="post" action="<%=strPagingURL%>&pageNumber=<%=intPageNumber%>" name="frmPermissions">
			<tr bgcolor="black" class="tableHeader">
				<td align="center" valign="middle" align="center" class="gridheader">
					Allow<%=common_checkAllLink("allowArray","document.forms.frmPermissions.allCheckedAllow")%>
				</td>
				<td align="center" valign="middle" align="center" class="gridheader">
					Deny<%=common_checkAllLink("denyArray","document.forms.frmPermissions.allCheckedDeny")%>
				</td>
				<td valign="middle" class="gridheader">
					<%=common_orderByLinks("Username",strOrderBy, strOrderByDirection, strSortingURL, "username")%>
				</td>
				<td valign="middle" class="gridheader">
					<%=common_orderByLinks("Domain", strOrderBy, strOrderByDirection, strSortingURL, "networkDomain")%>
				</td>
				<td valign="middle" class="gridheader">
					<%=common_orderByLinks("User Type", strOrderBy, strOrderByDirection, strSortingURL, "usertype")%>
				</td>
				<td valign="middle" class="gridheader">
					<%=common_orderByLinks("Email", strOrderBy, strOrderByDirection, strSortingURL, "email")%>
				</td>
				<td valign="middle" class="gridheader">
					<%=common_orderByLinks("First Name", strOrderBy, strOrderByDirection, strSortingURL, "firstName")%>
				</td>
				<td valign="middle" class="gridheader">
					<%=common_orderByLinks("Last Name", strOrderBy, strOrderByDirection, strSortingURL, "lastName")%>
				</td>
			</tr>
<%
			intCounter = 0
			
			strAllowArray = "new Array("
			strDenyArray = "new Array("
			
			Do while rsResults.AbsolutePage = intPageNumber and not rsResults.EOF
				intCounter = intCounter + 1
				intUserFoundID = rsResults("userID")
				intUserTypeFound = rsResults("userType")

				If intCounter > 1 Then
					strAllowArray = strAllowArray & ","
					strDenyArray = strDenyArray & ","
				End If
				
				strAllowArray = strAllowArray & "document.forms.frmPermissions.allow" & intCounter
				strDenyArray = strDenyArray & "document.forms.frmPermissions.deny" & intCounter
%>
				<%=common_tableRow(intCounter)%>
					<td class="griddata" align="center">
						<input type="checkbox" name="allow<%=intCounter%>" 
							<%=onlyOneCheckedJavascipt("allow" & intCounter,"deny" & intCounter)%> >
					</td>
					<td class="griddata" align="center">
						<input type="checkbox" name="deny<%=intCounter%>" 
							<%=onlyOneCheckedJavascipt("deny" & intCounter,"allow" & intCounter)%> >
							
						<input type="hidden" name="userID<%=intCounter%>" value="<%=intUserFoundID%>">
					</td>
					<td class="griddata">
						<%=rsResults("userName")%>&nbsp;
					</td>
					<td class="griddata">
						<%=rsResults("networkDomain")%>&nbsp;
					</td>
					<td  class="griddata"> 
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
					<td  class="griddata">
						<%=rsResults("email")%>&nbsp;
					</td>
					<td class="griddata">
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
		<input type="image" src="images/button-submit.gif" alt="Submit" border="0" 
		onclick="return confirmAction('Are you sure you want to change user permissions?');"
		>
		<input type="hidden" name="allCheckedAllow" value="0">
		<input type="hidden" name="allCheckedDeny" value="0">
		<script language="javascript">
			<!--
			allowArray = <%=strAllowArray%>);
			denyArray = <%=strDenyArray%>);
			-->
		</script>
		</form>
<%
	End If
	rsResults.Close
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->
<%
Function onlyOneCheckedJavascipt(strBoxClicked, strOtherBox)
%>
	onclick="javascript:if (document.frmPermissions.<%=strBoxClicked%>.checked){document.frmPermissions.<%=strOtherBox%>.checked = false;}"
			
<%
End Function

%>