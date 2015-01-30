<%
'****************************************************
'
' Name:		survey_inc.asp Server-Side Include
' Purpose:		Provides functions relating to surveys in general
'
' Date Written:	6/18/2002
'****************************************************


'**************************************************************************************
'Name:			survey_getSurveyTypeText
'
'Purpose:		get text name of integer value of survey type
'
'Inputs:		intSurveyType - integer of survey type
'**************************************************************************************
Function survey_getSurveyTypeText(intSurveyType)
	Select Case intSurveyType
		Case SV_SURVEY_TYPE_PUBLIC
			survey_getSurveyTypeText = "Public"
		Case SV_SURVEY_TYPE_REGISTERED_ONLY
			survey_getSurveyTypeText = "Registed Users Only"
		Case SV_SURVEY_TYPE_RESTRICTED 
			survey_getSurveyTypeText = "Restricted"
	End Select
End Function

'**************************************************************************************
'Name:			survey_getOwnerID
'
'Purpose:		get the ID of the owner of the survey
'
'Inputs:		intSurveyID - unique ID of the survey
'**************************************************************************************
Function survey_getOwnerID(intSurveyID)
	Dim strSQL
	Dim rsResults
	If utility_isPositiveInteger(intSurveyID) Then
		strSQL = "SELECT ownerUserID " &_
				 "FROM usd_Survey " &_
				 "WHERE surveyID = " & intSurveyID
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
			survey_getOwnerID = rsResults("ownerUserID")
		Else
			survey_getOwnerID = 0
		End If
		rsResults.Close
		Set rsResults = NOTHING
	Else
		survey_getOwnerID = 0
	End If
End Function

'**************************************************************************************
'Name:			survey_questionsDropdown
'
'Purpose:		show dropdown of all items for a survey that are questions, as opposed
'				to static items
'
'Inputs:		intSurveyID - survey to get questions for
'				intItemID - item ID of item not to show (optional)
'				intPageID - page ID of page not to show (optional)
'				strFormName - name of form dropdown is in
'				strSelectName - HTML name of select
'				
'Outputs:		boolQuestionsExistOut - whether or not questions exist and were added to dropdown
'**************************************************************************************
Function survey_questionsDropdown(intSurveyID, intItemID, intPageID, strFormName, strSelectName, boolQuestionsExistOut, intDefaultItemID)
	Dim strSQL
	Dim rsResults
	Dim strJavaScript
	Dim intItemFoundID
	Dim strItemText
	strSQL = "SELECT itemID, itemText " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemType " &_
			 "In(" & SV_ITEM_TYPE_TEXTAREA & "," &_
					SV_ITEM_TYPE_SINGLE_LINE & "," &_
					SV_ITEM_TYPE_DATE & "," &_
					SV_ITEM_TYPE_CHECKBOXES & "," &_
					SV_ITEM_TYPE_RADIO & "," &_
					SV_ITEM_TYPE_DROPDOWN & "," &_
					SV_HIDDEN_FIELD_TYPE_QUERYSTRING & "," &_
					SV_HIDDEN_FIELD_TYPE_COOKIE & "," &_
					SV_HIDDEN_FIELD_TYPE_SESSION & ")" &_
			 " AND surveyID = " & intSurveyID 

	If utility_isPositiveInteger(intItemID) Then
		strSQL = strSQL & " AND itemID <> " & intItemID 
	End If
	If utility_isPositiveInteger(intPageID) Then
		strSQL = strSQL & " AND pageID < " & intPageID 
	End If
				 			 
	Set rsResults = utility_getRecordset(strSQL)
	If rsResults.EOF Then
		boolQuestionsExistOut = False
	Else
		boolQuestionsExistOut = True
%>
		<select name="<%=strSelectName%>" 
			onchange="javascript:updateAnswers(document.<%=strFormName%>.<%=strSelectName%>.value);">
			<option value="">Select a Question</option>
