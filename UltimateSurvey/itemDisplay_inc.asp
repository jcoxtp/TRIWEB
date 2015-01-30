<%
'****************************************************
'
' Name:			itemDisplay_inc.asp Server-Side Include
' Purpose:		Provides functions to display items of various types
'
' Date Written:	  10/08/2002
' Modified:		
'
'****************************************************

'**************************************************************************************
'Name:			itemDisplay_displayImage
'
'Purpose:		make image type item and display on page
'
'Inputs:		intItemID - ID of item to display image for
'**************************************************************************************
Function itemDisplay_displayImage(intItemID)
	Dim strSQL
	Dim rsResults
	Dim strText
	strSQL = "SELECT itemText  " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
%>
		<img src="<%=rsResults("itemText")%>" border="0" />
<%
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function


'**************************************************************************************
'Name:			itemDisplay_displayRadio
'
'Purpose:		make radio button type item and display on page
'
'Inputs:		intItemID - ID of item to make radio buttons out of
'**************************************************************************************
Function itemDisplay_displayRadio(intItemID, intQuestionCounter, boolQuestionNumberLabels, intQuestionSize, strQuestionColor, _
						intQuestionDescriptionSize, strQuestionDescriptionColor, intAnswerSize, strAnswerColor, strBaseFont, _
						intResponseID, boolEditing, strJavascript, intCurrentResponseID)
	Dim strSQL
	Dim rsResults
	Dim strItemText
	Dim strDescription
	Dim boolAllowOther
	Dim strOtherText
	Dim boolIsRequired
	Dim intLayoutStyle
	Dim boolRandomize
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
	Dim varResponse
	Dim boolDefaulted
	Dim intPipedItemID1
	Dim intPipedItemID2
	Dim intPipedItemID3
	Dim intOrderByID
	
	intQuestionCounter = intQuestionCounter + 1
	
	If utility_isPositiveInteger(intResponseID) and boolEditing = True Then
		varResponse = response_getResponseText(intResponseID, intItemID,0,0)
	
	Else 'TRI++: Added in order to enable backward and forward paging -- mlp, 9/27/2006
	
		If utility_isPositiveInteger(intCurrentResponseID) Then
			varResponse = response_getResponseText(intCurrentResponseID, intItemID,0,0)
		End If
	
	End If
	
	strSQL = "SELECT itemText, itemDescription, allowOther, otherText, isRequired, layoutStyle, randomize, numberLabels, pipedItemID1, pipedItemID2, pipedItemID3  " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	
	strItemText = rsResults("itemText")
	strDescription = rsResults("itemDescription")
	boolAllowOther = Cbool(rsResults("allowOther"))
	strOtherText = rsResults("otherText")
	boolIsRequired = Cbool(rsResults("isRequired"))
	intLayoutStyle = rsResults("layoutStyle")
	boolRandomize = Cbool(rsResults("randomize"))
	boolNumberLabels = Cbool(rsResults("numberLabels"))
	
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
	<p>
		<font color="<%=strQuestionColor%>" face="<%=strBaseFont%>" size="<%=intQuestionSize%>">
