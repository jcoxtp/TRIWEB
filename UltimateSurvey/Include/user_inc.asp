<%
'**************************************************************************************'
' Name:		user_inc.asp Server-Side Include
' Purpose:		Provides functions relating to the user of the survey application
'
' Date Written:	6/18/2002
' Modified:		
'
' Changes:
'**************************************************************************************

'**************************************************************************************
'Name:			user_usernameTaken
'
'Purpose:       determines if a certain user name is used or not 
'
'Inputs:	    strUsername - user name to check for existence
'
'**************************************************************************************
Function user_usernameTaken(strUsername)
	Dim strSQL
	strSQL = "SELECT userID " &_
			 "FROM usd_surveyUser " &_
			 "WHERE username = " & utility_SQLEncode(strUsername, False) &_
			 " AND loginType = " & SV_LOGIN_TYPE_PASSWORD
	user_usernameTaken = utility_checkForRecords(strSQL)
End Function

Function user_emailExists(strEmail)
	Dim strSQL
	strSQL = "SELECT userID " &_
			 "FROM usd_surveyUser " &_
			 "WHERE email = " & utility_SQLEncode(strEmail, False)
	user_emailExists = utility_checkForRecords(strSQL)
End Function

'**************************************************************************************
'Name:		user_addUser
'
'Purpose:	add a user to the database
'
'Inputs:	strUsername - username of new user
'			strPassword - new user's password
'			intUserType - user type of new user
'			strFirstName - first name of new user (optional)
'		    strLastName - last name of new user (optional)
'			strEmail - email address of new user (optional)
'			strTitle - title of new user (optional)
'			strCompany - company of new user (optional)
'			strLocation - location of new user
'			intLoginType - password vs network
'			strDomainName - network domain for network login users
'
'Outputs:	intUserIDOut - unique ID of the new user
'**************************************************************************************
Function user_addUser(strUsername, strPassword, intUserType, strFirstName, strLastName, _
				strEmail, strTitle, strCompany, strLocation, intLoginType, strDomainName, strCustomField1, strCustomField2, strCustomField3, intUserIDOut)
	Dim strSQL
	Dim rsResults
	strSQL = "INSERT INTO usd_SurveyUser " &_
			 "(username, pword, userType, firstName, lastName, email, title, company, location, loginType, networkDomain, " &_
				"customField1, customField2, customField3) " &_
			 "VALUES (" & utility_SQLEncode(strUsername, True) & "," &_
			 utility_SQLEncode(strPassword, True) & "," &_
			 utility_SQLEncode(intUserType, True) & "," & utility_SQLEncode(strFirstName, True) &_
			 "," & utility_SQLEncode(strLastName, True) & "," & utility_SQLEncode(strEmail, True) &_
			 "," & utility_SQLEncode(strTitle, True) & "," & utility_SQLEncode(strCompany, True) &_
			 "," & utility_SQLEncode(strLocation, True) & "," & intLoginType & "," &_
			 utility_SQLEncode(strDomainName, True) & "," & utility_SQLEncode(strCustomField1, True) & "," & utility_SQLEncode(strCustomField2, True) & "," &_
			 utility_SQLEncode(strCustomField3, True) & ")"

	Call utility_executeCommand(strSQL)
	strSQL = "SELECT userID " &_
			 "FROM usd_SurveyUser " &_
			 "WHERE username = " & utility_SQLEncode(strUsername, False)
	Set rsResults = utility_getRecordset(strSQL)
	intUserIDOut = rsResults("userID")
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:		user_updateUserType
'
'Purpose:	update a particular user's user type
'
'Inputs:	intUserID - unique ID of user to update
'			intUserType - user type to change the user to
'**************************************************************************************
Function user_updateUserType(intUserID, intUserType)
	Dim strSQL
	strSQL = "UPDATE usd_SurveyUser " &_
			 "SET userType = " & intUserType &_
			 " WHERE userID = " & intUserID
	Call utility_executeCommand(strSQL)
End Function

'**************************************************************************************
' Name:        admin_getUserPassword
'
' Purpose:     gets password for user
'
' Inputs:	   intUserID - ID of user to find password for
'**************************************************************************************
Function user_getUserPassword(intUserID)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT pword " &_
			 "FROM usd_SurveyUser " &_
			 "WHERE userID = " & intUserID
	Set rsResults = utility_getRecordset(strSQL)
	user_getUserPassword = rsResults("pword")
	rsResults.Close
	Set rsResults = NOTHING
