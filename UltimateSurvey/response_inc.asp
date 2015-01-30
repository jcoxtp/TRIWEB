<%
'****************************************************
'
' Name:		response_inc.asp Server-Side Include
' Purpose:		Provides functions relating to responses to surveys
'
' Date Written:	6/18/2002
' Modified:		
'
' Changes:
'****************************************************

'**************************************************************************************
'Name:			response_startResponse
'
'Purpose:		initiate response to a survey
'
'Inputs:		intSurveyID - unique ID of survey user is responding to
'				intUserID - unique ID of user taking survey (optional)
'
'Outputs:		intResponseInProgressIDOut - unique ID of response in progress
'				strGUIDOut - globally unique identifier of response in progress
'**************************************************************************************
Function response_startResponse(intSurveyID, intUserID, intResponseInProgressIDOut, strGUIDOut, boolLogNTUser, boolAdminEditing, intOldResponseID)
	Dim strGUID
	Dim strSQL
	Dim rsResults
	Dim strNetworkUsername
	
	If boolAdminEditing = True and utility_isPositiveInteger(intOldResponseID) Then
		Dim intSurveyUserID
		Dim dtmDateStarted
		Dim strUserIP
		Dim dtmDateCompleted
		
		strSQL = "SELECT userID, dateStarted, dateCompleted, userIP, NTUser " &_
				 "FROM usd_response WHERE responseID = " & intOldResponseID
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
			intSurveyUserID = rsResults("userID")
			dtmDateStarted = rsResults("dateStarted")
			dtmDateCompleted = rsResults("dateCompleted")
			strUserIP = rsResults("userIP")
			strNetworkUsername = rsResults("NTUser")
		End If
		rsResults.Close
		Set rsResults = NOTHING
		
	Else
		intSurveyUserID = intUserID
		dtmDateStarted = now()
		strUserIP = Request.ServerVariables("REMOTE_ADDR")
		If boolLogNTUser = True Then
			strNetworkUsername = utility_getNetworkUsername()
		End If
	End If
	
	
	strGUID = utility_createGUID()
	strSQL = "INSERT INTO usd_Response " &_
			 "(surveyID, userID, dateStarted, userIP, responseGUID, completed, lastPageAnswered, NTUser, dateCompleted) " &_
			 "VALUES(" & intSurveyID & "," & utility_SQLEncode(intSurveyUserID, True) &_
			 ", " & utility_SQLEncode(dtmDateStarted,True) & "," &_
			 utility_SQLEncode(strUserIP, True) & "," &_
			 utility_SQLEncode(strGUID, False) & ",0,0," & utility_SQLEncode(strNetworkUserName, True) & "," &_
			 utility_SQLEncode(dtmDateCompleted, True) & ")"
	Call utility_executeCommand(strSQL)
	
	strSQL = "SELECT responseID " &_
			 "FROM usd_response " &_
			 "WHERE responseGUID = " & utility_SQLEncode(strGUID, False)
	Set rsResults = utility_getRecordset(strSQL)
	intResponseInProgressIDOut = rsResults("responseID")
	rsResults.Close
	Set rsResults = NOTHING
	strGUIDOut = strGUID
End Function

'**************************************************************************************
'Name:			response_outputItems
'
'Purpose:		display all items/questions for the survey/page number combo
'
'Inputs:		intSurveyID - unique ID of survey to display items for
'				intPageNumber - page number to output items for
'				intResponseID - unique ID of response in progress
'
'Outpus:		boolItemsShown - whether or not any item was shown
'**************************************************************************************
Function response_outputItems(intSurveyID, intPageNumber, intResponseID, _
					intLastQuestionNumber, boolNumberLabels, intQuestionSize, strQuestionColor, _
						intQuestionDescriptionSize, strQuestionDescriptionColor, intAnswerSize, strAnswerColor, _
						strBaseFont, boolEditing, intOldResponseID, strOddRowColor, strEvenRowColor, strHeaderColor)
	Dim strSQL
	Dim rsResults
	Dim intItemID
	Dim intPageID
	Dim intCurrentPageID
	Dim boolTableShown
	Dim intCounter
	Dim intItemType
	Dim strMinimumValue
	Dim strMaximumValue
	Dim strJavaScript
	Dim strItemText
	Dim intQuestionCounter
	Dim boolAllowOther	
	Dim strQuerystring
	Dim boolConditional
	Dim boolShow	
	
		strSQL = "SELECT itemID, conditional, itemType " &_
				 "FROM usd_SurveyItem " &_
				 "WHERE surveyID = " & intSurveyID &_
				 " AND pageID = " & intPageNumber &_
				 " ORDER BY pageID, orderByID "
		Set rsResults = utility_getRecordset(strSQL)
	
		intQuestionCounter = intLastQuestionNumber
	
		strQuerystring = "?surveyID=" & intSurveyID
		If  boolEditing = True Then
			strQuerystring = strQuerystring & "&editResponseID=" & intOldResponseID
		End If
				
	
		If not rsResults.EOF Then
%>
			<form method="post" name="frmResponse" 
				action="processResponse.asp<%=strQuerystring%>">		
<%
			Do until rsResults.EOF
				boolShow = True
				intItemID = rsResults("itemID")
				boolConditional = cbool(rsResults("conditional"))
				If boolConditional = True Then
					If response_checkConditions(intItemID, "", "", intResponseID) = False Then
						boolShow = False
					Else
						boolShow = True
					End If
				Else
					boolShow = True
				End If
				
				If boolShow = True Then
					intItemType = rsResults("itemType")
					boolItemsShown = True
						Select Case intItemType
							Case SV_ITEM_TYPE_HEADER
								Call itemDisplay_displayHeader(intItemID)
							Case SV_ITEM_TYPE_MESSAGE
								Call itemDisplay_displayMessage(intItemID,intResponseID)
							Case SV_ITEM_TYPE_IMAGE
								Call itemDisplay_displayImage(intItemID)
							Case SV_ITEM_TYPE_LINE
								Call itemDisplay_displayLine()
							Case SV_ITEM_TYPE_HTML
								Call itemDisplay_displayHTML(intItemID)
							Case SV_ITEM_TYPE_TEXTAREA
								Call itemDisplay_displayTextArea(intItemID, intQuestionCounter, boolNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, strBaseFont, intOldResponseID, boolEditing, strJavascript, intResponseID)
							Case SV_ITEM_TYPE_SINGLE_LINE
								Call itemDisplay_displaySingleLine(intItemID, intQuestionCounter, boolNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, strBaseFont, intOldResponseID, boolEditing, strJavascript, intResponseID)
							Case SV_ITEM_TYPE_DATE
								Call itemDisplay_displayDate(intItemID, intQuestionCounter, boolNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, strBaseFont, intOldResponseID, boolEditing, strJavascript, intResponseID)
							Case SV_ITEM_TYPE_CHECKBOXES
								Call itemDisplay_displayCheckboxes(intItemID, strJavascript, intQuestionCounter, boolNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, intAnswerSize, strAnswerColor, strBaseFont, intOldResponseID, boolEditing, intResponseID)
							Case SV_ITEM_TYPE_RADIO
								Call itemDisplay_displayRadio(intItemID, intQuestionCounter, boolNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, intAnswerSize, strAnswerColor, strBaseFont, intOldResponseID, boolEditing, strJavascript,intResponseID)
							Case SV_ITEM_TYPE_DROPDOWN
								Call itemDisplay_displayDropdown(intItemID, intQuestionCounter, boolNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, strBaseFont, intOldResponseID, boolEditing, strJavascript, intResponseID)
							Case SV_ITEM_TYPE_MATRIX
								Call itemDisplay_displayMatrix(intItemID, strJavascript, intQuestionCounter, boolNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, intAnswerSize, strAnswerColor, strBaseFont, intOldResponseID, _
									boolEditing,False, strOddRowColor, strEvenRowColor, strHeaderColor,0,intResponseID)
						End Select