<%	
		If boolIsRequired = True Then
			strJavascript = strJavascript &_
				" myOption = -1;for (i=0; i<document.frmResponse.item" & intItemID &_
				".length; i++) {if (" &_
				"document.frmResponse.item" & intItemID &_
				"[i].checked) {myOption = i;}}" &_
				"if (myOption == -1){alert(""Response is required for: " 
				If len(strItemText) > 100 Then
					strJavaScript = strJavascript & utility_javascriptEncode(mid(strItemText,1,100)) & "...."
				Else
					strJavaScript = strJavascript & utility_javascriptEncode(strItemText)
				End If
				strJavascript = strJavascript & """);return false;}"
%>
			<%=common_requiredFlag%>
<%
		End If
		
		If boolQuestionNumberLabels = True Then
%>

			<%=intQuestionCounter%>.
<%
		End If
%>
		<%=strItemText%>
		</font><br />
		<font color="<%=strQuestionDescriptionColor%>" face="<%=strBaseFont%>" size="<%=intQuestionDescriptionSize%>">
			<%=strDescription%></font>
	</p>
<%

	strSQL = "SELECT answerID, answerText, isDefault, orderByID " &_
			 "FROM usd_Answers " &_
			 "WHERE itemID = " & intItemID &_
			 " ORDER by orderByID, answerID"
	Set objConnDB = Server.CreateObject("ADODB.Connection")
	objConnDB.Open DB_CONNECTION
	Set rsResults = objConnDB.Execute(strSQL)

	' First array index is field:
	' 0 = id, 1 = name, 2 = image, 3 = url
	' Second array index = record number
	If not rsResults.EOF Then
		arrData = rsResults.GetRows

		' Moved up to before the loop
		rsResults.close
		Set rsResults = Nothing
		objConnDB.close
		Set objConnDB = Nothing

		' Determine the size of the data array's 2nd (data) dimension.
		iArraySize = (Ubound(arrData, 2) - LBound(arrData, 2)) + 1

		' Get an array of numbers 0 to array size randomly sequenced.
		arrSequencer = utility_GetRandomizedSequencerArray(iArraySize)

%>
		<table>
<%
		If intLayoutStyle = SV_RADIO_LAYOUT_HORIZONTAL Then
%>
			<tr>
<%
		End If
		
		intCounter = 0
		
		For iArrayLooper = LBound(arrSequencer) To UBound(arrSequencer)
			intCounter = intCounter + 1
			If boolRandomize = True Then
				intAnswerID = arrData(0, arrSequencer(iarrayLooper))
				strAnswerText  = arrData(1, arrSequencer(iarrayLooper))
				boolDefault = cbool(arrData(2, arrSequencer(iarrayLooper)))
				intOrderByID = arrData(3,arrSequencer(iarrayLooper))
			Else
				intAnswerID = arrData(0, iarrayLooper)
				strAnswerText  = arrData(1, iarrayLooper)
				boolDefault = cbool(arrData(2, iarrayLooper))
				intOrderByID = arrData(3, iarrayLooper)
			End If	
		
			If not utility_isPositiveInteger(intOrderByID) Then
				strSQL = "UPDATE usd_answers SET orderByID = " & intCounter & " WHERE answerID = " & intAnswerID
				Call utility_executeCommand(strSQL)
			End If
		
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
		
			If intLayoutStyle = SV_RADIO_LAYOUT_VERTICAL Then
%>
			
				<tr>
<%
			End If

%>
				
					<td valign="middle">
						<input 
							type="radio" 
							name="item<%=intItemID%>"
<%
							If varResponse = intAnswerID Then
								boolDefaulted = True
%>
								checked								
<%
							End If
													
							If boolDefault = True and varResponse = "" Then
%>
								checked
<%
							End If
%>
							value="<%=intAnswerID%>">
					</td>
					<td valign="middle">
						<font color="<%=strAnswerColor%>" face="<%=strBaseFont%>" size="<%=intAnswerSize%>">			
<%
					If boolNumberLabels = True Then
%>
						<%=intCounter%>.
<%
					End If
%>
						<%=strAnswerText%></font>
					</td>
<%
			If intLayoutStyle = SV_RADIO_LAYOUT_VERTICAL Then
%>
			
				</tr>
<%
			End If

	Next

		If boolAllowOther = True Then
			If intLayoutStyle = SV_RADIO_LAYOUT_VERTICAL Then
%>
			
				<tr>
<%
			End If
%>
					<td>
						<input type="radio" name="item<%=intItemID%>" value="0"
<%
						If boolDefaulted = False and varResponse <> "" Then
%>
							checked
<%
						End If
%>						
						>
						
					</td>
					<td valign="middle">
						<font color="<%=strAnswerColor%>" face="<%=strBaseFont%>" size="<%=intAnswerSize%>">
						<%=strOtherText%></font>
					</td>
					<td>
						<input type="text" name="item<%=intItemID%>_otherText" size="20"
<%
						If boolDefaulted = False Then
%>
							value="<%=varResponse%>"
<%
						End If
%>						
						>
					</td>
<%
		End If
%>
			<input type="hidden" name="itemShown<%=intItemID%>" value="true">
			</tr>
		</table>
<%
	End If
End Function

'**************************************************************************************
'Name:			itemDisplay_displayCheckboxes
'
'Purpose:		make checkbox type item and display on page
'
'Inputs:		intItemID - ID of item to make checkboxes out of
'
'Ouputs:		strJavaScript - appends any necessary javascript
'**************************************************************************************
Function itemDisplay_displayCheckboxes(intItemID, strJavaScript, intQuestionCounter, boolQuestionNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, intAnswerSize, strAnswerColor, strBaseFont, intResponseID, boolEditing,intCurrentResponseID)
	Dim strSQL
	Dim rsResults
	Dim strText
	Dim strDescription
	Dim boolAllowOther
	Dim strOtherText
	Dim strOtherResponse ' User's data entry in an "other" checkbox. --mlp 9/28/2006
	Dim boolIsRequired
	Dim intCounter
	Dim intAnswerID
	Dim	strAnswerText
	Dim boolDefault
	Dim arrData       ' Array to Store Data
	Dim arrSequencer  ' Array to Hold Random Sequence
	Dim iArrayLooper  ' Integer for Looping
	Dim iArraySize    ' Size of Data Array
	Dim boolRandomize
	Dim objConnDB
	Dim boolNumberLabels
	Dim intMinimum
	Dim intMaximum
	Dim strResponse
	Dim intNumberColumns
	Dim intPipedItemID1
	Dim intPipedItemID2
	Dim intPipedItemID3
	Dim intNumberAnswers
	Dim intAnswersPerColumn
	Dim intOrderByID
	
	intQuestionCounter = intQuestionCounter + 1
	
	strSQL = "SELECT itemText, itemDescription, allowOther, otherText, isRequired, randomize, numberLabels, " &_
			 "maximumValue, minimumValue, layoutStyle, pipedItemID1, pipedItemID2, pipedItemID3 " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	
	strText = rsResults("itemText")
	strDescription = rsResults("itemDescription")
	boolAllowOther = Cbool(rsResults("allowOther"))
	strOtherText = rsResults("otherText")
	boolIsRequired = Cbool(rsResults("isRequired"))
	boolRandomize = Cbool(rsResults("randomize"))
	boolNumberLabels = Cbool(rsResults("numberLabels"))
	intMaximum = rsResults("maximumValue")
	intMinimum = rsResults("minimumValue")
	intNumberColumns = rsResults("layoutStyle")
	
	If not utility_isPositiveInteger(intNumberColumns) Then
		intNumberColumns = 1
	End If
	
	If utility_isPositiveInteger(intCurrentResponseID) Then
		intPipedItemID1 = rsResults("pipedItemID1")
		intPipedItemID2 = rsResults("pipedItemID2")
		intPipedItemID3 = rsResults("pipedItemID3")
	
		If utility_isPositiveInteger(intPipedItemID1) Then
			strText = response_pipeAnswer(1,intCurrentResponseID, intPipedItemID1, strText)
			strDescription = response_pipeAnswer(1,intCurrentResponseID, intPipedItemID1, strDescription)
		End If
		
		If utility_isPositiveInteger(intPipedItemID2) Then
			strText = response_pipeAnswer(2,intCurrentResponseID, intPipedItemID2, strText)
			strDescription = response_pipeAnswer(2,intCurrentResponseID, intPipedItemID2, strDescription)
		End If
		
		If utility_isPositiveInteger(intPipedItemID3) Then
			strText = response_pipeAnswer(3,intCurrentResponseID, intPipedItemID3, strText)
			strDescription = response_pipeAnswer(3,intCurrentResponseID, intPipedItemID3, strDescription)
		End If
	End If
	
	rsResults.Close
	
	
%>	
	<p>
		<font color="<%=strQuestionColor%>" face="<%=strBaseFont%>" size="<%=intQuestionSize%>">
<%	
		If boolIsRequired = True Then
%>
			<%=common_requiredFlag%>
<%
		End If
		
		If boolQuestionNumberLabels = True Then
%>
			<%=intQuestionCounter%>.
<%
		End If
%>
		<%=strText%></font><br />
		<font color="<%=strQuestionDescriptionColor%>" face="<%=strBaseFont%>" size="<%=intQuestionDescriptionSize%>">
			<%=strDescription%></font>
	</p>
<%
	
	strSQL = "SELECT answerID, answerText, isDefault, orderByID " &_
			 "FROM usd_Answers " &_
			 "WHERE itemID = " & intItemID &_
			 " ORDER by orderByID, answerID"
	Set objConnDB = Server.CreateObject("ADODB.Connection")
	objConnDB.Open DB_CONNECTION
	Set rsResults = objConnDB.Execute(strSQL)

	' First array index is field:
	' 0 = id, 1 = name, 2 = image, 3 = url
	' Second array index = record number
	If not rsResults.EOF Then
		arrData = rsResults.GetRows
		
		intNumberAnswers = ubound(arrData,2) + 1

		' Moved up to before the loop
		rsResults.close
		Set rsResults = Nothing
		objConnDB.close
		Set objConnDB = Nothing

		' Determine the size of the data array's 2nd (data) dimension.
		iArraySize = (Ubound(arrData, 2) - LBound(arrData, 2)) + 1

		' Get an array of numbers 0 to array size randomly sequenced.
		arrSequencer = utility_GetRandomizedSequencerArray(iArraySize)
%>
		<table border="0"><tr><td valign="top" align="left"><table><tr><td>
<%
		strJavaScript = strJavaScript & "checkCount" & intItemID & " = 0;"
			
		
		intAnswersPerColumn = intNumberAnswers / intNumberColumns
		
		If not utility_isPositiveInteger(intAnswersPerColumn) Then
			If cint(intAnswersPerColumn) > intAnswersPerColumn Then
				intAnswersPerColumn = cint(intAnswersPerColumn)
			Else
				intAnswersPerColumn = cint(intAnswersPerColumn) + 1
			End If
		End If
		
		For iArrayLooper = LBound(arrSequencer) To UBound(arrSequencer)
			If boolRandomize = True Then
				intAnswerID = arrData(0, arrSequencer(iarrayLooper))
				strAnswerText  = arrData(1, arrSequencer(iarrayLooper))
				boolDefault = cbool(arrData(2, arrSequencer(iarrayLooper)))
				intOrderByID = arrData(3, arrSequencer(iarrayLooper))
			Else
				intAnswerID = arrData(0, iarrayLooper)
				strAnswerText  = arrData(1, iarrayLooper)
				boolDefault = cbool(arrData(2, iarrayLooper))
				intOrderByID = arrData(3, iarrayLooper)
			End If	
			
			
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
			
			
			If intCounter mod intAnswersPerColumn = 0 Then

%>
				</td></tr></table></td><td valign="top" align="left"><table border="0"><tr><td valign="top" align="left">
<%
			End If
			intCounter = intCounter + 1
			
			If not utility_isPositiveInteger(intOrderByID) Then
				strSQL = "UPDATE usd_answers SET orderByID = " & intCounter & " WHERE answerID = " & intAnswerID
				Call utility_executeCommand(strSQL)
			End If
			
				strJavascript = strJavascript & "if (document.frmResponse.item" & intItemID & "_check" & intCounter &_
						".checked) {checkCount" & intItemID & " = checkCount" & intItemID & " + 1}"
%>
			
					<input type="hidden" name="item<%=intItemID%>_answerID<%=intCounter%>" value="<%=intAnswerID%>">
					<input 
						type="checkbox" 
						name="item<%=intItemID%>_check<%=intCounter%>"
<%
						If utility_isPositiveInteger(intResponseID) and boolEditing = True Then
							If response_checkCheckboxResponse(intResponseID, intItemID, intAnswerID,0,0) = True Then
%>
								checked
<%
							End If
						ElseIf boolDefault = True Then
%>
							checked
<%
						Else 'TRI++: render previous user input to enable paging. --mlp 9/28/2006
							If utility_isPositiveInteger(intCurrentResponseID) Then
								If response_checkCheckboxResponse(intCurrentResponseID, intItemID, intAnswerID,0,0) = True Then
%>
									checked
<%								
								End If
							End If
						End If
%> 
						>
						<input type="hidden" name="item<%=intItemID%>_value<%=intCounter%>"
							value="<%=intAnswerID%>">
								<font color="<%=strAnswerColor%>" face="<%=strBaseFont%>" size="<%=intAnswerSize%>">
<%
				If boolNumberLabels = True Then
%>
					<%=intCounter%>.
<%
				End If
%>
					
					<%=strAnswerText%></font>
				&nbsp;<br />
<%
		Next
	
		If boolAllowOther = True Then
			If intCounter mod intNumberColumns = 0 Then
%>
				</td></tr></table><table><tr><td valign="top" align="left" colspan="<%=intNumberColumns%>">
<%
			End If			
			strJavascript = strJavascript & "if (document.frmResponse.item" & intItemID & "_other" &_
						".checked) {checkCount" & intItemID & " = checkCount" & intItemID & " + 1}"
%>
						<input type="checkbox" name="item<%=intItemID%>_other" 
<%
						'TRI++: render previous user input to enable paging. --mlp 9/28/2006
						If utility_isPositiveInteger(intCurrentResponseID) Then
							strOtherResponse = response_getOtherText(intCurrentResponseID, intItemID)
						Else
							strOtherResponse = ""
						End If
						
						If strOtherResponse <> "" Then
%>
							checked
<%								
						End If
%>						
						>
						<font color="<%=strAnswerColor%>" face="<%=strBaseFont%>" size="<%=intAnswerSize%>">
						<%=strOtherText%></font>
						
						<input type="text" name="item<%=intItemID%>_otherText" size="20"
<%
						'TRI++: render previous user input to enable paging. --mlp 9/28/2006
%>						
						value="<%=strOtherResponse%>">
						<input type="hidden" name="otherAllowed<%=intItemID%>" value="true">
								
<%
		End If
%>
			<input type="hidden" name="itemShown<%=intItemID%>" value="true">
			<input type="hidden" name="numberCheckboxes<%=intItemID%>" value="<%=intCounter%>">
			</td></tr>
		</table></td></tr></table>
<%
	
		If isNumeric(intMaximum) Then
			strJavaScript = strJavaScript & "if (checkCount" & intItemID & " > " & intMaximum & "){" &_
							"alert(""You may not choose more than " & intMaximum & " response(s) to '" &_
							 utility_javascriptEncode(strText) & "'."");return false;}"
		End If
		
		If isNumeric(intMinimum) Then
			strJavaScript = strJavaScript & "if (checkCount" & intItemID & " < " & intMinimum & "){" &_
							"alert(""You must choose at least " & intMinimum & " response(s) to '" &_
							 utility_javascriptEncode(strText) & "'."");return false;}"
		End If
	End If
End Function

'**************************************************************************************
'Name:			itemDisplay_displayDropdown
'
'Purpose:		make dropdown type item and display on page
'
'Inputs:		intItemID - ID of item to make dropdown out of
'**************************************************************************************
Function itemDisplay_displayDropdown(intItemID, intQuestionCounter, boolQuestionNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, strBaseFont, intResponseID, boolEditing, strJavascript,intCurrentResponseID)
	Dim strSQL
	Dim rsResults
	Dim strItemText
	Dim strDescription
	Dim boolAllowOther
	Dim strOtherText
	Dim boolIsRequired
	Dim intAnswerID
	Dim	strAnswerText
	Dim boolDefault
	Dim arrData       ' Array to Store Data
	Dim arrSequencer  ' Array to Hold Random Sequence
	Dim iArrayLooper  ' Integer for Looping
	Dim iArraySize    ' Size of Data Array
	Dim boolRandomize
	Dim objConnDB
	Dim boolNumberLabels
	Dim intCounter
	Dim varResponse
	Dim intPipedItemID1
	Dim intPipedItemID2
	Dim intPipedItemID3
	Dim intOrderByID
	
	intQuestionCounter = intQuestionCounter + 1
	
	If utility_isPositiveInteger(intResponseID) and boolEditing = True Then
		varResponse = response_getResponseText(intResponseID, intItemID,0,0)

	Else 'TRI++: Added in order to enable backward and forward paging -- mlp, 9/27/2006
	
		If utility_isPositiveInteger(intCurrentResponseID) Then
			varResponse = response_getResponseText(intCurrentResponseID, intItemID,0,0)
		End If
		
	End If
	
	strSQL = "SELECT itemText, itemDescription, allowOther, otherText, isRequired, randomize, numberLabels, pipedItemID1, pipedItemID2, pipedItemID3  " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	
	strItemText = rsResults("itemText")
	strDescription = rsResults("itemDescription")
	boolAllowOther = Cbool(rsResults("allowOther"))
	strOtherText = rsResults("otherText")
	boolIsRequired = Cbool(rsResults("isRequired"))
	boolRandomize = Cbool(rsResults("randomize"))
	boolNumberLabels = Cbool(rsResults("numberLabels"))
	
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
	<p>
		<font color="<%=strQuestionColor%>" face="<%=strBaseFont%>" size="<%=intQuestionSize%>">
<%	
		If boolIsRequired = True Then

			If boolAllowOther = True Then
				strJavaScript = strJavaScript & "if (document.frmResponse.item" & intItemID & ".value== """") " &_
								"{if (document.frmResponse.item" & intItemID & "_otherText.value != """") " &_
								"{alert(""For: "
				If len(strItemText) > 100 Then
					strJavaScript = strJavascript & utility_javascriptEncode(mid(strItemText,1,100)) & "...."
				Else
					strJavaScript = strJavascript & utility_javascriptEncode(strItemText)
				End If
				strJavaScript = strJavascript & " please choose an item from the dropdown or leave the 'other' field blank"");return false;}}"
			End If
			
				strJavaScript = strJavaScript & "if (document.frmResponse.item" & intItemID & ".value== """") " &_
								"{alert(""For: "
				If len(strItemText) > 100 Then
					strJavaScript = strJavascript & utility_javascriptEncode(mid(strItemText,1,100)) & "...."
				Else
					strJavaScript = strJavascript & utility_javascriptEncode(strItemText)
				End If
				strJavaScript = strJavascript & " please choose an item from the dropdown."");return false;}"
			

