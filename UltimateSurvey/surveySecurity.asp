<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
Server.ScriptTimeout = 6000

%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/inviteUsers_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim intUserType
	Dim intUserID
	Dim strSQL
	Dim rsResults
	Dim intSurveyID
	Dim boolIsActive
	Dim intCounter
	Dim strSurveyTitle
	Dim intSurveyType
	Dim strGroupName
	Dim strUsername
	Dim boolIsPermitted
	Dim intNumberGroups
	Dim intNumberUsers
	Dim intUserFoundID
	Dim strRemoveGroup
	Dim intRemoveUserID
	Dim strMessage
	Dim intMessage
	Dim intRowCounter
	Dim strOrderByDirection
		
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = cint(Request.QueryString("surveyID"))

	If not utility_isPositiveInteger(intUserID) Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	Else
		If ((survey_getOwnerID(intSurveyID) <> intUserID) _
				and intUserType = SV_USER_TYPE_CREATOR) _
				or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
			Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
		End If
	End If
	
	If request.Form("updateType") = "true" Then
		intSurveyType = Request.Form("surveyType")
		strSQL = "UPDATE usd_survey SET surveyType = " & intSurveyType & " WHERE surveyID = " & intSurveyID
		Call utility_executeCommand(strSQL)
		intSurveyType = cint(intSurveyType)
	Else
		intSurveyType = survey_getSurveyType(intSurveyID)
	End If
	
	
	
	If request.Form("submitted") = "true" Then
		If intSurveyType = SV_SURVEY_TYPE_RESTRICTED Then
			intNumberGroups = Request.Form("numberGroups")
			If utility_isPositiveInteger(intNumberGroups) Then
				For intCounter = 1 to cint(intNumberGroups)
					strGroupName = Request.Form("group" & intCounter)
					If Request.Form("permission" & intCounter) = "allowed" Then
						boolIsPermitted = True
					Else
						boolIsPermitted = False
					End If
				
					Call inviteUsers_editGroupPermissions(strGroupName, intSurveyID, boolIsPermitted)
					strMessage = "Permissions updated."
				Next
			End If
			
			intNumberUsers = Request.Form("numberUsers")
			If utility_isPositiveInteger(intNumberUsers) Then
				For intCounter = 1 to cint(intNumberUsers) 
					intUserFoundID = Request.Form("user" & intCounter)
					
					If Request.Form("userPermission" & intCounter) = "allowed" Then
						boolIsPermitted = True
					Else
						boolIsPermitted = False
					End If
					
					Call inviteUsers_setUserPermission(intUserFoundID, intSurveyID, boolIsPermitted, SV_PERMISSION_TYPE_INDIVIDUAL)
					strMessage = "Permissions updated."
				Next
			End If
			
		End If

	End If
	
	strOrderByDirection = Request.QueryString("orderByDirection")
	
	strRemoveGroup = Request.QueryString("removeGroup")
	If len(strRemoveGroup) > 0 Then
		strSQL = "DELETE FROM usd_surveyToGroupMap WHERE surveyID = " & intSurveyID & " AND groupName = " & utility_SQLEncode(strRemoveGroup, True)
		Call utility_executeCommand(strSQL)
		strMessage = "Group removed."
	End If
	
	intRemoveUserID = Request.QueryString("removeUser") 
	If utility_isPositiveInteger(intRemoveUserID) Then
		strSQL = "DELETE FROM usd_restrictedSurveyUsers WHERE userID = " & intRemoveUserID & " AND surveyID = " & intSurveyID
		Call utility_executeCommand(strSQL)
		strMessage = "User removed."
	End If
	
	intMessage = Request.QueryString("message")
	If utility_isPositiveInteger(intMessage) Then
		Select Case cint(intMessage)
			Case SV_MESSAGE_PERMISSION_GIVEN
				strMessage = "Group permission given."
		End Select
	End If
	
%>
	<%=header_htmlTop("white","")%>
	<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
	<span class="normalBold" align="left">
		<span class="breadcrumb" align="left">
	<a href="manageSurveys.asp">All Surveys</a> >>
	<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=survey_getSurveyTitle(intSurveyID)%></a> >>
	Survey Security
	</span><br /><br />
	
	<span class="surveyTitle">Survey Security<%=common_helpLink("surveys/inviteUsers.asp",SV_SMALL_HELP_IMAGE)%></span>
