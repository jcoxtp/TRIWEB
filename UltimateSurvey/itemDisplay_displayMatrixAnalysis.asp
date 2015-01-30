<%
'**************************************************************************************
'Name:			itemDisplay_displayMatrix
'
'Purpose:		make matrix type item and display on page
'
'Inputs:		intItemID - ID of item to make matrix out of
'				strJavaScript - javascript for required fields
'**************************************************************************************
Function itemDisplay_displayMatrix(intItemID, strJavaScript, intQuestionCounter, boolQuestionNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, intAnswerSize, strAnswerColor, strBaseFont, _
									intResponseID, boolEditing, boolCreating, strOddRowColor, strEvenRowColor, strHeaderColor, intItemCategoryID, intCurrentResponseID)
	Dim strSQL
	Dim rsResults
	Dim strItemText
	Dim strDescription
	Dim boolAllowOther
	Dim strOtherText
	Dim boolIsRequired
	Dim intLayoutStyle
	Dim objConnDB
	Dim intAnswerID
	Dim	strAnswerText
	Dim boolDefault
	Dim arrData       ' Array to Store Data
	Dim arrSequencer  ' Array to Hold Random Sequence
	Dim iArrayLooper  ' Integer for Looping
	Dim iArraySize    ' Size of Data Array
	Dim boolNumberLabels
	Dim intCounter
	Dim intCategoryID
	Dim strCategory
	Dim intCategoryCounter
	Dim intCounter2
	Dim varResponse
	Dim arrSets
	Dim intMatrixSetID
	Dim strSetText
	Dim intScaleStart
	Dim intScaleEnd
	Dim strScaleStartText
	Dim strScaleEndText
	Dim strAlias
	Dim intSetCounter
	Dim rsMatrix	
	Dim intMatrixSetType
	Dim boolSet
	Dim intNumberAnswers
	Dim boolRequired
	Dim intAnswerCounter
	Dim arrCategories
	Dim boolUnique
	Dim intCurrentCategoryID
	Dim intNumberCategories
	Dim i 
	Dim boolCategories
	Dim intPipedItemID1
	Dim intPipedItemID2
	Dim intPipedItemID3
	Dim intFieldLength
		
	intQuestionCounter = intQuestionCounter + 1
	
	strSQL = "SELECT itemText, itemDescription, isRequired, numberLabels, layoutStyle, pipedItemID1, pipedItemID2, pipedItemID3  " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	
	strItemText = rsResults("itemText")
	strDescription = rsResults("itemDescription")
	boolIsRequired = Cbool(rsResults("isRequired"))
	boolNumberLabels = Cbool(rsResults("numberLabels"))
	intLayoutStyle = rsResults("layoutStyle")
	
	If utility_isPositiveInteger(intCurrentResponseID) Then
		intPipedItemID1 = rsResults("pipedItemID1")
		intPipedItemID2 = rsResults("pipedItemID2")
		intPipedItemID3 = rsResults("pipedItemID3")
	
		If utility_isPositiveInteger(intPipedItemID1) Then
			strItemText = response_pipeAnswer(1,intCurrentResponseID, intPipedItemID1, strItemText)
			strDescription = response_pipeAnswer(1,intCurrentResponseID, intPipedItemID1, strDescription)
		End If
		
		If utility_isPositiveInteger(intPipedItemID2) Then
			strItemText = response_pipeAnswer(2,intCurrentResponseID, intPipedItemID2, strItemText)
			strDescription = response_pipeAnswer(2,intCurrentResponseID, intPipedItemID2, strDescription)
		End If
		
		If utility_isPositiveInteger(intPipedItemID3) Then
			strItemText = response_pipeAnswer(3,intCurrentResponseID, intPipedItemID3, strItemText)
			strDescription = response_pipeAnswer(3,intCurrentResponseID, intPipedItemID3, strDescription)
		End If
	End If
	
	rsResults.Close
	
%>	

		<font color="<%=strQuestionColor%>" face="<%=strBaseFont%>" size="<%=intQuestionSize%>">
<%	
		If boolIsRequired = True Then '1
%>
			<%=common_requiredFlag%>
<%
		End If 
		
		If boolQuestionNumberLabels = True Then '2
