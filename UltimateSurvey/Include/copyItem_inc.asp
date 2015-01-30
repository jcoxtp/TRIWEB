<%
'****************************************************
'
' Name:		copyItem_inc.asp Server-Side Include
' Purpose:		Provides functions relating to copying items in general
'
' Author:	      Ultimate Software Designs
' Date Written:	2/13/2003
' Modified:		
' Changes:
'****************************************************
Function copyItem_copyItem(intItemID, intSurveyID, intPageID, boolCopyConditions, intItemIDOut)
	Dim intNewOrderByID
	Dim strSQL
	Dim rsResults
	Dim strGUID
	Dim strCategory
	Dim strCategoryAlias
	Dim strItemDescription
	Dim strDefaultValue
	Dim intNewItemID
	Dim strAnswerText
	Dim strItemText
	
	intNewOrderByID = surveyCreation_getNextOrderByID(intSurveyID, intPageID)
		
	
	strSQL = "SELECT itemID, itemType, itemText, itemDescription, orderByID, isRequired, allowOther, otherText, " &_
		 "dataType, minimumValue, defaultValue, maximumValue, layoutStyle, randomize, numberLabels, numberResponses, graphType, conditional, numberRows, numberColumns " &_
		 "FROM usd_surveyItem WHERE itemID = " & intItemID

	Set rsResults = utility_getRecordset(strSQL)
		
	strGUID = utility_createGUID()
	strSQL = "INSERT INTO usd_surveyItem " &_
			"(surveyID, pageID, itemType, itemText, itemDescription, orderByID, isRequired, allowOther, " &_
			"otherText, dataType, minimumValue, defaultValue, maximumValue, layoutStyle, itemGUID, " &_
			"randomize, numberLabels, numberResponses, graphType, conditional, numberRows, numberColumns)" &_
			"VALUES(" & intSurveyID & "," & intPageID & "," &_
			rsResults("itemType") & "," 
					 
			strItemText = rsResults("itemText")
			strItemDescription = rsResults("itemDescription")
					 
			strSQL = strSQL & utility_SQLEncode(strItemText, True) & "," &_
			utility_SQLEncode(strItemDescription, True) & "," &_
			intNewOrderByID & "," &_
			rsResults("isRequired") & "," &_
			rsResults("allowOther") & "," &_
			utility_SQLEncode(rsResults("otherText"), True) & "," &_
			utility_SQLEncode(rsResults("dataType"), True) & "," &_
			utility_SQLEncode(rsResults("minimumValue"), True) & "," 
					 
			strDefaultValue = rsResults("defaultValue")
					 
			strSQL = strSQL & utility_SQLEncode(strDefaultValue, True) & "," &_
			utility_SQLEncode(rsResults("maximumValue"), True) & "," &_
			utility_SQLEncode(rsResults("layoutStyle"), True) & "," &_
			utility_SQLEncode(strGUID, True) & "," &_
			utility_SQLEncode(rsResults("randomize"), True) & "," &_
			utility_SQLEncode(rsResults("numberLabels"), True) & "," &_
			"0," & rsResults("graphType") & "," & utility_SQLEncode(rsResults("conditional"),True) & "," &_
			utility_SQLEncode(rsResults("numberRows"),True) & "," & utility_SQLEncode(rsResults("numberColumns"),True) & ")"
		Call utility_executeCommand(strSQL)
			
		rsResults.Close
			
		strSQL = "SELECT itemID " &_
					 "FROM usd_surveyItem " &_
					 "WHERE itemGUID = " & utility_SQLEncode(strGUID, True)
		rsResults.Open strSQL, DB_CONNECTION
		intNewItemID = rsResults("itemID")
		rsResults.Close
			
		strSQL = "SELECT answerText, isDefault, points, alias " &_
					 "FROM usd_answers " &_
					 "WHERE itemID = " & intItemID
		rsResults.Open strSQL, DB_CONNECTION
		If not rsResults.EOF Then
			Do until rsResults.EOF
				strAnswerText = rsResults("answerText")
				strSQL = "INSERT INTO usd_answers " &_
				         "(itemID, answerText, isDefault, points, alias) " &_
				         "VALUES(" & intNewItemID & "," &_
				         utility_SQLEncode(strAnswerText, True) & "," &_
				         utility_SQLEncode(rsResults("isDefault"), True) & "," &_
				         utility_SQLEncode(rsResults("points"), True) & "," &_
				         utility_SQLEncode(rsResults("alias"), True) & ")"
				 Call utility_executeCommand(strSQL)
				 rsResults.MoveNext
			Loop
		End If
			
		rsResults.Close
			
		strSQL = "SELECT category, alias " &_
					 "FROM usd_matrixCategories " &_
					 "WHERE itemID = " & intItemID &_
					 " ORDER by categoryID"
					 
		rsResults.Open strSQL, DB_CONNECTION
		If not rsResults.EOF Then
			Do until rsResults.EOF
				strCategory = rsResults("category")
				strCategoryAlias = rsResults("alias")
				strSQL = "INSERT INTO usd_matrixCategories (" &_
						 "itemID, category, alias) " &_
						 "VALUES(" & intNewItemID & "," &_
						 utility_SQLEncode(strCategory, True) & "," & utility_SQLEncode(strCategoryAlias, True) & ")"
				Call utility_executeCommand(strSQL)
				rsResults.MoveNext
			Loop
		End If
			
		rsResults.Close				
		
		strSQL = "SELECT matrixSetID, setText, matrixSetType, scaleStart, scaleEnd, scaleStartText, scaleEndText, alias, orderByID, isRequired, numberResponses, enforceUnique " &_
					 "FROM usd_matrixSets WHERE itemID = " & intItemID
			

	
	rsResults.Open strSQL, DB_CONNECTION
	If not rsResults.EOF Then
		Dim rsSets
		Dim intMatrixSetID
		Dim intNewMatrixSetID
		Set rsSets = server.CreateObject("ADODB.Recordset")
				
		Do until rsResults.EOF
			

			strGUID = utility_createGUID()
			intMatrixSetID = rsResults("matrixSetID")
			strSQL = "INSERT INTO usd_matrixSets(itemID, setText, matrixSetType, scaleStart, scaleEnd, scaleStartText, scaleEndText, alias, orderByID, isRequired, numberResponses, setGUID, enforceUnique) " &_
					 "VALUES(" & intNewItemID & "," & utility_SQLEncode(rsResults("setText"),True) & "," & rsResults("matrixSetType") & "," &_
					utility_SQLEncode(rsResults("scaleStart"),True) & "," & utility_SQLEncode(rsResults("scaleEnd"),True) & "," &_
					utility_SQLEncode(rsResults("scaleStartText"),True) & "," &_
					utility_SQLEncode(rsResults("scaleEndText"), True) & "," & utility_SQLEncode(rsResults("alias"),True) & "," &_
					rsResults("orderByID") & "," & utility_SQLEncode(rsResults("isRequired"),True) & ",0," & utility_SQLEncode(strGUID, True) & "," & rsResults("enforceUnique") & ")" 
									
									
			Call utility_executeCommand(strSQL)			
							
			strSQL = "SELECT matrixSetID FROM usd_matrixSets WHERE setGUID = " & utility_SQLEncode(strGUID, True)
							
			rsSets.Open strSQL, DB_CONNECTION
			If not rsSets.EOF Then
				intNewMatrixSetID = rsSets("matrixSetID")
			End If
							
			rsSets.Close
					
			If utility_isPositiveInteger(intNewMatrixSetID) Then
				strSQL = "SELECT answerText, alias, points, isDefault FROM usd_matrixAnswers WHERE matrixSetID = " & intMatrixSetID &_
						 " ORDER BY matrixAnswerID"
								
				rsSets.Open strSQL, DB_CONNECTION
				If not rsSets.EOF Then
					Do until rsSets.EOF
						strSQL = "INSERT INTO usd_matrixAnswers(matrixSetID, answerText, alias, points, isDefault) " &_
								 "VALUES(" & intNewMatrixSetID & "," & utility_SQLEncode(rsSets("answerText"),True) & "," &_
								  utility_SQLEncode(rsSets("alias"),True) & "," & utility_SQLEncode(rsSets("points"),True) & "," &_
								  utility_SQLEncode(rsSets("isDefault"),True) & ")"
										
						Call utility_executeCommand(strSQL) 
							
							
						rsSets.MoveNext
					Loop
				End If
				rsSets.Close
			End If
	
			rsResults.MoveNext
		Loop
	End If
	
	rsResults.Close


		
			
		If boolCopyConditions Then
			strSQL = "SELECT conditionID, conditionGroupID " &_
					 "FROM usd_conditionMapping " &_
					 "WHERE itemID = " & intItemID
			rsResults.Open strSQL, DB_CONNECTION
			If not rsResults.EOF Then
				Do until rsResults.EOF 
					strSQL = "INSERT INTO usd_conditionMapping " &_	
							 "(conditionID, itemID, conditionGroupID) " &_
							 "VALUES(" & rsResults("conditionID") & "," & intNewItemID & "," &_
							 rsResults("conditionGroupID") & ")"
					Call utility_executeCommand(strSQL)
				rsResults.MoveNext
			Loop
			End If
			rsResults.Close
		End If
	
		Set rsResults = NOTHING		
		
		Call surveyCreation_updatePages(intSurveyID)
		
		intItemIDOut = intNewItemID
End Function
%>