%>
					<input type="hidden" name="itemType<%=intItemID%>" value="<%=intItemType%>">
<%
				End If
				rsResults.Movenext
			Loop
		End If
	
	
	
%>
			<script language="javascript">
				function validateForm()
				{
					<%=strJavaScript%>
				}
			</script>
			<br /><br />
			<input type="hidden" name="pageNumber" value="<%=intPageNumber%>">
<%
			If intItemID = survey_getLastSurveyItemID(intSurveyID) Then
%>
				<input type="submit" name="submit" value="Complete Survey" 
					onclick="javascript:return validateForm();">
				<input type="hidden" name="completeSurvey" value="true">		
<%
			Else
					If intPageNumber > 1 Then
%>	
						<input type="button" name="submit_back" value="Previous" onclick="javascript:submitBackwards();" />&nbsp;&nbsp;&nbsp;
						<input type="hidden" name="moveToPageDirection" id="moveToPageDirection" value="next" />
						<script language="javascript">
							function submitBackwards()
							{
								
								if( validateForm() )
									return;
								
								//alert('submitBackwards');
								document.frmResponse.moveToPageDirection.value = new String('prev');
								document.frmResponse.submit();
								
							}
						</script>
<%
					End If
%>
				<input type="submit" name="submit_fwd" value="Continue" 
					onclick="javascript:return validateForm();">
<%
			End If
%>
			<input type="hidden" name="lastQuestionNumber" value="<%=intQuestionCounter%>">
		</form>
<%
		rsResults.Close
		Set rsResults = NOTHING
		
End Function

Function response_outputItemsToPrint(intSurveyID, intPageNumber, intResponseID, _
					boolItemsShown, intLastQuestionNumber, boolNumberLabels, intQuestionSize, strQuestionColor, _
						intQuestionDescriptionSize, strQuestionDescriptionColor, intAnswerSize, strAnswerColor, _
						strBaseFont, boolEditing, intOldResponseID, strOddRowColor, strEvenRowColor, strHeaderColor)
	Dim strSQL
	Dim rsResults
	Dim intItemID
	Dim intPageID
	Dim intCurrentPageID
	Dim boolTableShown
	Dim intCounter
	Dim intItemType
	Dim strMinimumValue
	Dim strMaximumValue
	Dim strJavaScript
	Dim strItemText
	Dim intQuestionCounter
	Dim boolAllowOther	
	Dim strQuerystring
		
	boolItemsShown = False
	
	strSQL = "SELECT itemID, itemType, isRequired, itemText, allowOther " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " AND pageID = " & intPageNumber &_
			 " ORDER BY pageID, orderByID "
		Set rsResults = utility_getRecordset(strSQL)
	
		intQuestionCounter = intLastQuestionNumber
	
	
		If not rsResults.EOF Then
%>
			<form method="post" name="frmResponse" 
				action="processResponse.asp<%=strQuerystring%>" ID="Form1">		
<%
			Do until rsResults.EOF
				intItemID = rsResults("itemID")
				intItemType = rsResults("itemType")
						
						Select Case intItemType
							Case SV_ITEM_TYPE_HEADER
								Call itemDisplay_displayHeader(intItemID)
							Case SV_ITEM_TYPE_MESSAGE
								Call itemDisplay_displayMessage(intItemID)
							Case SV_ITEM_TYPE_IMAGE
								Call itemDisplay_displayImage(intItemID)
							Case SV_ITEM_TYPE_LINE
								Call itemDisplay_displayLine()
							Case SV_ITEM_TYPE_HTML
								Call itemDisplay_displayHTML(intItemID)
							Case SV_ITEM_TYPE_TEXTAREA
								Call itemDisplay_displayTextArea(intItemID, intQuestionCounter, boolNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, strBaseFont, intOldResponseID, boolEditing,"",0)
							Case SV_ITEM_TYPE_SINGLE_LINE
								Call itemDisplay_displaySingleLine(intItemID, intQuestionCounter, boolNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, strBaseFont, intOldResponseID, boolEditing,"",0)
							Case SV_ITEM_TYPE_DATE
								Call itemDisplay_displayDate(intItemID, intQuestionCounter, boolNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, strBaseFont, intOldResponseID, boolEditing,"",0)
							Case SV_ITEM_TYPE_CHECKBOXES
								Call itemDisplay_displayCheckboxes(intItemID, strJavascript, intQuestionCounter, boolNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, intAnswerSize, strAnswerColor, strBaseFont, intOldResponseID, boolEditing,0)
							Case SV_ITEM_TYPE_RADIO
								Call itemDisplay_displayRadio(intItemID, intQuestionCounter, boolNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, intAnswerSize, strAnswerColor, strBaseFont, intOldResponseID, boolEditing,"",0)
							Case SV_ITEM_TYPE_DROPDOWN
								Call itemDisplay_displayDropdown(intItemID, intQuestionCounter, boolNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, strBaseFont, intOldResponseID, boolEditing,"",0)
							Case SV_ITEM_TYPE_MATRIX
								Call itemDisplay_displayMatrix(intItemID, strJavascript, intQuestionCounter, boolNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, intAnswerSize, strAnswerColor, strBaseFont, intOldResponseID, _
									boolEditing,False, strOddRowColor, strEvenRowColor, strHeaderColor,0,0)
						End Select

					

				rsResults.Movenext
			Loop
		End If
	
%>
			<br /><br />
		</form>
<%
		rsResults.Close
		Set rsResults = NOTHING
End Function


