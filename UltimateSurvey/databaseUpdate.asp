<%
Server.ScriptTimeout = 60000
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/reports_inc.asp"-->
<!--#INCLUDE FILE="Include/response_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%

	Dim rsResults
	Dim intItemID
	Dim intAnswerID
	Dim intMatrixSetID
	Dim intMatrixAnswerID
	Dim intCategoryID
	Dim strCategory
	
	strSQL = "SELECT itemID, answerID, answerText FROM usd_answers"
	Set rsResults = utility_getRecordset(strSQL)
	
	If not rsResults.EOF Then
		Do until rsResults.EOF
			intItemID = rsResults("itemID")
			intAnswerID = rsResults("answerID")
			strAnswerText = rsResults("answerText")
			
			strSQL = "UPDATE usd_itemResponses SET responseText = NULL, answerID = " & intAnswerID &_
					 " WHERE responseText LIKE " & utility_SQLEncode(strAnswerText, True) & " AND itemID = " & intItemID
			Call utility_executeCommand(strSQL)
	
			strSQL = "UPDATE usd_responseDetails SET response = NULL, answerID = " & intAnswerID &_
					 " WHERE response LIKE " & utility_SQLEncode(strAnswerText,True) & " AND itemID = " & intItemID
				
			Call utility_executeCommand(strSQL)	
			
			strSQL = "UPDATE usd_conditions SET answerID = " & intAnswerID &_
					 " WHERE questionAnsweredID = " & intItemID & " AND conditionValue LIKE " & utility_SQLEncode(strAnswerText,True)
			Call utility_executeCommand(strSQL)			 
				
			rsResults.MoveNext
		Loop
	End If
	
	rsResults.Close
	Set rsResults = NOTHING
	
	strSQL = "SELECT matrixSetID, matrixAnswerID, answerText FROM usd_matrixAnswers"
	Set rsResults = utility_getRecordset(strSQL)
	
	If not rsResults.EOF Then
		Do until rsResults.EOF
			intMatrixSetID = rsResults("matrixSetID")
			intMatrixAnswerID = rsResults("matrixAnswerID")
			strAnswerText = rsResults("answerText")
			
			strSQL = "UPDATE usd_itemResponses SET responseText = NULL, answerID = " & intMatrixAnswerID &_
					 " WHERE responseText LIKE " & utility_SQLEncode(strAnswerText, True) & " AND matrixSetID = " & intMatrixSetID
			Call utility_executeCommand(strSQL)
					
			strSQL = "UPDATE usd_responseDetails SET response = NULL, answerID = " & intMatrixAnswerID &_
					 " WHERE response LIKE " & utility_SQLEncode(strAnswerText,True) & " AND matrixSetID = " & intMatrixSetID			
			Call utility_executeCommand(strSQL)
					
			rsResults.MoveNext
		Loop
	End If
	
	rsResults.Close
	Set rsResults = NOTHING
	
	strSQL = "SELECT categoryID, itemID, category FROM usd_matrixCategories"
	Set rsResults = utility_getRecordset(strSQL)
	
	If not rsResults.EOF Then
		Do until rsResults.EOF
			intCategoryID = rsResults("categoryID")
			intItemID = rsResults("itemID")
			strCategory = rsResults("category")
			
			strSQL = "UPDATE usd_responseDetails SET matrixCategory = NULL, matrixCategoryID = " & intCategoryID &_
					 " WHERE matrixCategory LIKE " & utility_SQLEncode(strCategory, True) & " AND itemID = " & intItemID
			Call utility_executeCommand(strSQL)
			
			strSQL = "UPDATE usd_itemResponses SET category = NULL, matrixCategoryID = " & intCategoryID &_
					 " WHERE category LIKE " & utility_SQLEncode(strCategory, True) & " AND itemID = " & intItemID
			Call utility_executeCommand(strSQL)
					
			rsResults.MoveNext
						
		Loop
	End If
	
	rsResults.Close
	Set rsResults = NOTHING
	
	strSQL = "UPDATE usd_surveyItem SET conditional = 0"
	Call utility_executeCommand(strSQL)
	
	
	strSQL = "SELECT itemID FROM usd_conditionMapping WHERE itemID IS NOT NULL"
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF 
			strSQL = "UPDATE usd_surveyItem SET conditional = 1 WHERE itemID = " & rsResults("itemID")
			Call utility_executeCommand(strSQL)
			rsResults.MoveNext
		Loop
	End If
	rsResults.Close
	Set rsResults = NOTHING

	
	strSQL = "UPDATE usd_survey SET userInfoAvailable = 1"
	Call utility_executeCommand(strSQL)
	
	strSQL = "UPDATE usd_matrixSets SET enforceUnique = 0"
	Call utility_executeCommand(strSQL)
	
	strSQL = "SELECT emailCDONTS FROM usd_surveySettings WHERE emailCDONTS = 1"
	If utility_checkForRecords(strSQL) = True Then
		strSQL = "UPDATE usd_surveySettings SET emailObjectType = " & SV_EMAIL_CDONTS
		Call utility_executeCommand(strSQL)
	End If
	
	strSQL = "SELECT emailASPMail FROM usd_surveySettings WHERE emailASPMail = 1"
	If utility_checkForRecords(strSQL) = True Then
		strSQL = "UPDATE usd_surveySettings SET emailObjectType = " & SV_EMAIL_ASPMAIL
		Call utility_executeCommand(strSQL)
	End If
	
	strSQL = "SELECT emailJMail FROM usd_surveySettings WHERE emailJMail = 1"
	If utility_checkForRecords(strSQL) = True Then
		strSQL = "UPDATE usd_surveySettings SET emailObjectType = " & SV_EMAIL_JMAIL
		Call utility_executeCommand(strSQL)
	End If
	
	
	Response.Write "Update Complete"
%>