<%	
	If len(strMessage) > 0 Then
%>	
		<br /><span class="message"><%=strMessage%></span>
<%
	End If
%>
	<hr noshade color="#C0C0C0" size="2">
	<form method="post" action="surveySecurity.asp?surveyID=<%=intSurveyID%>" name="frmSecurity">
	<table class="normal">
		<tr>
			<td class="normalBold-Big" width="150" valign="top">
				Survey Type
			</td>
			<td valign="top">
					<input type="radio" name="surveyType" value="<%=SV_SURVEY_TYPE_PUBLIC%>"
<%
						If intSurveyType = SV_SURVEY_TYPE_PUBLIC Then
%>
							checked
<%
						End If
%>
						>
					</input>
					<span class="normalBold"><%=survey_getSurveyTypeText(SV_SURVEY_TYPE_PUBLIC)%></span>
					- Allow anyone with access to the URL to take the survey
					<br />
					
					<input type="radio" name="surveyType" value="<%=SV_SURVEY_TYPE_REGISTERED_ONLY%>"
<%
							If intSurveyType = SV_SURVEY_TYPE_REGISTERED_ONLY Then
%>
								checked
<%
							End If
%>
						></input>
						<span class="normalBold"><%=survey_getSurveyTypeText(SV_SURVEY_TYPE_REGISTERED_ONLY)%></span>
						- Allow all users in the system to take the survey
						<br />
							
						<input type="radio" name="surveyType" value="<%=SV_SURVEY_TYPE_RESTRICTED%>"
<%
							If intSurveyType = SV_SURVEY_TYPE_RESTRICTED Then
%>
								checked
<%
							End If
%>
							></input>

							<span class="normalBold"><%=survey_getSurveyTypeText(SV_SURVEY_TYPE_RESTRICTED)%></span>
							- Allow only users and groups with permission to take the survey
						
			</td>
		</tr>
		<tr><td>&nbsp;</td>
		<td><input type="hidden" name="updateType" value="true" ID="Hidden1">
		<input type="image" src="images/button-update.gif" alt="Update" border="0"
			onclick="javascript:return confirmAction('Are you sure you want to update the security of this survey?');" ID="Image1" NAME="Image1">
		</td></tr></table></form>
<%
	If intSurveyType = SV_SURVEY_TYPE_RESTRICTED Then
%>
		<form method="post" action="surveySecurity.asp?surveyID=<%=intSurveyID%>" name="frmSecurity" ID="Form1">
		<hr noshade color="#C0C0C0" size="2">
		<table border="0" width="100%"><tr><td width="150" class="normalBold-Big" valign="top">
			Access List</td><td valign="top">
			<span  class="navlinks"><a href="individualPermissions.asp?surveyID=<%=intSurveyID%>">
				<img src="images/button-addUsers.gif" alt="Add Users" border="0" width="125" height="17"></a></span>
<%		
			strSQL = "SELECT groupName FROM usd_userGroups WHERE groupname NOT IN(" &_
				 "SELECT groupName FROM usd_surveyToGroupMap WHERE surveyID = " & intSurveyID & ")"	

			If utility_checkForRecords(strSQL) = True Then
%>
	
				<span  class="navlinks"><a href="groupPermissions.asp?surveyID=<%=intSurveyID%>">
					<img src="images/button-addGroups.gif" alt="Add Groups" border="0" width="125" height="17"></a></span><br /><br />
<%
			End If
%>
		</td></tr><tr><td colspan="2">
		<table border="1" cellpadding="2" bordercolor="#CCCCCC" cellspacing="0" width="100%" ID="Table1">
				<tr bgcolor="black" class="tableHeader">
					<td valign="middle" class="gridheader" width="25">
						Allow
					</td>
					<td valign="middle" class="gridheader" width="25">
						Deny
					</td>
					<td valign="middle" class="gridheader">
						&nbsp;
					</td>
					<td valign="middle" class="gridheader">
						<%=common_orderByLinks("Name","username", strOrderByDirection,"surveySecurity.asp?surveyID=" & intSurveyID,"username")%>
					</td>
					<td valign="middle" class="gridheader" width="70" align="center">
						Actions
					</td>
				</tr>
		
	
