<%@language = "vbscript"%>
<%
Option Explicit
Response.Expires = -1
Response.Buffer = True	
Response.ContentType="TEXT/csv"
'page served as "export.csv"
Call Response.AddHeader("Content-disposition","inline;filename=export.csv")
Server.ScriptTimeout = 6000
'****************************************************
'
' Name:		executeExport.asp 
' Purpose:	exports survey data to excel spreadsheet
'
'
' Author:	    Ultimate Software Designs
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/response_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim intUserType
	Dim intUserID
	Dim intSurveyID
	Dim strSQL
	Dim rsResults
	Dim strResponse
	Dim boolAllowOther
	Dim strItemText
	Dim boolResponseDetails
	Dim boolUserDetails
	Dim intResponseID
	Dim intPoints
	Dim boolScored
	Dim boolLogNTUser
	Dim strNetworkUsername
	Dim boolAliases
	Dim intItemType
	Dim intItemID
	Dim boolSingleColumnCheckboxes
	Dim intLayoutStyle
	Dim arrItems
	Dim intCounter
	Dim rsResponse
	Dim rsCheckbox
	Dim intCurrentResponseID
	Dim intCurrentItemID
	Dim strSetText
	Dim boolOutput
	Dim boolOpenEndedQuestions
	
	Call user_loginNetworkUser()

	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = cint(Request.Form("surveyID"))

	If Request.Form("aliases") = "on" Then
		boolAliases = True
	End If

	If Request.Form("singleColumnCheckboxes") = "on" Then
		boolSingleColumnCheckboxes = True
	Else
		boolSingleColumnCheckboxes = False
	End If
	
	If Request.Form("openEndedQuestions") = "on" Then
		boolOpenEndedQuestions = True
	Else
		boolOpenEndedQuestions = False
	End If

	If utility_isPositiveInteger(intSurveyID) Then
		strSQL = "SELECT privacyLevel, isScored, logNTUser " &_
				 "FROM usd_Survey " &_
				 "WHERE surveyID = " & intSurveyID
		
		Set rsResults = utility_getRecordset(strSQL)
		Set rsResponse = server.CreateObject("ADODB.Recordset")
		Set rsCheckbox = server.CreateObject("ADODB.Recordset")	

		If not rsResults.EOF Then
			If rsResults("privacyLevel") = SV_PRIVACY_LEVEL_PRIVATE Then
				If ((survey_getOwnerID(intSurveyID) <> intUserID) _
				and intUserType = SV_USER_TYPE_CREATOR) _
				or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then 
					Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
				End If
			End If
			boolScored = cbool(rsResults("isScored"))
			boolLogNTUser = cbool(rsResults("logNTUser"))
			rsResults.Close
	
			If Request.Form("detailedResults") = "on" Then
				boolResponseDetails = True
			Else	
				boolResponseDetails = False
			End If
			
			If Request.Form("userDetails") = "on" Then
				boolUserDetails = True
			Else
				boolUserDetails = False
			End If
			
			If boolResponseDetails = True Then
				If boolUserDetails = True Then
					Response.Write "Username,  "
				End If
				
				Response.write "Date Started, Date Completed, Total Time (Minutes), User IP,"
				If boolScored = True Then
					Response.Write "Score,"
				End If
				If boolLogNTUser = True Then
					Response.Write "Network Username,"
				End If
			End If
			
			If boolUserDetails = True Then
				Response.Write "First Name, Last Name, Email, Title, Company, Location,"
			End If
			
			
			
			strSQL = "SELECT itemID, itemText, alias, itemType, allowOther, layoutStyle " &_
					 "FROM usd_SurveyItem " &_
					 "WHERE surveyID = " & intSurveyID &_
					 " AND itemType IN(" 
					 
					 If boolOpenEndedQuestions = True Then
						strSQL = strSQL & SV_ITEM_TYPE_TEXTAREA & "," & SV_ITEM_TYPE_SINGLE_LINE & "," 
					 End If
					 
					 strSQL = strSQL & SV_ITEM_TYPE_DATE & "," & SV_ITEM_TYPE_CHECKBOXES  &_
						"," & SV_ITEM_TYPE_RADIO & "," & SV_ITEM_TYPE_DROPDOWN & "," & SV_ITEM_TYPE_MATRIX & ")" &_
					 " ORDER BY pageID, orderByID " 
			
		
			
			rsResults.Open strSQL, DB_CONNECTION
			If not rsResults.EOF Then
				
				arrItems = rsResults.GetRows
			
				For intCounter = 0 To (Ubound(arrItems, 2) - LBound(arrItems, 2)) 
					intItemID = arrItems(0,intCounter)
					If boolAliases = True Then
						strItemText = arrItems(2,intCounter)
					Else
						strItemText = arrItems(1,intCounter)
					End If
					
					intItemType = arrItems(3,intCounter)
			
					intLayoutStyle = arrItems(5,intCounter)
			
					Select Case intItemType
						Case SV_ITEM_TYPE_CHECKBOXES
							boolAllowOther = cbool(arrItems(4,intCounter))
							Call write_checkboxes_header(intItemID, strItemText, boolAllowOther, boolSingleColumnCheckboxes)
						Case SV_ITEM_TYPE_MATRIX
							Call write_matrix_header(intItemID, strItemText)
						Case Else
							Response.Write """" & strItemText & ""","
					End Select
					
					'Response.Write """" & strItemText & ""","
					
				Next
				Response.Write vbcrlf
				
				

				
				rsResults.Close
				
				
				
				
				strSQL = "SELECT r.responseID, "
				
				If boolResponseDetails = True Then
					If boolUserDetails = True Then
						strSQL = strSQL & "U.username, "
					End If
					strSQL = strSQL & "R.userID, R.dateStarted, R.dateCompleted, R.userIP, R.NTUser, "
					
					If boolScored = True Then
							strSQL = strSQL & "R.points, "
					End If
				End If
				
				If boolUserDetails = True Then
					strSQL = strSQL & "U.firstName, U.lastName, U.email, U.title, U.company, U.location, "
				End If
				
				strSQL = strSQL & " MC.category, S.itemType, S.itemID " 
				strSQL = strSQL & " ,RD.matrixSetType  "
				
				
				If boolAliases = True Then
					strSQL = strSQL & ", A.alias as answerAlias, MA.alias as matrixAnswerAlias "
				End If
				
				strSQL = strSQL & ", RD.answerID, RD.response, A.answerText, MA.answerText as 'matrixAnswerText'  "
				
				
				strSQL = strSQL & " FROM usd_response R INNER JOIN  usd_surveyItem S ON S.surveyID = R.surveyID " &_
				"left outer join usd_responsedetails rd on rd.responseid = r.responseid and rd.itemid = s.itemid " &_
				" left outer join usd_answers A ON RD.answerID = A.answerID AND A.itemID = RD.itemID " &_
				" left outer join usd_matrixAnswers MA ON RD.answerID = MA.matrixAnswerID " &_
				" left outer join usd_matrixCategories MC ON RD.matrixCategoryID = MC.categoryID " 				
				
				If boolUserDetails = True or boolResponseDetails = True Then
					strSQL = strSQL & "LEFT OUTER JOIN usd_surveyUser U ON R.userID = U.userID "
				End If
				
				
				strSQL = strSQL & " WHERE r.surveyID = " & intSurveyID &_
								  " AND R.completed = 1 " &_
								  " AND S.itemType IN(" 
								  
								  If boolOpenEndedQuestions = True Then
									strSQL = strSQL & SV_ITEM_TYPE_TEXTAREA & "," & SV_ITEM_TYPE_SINGLE_LINE & ","
								  End If
								  
								  strSQL = strSQL & SV_ITEM_TYPE_DATE & "," & SV_ITEM_TYPE_CHECKBOXES  &_
								  "," & SV_ITEM_TYPE_RADIO & "," & SV_ITEM_TYPE_DROPDOWN & "," & SV_ITEM_TYPE_MATRIX & ")" &_
 								  " ORDER BY r.responseid, S.pageID, S.orderByID, RD.responseDetailID "


	
			Set rsResults = utility_getRecordset(strSQL)
			
			If not rsResults.EOF Then
				Dim boolComma
				Dim boolStarted
				Dim strCategory
				Dim strCurrentCategory
				Dim intAnswerID
				Dim intCurrentAnswerID
				Dim boolMoveNext
				Dim boolCloseQuotes
				Dim strAnswerText
				Dim intSetType
				Dim intMatrixCounter
				Dim dtmDateStarted
				Dim dtmDateCompleted
				Dim intTotalTime
						
				boolStarted = False
			
				boolOutput = False	
			
			Do until rsResults.EOF 
					intResponseID = rsResults("responseID")
					
					If intCurrentResponseID <> intResponseID Then
						intCurrentItemID = ""
						If boolStarted = True Then
							Response.Write """" & vbcrlf & """"
						Else
							Response.Write """"
							boolStarted = True
						End If
						If boolResponseDetails = True Then
							If boolUserDetails = True Then
								Response.Write rsResults("userName") & """,""" 
							End If
							
							dtmDateStarted = rsResults("dateStarted")
							dtmDateCompleted = rsResults("dateCompleted")
							intTotalTime = datediff("N",dtmDateStarted,dtmDateCompleted)
							
							Response.write dtmDateStarted & """,""" & dtmDateCompleted & """,""" & intTotalTime & """,""" &_
											rsResults("userIP")
											
							
							If boolScored = True Then
								Response.Write """,""" & rsResults("points")
							End If
							
							If boolLogNTUser = True Then
								Response.Write """,""" & rsResults("NTUser")
							End If
					
							
						End If
						
						If boolUserDetails = True Then
							If boolResponseDetails = True Then
								Response.Write ""","""
							End If
							Response.Write rsResults("firstName") & """,""" & rsResults("lastName") & """,""" & rsResults("email") & """,""" &_
									rsResults("title") & """,""" & rsResults("company") & """,""" & rsResults("location") 
						End If
						
						intCurrentResponseID = intResponseID		
					
						If boolResponseDetails = False and boolUserDetails = False Then
							boolComma = False
						Else
							boolComma = True
						End If	
						
					Else
						boolComma = True
					End If
			
					
					strCategory = rsResults("category")
					intItemType = rsResults("itemType")
					intItemID = rsResults("itemID")
					intSetType = rsResults("matrixSetType")
					intAnswerID = rsResults("answerID")
					
					If intItemType = SV_ITEM_TYPE_MATRIX and boolAliases = True Then
						strResponse = rsResults("matrixAnswerAlias")
					ElseIf (intItemType = SV_ITEM_TYPE_CHECKBOXES or intSetType = SV_MATRIX_LAYOUT_CHECKBOX) and boolSingleColumnCheckboxes = False Then
						strResponse = rsResults("response")
					
					ElseIf boolAliases = True and intItemType <> SV_ITEM_TYPE_SINGLE_LINE and intItemType <> SV_ITEM_TYPE_TEXTAREA Then
						strResponse = rsResults("answerAlias")
						If len(trim(strResponse)) = 0 Then
							strResponse = rsResults("matrixAnswerText")
						End If

						
					Else
						strResponse = rsResults("response")
						If len(trim(strResponse)) = 0 or isNull(strResponse) Then
							strResponse = rsResults("answerText")
						End If
						
						If len(trim(strResponse)) = 0 or isNull(strResponse) Then
							strResponse = rsResults("matrixAnswerText")
						End If
					End If
					
					
					
					
					If not utility_isPositiveInteger(intItemID) Then
						intItemID = 0
					End If
					
					If not utility_isPositiveInteger(intAnswerID) Then
						intAnswerID = 0
					End If
					
					If isNull(strCategory) Then
						strCategory = ""
					End If
					
				
				boolMoveNext = True
				
						
				If (intItemType = SV_ITEM_TYPE_CHECKBOXES and boolSingleColumnCheckboxes = False) or intSetType = SV_MATRIX_LAYOUT_CHECKBOX Then
					If boolComma = True Then
						Response.Write """,""" 
					End If
					If isNull(strResponse) and utility_isPositiveInteger(intAnswerID) = False Then
						Response.Write "0"
					Else
						Response.Write "1"
					End If
					
								
				ElseIf intItemType = SV_ITEM_TYPE_CHECKBOXES Then
					If intItemID <> intCurrentItemID Then
						If boolComma = True Then
							Response.Write ""","""
						End If
						
					End If	
									
					If len(trim(strResponse)) > 0 Then
						Response.write strResponse & ";"
					End If

				ElseIf intSetType = SV_MATRIX_LAYOUT_CHECKBOX Then
					If strCategory <> strCurrentCategory Then
						If boolComma = True Then
							Response.Write ""","""
						End If
						'Response.Write """"
					End If
					
					If len(trim(strResponse)) > 0 Then
						Response.write strResponse & ";"
					End If
				

				Else	
					If boolComma = True Then
						Response.Write ""","""
					End If
					
					If len(trim(strResponse)) > 0 Then
						Response.write strResponse
					End If
				End If
				
				intCurrentItemID = intItemID
				strCurrentCategory = strCategory	
			
				rsResults.MoveNext	
					
				Loop
				

				
			End If
			
			rsResults.Close
			Set rsResults = NOTHING
			
			End If
		End If

		Set rsResults = NOTHING
		Set rsResponse = NOTHING
		Set rsCheckbox = NOTHING

	End If	