'**************************************************************************************
'Name:			response_getResponseInProgressID
'
'Purpose:		get integer response ID based on GUID
'
'Inputs:		strGUID - globally unique identifier of response in progress
'				intUserID - userID to get response ID for
'				intSurveyID - unique ID of survey to get response ID for
'**************************************************************************************
Function response_getResponseInProgressID(strGUID, intUserID, intSurveyID)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT responseID " &_
			 "FROM usd_response " 
	'If utility_isPositiveInteger(intUserID) Then
		'strSQL = strSQL & "WHERE userID = " & intUserID &_
		'				  " AND surveyID = " & intSurveyID
	'Else
		strSQL = strSQL & "WHERE responseGUID = " & utility_SQLEncode(strGUID, False)
	'End If
	
	strSQL = strSQL & " AND completed = 0"
		
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		response_getResponseInProgressID = rsResults("responseID")
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:			response_addResponse(intResponseID, intItemID, strResponse, boolDeleteOld, boolOther)
'
'Purpose:		add response to the database
'
'Inputs:		intResponseID - unique ID of response in progress
'				intItemID - unique ID of question responded to
'				strResponse - response to question 
'				boolDeleteOld - whether to replace old answers to this item or add to them
'				boolOther - whether or not the response is an "other" response
'				strCategory - category for matrix questions
'**************************************************************************************
Function response_addResponse(intResponseID, intItemID, strResponse, boolDeleteOld, boolOther, intCategoryID, intMatrixSetID, intMatrixSetType, intAnswerID)
	Dim strSQL
	Dim rsResults
		If not utility_isPositiveInteger(intCategoryID) Then
			intCategoryID = 0
		End If


		strSQL = "INSERT INTO usd_ResponseDetails " &_
				 "(responseID, itemID, response, timeAnswered, isOther, matrixCategoryID, matrixSetID, matrixSetType, answerID) " &_
				 "VALUES(" & intResponseID & "," & intItemID & "," &_
				 utility_SQLEncode(strResponse, True) & ", GETDATE() " &_
				 "," & abs(cbool(boolOther)) & "," & intCategoryID &_
				 "," & intMatrixSetID & "," & intMatrixSetType & "," & intAnswerID & ")"
		Call utility_executeCommand(strSQL)
		
		strSQL = "SELECT points " &_
				 "FROM usd_answers " &_
				 "WHERE itemID = " & intItemID &_
				 " AND answerID = " & intAnswerID &_
				 " AND points <> 0"
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
			strSQL = "UPDATE usd_response " &_
					 "SET points = points + " & rsResults("points") &_
					 " WHERE responseID = " & intResponseID 
			Call utility_executeCommand(strSQL)
		End If
		
		rsResults.Close
		Set rsResults = NOTHING
		
		If utility_isPositiveInteger(intMatrixSetID) and utility_isPositiveInteger(intAnswerID) Then
			strSQL = "SELECT points " &_
				 "FROM usd_matrixAnswers " &_
				 "WHERE matrixSetID = " & intMatrixSetID &_
				 " AND matrixAnswerID = " & intAnswerID &_
				 " AND points <> 0"
			Set rsResults = utility_getRecordset(strSQL)
			If not rsResults.EOF Then
				strSQL = "UPDATE usd_response " &_
						 "SET points = points + " & rsResults("points") &_
						 " WHERE responseID = " & intResponseID 
				Call utility_executeCommand(strSQL)
			End If
		
			rsResults.Close
			Set rsResults = NOTHING
		End If
	'End If
End Function

'**************************************************************************************
'Name:			response_itemResponded
'
'Purpose:		returns true if user has already responded to a question
'
'Inputs:		intResponseID - unique ID of response in progress
'				intItemID - item to check to see if it has been responded to
'				strCategory - category for matrix questions
'**************************************************************************************
Function response_itemResponded(intResponseID, intItemID, strCategory)
	Dim strSQL
	strSQL = "SELECT responseID " &_
			 "FROM usd_ResponseDetails " &_
			 "WHERE responseID = " & intResponseID &_
			 " AND itemID = " & intItemID &_
			 " AND matrixCategory = " & utility_SQLEncode(strCategory, True)
	response_itemResponded = utility_checkForRecords(strSQL)
End Function

'**************************************************************************************
'Name:			response_checkConditions
'
'Purpose:		returns true if all conditions are passed and item should display
'
'Inputs:		intItemID - unique ID of item to conditionally display (optional)
'				intPageID - unique ID of page to conditionally display (optional)
'				intSurveyID - unique ID of survey (needed if looking up entire page)
'				intResponseID - unique ID of response in progress
'**************************************************************************************
Function response_checkConditions(intItemID, intPageID, intSurveyID, intResponseID)
	Dim strSQL
	Dim rsResults
	Dim boolConditionPassed
	Dim boolGroupConditionsPassed
	Dim intConditionGroupID
	Dim intCurrentConditionGroupID
	Dim intQuestionAnsweredID
	Dim intConditionType
	Dim strConditionValue
	Dim intAnswerID
	
	If utility_isPositiveInteger(intItemID) Then
		strSQL = "SELECT C.questionAnsweredID, C.conditionType, C.conditionValue, C.answerID, CM.conditionGroupID " &_
				 "FROM usd_conditions C " &_
				 "INNER JOIN usd_conditionMapping CM " &_
				 "ON C.conditionID = CM.conditionID " &_
				 "WHERE CM.itemID = " & intItemID &_
				 " ORDER BY CM.conditionGroupID " 
	ElseIf utility_isPositiveInteger(intPageID) Then
		strSQL = "SELECT C.questionAnsweredID, C.conditionType, C.conditionValue, C.answerID, CM.conditionGroupID " &_
				 "FROM usd_conditions C " &_
				 "INNER JOIN usd_conditionMapping CM " &_
				 "ON C.conditionID = CM.conditionID " &_
				 "WHERE CM.pageID = " & intPageID &_
				 " AND CM.surveyID = " & intSurveyID &_
				 " ORDER BY CM.conditionGroupID " 
	End If

	Set rsResults = utility_getRecordset(strSQL)
	
	

	boolGroupConditionsPassed = False
		
	If rsResults.EOF Then
		response_checkConditions = True
	Else
		Do until rsResults.EOF
			intQuestionAnsweredID = rsResults("questionAnsweredID")
			intConditionType = rsResults("conditionType")
			strConditionValue = rsResults("conditionValue")
			intAnswerID = rsResults("answerID")
			intConditionGroupID = rsResults("conditionGroupID") 
			If intCurrentConditionGroupID <> intConditionGroupID Then
				If boolGroupConditionsPassed = True Then
					response_checkConditions = True
					Exit Function
				End If
				boolGroupConditionsPassed = True
				intCurrentConditionGroupID = intConditionGroupID
			End If
			boolConditionPassed = response_evaluateCondition(intQuestionAnsweredID, _
			cint(intConditionType), strConditionValue, intResponseID, intAnswerID) 
			If boolConditionPassed = False Then
				boolGroupConditionsPassed = False
			End If
			rsResults.MoveNext
		Loop
		If boolGroupConditionsPassed = True Then
			response_checkConditions = True
		Exit Function
		End If
	End If
End Function

