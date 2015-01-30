<%
'****************************************************
'
' Name:		surveyCreation_inc.asp Server-Side Include
' Purpose:		Provides functions relating to creating and editing surveys
'
' Date Written:	6/18/2002
'****************************************************

'************************************************************************************
'Name:			surveyCreation_addSurvey
'
'Purpose:       add basic survey information to database 
'
'Inputs:	    strSurveyTitle - title of survey to add
'				strDescription - description of survey
'				intSurveyType - type of survey
'				dtmStartDate - start date of survey (optional)
'				dtmEndDate - end date of survey (optional)
'				intMaxResponses - maximum total times a survey may be taken (optional)
'				intResponsesPerUser - number times each user can take the survey (optional)
'				strCompletionMessage - message to be displayed when user completes survey (optional)
'				strCompletionRedirect - URL to redirect to when survey completed (optional)
'				intPrivacyLevelID - privacy level of survey
'				intUserID - userID of survey creator
'				boolAllowContinue - whether or not the user can leave a survey then come back and continue
'				strResultsEmail - email address to send results to (optional)
'				boolNumberLabels - whether or not to show number labels next to each item
'
'Outputs:		intSurveyIDOut - the unique ID of the survey in the database
'************************************************************************************
Function surveyCreation_addSurvey(strSurveyTitle, strDescription, intSurveyType, dtmStartDate, _
					dtmEndDate, intMaxResponses, intResponsesPerUser, _
					strCompletionMessage, strCompletionRedirect, intPrivacyLevelID, _
					intUserID, boolAllowContinue, strResultsEmail, intSurveyIDOut, _
					boolShowProgress, boolScored, boolLogNTUser, boolEmailUser, boolNumberLabels, intTemplateID, boolEditable, boolUserInfoAvailable)

	strSurveyTitle = utility_formEncode(strSurveyTitle)
	strDescription = utility_formEncode(strDescription)
	strCompletionMessage = utility_formEncode(strCompletionMessage)
	strCompletionRedirect = utility_formEncode(strCompletionRedirect)

	Dim strSQL
	Dim rsResults
	strSQL = "INSERT INTO usd_Survey " &_
			 "(surveyTitle, surveyDescription, surveyType, startDate, endDate, maxResponses, " &_
			 "responsesPerUser, completionMessage, completionRedirect, privacyLevel, " &_
			 "ownerUserID, allowContinue, resultsEmail, isActive, numberResponses," &_
			 " showProgress, isScored, logNTUser, numberLabels, templateID, editable, userInfoAvailable) " &_
			 "VALUES(" & utility_SQLEncode(strSurveyTitle, False) & "," &_
			 utility_SQLEncode(strDescription, False) & "," & intSurveyType & "," &_
			 utility_SQLDateEncode(dtmStartDate) & "," & utility_SQLDateEncode(dtmEndDate) &_
			 "," & utility_SQLEncode(intMaxResponses, True) & "," &_
			 utility_SQLEncode(intResponsesPerUser, True) & "," &_
			 utility_SQLEncode(strCompletionMessage, True) & "," &_
			 utility_SQLEncode(strCompletionRedirect, True) & "," &_
			 utility_SQLEncode(intPrivacyLevelID, True) & "," & intUserID & "," &_
			 utility_SQLEncode(abs(cint(boolAllowContinue)), True) & "," &_
			 utility_SQLEncode(strResultsEmail, True) & ",0,0," &_
			 utility_SQLEncode(abs(cint(boolShowProgress)), True) & "," &_
			 utility_SQLEncode(abs(cint(boolScored)), True) & "," &_
			 utility_SQLEncode(abs(cint(boolLogNTUser)),True) & "," &_
			 utility_SQLEncode(abs(cint(boolNumberLabels)),True) & "," &_
			 utility_SQLEncode(intTemplateID,True) & "," &_
			 utility_SQLEncode(abs(cint(boolEditable)), True) & "," &_
			 utility_SQLEncode(abs(cint(boolUserInfoAvailable)), True) &_
			  ")"

	Call utility_executeCommand(strSQL)
	'retrieve newly created survey's surveyID
	strSQL = "SELECT surveyID " &_
			 "FROM usd_Survey " &_
			 "WHERE surveyTitle = " & utility_SQLEncode(strSurveyTitle, False)
	Set rsResults = utility_getRecordset(strSQL)
	intSurveyIDOut = rsResults("surveyID")
	rsResults.Close
	Set rsResults = NOTHING
End Function

'************************************************************************************
'Name:			surveyCreation_titleExists
'
'Purpose:		returns true if a survey by inputted title already exists
'
'Inputs:		strSurveyTitle - title to check for existence
'************************************************************************************
Function surveyCreation_titleExists(strSurveyTitle)
	Dim strSQL
	strSQL = "SELECT surveyID " &_
			 "FROM usd_Survey " &_
			 "WHERE surveyTitle = " & utility_SQLEncode(strSurveyTitle, False)
	surveyCreation_titleExists = utility_checkForRecords(strSQL)
End Function



'**************************************************************************************
'Name:			surveyCreation_addItem
'
'Purpose:		add a new item to the survey
'
'Inputs:		intSurveyID - survey to add the item to
'				intItemType - type of item
'				strItemText - main text of item (for question, it is the actual question)
'				strDescription - subtext/description for question or item (optional)
'				intDataType - data type that response must be in (optional)
'				strMinimumValue - minimum value response must have (optional)
'				strMaximumValue - maximum value response can have (optional)
'				strDefaultValue - default value shown to user (optional)
'				boolRequired - whether or not user is required to answer question (optional)
'				boolAllowOther - whether or not user can choose "other" to answer question
'				strOtherText - text to describe "other" field
'				intPageID - page to add item to
'				intOrderByID - order for item to go in
'				intLayoutStyle - identifies how to output certain items on page (optional)
'				boolRandomize - whether or not to randomize answers
'				boolNumberLabels - whether or not to label each answer with a number
'				strQuestionAlias - alias of question for export purposes
'		
'Outputs:		intItemIDOut - unique ID of item added
'**************************************************************************************
Function surveyCreation_addItem(intSurveyID, intItemType, strItemText, strDescription, intDataType, _
				strMinimumValue, strMaximumValue, strDefaultValue, boolRequired, _ 
 				boolAllowOther, strOtherText, intPageID, intOrderByID, intLayouStyle, _
 				intItemIDOut, boolRandomize, boolNumberLabels, strQuestionAlias)
	Dim strSQL
	Dim strItemGUID
	Dim rsResults
	Dim intGraphType
	
	If intItemType = SV_ITEM_TYPE_CHECKBOXES Then
		intGraphType = SV_GRAPH_TYPE_COLUMN
	Else
		intGraphType = SV_GRAPH_TYPE_PIE
	End If
	
	strItemGUID = utility_createGUID()
	
	strItemText = utility_formEncode(strItemText)
	strDescription = utility_formEncode(strDescription)
	strMinimumValue = utility_formEncode(strMinimumValue)
	strMaximumValue = utility_formEncode(strMaximumValue)
	strDefaultValue = utility_formEncode(strDefaultValue)
	strOtherText = utility_formEncode(strOtherText)
		
	strSQL = "INSERT into usd_SurveyItem " &_
				"(surveyID, itemType, itemText, itemDescription, dataType, minimumValue, " &_ 
				"maximumValue, defaultValue, isRequired, allowOther, otherText, pageID, " &_
				"orderByID, layoutStyle, itemGUID, randomize, numberLabels, numberResponses, alias, graphType, conditional, numberRows, numberColumns) " &_
			 "VALUES(" & utility_SQLEncode(intSurveyID, False) & "," &_
			 utility_SQLEncode(intItemType, False) & "," &_ 
			 utility_SQLEncode(strItemText, True) &_
			 "," & utility_SQLEncode(strDescription, True) &_
			 "," & utility_SQLEncode(intDataType, True) &_
			 "," & utility_SQLEncode(strMinimumValue, True) &_
			 "," & utility_SQLEncode(strMaximumValue, True) &_
			 "," & utility_SQLEncode(strDefaultValue, True) &_
			 "," & utility_SQLEncode(abs(cint(boolRequired)), True) &_
			 "," & utility_SQLEncode(abs(cint(boolAllowOther)), True) &_
			 "," & utility_SQLEncode(strOtherText, True) &_
			 "," & utility_SQLEncode(intPageID, True) &_
			 "," & utility_SQLEncode(intOrderByID, True) &_
			  "," & utility_SQLEncode(intLayoutStyle, True) &_
			 "," & utility_SQLEncode(strItemGUID, True) &_
			 "," & utility_SQLEncode(abs(cint(boolRandomize)), True) &_
			 "," & utility_SQLEncode(abs(cint(boolNumberLabels)), True) & ",0," &_
			 utility_SQLEncode(strQuestionAlias, True) & "," & intGraphType & ",0,0,0)"

	 Call utility_executeCommand(strSQL)

	 strSQL = "SELECT itemID " &_
			  "FROM usd_SurveyItem " &_
			  "WHERE itemGUID = " & utility_SQLEncode(strItemGUID, False)
	 Set rsResults = utility_getRecordset(strSQL)
	 intItemIDOut = rsResults("itemID")
	 rsResults.Close
	 Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:			surveyCreation_getNextPageID