End Function


'**************************************************************************************
' Name:        user_changeLoginInfo
'
' Purpose:     changes user's password
'
' Inputs:   intUserID - ID of user to change password for
'			   strNewPassword - text of new password
'**************************************************************************************
Function user_changeLoginInfo(intUserID, strUsername, strNewPassword)
	Dim strSQL
	strSQL = "UPDATE usd_SurveyUser " &_
			 "SET username = " & utility_SQLEncode(strUsername, False) & ", " &_
			 "pword = " & utility_SQLEncode(strNewPassword, False) &_
			 " WHERE userID = " & intUserID
	Call utility_executeCommand(strSQL)
End Function

'**************************************************************************************
' Name:        user_getUsername
'
' Purpose:     returns user's username
'
' Inputs:   intUserID - unique ID of user to get username for
'**************************************************************************************
Function user_getUsername(intUserID)
	If utility_isPositiveInteger(intUserID) Then
		Dim strSQL
		Dim rsResults
		strSQL = "SELECT username " &_
				 "FROM usd_SurveyUser " &_
				 "WHERE userID = " & intUserID
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
			user_getUsername = rsResults("username")
		End If
		rsResults.Close
		Set rsResults = NOTHING
	End If
End Function

'**************************************************************************************
' Name:        user_getUserEmail
'
' Purpose:     returns user's email address
'
' Inputs:   intUserID - unique ID of user to get email address for
'**************************************************************************************
Function user_getUserEmail(intUserID)
	If utility_isPositiveInteger(intUserID) Then
		Dim strSQL
		Dim rsResults
		strSQL = "SELECT email " &_
				 "FROM usd_SurveyUser " &_
				 "WHERE userID = " & intUserID
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
			user_getUserEmail = rsResults("email")
		End If
		rsResults.Close
		Set rsResults = NOTHING
	End If
End Function

'**************************************************************************************
' Name:        user_generatePassword
'
' Purpose:     returns a randomly generated password
'
' Inputs:	   none
'**************************************************************************************
Function user_generatePassword()
	Dim intUniquePasswordID
	randomize()
	intUniquePasswordID = cint(rnd(1) * 10) & cint(rnd(1) * 10) & cint(rnd(1) * 10) & cint(rnd(1) * 10)
	user_generatePassword = "survey" & intUniquePasswordID

End Function

'**************************************************************************************
' Name:         user_changeUserInfo
'
' Purpose:      changes user information
'
' Inputs:	    intUserID - unique ID of user to change information for
'				strEmail - email address of user
'				strFirstName - user's first name
'				strLastName - user's last name
'				strTitle - user's title
'				strCompany - user's company
'				strLocation - user's location
'**************************************************************************************
Function user_changeUserInfo(intUserID, strEmail, strFirstName, strLastName, strTitle, strCompany, strLocation, strDomain, strCustomField1, strCustomField2, strCustomField3)
	Dim strSQL
	strSQL = "UPDATE usd_surveyUser " &_
			 "SET email = " & utility_SQLEncode(strEmail, True) &_
			 ",firstName = " & utility_SQLEncode(strFirstName, True) &_
			 ",lastName = " & utility_SQLEncode(strLastName, True) &_
			 ",title = " & utility_SQLEncode(strTitle, True) &_
			 ",company = " & utility_SQLEncode(strcompany, True) &_
			 ",location = " & utility_SQLEncode(strLocation, True) &_
			 ",networkDomain = " & utility_SQLEncode(strDomain, True) &_
			 ",customField1 = " & utility_SQLEncode(strCustomField1, True) &_
			 ",customField2 = " & utility_SQLEncode(strCustomField2, True) &_
			 ",customField3 = " & utility_SQLEncode(strCustomField3, True) &_
			 " WHERE userID = " & intUserID
	Call utility_executeCommand(strSQL)	 
End Function

'**************************************************************************************
' Name:         user_deleteUser
'
' Purpose:      deletes user and sets his/her surveys taken to anonymous
'
' Inputs:	    intUserID - unique ID of user to delete
'**************************************************************************************
Function user_deleteUser(intUserID)
	Dim strSQL
	If utility_isPositiveInteger(intUserID) Then
		strSQL = "UPDATE usd_Response " &_
				 "SET userID = NULL " &_
				 "WHERE userID = " & intUserID
		Call utility_executeCommand(strSQL)	 
	
		strSQL = "DELETE FROM usd_restrictedSurveyUsers " &_
			     "WHERE userID = " & intUserID
		Call utility_executeCommand(strSQL)
		
		strSQL = "DELETE FROM usd_surveyUser " &_
				 "WHERE userID = " & intUserID
		Call utility_executeCommand(strSQL)
	End If 
	