'**************************************************************************************
'Name:			response_evaluateCondition
'
'Purpose:		returns true if condition is true
'
'Inputs:		intQuestionAnsweredID - unique ID of item to evaluate answer to
'				intConditionType - type of condition 
'				strConditionValue - value to compate
'				intResponseID - unique ID of response in progress
'**************************************************************************************
Function response_evaluateCondition(intQuestionAnsweredID, intConditionType, _
					strConditionValue, intResponseID, intAnswerID)
	Dim strSQL
	Dim rsResults
	Dim strResponse
	Dim boolChecked
	
	boolChecked = False
	
	If utility_isPositiveInteger(intAnswerID) Then
		
		Select Case intConditionType
			Case SV_CONDITION_EQUALS_ID
				strSQL = "SELECT responseDetailID FROM usd_responseDetails WHERE answerID = " & intAnswerID & " AND responseID = " & intResponseID
				response_evaluateCondition = utility_checkForRecords(strSQL)
				boolChecked = True
			Case SV_CONDITION_NOT_EQUAL_ID
				strSQL = "SELECT responseDetailID FROM usd_responseDetails WHERE answerID = " & intAnswerID & " AND responseID = " & intResponseID
				Set rsResults = utility_getRecordset(strSQL)
				If rsResults.EOF Then
					response_evaluateCondition = True
				Else
					response_evaluateCondition = False
				End If
				rsResults.Close
				Set rsResults = NOTHING
				boolChecked = True
			End Select
	End If
	
	If boolChecked = False Then
	
	
		strSQL = "SELECT RD.response, A.answerText " &_
				 "FROM usd_ResponseDetails RD " &_
				 "LEFT JOIN usd_answers A ON RD.answerID = A.answerID " &_
				 "WHERE RD.responseID = " & intResponseID &_
				 " AND RD.itemID = " & intQuestionAnsweredID &_
				 " AND (RD.response IS NOT NULL OR RD.answerID > 0)"
		

		
		Set rsResults = utility_getRecordset(strSQL)

		If not rsResults.EOF Then
			Do until rsResults.EOF
				
				strResponse = rsResults("response")
	
				If len(trim(strResponse)) = 0 or isNull(strResponse) Then
					strResponse = rsResults("answerText")
				End If
	
				Select case intConditionType
					Case SV_CONDITION_EQUALS_ID
						If cstr(strResponse) = cstr(strConditionValue) Then
							response_evaluateCondition = True
						End If
					Case SV_CONDITION_NOT_EQUAL_ID
						 If cstr(strResponse) <> cstr(strConditionValue) Then
							response_evaluateCondition = True
						 End If
					Case SV_CONDITION_GREATER_THAN_ID
						If isNumeric(strResponse) Then
							If cdbl(strResponse) > cdbl(strConditionValue) Then
								response_evaluateCondition = True
							End If
						ElseIf isDate(strResponse) AND isDate(strConditionValue) Then
							If cdate(strResponse) > cdate(strConditionValue) Then
								response_evaluateCondition = True
							End If
						End If
					Case SV_CONDITION_LESS_THAN_ID
						If isNumeric(strResponse) Then
							If cint(strResponse) < cint(strConditionValue) Then
								response_evaluateCondition = True
							End If
						ElseIf isDate(strResponse) AND isDate(strConditionValue) Then
							If cdate(strResponse) < cdate(strConditionValue) Then
								response_evaluateCondition = True
							End If
						End If
					Case SV_CONDITION_CONTAINS_ID
						If inStr(1,strResponse,strConditionValue, vbTextCompare) > 0 Then
							response_evaluateCondition = True
						End If
					Case SV_CONDITION_DOES_NOT_CONTAIN_ID
						If inStr(1,strResponse,strConditionValue, vbTextCompare) = 0 Then
							response_evaluateCondition = True
						End If
					Case SV_CONDITION_ANSWERED
						response_evaluateCondition = True
					Case SV_CONDITION_DID_NOT_ANSWER
						response_evaluateCondition = False
						
				End Select
				rsResults.MoveNext
			Loop
		Else
			If intConditionType = SV_CONDITION_DID_NOT_ANSWER Then
				response_evaluateCondition = True
			Else
				response_evaluateCondition = False
			End If
		End If
		rsResults.Close
		Set rsResults = NOTHING
	End If
End Function

'**************************************************************************************
'Name:			response_getAnswerText
'
'Purpose:		get text of answer based on its ID
'
'Inputs:		intAnswerID - unique ID of answer to get text for
'**************************************************************************************
Function response_getAnswerText(intAnswerID, strAlias)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT answerText, alias " &_
			 "FROM usd_Answers " &_
			 "WHERE answerID = " & intAnswerID
	Set rsResults = utility_getRecordset(strSQL)
	response_getAnswerText = rsResults("answerText")
	strAlias = rsResults("alias")
	rsResults.Close
	Set rsResults = NOTHING
End Function


Function response_getMatrixAnswerText(intAnswerID, strAlias)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT answerText, alias " &_
			 "FROM usd_matrixAnswers " &_
			 "WHERE matrixAnswerID = " & intAnswerID
	Set rsResults = utility_getRecordset(strSQL)
	response_getMatrixAnswerText = rsResults("answerText")
	strAlias = rsResults("alias")
	rsResults.Close
	Set rsResults = NOTHING
End Function


'**************************************************************************************
'Name:			response_deleteResponseItems
'
'Purpose:		deletes a particular response detail from a response in progress
'
'Inputs:		intResponseID - unique ID of response 
'				intItemID - unique ID of item to delete response for
'				strCategory - category for matrix questions
'**************************************************************************************
Function response_deleteResponseItem(intResponseID, intItemID, strCategory, intMatrixSetID)
	Dim strSQL
	
	If not utility_isPositiveInteger(intMatrixSetID) Then
		intMatrixSetID = 0	
	End If
	
	strSQL = "DELETE FROM usd_ResponseDetails " &_
		 "WHERE responseID = " & intResponseID &_
		 " AND itemID = " & intItemID &_
		 " AND matrixSetID = " & intMatrixSetID
	Call utility_executeCommand(strSQL)
End Function