'
'Purpose:		gets next available pageID for specified survey
'
'Inputs:		intSurveyID - unique ID of survey to get pageID for
'**************************************************************************************
Function surveyCreation_getNextPageID(intSurveyID)
	Dim strSQL
	Dim rsResults
	'get highest current pageID for chosen survey
	strSQL = "SELECT max(pageID) as maxPageID " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE surveyID = " & intSurveyID
	Set rsResults = utility_getRecordset(strSQL)
	'if no pages for this survey exist
	If isNull(rsResults("maxPageID")) Then
		surveyCreation_getNextPageID = 1
	Else
		'add 1 to the current highest pageID
		surveyCreation_getNextPageID = rsResults("maxPageID") + 1
	End If
End Function

'**************************************************************************************
'Name:			surveyCreation_editSurvey
'
'Purpose:		edit basic survey information
'
'Inputs:		intSurveyID - unique ID of survey to edit
'				strSurveyTitle - title of survey
'				strDescription - description of survey (optional)
'				dtmStartDate - start date (optional)
'				dtmEndDate - end date (optional)
'				intMaxResponses - maximum total times survey can be responded to
'				intResponsesPerUser - number times each user can take survey
'				strCompletionMessage - message to be displayed when survey is completed
'				strCompletionRedirect - URL to redirect to when survey is completed
'				intPrivacyLevel - privacy level of survey results
'				boolAllowContinue - whether user can leave survey and come back and continue
'				strResultsEmail - email to send results to
'**************************************************************************************
Function surveyCreation_editSurvey(intSurveyID, strSurveyTitle, strDescription, _ 
							dtmStartDate, dtmEndDate, intMaxResponses, intResponsesPerUser, _
							strCompletionMessage, strCompletionRedirect, _
							intPrivacyLevel, boolAllowContinue, strResultsEmail, _
							boolShowProgress, boolScored, boolLogNTUser, boolEmailUser, boolNumberLabels, intTemplateID, boolEditable, boolUserInfoAvailable)

	strSurveyTitle = utility_formEncode(strSurveyTitle)
	strDescription = utility_formEncode(strDescription)
	strCompletionMessage = utility_formEncode(strCompletionMessage)
	strCompletionRedirect = utility_formEncode(strCompletionRedirect)

	Dim strSQL
	strSQL = "UPDATE usd_Survey " &_
			 "SET surveyTitle = " & utility_SQLEncode(strSurveyTitle, True) &_
			 ", surveyDescription = " & utility_SQLEncode(strDescription, True) &_
			  ", startDate = " & utility_SQLDateEncode(dtmStartDate) &_
			 ", endDate = " & utility_SQLDateEncode(dtmEndDate) &_
			 ", maxResponses = " & utility_SQLEncode(intMaxResponses, True) &_
			 ", responsesPerUser = " & utility_SQLEncode(intResponsesPerUser, True) &_
			 ", completionMessage = " & utility_SQLEncode(strCompletionMessage, True) &_
			 ", completionRedirect = " & utility_SQLEncode(strCompletionRedirect, True) &_
			 ", privacyLevel = " & utility_SQLEncode(intPrivacyLevel, True) &_
			 ", allowContinue = " & utility_SQLEncode(abs(cint(boolAllowContinue)), True) &_
			 ", resultsEmail = " & utility_SQLEncode(strResultsEmail, True) &_
			 ", showProgress = " & utility_SQLEncode(abs(cint(boolShowProgress)), True) &_
			 ", isScored = " & utility_SQLEncode(abs(cint(boolScored)), True) &_
			 ", logNTUser = " & utility_SQLEncode(abs(cint(boolLogNTUser)), True) &_
			 ", emailUser = " & utility_SQLEncode(abs(cint(boolEmailUser)), True) &_
			 ", numberLabels = " & utility_SQLEncode(abs(cint(boolNumberLabels)), True) &_
			 ", templateID = " & utility_SQLEncode(intTemplateID, True) &_
			 ", editable = " &  utility_SQLEncode(abs(cint(boolEditable)), True) &_
			 ", userInfoAvailable = " & abs(cint(boolUserInfoAvailable)) &_
			 " WHERE surveyID = " & intSurveyID
	Call utility_executeCommand(strSQL)
End Function

'**************************************************************************************
'Name:			surveyCreation_addAnswer
'
'Purpose:		add allowed answers to non-open ended questions
'
'Inputs:		intItemID - unique ID of item to add answers for
'				strAnswerText - text value of answer to add
'				boolDefault - whether this answer is selected by default
'				intPoints - point value of answer
'				strAlias - alias of answer for reporting purposed
'**************************************************************************************
Function surveyCreation_addAnswer(intItemID, strAnswerText, boolDefault, intPoints, strAlias, intOrderByID) 
	Dim strSQL
	
	strAnswerText = utility_formEncode(strAnswerText)
	
	strSQL = "SELECT answerID FROM usd_answers WHERE itemID = " & intItemID & " AND answerText = " & utility_SQLEncode(strAnswerText,True)
	If utility_checkForRecords(strSQL) = True Then
		strSQL = "UPDATE usd_Answers " &_
				 "SET orderByID = " & intOrderByID &_
				 ",isDefault = " & abs(cint(boolDefault)) &_
				 ",points = " & intPoints &_
				 ",alias = " & utility_SQLEncode(strAlias, True) &_
				 " WHERE answerText = " & utility_SQLEncode(strAnswerText,True)  &_
				 " AND itemID = " & intItemID
		Call utility_executeCommand(strSQL)

	Else
	
		strSQL = "INSERT INTO usd_Answers " &_
				 "(itemID, answerText, isDefault, points, alias, orderByID) " &_
				 "VALUES(" & utility_SQLEncode(intItemID, False) & "," &_
				 utility_SQLEncode(strAnswerText, False) & "," &_
				 utility_SQLEncode(abs(cint(boolDefault)), True) &_
				 "," & intPoints & "," &_
				 utility_SQLEncode(strAlias, True) & "," & intOrderByID & ")"
	
		Call utility_executeCommand(strSQL)
	End If
End Function

Function surveyCreation_addMatrixAnswer(intAnswerSetID, strAnswerText, boolDefault, intPoints, strAlias, intOrderByID)
	Dim strSQL
	
	If not utility_isPositiveInteger(intPoints) Then
		intPoints = 0
	End If
	
	strAnswerText = utility_formEncode(strAnswerText)
	
	strSQL = "SELECT matrixSetID FROM usd_matrixAnswers WHERE matrixSetID = " & intAnswerSetID &_
			 " AND answerText = " & utility_SQLEncode(strAnswerText, True)
			 
	If utility_checkForRecords(strSQL) = False Then			 
	
		strSQL = "INSERT INTO usd_MatrixAnswers " &_
				 "(matrixSetID, answerText, isDefault, points, alias, orderByID) " &_
				 "VALUES(" & intAnswerSetID & "," &_
				 utility_SQLEncode(strAnswerText, False) & "," &_
				 utility_SQLEncode(abs(cint(boolDefault)), True) &_
				 "," & intPoints & "," &_
				 utility_SQLEncode(strAlias, True) & "," & intOrderByID & ")"
	Else
	
		strSQL = "UPDATE usd_matrixAnswers " &_
				 "SET isDefault = " & utility_SQLEncode(abs(cint(boolDefault)), True) & "," &_
				 "points = " & intPoints & ",alias = " & utility_SQLEncode(strAlias, True) &_
				 ",orderByID=" & intOrderByID &_
				 " WHERE matrixSetID = " & intAnswerSetID & " AND answerText = " & utility_SQLEncode(strAnswerText, True)
	End If
	
	Call utility_executeCommand(strSQL)

End Function

