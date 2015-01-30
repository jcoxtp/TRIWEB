<%
'****************************************************
'
' Name:		inviteUsers_inc.asp Server-Side Include
' Purpose:		Provides functions relating to inviting users to take the survey
'****************************************************

'**************************************************************************************
'Name:			inviteUsers_addRestrictedSurveyUser
'
'Purpose:		adds permission for a user to take a survey
'
'Inputs:		intSurveyID - unique ID of survey to give permission for
'				intUserID - unique ID of user to give permission to
'**************************************************************************************
Function inviteUsers_addRestrictedSurveyUser(intSurveyID, intUserID, intPermissionType)
	Dim strSQL
	strSQL = "SELECT distinct(userID) " &_
			 "FROM usd_restrictedSurveyUsers " &_
			 "WHERE surveyID = " & intSurveyID & " AND userID = " & intUserID
	If utility_checkForRecords(strSQL) = False Then
		strSQL = "INSERT INTO usd_restrictedSurveyUsers " &_
				 "(surveyID, userID, invited, isPermitted, permissionType) " &_
				 "VALUES(" & intSurveyID & "," & intUserID & ",0,0," & intPermissionType & ")"
		Call utility_executeCommand(strSQL)
	End If
End Function

Function inviteUsers_setUserPermission(intUserID, intSurveyID, boolIsPermitted, intPermissionType)
	Dim strSQL
	strSQL = "SELECT distinct(userID) " &_
			 "FROM usd_restrictedSurveyUsers " &_
			 "WHERE surveyID = " & intSurveyID & " AND userID = " & intUserID 
	If utility_checkForRecords(strSQL) = False Then
		strSQL = "INSERT INTO usd_restrictedSurveyUsers " &_
				 "(surveyID, userID, invited, isPermitted, permissionType) " &_
				 "VALUES(" & intSurveyID & "," & intUserID & ",0," & abs(cint(boolIsPermitted)) & "," & intPermissionType & ")"
		Call utility_executeCommand(strSQL)
	Else
		If intPermissionType = SV_PERMISSION_TYPE_INDIVIDUAL Then
			
			strSQL = "UPDATE usd_restrictedSurveyUsers SET isPermitted = " & abs(cint(boolIsPermitted)) 
			strSQL = strSQL & ", permissionType = " & SV_PERMISSION_TYPE_INDIVIDUAL 
			strSQL = strSQL & " WHERE surveyID = " & intSurveyID & " AND userID = " & intUserID
		
		End If
		
		Call utility_executeCommand(strSQL)
		
	End If
End Function

'**************************************************************************************
'Name:			inviteUsers_addInvitedEmail
'
'Purpose:		record email invitation in the database
'
'Inputs:		intSurveyID - unique ID of survey 
'			    strEmail - email address invited
'**************************************************************************************
Function inviteUsers_addInvitedEmail(intSurveyID, strEmail, intInvitationID)
	Dim strSQL
	Dim rsResults
	strSQL = "INSERT INTO usd_InvitedList(surveyID, email,responded) " &_
			 "VALUES(" & intSurveyID & "," & utility_SQLEncode(strEmail, True) & ",0)"
	Call utility_executeCommand(strSQL)
	strSQL = "SELECT invitationID FROM usd_invitedList WHERE surveyID = " & intSurveyID &_
			 " AND email = " & utility_SQLEncode(strEmail, True)
	Set rsResults = utility_getRecordset(strSQL)
	intInvitationID = rsResults("invitationID")
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:			inviteUsers_isInvited
'
'Purpose:		returns true if this email address has already been invited to this survey
'
'Inputs:		intSurveyID - unique ID of survey 
'			    strEmail - email address to check
'**************************************************************************************
Function inviteUsers_isInvited(intSurveyID, strEmail)
	Dim strSQL
	strSQL = "SELECT surveyID " &_
			 "FROM usd_InvitedList " &_
			 "WHERE surveyID = " & intSurveyID & " AND email = " & utility_SQLEncode(strEmail, False)
	inviteUsers_isInvited = utility_checkForRecords(strSQL)
