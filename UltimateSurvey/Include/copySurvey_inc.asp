<%
Function copySurvey_copySurvey(intSurveyID, intUserID)
	Dim strSQL
	Dim rsResults 
	Dim intAnswerID
	Dim strAnswerText
	Dim intCategoryID
	Dim strCategory
	Dim strCategoryAlias
	Dim intPoints
	Dim strAlias
	Dim strItemText
	Dim strItemDescription
	Dim strCompletionRedirect
	Dim strCompletionMessage
	Dim strDefaultValue
	Dim intItemID
	Dim rsItems
	Dim strGUID
	Dim dtmCreatedDate
	Dim strSurveyTitle
	Dim intNewSurveyID
	Dim intNewItemID
	Dim intNewConditionID
	Dim rsConditions
	Dim intConditionID
	Dim intPageID
	Dim intConditionGroupID
	Dim intItemDifferential	
	Dim strScoreMessage
	Dim intLowPoints
	Dim intHighPoints
	Dim intNewAnswerID
	Dim intOrderByID
	
	strSQL = "SELECT surveyType, surveyTitle, surveyDescription, startDate, endDate, responsesPerUser, " &_
			 "maxResponses, completionMessage, completionRedirect, privacyLevel, allowContinue, resultsEmail, isScored, showProgress, logNTUser, templateID, numberLabels, editable, userInfoAvailable " &_
			 "FROM usd_survey WHERE surveyID = " & intSurveyID
	
	Set rsResults = utility_getRecordset(strSQL)
	
	If not rsResults.EOF Then
		dtmCreatedDate = now()
		strSQL = "INSERT INTO usd_survey " &_
				 "(surveyType, surveyTitle, surveyDescription, startDate, endDate, orderByID, responsesPerUser, isActive, " &_
				 "createdDate, maxResponses, completionMessage, completionRedirect, ownerUserID, privacyLevel, allowContinue, " &_
				 "resultsEmail, isScored, showProgress, logNTUser, templateID, numberLabels, editable, numberResponses, userInfoAvailable) " &_
				 "VALUES(" & rsResults("surveyType") & "," 
				 
				 strSurveyTitle = rsResults("surveyTitle") & "_copy"
				 
				 strSQL = strSQL & utility_SQLEncode(strSurveyTitle,True) & "," &_
				 utility_SQLEncode(rsResults("surveyDescription"),True) & "," &_
				 utility_SQLEncode(rsResults("startDate"),True) & "," &_
				 utility_SQLEncode(rsResults("endDate"),True) & "," &_
				 "0," &_
				 utility_SQLEncode(rsResults("responsesPerUser"), True) & "," &_
				 "0," &_
				 utility_SQLEncode(dtmCreatedDate,True) & "," &_
				 utility_SQLEncode(rsResults("maxResponses"),True) & "," 
				 
				 strCompletionMessage = rsResults("completionMessage")
				 strCompletionRedirect = rsResults("completionRedirect")
				 
				 strSQL = strSQL & utility_SQLEncode(strCompletionMessage,True) & "," &_
				 utility_SQLEncode(strCompletionRedirect,True) & "," &_
				 intUserID & "," &_
				 rsResults("privacyLevel") & "," &_
				 rsResults("allowContinue") & "," &_
				 utility_SQLEncode(rsResults("resultsEmail"),True) & "," &_
				 rsResults("isScored") & "," &_
				 rsResults("showProgress") &  "," &_
				 rsResults("logNTUser") & "," &_
				 rsResults("templateID") & "," &_
				 rsResults("numberLabels") & "," &_
				 rsResults("editable") & ",0," & rsResults("userInfoAvailable") & ")"
		Call utility_executeCommand(strSQL)
	End If
	rsResults.Close
	
	strSQL = "SELECT max(surveyID) as newID FROM usd_survey " &_
			 "WHERE surveyTitle = " & utility_SQLEncode(strSurveyTitle, True)
	rsResults.Open strSQL, DB_CONNECTION
	intNewSurveyID = rsResults("newID")
	
	rsResults.Close
	
	strSQL = "SELECT itemID, pageID, orderByID	FROM usd_surveyItem WHERE surveyID = " & intSurveyID & " ORDER BY pageID, orderByID"
	
	rsResults.CursorLocation = adUseClient
	rsResults.Open strSQL, DB_CONNECTION
	If not rsResults.EOF Then
		Do until rsResults.EOF
			intItemID = rsResults("itemID")
			intPageID = rsResults("pageID")
						
			Call copyItem_copyItem(intItemID, intNewSurveyID, intPageID, False, intNewItemID)
			rsResults.MoveNext
		Loop					
	End If
	
	rsResults.MoveFirst
	Do until rsResults.EOF
		intItemID = rsResults("itemID")
		intPageID = rsResults("pageID")
		intOrderByID = rsResults("orderByID")	
			
		strSQL = "SELECT answerID, conditionValue, conditionType, conditionGUID  FROM usd_conditions WHERE questionAnsweredID = " & intItemID
		
		Set rsConditions = utility_getRecordset(strSQL)
		If not rsConditions.EOF Then
			Do until rsConditions.EOF
				intAnswerID = rsConditions("answerID")
				intNewItemID = getCorrespondingItemID(intNewSurveyID, intPageID, intOrderByID)
				intNewAnswerID = getAnswerID(intItemID, intAnswerID, intNewItemID)
				
				
				strSQL = "INSERT INTO usd_conditions(questionAnsweredID, conditionValue, conditionType, conditionGUID, answerID) " &_
						"VALUES(" & intNewItemID & "," & utility_SQLEncode(rsConditions("conditionValue"),True) & "," & utility_SQLEncode(rsConditions("conditionType"),True) &_
						"," & utility_SQLEncode(rsConditions("conditionGUID"),True) & "," & utility_SQLEncode(intNewAnswerID, True) & ")"
				Call utility_executeCommand(strSQL)
				rsConditions.MoveNext 
			Loop
			
		End If
		rsConditions.Close
		Set rsConditions = NOTHING
		rsResults.MoveNext
	Loop		
	
	rsResults.MoveFirst
	
	Do until rsResults.EOF
		intItemID = rsResults("itemID")
		intPageID = rsResults("pageID")
		intOrderByID = rsResults("orderByID")	
		intNewItemID = getCorrespondingItemID(intNewSurveyID, intPageID, intOrderByID)
		
		strSQL = "SELECT conditionID, conditionGroupID FROM usd_conditionMapping WHERE itemID = " & intItemID
		Set rsConditions = utility_getRecordset(strSQL)
		If not rsConditions.EOF Then
			Do until rsConditions.EOF
				intConditionID = rsConditions("conditionID")
				intConditionGroupID = rsConditions("conditionGroupID")
				intNewConditionID = getLatestConditionID(intConditionID)
			
				strSQL = "INSERT INTO usd_conditionMapping(conditionID, itemID, conditionGroupID) " &_
						 "VALUES(" & intNewConditionID & "," & intNewItemID & "," & intConditionGroupID & ")"
				Call utility_executeCommand(strSQL)
			
				rsConditions.MoveNext
			Loop
		End If
		rsConditions.Close
		Set rsConditions = NOTHING
		rsResults.MoveNext
	Loop
	
	rsResults.Close
	
	strSQL = "SELECT conditionID, conditionGroupID, pageID FROM usd_conditionMapping WHERE surveyID = " & intSurveyID
	Set rsConditions = utility_getRecordset(strSQL)
	If not rsConditions.EOF Then
		Do until rsConditions.EOF
			intConditionID = rsConditions("conditionID")
			intConditionGroupID = rsConditions("conditionGroupID")
			intPageID = rsConditions("pageID")
			intNewConditionID = getLatestConditionID(intConditionID)
			
			strSQL = "INSERT INTO usd_conditionMapping(conditionID, conditionGroupID, pageID, surveyID) " &_
					 "VALUES(" & intNewConditionID & "," & intConditionGroupID & "," & intPageID & "," & intNewSurveyID & ")"
			Call utility_executeCommand(strSQL)
			
		
			rsConditions.MoveNext
		Loop
	End If
	
	strSQL = "SELECT lowPoints, highPoints, message " &_
			 "FROM usd_scoringMessages " &_
			 "WHERE surveyID = " & intSurveyID
	rsResults.Open strSQL, DB_CONNECTION
	If not rsResults.EOF Then
		Do until rsResults.EOF
			intLowPoints = rsResults("lowPoints")
			intHighPoints = rsResults("highPoints")
			strScoreMessage = rsResults("message")
			strSQL = "INSERT INTO usd_scoringMessages " &_
					 "(surveyID, lowPoints, highPoints, message)" &_
					 "VALUES(" & intNewSurveyID & "," & intLowPoints & "," & intHighPoints & "," &_
					 utility_SQLEncode(strScoreMessage, True) & ")" 
			Call utility_executeCommand(strSQL)
			rsResults.MoveNext
		Loop
	End If
	
	rsResults.Close
	Set rsResults = NOTHING
	
	'response.End