%>
			<%=intQuestionCounter%>.
<%
		End If 
%>
		<%=strItemText%></font>
<%
		If len(strDescription) > 0 Then
%>		
			<br />
			<font color="<%=strQuestionDescriptionColor%>" face="<%=strBaseFont%>" size="<%=intQuestionDescriptionSize%>">
				<%=strDescription%>
			</font>
<%
		End If
	
		If boolCreating = True Then
%>
			<br /><a href="#" class="normal" onclick="javascript:popup('editQuestionText.asp?surveyID=<%=intSurveyID%>&itemID=<%=intItemID%>&itemType=<%=SV_ITEM_TYPE_MATRIX%>&pageID=<%=intPageID%>&categoryID=<%=intItemCategoryID%>','text',0,1,0,0,0,0,600,400,100,100);return false;">
				Edit Question Text</a>
<%
		End If
%>

		<table cellpadding="0" cellspacing="0" border="1" width="100%">
			<tr bgcolor="<%=strHeaderColor%>">
				<td>
					&nbsp;
				</td>
<%

			
			strSQL = "SELECT categoryID, category, alias FROM usd_matrixCategories WHERE itemID = " & intItemID &_
					 " ORDER by orderByID, categoryID"
		
			Set rsResults = utility_getRecordset(strSQL)
			If not rsResults.EOF Then
				arrCategories = rsResults.GetRows
				boolCategories = True
			Else
				boolCategories = False
			End If
			rsResults.Close
			Set rsResults = NOTHING

			strSQL = "SELECT matrixSetID, setText, matrixSetType, scaleStart, scaleEnd, scaleStartText, scaleEndText, alias, isRequired, enforceUnique, fieldLength " &_
					 "FROM usd_matrixSets WHERE itemID = " & intItemID & " ORDER BY orderByID"
					 
			Set rsResults = utility_getRecordset(strSQL)
			If not rsResults.EOF Then '3 
				arrSets = rsResults.GetRows
				boolSet = True
			Else
				boolSet = False
			End If 
			rsResults.Close

			If boolSet = False Then
%>
				<td align="left">&nbsp;</td>
<%
			Else
			
			For intSetCounter = 0 to ubound(arrSets,2) '4
				intMatrixSetID = arrSets(0, intSetCounter)
				strSetText = arrSets(1, intSetCounter)
				intMatrixSetType = arrSets(2, intSetCounter)
				strScaleStartText = arrSets(5, intSetCounter)
				strScaleEndText = arrSets(6, intSetCounter)
				boolIsRequired = cbool(arrSets(8, intSetCounter))
				
				intNumberAnswers = survey_getNumberMatrixAnswers(intMatrixSetID)
				
				If utility_isPositiveInteger(intCurrentResponseID) Then
					If utility_isPositiveInteger(intPipedItemID1) Then
						strSetText = response_pipeAnswer(1,intCurrentResponseID, intPipedItemID1, strSetText)
					End If

					If utility_isPositiveInteger(intPipedItemID2) Then
						strSetText = response_pipeAnswer(2,intCurrentResponseID, intPipedItemID2, strSetText)
					End If
		
					If utility_isPositiveInteger(intPipedItemID3) Then
						strSetText = response_pipeAnswer(3,intCurrentResponseID, intPipedItemID3, strSetText)
					End If
				End If
%>
				
				<input type="hidden" name="numberAnswers<%=intItemID%>setID<%=intMatrixSetID%>" value="<%=intNumberAnswers%>">
				<td valign="top" align="center">
<%
						If boolCreating = True Then
%>
								<a class="normal" href="#" onclick="setPopup(<%=intMatrixSetID%>,<%=intMatrixSetType%>);return false;">Edit Set</a> /
								<a class="normal" href="editItem.asp?surveyID=<%=intSurveyID%>&itemID=<%=intItemID%>&itemType=<%=SV_ITEM_TYPE_MATRIX%>&pageID=<%=intPageID%>&deleteMatrixSet=<%=intMatrixSetID%>&categoryID=<%=intItemCategoryID%>"
									onclick="javascript:return confirmAction('Are you sure you want to delete this set?')">
									Delete
								</a><br />
<%
						End If