End Function

Function inviteUsers_getPermittedCount(intSurveyID)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT userID FROM usd_restrictedSurveyUsers WHERE surveyID = " & intSurveyID
	
	Set rsResults = Server.CreateObject("ADODB.Recordset")
	rsResults.CursorLocation = adUseClient
	rsResults.Open utility_ConvertSQL(strSQL), DB_CONNECTION
	inviteUsers_getPermittedCount = rsResults.RecordCount
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function inviteUsers_getRegisteredRespondentCount(intSurveyID)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT distinct(userID) FROM usd_response WHERE surveyID = " & intSurveyID & " AND completed = 1"  &_
			 " AND userID IN (SELECT userID FROM usd_restrictedSurveyUsers WHERE surveyID = " & intSurveyID & ")"	
	
	Set rsResults = Server.CreateObject("ADODB.Recordset")
	rsResults.CursorLocation = adUseClient
	rsResults.Open utility_ConvertSQL(strSQL), DB_CONNECTION
	inviteUsers_getRegisteredRespondentCount = rsResults.RecordCount
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function inviteUsers_getEmailedCount(intSurveyID)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT surveyID FROM usd_invitedList WHERE surveyID = " & intSurveyID	
	
	Set rsResults = Server.CreateObject("ADODB.Recordset")
	rsResults.CursorLocation = adUseClient
	rsResults.Open utility_ConvertSQL(strSQL), DB_CONNECTION
	inviteUsers_getEmailedCount = rsResults.RecordCount
	rsResults.Close
	Set rsResults = NOTHING


End Function

Function inviteUsers_giveGroupPermission(intSurveyID, strGroupName)
	Dim strSQL
	Dim rsResults
	Dim intUserID
	
	strSQL = "SELECT userID FROM usd_userGroupMap WHERE groupName = " & utility_SQLEncode(strGroupName, True)
	
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF
			intUserID = rsResults("userID")
			
			Call inviteUsers_setUserPermission(intUserID, intSurveyID, True, SV_PERMISSION_TYPE_GROUP)
			
			rsResults.MoveNext
		Loop
	End If
	rsResults.Close
	Set rsResults = NOTHING
	
	strSQL = "INSERT INTO usd_surveyToGroupMap(surveyID, groupName, isPermitted) " &_
			 "VALUES(" & intSurveyID & "," & utility_SQLEncode(strGroupName, True) & ",1)"
	Call utility_executeCommand(strSQL)
	
	strSQL = "SELECT surveyID FROM usd_surveyToGroupMap WHERE groupName = " & utility_SQLEncode(strGroupName,True) &_
				" AND surveyID = " & intSurveyID
	If utility_checkForRecords(strSQL) = False Then
		strSQL = "INSERT INTO usd_surveyToGroupMap(surveyID, groupName, isPermitted) VALUES(" &_
				 intSurveyID & "," & utility_SQLEncode(strGroupName,True) & ",0)"
		Call utility_executeCommand(strSQL)
	End If
	
End Function


Function inviteUsers_removeGroupPermission(intSurveyID, strGroupName)
	Dim strSQL
	Dim rsResults
	Dim intUserID
	
	strSQL = "SELECT userID FROM usd_userGroupMap WHERE groupName = " & utility_SQLEncode(strGroupName, True)
	
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF
			intUserID = rsResults("userID")
			
			Call inviteUsers_removeRestrictedSurveyUser(intSurveyID, intUserID)
			
			rsResults.MoveNext
		Loop
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function


Function inviteUsers_removeRestrictedSurveyUser(intSurveyID, intUserID)
	Dim strSQL
	strSQL = "DELETE usd_restrictedSurveyUsers " &_
			 "WHERE surveyID = " & intSurveyID & " AND userID = " & intUserID
	Call utility_executeCommand(strSQL)