Function writeCheckboxResponse(intItemID, intResponseID)
	Dim strSQL
	Dim rsResults
	Dim strAnswer
	
	strSQL = "SELECT answerText FROM usd_answers WHERE itemID = " & intItemID & " ORDER BY answerID"
	
	Set rsResults = utility_getRecordset(strSQL)	
	If not rsResults.EOF Then
		Do until rsResults.EOF 
			strAnswer = rsResults("answerText")
			strSQL = "SELECT responseID FROM usd_responseDetails WHERE responseID = " & intResponseID & " AND response LIKE " &_
						utility_SQLEncode(strAnswer, True)
			If utility_checkForRecords(strSQL) = True Then
				Response.Write """1"","
			Else
				Response.Write """0"","
			End If
			rsResults.MoveNext
		Loop
	End If

	rsResults.Close
	Set rsResults = NOTHING

End Function


Function write_matrix_header(intItemID, strItemText)
	Dim strCategory
	Dim strSetText
	Dim intMatrixSetType
	Dim intMatrixSetID
	Dim rsResults
	Dim strSQL
	Dim strCurrentCategory

	strSQL =	 "Select MC.category, MC.alias, MS.setText, MS.alias as setAlias, MS.matrixSetType, MS.matrixSetID " &_
				 "FROM usd_matrixCategories MC, usd_matrixSets MS " &_
				 "WHERE MC.itemID = " & intItemID &_
				 " AND MS.itemID = " & intItemID &_
				 " ORDER BY MC.categoryID, MS.matrixSetID"	
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF
			If boolAliases = True Then
				strCategory = rsResults("alias")
				strSetText = rsResults("setAlias")
			Else
				strCategory = rsResults("category")
				strSetText = rsResults("setText")
			End If
			
			intMatrixSetType = rsResults("matrixSetType")
			intMatrixSetID = rsResults("matrixSetID")
			If intMatrixSetType = SV_MATRIX_LAYOUT_CHECKBOX and strCurrentCategory <> strCategory and boolSingleColumnCheckboxes = False Then
				Call write_matrix_checkbox_header(intMatrixSetID, strItemText, strCategory, strSetText)
			Else
				Response.Write """" & strItemText & "_" & strCategory 
			
				If len(trim(strSetText)) > 0 Then
					Response.Write "_" & strSetText
				End If
			
				Response.Write ""","
			
			End If
			
			strCurrentCategory = strCategory
			
			rsResults.MoveNext
		Loop
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function