%>				
					<font color="<%=strAnswerColor%>" face="<%=strBaseFont%>" size="<%=intAnswerSize%>">
<%
						If boolIsRequired = True Then
%>
							<%=common_requiredFlag%>
<%
						End If
%>

						
						<%=strSetText%>
					</font>
					<br>

<%
					If intMatrixSetType <> SV_MATRIX_LAYOUT_SINGLE and intMatrixSetType <> SV_MATRIX_LAYOUT_DROPDOWN Then
						strSQL = "SELECT answerText " &_
								 "FROM usd_matrixAnswers " &_
								 "WHERE matrixSetID = " & intMatrixSetID &_
								 " ORDER by orderByID, matrixAnswerID"
								 
						rsResults.Open strSQL, DB_CONNECTION
						
						If not rsResults.EOF Then
							intAnswerCounter = 0
%>
							<table width="100%" cellspacing="0" cellpadding="0" border="0">
								<tr>
<%
							Do until rsResults.EOF
								intAnswerCounter = intAnswerCounter + 1
								strAnswerText = rsResults("answerText")
								
								If utility_isPositiveInteger(intCurrentResponseID) Then
		
									If utility_isPositiveInteger(intPipedItemID1) Then
										strAnswerText = response_pipeAnswer(1,intCurrentResponseID, intPipedItemID1, strAnswerText)
									End If

									If utility_isPositiveInteger(intPipedItemID2) Then
										strAnswerText = response_pipeAnswer(2,intCurrentResponseID, intPipedItemID2, strAnswerText)
									End If
		
									If utility_isPositiveInteger(intPipedItemID3) Then
										strAnswerText = response_pipeAnswer(3,intCurrentResponseID, intPipedItemID3, strAnswerText)
									End If
								End If
%>					
								 <td align="center" width="<%=100 / intNumberAnswers%>%">
									<font color="<%=strAnswerColor%>" face="<%=strBaseFont%>" size="<%=intAnswerSize%>">
<%
								If intAnswerCounter = 1 Then
%>
									<%=strScaleStartText%>
<%
								ElseIf intAnswerCounter = intNumberAnswers Then
%>
									<%=strScaleEndText%>
<%
								End If
%>
									<br /><%=strAnswerText%>
									</font>
								</td>
<%						
								rsResults.MoveNext
							Loop
%>
								</tr>

							</table>
<%
						End If
						
						rsResults.Close
						
					End If

%>					

				</td>

<%		
			Next	

			End If
%>				
		</tr>
<%



		If boolCategories = True Then	
			For intCategoryCounter = 0 to ubound(arrCategories,2)
				intCategoryID = arrCategories(0,intCategoryCounter)
				strCategory = arrCategories(1,intCategoryCounter)
				
				If utility_isPositiveInteger(intCurrentResponseID) Then
		
					If utility_isPositiveInteger(intPipedItemID1) Then
						strCategory = response_pipeAnswer(1,intCurrentResponseID, intPipedItemID1, strCategory)
					End If

					If utility_isPositiveInteger(intPipedItemID2) Then
						strCategory = response_pipeAnswer(2,intCurrentResponseID, intPipedItemID2, strCategory)
					End If
		
					If utility_isPositiveInteger(intPipedItemID3) Then
						strCategory = response_pipeAnswer(3,intCurrentResponseID, intPipedItemID3, strCategory)
					End If
				End If

				If (intCategoryCounter + 1) mod 2 = 1 Then
%> 
					<tr bgcolor="<%=strOddRowColor%>">
<%
				Else
%>
					<tr bgcolor="<%=strEvenRowColor%>">
<%				
				End If
					If boolSet = False Then 'TODO: Add new scale type to the conditions since this cell
													'		 will only contain a number with no text.
%>												
						<td width="250">
<%
					Else
%>					
						<td>
<%
					End If
%>			
						<font color="<%=strAnswerColor%>" face="<%=strBaseFont%>" size="<%=intAnswerSize%>">

<%
						If boolNumberLabels = True Then
%>
							<%=intCategoryCounter + 1%>.
<%	
						End If
%>
						<%=strCategory%></font>
						<input type="hidden" name="categoryID<%=intCategoryCounter + 1%>itemID<%=intItemID%>" value="<%=intCategoryID%>">
					</td>
