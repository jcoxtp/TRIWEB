<%
Function copy_matrixSets(intItemID, intNewItemID)
	Dim strSQL
	Dim rsSets
	Dim strGUID
	Dim intMatrixSetID
	Dim intNewMatrixSetID
	Dim rsResults



	strSQL = "SELECT matrixSetID, setText, matrixSetType, scaleStart, scaleEnd, scaleStartText, scaleEndText, alias, orderByID, isRequired, numberResponses, enforceUnique " &_
					 "FROM usd_matrixSets WHERE itemID = " & intItemID
			
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Set rsSets = server.CreateObject("ADODB.Recordset")
				
		Do until rsResults.EOF
			

			strGUID = utility_createGUID()
			intMatrixSetID = rsResults("matrixSetID")
			strSQL = "INSERT INTO usd_matrixSets(itemID, setText, matrixSetType, scaleStart, scaleEnd, scaleStartText, scaleEndText, alias, orderByID, isRequired, numberResponses, setGUID, enforceUnique) " &_
					 "VALUES(" & intNewItemID & "," & utility_SQLEncode(rsResults("setText"),True) & "," & rsResults("matrixSetType") & "," &_
					utility_SQLEncode(rsResults("scaleStart"),True) & "," & utility_SQLEncode(rsResults("scaleEnd"),True) & "," &_
					utility_SQLEncode(rsResults("scaleStartText"),True) & "," &_
					utility_SQLEncode(rsResults("scaleEndText"), True) & "," & utility_SQLEncode(rsResults("alias"),True) & "," &_
					rsResults("orderByID") & "," & utility_SQLEncode(rsResults("isRequired"),True) & ",0," & utility_SQLEncode(strGUID, True) & "," &_
					rsResults("enforceUnique") & ")" 
									
									
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
	Set rsResults = NOTHING

End Function
%>