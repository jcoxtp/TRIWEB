<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		groupPermissions.asp 
' Purpose:	page to manage permissions for groups
'
' Changes:
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
	Dim intUserID
	Dim strSQL
	Dim rsResults
	Dim intUserTypeChosen
	Dim strUsername
	Dim strEmail
	Dim strFirstName
	Dim strLastName
	Dim strTitle
	Dim strCompany
	Dim strLocation
	Dim strDomain
	Dim intLoginType
	Dim strLoginType
	Dim strCustomField1
	Dim strCustomField2
	Dim strCustomField3
	Dim arrAllGroups
	Dim arrUserGroups
	Dim intGroupArraySize
	Dim intArrayLooper
	Dim strGroupName
	Dim strUserGroups
	Dim arrGroupsChosen
	Dim intSurveyID
	Dim intSurveyType
	Dim strCurrentGroups
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = cint(Request.QueryString("surveyID"))

	If ((survey_getOwnerID(intSurveyID) <> intUserID) _
			and intUserType = SV_USER_TYPE_CREATOR) _
			or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	
	
	intSurveyType = survey_getSurveyType(intSurveyID)
%>	
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_USERS)%>
	<span class="normalBold" align="left">
		<span class="breadcrumb" align="left">
	<a href="manageSurveys.asp">All Surveys</a> >>
	<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=survey_getSurveyTitle(intSurveyID)%></a> >>
	<a href="surveySecurity.asp?surveyID=<%=intSurveyID%>">Survey Security</a> >>
	Add Groups
	</span><br /><br />	<p class="surveyTitle">Add Groups<%=common_helpLink("surveys/inviteUsers.asp",SV_SMALL_HELP_IMAGE)%></p>
	<hr noshade color="#C0C0C0" size="2">
<%
	
	If Request.Form("submit") = "true" Then
		strSQL = "DELETE FROM usd_surveyToGroupMap WHERE surveyID = " & intSurveyID
		Call utility_executeCommand(strSQL)
		
		strUserGroups = Request.Form("groupsChosen")
		arrGroupsChosen = split(strUserGroups, ";" )
		intGroupArraySize = Ubound(arrGroupsChosen)
		For intArrayLooper = 0 to intGroupArraySize
			strGroupName = trim(arrGroupsChosen(intArrayLooper))
			If len(strGroupName) > 0 Then
				Call inviteUsers_giveGroupPermission(intSurveyID, strGroupName)
			End If
		Next	

	
		strUserGroups = Request.Form("currentGroups")
		arrGroupsChosen = split(strUserGroups, ";" )
		intGroupArraySize = Ubound(arrGroupsChosen)
		For intArrayLooper = 0 to intGroupArraySize
			strGroupName = trim(arrGroupsChosen(intArrayLooper))
			If len(strGroupName) > 0 Then
				strSQL = "SELECT surveyID FROM usd_surveyToGroupMap WHERE groupName = " & utility_SQLEncode(strGroupName,True) &_
				" AND surveyID = " & intSurveyID
				If utility_checkForRecords(strSQL) = False Then
					Call inviteUsers_removeGroupPermission(intSurveyID, strGroupName)
				End If
			End If
		Next
	
		Response.Redirect("surveySecurity.asp?surveyID=" & intSurveyID & "&message=" & SV_MESSAGE_PERMISSION_GIVEN)
		
	End If

			
		strSQL = "SELECT groupName FROM usd_userGroups WHERE groupname NOT IN(" &_
				 "SELECT groupName FROM usd_surveyToGroupMap WHERE surveyID = " & intSurveyID & ")" &_
				 " ORDER BY groupName "
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then	


		Call user_groupListJavascript()
%>
	<form method="post" action="groupPermissions.asp?surveyID=<%=intSurveyID%>" name="frmUser">
	<table border="0" cellpadding="0" cellspacing="0" class="normal">
			<tr>
				<td class="normalBold-Big" width="200" valign="top">
					User Groups
				</td>
				<td class="normalBold" width="150">
	<table cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="normal">Available User Groups</td>
			<td>&nbsp;</td>
			<td class="normal">Current Groups For This Survey</td>
		</tr>
		<tr>
		<td valign="top">
		<select name="allGroups" size="2" style="WIDTH: 216px; height=300px;">
<%
			arrAllGroups = rsResults.GetRows
			intGroupArraySize = (Ubound(arrAllGroups, 2) - LBound(arrAllGroups, 2)) + 1
			For intArrayLooper = 0 to intGroupArraySize - 1
				strGroupName = arrAllGroups(0,intArrayLooper)
%>
				<option value="<%=strGroupName%>"><%=strGroupName%></option>
<%			
			Next
		
		
%>
		</select>
		</td>
		<td valign="top">
			<input type="submit" value="> " onclick="javascript:moveItemRight();return false;" id=submit2 name=submit2><br />
			<input type="submit" value="< " onclick="javascript:removeItem();return false;" id=submit1 name=submit1><br />
			
		</td>
		<td valign="top">
			<select name="userGroups" size="2" style="WIDTH: 216px; height=300px;">
		</select>
		</td>
		</tr>
		</table></td></tr></table>
				<table>
			<tr>
				<td width="200">
					&nbsp;
				</td>
				<td>
					<input type="hidden" name="currentGroups" value="<%=strCurrentGroups%>">
					<input type="hidden" name="groupsChosen" value="">
					<input type="hidden" name="submit" value="true">
					<input type="image" src="images/button-change.gif" alt="Change"
					onclick="javascript:updateGroups();return confirmAction('Are you sure you want to change these permissions?');" id=image1 name=image1>
				</td>
			</tr>
		</table>
	</form>

<%
	End If
	rsResults.Close
	Set rsResults = NOTHING
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

<%
Function userTypeSelection(intDefaultUserType, intUserID)
%>
		<select name="userType">
			<option  
<%
				If intDefaultUserType = SV_USER_TYPE_TAKE_ONLY Then
%>
					selected 
<%
				End If
%>
					value="<%=SV_USER_TYPE_TAKE_ONLY%>">
				Take Surveys Only
			</option>
			<option 
<%
				If intDefaultUserType = SV_USER_TYPE_CREATOR Then
%>
					selected 
<%
				End If
%>
			value="<%=SV_USER_TYPE_CREATOR%>">
				Take and Create
			</option>
			<option		
<%
				If intDefaultUserType = SV_USER_TYPE_ADMINISTRATOR Then
%>
					selected 
<%
				End If
%>
			value="<%=SV_USER_TYPE_ADMINISTRATOR%>">
				Administrator
			</option>
		</select>
<%
	End Function
%>