End Function


Function inviteUsers_getInvitedResponseCount(intSurveyID)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT surveyID FROM usd_invitedList WHERE surveyID = " & intSurveyID & " AND responded = 1"	
	
	Set rsResults = Server.CreateObject("ADODB.Recordset")
	rsResults.CursorLocation = adUseClient
	rsResults.Open utility_ConvertSQL(strSQL), DB_CONNECTION
	inviteUsers_getInvitedResponseCount = rsResults.RecordCount
	rsResults.Close
	Set rsResults = NOTHING
	
End Function

Function inviteUsers_isPermitted(intUserID, intSurveyID)
	Dim strSQL
	
	strSQL = "SELECT userID FROM usd_restrictedSurveyUsers WHERE userID = " & intUserID &_
			 " AND surveyID = " & intSurveyID & " AND isPermitted = 1"

	inviteUsers_isPermitted = utility_checkForRecords(strSQL)
End Function

Function inviteUsers_editGroupPermissions(strGroupName, intSurveyID, boolIsPermitted)
	Dim strSQL
	Dim rsResults
	Dim intUserID
	
	strSQL = "SELECT surveyID FROM usd_surveyToGroupMap " &_
			 "WHERE groupName = " & utility_SQLEncode(strGroupName, True) &_
			 " AND surveyID = " & intSurveyID & " AND isPermitted = " & abs(cint(boolIsPermitted))

	If utility_checkForRecords(strSQL) = False Then
		strSQL = "UPDATE usd_surveyToGroupMap SET isPermitted = " & abs(cint(boolIsPermitted)) &_
				 " WHERE groupName = " & utility_SQLEncode(strGroupName, True) & " AND surveyID = " & intSurveyID
		Call utility_executeCommand(strSQL)
	
		strSQL = "UPDATE usd_restrictedSurveyUsers " &_
				 "SET isPermitted = " & abs(cint(boolIsPermitted)) &_
				 " WHERE surveyID = " & intSurveyID &_
				 " AND userID IN (SELECT userID FROM usd_userGroupMap WHERE groupName = " & utility_SQLEncode(strGroupName, True) &_
						" AND permissionType = " & SV_PERMISSION_TYPE_GROUP & ")"
		Call utility_executeCommand(strSQL)
	
		strSQL = "SELECT userID FROM usd_userGroupMap WHERE groupName = " & utility_SQLEncode(strGroupName, True) &_
				 " AND userID NOT IN (SELECT userID FROM usd_restrictedSurveyUsers WHERE surveyID = " & intSurveyID &_
				 " AND permissionType = " & SV_PERMISSION_TYPE_INDIVIDUAL & ")"
		Set rsResults = utility_getRecordset(strSQL)
		
		If not rsResults.EOF Then
			Do until rsResults.EOF
				intUserID = rsResults("userID")
				Call inviteUsers_setUserPermission(intUserID, intSurveyID, boolIsPermitted, SV_PERMISSION_TYPE_GROUP)
				rsResults.MoveNext
			Loop
		End If
		rsResults.Close
		Set rsResults = NOTHING
		
	End If
End Function

Function inviteUsers_updateSurveyPermissions(intUserID, strGroupName)
	Dim strSQL
	Dim rsResults
	Dim intSurveyID
	Dim boolIsPermitted
	
	strSQL = "SELECT surveyID, isPermitted FROM usd_surveyToGroupMap WHERE groupName = " & utility_SQLEncode(strGroupName, True)
	
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF
			intSurveyID = rsResults("surveyID")
			boolIsPermitted = cbool(rsResults("isPermitted"))
			Call inviteUsers_setUserPermission(intUserID, intSurveyID, boolIsPermitted, SV_PERMISSION_TYPE_GROUP)
			
			
			rsResults.MoveNext
		Loop
	End If
	rsResults.Close
	Set rsResults = NOTHING
	
	
End Function
%>