'**************************************************************************************
'Name:			surveyCreation_displayItems
'
'Purpose:		display all items/questions for the survey
'
'Inputs:		intSurveyID - unique ID of survey to display items for
'				intPageID - page of items within survey to show
'**************************************************************************************
Function surveyCreation_displayItems(intSurveyID, intPageID, intTemplateID)
	Dim strSQL
	Dim rsResults
	Dim intItemID
	Dim intCurrentPageID
	Dim boolTableShown
	Dim intCounter
	Dim strCurrentPage
	Dim intItemType
	Dim intLastPageNumber
	Dim boolUseStandardUI
	Dim strHeader
	Dim strFooter
	Dim strBaseFont
	Dim strTitleColor
	Dim intTitleSize
	Dim strSurveyDescriptionColor
	Dim intSurveyDescriptionSize
	Dim strBackgroundColor
	Dim intQuestionSize
	Dim strQuestionColor
	Dim intQuestionDescriptionSize
	Dim strQuestionDescriptionColor
	Dim intAnswerSize
	Dim strAnswerColor
	Dim strOddRowColor
	Dim strEvenRowColor
	Dim strHeaderColor
	Dim boolHiddenFields
		
	intLastPageNumber = surveyCreation_getLastPageNumber(intSurveyID)
	
	strCurrentPage = "editSurvey.asp?surveyID=" & intSurveyID & "&pageID=" & intPageID
	
	boolHiddenFields = survey_hasHiddenFields(intSurveyID)
	
	strSQL = "SELECT itemID, itemType, pageID " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE surveyID = " & intSurveyID
			 
	If utility_isPositiveInteger(intPageID) Then
		strSQL = strSQL & " AND pageID = " & intPageID
	End If
	strSQL = strSQL & " ORDER BY pageID, orderByID "
	
	
	Set rsResults = utility_getRecordset(strSQL)
	
	boolTableShown = False
	intCounter = 0
	If not rsResults.EOF Then
		Do until rsResults.EOF
			intItemID = rsResults("itemID")
			intPageID = rsResults("pageID") 
			intItemType = rsResults("itemType")
			If intPageID <> intCurrentPageID Then
				intCounter = 0
				intCurrentPageID = intPageID
				If boolTableShown = True Then
%>							
							
						</td>
						</tr>
						</table>
						</td>
					</tr>
				</table>
<%
				End If
				boolTableShown = True

%>
				<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
					<tr>
						<td width="100%">
							<font size="2">
							<table border="2" cellspacing="1" style="border-collapse: collapse" bordercolor="#C0C0C0" width="100%">
							<tr>
							<td width="100%" bgcolor="#000000" height="25"><font color="#FFFFFF" SIZE="2">
							<b><span class="text-white">&nbsp;Page <%=intPageID%></span></b></font></td>
							      </tr>
							<tr>
								<td width="100%" bgcolor="#F0F0F0" height="20">
							<a href="addItem.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>">
								<img border="0" src="images/buttons-addtopage.gif" alt="Add To Page"></a>
<%
							If intPageID < intLastPageNumber and intLastPageNumber > 1 Then
%>
								<a href="pageBranching.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>">
									<img border="0" src="images/button-pageBranching.gif" alt="Edit Page Branching Rules"></a>
<%
							End If
%>
							<a href="copyPage.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>">
								<img border="0" src="images/button-copyPage.gif" alt="Copy Page"
								onclick="return confirmAction('Are you sure you want to copy this page?');"
								></a>
							<a href="deletePage.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>">
								<img border="0" src="images/button-deletePage.gif" alt="Delete Page"
								onclick="return confirmAction('Are you sure you want to delete this page?');"
								></a>
<%
							If intPageID > 1 or boolHiddenFields = True Then
%>
								<a class="normalBold" 
									href="managePageConditions.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>">
									<img border="0" src="images/buttons-pageconditions.gif" alt="Edit Page Conditions"></a>
					
<%
							End If
							
							If intLastPageNumber > 1 Then
%>
								<a class="normalBold" 
									href="movePage.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>">
									<img border="0" src="images/button-movePage.gif" alt="Move Page"></a>
<%
							End If

							If intPageID > 1 Then
%>
								<tr>
									<td>
										<%=surveyCreation_showConditions("", intPageID, intSurveyID, "")%>
									</td>
								</tr>		
<%
							End If							
						End If
%>
							
								</td>
							</tr>

<%
							intCounter = intCounter + 1
%>			
				
				
				<tr>
					<td width="100%">
					<font SIZE="2">
					<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
					<tr>
					 <td width="65">
					<font SIZE="2">
					
<%

			
							If intCounter <> 1 Then
%>
								<a href="<%=strCurrentPage%>&moveItem=<%=intItemID%>&direction=<%=SV_UP%>">
									<img border="0" src="images/button-up.gif" alt="Move Item Up" hspace="3"></a>
<%
							Else
%>
								<img border="0" src="images/spacer.gif" hspace="3" width="25" height="24">
<%
							End If

					If intItemID <> surveyCreation_getLastPageItemID(intSurveyID, intPageID) Then
%>
								<a href="<%=strCurrentPage%>&moveItem=<%=intItemID%>&direction=<%=SV_DOWN%>">
									<img border="0" src="images/button-down.gif" alt="Move Item Down" hspace="3"></a>
<%
					Else
%>
									<img border="0" src="images/spacer.gif" hspace="3" width="25" height="24">
<%
					End If	
%>

					</font></td>
					</font> 
					<td>
					
<%	
					
							Select Case intItemType
								Case SV_ITEM_TYPE_HEADER
									Call itemDisplay_displayHeader(intItemID)
								Case SV_ITEM_TYPE_MESSAGE
									Call itemDisplay_displayMessage(intItemID,0)
								Case SV_ITEM_TYPE_IMAGE
									Call itemDisplay_displayImage(intItemID)
								Case SV_ITEM_TYPE_LINE
									Call itemDisplay_displayLine()
								Case SV_ITEM_TYPE_HTML
									Call itemDisplay_displayHTML(intItemID)
								Case SV_ITEM_TYPE_TEXTAREA
									Call itemDisplay_displayTextArea(intItemID,0,False, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, strBaseFont, 0, False,"",0)
								Case SV_ITEM_TYPE_SINGLE_LINE
									Call itemDisplay_displaySingleLine(intItemID,0,False, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, strBaseFont, 0, False, "",0)
								Case SV_ITEM_TYPE_DATE
									Call itemDisplay_displayDate(intItemID,0,False, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, strBaseFont, 0, False,"",0)
								Case SV_ITEM_TYPE_CHECKBOXES
									Call itemDisplay_displayCheckboxes(intItemID, "",0,False, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, intAnswerSize, strAnswerColor, strBaseFont, 0, False,0)
								Case SV_ITEM_TYPE_RADIO
									Call itemDisplay_displayRadio(intItemID,0,False, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, intAnswerSize, strAnswerColor, strBaseFont, _
									0, False,"",0)
								Case SV_ITEM_TYPE_DROPDOWN
									Call itemDisplay_displayDropdown(intItemID,0,False, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, strBaseFont, 0, False,"",0)
								Case SV_ITEM_TYPE_MATRIX
									Call itemDisplay_displayMatrix(intItemID, "",0,False, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, intAnswerSize, strAnswerColor, strBaseFont, _
									0, False, False, strOddRowColor, strEvenRowColor, strHeaderColor,0,0)
							End Select
%>
				<br />
<%
				If intPageID > 1 Then
%>
					<%=surveyCreation_showConditions(intItemID, intPageID, intSurveyID, "")%>
<%
				End If
%>
				</td>
				<td width="100">
				 	<font SIZE="2">
				  <a class="normalBold"
								href="editItem.asp?surveyID=<%=intSurveyID%>&itemID=<%=intItemID%>&itemType=<%=intItemType%>&pageID=<%=intPageID%>">
							<img border="0" src="images/button-editItem.gif" alt="Edit Item" vspace="2" hspace="3"></a><br>
<%
				If intPageID > 1 or boolHiddenFields = True Then
%>
				  <a class="normalBold" 
					href="manageItemConditions.asp?surveyID=<%=intSurveyID%>&itemID=<%=intItemID%>&pageID=<%=intPageID%>">
					<img border="0" src="images/button-itemConditions.gif" alt="Edit Item Conditions" vspace="2" hspace="3"></a>
				 <br>
<%
				End If

				If not surveyCreation_inCondition(intItemID) Then
%>				
					<a class="normalBold" 
						href="<%=strCurrentPage%>&delete=<%=intItemID%>"
						onclick="javascript:return confirmAction('Are you sure you want to delete this item?');">
						<img border="0" src="images/button-deleteItem.gif" alt="Delete Item" vspace="2" hspace="3"></a>
<%
				Else
%>
					<a class="normalBold" 
						href="<%=strCurrentPage%>&delete=<%=intItemID%>"
						onclick="javascript:return confirmAction('There are items that are shown conditionally based on the response to this item.  All related conditions will be deleted.  Are you sure you want to delete this item?');">
						<img border="0" src="images/button-deleteItem.gif" alt="Delete Item" vspace="2" hspace="3"></a>
<%
				End If
				
				If not surveyCreation_inCondition(intItemID) Then
%>				
						<a class="normalBold" 
							href="moveToPage.asp?surveyID=<%=intSurveyID%>&itemID=<%=intItemID%>&orderByID=<%=intCounter%>&pageID=<%=intPageID%>">
							<img border="0" src="images/button-moveToPage.gif" alt="Move Item To Other Page" vspace="2" hspace="3"></a>
<%
				Else
%>
						<a class="normalBold" 
							href="moveToPage.asp?surveyID=<%=intSurveyID%>&itemID=<%=intItemID%>&orderByID=<%=intCounter%>&pageID=<%=intPageID%>"
							onclick="javascript:return confirmAction('There are items that are shown conditionally based on the response to this item.  Be cautious when moving this item');">
							<img border="0" src="images/button-moveToPage.gif" alt="Move Item To Other Page" vspace="2" hspace="3"></a>
