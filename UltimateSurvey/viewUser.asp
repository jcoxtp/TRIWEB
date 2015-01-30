<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		viewUser.asp 
' Purpose:	page to view and edit the details of a certain user
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
	Dim strPassword
	
	Call user_loginNetworkUser()

	'Get the user info out of the session or cookie
	Call user_getSessionInfo("", intUserType, "","", "",True)

	If intUserType <> SV_USER_TYPE_ADMINISTRATOR Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If
%>	
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_USERS)%>
<%


	

	intUserID = cint(Request.QueryString("userID"))
	
	If Request.Form("submit") = "Change" Then
		intUserTypeChosen = Request.Form("userType")
		Call user_updateUserType(intUserID, intUserTypeChosen)
		strPassword = Request.Form("password")
		strEmail = Request.Form("email")
		strFirstName = Request.Form("firstName")
		strLastName = Request.Form("lastName")
		strTitle = Request.Form("title")
		strCompany = Request.Form("company")
		strLocation = Request.Form("location")
		strDomain = Request.Form("domain")
		strCustomField1 = Request.Form("customField1")
		strCustomField2 = Request.Form("customField2")
		strCustomField3 = Request.Form("customField3")
		strUserGroups = Request.Form("groupsChosen")
		strUsername = Request.Form("username")
		
		Call user_changeLoginInfo(intUserID, strUsername, strPassword)
		Call user_changeUserInfo(intUserID, strEmail, strFirstName, strLastName, strTitle, strCompany, strLocation, strDomain, strCustomField1, strCustomField2, strCustomField3)
	
		strSQL = "DELETE FROM usd_userGroupMap WHERE userID = " & intUserID
		Call utility_executeCommand(strSQL)
	
		
	
		arrGroupsChosen = split(strUserGroups, ";" )
		intGroupArraySize = Ubound(arrGroupsChosen)
		For intArrayLooper = 0 to intGroupArraySize
			strGroupName = trim(arrGroupsChosen(intArrayLooper))
			If len(strGroupName) > 0 Then
				strSQL = "INSERT INTO usd_userGroupMap(userID, groupName) " &_
						 "VALUES(" & intUserID & "," & utility_SQLEncode(strGroupName, True) & ")"
				Call utility_executeCommand(strSQL)
				Call inviteUsers_updateSurveyPermissions(intUserID, strGroupName)
			End If
		Next	
	
		
	
		Response.Redirect("manageUsers.asp?message=" & SV_MESSAGE_USER_TYPE_EDITED)
		
	Else
		strSQL = "SELECT username, networkDomain, pword, userType, email, firstName, lastName, title, company, location, loginType, customField1, customField2, customField3 " &_
			 "FROM usd_SurveyUser " &_
			 "WHERE userID = " & intUserID
		Set rsResults = utility_getRecordset(strSQL)
		strUsername = rsResults("username")
		strDomain = rsResults("networkDomain")
		strPassword = rsResults("pword")
		intUserType = rsResults("userType")
		strEmail = rsResults("email")
		strFirstName = rsResults("firstName")
		strLastName = rsResults("lastName")
		strTitle = rsResults("title")
		strCompany = rsResults("company")
		strLocation = rsResults("location")
		intLoginType = rsResults("loginType")
		
		strCustomField1 = rsResults("customField1")
		strCustomField2 = rsResults("customField2")
		strCustomField3 = rsResults("customField3")
		
		If intLoginType = SV_LOGIN_TYPE_PASSWORD Then
			strLoginType = "Username/Password"
		Else
			strLoginType = "Network"
		End If
	End If

	If not rsResults.EOF Then
%> 
		<span class="breadcrumb" align="left">
		<a href="manageUsers.asp">All Users</a> >>
		<%=strUsername%></a>
		</span><br /><br />
		<span class="surveyTitle">User Details</span>
		<hr noshade color="#C0C0C0" size="2">
		<form method="post" action="viewUser.asp?userID=<%=intUserID%>" name="frmUser">
		<table border="0" cellpadding="0" cellspacing="0" class="normal">
			<tr>
				<td class="normalBold-Big" width="200">
					User Information
				</td>
				
				<td class="normalBold" width="150">
					Username
				</td>
				<td>
					<%=strUsername%>
				</td>
			</tr>
			<tr>
				<td class="normalBold-Big" width="200">
					&nbsp;
				</td>
				<td class="normalBold" width="150">
					Login Type
				</td>
				<td>
					<%=strLoginType%>
				</td>
				
			</tr>
			<tr>
				<td class="normalBold-Big" width="200">
					&nbsp;
				</td>
				
				<td class="normalBold" width="150">
					Password
				</td>
				<td>
					<input type="text" name="password" value="<%=strPassword%>">
				</td>
			</tr>
<%
		If intLoginType = SV_LOGIN_TYPE_NETWORK Then
%>
			<tr>
				<td>
					&nbsp;
				</td>
				<td class="normalBold" width="150">
					Domain
				</td>
				<td>
					<input type="text" name="domain" value="<%=strDomain%>">	
				</td>
			</tr>
<%
		End If