End Function

'**************************************************************************************
' Name:         user_deleteUserResponses
'
' Purpose:      deletes all responses for a certain user
'
' Inputs:	    intUserID - unique ID of user to delete responses 
'**************************************************************************************
Function user_deleteUserResponses(intUserID)
	Dim strSQL
	Dim rsResults
	If utility_isPositiveInteger(intUserID) Then
		strSQL = "SELECT responseID " &_
				 "FROM usd_response " &_
				 "WHERE userID = " & intUserID
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
			Do until rsResults.EOF
				Call response_deleteResponse(rsResults("responseID"))
				rsResults.MoveNext
			Loop
		End If
		rsResults.Close
		Set rsResults = NOTHING
	
		strSQL = "DELETE FROM usd_response " &_
				 "WHERE userID = " & intUserID
		Call utility_executeCommand(strSQL)
	End If
End Function


Function user_hasSurveys(intUserID, intUserType)
	Dim strSQL
	strSQL = "SELECT top 1 surveyID " &_
			 "FROM usd_Survey " 
	If intUserType = SV_USER_TYPE_CREATOR Then
		strSQL = strSQL & "WHERE ownerUserID = " & intUserID &_
						  " OR (privacyLevel <> " & SV_PRIVACY_LEVEL_PRIVATE & " AND isActive = 1)"
	ElseIf intUserType <> SV_USER_TYPE_ADMINISTRATOR Then
		strSQL = strSQL & "WHERE privacyLevel <> " & SV_PRIVACY_LEVEL_PRIVATE &_
						  " AND isActive = 1"
	End If
	user_hasSurveys = utility_checkForRecords(strSQL)
End Function

Function user_networkUserAdded(strUsername, strDomainName)
	Dim strSQL 
	strSQL = "SELECT top 1 userID " &_
			 "FROM usd_surveyUser " &_
			 "WHERE username = " & utility_SQLEncode(strUsername, True) &_
			 " AND loginType = " & SV_LOGIN_TYPE_NETWORK &_
			 " AND networkDomain = " & utility_SQLEncode(strDomainName, True) 
			 
	user_networkUserAdded = utility_checkForRecords(strSQL)
End Function