%>			
			<%=common_requiredFlag%>
<%
		End If
		
		If boolQuestionNumberLabels = True Then
%>
			<%=intQuestionCounter%>.
<%
		End If
%>
		<%=strItemText%></font><br />
		<font color="<%=strQuestionDescriptionColor%>" face="<%=strBaseFont%>" size="<%=intQuestionDescriptionSize%>">
			<%=strDescription%>
		</font>
	</p>
<%

	strSQL = "SELECT answerID, answerText, isDefault, orderByID " &_
			 "FROM usd_Answers " &_
			 "WHERE itemID = " & intItemID &_
			 " ORDER by orderByID, answerID"

	Set objConnDB = Server.CreateObject("ADODB.Connection")
	objConnDB.Open DB_CONNECTION
	Set rsResults = objConnDB.Execute(strSQL)

	' First array index is field:
	' 0 = id, 1 = name, 2 = image, 3 = url
	' Second array index = record number
	If not rsResults.EOF Then
		arrData = rsResults.GetRows

		' Moved up to before the loop
		rsResults.close
		Set rsResults = Nothing
		objConnDB.close
		Set objConnDB = Nothing

		' Determine the size of the data array's 2nd (data) dimension.
		iArraySize = (Ubound(arrData, 2) - LBound(arrData, 2)) + 1

		' Get an array of numbers 0 to array size randomly sequenced.
		arrSequencer = utility_GetRandomizedSequencerArray(iArraySize)
