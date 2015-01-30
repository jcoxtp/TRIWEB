<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		editUserGroup.asp
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
	Dim intMessage
	Dim strMessage
	Dim intGroupID
	Dim strGroupName
	Dim strDescription
	Dim strPageHeader
	Dim strSQL
	Dim rsResults
	Dim strError
	Dim strBreadCrumbEnd
	Dim strOldGroupName
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo("", intUserType, "","", "",True)
	
	If intUserType <> SV_USER_TYPE_ADMINISTRATOR Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	
	intGroupID = Request.QueryString("groupID")
	
	If Request.Form("submit") = "true" Then
		strGroupName = trim(Request.Form("groupName"))
		strDescription = Request.Form("description")
		strOldGroupName = Request.form("oldGroupName")
		
		If strGroupName = "" Then
			strError = "Group Name is required."
		ElseIf utility_isPositiveInteger(intGroupID) Then
			If user_groupNameExists(strGroupName) and strGroupName <> strOldGroupName Then
				strError = "Group Name already exists."
			Else
				Call user_updateGroup(intGroupID, strGroupName, strDescription)
				strSQL = "UPDATE usd_userGroupMap SET groupName = " & utility_SQLEncode(strGroupname,True) &_
				" WHERE groupName = " & utility_SQLEncode(strOldGroupName, True)
				Call utility_executeCommand(strSQL)
			End If
		Else
			If user_groupNameExists(strGroupName) Then
				strError = "Group Name already exists."
			Else
				Call user_addUserGroup(strGroupName, strDescription)
			End If
		End If
		
		If strError = "" Then
			Response.Redirect("manageGroups.asp")
		End If
	Else
		If utility_isPositiveInteger(intGroupID) Then
			strSQL = "SELECT groupName, description FROM usd_userGroups WHERE groupID = " & intGroupID

			Set rsResults = utility_getRecordset(strSQL)
			If not rsResults.EOF Then
				strGroupName = rsResults("groupName")
				strDescription = rsResults("description")
			End If
			rsResults.Close
			Set rsResults = NOTHING
	
		End If
	End If

	If utility_isPositiveInteger(intGroupID) Then
		strPageHeader = "Group Properties"
		strBreadCrumbEnd = strGroupName
	Else
		strPageHeader = "Add User Group"
		strBreadCrumbEnd = "Add New Group"
	End If
%>	

<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_USERS)%>
	<span class="breadcrumb" align="left">
		<a href="manageGroups.asp">All Groups</a> >>
		<%=strBreadcrumbEnd%></a>
		</span><br /><br />
	<span class="surveyTitle"><%=strPageHeader%><%=common_helpLink("users/manageGroups.asp",SV_SMALL_HELP_IMAGE)%></span><br />
	<span class="message"><%=strError%></span>
	
	<hr noshade color="#C0C0C0" size="2">
		<form method="post" action="editUserGroup.asp?groupID=<%=intGroupID%>">
		<table border="0" cellpadding="0" cellspacing="0" class="normal">
			<tr>
				<td class="normalBold-Big" width="200">
					Group Properties
				</td>
				<td class="normalBold" width="150">
					Group Name
				</td>
				<td>
					<input type="text" name="groupName" value="<%=strGroupName%>" size="50">
				</td>
			</tr>
			<tr>
				<td class="normalBold-Big" width="200">
					&nbsp;
				</td>
				<td class="normalBold" width="150">
					Description
				</td>
				<td>
					<textarea name="description" rows="5" cols="70"><%=strDescription%></textarea>
				</td>
			</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table border="0" cellpadding="0" cellspacing="0" class="normal">
			<tr>
				<td class="normalBold-Big" width="200">
					&nbsp;
				</td>
				<td>
					<input type="hidden" name="submit" value="true">
					<input type="image" src="images/button-submit.gif" alt="Submit"
	<%
		If utility_isPositiveInteger(intGroupID) Then
	%>			
						onclick="javascript:return confirmAction('Are you sure you want to change the group properties?');"
	<%
		End If
	%>					
						
						>
					<input type="hidden" name="oldGroupName" value="<%=strGroupName%>">
				</td>
			</tr>
		</table>
	</form>
	
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