Function user_loginNetworkUser()
	Dim strAuthUser
	Dim strNetworkUsername
	Dim strDomainName
	Dim intSlashPosition
	Dim strSQL
	Dim rsResults
	Dim strUsername
	
	If Request.Cookies(SV_COOKIE_NAME & "user")("overrideNetwork") <> "true" Then
		strAuthUser = Request.ServerVariables("AUTH_USER")
		If len(trim(strAuthUser)) > 0 Then
			intSlashPosition = instr(1,strAuthUser,"\")
			If utility_isPositiveInteger(intSlashPosition) Then
				strNetworkUsername = replace(mid(strAuthUser, intSlashPosition),"\","") 
				strDomainName = replace(mid(strAuthUser,1,intSlashPosition),"\","")
			Else
				strNetworkUsername = strAuthUser
				strDomainName = ""
			End If
		End If

		strSQL = "SELECT userID, userType " &_
				 "FROM usd_surveyUser " &_
				 "WHERE username = " & utility_SQLEncode(strNetworkUsername, True) &_
				 " AND networkDomain = " & utility_SQLEncode(strDomainName, True) &_
				 " AND loginType = " & SV_LOGIN_TYPE_NETWORK
		Set rsResults = utility_getRecordset(strSQL)
		
		If not rsResults.EOF Then
			Call user_setSessioninfo(rsResults("userID"), rsResults("userType"), strNetworkUserName, SV_LOGIN_TYPE_NETWORK, "False","")
		End If
		rsResults.Close
		Set rsResults = NOTHING
	End If
End Function

'**************************************************************************************
' Name:         user_getsessioninfo
'
' Purpose:      Gets the userid and usertype from the cookie or session
'
' Inputs:	    intUserID, intUserType
'**************************************************************************************
Function user_getSessionInfo(intUserID, intUserType, strUserName, intLoginType, boolOverRideNetwork, boolMustBeLoggedIn)
	Dim boolSetCookie
	Dim strGUID
	Dim strSQL
	Dim rsResults
	
		
			
		If typeName(intUserID) = "String" Then
			boolSetCookie = False
		Else
			boolSetCookie = True	
		End If
			
		If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
			strGUID = Request.cookies(SV_COOKIE_NAME & "userGUID")
		ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then
			strGUID = Session("userGUID")
			'Response.Write strGUID
			'Response.End
		End If
				
		If len(trim(strGUID)) > 0 Then
				
			strSQL = "SELECT userType, userID, userName, loginType " &_
					"FROM usd_surveyUser " &_
					"WHERE userGUID = " & utility_SQLEncode(strGUID, True)
			Set rsResults = utility_getRecordset(strSQL)
			If not rsResults.EOF Then
				intUserType = rsResults("userType")
				intUserID = rsResults("userID")
				strUserName = rsResults("username")
				intLoginType = rsResults("loginType") 	 
			ElseIf SV_PREVENT_CONCURRENT_LOGIN = True Then
				Response.Redirect("index.asp?message=" & SV_MESSAGE_OTHER_USER_LOGGED_IN) 
			End If
			rsResults.Close
			Set rsResults = NOTHING
				
			' Update the cookie's expiration
			If utility_isPositiveInteger(intUserType) and boolSetCookie = True Then 
				If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
					Call utility_setCookieExpiration(SV_COOKIE_NAME & "userGUID",SV_SESSION_TIMEOUT, USD_MINUTES)
				End If
			End If
		End If
		
		If utility_isPositiveInteger(intUserID) Then
			boolOverrideNetwork = True
		Else
			Dim strAuthUser
			Dim intSlashPosition
			Dim strNetworkUsername
			Dim strDomainName
			strAuthUser = Request.ServerVariables("AUTH_USER")
			If len(trim(strAuthUser)) > 0 Then
				intSlashPosition = instr(1,strAuthUser,"\")
				If utility_isPositiveInteger(intSlashPosition) Then
					strNetworkUsername = replace(mid(strAuthUser, intSlashPosition),"\","") 
					strDomainName = replace(mid(strAuthUser,1,intSlashPosition),"\","")
				Else
					strNetworkUsername = strAuthUser
					strDomainName = ""
				End If
			End If

			strSQL = "SELECT userID, userType " &_
					"FROM usd_surveyUser " &_
					"WHERE username = " & utility_SQLEncode(strNetworkUsername, True) &_
					" AND (networkDomain = " & utility_SQLEncode(strDomainName, True) &_
					" OR networkDomain IS NULL) " &_
					" AND loginType = " & SV_LOGIN_TYPE_NETWORK
			Set rsResults = utility_getRecordset(strSQL)
			
			If not rsResults.EOF Then
				intUserID = rsResults("userID")
				intUserType = rsResults("userType")
				strUserName = strNetworkUsername
			End If
			rsResults.Close
			Set rsResults = NOTHING
			boolOverrideNetwork = False
		End If

		If utility_isPositiveInteger(intUserType) Then 
			intUserType = cint(intUserType)
		Else 
			intUserType = ""
		End If
		
		If utility_isPositiveInteger(intUserID) Then 
			intUserID = cint(intUserID)
		Else
			intUserID = 0
			
			If boolMustBeLoggedIn = True Then
				Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION) 
			End If
			
		End If
		
		If utility_isPositiveInteger(intLoginType) Then 
			intLoginType = cint(intLoginType)
		Else
			intLoginType = ""
		End If
		
		
	
End Function

Function user_setSessioninfo(intUserID, intUserType, strUserName, intLoginType, boolOverRideNetwork, strGUID)
	
	If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
	
		Response.Cookies(SV_COOKIE_NAME & "userGUID") = strGUID	

	ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then
		Session("userGUID") = strGUID	
	End If
	
End Function

Function user_clearSessionInfo()

	'If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
	
	
		Response.Cookies(SV_COOKIE_NAME & "userGUID") = ""
		Response.Cookies(SV_COOKIE_NAME & "user")("overrideNetwork") = "False"
	
	'ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then

		Session("userGUID") = ""
		Session("overrideNetwork") = ""
	
	'End If

End Function

Function user_clearSurveySessionInfo(intSurveyID)

	Session("survey" & intSurveyID & "timesTaken") = ""
	Session("survey" & intSurveyID & "responseGUID") = ""
	Session("survey" & intSurveyID & "completedID") = ""
	

End Function 


Function user_getSessionInfoWithoutSettingCookies(intUserID, intUserType, strUserName, intLoginType, boolOverRideNetwork)
	
	
	If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
		Dim strSQL
		Dim strGUID
		Dim rsResults
			
		strGUID = Request.cookies(SV_COOKIE_NAME & "userGUID")
			
		If len(trim(strGUID)) > 0 Then
			
			strSQL = "SELECT userType, userID, userName, loginType " &_
					 "FROM usd_surveyUser " &_
					 "WHERE userGUID = " & utility_SQLEncode(strGUID, True)
			Set rsResults = utility_getRecordset(strSQL)
			If not rsResults.EOF Then
				intUserType = rsResults("userType")
				intUserID = rsResults("userID")
				strUserName = rsResults("username")
				intLoginType = rsResults("loginType") 	 
				boolOverrideNetwork = Request.Cookies(SV_COOKIE_NAME & "user")("overrideNetwork")
			End If
			rsResults.Close
			Set rsResults = NOTHING
					
		End If

		
				
	ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then
		
		intUserType = Session("userType")
		intUserID = Session("userID")
		strUserName = Session("username")
		intLoginType = Session("loginType") 	 
		boolOverrideNetwork = Session("overrideNetwork")
	
	End If

	If utility_isPositiveInteger(intUserType) Then 
		intUserType = cint(intUserType)
	Else 
		intUserType = ""
	End If
	
	If utility_isPositiveInteger(intUserID) Then 
		intUserID = cint(intUserID)
	Else
		intUserID = 0
	End If
	
	If utility_isPositiveInteger(intLoginType) Then 
		intLoginType = cint(intLoginType)
	Else
		intLoginType = ""
	End If
	
	If boolOverrideNetwork <> "" Then 
		boolOverrideNetwork = cbool(boolOverrideNetwork)
	Else 
		boolOverrideNetwork = ""
	End If

	
End Function


Function user_getGroupUserCount(strGroupName)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT userID FROM usd_userGroupMap WHERE groupName = " & utility_SQLEncode(strGroupName,True)
	
	Set rsResults = Server.CreateObject("ADODB.Recordset")
	'set up record set for paging
	rsResults.CursorLocation = adUseClient
	rsResults.Open utility_ConvertSQL(strSQL), DB_CONNECTION
	user_getGroupUserCount = rsResults.RecordCount
	
	rsResults.Close
	Set rsResults = NOTHING
	
End Function

Function user_updateGroup(intGroupID, strGroupName, strDescription)
	Dim strSQL
	
	strSQL = "UPDATE usd_userGroups " &_
			 "SET groupName = " & utility_SQLEncode(strGroupName, True) &_
			 ",description = " & utility_SQLEncode(strDescription, True) &_
			 " WHERE groupID = " & intGroupID
	
	Call utility_executeCommand(strSQL)
End Function

Function user_addUserGroup(strGroupName, strDescription)
	Dim strSQL
	
	strSQL = "INSERT INTO usd_userGroups " &_
			 "(groupName,description) VALUES(" &_
			 utility_SQLEncode(strGroupName, True) & "," & utility_SQLEncode(strDescription, True) & ")"
	
	Call utility_executeCommand(strSQL)


End Function

Function user_groupNameExists(strGroupName)
	Dim strSQL
	
	strSQL = "SELECT groupID FROM usd_userGroups WHERE groupName = " & utility_SQLEncode(strGroupName, True)
	
	user_groupNameExists = utility_checkForRecords(strSQL)
End Function

Function user_addUserToGroup(strGroupName, intUserID)
	Dim strSQL
	
	strSQL = "SELECT userID FROM usd_userGroupMap WHERE userID = " & intUserID & " AND groupName = " & utility_SQLEncode(strGroupName, True)
	
	If utility_checkForRecords(strSQL) = False Then
	
		strSQL = "INSERT INTO usd_userGroupMap(groupName, userID) VALUES(" & utility_SQLEncode(strGroupName, True) & "," & intUserID & ")"
	
		Call utility_executeCommand(strSQL)
	End If
End Function

Function user_groupsExist()
	Dim strSQL
	
	strSQL = "SELECT top 1 groupID FROM usd_userGroups"

	user_groupsExist = utility_checkForRecords(strSQL)
End Function


Function user_getUserCount()
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT userID FROM usd_surveyUser"	
	
	Set rsResults = Server.CreateObject("ADODB.Recordset")
	rsResults.CursorLocation = adUseClient
	rsResults.Open utility_ConvertSQL(strSQL), DB_CONNECTION
	user_getUserCount = rsResults.RecordCount
	rsResults.Close
	Set rsResults = NOTHING
	
End Function

Function user_getListCount(strListName)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT email FROM usd_emailListDetails WHERE listName = " & utility_SQLEncode(strListName, True)
	
	Set rsResults = Server.CreateObject("ADODB.Recordset")
	rsResults.CursorLocation = adUseClient
	rsResults.Open utility_ConvertSQL(strSQL), DB_CONNECTION
	user_getListCount = rsResults.RecordCount
	rsResults.Close
	Set rsResults = NOTHING

End Function

Function user_listNameExists(strListName)
	Dim strSQL
	
	strSQL = "SELECT listID FROM usd_emailLists WHERE listName = " & utility_SQLEncode(strListName, True)
	
	user_listNameExists = utility_checkForRecords(strSQL)
End Function

Function user_updateList(intListID, strListName, strDescription)
	Dim strSQL
	
	strSQL = "UPDATE usd_emailLists " &_
			 "SET listName = " & utility_SQLEncode(strListName, True) &_
			 ",description = " & utility_SQLEncode(strDescription, True) &_
			 " WHERE listID = " & intListID
	
	Call utility_executeCommand(strSQL)
	
End Function

Function user_addEmailList(strListName, strDescription)
	Dim strSQL
	
	strSQL = "INSERT INTO usd_emailLists " &_
			 "(listName,description) VALUES(" &_
			 utility_SQLEncode(strListName, True) & "," & utility_SQLEncode(strDescription, True) & ")"
	
	Call utility_executeCommand(strSQL)


End Function

Function user_getEmailListName(intListID)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT listName FROM usd_emailLists WHERE listID = " & intListID
	
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		user_getEmailListName = rsResults("listName")
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function user_getGroupName(intGroupID)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT groupName	FROM usd_userGroups WHERE groupID = " & intGroupID
	
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		user_getGroupName = rsResults("groupName")
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function user_removeUserFromGroup(strGroupName, intUserID)
	Dim strSQL
	Dim rsResults
	Dim intSurveyID
	
	strSQL = "DELETE FROM usd_userGroupMap WHERE groupName = " & utility_SQLEncode(strGroupName, True) &_
			 " AND userID = " & intUserID
	Call utility_executeCommand(strSQL)
	
	strSQL = "DELETE FROM usd_restrictedSurveyUsers WHERE userID = " & intUserID &_
			 " AND permissionType = " & SV_PERMISSION_TYPE_GROUP &_
			 " AND userID NOT IN(SELECT userID FROM usd_userGroupMap)"
	Call utility_executeCommand(strSQL)
	
End Function

Function user_groupListJavascript()
%>


<script language="javascript">
function moveItemRight()
{
var group = frmUser.allGroups.value;
var deleteGroup = frmUser.allGroups.selectedIndex;
if (group != '')
{
frmUser.userGroups.options[frmUser.userGroups.options.length] = new Option(group,group);
if (deleteGroup != "-1")
{
frmUser.allGroups.options.remove(deleteGroup);
}
}
}

function moveAllRight()
{
var currentValue;

for (var i = 0; i < frmUser.allGroups.length; i++)
{
currentValue = frmUser.allGroups.options[i].value;
frmUser.userGroups.options[i] = new Option(currentValue,currentValue);
}
frmUser.allGroups.options.length = 0;
}

function removeItem()
{
 var deleteItem = frmUser.userGroups.selectedIndex;
 var group = frmUser.userGroups.value;
 if (deleteItem != "-1")
 {
 frmUser.userGroups.options.remove(deleteItem);
 frmUser.allGroups.options[frmUser.allGroups.options.length] = new Option(group,group);
 }
}

function removeAll()
{
for (var i = 0; i < frmUser.userGroups.length; i++)
{
currentValue = frmUser.userGroups.options[i].value;
frmUser.allGroups.options[i] = new Option(currentValue,currentValue);
}
frmUser.userGroups.options.length = 0;
}

function updateGroups()
{
 if (frmUser.userGroups)
  {
  var groups = "";
  for (var i = 0; i < frmUser.userGroups.length; i++)
  {
	groups = groups + frmUser.userGroups.options[i].value + ";"
  }
  frmUser.groupsChosen.value = groups;
  }
 }
</script>
<%
End Function
%>