'**************************************************************************************
'Name:			response_commitResponse
'
'Purpose:		take a response in progress and commit it as a completed response
'
'Inputs:		intResponseID - unique ID of response in progress
'
'**************************************************************************************
Function response_commitResponse(intResponseID, boolUpdateDateCompleted)
	Dim strSQL
	Dim strGUID
	Dim rsResults
	Dim strResponse
	Dim intItemID
	Dim intCurrentItemID 
	Dim intCategoryID
	Dim intCurrentSetID
	Dim intMatrixSetID
	Dim intAnswerID
	
	strGUID = utility_createGUID()
	
	strSQL = "UPDATE usd_response " &_
			 "SET completed = 1 "
			 
	If boolUpdateDateCompleted = True Then
		strSQL = strSQL & ",dateCompleted = GETDATE() "
	End If
	
	strSQL = strSQL & " WHERE responseID = " & intResponseID
	Call utility_executeCommand(strSQL)
	
	
	strSQL = "SELECT itemID, response, matrixCategoryID, matrixSetID, answerID " &_
			 "FROM usd_responseDetails " &_
			 "WHERE responseID = " & intResponseID &_
			 " AND (response IS NOT NULL or answerID > 0) " &_
			 " ORDER by responseDetailID"
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF
			intItemID = rsResults("itemID")
			strResponse = rsResults("response")
			intCategoryID = rsResults("matrixCategoryID")
			intMatrixSetID = rsResults("matrixSetID")
			intAnswerID = rsResults("answerID")
			
			If intItemID <> intCurrentItemID Then
				strSQL = "UPDATE usd_surveyItem " &_
					 "SET numberResponses = numberResponses + 1 " &_
					 "WHERE itemID = " & intItemID 
				intCurrentItemID = intItemID
				Call utility_executeCommand(strSQL)
			
			End If
			
			If utility_isPositiveInteger(intMatrixSetID) Then
				If intCurrentSetID <> intMatrixSetID Then
					strSQL = "UPDATE usd_matrixSets " &_
						 "SET numberResponses = numberResponses + 1 " &_
						 "WHERE matrixSetID = " & intMatrixSetID 

					Call utility_executeCommand(strSQL)
					intCurrentSetID = intMatrixSetID
				End If
			End If
			
			
			
			strSQL = "SELECT itemID " &_
					 "FROM usd_itemResponses " 
					
			If utility_isPositiveInteger(intAnswerID) Then
				strSQL = strSQL & "WHERE answerID = " & intAnswerID 
			Else
				strSQL = strSQL & "WHERE responseText LIKE " & utility_SQLEncode(strResponse, False)
			End If 
					 
			strSQL = strSQL & " AND itemID = " & intItemID & " AND matrixSetID = " & intMatrixSetID
			If utility_isPositiveInteger(intCategoryID) Then
				strSQL = strSQL & " and matrixCategoryID = " & intCategoryID
			End If	
				
			If utility_checkForRecords(strSQL) = False Then
				strSQL = "INSERT INTO usd_itemResponses(itemID, responseText, numberResponses, matrixCategoryID,matrixSetID, answerID) " &_
						 "VALUES(" & intItemID & "," & utility_SQLEncode(strResponse, False) & ",1," &_
						 intCategoryID & "," & intMatrixSetID & "," & intAnswerID & ")"
			Else
				strSQL = "UPDATE usd_itemResponses SET numberResponses = numberResponses + 1 " 
							
						If utility_isPositiveInteger(intAnswerID) Then
							strSQL = strSQL & "WHERE answerID = " & intAnswerID 
						Else
							strSQL = strSQL & "WHERE responseText LIKE " & utility_SQLEncode(strResponse, False)
						End If 
				
						 strSQL = strSQL & " AND itemID = " & intItemID 
					     If utility_isPositiveInteger(intCategoryID) Then
							strSQL = strSQL & " and matrixCategoryID = " & intCategoryID
						 End If	
						 
						 If utility_isPositiveInteger(intMatrixSetID) Then
							strSQL = strSQL & " AND matrixSetID = " & intMatrixSetID
						 End If
			End If
			Call utility_executeCommand(strSQL)
			rsResults.MoveNext
		Loop
	End If
	rsResults.Close
	Set rsResults = NOTHING

End Function


'**************************************************************************************
'Name:			response_responseStarted(intResponseID)
'
'Purpose:		returns true if items have been responded to , but survey not completed
'
'Inputs:		intResponseID - unique ID of response in progress
'**************************************************************************************
Function response_responseStarted(intResponseID)
	Dim strSQL
	strSQL = "SELECT top 1 RD.responseID " &_
			 "FROM usd_ResponseDetails RD, usd_response R, usd_surveyItem SI " &_
			 "WHERE R.responseID = RD.responseID " &_
			 "AND RD.itemID = SI.itemID " &_
			 "AND RD.responseID = " & intResponseID &_
			 " AND R.completed = 0" &_
			 " AND SI.pageID > 0 " 
	response_responseStarted = utility_checkForRecords(strSQL)
End Function



'**************************************************************************************
'Name:			response_updateLastPageAnswered
'
'Purpose:		update last page that was responsed to for particular response
'
'Inputs:		intResponseID - unique ID of response
'				intPageNumber - unique ID of page
'**************************************************************************************
Function response_updateLastPageAnswered(intResponseID, intPageNumber)
	Dim strSQL 
	strSQL = "UPDATE usd_response " &_
			 "SET lastPageAnswered = " & intPageNumber &_
			 " WHERE responseID = " & intResponseID
	Call utility_executeCommand(strSQL)
End Function