End Function

Function getAnswerID(intItemID, intAnswerID, intNewItemID)
	Dim strSQL
	Dim rsResults
	
	If utility_isPositiveInteger(intAnswerID) Then
	
		strSQL = "SELECT answerID FROM usd_Answers WHERE itemID = " & intNewItemID &_
				" AND answerText LIKE (SELECT answerText FROM usd_answers WHERE itemID = " & intItemID & " AND answerID = " & intAnswerID & ")"
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
			getAnswerID = rsResults("answerID")
		End If
		rsResults.Close
		Set rsResults = NOTHING
	End If
End Function

Function getCorrespondingItemID(intSurveyID, intPageID, intOrderByID)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT itemID FROM usd_surveyItem WHERE surveyID = " & intSurveyID & " AND pageID = " & intPageID & " AND orderByID = " & intOrderByID 
	Set rsResults = utility_getRecordset(strSQL)

	If not rsResults.EOF Then
		getCorrespondingItemID = rsResults("itemID")
	Else
		getCorrespondingItemID = 0
	End If
	rsResults.Close
	Set rsResults = NOTHING
	
End Function

Function getLatestConditionID(intConditionID)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT max(conditionID) as maxID FROM usd_conditions WHERE conditionGUID IN(SELECT conditionGUID FROM usd_conditions WHERE conditionID = " & intConditionID & ")"
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		getLatestConditionID = rsResults("maxID")
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function
%>