<%
					
					If boolSet = False Then
%>
						<td align="left">&nbsp;</td>
<%					
					Else
					For intSetCounter = 0 to ubound(arrSets,2) 'Matrix can have more than one Answer Set
						intLayoutStyle = arrSets(2,intSetCounter)
						strSetText = arrSets(1, intSetCounter)
						intMatrixSetID = arrSets(0, intSetCounter)
						boolIsRequired = cbool(arrSets(8, intSetCounter))
						
						If boolEditing = True Then
							varResponse = response_getResponseText(intResponseID, intItemID, intMatrixSetID, intCategoryID)
						End If
						

%>
					<td>
						<table width="100%" border="0">
							<tr>
<%
								If intLayoutStyle = SV_MATRIX_LAYOUT_SINGLE Then
									intFieldLength = arrSets(10, intSetCounter)
									If not utility_isPositiveInteger(intFieldLength) Then
											intFieldLength = 20
									End If
%>
									<td align="center"><input type="text" value="<%=varResponse%>"
										name="item<%=intItemID%>category<%=intCategoryID%>setID<%=intMatrixSetID%>" size="<%=intFieldLength%>"></td>
<%
								End If							
						
						
						If boolIsRequired = True Then
								If intLayoutStyle = SV_MATRIX_LAYOUT_RADIO or intLayoutStyle = SV_MATRIX_LAYOUT_SCALE Then 'TODO: add new type
									strJavascript = strJavascript &_
												"myOption = -1;for (i=0; i<document.frmResponse.item" & intItemID & "category" & intCategoryID &_
												"setID" & intMatrixSetID & ".length; i++) {if (" &_
												"document.frmResponse.item" & intItemID & "category" & intCategoryID & "setID" & intMatrixSetID &_
												"[i].checked) {myOption = i;}}" &_
												"if (myOption == -1){alert(""Response is required for: " & strCategory & " in " 
												If len(strItemText) > 100 Then
													strJavaScript = strJavascript & utility_javascriptEncode(mid(strItemText,1,100)) & "...."
												Else
													strJavaScript = strJavascript & utility_javascriptEncode(strItemText)
												End If
													strJavascript = strJavascript & """);return false;}"	
								ElseIf intLayoutStyle = SV_MATRIX_LAYOUT_SINGLE Then
									strJavascript = strJavascript &_
												"if (document.frmResponse.item" & intItemID & "category" & intCategoryID & "setID" & intMatrixSetID &_
												".value == ''){alert(""Response is required for: " & strCategory & " in " 
												If len(strItemText) > 100 Then
													strJavaScript = strJavascript & utility_javascriptEncode(mid(strItemText,1,100)) & "...."
												Else
													strJavaScript = strJavascript & utility_javascriptEncode(strItemText)
												End If
													strJavascript = strJavascript & """);return false;}"	
									
								
								End If
							End If
		
						
						
						strSQL = "SELECT matrixAnswerID, answerText, isDefault " &_
								 "FROM usd_matrixAnswers " &_
								 "WHERE matrixSetID = " & intMatrixSetID &_
								 " ORDER by orderByID, matrixAnswerID"
				
						Set objConnDB = Server.CreateObject("ADODB.Connection")
						objConnDB.Open DB_CONNECTION
						Set rsMatrix = objConnDB.Execute(strSQL)

			
						If not rsMatrix.EOF Then
							arrData = rsMatrix.GetRows

							rsMatrix.close
							Set rsMatrix = NOTHING
							objConnDB.close
							Set objConnDB = Nothing
		
							
					
							If intLayoutStyle = SV_MATRIX_LAYOUT_DROPDOWN Then
%>
								<td align="center"><select name="item<%=intItemID%>category<%=intCategoryID%>setID<%=intMatrixSetID%>">
<%
							End If
	
							If boolSet = True Then
							
							For intCounter = 0 to ubound(arrData,2)
								intAnswerID = arrData(0, intCounter)
								strAnswerText  = arrData(1, intCounter)
								boolDefault = cbool(arrData(2, intCounter))
								
								Select Case intLayoutStyle
									Case SV_MATRIX_LAYOUT_RADIO 'TODO: Add SV_MATRIX_LAYOUT_RADIOSCALE to this case

						