<%
		Do until rsResults.EOF
			intItemFoundID = rsResults("itemID")
			strItemText = rsResults("itemText")
			If len(trim(strItemText)) > SV_DROPDOWN_MAX_LENGTH Then
				strItemText = mid(strItemText,1,SV_DROPDOWN_MAX_LENGTH) & "..."
			End If
%>
			<option value="<%=intItemFoundID%>"
<%
			If intItemFoundID = cint(intDefaultItemID) Then
%>
				selected
<%
			End If
%>
			>
				<%=strItemText%>
			</option>
<%
			rsResults.moveNext
		Loop
%>
		</select>
<%
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:			survey_answersDropdownJS
'
'Purpose:		get javascript to update answers dropdown based on choice in questions dropdown
'
'Inputs:		intSurveyID - unique ID of survey
'				strFormName - name of HTML form
'				strSelectName - name of HTML select
'**************************************************************************************
Function survey_answersDropdownJS(intSurveyID, strFormName, strSelectName)
	Dim strSQL
	Dim rsResults
	Dim intItemID
	Dim intCurrentItemID
	Dim boolItemAdded
	Dim strAnswerText
	Dim intAnswerID
	'get all item answers
	strSQL = "SELECT A.itemID, A.answerText, A.answerID " &_
		     "FROM usd_answers A " &_
		     "INNER JOIN usd_SurveyItem S " &_
		     "ON A.itemID = S.itemID " &_
		     "WHERE S.surveyID = " & intSurveyID &_
		     " ORDER by A.itemID, A.answerText "
	Set rsResults = utility_getRecordset(strSQL)
	'loop through answers
	survey_answersDropdownJS = "function updateAnswers(itemID){"
	survey_answersDropdownJS = survey_answersDropdownJS & "document." & strFormName & "." & strSelectName & ".options.length = 0;"
	If not rsResults.EOF Then
		Do until rsResults.EOF 
			intItemID = rsResults("itemID")
			strAnswerText = rsResults("answerText")
			If len(trim(strAnswerText)) > SV_DROPDOWN_MAX_LENGTH Then
				strAnswerText = mid(strAnswerText,1,SV_DROPDOWN_MAX_LENGTH) & "..."
			End If
			strAnswerText = utility_javascriptEncode(strAnswerText)
			'if advertiser different from advertiser for previous banner
			If Cint(intCurrentItemID) <> intItemID Then
				If boolItemAdded = True Then
					survey_answersDropdownJS = survey_answersDropdownJS & "}"
				End If
				survey_answersDropdownJS = survey_answersDropdownJS & "if (itemID == " & intItemID &_
								"){n = 0;document." & strFormName & "." & strSelectName & "[n++] = new Option('Select a Value','');"
				intCurrentItemID = intItemID
				boolItemAdded = True
			End If
			'add banner to if statement
			survey_answersDropdownJS = survey_answersDropdownJS &_
				"document." & strFormName & "." & strSelectName & "[n++] = new Option(""" & strAnswerText &_
					""", '" & rsResults("answerID") & "');"
			rsResults.MoveNext
		Loop
		survey_answersDropdownJS = survey_answersDropdownJS & "}}"
	Else
		survey_answersDropdownJS = survey_answersDropdownJS & "}"
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function
'**************************************************************************************
'Name:			survey_conditionTypeDropdown
'
'Purpose:		show dropdown of all conditions that can be evaluated
'
'Inputs:		None
'**************************************************************************************
Function survey_conditionTypeDropdown(intDefaultConditionID)
	Dim strSQL
	Dim rsResults
	Dim intConditionType
	strSQL = "SELECT conditionTypeID, conditionTypeText " &_
							 "FROM usd_ConditionTypes " &_
							 "ORDER by orderByID "
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
%>
		<select name="conditionType">
			<option value="">Select an Operator</option>
<%
		Do until rsResults.EOF
			intConditionType = rsResults("conditionTypeID")
%>
			<option value="<%=intConditionType%>"
<%
			If intConditionType = cint(intDefaultConditionID) Then
%>
				selected
<%
			End If
%>
			>
				<%=rsResults("conditionTypeText")%>
			</option>
<%
			rsResults.moveNext
		Loop
%>
		</select>
<%
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function


'**************************************************************************************
'Name:			survey_getItemText
'
'Purpose:		get the main text for specified item
'
'Inputs:		intItemID - unique ID of Item to get item text for
'**************************************************************************************
Function survey_getItemText(intItemID)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT itemText " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	survey_getItemText = rsResults("itemText")
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:			survey_getConditionTypeText
'
'Purpose:		get the text for a condition type
'
'Inputs:		intConditionType - unique ID of condition to get text for
'**************************************************************************************
Function survey_getConditionTypeText(intConditionType)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT conditionTypeText " &_
			 "FROM usd_conditionTypes " &_
			 "WHERE conditionTypeID = " & intConditionType
	Set rsResults = utility_getRecordset(strSQL)
	survey_getConditionTypeText = rsResults("conditionTypeText")
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:			survey_getLastSurveyItemID
'
'Purpose:		get the itemID of the last item in the survey
'
'Inputs:		intSurveyID - unique ID of survey
'**************************************************************************************
Function survey_getLastSurveyItemID(intSurveyID)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT top 1 itemID " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " ORDER BY pageID DESC, orderByID DESC "
	Set rsResults = utility_getRecordset(strSQL)
	'if no orderByID for this page exists
	If rsResults.EOF Then
		survey_getLastSurveyItemID = 0
	Else
		survey_getLastSurveyItemID = rsResults("itemID")
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:			survey_getLastPageID
'
'Purpose:		get the pageID of the last item in the survey
'
'Inputs:		intSurveyID - unique ID of survey
'**************************************************************************************
Function survey_getLastPageID(intSurveyID)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT top 1 pageID " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " ORDER BY pageID DESC, orderByID DESC "
	Set rsResults = utility_getRecordset(strSQL)
	'if no orderByID for this page exists
	If rsResults.EOF Then
		survey_getLastPageID = 0
	Else
		survey_getLastPageID = rsResults("pageID")
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:			survey_clearResults
'
'Purpose:		clear all results of a survey
'
'Inputs:		intSurveyID - unique ID of survey
'**************************************************************************************
Function survey_clearResults(intSurveyID)
	Dim strSQL
	Dim rsResults
	Dim intItemID
	strSQL = "SELECT responseID " &_
			 "FROM usd_response " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " AND completed = 1"
			 
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF
			Call survey_deleteResponse(rsResults("responseID"))
			rsResults.MoveNext
		Loop
	End If
	rsResults.Close
	strSQL = "SELECT itemID " &_
			 "FROM usd_surveyItem " &_
			 "WHERE surveyID = " & intSurveyID 
		 
	rsResults.Open strSQL, DB_CONNECTION
	If not rsResults.EOF Then
		Do until rsResults.EOF
			intItemID = rsResults("itemID")
			strSQL = "DELETE FROM usd_itemResponses " &_
					 "WHERE itemID = " & intItemID
			Call utility_executeCommand(strSQL)
			strSQL = "DELETE FROM usd_responseDetails " &_
					 "WHERE itemID = " & intItemID
			Call utility_executeCommand(strSQL)
			
			strSQL = "UPDATE usd_matrixSets SET numberResponses = 0 WHERE itemID = " & intItemID
			Call utility_executeCommand(strSQL)
			
			rsResults.MoveNext
		Loop
	End If
	rsResults.Close
	Set rsResults = NOTHING
	strSQL = "UPDATE usd_surveyItem " &_
			 "SET numberResponses = 0 " &_
			 "WHERE surveyID = " & intSurveyID
	Call utility_executeCommand(strSQL)
	
	strSQL = "UPDATE usd_survey " &_
			 "SET numberResponses = 0 " &_
			 "WHERE surveyID = " & intSurveyID
	Call utility_executeCommand(strSQL)
End Function

'**************************************************************************************
'Name:			survey_deleteResponse
'
'Purpose:		deletes an entire response to a survey
'
'Inputs:		intResponseID - unique ID of response to delete
'**************************************************************************************
Function survey_deleteResponse(intResponseID)
	Dim strSQL
	Dim intSurveyID
	Dim rsResults
	
	strSQL = "SELECT surveyID FROM usd_response WHERE responseID = " & intResponseID
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		intSurveyID = rsResults("surveyID")
		strSQL = "UPDATE usd_survey SET numberResponses = (numberResponses - 1) WHERE surveyID = " & intSurveyID
		Call utility_executeCommand(strSQL)
	End If
	rsResults.Close
	Set rsResults = NOTHING
	
	strSQL = "DELETE FROM usd_response " &_
			 "WHERE responseID = " & intResponseID
	Call utility_executeCommand(strSQL)
	
	strSQL = "DELETE FROM usd_responseDetails " &_
			 "WHERE responseID = " & intResponseID
	Call utility_executeCommand(strSQL)
End Function

'**************************************************************************************
'Name:			survey_deleteAllResponsesInProgress
'
'Purpose:		deletes all in proress responses to a survey
'
'Inputs:		intSurveyID - unique ID of survey to delete in progress responses for
'**************************************************************************************
Function survey_deleteAllResponsesInProgress(intSurveyID)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT responseID " &_
			 "FROM usd_response " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " AND completed = 0"
			 
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF
			Call survey_deleteResponseInProgress(rsResults("responseID"))
			rsResults.MoveNext
		Loop
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:			survey_deleteAllResponsesInProgress
'
'Purpose:		deletes all in proress responses to a survey
'
'Inputs:		intSurveyID - unique ID of survey to delete in progress responses for
'**************************************************************************************
Function survey_deleteResponseInProgress(intResponseID)
	Dim strSQL
	strSQL = "DELETE FROM usd_response " &_
			 "WHERE responseID = " & intResponseID
	Call utility_executeCommand(strSQL)
	
	strSQL = "DELETE FROM usd_responseDetails " &_
			 "WHERE responseID = " & intResponseID
	Call utility_executeCommand(strSQL)
End Function

'**************************************************************************************
'Name:			survey_getSurveyTitle
'
'Purpose:		gets title of survey
'
'Inputs:		intSurveyID - unique ID of survey
'**************************************************************************************
Function survey_getSurveyTitle(intSurveyID)
	If utility_isPositiveInteger(intSurveyID) Then
		Dim strSQL
		Dim rsResults
		strSQL = "SELECT surveyTitle " &_
				 "FROM usd_Survey " &_
				 "WHERE surveyID = " & intSurveyID
		Set rsResults = utility_getRecordset(strSQL)
		survey_getSurveyTitle = rsResults("surveyTitle")
		rsResults.Close
		Set rsResults = NOTHING
	End If
End Function

'**************************************************************************************
'Name:			survey_getSurveyTitle
'
'Purpose:		gets description of survey
'
'Inputs:		intSurveyID - unique ID of survey
'**************************************************************************************
Function survey_getSurveyDescription(intSurveyID)
	If utility_isPositiveInteger(intSurveyID) Then
		Dim strSQL
		Dim rsResults
		strSQL = "SELECT surveyDescription " &_
				 "FROM usd_Survey " &_
				 "WHERE surveyID = " & intSurveyID
		Set rsResults = utility_getRecordset(strSQL)
		survey_getSurveyDescription = rsResults("surveyDescription")
		rsResults.Close
		Set rsResults = NOTHING
	End If
End Function

'**************************************************************************************
'Name:			survey_getSurveyType
'
'Purpose:		gets type of survey
'
'Inputs:		intSurveyID - unique ID of survey
'**************************************************************************************
Function survey_getSurveyType(intSurveyID)
	If utility_isPositiveInteger(intSurveyID) Then
		Dim strSQL
		Dim rsResults
		strSQL = "SELECT surveyType " &_
				 "FROM usd_Survey " &_
				 "WHERE surveyID = " & intSurveyID
		Set rsResults = utility_getRecordset(strSQL)
		survey_getSurveyType = rsResults("surveyType")
		rsResults.Close
		Set rsResults = NOTHING
	End If
End Function

'**************************************************************************************
'Name:			survey_getPrivacyLevel
'
'Purpose:		gets privacy level of survey
'
'Inputs:		intSurveyID - unique ID of survey
'**************************************************************************************
Function survey_getPrivacyLevel(intSurveyID)
	If utility_isPositiveInteger(intSurveyID) Then
		Dim strSQL
		Dim rsResults
		strSQL = "SELECT privacyLevel " &_
				 "FROM usd_Survey " &_
				 "WHERE surveyID = " & intSurveyID
		Set rsResults = utility_getRecordset(strSQL)
		survey_getPrivacyLevel = rsResults("privacyLevel")
		rsResults.Close
		Set rsResults = NOTHING
	End If
End Function

Function survey_userInfoAvailable(intSurveyID)
	If utility_isPositiveInteger(intSurveyID) Then
		Dim strSQL
		Dim rsResults
		strSQL = "SELECT userInfoAvailable " &_
				 "FROM usd_Survey " &_
				 "WHERE surveyID = " & intSurveyID
		Set rsResults = utility_getRecordset(strSQL)
		survey_userInfoAvailable = cbool(rsResults("userInfoAvailable"))
		rsResults.Close
		Set rsResults = NOTHING
	End If
End Function

'**************************************************************************************
'Name:			survey_surveyAvailable
'
'Purpose:		returns boolean of whether survey is currently available
'
'Inputs:		intSurveyID - unique ID of survey
'				intUserID - unique ID of current user (optional)
'**************************************************************************************
Function survey_surveyAvailable(intSurveyID, intUserID, boolEditing)
	Dim strSQL
	Dim rsResults
	Dim intTimesTaken
	If not utility_isPositiveInteger(intSurveyID) Then
		survey_surveyAvailable = False
	Else
		If not utility_isPositiveInteger(intUserID) Then
					
			If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
				intTimesTaken = cint(Request.Cookies(SV_COOKIE_NAME & "survey" & intSurveyID)("timesTaken"))
			ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then
				intTimesTaken = Cint(Session("survey" & intSurveyID & "timesTaken"))
			End If	
			
			strSQL = "SELECT top 1 surveyID " &_
					 "FROM usd_Survey " &_
					 "WHERE surveyType = " & SV_SURVEY_TYPE_PUBLIC &_
					 " AND isActive = 1 " &_
					 " AND surveyID = " & intSurveyID &_
					 "AND (numberResponses < maxResponses OR maxResponses IS NULL )" &_
					 " AND ((responsesPerUser > " & intTimesTaken & ")" &_
					 " OR (responsesPerUser IS NULL))" &_
					 "AND (startDate <= GETDATE() OR startDate IS NULL) " &_
					 "AND (endDate >= GETDATE() OR endDate IS NULL) "
		Else
			If response_respondedMaxTimes(intSurveyID, intUserID) = True Then
				If  boolEditing = True Then
					survey_surveyAvailable = True
				Else
					survey_surveyAvailable = False
				End If
				Exit Function
			Else	
				strSQL = "SELECT top 1 surveyID " &_
					 "FROM usd_Survey " &_
					 "WHERE (((surveyType <> " & SV_SURVEY_TYPE_RESTRICTED & ") " &_
					 "OR (surveyType = " & SV_SURVEY_TYPE_RESTRICTED & " AND " &_
					 "surveyID IN (SELECT surveyID FROM usd_restrictedSurveyUsers " &_
					 "WHERE userID = " & intUserID & " and isPermitted = 1)))" &_
					 " AND surveyID = " & intSurveyID &_
					 " AND isActive = 1 " &_
					 "AND (numberResponses < maxResponses OR maxResponses IS NULL )" &_
					 "AND (startDate <= GETDATE() OR startDate IS NULL) " &_
					 "AND (endDate >= GETDATE() OR endDate IS NULL)) " &_
					 " OR ownerUserID = " & intUserID
			End If
		End If
		If utility_checkForRecords(strSQL) = False Then
			survey_surveyAvailable = False
		Else
			strSQL = "SELECT top 1 itemID " &_
					 "FROM usd_surveyItem " &_
					 "WHERE surveyID = " & intSurveyID
			survey_surveyAvailable = utility_checkForRecords(strSQL)
		End If	 
	End If
		
End Function

'**************************************************************************************
'Name:			survey_getItemDescription
'
'Purpose:		returns description of item in survey
'
'Inputs:		intItemID - uniqueID of item to get description of
'**************************************************************************************
Function survey_getItemDescription(intItemID)
	Dim strSQL
	Dim rsResults
	If utility_isPositiveInteger(intItemID) Then
		strSQL = "SELECT itemDescription " &_
				 "FROM usd_SurveyItem " &_
				 "WHERE itemID = " & intItemID
		Set rsResults = utility_getRecordset(strSQL)
		survey_getItemDescription = rsResults("itemDescription")
		rsResults.Close
		Set rsResults = NOTHING
	End If
End Function

'**************************************************************************************
'Name:			survey_surveyExists
'
'Purpose:		returns boolean of whether survey exists or not
'
'Inputs:		intSurveyID - survey to check for existence
'**************************************************************************************
Function survey_surveyExists(intSurveyID)
	Dim strSQL
	If not utility_isPositiveInteger(intSurveyID) Then
		survey_surveyExists = False
	Else
		strSQL = "SELECT surveyID " &_
				 "FROM usd_Survey " &_
				 "WHERE surveyID = " & intSurveyID
		survey_surveyExists = utility_checkForRecords(strSQL)
	End If
End Function

'**************************************************************************************
'Name:			survey_isScored
'
'Purpose:		returns boolean of survey is scored or not
'
'Inputs:		intSurveyID - survey to check
'**************************************************************************************
Function survey_isScored(intSurveyID)
	Dim strSQL
	If not utility_isPositiveInteger(intSurveyID) Then
		survey_isScored = False
	Else
		strSQL = "SELECT surveyID " &_
				 "FROM usd_Survey " &_
				 "WHERE surveyID = " & intSurveyID &_
				 " AND isScored = 1"
		survey_isScored = utility_checkForRecords(strSQL)
	End If
End Function

Function survey_updateResponseCount(intSurveyID)
	Dim strSQL
	Dim rsResults
	Dim intNumberResponses
	strSQL = "SELECT count(responseID) as numResponses " &_
			 "FROM usd_response " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " AND completed = 1"
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		intNumberResponses = rsResults("numResponses")
	Else
		intNumberResponses = 0
	End If
	rsResults.Close
	Set rsResults = NOTHING
	strSQL = "UPDATE usd_survey " &_
			 "SET numberResponses = " & intNumberResponses &_
			 " WHERE surveyID = " & intSurveyID
	Call utility_executeCommand(strSQL)
End Function

Function survey_getOwnerUsername(intSurveyID)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT U.username " &_
			 "FROM usd_surveyUser U " &_
			 "INNER JOIN usd_survey S " &_
			 "ON U.userID = S.ownerUserID " &_
			 "WHERE surveyID = " & intSurveyID
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		survey_getOwnerUsername = rsResults("username")
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function survey_getItemCount(intSurveyID)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT count(itemID) as itemCount " &_
			 "FROM usd_surveyItem " &_
			 "WHERE surveyID = " & intSurveyID
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		survey_getItemCount = rsResults("itemCount")
	End If
	rsResults.Close
	Set rsResults = NOTHING	
End Function

Function survey_getAnswerText(intAnswerID)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT answerText " &_
			 "FROM usd_Answers " &_
			 "WHERE answerID = " & intAnswerID
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		survey_getAnswerText = rsResults("answerText")
	End If
	rsResults.Close
	Set rsResults = NOTHING	
End Function

Function survey_getCategoryName(intCategoryID)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT category FROM usd_matrixCategories WHERE categoryID = " & intCategoryID
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		survey_getCategoryName = rsResults("category")
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function survey_getAlias(intItemID, strResponse, intMatrixSetID)
	Dim strSQL
	Dim rsResults
	
	If utility_isPositiveInteger(intMatrixSetID) Then
		strSQL = "SELECT alias FROM usd_matrixAnswers WHERE matrixSetID = " & intMatrixSetID & " AND answerText = " & utility_SQLEncode(strResponse, True)
	Else
		strSQL = "SELECT alias FROM usd_answers WHERE itemID = " & intItemID & " AND answerText = " & utility_SQLEncode(strResponse, True)
	End If
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		survey_getAlias = rsResults("alias")
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function survey_getCategoryAlias(intItemID, strCategory)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT alias FROM usd_matrixCategories WHERE itemID = " & intItemID & " AND category = " & utility_SQLEncode(strCategory, True)
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		survey_getCategoryAlias = rsResults("alias")
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function survey_getNumberMatrixAnswers(intMatrixSetID)
	Dim strSQL
	Dim rsResults

	strSQL = "SELECT count(matrixAnswerID) as numberAnswers FROM usd_matrixAnswers WHERE matrixSetID = " & intMatrixSetID
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		survey_getNumberMatrixAnswers = rsResults("numberAnswers")
	End If
	
	rsResults.Close
	Set rsResults = NOTHING

End Function

Function survey_getMatrixResponse(intResponseID, intMatrixSetID, strCategory)
	Dim strSQL
	Dim rsResults

	If utility_isPositiveInteger(intResponseID) Then

		strSQL = "SELECT response FROM usd_responseDetails " &_
				 "WHERE responseID = " & intResponseID & " AND matrixSetID = " & intMatrixSetID & " AND matrixCategory = " & utility_SQLEncode(strCategory, True)
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
			survey_getMatrixResponse = rsResults("response")
		Else
			survey_getMatrixResponse = ""
		End If
	
		rsResults.Close
		Set rsResults = NOTHING	
	Else
		survey_getMatrixResponse = ""
	End If
End Function

Function survey_isActive(intSurveyID)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT isActive FROM usd_survey WHERE surveyID = " & intSurveyID
	Set rsResults = utility_getRecordset(strSQL)
	
	survey_isActive = cbool(rsResults("isActive"))
	
	rsResults.Close
	Set rsResults = NOTHING
	
End Function

Function survey_getItemTypeText(intItemType)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT itemTypeText FROM usd_itemTypes WHERE itemTypeID = " & intItemType
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		survey_getItemTypeText = rsResults("itemTypeText")
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function survey_getLibraryName(intCategoryID)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT categoryName FROM usd_itemCategories WHERE categoryID = " & intCategoryID
	Set rsResults = utility_getRecordset(strSQL)
	survey_getLibraryName = rsResults("categoryName")
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function survey_updateAllResponseCounts()
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT surveyID FROM usd_survey"
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF
			Call survey_updateResponseCount(rsResults("surveyID"))
			rsResults.MoveNext
		Loop
	End If
	
	
End Function

Function survey_hasHiddenFields(intSurveyID)
	Dim strSQL
	
	strSQL = "SELECT top 1 itemID FROM usd_surveyItem WHERE surveyID = " & intSurveyID & " AND pageID = 0"
	survey_hasHiddenFields = utility_checkForRecords(strSQL)
End Function

Function survey_getQueryString(intSurveyID)
	If utility_isPositiveInteger(intSurveyID) Then
		Dim strSQL
		Dim rsResults
		Dim strQueryString
		Dim strVariableName
		strSQL = "SELECT variableName FROM usd_surveyItem WHERE itemType = " & SV_HIDDEN_FIELD_TYPE_QUERYSTRING & " AND surveyID = " & intSurveyID
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
			Do until rsResults.EOF
				strVariableName = rsResults("variableName")
				strQuerystring = strQuerystring & "&" & strVariableName & "=" & request.QueryString(strVariableName)
				rsResults.MoveNext
			Loop
			
		End If
		rsResults.Close
		Set rsResults = NOTHING
		survey_getQueryString = strQueryString
	End If
End Function
%>