'**************************************************************************************
'Name:			response_getLastPageAnswered
'
'Purpose:		returns ID of last page that was responsed to for particular response
'
'Inputs:		intResponseID - unique ID of response in progress to find last page
'				intSurveyID - unique ID of survey the response is for
'**************************************************************************************
Function response_getLastPageAnswered(intResponseID, intSurveyID)
	Dim strSQL
	Dim rsResults
	Dim intItemID
	strSQL = "SELECT lastPageAnswered " &_
			 "FROM usd_response " &_
			 "WHERE responseID = " & intResponseID 
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		response_getLastPageAnswered = rsResults("lastPageAnswered")
	Else
		response_getLastPageAnswered = 0
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:			response_respondedMaxTimes
'
'Purpose:		returns boolean of whether user has taken survey maximum number of times or not
'
'Inputs:		intSurveyID - unique ID of survey to check responses for
'				intUserID - unique ID of user to check responses
'**************************************************************************************
Function response_respondedMaxTimes(intSurveyID, intUserID) 
	Dim strSQL
	Dim rsResults
	Dim intResponsesPerUser
	strSQL = "SELECT responsesPerUser " &_
			 "FROM usd_Survey " &_
			 "WHERE surveyID = " & intSurveyID
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		intResponsesPerUser = rsResults("responsesPerUser")
		rsResults.Close
		If cint(intUserID) = survey_getOwnerID(intSurveyID) Then
			Set rsResults = NOTHING
			response_respondedMaxTimes = False
			Exit Function
		ElseIf not utility_isPositiveInteger(intResponsesPerUser) Then
			Set rsResults = NOTHING
			response_respondedMaxTimes = False
			Exit Function
		Else
			strSQL = "SELECT count(responseID) as responseCount " &_
					 "FROM usd_Response " &_
					 "WHERE surveyID = " & intSurveyID &_
					 " AND userID = " & intUserID &_
					 " AND completed = 1"
			rsResults.Open strSQL, DB_CONNECTION
			If rsResults("responseCount") >= intResponsesPerUser Then
				response_respondedMaxTimes = True
			Else
				response_respondedMaxTimes = False
			End If
		End If
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:			response_sendResults
'
'Purpose:		email response details to specified address
'
'Inputs:		intResponseID - unique ID of response to send results for
'				strResultsEmail - email address to send results to
'**************************************************************************************
Function response_sendResults(intResponseID, strResultsEmail)
	Dim strSQL
	Dim rsResults
	Dim strSummary
	Dim strDetails
	Dim strBody
	Dim strSubject
	Dim dtmTimeStarted
	Dim dtmTimeCompleted
	Dim intUserID
	Dim intItemID
	Dim intCurrentItemID
	Dim intPoints
	Dim boolScored
	Dim strResponse
	Dim strCategory
	Dim strSetText
	Dim strCurrentSetText
	Dim intAnswerID
	Dim intMatrixSetID

	strSQL = "SELECT surveyTitle, isScored " &_
			 "FROM usd_survey " &_
			 "WHERE surveyID = " & intSurveyID
	Set rsResults = utility_getRecordset(strSQL)
	strSubject = "Survey Response: " & rsResults("surveyTitle")
	boolScored = cbool(rsResults("isScored"))
	rsResults.Close
	strSQL = "SELECT userID, dateStarted, dateCompleted, userIP, points " &_
			 "FROM usd_Response " &_
			 "WHERE responseID = " & intResponseID 
	rsResults.Open strSQL, DB_CONNECTION
	If not rsResults.EOF Then
		intUserID = rsResults("userID")
		dtmTimeStarted = rsResults("dateStarted")
		dtmTimeCompleted = rsResults("dateCompleted")
		intPoints = rsResults("points")
		strSummary = "User: " & user_getUsername(intUserID) & vbcrlf &_
					 "Time Started: " & dtmTimeStarted & vbcrlf &_
					 "Time Completed: " & dtmTimeCompleted & vbcrlf &_
					 "Total Time: " &_
						dateDiff("N",dtmTimeStarted, dtmTimeCompleted) & " Minute(s)" & vbcrlf
		If boolScored Then
			strSummary = strSummary & "Score: " & intPoints & vbcrlf
		End If
	End If
	rsResults.Close
	If utility_isPositiveInteger(intUserID) Then
		strSQL = "SELECT firstName, lastName, email, title, company, location " &_
				 "FROM usd_surveyUser " &_
				 "WHERE userID = " & intUserID
		rsResults.Open strSQL, DB_CONNECTION
		If not rsResults.EOF Then
			strSummary = strSummary & "Name: " & rsResults("firstName") & " " & rsResults("lastName") & vbcrlf &_
						 "Email: " & rsResults("email") & vbcrlf & "Title: " & rsResults("title") & vbcrlf &_
						 "Company: " & rsResults("company") & vbcrlf & "Location: " & rsResults("location") & vbcrlf
		End If
		rsResults.Close
	End If
	strSQL = "SELECT RD.itemID, RD.answerID, RD.matrixSetID, RD.response, MS.setText, RD.matrixCategory " &_
			 "FROM usd_ResponseDetails RD " &_
			 "LEFT OUTER JOIN usd_matrixSets MS " &_
			 "ON RD.matrixSetID = MS.matrixSetID " &_
			 "WHERE responseID = " & intResponseID &_ 
			 " AND (response IS NOT NULL OR answerID > 0) " &_
			 " ORDER BY responseDetailID" 
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF
			intItemID = rsResults("itemID")
			
			intAnswerID = rsResults("answerID")
			intMatrixSetID = rsResults("matrixSetID")
			
			If utility_isPositiveInteger(intAnswerID) Then
				strResponse = reports_getResponse(intAnswerID, intMatrixSetID)
			Else
				strResponse = rsResults("response")
			End If
			
			If utility_isPositiveInteger(intMatrixSetID) Then
				strSetText = reports_getMatrixSetText(intMatrixSetID)
			Else		
				strSetText = rsResults("setText")
			End If

			
			strCategory = rsResults("matrixCategory")
			
				If intItemID <> intCurrentItemID Then
					strDetails = strDetails & vbcrlf & survey_getItemText(intItemID) & vbcrlf 
					intCurrentItemID = intItemID
				End If
				
				If len(trim(strSetText)) > 0 Then
					If strSetText <> strCurrentSetText Then
						strDetails = strDetails & strSetText & ":" & vbcrlf 
						strCurrentSetText = strSetText
					End If
				End If
				
				If len(trim(strCategory)) > 0 Then
					strDetails = strDetails & strCategory & " - " 
				End If
				strDetails = strDetails & strResponse & vbcrlf
			rsResults.MoveNext
		Loop
	End If				
	strBody = strSummary & vbcrlf & vbcrlf & strDetails

	Call utility_sendMail(SV_EMAIL_FROM_ADDRESS, strResultsEmail, strSubject, strBody)	
	
End Function

'**************************************************************************************
'Name:			response_incrementSurveyResponses
'
'Purpose:		adds 1 to number of total responses to a survey
'
'Inputs:		intSurveyID - unique ID of survey to increment
'**************************************************************************************
Function response_incrementSurveyResponses(intSurveyID)
	Dim strSQL
	strSQL = "UPDATE usd_survey " &_
			 "SET numberResponses = numberResponses + 1 " &_
			 "WHERE surveyID = " & intSurveyID
	Call utility_executeCommand(strSQL)
End Function

'**************************************************************************************
'Name:			response_deleteResponse
'
'Purpose:		deletes a survey response
'
'Inputs:		intResponseID - unique ID of response to delete
'**************************************************************************************
Function response_deleteResponse(intResponseID)
	Dim strSQL
	Dim rsResults
	Dim rsCount
	Dim intItemID
	Dim strResponse
	Dim intCurrentItemID
	Dim rsResponse
	Dim strCategory
	Dim intMatrixSetID
	Dim intCurrentMatrixSetID
	Dim intAnswerID
	Dim intSurveyID
	
	strSQL = "SELECT surveyID FROM usd_response WHERE responseID = " & intResponseID
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		intSurveyID = rsResults("surveyID")
		strSQL = "UPDATE usd_survey SET numberResponses = (numberResponses - 1) WHERE surveyID = " & intSurveyID
		Call utility_executeCommand(strSQL)
	End If
	rsResults.Close
	Set rsResults = NOTHING
	

	strSQL = "SELECT itemID, response, matrixCategory, matrixSetID, answerID " &_
			 "FROM usd_responseDetails " &_
			 "WHERE responseID = " & intResponseID &_
			 " ORDER by responseDetailID "
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF 
			intItemID = rsResults("itemID")
			strResponse = rsResults("response")
			strCategory = rsResults("matrixCategory")
			intMatrixSetID = rsResults("matrixSetID")
			intAnswerID = rsResults("answerID")
			strSQL = "SELECT numberResponses " &_
					 "FROM usd_itemResponses " &_
					 "WHERE itemID = " & intItemID 
					 
					 If utility_isPositiveInteger(intAnswerID) Then
						strSQL = strSQL & " AND answerID = " & intAnswerID
					 Else
						strSQL = strSQL & " AND responseText LIKE " & utility_SQLEncode(strResponse, True)
					 End If
						
					 If len(trim(strCategory)) > 0 Then
						strSQL = strSQL & " AND category = " & utility_SQLEncode(strCategory, True) 
					 End If
					 If utility_isPositiveInteger(intMatrixSetID) Then
						strSQL = strSQL & " AND matrixSetID = " & intMatrixSetID
					 End If

			Set rsResponse = utility_getRecordset(strSQL)
			If not rsResponse.EOF Then		
					If rsResponse("numberResponses") < 2 Then
						strSQL = "DELETE FROM usd_itemResponses " &_
								 "WHERE itemID = " & intItemID 
								 
								 If utility_isPositiveInteger(intAnswerID) Then
									strSQL = strSQL & " AND answerID = " & intAnswerID
								 Else
									strSQL = strSQL & " AND responseText LIKE " & utility_SQLEncode(strResponse, True)
								 End If								 
								 If len(trim(strCategory)) > 0 Then
									strSQL = strSQL & " AND category = " & utility_SQLEncode(strCategory, True) 
								 End If
								 If utility_isPositiveInteger(intMatrixSetID) Then
									strSQL = strSQL & " AND matrixSetID = " & intMatrixSetID
								 End If
				
						Call utility_executeCommand(strSQL)
					Else
						strSQL = "UPDATE usd_itemResponses " &_
								 "SET numberResponses = numberResponses - 1 " &_
								 "WHERE itemID = " & intItemID 
								 
								 If utility_isPositiveInteger(intAnswerID) Then
									strSQL = strSQL & " AND answerID = " & intAnswerID
								 Else
									strSQL = strSQL & " AND responseText LIKE " & utility_SQLEncode(strResponse, True)
								 End If
								 
								 If len(trim(strCategory)) > 0 Then
									strSQL = strSQL & " AND category = " & utility_SQLEncode(strCategory, True) 
								 End If
								 
								 If utility_isPositiveInteger(intMatrixSetID) Then
									strSQL = strSQL & " AND matrixSetID = " & intMatrixSetID
								 End If
						Call utility_executeCommand(strSQL)
					End If
			
					If intItemID <> intCurrentItemID Then
						strSQL = "UPDATE usd_surveyItem " &_
								 "SET numberResponses = numberResponses - 1 " &_
								 "WHERE itemID = " & intItemID
						Call utility_executeCommand(strSQL)
						intCurrentItemID = intItemID
					End If
					
					If intMatrixSetID <> intCurrentMatrixSetID Then
						strSQL = "UPDATE usd_matrixSets " &_
								 "SET numberResponses = numberResponses - 1 " &_
								 "WHERE matrixSetID = " & intMatrixSetID
						Call utility_executeCommand(strSQL)
						intCurrentMatrixSetID = intMatrixSetID
					End If
				End If
				rsResults.MoveNext
			Loop
		
	End If
	
	strSQL = "DELETE FROM usd_response " &_
			 "WHERE responseID = " & intResponseID
	Call utility_executeCommand(strSQL)
	strSQL = "DELETE FROM usd_responseDetails " &_
			 "WHERE responseID = " & intResponseID
	Call utility_executeCommand(strSQL)