%>
		<select name="item<%=intItemID%>">
			<option value=""><%=SV_DROPDOWN_DEFAULT%></option>
<%
		
		intCounter = 0
		For iArrayLooper = LBound(arrSequencer) To UBound(arrSequencer)
			intCounter = intCounter + 1
			If boolRandomize = True Then
				intAnswerID = arrData(0, arrSequencer(iarrayLooper))
				strAnswerText  = arrData(1, arrSequencer(iarrayLooper))
				boolDefault = cbool(arrData(2, arrSequencer(iarrayLooper)))
				intOrderByID = arrData(3, arrSequencer(iarrayLooper))
			Else
				intAnswerID = arrData(0, iarrayLooper)
				strAnswerText  = arrData(1, iarrayLooper)
				boolDefault = cbool(arrData(2, iarrayLooper))
				intOrderByID = arrData(3, iarrayLooper)
			End If	
			
			If not utility_isPositiveInteger(intOrderByID) Then
				strSQL = "UPDATE usd_answers SET orderByID = " & intCounter & " WHERE answerID = " & intAnswerID
				Call utility_executeCommand(strSQL)
			End If
			
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
				>
<%
				If boolNumberLabels = True Then
%>
					<%=intCounter%>.
<%
				End If
%>
				<%=strAnswerText%>