<%
				End If
%>
						<a class="normalBold" 
							href="copyItem.asp?itemID=<%=intItemID%>&pageID=<%=intPageID%>&surveyID=<%=intSurveyID%>">
							<img border="0" src="images/button-copyItem.gif" alt="Copy Item" vspace="2" hspace="3"></a>
				</font></td>
				</tr>
				</table>
				</font> 
				</td>
				</tr>
				
			

								
				
<%
			rsResults.Movenext
		Loop
%>
				</td>
						</tr>
						</table>
						</td>
					</tr>
				</table>
		
<%
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:			surveyCreation_deleteItem
'
'Purpose:		delete an item from the survey
'
'Inputs:		intSurveyID - unique ID of survey the item is in, included to prevent accidental
'								deletions
'				intItemID - unique ID of the item to delete
'**************************************************************************************
Function surveyCreation_deleteItem(intSurveyID, intItemID)
	Dim strSQL
	Dim rsResults
	
	strSQL = "UPDATE usd_surveyItem SET orderByID = orderByID - 1 " &_
			 "WHERE pageID = (SELECT pageID FROM usd_surveyItem WHERE itemID = " & intItemID & ") AND surveyID = " & intSurveyID &_
			 " AND orderByID > (SELECT orderByID FROM usd_surveyItem WHERE itemID = " & intItemID & ")"
	Call utility_executeCommand(strSQL)
	
	strSQL = "DELETE FROM usd_SurveyItem " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " AND itemID = " & intItemID
	
	Call utility_executeCommand(strSQL)
	
	strSQL = "DELETE FROM usd_ConditionMapping " &_
			 "WHERE itemID = " & intItemID
	
	Call utility_executeCommand(strSQL)
	
	strSQL = "DELETE FROM usd_Answers " &_
			 "WHERE itemID = " & intItemID
	
	Call utility_executeCommand(strSQL)
	
	strSQL = "DELETE FROM usd_matrixCategories " &_
			 "WHERE itemID = " & intItemID
	
	Call utility_executeCommand(strSQL)
	
	strSQL = "SELECT conditionID " &_
			 "FROM usd_conditions " &_
			 "WHERE questionAnsweredID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF
			strSQL = "DELETE FROM usd_conditionMapping " &_
				     "WHERE conditionID = " & rsResults("conditionID")
			Call utility_executeCommand(strSQL)			   
			rsResults.MoveNext
		Loop
	End If
	
	rsResults.Close
	Set rsResults = NOTHING
	
	strSQL = "SELECT matrixSetID FROM usd_matrixSets WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF
			strSQL = "DELETE FROM usd_matrixAnswers WHERE matrixSetID = " & rsResults("matrixSetID")
			Call utility_executeCommand(strSQL)			   
			rsResults.MoveNext
		Loop
	End If
	
	rsResults.Close
	Set rsResults = NOTHING
	
	strSQL = "DELETE FROM usd_conditions " &_
			 "WHERE questionAnsweredID = " & intItemID
	Call utility_executeCommand(strSQL)	

	strSQL = "DELETE FROM usd_matrixSets " &_
			 "WHERE itemID = " & intItemID
	Call utility_executeCommand(strSQL)	
	
	strSQL = "DELETE FROM usd_branching WHERE itemID = " & intItemID
	Call utility_executeCommand(strSQL)
	

End Function

'**************************************************************************************
'Name:			surveyCreation_conditionForm
'
'Purpose:		form to add conditions to an item
'
'Inputs:		intSurveyID - unique ID of survey the item is in
'				intItemID - unique ID of the item to add condition to
'			    intPageID - unique ID of page item is in
'				strAction - action of form
'
'Outputs:		boolConditionsAvailable - whether or not this item can have conditions
'**************************************************************************************
Function surveyCreation_conditionForm(intSurveyID, intItemID, intPageID, strAction, boolConditionsAvailable)

Dim boolQuestionsExist
Dim boolGroupsExist
Dim boolConditionsExist
boolGroupsExist = surveyCreation_groupsExist(intItemID, intPageID, intSurveyID)
%>
<form method="post" action="<%=strAction%>"
		name="frmConditions">
		<table class="normal" border="0">
			<tr>
				<td align="left" class="normalBold-Big" width="175" valign="top">
					<%=common_helpLink("surveys/conditions/createNew.asp",SV_SMALL_HELP_IMAGE)%>Create New Condition
				</td>
				<td valign="top" class="normalBold" width="100">
					Question:
				</td>
				<td valign="top">
					<%=survey_questionsDropdown(intSurveyID, intItemID, intPageID, "frmConditions","questionID",boolQuestionsExist,0)%>
				</td>
			</tr>
<%
			If boolQuestionsExist Then
				boolConditionsAvailable = True
%>
				<tr>
					<td>
						&nbsp;
					</td>
					<td valign="top" class="normalBold">
						Operator:
					</td>
					<td valign="top">
						<%=survey_conditionTypeDropdown(0)%>
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td valign="top" class="normalBold">
						Value:
					</td>
					<td class="normalBold">
						<select name="answer">
							<option value="">Select a Value</option>
						</select>
						Other:<input type="text" name="conditionValue" size="30">
					</td>		
				</tr>
			</table>
<%
				If boolGroupsExist = True Then
%>
				<table>
					<tr>
						<td width="175">
							&nbsp;
						</td>
						<td valign="top" class="normalBold" width="100">
							Add to group:
						</td>
						<td valign="top">
							<%=surveyCreation_conditionGroupDropdown(intItemID, intSurveyID, intPageID)%>
						</td>
					</tr>
				</table>
<%
				End If
%>
			
			<hr noshade color="#C0C0C0" size="2">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td width="175">
						&nbsp;
					</td>
					<td>
						<input type="image" src="images/button-addCondition.gif" 
							alt="Add Condition" border="0">
						<input type="hidden" name="submit" value="Add Condition">
					</td>	
				</tr>
			</table>
			</form>
<%
			boolConditionsExist = surveyCreation_conditionsExist(intSurveyID)
			If boolConditionsExist = True Then
%>
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td width="175">
							&nbsp;
						</td>
						<td class="normalBold-Large">
							OR
						</td>
					</tr>
				</table>
				<form method="post" action="<%=strAction%>">
				<table>
					<tr>
						<td class="normalBold-Big" width="175">	
							<%=common_helpLink("surveys/conditions/addExisting.asp",SV_SMALL_HELP_IMAGE)%>Add existing condition
						</td>
						<td class="normalBold">
							Condition:
						</td>
						<td>	
							<%=surveyCreation_presetConditionsDropdown(intSurveyID)%>
						</td>
					</tr>
<%
				If boolGroupsExist = True Then
%>
					<tr>
						<td>
							&nbsp;
						</td>
						<td valign="top" class="normalBold">
							Add to Group:
						</td>
						<td valign="top">
							<%=surveyCreation_conditionGroupDropdown(intItemID, intSurveyID, intPageID)%>
						</td>
					</tr>
					
<%
				End If
%>
				</table>
				<hr noshade color="#C0C0C0" size="2">
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td width="175">
							&nbsp;
						</td>
						<td valign="top">
							<input type="hidden" name="preset" value="true">
							<input type="hidden" name="submit" value="Add Condition">
							<input type="image" src="images/button-addCondition.gif"
								alt="Add Condition">
						</td>	
					</tr>
				</table>
				</form>
<%
			End If
		Else
			boolConditionsAvailable = False				
		End If
%>
	<script language="javascript">
		<%=survey_answersDropdownJS(intSurveyID,"frmConditions","answer")%>
	</script>
<%
End Function

'**************************************************************************************
'Name:			surveyCreation_groupsExist
'
'Purpose:		check to see if groups exist for item or page
'
'Inputs:		intSurveyID - unique ID of survey to check for conditions
'**************************************************************************************
Function surveyCreation_groupsExist(intItemID, intPageID, intSurveyID)
	If not utility_isPositiveInteger(intItemID) Then
		strSQL = "SELECT top 1 conditionGroupID " &_
				 "FROM usd_conditionMapping " &_
				 "WHERE pageID = " & intPageID &_
				 " AND surveyID = " & intSurveyID
	Else
		strSQL = "SELECT top 1 conditionGroupID " &_
				 "FROM usd_conditionMapping " &_
				 "WHERE itemID = " & intItemID
	End If
	surveyCreation_groupsExist = utility_checkForRecords(strSQL)
End Function

'**************************************************************************************
'Name:			surveyCreation_conditionGroupDropdown(intItemID)
'
'Purpose:		create dropdown menu for user to choose condtion group to add condition to
'
'Inputs:		intItemID - unique ID of the item to add condition to (overrides intPageID)
'				intSurveyID - unique ID of survey page is in
'				intPageID - unique ID of page to add conditions to
'**************************************************************************************
Function surveyCreation_conditionGroupDropdown(intItemID, intSurveyID, intPageID)
	Dim strSQL
	Dim rsResults
	Dim intConditionGroupID
	If not utility_isPositiveInteger(intItemID) Then
		strSQL = "SELECT distinct(conditionGroupID) " &_
				 "FROM usd_conditionMapping " &_
				 "WHERE pageID = " & intPageID &_
				 " AND surveyID = " & intSurveyID
	Else
		strSQL = "SELECT distinct(conditionGroupID) " &_
				 "FROM usd_conditionMapping " &_
				 "WHERE itemID = " & intItemID
	End If