%>
			<tr>
				<td>
					&nbsp;
				</td>
				<td class="normalBold" width="150">
					User Type
				</td>
				<td>
					<%=userTypeSelection(intUserType, intUserID)%>	
				</td>
			</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table border="0" cellpadding="0" cellspacing="0" class="normal">
			<tr>
				<td class="normalBold-Big" width="200">
					Contact Information
				</td>
				<td class="normalBold" width="150">
					Email
				</td>
				<td>
					<input type="text" name="email" value="<%=strEmail%>" size="30">	
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td class="normalBold" width="150">
					First Name
				</td>
				<td>
					<input type="text" name="firstName" value="<%=strFirstName%>" size="30">	
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td class="normalBold" width="150">
					Last Name
				</td>
				<td>
					<input type="text" name="lastName" value="<%=strLastName%>" size="30">	
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td class="normalBold" width="150">
					Title
				</td>
				<td>
					<input type="text" name="title" value="<%=strTitle%>" size="30">	
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td class="normalBold" width="150">
					Company
				</td>
				<td>
					<input type="text" name="company" value="<%=strCompany%>" size="30">	
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td class="normalBold" width="150">
					Location
				</td>
				<td>
					<input type="text" name="location" value="<%=strLocation%>" size="30">	
				</td>
			</tr>
<%
			If len(SV_CUSTOM_USER_FIELD_1) > 0 Then
%>
				<tr>
					<td>
						&nbsp;
					</td>
					<td class="normalBold" width="150">
						<%=SV_CUSTOM_USER_FIELD_1%>
					</td>
					<td>
						<input type="text" name="customField1" value="<%=strCustomField1%>" size="30">	
					</td>
				</tr>

<%
			End If

			If len(SV_CUSTOM_USER_FIELD_2) > 0 Then
%>
				<tr>
					<td>
						&nbsp;
					</td>
					<td class="normalBold" width="150">
						<%=SV_CUSTOM_USER_FIELD_2%>
					</td>
					<td>
						<input type="text" name="customField2" value="<%=strCustomField2%>" size="30">	
					</td>
				</tr>

<%
			End If

			If len(SV_CUSTOM_USER_FIELD_3) > 0 Then
%>
				<tr>
					<td>
						&nbsp;
					</td>
					<td class="normalBold" width="150">
						<%=SV_CUSTOM_USER_FIELD_3%>
					</td>
					<td>
						<input type="text" name="customField3" value="<%=strCustomField3%>" size="30">	
					</td>
				</tr>

<%
			End If
		rsResults.Close
%>


		</table>	
		<hr noshade color="#C0C0C0" size="2">

<%
	If user_groupsExist = True Then
		Call user_groupListJavascript()
%>
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
			<td class="normal">Current Groups For This User</td>
		</tr>
		<tr>
		<td valign="top">
		<select name="allGroups" size="2" style="WIDTH: 216px; height=300px;">
<%
			
		strSQL = "SELECT groupName FROM usd_userGroups WHERE groupname NOT IN(" &_
				 "SELECT groupName FROM usd_userGroupMap WHERE userID = " & intUserID & ")" &_
				 " ORDER BY groupName "
		rsResults.Open strSQL, DB_CONNECTION
		If not rsResults.EOF Then	
			arrAllGroups = rsResults.GetRows
			intGroupArraySize = (Ubound(arrAllGroups, 2) - LBound(arrAllGroups, 2)) + 1
			For intArrayLooper = 0 to intGroupArraySize - 1
				strGroupName = arrAllGroups(0,intArrayLooper)
%>
				<option value="<%=strGroupName%>"><%=strGroupName%></option>
<%			
			Next
		End If
		rsResults.Close
%>
		</select>
		</td>
		<td valign="top">
			<input type="submit" value="> " onclick="javascript:moveItemRight();return false;" id=submit2 name=submit2><br />
			<input type="submit" value="< " onclick="javascript:removeItem();return false;" id=submit1 name=submit1><br />
			
		</td>
		<td valign="top">
			<select name="userGroups" size="2" style="WIDTH: 216px; height=300px;">
<%
			
		strSQL = "SELECT groupName FROM usd_userGroupMap WHERE userID = " & intUserID &_
				 " ORDER BY groupName"

		rsResults.Open strSQL, DB_CONNECTION
		If not rsResults.EOF Then	
			arrUserGroups = rsResults.GetRows
			intGroupArraySize = (Ubound(arrUserGroups, 2) - LBound(arrUserGroups, 2)) + 1
			For intArrayLooper = 0 to intGroupArraySize - 1
				strGroupName = arrUserGroups(0,intArrayLooper)
%>
				<option value="<%=strGroupName%>"><%=strGroupName%></option>
<%			
			Next
		End If
		rsResults.Close
%>
		</select>
		</td>
		</tr>
		</table></td></tr></table>
<%
	End If
%>
		<table>
			<tr>
				<td width="200">
					&nbsp;
				</td>
				<td>
					<input type="hidden" name="groupsChosen" value="">
					<input type="hidden" name="submit" value="Change">
					<input type="hidden" name="username" value="<%=strUsername%>">
					<input type="image" src="images/button-change.gif" alt="Change"
					onclick="javascript:
<%
	If user_groupsExist Then
%>
	updateGroups();
<%
	End If
%>return confirmAction('Are you sure you want to edit this user?');">
				</td>
			</tr>
		</table>
	</form>
<%
	End If

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