<%
		Next
	
		If boolAllowOther = True Then
%>
			<option value="0">
				<%=strOtherText%>
			</option>
<%
		End If
%>
		</select>
		<input type="hidden" name="itemShown<%=intItemID%>" value="true">
<%
		If boolAllowOther = True Then
%>
			<span class="normal"><%=strOtherText%></span>
			<input type="text" name="item<%=intItemID%>_otherText" size="20">
<%
		End if
	End If
End Function

'**************************************************************************************
'Name:			itemDisplay_displayHeader
'
'Purpose:		make header type item and display on page
'
'Inputs:		intItemID - ID of header item
'**************************************************************************************
Function itemDisplay_displayHeader(intItemID)
	Dim strSQL
	Dim rsResults
	Dim strText
	Dim strDescription
	strSQL = "SELECT itemText, itemDescription " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	strText = rsResults("itemText")
	strDescription = rsResults("itemDescription")
	
%>	
	<p class="itemTitle">
		<%=strText%>
		<br />
		<span class="normal"><%=strDescription%></span>
	</p>
<%
	rsResults.Close
	Set rsResults = NOTHING
	
End Function

'**************************************************************************************
'Name:			itemDisplay_displayMessage
'
'Purpose:		make message type item and display on page
'
'Inputs:		intItemID - ID of message item
'**************************************************************************************
Function itemDisplay_displayMessage(intItemID, intResponseID)
	Dim strSQL
	Dim rsResults
	Dim strText
	Dim intPipedItemID1
	Dim intPipedItemID2
	Dim intPipedItemID3
	
	strSQL = "SELECT itemText, pipedItemID1, pipedItemID2, pipedItemID3 " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	
	strText = rsResults("itemText")
	
	If utility_isPositiveInteger(intResponseID) Then
	
		intPipedItemID1 = rsResults("pipedItemID1")
		intPipedItemID2 = rsResults("pipedItemID2")
		intPipedItemID3 = rsResults("pipedItemID3")
	
		If utility_isPositiveInteger(intPipedItemID1) Then
			strText = response_pipeAnswer(1,intResponseID, intPipedItemID1, strText)
		End If
		
		If utility_isPositiveInteger(intPipedItemID2) Then
			strText = response_pipeAnswer(2,intResponseID, intPipedItemID2, strText)
		End If
		
		If utility_isPositiveInteger(intPipedItemID3) Then
			strText = response_pipeAnswer(3,intResponseID, intPipedItemID3, strText)
		End If

	End If