Function write_matrix_checkbox_header(intMatrixSetID, strItemText, strCategory, strSetText)
	Dim strSQL
	Dim rsResults
	Dim strAnswerText
	
	strSQL = "SELECT answerText, alias FROM usd_matrixAnswers WHERE matrixSetID = " & intMatrixSetID & " ORDER BY matrixAnswerID"

	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF
			If boolAliases = False Then
				strAnswerText = rsResults("answerText")
			Else
				strAnswerText = rsResults("alias")
			End If
			Response.Write """" & strItemText & "_" & strCategory & "_" & strSetText & "_" & strAnswerText & ""","
			
			rsResults.MoveNext
		Loop
	
	End If

End Function

Function write_matrix_header_backup(intItemID, strItemText)
	Dim strCategory
	Dim rsResults
	Dim strSQL
	If boolAliases = True Then
		strSQL = "SELECT alias as category " &_
				 "FROM usd_matrixCategories " &_
				 "WHERE itemID = " & intItemID &_
				 " ORDER by categoryID"
	Else
		strSQL = "SELECT category " &_
			 "FROM usd_matrixCategories " &_
			 "WHERE itemID = " & intItemID &_
			 " ORDER by categoryID"
	End If
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF
			strCategory = rsResults("category")
			Response.Write """" & strItemText & "_" & strCategory & ""","
			rsResults.MoveNext
		Loop
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function