%>
										<td valign="middle" align="center">
											<input 
												type="radio" 
												name="item<%=intItemID%>category<%=intCategoryID%>setID<%=intMatrixSetID%>"
<%
										If varResponse = intAnswerID Then
%>
											checked
<%
										ElseIf boolDefault = True and varResponse = "" Then
%>
											checked
<%
										End If
%>
											value="<%=intAnswerID%>">
											
										</td>
<%
									Case SV_MATRIX_LAYOUT_SCALE
						
%>
										<td valign="middle" align="center">
											<input 
												type="radio" 
												name="item<%=intItemID%>category<%=intCategoryID%>setID<%=intMatrixSetID%>"
<%
										If varResponse = intAnswerID Then
%>
											checked
<%
										ElseIf boolDefault = True and varResponse = "" Then
%>
											checked
<%
										End If
%>
											value="<%=intAnswerID%>">
										</td>
<%
									Case SV_MATRIX_LAYOUT_CHECKBOX
%>
										<td valign="middle" align="center">
											<input type="checkbox" name="item<%=intItemID%>category<%=intCategoryID%>counter<%=intCounter + 1%>setID<%=intMatrixSetID%>"
<%
											If boolEditing = True Then
												If response_checkCheckboxResponse(intResponseID, intItemID, intAnswerID, intMatrixSetID, intCategoryID) Then
%>
													checked
<%
												End If
											ElseIf boolDefault = True Then
%>
												checked
<%
											End If
%>
											>
											<input type="hidden" name="item<%=intItemID%>category<%=intCategoryID%>counter<%=intCounter + 1%>valuesetID<%=intMatrixSetID%>" 
												value="<%=intAnswerID%>">
										</td>
<%
									Case SV_MATRIX_LAYOUT_DROPDOWN
%>				
										<option value="<%=intAnswerID%>"
<%
											If varResponse = intAnswerID Then
%>
												selected
<%
											ElseIf boolDefault = True and varResponse = "" Then
%>
												selected
<%
											End If
%>				
										><%=strAnswerText%></option>
<%			
								End Select
							Next 	
							
							End If
	
							If intLayoutStyle = SV_MATRIX_LAYOUT_DROPDOWN Then
%>
								</select></td>
<%
							End If
						End If
%>
						
						</td></tr></table><!-- TODO: Add Right hand term from categories --></td>
<%
					Next
				End If
%>
					
				</tr>