%>
		<p class="message"><%=strText%></p>
<%

	rsResults.Close
	Set rsResults = NOTHING
	
End Function

'**************************************************************************************
'Name:			itemDisplay_displayLine
'
'Purpose:		make line type item and display on page
'
'Inputs:		none
'**************************************************************************************
Function itemDisplay_displayLine()
%>
	<hr>
<%
End Function

'**************************************************************************************
'Name:			itemDisplay_displayHTML
'
'Purpose:		make message type item and display on page
'
'Inputs:		intItemID - ID of message item
'**************************************************************************************
Function itemDisplay_displayHTML(intItemID)
	Dim strSQL
	Dim rsResults
	Dim strText
	Dim strDescription
	strSQL = "SELECT itemText " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	strText = rsResults("itemText")
	
	If strText <> "" Then

		Response.write strText

	End If

	rsResults.Close
	Set rsResults = NOTHING
	
End Function

'**************************************************************************************
'Name:			itemDisplay_displayTextArea
'
'Purpose:		make textArea type item and display on page
'
'Inputs:		intItemID - ID of textArea item
'**************************************************************************************
Function itemDisplay_displayTextArea(intItemID, intQuestionCounter, boolQuestionNumberLabels, intQuestionSize, strQuestionColor, _
						intQuestionDescriptionSize, strQuestionDescriptionColor, strBaseFont, intResponseID, boolEditing, strJavascript, intCurrentResponseID)

	Dim strSQL
	Dim rsResults
	Dim strItemText
	Dim strDescription
	Dim boolIsRequired
	Dim strDefaultValue
	Dim strResponse
	Dim intPipedItemID1
	Dim intPipedItemID2
	Dim intPipedItemID3
	Dim intNumberRows
	Dim intNumberColumns
	
	intQuestionCounter = intQuestionCounter + 1
	
	strSQL = "SELECT itemText, itemDescription, defaultValue, isRequired, pipedItemID1, pipedItemID2, pipedItemID3, numberRows, numberColumns " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	strItemText = rsResults("itemText")
	strDescription = rsResults("itemDescription")
	strDefaultValue = rsResults("defaultValue")
	boolIsRequired = Cbool(rsResults("isRequired"))
	
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
	
	intNumberRows = rsResults("numberRows")
	intNumberColumns = rsResults("numberColumns")
	
	rsResults.Close
	Set rsResults = NOTHING
	
	If utility_isPositiveInteger(intResponseID) and boolEditing = True Then
		strResponse = response_getResponseText(intResponseID, intItemID,0,0)
		strDefaultValue = strResponse
	
	Else 'TRI++: Added in order to enable backward and forward paging -- mlp, 9/27/2006
	
		If utility_isPositiveInteger(intCurrentResponseID) Then
			strResponse = response_getResponseText(intCurrentResponseID, intItemID,0,0)
			strDefaultValue = strResponse
		End If
		
	End If
%>	
	<p>
		<font color="<%=strQuestionColor%>" face="<%=strBaseFont%>" size="<%=intQuestionSize%>">