%>
	<select name="conditionGroup">
		<option value="">Create New Group</option>
<%
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF
			intConditionGroupID = rsResults("conditionGroupID")
%>
			<option	value="<%=intConditionGroupID%>"><%=intConditionGroupID%></option>
<%
			rsResults.MoveNext
		Loop
	End If	 
	rsResults.Close
	Set rsResults = NOTHING
%>
	</select>
<%
End Function


'**************************************************************************************
'Name:			surveyCreation_addItemCondition
'
'Purpose:		add a condition to an item
'
'Inputs:		intItemID - unique ID of item to add condition to
'				intSurveyID - unique ID of survey page is in
'				intPageID - unique ID of page to add conditions to
'				intQuestionID - unique ID of question to evaluate answer of
'				strConditionValue - text of condition to add
'				intConditionType - type of condition
'				intConditionGroupID - ID of group of conditions
'**************************************************************************************
Function surveyCreation_addCondition(intItemID, intSurveyID, intPageID, intQuestionID, strConditionValue, intConditionType, _
									intConditionGroupID, intAnswerID) 
	Dim strSQL
	Dim strGUID
	Dim rsResults
	strGUID = utility_createGUID()
	
	If not utility_isPositiveInteger(intAnswerID) Then
		intAnswerID = 0
	End If
	
	strSQL = "INSERT INTO usd_Conditions" &_
			 "(questionAnsweredID, conditionValue, conditionType, conditionGUID, answerID) " &_
			 "VALUES(" & intQuestionID & "," &_
				utility_SQLEncode(strConditionValue, False) & "," & intConditionType & "," &_
				utility_SQLEncode(strGUID, False) & "," & intAnswerID & ")"
	Call utility_executeCommand(strSQL)
	strSQL = "SELECT conditionID " &_
			 "FROM usd_Conditions " &_
			 "WHERE conditionGUID = " & utility_SQLEncode(strGUID, False)		 
	Set rsResults = utility_getRecordset(strSQL)
	Call surveyCreation_addPresetCondition(intItemID, intSurveyID, intPageID, rsResults("conditionID"), intConditionGroupID)
	rsResults.Close
	Set rsResults = NOTHING
	Call utility_executeCommand(strSQL)
End Function

'**************************************************************************************
'Name:			surveyCreation_deleteCondition
'
'Purpose:		delete a condition for an item
'
'Inputs:		intItemID - unique ID of item the condition is for, included to prevent 
'							accidental deletions
'				intConditionID - unique ID of the condition to delete
'				intConditionGroupID - ID of condition group for item
'**************************************************************************************
Function surveyCreation_deleteCondition(intItemID, intConditionID, intConditionGroupID)
	Dim strSQL
	strSQL = "DELETE FROM usd_conditionMapping " &_
			 "WHERE itemID = " & intItemID &_
			 " AND conditionID = " & intConditionID  &_
			 " AND conditionGroupID = " & intConditionGroupID
	
	Call utility_executeCommand(strSQL)
	
	strSQL = "UPDATE usd_surveyItem SET conditional = 0 WHERE itemID = " & intItemID
	Call utility_executeCommand(strSQL)
	
End Function

'**************************************************************************************
'Name:			surveyCreation_deletePageCondition
'
'Purpose:		delete a condition for a page
'
'Inputs:		intSurveyID - unique ID of survey page is in
'				intPageID - unique ID of page to delete condition for
'				intConditionID - unique ID of the condition to delete
'				intConditionGroupID - ID of condition group for page
'**************************************************************************************
Function survey_deletePageCondition(intSurveyID, intPageID, intConditionID, intConditionGroupID)
	Dim strSQL
	strSQL = "DELETE FROM usd_conditionMapping " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " AND pageID = " & intPageID &_
			 " AND conditionID = " & intConditionID &_
			 " AND conditionGroupID = " & intConditionGroupID
	
	Call utility_executeCommand(strSQL)
End Function
'**************************************************************************************
'Name:			surveyCreation_showConditions
'
'Purpose:		shows all current conditions for an item
'
'Inputs:		intItemID - unique ID of item to get conditions for
'				intPageID - unique ID of page the item is in
'**************************************************************************************
Function surveyCreation_showConditions(intItemID, intPageID, intSurveyID, strPage)
	Dim strSQL
	Dim rsResults
	Dim intConditionGroupID
	Dim intCurrentConditionGroupID
	Dim boolGroupDisplayed
	Dim intCounter
	Dim intGroupCounter
	strSQL = "SELECT C.conditionID, CM.conditionGroupID " &_
			 "FROM usd_Conditions C " &_
			 "INNER JOIN usd_ConditionMapping CM " &_
			 "ON C.conditionID = CM.conditionID " 
	
	If utility_isPositiveInteger(intItemID) Then
		strSQL = strSQL & "WHERE CM.itemID = " & intItemID 
	Else
		strSQL = strSQL & "WHERE CM.pageID = " & intPageID &_
						  " AND CM.surveyID = " & intSurveyID 
	End If 
		strSQL = strSQL & " ORDER by CM.conditionGroupID "
	
	Set rsResults = utility_getRecordset(strSQL)
	If rsResults.EOF Then
		If utility_isPositiveInteger(intItemID) Then
%>
			<span class="condition-text">
				There are no conditions.  This item will always be displayed. 
			</span>
<%
		Else
%>
			<span class="condition-text">
				There are no conditions.  This page will always be displayed. 
			</span>
<%
		End If
	Else
%>
		<table class="condition-text" border="0" cellspacing="0" cellpadding="2" width="100%">
			<tr>
				<td>
				
<%
		boolGroupDisplayed = False
		If utility_isPositiveInteger(intItemID) Then
%>
			<span class="normalBold">Item Conditions:</span>
<%
		Else
%>	
			<span class="normalBold">Page Conditions:</span>
<%
		End If

		Do until rsResults.EOF 
			intCounter = intCounter + 1
			intConditionGroupID = rsResults("conditionGroupID")
			If intCurrentConditionGroupID <> intConditionGroupID Then
				If boolGroupDisplayed = True Then
%>
					</td></tr></table>&nbsp;<span class="condition-text-bold">OR</span>
<%
				End If
	
				intCurrentConditionGroupID = intConditionGroupID
				boolGroupDisplayed = True	
				intGroupCounter = 0
%>
				<table class="condition-text" border="0" cellspacing="0" cellpadding="0" width="100%">
					<tr>
						<td colspan="2">
							If Group <%=intConditionGroupID%>:
						
				
<%
			End If	
			intGroupCounter = intGroupCounter + 1
			If intGroupCounter > 1 Then
%>
					<span class="condition-text-bold">AND</span>&nbsp;
<%
			End If
%>
					<%=surveyCreation_getConditionText(rsResults("conditionID"))%>
<%
				If strPage <> "" Then
%>
					<a onclick="javascript:return confirmAction('Are you sure you want to delete this condition?');"
						href="<%=strPage%>&delete=<%=rsResults("conditionID")%>&groupID=<%=intConditionGroupID%>">(Delete)</a>
<%
				Else
%>
					&nbsp;
<%			
				End If
			rsResults.MoveNext
		Loop
%>
				
		</td></tr></table></td></tr></table>
<%
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:			surveyCreation_getNextOrderByID
'
'Purpose:		get next order by ID for a page within a survey
'
'Inputs:		intSurveyID - unique ID of survey
'				intPageID - page ID to get next order by ID for
'**************************************************************************************
Function surveyCreation_getNextOrderByID(intSurveyID, intPageID)
	Dim strSQL
	Dim rsResults
	'get highest current orderID for chosen survey/page combo
	strSQL = "SELECT max(orderByID) as maxOrderByID " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " AND pageID = " & intPageID
	Set rsResults = utility_getRecordset(strSQL)
	'if no orderByID for this page exists
	If isNull(rsResults("maxOrderByID")) Then
		surveyCreation_getNextOrderByID = 1
	Else
		'add 1 to the current highest orderByID
		surveyCreation_getNextOrderByID = rsResults("maxOrderByID") + 1
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function