<%
				
			Next
		

			If boolSet = True Then
			
			For intSetCounter = 0 to ubound(arrSets,2)
				boolUnique = cbool(arrSets(9,intSetCounter))
				If boolUnique = True Then
					intLayoutStyle = arrSets(2,intSetCounter)
					intMatrixSetID = arrSets(0, intSetCounter)
					strSetText = arrSets(1, intSetCounter)
					
				
					If intLayoutStyle = SV_MATRIX_LAYOUT_DROPDOWN or intLayoutStyle = SV_MATRIX_LAYOUT_SINGLE Then	
							For intCategoryCounter = 0 to ubound(arrCategories,2)
								intCurrentCategoryID = arrCategories(0,intCategoryCounter)		
								
								For intCounter = 0 to ubound(arrCategories,2)
									intCategoryID = arrCategories(0,intCounter)
									If intCategoryID <> intCurrentCategoryID Then
										strJavascript = strJavascript & "if (document.frmResponse.item" & intItemID & "category" & intCurrentCategoryID & "setID" & intMatrixSetID &_
														".value == document.frmResponse.item" & intItemID & "category" & intCategoryID & "setID" & intMatrixSetID & ".value) " &_
														"{alert(""Each response for " 
														If len(strSetText) > 0 Then
															strJavaScript = strJavascript & strSetText & " in the question "
														End If
														If len(strItemText) > 100 Then
															strJavaScript = strJavascript & utility_javascriptEncode(mid(strItemText,1,100)) & "...."
														Else
															strJavaScript = strJavascript & utility_javascriptEncode(strItemText)
														End If
															strJavascript = strJavascript & " must be unique."");return false;}"	
									End If
								Next
								
							
							Next
					ElseIf intLayoutStyle = SV_MATRIX_LAYOUT_RADIO or intLayoutStyle = SV_MATRIX_LAYOUT_SCALE Then
							intNumberCategories = intCategoryCounter
							For intCategoryCounter = 0 to ubound(arrCategories,2)
								intCurrentCategoryID = arrCategories(0,intCategoryCounter)		
								
								For intCounter = 0 to ubound(arrCategories,2)
									intCategoryID = arrCategories(0,intCounter)
									strJavascript = strJavascript & "for (i = 0;i<document.frmResponse.item" & intItemID & "category" & intCurrentCategoryID & "setID" & intMatrixSetID &_
											".length; i++){if (document.frmResponse.item" & intItemID & "category" & intCurrentCategoryID & "setID" & intMatrixSetID &_
											"[i].checked){radioValue = document.frmResponse.item" & intItemID & "category" & intCurrentCategoryID & "setID" & intMatrixSetID &_
											"[i].value;}};"

									If intCategoryID <> intCurrentCategoryID Then
										strJavascript = strJavascript & "for (i = 0;i<document.frmResponse.item" & intItemID & "category" & intCategoryID & "setID" & intMatrixSetID &_
											".length; i++){if (document.frmResponse.item" & intItemID & "category" & intCategoryID & "setID" & intMatrixSetID &_
											"[i].checked){if (document.frmResponse.item" & intItemID & "category" & intCategoryID & "setID" & intMatrixSetID &_
											"[i].value == radioValue) {alert(""Each response for " 
														If len(strSetText) > 0 Then
															strJavaScript = strJavascript & strSetText & " in the question "
														End If
														If len(strItemText) > 100 Then
															strJavaScript = strJavascript & utility_javascriptEncode(mid(strItemText,1,100)) & "...."
														Else
															strJavaScript = strJavascript & utility_javascriptEncode(strItemText)
														End If
															strJavascript = strJavascript & " must be unique."");return false;}}};"
									End If
								Next
								
							
							Next
					
					
					End If
				End If
			Next
		End If
		End If	
			If boolCreating = True Then
%>
				<table width="100%">
					<tr><td valign="left" valign="top">
						<a class="normal" href="#" onclick="javascript:popup('editMatrixCategories.asp?surveyID=<%=intSurveyID%>&itemID=<%=intItemID%>&itemType=<%=SV_ITEM_TYPE_MATRIX%>&pageID=<%=intPageID%>&categoryID=<%=intItemCategoryID%>','text',0,1,0,0,0,0,600,400,100,100);return false;">
							Edit Categories</a>
					</td><td valign="top" align="right" width="100">
					<select name="newSetType">
								<option value="<%=SV_MATRIX_LAYOUT_RADIO%>">Radio Buttons</option>
								<option value="<%=SV_MATRIX_LAYOUT_DROPDOWN%>">Dropdown Menus</option>
								<option value="<%=SV_MATRIX_LAYOUT_CHECKBOX%>">Checkboxes</option>
								<option value="<%=SV_MATRIX_LAYOUT_SINGLE%>">Single Line Inputs</option>
								<option value="<%=SV_MATRIX_LAYOUT_SCALE%>">Radio Button Scale</option>
								<!-- TODO: Add new answer set type option -->
							</select>
					<a class="normal" href="#"
						 onclick="setPopup(0,0);">
						 Add New Set</a></td></tr>
				</table>
<%
			End If	
%>
			<input type="hidden" name="numberCategories<%=intItemID%>" value="<%=intCategoryCounter%>">
			<input type="hidden" name="itemShown<%=intItemID%>" value="true">
			
<%
			If boolCreating = True Then
%>
				<script language="javascript">
					function setPopup(setID, setType)
					{
						if (setType == 0)
						{
							setType = document.frmItem.newSetType.value;
						} 
						var URL = 'editMatrixSet.asp?setID=' + setID + '&itemID=<%=intItemID%>&surveyID=<%=intSurveyID%>&itemType=<%=intItemType%>&pageID=<%=intPageID%>&categoryID=<%=intItemCategoryID%>&setType=' + setType;
						popup(URL,'sets',0,1,0,0,0,1,600,500,100,100);
					}
				</script>
<%	
			End If
%>
			</table>
<%
End Function
%>