<%
		If boolIsRequired = True Then
			If len(strItemText) > 100 Then
				strItemText = utility_javascriptEncode(mid(strItemText,1,100)) & "...."
			End If
			strJavaScript = strJavaScript &_
									"if(document.frmResponse.item" & intItemID & ".value == """") " &_
										"{alert(""Response to: " & utility_javascriptEncode(strItemText) & " is required."");return false;}"
%>
			<%=common_requiredFlag%>
<%
		End If
		
		If boolQuestionNumberLabels Then
%>
		<%=intQuestionCounter%>.
<%
		End If
		'TODO: Add getResponse functionality for user response content in textarea.
%>
		
		<%=strItemText%></font>
		<br />
		<font color="<%=strQuestionDescriptionColor%>" face="<%=strBaseFont%>" size="<%=intQuestionDescriptionSize%>">
		<%=strDescription%></font><br />
		<textarea cols="<%=intNumberColumns%>" rows="<%=intNumberRows%>"
		name="item<%=intItemID%>"><%=strDefaultValue%></textarea>
		<input type="hidden" name="itemShown<%=intItemID%>" value="true">
	</p>
<%	
	
End Function

'**************************************************************************************
'Name:			itemDisplay_displaySingleLine
'
'Purpose:		make single line type item and display on page
'
'Inputs:		intItemID - ID of single line item
'**************************************************************************************
Function itemDisplay_displaySingleLine(intItemID, intQuestionCounter, boolQuestionNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, strBaseFont, intResponseID, boolEditing, strJavascript, intCurrentResponseID)
	Dim strSQL
	Dim rsResults
	Dim strItemText
	Dim strDescription
	Dim boolIsRequired
	Dim strDefaultValue
	Dim strResponse
	Dim intDataType
	Dim intPipedItemID1
	Dim intPipedItemID2
	Dim intPipedItemID3
	Dim intSize

	intQuestionCounter = intQuestionCounter + 1
	
	strSQL = "SELECT itemText, itemDescription, defaultValue, isRequired, dataType, pipedItemID1, pipedItemID2, pipedItemID3, layoutStyle " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	strItemText = rsResults("itemText")
	strDescription = rsResults("itemDescription")
	strDefaultValue = rsResults("defaultValue")
	boolIsRequired = Cbool(rsResults("isRequired"))
	intDataType = rsResults("dataType")
	
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
	
	intSize = rsResults("layoutStyle")
	If not utility_isPositiveInteger(intSize) Then
		intSize = 50
	End If
	
	rsResults.Close
	Set rsResults = NOTHING
	
	
	If boolEditing = True and utility_isPositiveInteger(intResponseID) Then
		strResponse = response_getResponseText(intResponseID, intItemID,0,0)
		strDefaultValue = strResponse
	
	Else 'TRI++: Added in order to enable backward and forward paging -- mlp, 9/27/2006
	
		If utility_isPositiveInteger(intCurrentResponseID) Then
			strResponse = response_getResponseText(intCurrentResponseID, intItemID,0,0)
			strDefaultValue = strResponse
		End If
		
	End If



%>	

	<p>
		<font color="<%=strQuestionColor%>" face="<%=strBaseFont%>" size="<%=intQuestionSize%>">
<%	
		If boolIsRequired = True Then
			
			strJavaScript = strJavaScript &_
									"if(document.frmResponse.item" & intItemID & ".value == """") " &_
										"{alert(""Response to: "
			If len(strItemText) > 100 Then
				strJavascript = strJavascript & utility_javascriptEncode(mid(strItemText,1,100)) & "...."
			Else
				strJavascript = strJavascript & utility_javascriptEncode(strItemText) 
			End If							
			strJavascript = strJavascript & " is required."");return false;}"
%>
			<%=common_requiredFlag%>
<%
		End If
		
	
		If boolQuestionNumberLabels = True Then
%>
			<%=intQuestionCounter%>.
<%
		End If
		
		'TODO: Add getResponse functionality for user response content in textbox.
%>
		<%=strItemText%></font><br />
		<font color="<%=strQuestionDescriptionColor%>" face="<%=strBaseFont%>" size="<%=intQuestionDescriptionSize%>">
			<%=strDescription%>
		</font><br />
	<input type="text" name="item<%=intItemID%>" size="<%=intSize%>" 
		value="<%=strDefaultValue%>">
		<input type="hidden" name="itemShown<%=intItemID%>" value="true">
	</p>
	
<%	

End Function


'**************************************************************************************
'Name:			itemDisplay_displayDate
'
'Purpose:		make date type item and display on page
'
'Inputs:		intItemID - ID of date item
'**************************************************************************************
Function itemDisplay_displayDate(intItemID, intQuestionCounter, boolQuestionNumberLabels, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, strBaseFont, intResponseID, boolEditing, strJavascript, intCurrentResponseID)
	Dim strSQL
	Dim rsResults
	Dim strItemText
	Dim dtmMinimumDate
	Dim dtmMaximumDate
	Dim dtmFirstYear
	Dim dtmLastYear
	Dim dtmNumberYears
	Dim strDescription
	Dim boolIsRequired
	Dim dtmDefaultDate
	Dim intPipedItemID1
	Dim intPipedItemID2
	Dim intPipedItemID3
	
	intQuestionCounter = intQuestionCounter + 1
	
	strSQL = "SELECT itemText, itemDescription, defaultValue, minimumValue, maximumValue, " &_
			 "isRequired, pipedItemID1, pipedItemID2, pipedItemID3 " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	strItemText = rsResults("itemText")
	strDescription = rsResults("itemDescription")
	dtmDefaultDate = rsResults("defaultValue")
	dtmMinimumDate = rsResults("minimumValue")
	dtmMaximumDate = rsResults("maximumValue")
	boolIsRequired = Cbool(rsResults("isRequired"))
		
	If boolEditing = True and utility_isPositiveInteger(intResponseID) Then
		dtmDefaultDate = response_getResponseText(intResponseID, intItemID,0,0)
	End If	
		
	If isDate(dtmMinimumDate) Then
		dtmFirstYear = datepart("yyyy",dtmMinimumDate)
	Else
		dtmFirstYear = SV_DEFAULT_START_YEAR
	End If
	
	If isDate(dtmMaximumDate) Then
		dtmLastYear = datepart("yyyy",dtmMaximumDate)
		dtmNumberYears = dtmLastYear - dtmFirstYear + 1
	Else
		dtmNumberYears = USD_DROPDOWN_YEARS
	End If
	
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
	Set rsResults = NOTHING
		