End Function

'**************************************************************************************
'Name:			response_getResponseByID
'
'Purpose:		get response text based on its IDs
'
'Inputs:		intResponseID - unique ID of response
'				intItemID - unique ID of item responded to
'**************************************************************************************
Function response_getResponseByID(intResponseID, intItemID)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT response " &_
			 "FROM usd_responseDetails " &_
			 "WHERE responseID = " & intResponseID &_
			 " AND itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	response_getResponseByID = rsResults("response")
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function response_getScoreMessages(intResponseID, intSurveyID)
	Dim intPoints
	Dim strMessage
	strSQL = "SELECT points " &_
			 "FROM usd_response " &_
			 "WHERE responseID = " & intResponseID
	Set rsResults = utility_getRecordset(strSQL)
	intPoints = rsResults("points")
	rsResults.Close
	Set rsResults = NOTHING
	strSQL = "SELECT message " &_
			 "FROM usd_scoringMessages " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " AND lowPoints <= " & intPoints &_
			 " AND highPoints >= " & intPoints
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
%>
		<span class="normalBold">Based on your score:</span><br />
		<span class="normal">
<%		
		Do until rsResults.EOF
%>
			<%=rsResults("message")%><br />
<%
			rsResults.MoveNext
		Loop
%>
		</span><br />
<%
	End If
	response_getScoreMessages = strMessage
End Function

'**************************************************************************************
'Name:			response_getNextPage
'
'Purpose:		get next page in a survey
'
'Inputs:		intPageNumber - page number currently on
'				intResponseID - unique ID of response in progress
'**************************************************************************************
Function response_getNextPage(intPageNumber, intResponseID)
	Dim strSQL
	Dim rsResults
	Dim strResponse
	Dim intItemID
	Dim intAnswerID
	Dim intNextPage
	strSQL = "SELECT itemID, response, nextPage, answerID " &_
			 "FROM usd_branching " &_
			 "WHERE currentPage = " & intPageNumber &_
			 " ORDER by branchID "
	Set rsResults = utility_getRecordset(strSQL)
	If rsResults.EOF Then
		response_getNextPage = intPageNumber + 1
	Else
		Do until rsResults.EOF
			intItemID = rsResults("itemID")
			strResponse = rsResults("response")
			intNextPage = rsResults("nextPage")
			intAnswerID = rsResults("answerID")
			
			If not utility_isPositiveInteger(intAnswerID) Then
				intAnswerID = 0
			End If
			
			strSQL = "SELECT itemID FROM usd_responseDetails WHERE itemID = " & intItemID &_
					 " AND (response LIKE " & utility_SQLEncode(strResponse,True) & " OR answerID = " & intAnswerID & ") " &_
					 " AND responseID = " & intResponseID
			
			If utility_checkForRecords(strSQL) = True Then
				response_getNextPage = rsResults("nextPage")
				rsResults.Close
				Set rsResults = NOTHING
				Exit Function
			End If
			rsResults.MoveNext
		Loop
	End If
	response_getNextPage = intPageNumber + 1
	rsResults.Close
	Set rsResults = NOTHING
End Function