'**************************************************************************************
'Name:			surveyCreation_moveItem
'
'Purpose:		reorder item within a page in the survey
'
'Inputs:		intItemID - unique ID of item to move
'				intDirection - direction to move the item
'				intPageID - unique ID of page the item is in
'				intSurveyID - unique ID of survey item is in
'**************************************************************************************
Function surveyCreation_moveItem(intItemID, intDirection, intPageID, intSurveyID)
	Dim strSQL
	Dim rsResults
	Dim intOrderByID
	strSQL = "SELECT orderByID " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	intOrderByID = rsResults("orderByID")
	rsResults.Close
	Set rsResults = NOTHING
	
	If intDirection = SV_UP Then
		strSQL = "UPDATE usd_SurveyItem " &_
				 "SET orderByID = (orderByID + 1) " &_
				 "WHERE orderByID = " & (intOrderByID - 1) &_
				 " AND pageID = " & intPageID &_
				 " AND surveyID = " & intSurveyID
				 
		Call utility_executeCommand(strSQL)
		
		strSQL = "UPDATE usd_SurveyItem " &_
				 "SET orderByID = (orderByID - 1) " &_
				 "WHERE itemID = " & intItemID &_
				 " AND pageID = " & intPageID &_
				 " AND surveyID = " & intSurveyID
		
		Call utility_executeCommand(strSQL)
		
	ElseIf intDirection = SV_DOWN Then
		strSQL = "UPDATE usd_SurveyItem " &_
				 "SET orderByID = (orderByID - 1) " &_
				 "WHERE orderByID = " & (intOrderByID + 1) &_
				 " AND pageID = " & intPageID &_
				 " AND surveyID = " & intSurveyID
				 
		Call utility_executeCommand(strSQL)
		
		strSQL = "UPDATE usd_SurveyItem " &_
				 "SET orderByID = orderByID + 1 " &_
				 "WHERE itemID = " & intItemID &_
				 " AND pageID = " & intPageID &_
				 " AND surveyID = " & intSurveyID
		Call utility_executeCommand(strSQL)
	End If
End Function

'**************************************************************************************
'Name:			surveyCreation_deleteSurvey
'
'Purpose:		delete survey and everything related to it
'
'Inputs:		intSurveyID - unique ID of survey to delete
'**************************************************************************************
Function surveyCreation_deleteSurvey(intSurveyID)
	Dim strSQL
	strSQL = "DELETE FROM usd_Survey " &_
			 "WHERE surveyID = " & intSurveyID 
	Call utility_executeCommand(strSQL)
	
	strSQL = "DELETE FROM usd_Answers " &_
			 "WHERE itemID IN(" &_
			 "SELECT itemID FROM usd_surveyItem WHERE surveyID = " & intSurveyID & ")"
	Call utility_executeCommand(strSQL)

	strSQL = "DELETE FROM usd_matrixCategories " &_
			 "WHERE itemID IN(" &_
			 "SELECT itemID FROM usd_surveyItem WHERE surveyID = " & intSurveyID & ")"
	Call utility_executeCommand(strSQL)

	strSQL = "DELETE FROM usd_matrixAnswers WHERE matrixSetID IN(SELECT matrixSetID FROM usd_matrixSets WHERE itemID IN(SELECT itemID FROM usd_SurveyItem WHERE surveyID = " & intSurveyID & "))"
	Call utility_executeCommand(strSQL)

	strSQL = "DELETE FROM usd_matrixSets WHERE itemID IN(SELECT itemID FROM usd_SurveyItem WHERE surveyID = " & intSurveyID & ")"
	Call utility_executeCommand(strSQL)

	strSQL = "DELETE FROM usd_Conditions " &_
			 "WHERE questionAnsweredID IN(" &_
			 "SELECT itemID FROM usd_surveyItem WHERE surveyID = " & intSurveyID & ")"
	Call utility_executeCommand(strSQL)
	
	strSQL = "DELETE FROM usd_ConditionMapping " &_
			 "WHERE itemID IN(" &_
			 "SELECT itemID FROM usd_surveyItem WHERE surveyID = " & intSurveyID & ")"
	Call utility_executeCommand(strSQL)
	
	strSQL = "DELETE FROM usd_ConditionMapping " &_
			 "WHERE surveyID = " & intSurveyID 
	Call utility_executeCommand(strSQL)
	
	Call survey_clearResults(intSurveyID)

	Call survey_deleteAllResponsesInProgress(intSurveyID)
	
	strSQL = "DELETE FROM usd_SurveyItem " &_
			 "WHERE surveyID = " & intSurveyID
	Call utility_executeCommand(strSQL)
	
	strSQL = "DELETE FROM usd_invitedList " &_
			 "WHERE surveyID = " & intSurveyID
	Call utility_executeCommand(strSQL)
	
	strSQL = "DELETE FROM usd_RestrictedSurveyUsers " &_
			 "WHERE surveyID = " & intSurveyID
	Call utility_executeCommand(strSQL)
	
	strSQL = "DELETE FROM usd_scoringMessages " &_
			 "WHERE surveyID = " & intSurveyID
	Call utility_executeCommand(strSQL)

	strSQL = "DELETE FROM usd_branching " &_
			 "WHERE surveyID = " & intSurveyID
	Call utility_executeCommand(strSQL)
	
	Call survey_clearResults(intSurveyID)
End Function

'***************************************************************************************
'Name:			surveyCreation_inCondition
'
'Purpose:		returns true if there are items that are shown conditionally based on this item
'
'Inputs:		intItemID - item ID to check
'**************************************************************************************
Function surveyCreation_inCondition(intItemID)
	Dim strSQL
	strSQL = "SELECT conditionID " &_
			 "FROM usd_conditions " &_
			 "WHERE questionAnsweredID = " & intItemID
	surveyCreation_inCondition = utility_checkForRecords(strSQL)
End Function

'***************************************************************************************
'Name:			surveyCreation_isConditional
'
'Purpose:		returns true if the item is shown conditionally
'
'Inputs:		intItemID - item ID to check
'**************************************************************************************
Function surveyCreation_isConditional(intItemID)
	Dim strSQL
	strSQL = "SELECT conditionID " &_
			 "FROM usd_conditionMapping " &_
			 "WHERE itemID = " & intItemID
	surveyCreation_isConditional = utility_checkForRecords(strSQL)
End Function

'***************************************************************************************
'Name:			surveyCreation_changeActiveStatus
'
'Purpose:		activates or deactivates surveys
'
'Inputs:		intSurveyID - unique ID of survey to activate or deactivate
'				isActive - active status requested
'**************************************************************************************
Function surveyCreation_changeActiveStatus(intSurveyID, isActive)
	Dim strSQL
	strSQL = "UPDATE usd_Survey " &_
			 "SET isActive = " & cint(abs(isActive)) &_
			 " WHERE surveyID = " & intSurveyID
	Call utility_executeCommand(strSQL)
End Function

'**************************************************************************************
'Name:			surveyCreation_getNextConditionGroupID
'
'Purpose:		get next order condition group ID for an item
'
'Inputs:		intItemID - unique ID of item (overrided intPageID)
'				intSurveyID - unique ID of survey
'				intPageID - page ID to get next conditiongroup for
'**************************************************************************************
Function surveyCreation_getNextConditionGroupID(intItemID, intSurveyID, intPageID)
	Dim strSQL
	Dim rsResults
	'get highest current orderID for chosen survey/group combo
	strSQL = "SELECT max(conditionGroupID) as maxConditionGroupID " &_
			 "FROM usd_ConditionMapping "
	
	If utility_isPositiveInteger(intItemID) Then
		strSQL = strSQL & "WHERE itemID = " & intItemID
	Else
		strSQL = strSQL & "WHERE surveyID = " & intSurveyID &_
						  " AND pageID = " & intPageID
	End If
	Set rsResults = utility_getRecordset(strSQL)
	'if no orderByID for this group exists
	If isNull(rsResults("maxConditionGroupID")) Then
		surveyCreation_getNextConditionGroupID = 1
	Else
		'add 1 to the current highest orderByID
		surveyCreation_getNextConditionGroupID = rsResults("maxConditionGroupID") + 1
	End If
End Function

'**************************************************************************************
'Name:			surveyCreation_conditionsExist
'
'Purpose:		check to see if conditions exist in this survey
'
'Inputs:		intSurveyID - unique ID of survey to check for conditions
'**************************************************************************************
Function surveyCreation_conditionsExist(intSurveyID)
	Dim strSQL
	strSQL = "SELECT top 1 C.ConditionID " &_
			 "FROM usd_conditions C " &_
			 "INNER JOIN usd_conditionMapping CM " &_
			 "ON C.conditionID = CM.conditionID " &_
			 "WHERE CM.itemID " &_
			 "IN(Select itemID from usd_SurveyItem Where surveyID = " & intSurveyID & ")"
	surveyCreation_conditionsExist = utility_checkForRecords(strSQL)
End Function

'**************************************************************************************
'Name:			surveyCreation_presetConditionsDropdown
'
'Purpose:		create a dropdown menu of all conditions that exist for specified survey
'
'Inputs:		intSurveyID - uniqueID of survey to find conditions for
'
'Outputs:		boolConditionsExist - whether or not conditions exist for this survey already
'**************************************************************************************
Function surveyCreation_presetConditionsDropdown(intSurveyID)
	Dim strSQL
	Dim rsResults
	Dim intConditionID

	strSQL = "SELECT C.ConditionID " &_
			 "FROM usd_conditions C " &_
			 "INNER JOIN usd_conditionMapping CM " &_
			 "ON C.conditionID = CM.conditionID " &_
			 "WHERE CM.itemID " &_
			 "IN(Select itemID from usd_SurveyItem Where surveyID = " & intSurveyID & ")"
		
	

	
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
%>

			<select name="presetCondition">