%>	
	<p>
		<font color="<%=strQuestionColor%>" face="<%=strBaseFont%>" size="<%=intQuestionSize%>">
<%	
		If boolIsRequired = True Then
			strJavaScript = strJavaScript &_
					" if (document.frmResponse.item" & intItemID & "Day.value == """") " &_
										"{alert(""Response to: "
			If len(strItemText) > 100 Then
				strJavascript = strJavascript & utility_javascriptEncode(mid(strItemText,1,100)) & "...."
			Else
				strJavascript = strJavascript & utility_javascriptEncode(strItemText) 
			End If							
			strJavascript = strJavascript & " is required."");return false;}"
			
			strJavaScript = strJavaScript &_
					"else if (document.frmResponse.item" & intItemID & "Year.value == """") " &_
										"{alert(""Response to: "
			If len(strItemText) > 100 Then
				strJavascript = strJavascript & utility_javascriptEncode(mid(strItemText,1,100)) & "...."
			Else
				strJavascript = strJavascript & utility_javascriptEncode(strItemText) 
			End If							
			strJavascript = strJavascript & " is required."");return false;}"
			
			strJavaScript = strJavaScript &_
					"else if (document.frmResponse.item" & intItemID & "Month.value == """") " &_
										"{alert(""Response to: "
			If len(strItemText) > 100 Then
				strJavascript = strJavascript & utility_javascriptEncode(mid(strItemText,1,100)) & "...."
			Else
				strJavascript = strJavascript & utility_javascriptEncode(strItemText) 
			End If							
			strJavascript = strJavascript & " is required."");return false;}"

%>
			<%=common_requiredFlag%>
<%
		End If
		
		If boolQuestionNumberLabels = True Then
%>
			<%=intQuestionCounter%>.
<%
		End If
%>
		<%=strItemText%></font><br />
		<font color="<%=strQuestionDescriptionColor%>" face="<%=strBaseFont%>" size="<%=intQuestionDescriptionSize%>">
			<%=strDescription%>
		</font>
	</p>
	<%=common_dateSelect("item" & intItemID, dtmDefaultDate, dtmFirstYear, dtmNumberYears)%>
	<input type="hidden" name="itemShown<%=intItemID%>" value="true"></p>
<%	
End Function


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
								 <td valign="bottom" align="center" width="<%=100 / intNumberAnswers%>%">
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
				
				If boolSet = False Then
%>
						<td width="250">
<%
				Else
					If arrSets(2,0) = SV_MATRIX_LAYOUT_ALPHASCALE Then
%>
						<td align=right>
<%
					Else	
%>					
						<td>
<%
					End If
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
					For intSetCounter = 0 to ubound(arrSets,2)
						intLayoutStyle = arrSets(2,intSetCounter)
						strSetText = arrSets(1, intSetCounter)
						intMatrixSetID = arrSets(0, intSetCounter)
						boolIsRequired = cbool(arrSets(8, intSetCounter))
						
						If boolEditing = True Then
							varResponse = response_getResponseText(intResponseID, intItemID, intMatrixSetID, intCategoryID)
						
						Else 'TRI++: Added in order to enable backward and forward paging -- mlp, 9/27/2006
	
							If utility_isPositiveInteger(intCurrentResponseID) Then
								varResponse = response_getResponseText(intCurrentResponseID, intItemID, intMatrixSetID, intCategoryID)
							End If
							
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
								If intLayoutStyle = SV_MATRIX_LAYOUT_RADIO or intLayoutStyle = SV_MATRIX_LAYOUT_SCALE or intLayoutStyle = SV_MATRIX_LAYOUT_ALPHASCALE Then 'NEW TYPE
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
		
						
						'TODO: Assign "varResponse" for each Matrix category
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
								
								'TRI++: get previous user input
								If utility_isPositiveInteger(intCurrentResponseID) Then
									varResponse = response_getResponseText(intCurrentResponseID, intItemID, intMatrixSetID, intCategoryID)
								End If
								
								Select Case intLayoutStyle
									Case SV_MATRIX_LAYOUT_RADIO, SV_MATRIX_LAYOUT_ALPHASCALE

						
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
						
						</td></tr></table></td>
<%
					Next
				End If
				'NEW TYPE
				If intLayoutStyle = SV_MATRIX_LAYOUT_ALPHASCALE Then
%>
					<td>
						<font color="<%=strAnswerColor%>" face="<%=strBaseFont%>" size="<%=intAnswerSize%>">
							<%=arrCategories(2,intCategoryCounter)%>
						</font>
					</td>
<%
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
					ElseIf intLayoutStyle = SV_MATRIX_LAYOUT_RADIO or intLayoutStyle = SV_MATRIX_LAYOUT_SCALE or intLayoutStyle = SV_MATRIX_LAYOUT_ALPHASCALE Then
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
								<option value="<%=SV_MATRIX_LAYOUT_ALPHASCALE%>">Adjective Scale</option>
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