<%

		strSQL = "SELECT groupName, isPermitted FROM usd_surveyToGroupMap WHERE surveyID = " & intSurveyID &_
				 " ORDER BY groupName " & strOrderByDirection 
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
			intCounter = 0
			Do until rsResults.EOF
				strGroupName = rsResults("groupName")
				boolIsPermitted = cbool(rsResults("isPermitted"))
				intCounter = intCounter + 1
				intRowCounter = intRowCounter + 1
%>
			<%=common_tableRow(intRowCounter)%>
				
				<td class="griddata">
					<input type="radio" name="permission<%=intCounter%>" value="allowed"
<%
					If boolIsPermitted = True Then
%>
						checked
<%
					End If
%>
					>
				</td>
				<td class="griddata">
				 <input type="radio" name="permission<%=intCounter%>" value="denied"
<%
					If boolIsPermitted = False Then
%>
						checked
<%
					End If
%>
					>
					<input type="hidden" name="group<%=intCounter%>" value="<%=strGroupName%>">
				</td>
				<td valign="middle" class="griddata">
					Group
				</td>
				<td valign="middle" class="griddata">
					<%=strGroupName%>
				</td>
				<td valign="middle" class="griddata" align="center">
					<a href="surveySecurity.asp?removeGroup=<%=strGroupName%>&surveyID=<%=intSurveyID%>">
						<img src="images/button-remove.gif" alt="remove" border="0" width="65" height="17"></a>
				</td>
			</tr>
<%
				rsResults.MoveNext
			Loop
		End If
		
		rsResults.Close
		Set rsResults = NOTHING
%>
		<input type="hidden" name="numberGroups" value="<%=intCounter%>">
<%		
		
		intCounter = 0
		strSQL = "SELECT RSU.userID, U.username, RSU.isPermitted " &_
				 "FROM usd_restrictedSurveyUsers RSU, usd_surveyUser U " &_
				 "WHERE RSU.userID = U.userID " &_
				 "AND RSU.surveyID = " & intSurveyID &_
				 " AND RSU.permissionType = " & SV_PERMISSION_TYPE_INDIVIDUAL &_
				 " ORDER BY U.username " & strOrderByDirection
				 
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
			
			Do until rsResults.EOF
				intUserFoundID = rsResults("userID")
				strUserName = rsResults("userName")
				boolIsPermitted = cbool(rsResults("isPermitted"))
				intCounter = intCounter + 1
				intRowCounter = intRowCounter + 1
%>			
				<%=common_tableRow(intRowCounter)%>
				<td class="griddata">
					<input type="radio" name="userPermission<%=intCounter%>" value="allowed"
<%
					If boolIsPermitted = True Then
%>
						checked
<%
					End If
%>
					>
				</td>
				<td class="griddata">
					<input type="radio" name="userPermission<%=intCounter%>" value="denied"
<%
					If boolIsPermitted = False Then
%>
						checked
<%
					End If
%>
					>
					<input type="hidden" name="user<%=intCounter%>" value="<%=intUserFoundID%>">
				</td>
				<td valign="middle" class="griddata">
					User
				</td>
				<td valign="middle" class="griddata">
					<%=strUserName%>
				</td>
				<td>
					<a href="surveySecurity.asp?removeUser=<%=intUserFoundID%>&surveyID=<%=intSurveyID%>"
						onclick="javascript:return confirmAction('Are you sure you want to remove this user from the permission list?');">
						<img src="images/button-remove.gif" alt="Remove" border="0" width="65" height="17"></a>
				</td>
				</tr>
<%
				rsResults.MoveNext
			Loop
		End If
%>
		</table>
		<input type="hidden" name="numberUsers" value="<%=intCounter%>"></td></tr></table>
				<hr noshade color="#C0C0C0" size="2">
		<table ID="Table2"><tr><td>&nbsp;</td>
		<td><input type="hidden" name="submitted" value="true" ID="Hidden2">
		<input type="image" src="images/button-update.gif" alt="Update" border="0"
			onclick="javascript:return confirmAction('Are you sure you want to update the security of this survey?');" ID="Image2" NAME="Image2">
		</td></tr></table></form>
<%
	End If
%>	

	
	<!--#INCLUDE FILE="Include/footer_inc.asp"-->