'**************************************************************************************
'Name:			response_getPreviousPage
'
'Purpose:		get previous page in a survey
'
'Inputs:		intPageNumber - page number currently on
'				intResponseID - unique ID of response in progress
'**************************************************************************************
Function response_getPreviousPage(intPageNumber, intResponseID)
	Dim strSQL
	Dim rsResults
	Dim strResponse
	Dim intItemID
	Dim intAnswerID
	Dim intPreviousPage
	strSQL = "SELECT itemID, response, currentPage, answerID " &_
			 "FROM usd_branching " &_
			 "WHERE nextPage = " & intPageNumber &_
			 " ORDER by branchID "
	Set rsResults = utility_getRecordset(strSQL)
	If rsResults.EOF Then
		response_getPreviousPage = intPageNumber - 1
	Else
		Do until rsResults.EOF
			intItemID = rsResults("itemID")
			strResponse = rsResults("response")
			intPreviousPage = rsResults("currentPage")
			intAnswerID = rsResults("answerID")
			
			If not utility_isPositiveInteger(intAnswerID) Then
				intAnswerID = 0
			End If
			
			strSQL = "SELECT itemID FROM usd_responseDetails WHERE itemID = " & intItemID &_
					 " AND (response LIKE " & utility_SQLEncode(strResponse,True) & " OR answerID = " & intAnswerID & ") " &_
					 " AND responseID = " & intResponseID
			
			If utility_checkForRecords(strSQL) = True Then
				response_getPreviousPage = rsResults("currentPage")
				rsResults.Close
				Set rsResults = NOTHING
				Exit Function
			End If
			rsResults.MoveNext
		Loop
	End If
	response_getPreviousPage = intPageNumber - 1
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function response_getLastResponse(intUserID, intSurveyID)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT top 1 responseID " &_
			 "FROM usd_response " &_
			 "WHERE completed = 1 AND userID = " & intUserID &_
			 " AND surveyID = " & intSurveyID &_
			 " ORDER BY dateCompleted DESC"
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		response_getLastResponse = rsResults("responseID")
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function response_updateItemResponses(intSurveyID)
	Dim strSQL
	Dim strGUID
	Dim rsResults
	Dim strResponse
	Dim intItemID
	Dim intCurrentItemID 
	Dim strCategory
		
	strSQL = "SELECT RD.itemID, RD.response, RD.matrixCategory " &_
			 "FROM usd_responseDetails RD, usd_surveyItem SI " &_
			 "WHERE RD.itemID = SI.itemID AND SI.surveyID = " & intSurveyID &_
			 " ORDER by responseDetailID"
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF
			intItemID = rsResults("itemID")
			strResponse = rsResults("response")
			strCategory = rsResults("matrixCategory")
			If intItemID <> intCurrentItemID Then
				strSQL = "UPDATE usd_surveyItem " &_
					 "SET numberResponses = numberResponses + 1 " &_
					 "WHERE itemID = " & intItemID 
				intCurrentItemID = intItemID
				Call utility_executeCommand(strSQL)
			
			End If
			
			
			strSQL = "SELECT itemID " &_
					 "FROM usd_itemResponses " &_
					 "WHERE responseText LIKE " & utility_SQLEncode(strResponse, False) &_
					 " AND itemID = " & intItemID &_
					 " AND category = " & utility_SQLEncode(strCategory, True)
		
			If utility_checkForRecords(strSQL) = False Then
				strSQL = "INSERT INTO usd_itemResponses(itemID, responseText, numberResponses, category) " &_
						 "VALUES(" & intItemID & "," & utility_SQLEncode(strResponse, False) & ",1," &_
						 utility_SQLEncode(strCategory, True) & ")"
			Else
				strSQL = "UPDATE usd_itemResponses SET numberResponses = numberResponses + 1 " &_
						 "WHERE responseText LIKE " & utility_SQLEncode(strResponse, False) &_
					     " AND itemID = " & intItemID &_
					     " AND category = " & utility_SQLEncode(strCategory, True)
			End If
			Call utility_executeCommand(strSQL)
			rsResults.MoveNext
		Loop
	End If
	rsResults.Close
	Set rsResults = NOTHING


End Function

Function response_getResponseText(intResponseID, intItemID, intMatrixSetID, intMatrixCategoryID)
	Dim strSQL
	Dim rsResults
	Dim intAnswerID
	strSQL = "SELECT answerID, response " &_
			 "FROM usd_responseDetails  WHERE responseID = " & intResponseID & " AND itemID = " & intItemID 
	If utility_isPositiveInteger(intMatrixCategoryID) Then
		strSQL = strSQL & " AND matrixSetID = " & intMatrixSetID & " AND matrixCategoryID = " & intMatrixCategoryID
	End If
	
	
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		intAnswerID = rsResults("answerID")
		If utility_isPositiveInteger(intAnswerID) Then
			response_getResponseText = intAnswerID
		Else
			response_getResponseText = rsResults("response")
		End If
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

'TRI++: Retrieves user's previous data entry into an "Other" field
Function response_getOtherText(intResponseID, intItemID)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT response " &_
				"FROM usd_responseDetails " &_
				"WHERE isOther = 1 AND responseID = " & intResponseID & " AND itemID = " & intItemID
				
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		If IsNull(rsResults("response")) Then
			response_getOtherText = ""
		Else
			response_getOtherText = rsResults("response")
		End If
	Else
		response_getOtherText = ""
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function response_getPipeResponse(intResponseID, intItemID, intMatrixSetID, intMatrixCategoryID)
	Dim strSQL
	Dim rsResults
	Dim intAnswerID
	strSQL = "SELECT RD.answerID, RD.response, A.answerText  " &_
			 "FROM usd_responseDetails RD LEFT JOIN usd_answers A " &_
			 " ON A.answerID = RD.answerID " &_
			 " WHERE RD.responseID = " & intResponseID & " AND RD.itemID = " & intItemID &_
			 " AND (RD.response IS NOT NULL or RD.answerID > 0)" 
	
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		intAnswerID = rsResults("answerID")
		If utility_isPositiveInteger(intAnswerID) Then
			response_getPipeResponse = rsResults("answerText")
		Else
			response_getPipeResponse = rsResults("response")
		End If
	Else
		response_getPipeResponse = ""
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function response_getCheckboxOtherResponse(intItemID, intResponseID)
	Dim strSQL
	strSQL = "SELECT response FROM usd_responseDetails WHERE itemID = " & intItemID & " AND responseID = " & intResponseID & " AND isOther = 1"
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		response_getCheckboxOtherResponse = rsResults("response")
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function response_checkCheckboxResponse(intResponseID, intItemID, intAnswerID, intMatrixSetID, intMatrixCategoryID) 
	Dim strSQL
	strSQL = "SELECT responseID FROM usd_responseDetails WHERE responseID = " & intResponseID &_
			 " AND itemID = " & intItemID &_
			 " AND answerID = " & intAnswerID
	If utility_isPositiveInteger(intMatrixCategoryID) Then
		strSQL = strSQL & " AND matrixSetID = " & intMatrixSetID & " AND matrixCategoryID = " & intMatrixCategoryID
	End If
	response_checkCheckBoxResponse = utility_checkForRecords(strSQL)
End Function

Function response_getLastQuestionNumber(intResponseID)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT distinct(itemID)  FROM usd_responseDetails WHERE responseID = " & intResponseID 
	
	Set rsResults = Server.CreateObject("ADODB.Recordset")
	'set up record set for paging
	rsResults.CursorLocation = adUseClient
	rsResults.Open utility_ConvertSQL(strSQL), DB_CONNECTION
	response_getLastQuestionNumber = rsResults.RecordCount
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function response_pipeAnswer(intPipeNumber, intResponseID, intPipedItemID, strText)
	Dim strResponse
	If instr(1,strText,"@@pipe" & intPipeNumber) > 0 Then
		strResponse = response_getPipeResponse(intResponseID, intPipedItemID, 0, 0)
		response_pipeAnswer = replace(strText,"@@pipe" & intPipeNumber,strResponse)
	Else
		response_pipeAnswer = strText
	End If
End Function

Function response_copyHiddenFields(intResponseID1, intResponseID2)
	Dim strSQL
	Dim rsResults
	Dim intItemID
	Dim strResponse
	strSQL = "SELECT RD.itemID, RD.response FROM usd_responseDetails RD, usd_surveyItem SI " &_
			 "WHERE RD.responseID = " & intResponseID1 &_
			 " AND RD.itemID = SI.itemID " &_
			 "AND SI.pageID = 0"
			 
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF
			intItemID = rsResults("itemID")
			strResponse = rsResults("response")
			
			Call response_addResponse(intResponseID2,intItemID, strResponse,True,False,0,0,0,0)
			
			rsResults.MoveNext
		Loop
	End If
	rsResults.Close
	Set rsResults = NOTHING	
			 
End Function
%>