Function write_checkboxes_header(intItemID, strItemText, boolAllowOther, boolSingleColumnCheckboxes)
	If boolSingleColumnCheckboxes = True Then
		Response.Write """" & strItemText & ""","
	Else
		Dim strSQL
		Dim rsResults
			
		If boolAliases = True Then
			strSQL = " SELECT alias as answerText " &_
					 "FROM usd_Answers " &_
					 "WHERE itemID = " & intItemID &_
					 " ORDER BY answerID"
		Else
			strSQL = "SELECT answerText " &_
				 "FROM usd_Answers " &_
				 "WHERE itemID = " & intItemID &_
				 " ORDER BY answerID"
		End If
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
			Do until rsResults.EOF
				Response.Write """" & strItemText & "_" & rsResults("answerText") & ""","
				rsResults.MoveNext
			Loop
		End If
		If boolAllowOther = True Then
			Response.Write """" & strItemText & "_other"","
		End If
	End If
End Function

Function write_responseDetails(intResponseID, intSurveyID, arrItems)
	Dim strSQL
	Dim strCategory
	Dim boolMultiple
	Dim intItemType
	Dim intLayoutStyle
		
	For intCounter = 0 To (Ubound(arrItems, 2) - LBound(arrItems, 2)) 
	
			intItemID = arrItems(0,intCounter)
			intItemType = arrItems(3,intCounter)
			intLayoutStyle = arrItems(5,intCounter)
	
			strSQL = "SELECT MC.category " &_
					 "FROM usd_matrixCategories MC " &_
					 "WHERE itemID = " & intItemID &_
					 " ORDER BY categoryID " 
			rsDetails.Open strSQL, DB_CONNECTION
					
			If not rsDetails.EOF Then
				Do until rsDetails.EOF
					strCategory = rsDetails("category")
				
					If intItemType <> SV_ITEM_TYPE_CHECKBOXES Then
						If intItemType = SV_ITEM_TYPE_MATRIX and intLayoutStyle = SV_MATRIX_LAYOUT_CHECKBOX Then
							boolMultiple = True
						Else
							boolMultiple = False
						End If
				
						Call write_responseItem(intItemID,intResponseID, strCategory, intItemType, boolMultiple)
					Else
						Call write_checkboxResponse(intItemID, intResponseID, boolAllowOther, boolSingleColumnCheckboxes, boolAliases)
					End If

				
					rsDetails.MoveNext
				Loop
			Else
				If intItemType <> SV_ITEM_TYPE_CHECKBOXES Then
					If intItemType = SV_ITEM_TYPE_MATRIX and intLayoutStyle = SV_MATRIX_LAYOUT_CHECKBOX Then
						boolMultiple = True
					Else
						boolMultiple = False
					End If
				
					Call write_responseItem(intItemID,intResponseID, strCategory, intItemType, boolMultiple)
				Else
					Call write_checkboxResponse(intItemID, intResponseID, boolAllowOther, boolSingleColumnCheckboxes, boolAliases)
				End If
			End If				
			rsDetails.Close
			
	
		Next

	Response.Write vbcrlf



End Function

Function write_responseItem(intItemID,intResponseID, strCategory, intItemType, boolMultiple)
	Dim strSQL
	Dim strResponse

	If boolAliases = True and (intItemType = SV_ITEM_TYPE_RADIO or intItemType = SV_ITEM_TYPE_DROPDOWN or _
						intItemType = SV_ITEM_TYPE_MATRIX) Then
		strSQL = "Select top 1 A.Alias as userResponse " &_
				 "From usd_answers A, usd_responseDetails RD " &_ 
				 "WHERE A.answerText LIKE RD.response " &_
				 " AND RD.itemID = A.itemID " &_
				 " AND RD.itemID = " & intItemID &_
				 " AND RD.responseID = " & intResponseID 
				 If len(trim(strCategory)) > 0 Then
					strSQL = strSQL & " AND RD.matrixCategory = " & utility_SQLEncode(strCategory, True)
				 End If
	

	Else
	
		strSQL = "SELECT response as userResponse " &_
				 "FROM usd_responseDetails " &_
				 "WHERE itemID = " & intItemID &_
				 " AND responseID = " & intResponseID 
				 If len(trim(strCategory)) > 0 Then
					strSQL = strSQL & " AND matrixCategory = " & utility_SQLEncode(strCategory, True)
				 End If
	End If
	
	Response.Write """"
	
	rsResponse.Open strSQL, DB_CONNECTION
	If not rsResponse.EOF Then
		Do until rsResponse.EOF
			strResponse = rsResponse("userResponse")
			If not isNull(strResponse) Then
				strResponse = replace(strResponse,vbcrlf," *break* ")
				strResponse = replace(strResponse,"""","""""")
				Response.Write strResponse 
				If boolMultiple = True Then 
					Response.Write ";"
				End	If
			End If
			rsResponse.MoveNext
		Loop
	End If
		
	rsResponse.Close

	Response.Write ""","

End Function

Function write_checkboxResponse(intItemID, intResponseID, boolAllowOther, boolSingleColumnCheckboxes, boolAliases)
	Dim strSQL
	Dim strResponse

	
	
	If boolSingleColumnCheckboxes = True Then
		Response.write """"
		
		strSQL = "SELECT response FROM usd_responseDetails WHERE responseID = " & intResponseID & " AND itemID = " & intItemID & " ORDER BY responseDetailID"
		rsResponse.Open strSQL, DB_CONNECTION
		If not rsResponse.EOF Then
			Do until rsResponse.EOF
				strResponse = rsResponse("response")
				If boolAliases = True Then	
					strResponse = survey_getAlias(intItemID, strResponse)
				End If
				Response.Write strResponse & ";"
				
				rsResponse.moveNext
			Loop	
		End If
		rsResponse.Close
		Set rsResponse = NOTHING
			
		Response.Write ""","
	Else
		strSQL = "SELECT answerText " &_
				 "FROM usd_answers " &_
				 "WHERE itemID = " & intItemID
		rsResponse.Open strSQL, DB_CONNECTION
		If not rsResponse.EOF Then
			Do until rsResponse.EOF 
				strResponse = rsResponse("answerText")
				If boolSingleColumnCheckboxes = True Then
					Response.Write strResponse & ";"
				Else
					Call write_checkboxResponseDetail(strResponse, intResponseID, intItemID)
				End If
				rsResponse.MoveNext
			Loop
		End If
		If boolAllowOther Then
			Call write_checkboxOtherResponse(intResponseID, intItemID)
		End If
		rsResponse.Close
		
	End If
End Function

Function write_checkboxResponseDetail(strResponse, intResponseID, intItemID)
	Dim strSQL
	
	strSQL = "SELECT responseID " &_
			 "FROM usd_responseDetails " &_
			 "WHERE itemID = " & intItemID &_
			 " AND response LIKE " & utility_SQLEncode(strResponse, True) &_
			 "AND responseID = " & intResponseID
	rsCheckbox.Open strSQL, DB_CONNECTION
	If not rsResults.EOF Then
		Response.Write "1"
	Else
		Response.Write "0"
	End If
	Response.Write ","
	rsCheckbox.Close
End Function

Function write_checkboxOtherResponse(intResponseID, intItemID)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT response " &_
			 "FROM usd_responseDetails " &_
			 "WHERE itemID = " & intItemID &_
			 " AND isOther = 1 "  &_
			 "AND isOther = 1 " &_
			 "AND responseID = " & intResponseID

	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Response.Write """" & rsResults("response") & """"
	End If
	Response.Write ","
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function write_responseInfo(intResponseID)
	Dim strSQL
	Dim rsResults
	Dim dtmDateStarted
	Dim dtmDateCompleted
	strSQL = "SELECT userID, dateStarted, dateCompleted, userIP, NTUser " &_
			 "FROM usd_response " &_
			 "WHERE responseID = " & intResponseID
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		dtmDateStarted = rsResults("dateStarted")
		dtmDateCompleted = rsResults("dateCompleted")
		Do until rsResults.EOF
			Response.Write """" & user_getUserName(rsResults("userID")) & """," & dtmDateStarted & "," & dtmDateCompleted 
			Response.Write "," & dateDiff("N",dtmDateStarted, dtmDateCompleted) & "," & rsResults("userIP") & ","
			If boolLogNTUser = True Then
				Response.Write rsResults("NTUser") & ","
			End If
			rsResults.MoveNext
		Loop
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function write_userInfo(intUserID)
	Dim strSQL
	Dim rsResults
	If utility_isPositiveInteger(intUserID) Then
		strSQL = "SELECT firstName, lastName, email, title, company, location " &_
				 "FROM usd_surveyUser " &_
				 "WHERE userID = " & intUserID
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
			Do until rsResults.EOF
				Response.Write """" & rsResults("firstName") & """,""" & rsResults("lastName") & """,""" & rsResults("email") & """,""" 
				Response.Write rsResults("title") & """,""" & rsResults("company") & """,""" & rsResults("location") & ""","
				rsResults.MoveNext
			Loop
		End If
		rsResults.Close
		Set rsResults = NOTHING
	Else
		Response.write ",,,,,,"
	End If
End Function
%>