<%
				Do until rsResults.EOF
					intConditionID = rsResults("conditionID")
%>
					<option value="<%=intConditionID%>">
						<%=surveyCreation_getConditionText(intConditionID)%>
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
'Name:			surveyCreation_getConditionText
'
'Purpose:		display textual representation of a condition
'
'Inputs:		intConditionID - unique ID of condition to find text for
'**************************************************************************************
Function surveyCreation_getConditionText(intConditionID)
	Dim strSQL
	Dim rsResults
	Dim intConditionType
	Dim strQuestionAnsweredText
	Dim strConditionTypeText
	
	strSQL = "SELECT questionAnsweredID, conditionType, conditionValue " &_
			 "FROM usd_conditions " &_
			 "WHERE conditionID = " & intConditionID
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		intConditionType = rsResults("conditionType")
		strQuestionAnsweredText = survey_getItemText(rsResults("questionAnsweredID"))
		strConditionTypeText = survey_getConditionTypeText(intConditionType)
		
		If intConditionType <> SV_CONDITION_DID_NOT_ANSWER _
			and intConditionType <> SV_CONDITION_ANSWERED Then
%>
			Answer to "<%=strQuestionAnsweredText%>"
						<span class="condition-text-bold"><%=strConditionTypeText%></span>&nbsp;
						<%=rsResults("conditionValue")%>
<%
		Else
%>
			User <span class="condition-text-bold"><%=strConditionTypeText%></span> "<%=strQuestionAnsweredText%>"
<%
		End If

	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:			surveyCreation_addPresetCondition
'
'Purpose:		add a condition that already exists to an item
'
'Inputs:		intItemID - unique ID of item to add condition to
'				intConditionID - unique ID of condition to add
'			    intConditionGroupID - ID of condition group within the set of conditions
'									  for the item
'**************************************************************************************
Function surveyCreation_addPresetCondition(intItemID, intSurveyID, intPageID, intConditionID, intConditionGroupID)
	Dim strSQL
	If utility_isPositiveInteger(intItemID) Then
		strSQL = "INSERT INTO usd_ConditionMapping" &_
				 "(conditionID, itemID, conditionGroupID) " &_
				 "VALUES(" & intConditionID & "," & intItemID & "," & intConditionGroupID & ")"
		
		Call utility_executeCommand(strSQL)	
		strSQL = "UPDATE usd_surveyItem SET conditional = 1 WHERE itemID = " & intItemID
		Call utility_executeCommand(strSQL)
		

	Else
		strSQL = "INSERT INTO usd_ConditionMapping" &_
				 "(conditionID, surveyID, pageID, conditionGroupID) " &_
				 "VALUES(" & intConditionID & "," & intSurveyID & "," & intPageID & "," &_
					intConditionGroupID & ")"
	End If
	Call utility_executeCommand(strSQL)

End Function

'**************************************************************************************
'Name:			surveyCreation_privacyLevelDropdown
'
'Purpose:		show dropdown of all possible privacy levels
'
'Inputs:		intDefaultPrivacyLevelID - ID of default privacy level (optional)
'**************************************************************************************
Function surveyCreation_privacyLevelDropdown(intDefaultPrivacyLevelID)
	Dim strSQL
	Dim rsResults
	Dim intPrivacyLevelID
	strSQL = "SELECT privacyLevelID, privacyLevelText " &_
				"FROM usd_privacyLevels " &_
				"ORDER by orderByID "
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
%>
		<select name="privacyLevel">
<%
		Do until rsResults.EOF
			intPrivacyLevelID = rsResults("privacyLevelID")
%>
			<option value="<%=intPrivacyLevelID%>"
<%
			If intPrivacyLevelID = intDefaultPrivacyLevelID Then
%>
				selected
<%
			End If
%>
			>
				<%=rsResults("privacyLevelText")%>
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
'Name:			surveyCreation_editItem
'
'
'Purpose:		edit an item in a survey
'
'Inputs:		intSurveyID - unique ID of survey to edit item in
'				intItemType - type of item
'				strItemText - main text of item (for question, it is the actual question)
'				strDescription - subtext/description for question or item (optional)
'				intDataType - data type that response must be in (optional)
'				strMinimumValue - minimum value response must have (optional)
'				strMaximumValue - maximum value response can have (optional)
'				strDefaultValue - default value shown to user (optional)
'				boolRequired - whether or not user is required to answer question (optional)
'				boolAllowOther - whether or not user can choose "other" to answer question
'				strOtherText - text to describe "other" field
'				intLayoutStyle - identifies how to output certain items on p
'				intItemID - unique ID of item to edit
'				boolRandomize - whether to randomize answer order
'				boolNumberLabels - whether or not to put numbers next to each answer
'				strQuestionAlias - alias of question for export purposes
'**************************************************************************************

Function surveyCreation_editItem(intSurveyID, intItemType, strItemText, strDescription, _
							intDataType, strMinimumValue, strMaximumValue, _
							strDefaultValue, boolRequired, boolAllowOther, _
							strOtherText, intLayoutStyle, intItemID, boolRandomize, boolNumberLabels, strQuestionAlias, intNumberRows, intNumberColumns)
	
	If intItemType <> SV_ITEM_TYPE_HTML Then
		strItemText = utility_formEncode(strItemText)					
	End If
	strDescription = utility_formEncode(strDescription)
	strMinimumValue = utility_formEncode(strMinimumValue)
	strMaximumValue = utility_formEncode(strMaximumValue)
	strDefaultValue = utility_formEncode(strDefaultValue)
	strOtherText = utility_formEncode(strOtherText)
		
	Dim strSQL
	
	strSQL = "UPDATE usd_SurveyItem " &_
			 "SET itemType = " & utility_SQLEncode(intItemType, True) & "," &_
			 "itemText = " & utility_SQLEncode(strItemText, True) & "," &_
			 "itemDescription = " & utility_SQLEncode(strDescription, True) & "," &_
			 "dataType = " & utility_SQLEncode(intDataType, True) & "," &_
			 "minimumValue = " & utility_SQLEncode(strMinimumValue, True) & "," &_
			 "defaultValue = " & utility_SQLEncode(strDefaultValue, True) & "," &_
			 "maximumValue = " & utility_SQLEncode(strMaximumValue, True) & "," &_
			 "isRequired = " & abs(cint(boolRequired)) & "," &_
			 "allowOther = " & abs(cint(boolAllowOther)) & "," &_
			 "otherText = " & utility_SQLEncode(strOtherText, True) & "," &_
			 "layoutStyle = " & utility_SQLEncode(intLayoutStyle, True) & "," &_
			 "randomize = " & abs(cint(boolRandomize)) & "," &_
			 " numberLabels = " & abs(cint(boolNumberLabels)) & "," &_
			 " alias = " & utility_SQLEncode(strQuestionAlias, True) & "," &_
			 " numberRows = " & intNumberRows & "," &_
			 " numberColumns = " & intNumberColumns &_			 
			 " WHERE itemID = " & intItemID &_
			 " AND surveyID = " & intSurveyID
	Call utility_executeCommand(strSQL)
	'strSQL = "DELETE FROM usd_Answers " &_
	'		 "WHERE itemID = " & intItemID
	Call utility_executeCommand(strSQL)
	strSQL = "DELETE FROM usd_matrixCategories " &_
			 "WHERE itemID = " & intItemID
	Call utility_executeCommand(strSQL)
End Function

'**************************************************************************************
'Name:			surveyCreation_updatePages
'
'
'Purpose:		update page numbers after item is deleted
'
'Inputs:		intSurveyID - unique ID of survey to update page numbers for
'**************************************************************************************
Function surveyCreation_updatePages(intSurveyID)
	Dim strSQL
	Dim rsResults
	Dim intPageID
	strSQL = "SELECT distinct pageID " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " ORDER by pageID"
	Set rsResults = utility_getRecordset(strSQL)
	intPageID = 0
	If not rsResults.EOF Then
		Do until rsResults.EOF
			If rsResults("pageID") - 1 > intPageID Then
				strSQL = "UPDATE usd_surveyItem " &_
						 "SET pageID = pageID - 1 " &_
						 "WHERE pageID > " & intPageID &_
						 " AND surveyID = " & intSurveyID
				Call utility_executeCommand(strSQL)
			End If
			intPageID = rsResults("pageID")
			rsResults.MoveNext
		Loop
	End If
End Function

'**************************************************************************************
'Name:			surveyCreation_getLastPageItemID
'
'Purpose:		get ID of last item in specified page
'
'Inputs:		intSurveyID - uniqueID of survey page is in
'				intPageID - page to find last item for
'**************************************************************************************
Function surveyCreation_getLastPageItemID(intSurveyID, intPageID)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT top 1 itemID " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " AND pageID = " & intPageID &_
			 " ORDER BY orderByID DESC "
	Set rsResults = utility_getRecordset(strSQL)
	'if no orderByID for this page exists
	If rsResults.EOF Then
		surveyCreation_getLastPageItemID = 0
	Else
		surveyCreation_getLastPageItemID = rsResults("itemID")
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:			surveyCreation_getLastPageNumber
'
'Purpose:		get ID of last item in specified page
'
'Inputs:		intSurveyID - uniqueID of survey page is in
'				intPageID - page to find last item for
'**************************************************************************************
Function surveyCreation_getLastPageNumber(intSurveyID)
	Dim strSQL
	Dim rsResults
	Dim intMaxPage
	strSQL = "SELECT max(pageID) as maxPage " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE surveyID = " & intSurveyID 
	Set rsResults = utility_getRecordset(strSQL)
	'if no orderByID for this page exists
	If rsResults.EOF Then
		intMaxPage = 0
	Else
		intMaxPage = rsResults("maxPage")
	End If
	rsResults.Close
	Set rsResults = NOTHING
	If not utility_isPositiveInteger(intMaxPage) Then
		intMaxPage = 0 
	End If
	surveyCreation_getLastPageNumber = intMaxPage
End Function

'**************************************************************************************
'Name:			surveyCreation_presetAnswerDropdown
'
'Purpose:		dropdown menu to add preset answer set to item
'
'Inputs:		intSurveyID - uniqueID of survey
'				intSelectedItemID - item ID to add answer set to
'**************************************************************************************
Function surveyCreation_presetAnswerDropdown(intSurveyID, intSelectedItemID)
	Dim strSQL
	Dim rsResults
	Dim strItemText
	Dim intItemID
	If not utility_isPositiveInteger(intSelectedItemID) Then
		intSelectedItemID = 0
	End If
	
	strSQL = "SELECT itemID, itemText " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " AND itemID <> " & intSelectedItemID &_
			 " AND itemType IN(" & SV_ITEM_TYPE_CHECKBOXES  &_
					"," & SV_ITEM_TYPE_RADIO & "," & SV_ITEM_TYPE_DROPDOWN & "," & SV_ITEM_TYPE_MATRIX & ")" 

	Set rsResults = utility_getRecordset(strSQL)
%>
	<select name="presetAnswerGroup">
<%
	If rsResults.EOF Then
%>
		<option value="0">Not Available</option>
<%
	Else
%>
			<option value="0"></option>
<%
		Do until rsResults.EOF
			intItemID = rsResults("itemID")
			strItemText = rsResults("itemText")
			If len(trim(strItemText)) > SV_DROPDOWN_MAX_LENGTH Then
				strItemText = mid(strItemText,1,SV_DROPDOWN_MAX_LENGTH) & "..."
			End If
			
%>
			<option value="<%=intItemID%>"><%=strItemText%></option>
<%
			rsResults.MoveNext
		Loop
%>
		</select>
<%	
	End If
End Function

Function surveyCreation_addBranch(intQuestionID, strResponse, intBranchPageID, intPageID, intSurveyID, intAnswerID)
	Dim strSQL
	strSQL = "INSERT INTO usd_branching(itemID, response, currentPage, nextPage, surveyID, answerID) " &_
			 "VALUES(" & intQuestionID & "," & utility_SQLEncode(strResponse, True) & "," &_
			 intPageID & "," & intBranchPageID & "," & intSurveyID & "," & intAnswerID & ")"
	Call utility_executeCommand(strSQL)
End Function


Function surveyCreation_addMatrixCategory(intItemID, strCategoryText, strCategoryAlias, intOrderByID)
	Dim strSQL
	
	strSQL = "SELECT itemID FROM usd_matrixCategories WHERE category = " & utility_SQLEncode(strCategoryText,True) & " AND itemID = " & intItemID
	
	If utility_checkForRecords(strSQL) = False Then
	
		strSQL = "INSERT INTO usd_matrixCategories(itemID, category, alias, orderByID) " &_
				 "VALUES(" & intItemID & "," & utility_SQLEncode(strCategoryText, True) &_
				 "," & utility_SQLEncode(strCategoryAlias, True) & "," & intOrderByID & ")"
	Else
	
		strSQL = "UPDATE usd_matrixCategories SET alias = " & utility_SQLEncode(strCategoryAlias, True) &_
				 ",orderByID = " & intOrderByID &_
				 " WHERE category = " & utility_SQLEncode(strCategoryText,True) & " AND itemID = " & intItemID
	End If
	
	Call utility_executeCommand(strSQL)
	
End Function

Function surveyCreation_templateDropdown(intTemplateID)
	Dim strSQL
	Dim rsResults
	Dim intTemplateFoundID
	Dim strTemplateName
	
	strSQL = "SELECT templateID, templateName FROM usd_styleTemplates ORDER BY templateName"
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
%>
		<select name="templateID">
<%
		Do until rsResults.EOF
			intTemplateFoundID = rsResults("templateID")
			strTemplateName = rsResults("templateName")
%>
				<option value="<%=intTemplateFoundID%>"
<%
			If intTemplateFoundID = cint(intTemplateID) Then
%>
					selected
<%
			End If
%>
					><%=strTemplateName%></option>
<%
			rsResults.MoveNext
		Loop
%>
		</select>
<%
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function surveyCreation_matrixLayoutDropdown(intLayoutType)
%>
	<select name="layoutStyle">
		<option value="<%=SV_MATRIX_LAYOUT_RADIO%>"
<%
		If intLayoutType = SV_MATRIX_LAYOUT_RADIO Then
%>		
			selected
<%
		End If
%>
		>
			Radio Buttons</option>
		<option value="<%=SV_MATRIX_LAYOUT_CHECKBOX%>"
<%
		If intLayoutType = SV_MATRIX_LAYOUT_CHECKBOX Then
%>		
			selected
<%
		End If
%>
		>
			Checkboxes</option>
		<option value="<%=SV_MATRIX_LAYOUT_DROPDOWN%>"
<%
		If intLayoutType = SV_MATRIX_LAYOUT_DROPDOWN Then
%>		
			selected
<%
		End If
%>
		>
			Dropdown Menus</option>
		<option value="<%=SV_MATRIX_LAYOUT_ALPHASCALE%>"
<%
		If intLayoutType = SV_MATRIX_LAYOUT_ALPHASCALE Then
%>
			selected
<%
		End If
%>
		>
			Adjective Scale</option>
<%
End Function

Function surveyCreation_addAnswerSet(intItemID, intAnswerSetType, boolRequired, strSetText)
	Dim strSQL
	Dim rsResults
	Dim strGUID
	Dim intOrderByID
	
	strSQL = "SELECT orderByID FROM usd_matrixSets WHERE itemID = " & intItemID & " ORDER BY orderByID DESC"
	
	Set rsResults = utility_getRecordset(strSQL)
	
	If rsResults.EOF Then
		intOrderByID = 1
	Else 
		intOrderByID = rsResults("orderByID") + 1
	End If
	
	rsResults.Close
		
	strGUID = utility_createGUID()
	
	strSQL = "INSERT INTO usd_matrixSets(itemID, matrixSetType, isRequired, setGUID, setText, orderByID, numberResponses, enforceUnique) " &_
			 "VALUES(" & intItemID & "," & intAnswerSetType & "," & abs(cint(boolRequired)) & "," & utility_SQLEncode(strGUID, True) & "," &_
					utility_SQLEncode(strSetText, True) & "," & intOrderByID & ",0,0)"
	
	Call utility_ExecuteCommand(strSQL)
	
	strSQL = "SELECT matrixSetID FROM usd_matrixSets WHERE setGUID = " & utility_SQLEncode(strGUID, True)
	
	rsResults.Open strSQL, DB_CONNECTION
	
	surveyCreation_addAnswerSet = rsResults("matrixSetID")
	
	rsResults.Close
	Set rsResults = NOTHING

End Function

Function surveyCreation_addHiddenField(intSurveyID, intHiddenFieldType, strQuestionText, strVariableName)
	strSQL = "INSERT INTO usd_surveyItem(surveyID, pageID, itemType, itemText, variableName) " &_
			 "VALUES(" & intSurveyID & ",0," & intHiddenFieldType & "," & utility_SQLEncode(strQuestionText, True) & "," &_
					utility_SQLEncode(strVariableName,True) & ")"
	Call utility_executeCommand(strSQL)
End Function

Function surveyCreation_editHiddenField(intHiddenFieldID, intHiddenFieldType, strQuestionText, strVariableName)
	strSQL = "UPDATE usd_surveyItem " &_
			 "SET itemType = " & intHiddenFieldType & "," &_
			 "itemText = " & utility_SQLEncode(strQuestionText, True) & "," &_
			 "variableName = " & utility_SQLEncode(strVariableName, True) &_
			 " WHERE itemID = " & intHiddenFieldID
	Call utility_executeCommand(strSQL)
	
End Function
%>




