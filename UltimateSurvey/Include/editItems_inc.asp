<%
'****************************************************
'
' Name:		editItems_inc.asp Server-Side Include
' Purpose:		Provides functions to edit items of various types
'
' Author:	      Ultimate Software Designs
' Date Written:	6/18/2002
' Modified:		
'
'****************************************************
'**************************************************************************************
'Name:			editItems_editImage
'
'Purpose:		make form to edit image type item
'
'Inputs:		intItemID - ID of item to edit
'				strCurrentURL - URL of page form is being displayed on
'				strDefaultImage - address of image to default to (optional)
'				intSurveyID - unique ID of survey item is in
'**************************************************************************************
Function editItems_editImage(intItemID, strCurrentURL, strDefaultImage, intSurveyID)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT itemText  " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		If trim(strDefaultImage) <> "" Then
			strDefaultImage = SV_UPLOADED_IMAGE_URL & strDefaultImage
		Else
			strDefaultImage = rsResults("itemText")
		End If
		
		If len(strDefaultImage) > 0 Then
%>
			<img src="<%=strDefaultImage%>" border="0" />
<%
		End If
%>		
		<table>
			<tr valign="top">
				<td class="normalBold-Big" width="200">
					Image Options
				</td>
				<td class="normalBold">
					URL:
				</td>
				<td>
					<input type="text" name="itemText" size="50" value="<%=strDefaultImage%>">
				</td>
				<td>
					<a href="uploadFile.asp?surveyID=<%=intSurveyID%>&returnPage=<%=server.URLEncode(strCurrentURL)%>">
						<img src="images/button-upload.gif" border="0" alt="Upload"></a>
				</td>
			</tr>
		</table>
<%
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:			editItems_editHeader
'
'Purpose:		create form to allow user to edit a header to the survey
'
'Inputs:		intItemID - unique ID of item editing
'**************************************************************************************
Function editItems_editHeader(intItemID)
%>
	<table class="normal">
		<tr valign="top">
			<td class="normalBold-Big" width="150">
				Header Options
			</td>
			<td class="normal" valign="top">
				Header Text
				<br />
				<input type="text" name="itemText" size="50" value="<%=survey_getItemText(intItemID)%>">
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>	
			<td class="normal" valign="top">
				Sub Text
				<br />
				<textarea name="description" rows="4" cols="40"><%=survey_getItemDescription(intItemID)%></textarea>
			</td>
		</tr>
	</table>
<%
End Function		

'**************************************************************************************
'Name:			editItems_editSingleLine
'
'Purpose:		create form to allow user to edit a single line text field
'
'Inputs:		intItemID - unique ID of item editing
'**************************************************************************************
Function editItems_editSingleLine(intItemID)
	Dim strSQL
	Dim rsResults
	Dim strItemText
	Dim strItemDescription
	Dim boolRequired
	Dim strDefaultValue
	Dim intDataType
	Dim dblMinimumValue
	Dim dblMaximumValue
	Dim intSize
	
	strSQL = "SELECT itemText, itemDescription, defaultValue, minimumValue, maximumValue, isRequired, dataType, alias, layoutStyle " &_
			 "FROM usd_surveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)

	strItemText = rsResults("itemText")
	strItemDescription = rsResults("itemDescription")
	strDefaultValue = rsResults("defaultValue")
	dblMinimumValue = rsResults("minimumValue")
	dblMaximumValue = rsResults("maximumValue")
	boolRequired = cbool(rsResults("isRequired"))
	intDataType = rsResults("dataType")
	strQuestionAlias = rsResults("alias")
	intSize = rsResults("layoutStyle")
	
	If not utility_isPositiveInteger(intSize) Then intSize = 50
	
	
	rsResults.Close
	Set rsResults = NOTHING
%>
	<table class="normal">
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Question/SubText
			</td>
			<td class="normalBold" valign="top">
				Question Text:
				<br /><input type="text" name="itemText" size="50" value="<%=strItemText%>">
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Sub Text:
				<br />
				<span class="normal">
				(Instructional or other text to appear below the question)
				</span><br /> 
				<textarea name="description" rows="4" cols="40"><%=strItemDescription%></textarea>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Alias:<span class="normal">(Short alias for the question that can be used to make reports easier to view)</span> 
				<br /><input type="text" name="questionAlias" size="50" value="<%=strQuestionAlias%>">
			</td>
		</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table border="0">
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Required?
			</td>
			<td class="normalBold" valign="bottom">
				<input type="checkbox" name="required"
<%
				If boolRequired = True Then
%>
					checked
<%
				End If
%> 
				>Answer is Required
			</td>
		</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table border="0">
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Other Options
			</td>
					
			<td class="normalBold">
				Required Answer Format:
			</td>
			<td>
				<select name="dataType" value="<%=intDataType%>">
					<option value="">
						None
					</option>
					<option value="<%=SV_DATA_TYPE_NUMBER%>"
<%
					If intDataType = SV_DATA_TYPE_NUMBER Then
%>
						selected
<%
					End If
%>
					>
						Numbers Only
					</option>
					<option value="<%=SV_DATA_TYPE_INTEGER%>"
<%
					If intDataType = SV_DATA_TYPE_INTEGER Then
%>
						selected
<%
					End If
%>
					>
						Integers Only
					</option>
					<option value="<%=SV_DATA_TYPE_DECIMAL%>"
<%
					If intDataType = SV_DATA_TYPE_DECIMAL Then
%>
						selected
<%
					End If
%>
					>
						Decimals Only
					</option>
					<option value="<%=SV_DATA_TYPE_MONEY%>"
<%
					If intDataType = SV_DATA_TYPE_MONEY Then
%>
						selected
<%
					End If
%>
					>
						Money
					</option>
					<option value="<%=SV_DATA_TYPE_EMAIL%>"
<%
					If intDataType = SV_DATA_TYPE_EMAIL Then
%>
						selected
<%
					End If
%>
					>
						Email Address
					</option>
				</select>
				</td>
			</tr>
			<tr valign="top">
				<td>
					&nbsp;
				</td>
				<td>
					<span class="normalBold">Size:</span>
				</td>
				<td>
					<input type="text" name="layoutStyle" size="4" value="<%=intSize%>">
				</td>
			</tr>
			<tr valign="top">
				<td>
					&nbsp;
				</td>
				<td>
					<span class="normalBold">Minimum Value:</span>
				</td>
				<td>
					<input type="text" name="minimumValue" size="4" value="<%=dblMinimumValue%>">
				</td>
			</tr>
			<tr valign="top">
				<td>
					&nbsp;
				</td>
				<td>
					<span class="normalBold">Maximum Value:</span>
				</td>
				<td>
					<input type="text" name="maximumValue" size="4" value="<%=dblMaximumValue%>">
				</td>
			</tr>
			<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="bottom">
				Default Value:
			</td>
			<td valign="bottom">
				<input type="text" name="defaultValue" size="30" value="<%=strDefaultValue%>">
			</td>
		</tr>
	</table>
<%
End Function	

'**************************************************************************************
'Name:			editItems_editHTML
'
'Purpose:		create form to allow user to edit an html item 
'
'Inputs:		intItemID - unique ID of item editing
'**************************************************************************************
Function editItems_editHTML(intItemID)
%>
	<table class="normal">
		<tr valign="top">
			<td class="normalBold-Big" valign="top" width="200">
				HTML
			</td>
			<td>
				<textarea name="itemText" rows="20" cols="50"><%=survey_getItemText(intItemID)%></textarea>
			</td>
		</tr>
	</table>
<%
End Function

'**************************************************************************************
'Name:			editItems_editMessage
'
'Purpose:		create form to allow user to edit a message item
'
'Inputs:		intItemID - unique ID of item editing
'**************************************************************************************
Function editItems_editMessage(intItemID)
%>
	<table class="normal">
		<tr valign="top">
			<td class="normalBold-Big" valign="top" width="200">
				Message
			</td>
			<td>
				<textarea name="itemText" rows="4" cols="40"><%=survey_getItemText(intItemID)%></textarea>
			</td>
		</tr>
	</table>
<%
End Function

'**************************************************************************************
'Name:			editItems_editLine
'
'Purpose:		create form to allow user to edit a horizontal line as an item
'
'Inputs:		none
'**************************************************************************************
Function editItems_editLine()
%>
	<table class="normal">
		<tr valign="top">
			<td class="normalBold-Big" valign="top">
				Sample:
			</td>
		</tr>
	</table>
	<hr>
<%
End Function

'**************************************************************************************
'Name:			editItems_editTextArea
'
'Purpose:		create form to allow user to edit a textarea type question to the survey
'
'Inputs:		intItemID - unique ID of item editing
'**************************************************************************************
Function editItems_editTextArea(intItemID)
	Dim strSQL
	Dim rsResults
	Dim strItemText
	Dim strItemDescription
	Dim boolRequired
	Dim dtmDefaultValue
	Dim strQuestionAlias	
	Dim intNumberColumns
	Dim intNumberRows
	
	strSQL = "SELECT itemText, itemDescription, defaultValue, isRequired, alias, numberRows, numberColumns " &_
			 "FROM usd_surveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	
	strItemText = rsResults("itemText")
	strItemDescription = rsResults("itemDescription")
	strDefaultValue = rsResults("defaultValue")
	boolRequired = cbool(rsResults("isRequired"))
	strQuestionAlias = rsResults("alias")
	intNumberRows = rsResults("numberRows")
	intNumberColumns = rsResults("numberColumns")

	rsResults.Close
	Set rsResults = NOTHING

	If not utility_isPositiveInteger(intNumberRows) Then
		intNumberRows = 5
	End If
			
	If not utility_isPositiveInteger(intNumberColumns) Then
		intNumberColumns = 70
	End If
%>
	<table class="normal" width="100%">
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Question/SubText<br>
			</td>
			<td class="normalBold" valign="top">
				Question Text:
				<br />
 				<input type="text" name="itemText" size="50" value="<%=strItemText%>">
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Sub Text: <span class="normal">(Instructional or other text 
				to appear below the question)</span>
 				<br />
 				<textarea name="description" rows="4" cols="40"><%=strItemDescription%></textarea>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Alias:<span class="normal">(Short alias for the question that can be used to make reports easier to view)</span> 
				<br /><input type="text" name="questionAlias" size="50" value="<%=strQuestionAlias%>">
			</td>
		</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table>
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Required?
			</td>
			<td class="normalBold" valign="top">
				Answer is Required<input type="checkbox" name="required"
<%
				If boolRequired = True Then
%>
					checked
<%
				End If
%> 

				>
			</td>
		</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table ID="Table1">
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Appearance Options<br>
			</td>
			<td class="normalBold" valign="top">
				Number of Rows:
			</td>
			<td>	
				<input type="text" name="numberRows" value="<%=intNumberRows%>" size="4"> 
			</td>
		</tr>
				<tr valign="top">
			<td class="normalBold-Big" width="200">
				&nbsp;<br>
			</td>
			<td class="normalBold" valign="top">
				Number of Columns:
			</td>
			<td>	
				<input type="text" name="numberColumns" value="<%=intNumberColumns%>" size="4">
			</td>
		</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table>
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Other Options<br>
			</td>
			<td class="normalBold" valign="top">
				Default Value:
				<br />
				<textarea name="defaultValue" rows="4" cols="40"><%=strDefaultValue%></textarea>
			</td>
		</tr>
		</table>

<%
End Function	

'**************************************************************************************
'Name:			editItems_editDate
'
'Purpose:		create form to allow user to edit a date type question to the survey
'
'Inputs:		intItemID - unique ID of item editing
'**************************************************************************************
Function editItems_editDate(intItemID)
	Dim strSQL
	Dim rsResults
	Dim strItemText
	Dim strItemDescription
	Dim boolRequired
	Dim dtmDefaultDate
	Dim dtmEarliestDate
	Dim dtmLatestDate
	Dim strQuestionAlias
	
	strSQL = "SELECT itemText, itemDescription, defaultValue, minimumValue, maximumValue, isRequired, alias " &_
			 "FROM usd_surveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	
	strItemText = rsResults("itemText")
	strItemDescription = rsResults("itemDescription")
	dtmDefaultDate = rsResults("defaultValue")
	dtmEarliestDate = rsResults("minimumValue")
	dtmLatestDate = rsResults("maximumValue")
	boolRequired = cbool(rsResults("isRequired"))
	strQuestionAlias = rsResults("alias")
	
	If not isDate(dtmDefaultDate) Then
		dtmDefaultDate = DATE()
	End If
	
	If not isDate(dtmEarliestDate) Then
		dtmEarliestDate = SV_EARLIEST_DATE
	End If
	
	If not isDate(dtmLatestDate) Then
		dtmLatestDate = SV_LATEST_DATE
	End If
	
	rsResults.Close
	Set rsResults = NOTHING
%>
	<input type="hidden" name="dataType" value="<%=SV_DATA_TYPE_DATE%>">
	<table class="normal">
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Question/SubText
			</td>
			<td class="normalBold" valign="top">
				Question Text:
				<br />
				<input type="text" name="itemText" size="50" value="<%=strItemText%>">
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Sub Text:<span class="normal">
				(Instructional or other text <br /> 
				to appear below the question)
				</span> 
				<br />
				<textarea name="description" rows="4" cols="40"><%=strItemDescription%></textarea>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Alias:<span class="normal">(Short alias for the question that can be used to make reports easier to view)</span> 
				<br /><input type="text" name="questionAlias" size="50" value="<%=strQuestionAlias%>">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table>
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Required?
			</td>
			<td class="normalBold" valign="top">
				Answer is Required
				<input type="checkbox" name="required"
<%
				If boolRequired = True Then
%>
					checked
<%
				End If
%>
				>
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table>
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Item Options
			</td>
			<td class="normalBold" valign="top">
				Default Date:
			</td>
			<td>
				<%=common_dateSelect("default", dtmDefaultDate, 1900, 200)%>
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Earliest Date Allowed:
			</td>
			<td>
				<%=common_dateSelect("minimum", dtmEarliestDate, 1900, 200)%>
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Last Date Allowed:
			</td>
			<td>
				<%=common_dateSelect("maximum", dtmLatestDate, 1900, 200)%>
			</td>
		</tr>
	</table>
<%
End Function	

'**************************************************************************************
'Name:				editItems_editCheckboxes
'
'Purpose:			create form to allow user to edit a checkbox type question to the survey
'
'Inputs:			intNumberAnswerInputs - number of input fields for answers
'					intItemID - unique ID of item editing
'					boolScored - whether or not the survey is scored
'**************************************************************************************
Function editItems_editCheckboxes(intNumberAnswerInputs, intItemID, boolScored)
	Dim intCounter
	Dim strItemDescription
	Dim boolAllowOther
	Dim intMaxResponses
	Dim intMinResponses
	Dim strOtherText
	Dim strAnswer
	Dim boolRandomize
	Dim boolNumberLabels
	Dim intPoints
	Dim strAlias
	Dim strQuestionAlias
	Dim intNumberColumns
	
	strSQL = "SELECT itemText, itemDescription, allowOther, otherText, minimumValue, maximumValue, randomize, numberLabels, alias, layoutStyle " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID
	
	Set rsResults = utility_getRecordset(strSQL)
	
	strItemText = rsResults("itemText")
	strItemDescription = rsResults("itemDescription")
	boolAllowOther = cbool(rsResults("allowOther"))
	strOtherText = rsResults("otherText")
	
	If strOtherText = "" Then
		strOtherText = "Other:"
	End If
	
	If not isNull(rsResults("minimumValue")) Then
		If isNumeric(rsResults("minimumValue")) Then
			intMinResponses = cint(rsResults("minimumValue"))
		End If
	End If
	If not isNull(rsResults("maximumValue")) Then
		If isNumeric(rsResults("maximumValue")) Then
			intMaxResponses = cint(rsResults("maximumValue"))
		End If
	End If
	
	boolRandomize = cbool(rsResults("randomize"))
	boolNumberLabels = cbool(rsResults("numberLabels"))
	strQuestionAlias = rsResults("alias")
	intNumberColumns = rsResults("layoutStyle")
	rsResults.Close

	If not utility_isPositiveInteger(intNumberColumns) Then
		intNumberColumns = 1
	End If
%>
	
	<table class="normal" border="0">
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Question/SubText
			</td>
			<td class="normalBold" valign="top">
				Question Text:<br />
				<input type="text" name="itemText" size="50" value="<%=strItemText%>">
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Sub Text:<span class="normal">(Instructional or other text to appear below the question)</span> 
				<br /><textarea name="description" rows="4" cols="40"><%=strItemDescription%></textarea>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Alias:<span class="normal">(Short alias for the question that can be used to make reports easier to view)</span> 
				<br /><input type="text" name="questionAlias" size="50" value="<%=strQuestionAlias%>">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table border="0">
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Enter Answers
			</td>
			<td class="normal">
				<table border="0">
					<tr valign="top">
						<td class="normalBold">
							Answer Text
						</td>
<%
						If boolScored = True Then
%>
							<td class="normalBold">
								Points
							</td>
<%
						End If
%>	
						<td class="normalBold">
							Checked?
						</td>
						<td class="normalBold">
							Alias
						</td>
					</tr>
			
<%
	strSQL = "SELECT answerText, isDefault, points, alias " &_
			 "FROM usd_Answers " &_
			 "WHERE itemID = " & intItemID &_
			 " ORDER by answerID"
	
	rsResults.Open strSQL, DB_CONNECTION		 
	
	Dim strArray
	Dim strAliasArray
	Dim strDefaultArray
	Dim strPointsArray
	
	strArray = "new Array("
	strAliasArray = "new Array("
	strDefaultArray = "new Array("
	
	If boolScored = True Then
		strPointsArray = "new Array("
	End If
	
	intCounter = 0
	
	Do until intCounter >= intNumberAnswerInputs and rsResults.EOF
		If intCounter > 0 Then 
			strArray = strArray & ","
			strAliasArray = strAliasArray & ","
			strDefaultArray = strDefaultArray & ","
			If boolScored = True Then
				strPointsArray = strPointsArray & ","
			End If
		End If
		
		If not rsResults.EOF Then
			intCounter = intCounter + 1
			strAnswer = rsResults("answerText")
			boolDefault = cbool(rsResults("isDefault"))
			intPoints = rsResults("points")
			strAlias = rsResults("alias")
			rsResults.MoveNext
		Else
			intCounter = intCounter + 1
			strAnswer = ""
			boolDefault = False
			intPoints = ""
			strAlias = ""
		End If
		
		strArray = strArray & "document.forms.frmItem.answer" & intCounter 
		strAliasArray = strAliasArray & "document.forms.frmItem.alias" & intCounter
		strDefaultArray = strDefaultArray & "document.forms.frmItem.defaultAnswer" & intCounter

		
%>
					<tr valign="top">
						<td>
							<input type="text" name="answer<%=intCounter%>" size="20" value="<%=strAnswer%>">
						</td>
<%
					If boolScored = True Then
						strPointsArray = strPointsArray & "document.forms.frmItem.points" & intCounter
%>
						<td>
							<input type="text" name="points<%=intCounter%>" size="4" value="<%=intPoints%>">
						</td>
<%
					End If
%>
					<td>
						<input type="checkbox" name="defaultAnswer<%=intCounter%>" id="default<%=intCounter%>"
<%
						If boolDefault = True Then
%>
							checked
<%
						End If
%>
						><br />
					</td>
					<td>
						<input type="text" name="alias<%=intCounter%>" value="<%=strAlias%>">
					</td>
					<td valign="middle">
						<%=editItems_moveButtons(intCounter, boolScored, SV_ITEM_TYPE_CHECKBOXES, intNumberAnswerInputs)%>
					</td>
				</tr>
<%
		
	Loop		
%>
			</table>
			<input type="hidden" name="numberAnswers" value="<%=intCounter%>">
			</td>
		</tr>
	</table>
	
		
<script language="javascript">
<!--
	questionarray = <%=strArray%>);
	aliasarray = <%=strAliasArray%>);
	defaultarray = <%=strDefaultArray%>);
<%
	If boolScored = True Then
%>
	pointsarray = <%=strPointsArray%>);
<%
	End If
%>
-->
</script>
	
	<table>
		<tr valign="top">
			<td width="200">
				&nbsp;
			</td>
			<td class="message" align="center">
				OR
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Same Answers As:
			</td>
			<td class="normal">
				<%=surveyCreation_presetAnswerDropdown(intSurveyID, intItemID)%>
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table>
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Other Options
			</td>
			<td class="normalBold" valign="middle">
				Allow "other"?
			</td>
			<td valign="middle">
				<input type="checkbox" name="allowOther"
<%
				If boolAllowOther = True Then
%>
					checked
<%
				End If
%>
				>
			</td>
			<td class="normalBold">"Other" text:
			</td>
			<td>
				<input type="text" name="otherText" size="20" value="<%=strOtherText%>">
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="middle">
				Number of Columns
			</td>
			<td valign="middle">
				<input type="text" value="<%=intNumberColumns%>" name="layoutStyle" size="4">
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="middle">
				Randomize Answer Order
			</td>
			<td valign="middle">
				<input type="checkbox" name="randomize" 
<%
					If boolRandomize = True Then
%>
						checked
<%
					End If
%> 
				>
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Number Labels (e.g. 1.,2.,3.)
			</td>
			<td valign="top">
				<input type="checkbox" name="numberLabels" 
<%
					If boolNumberLabels = True Then
%>
						checked
<%
					End If
%> 
				>
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="middle">
				Maximum To Choose:
			</td>
			<td valign="middle">
				<input type="text" name="maximumValue" size="4" value="<%=intMaxResponses%>">
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="middle">
				Minimum To Choose:
			</td>
			<td valign="middle">
				<input type="text" name="minimumValue" size="4" value="<%=intMinResponses%>">
			</td>
		</tr>
	</table>
	
<%
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:				editItems_editRadio
'
'Purpose:			create form to allow user to edit a radio button type question to the survey
'
'Inputs:			intNumberAnswerInputs - number of input fields for answers
'					intItemID - unique ID of item editing
'					boolScored - whether or not the survey is scored
'**************************************************************************************
Function editItems_editRadio(intNumberAnswerInputs, intItemID, boolScored)
	Dim intCounter 
	Dim strSQL 
	Dim rsResults
	Dim strAnswer
	Dim boolDefault
	Dim strItemText
	Dim strItemDescription
	Dim boolAllowOther
	Dim boolRequired
	Dim intLayoutStyle
	Dim strOtherText
	Dim boolRandomize
	Dim boolNumberLabels
	Dim intPoints
	Dim strAlias
	Dim strQuestionAlias
	
	strSQL = "SELECT itemText, itemDescription, allowOther, isRequired, layoutStyle, otherText, randomize, numberLabels, alias " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID
	
	Set rsResults = utility_getRecordset(strSQL)
	
	strItemText = rsResults("itemText")
	strItemDescription = rsResults("itemDescription")
	boolAllowOther = cbool(rsResults("allowOther"))
	boolRequired = cbool(rsResults("isRequired"))
	intLayoutStyle = rsResults("layoutStyle")
	strOtherText = rsResults("otherText")
	boolRandomize = cbool(rsResults("randomize"))
	boolNumberLabels = cbool(rsResults("numberLabels"))
	strQuestionAlias = rsResults("alias")
	
	If strOtherText = "" Then
		strOtherText = "Other:"
	End If
	
	rsResults.Close
	
%>
	<table class="normal" width="100%">
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Question/SubText
			</td>
			<td class="normalBold" valign="top" width="200px">
				Question Text:
				<br />
				<input type="text" name="itemText" size="50" value="<%=strItemText%>">
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Sub Text:<span class="normal">
						(Instructional or other text to appear below the question)
					</span><br />
					<textarea name="description" rows="4" cols="40"><%=strItemDescription%></textarea>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Alias:<span class="normal">(Short alias for the question that can be used to make reports easier to view)</span> 
				<br /><input type="text" name="questionAlias" size="50" value="<%=strQuestionAlias%>">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table>
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Enter Answers<br>
			</td>
			<td>
				<table cellpadding="0" cellspacing="0" border="0">
					<tr valign="top">
						<td class="normalBold" valign="top" nowrap="true"> 
							Enter Answers:
						</td>
						
<%
					If boolScored = True Then
%>
						<td class="normalBold">
							Points
						</td>
<%
					End If
%>	
						<td>
							&nbsp;
						</td>
						<td class="normalBold" align="middle">
							Default?
						</td>
						<td class="normalBold" align="middle">
							Alias
						</td>
					</tr>
				
<%
	strSQL = "SELECT answerText, isDefault, points, alias " &_
			 "FROM usd_Answers " &_
			 "WHERE itemID = " & intItemID &_
			 " ORDER by orderByID, answerID"
	
	rsResults.Open strSQL, DB_CONNECTION	
	
	Dim strArray
	Dim strAliasArray
	Dim strDefaultArray
	Dim strPointsArray
	
	strArray = "new Array("
	strAliasArray = "new Array("
	strDefaultArray = "new Array("
	
	If boolScored = True Then
		strPointsArray = "new Array("
	End If
	
	Do until intCounter >= cint(intNumberAnswerInputs) and rsResults.EOF
		
		If intCounter > 0 Then 
			strArray = strArray & ","
			strAliasArray = strAliasArray & ","
			strDefaultArray = strDefaultArray & ","
			If boolScored = True Then
				strPointsArray = strPointsArray & ","
			End If
		End If
		
		intCounter = cint(intCounter + 1)
		If not rsResults.EOF Then
			strAnswer = rsResults("answerText")
			boolDefault = cbool(rsResults("isDefault"))
			intPoints = rsResults("points")
			strAlias = rsResults("alias")
			rsResults.MoveNext
		Else
			strAnswer = ""
			boolDefault = False
			intPoints = ""
			strAlias = ""
		End If
		
		strArray = strArray & "document.forms.frmItem.answer" & intCounter 
		strAliasArray = strAliasArray & "document.forms.frmItem.alias" & intCounter
		strDefaultArray = strDefaultArray & "document.forms.frmItem.defaultAnswer" & intCounter

%>
			<tr valign="top">
				<td align="middle">
					<input type="text" name="answer<%=intCounter%>" size="20" value="<%=strAnswer%>">
				</td>
<%
				If boolScored = True Then

					strPointsArray = strPointsArray & "document.forms.frmItem.points" & intCounter

%>
					<td>
						<input type="text" name="points<%=intCounter%>" size="4" value="<%=intPoints%>">
					</td>
<%
				End If
%>
					<td>
						&nbsp;
					</td>
					<td align="middle">
						<input type="checkbox" name="defaultAnswer<%=intCounter%>" id="default<%=intCounter%>"
							onclick="javascript:if (document.forms.frmItem.defaultAnswer<%=intCounter%>.checked){<%=turnOffBoxesJS(intCounter, intNumberAnswerInputs)%>}"
<%
				If boolDefault = True Then
%>
					checked
<%
				End If
%>
				>
				<td>
					<input type="text" name="alias<%=intCounter%>" value="<%=strAlias%>">
				</td>
				<td valign="middle">
<%=editItems_moveButtons(intCounter, boolScored, SV_ITEM_TYPE_RADIO, intNumberAnswerInputs)%>				

				</td>
			</tr>
<%
	Loop		
	
%>			

			</table>
			<input type="hidden" name="numberAnswers" value="<%=intCounter%>">
			</td>
		</tr>
	</table>
	
<script language="javascript">
<!--
	questionarray = <%=strArray%>);
	aliasarray = <%=strAliasArray%>);
	defaultarray = <%=strDefaultArray%>);
<%
	If boolScored = True Then
%>
	pointsarray = <%=strPointsArray%>);
<%
	End If
%>
-->
</script>
	
	<table>
		<tr valign="top">
			<td width="200">
				&nbsp;
			</td>
			<td class="message" align="right">
				OR
			</td>
		</tr>		
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Same Answers As:
			</td>
			<td class="normal">
				<%=surveyCreation_presetAnswerDropdown(intSurveyID, intItemID)%>
			</td>
		</tr>
	</table>
		<hr noshade color="#C0C0C0" size="2">
	<table>
		<tr valign="top">
			<td width="200" class="normalBold-Big">
				Required?
			</td>
			<td>
				<td class="normalBold" valign="middle">
					Answer is Required
				</td>
				<td valign="middle">
					<input type="checkbox" name="required" 
<%
					If boolRequired = True Then
%>
						checked
<%
					End If
%>
					>
				</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table>
		<tr valign="top">
			<td width="200" class="normalBold-Big">
				Other Options
			</td>
			<td class="normalBold" valign="middle">
				Allow "other"?
			</td>
			<td valign="middle">
				<input type="checkbox" name="allowOther"
<%
				If boolAllowOther = True Then
%>
					checked
<%
				End If
%> 
				>
				<span class="normalBold">"Other" text</span>
				<input type="text" name="otherText" size="20" value="<%=strOtherText%>">
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="middle">
				Randomize Answer Order
			</td>
			<td valign="middle">
				<input type="checkbox" name="randomize" 
<%
				If boolRandomize = True Then
%>
					checked
<%
				End If
%>
				>
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="middle">
				Number Labels (e.g. 1.,2.3.)
						</td>
						<td valign="middle">
							<input type="checkbox" name="numberLabels" 
<%
							If boolNumberLabels = True Then
%>
								checked
<%
							End If
%>
							>
			</td>
		</tr>			

		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="middle">
				Answer Layout Style
			</td>
			<td>
				<select name="layoutStyle">
					<option value="<%=SV_RADIO_LAYOUT_HORIZONTAL%>"
<%
					If intLayoutStyle = SV_RADIO_LAYOUT_HORIZONTAL Then
%>
						selected
<%
					End If
%>
					>Horizontal</option>
					<option value="<%=SV_RADIO_LAYOUT_VERTICAL%>"
<%
					If intLayoutStyle = SV_RADIO_LAYOUT_VERTICAL Then
%>
						selected
<%
					End If
%>
						>Vertical</option>
					</select>
			</td>
		</tr>
	</table>
<%
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:				editItems_editDropdown
'
'Purpose:			create form to allow user to edit a dropdown type question to the survey
'
'Inputs:			intNumberAnswerInputs - number of input fields for answers
'					intItemID - unique ID of item editing
'					boolScored - whether or not the survey is scored
'**************************************************************************************
Function editItems_editDropdown(intNumberAnswerInputs, intItemID, boolScored)
	Dim intCounter
	Dim strItemDescription
	Dim boolAllowOther
	Dim intMaxResponses
	Dim intMinResponses
	Dim strOtherText
	Dim strAnswer
	Dim boolRequired
	Dim boolRandomize
	Dim boolNumberLabels
	Dim intPoints
	Dim strAlias
	Dim strQuestionAlias
	
	strSQL = "SELECT itemText, itemDescription, allowOther, otherText, isRequired, randomize, numberLabels, alias " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID
	
	Set rsResults = utility_getRecordset(strSQL)
	
	strItemText = rsResults("itemText")
	strItemDescription = rsResults("itemDescription")
	boolAllowOther = cbool(rsResults("allowOther"))
	strOtherText = rsResults("otherText")
	boolRequired = cbool(rsResults("isRequired"))
	
	If strOtherText = "" Then
		strOtherText = "Other:"
	End If
	
	boolRandomize = cbool(rsResults("randomize"))
	boolNumberLabels = cbool(rsResults("numberLabels"))
	strQuestionAlias = rsResults("alias")
		
	rsResults.Close
	 
%>
	<table class="normal" width="100%">
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Question/SubText
			</td>
			<td class="normalBold" valign="top">
				Question Text:<br />
				<input type="text" name="itemText" size="50" value="<%=strItemText%>">
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Sub Text:<span class="normal">
				(Instructional or other text to appear below the question)
				</span><br />
				<textarea name="description" rows="4" cols="40"><%=strItemDescription%></textarea>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Alias:<span class="normal">(Short alias for the question that can be used to make reports easier to view)</span> 
				<br /><input type="text" name="questionAlias" size="50" value="<%=strQuestionAlias%>">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
`	<table>
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Enter Answers
			</td>
			<td>
				<table>
					<tr valign="top">
						<td class="normalBold">
							Enter Answers:
						</td>
<%
					If boolScored = True Then
%>
						<td class="normalBold">
							Points
						</td>
<%
					End If
%>	
						<td class="normalBold">
							Default?
						</td>
						<td class="normalBold">
							Alias
						</td>
					</tr>
			
<%
	strSQL = "SELECT answerText, isDefault, points, alias " &_
			 "FROM usd_Answers " &_
			 "WHERE itemID = " & intItemID &_
			 " ORDER by answerID"
	
	rsResults.Open strSQL, DB_CONNECTION		 
	
	intCounter = 0
	
		Dim strArray
	Dim strAliasArray
	Dim strDefaultArray
	Dim strPointsArray
	
	strArray = "new Array("
	strAliasArray = "new Array("
	strDefaultArray = "new Array("
	
	If boolScored = True Then
		strPointsArray = "new Array("
	End If
	
	Do until intCounter >= cint(intNumberAnswerInputs) and rsResults.EOF
		If intCounter > 0 Then 
			strArray = strArray & ","
			strAliasArray = strAliasArray & ","
			strDefaultArray = strDefaultArray & ","
			If boolScored = True Then
				strPointsArray = strPointsArray & ","
			End If
		End If

		
		intCounter = intCounter + 1
		If not rsResults.EOF Then
			strAnswer = rsResults("answerText")
			boolDefault = cbool(rsResults("isDefault"))
			intPoints = rsResults("points")
			strAlias = rsResults("alias")
			rsResults.MoveNext
		Else
			strAnswer = ""
			boolDefault = False
			intPoints = ""
			strAlias = ""
		End If
		
		strArray = strArray & "document.forms.frmItem.answer" & intCounter 
		strAliasArray = strAliasArray & "document.forms.frmItem.alias" & intCounter
		strDefaultArray = strDefaultArray & "document.forms.frmItem.defaultAnswer" & intCounter
%>
				<tr valign="top">
					<td>
						<input type="text" name="answer<%=intCounter%>" size="20" value="<%=strAnswer%>">
					</td>
<%
					If boolScored = True Then
						strPointsArray = strPointsArray & "document.forms.frmItem.points" & intCounter
%>
						<td>
							<input type="text" size="4" name="points<%=intCounter%>" value="<%=intPoints%>">
						</td>
<%
					End If
%>
					<td>
						<input type="checkbox" name="defaultAnswer<%=intCounter%>" id="default<%=intCounter%>"
							onclick="javascript:if (document.forms.frmItem.defaultAnswer<%=intCounter%>.checked){<%=turnOffBoxesJS(intCounter, intNumberAnswerInputs)%>}"
<%
						If boolDefault = True Then
%>	
							checked
<%
						End If
%>
						>
					</td>
					<td>
						<input type="text" name="alias<%=intCounter%>" value="<%=strAlias%>">
					</td>
					<td valign="middle">
						<%=editItems_moveButtons(intCounter, boolScored, SV_ITEM_TYPE_DROPDOWN, intNumberAnswerInputs)%>		
					</td>
				</tr>				
<%
		
	Loop		
%>
			</table>
			<input type="hidden" name="numberAnswers" value="<%=intCounter%>">
			</td>
		</tr>
</table>
<script language="javascript">
<!--
	questionarray = <%=strArray%>);
	aliasarray = <%=strAliasArray%>);
	defaultarray = <%=strDefaultArray%>);
<%
	If boolScored = True Then
%>
	pointsarray = <%=strPointsArray%>);
<%
	End If
%>
-->
</script>
<table>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td align="right" class="message">
				OR
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Same Answers As:
			</td>
			<td class="normal">
				<%=surveyCreation_presetAnswerDropdown(intSurveyID, intItemID)%>
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table>
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Required?
			</td>
			<td class="normalBold" valign="top">
				Answer is Required
			</td>
			<td valign="top">
				<input type="checkbox" name="required"
<%
					If boolRequired = True Then
%>
						checked
<%
					End If
%> 
	
				>
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table>
		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Other Options
			</td>
			<td class="normalBold" valign="top">
				Allow "other"?
			</td>
			<td valign="top">
				<input type="checkbox" name="allowOther"
<%
				If boolAllowOther = True Then
%>
					checked
<%
				End If
%> 
				>
			</td>
			<td valign="top">
				<span class="normalBold">"Other" text</span>
				<input type="text" name="otherText" value="<%=strOtherText%>" size="20">
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Randomize Answer Order
			</td>
			<td valign="top">
				<input type="checkbox" name="randomize" 
<%
					If boolRandomize = True Then
%>
						checked
<%
					End If
%> 
	
				>
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Number Labels (e.g. 1.,2.,3.)
			</td>
			<td valign="top">
				<input type="checkbox" name="numberLabels" 
<%
					If boolNumberLabels = True Then
%>
						checked
<%
					End If
%> 
	
				>
			</td>
		</tr>
	</table>
<%
End Function

'**************************************************************************************
'Name:				editItems_editMatrix
'
'Purpose:			create form to allow user to edit a matrix type question to the survey
'
'Inputs:			intNumberAnswerInputs - number of input fields for answers
'					intItemID - unique ID of item editing
'					boolScored - whether or not the survey is scored
'**************************************************************************************
Function editItems_editMatrix(intNumberAnswerInputs, intItemID, boolScored, intItemCategoryID)
	Dim intCounter 
	Dim strSQL 
	Dim rsResults
	Dim strAnswer
	Dim boolDefault
	Dim strItemText
	Dim strItemDescription
	Dim boolAllowOther
	Dim boolRequired
	Dim intLayoutStyle
	Dim strOtherText
	Dim boolRandomize
	Dim boolNumberLabels
	Dim intPoints
	Dim strAlias
	Dim strQuestionAlias
	Dim strCategory
	Dim strCategoryAlias
	Dim intQuestionSize
	Dim strQuestionColor
	Dim intQuestionDescriptionSize
	Dim strQuestionDescriptionColor
	Dim intAnswerSize
	Dim strAnswerColor
	Dim strBaseFont
	Dim strOddRowColor
	Dim strEvenRowColor
	Dim strHeaderColor
	
	strSQL = "SELECT itemText, itemDescription, allowOther, isRequired, layoutStyle, otherText, " &_
			 "randomize, SI.numberLabels, " &_
			 "questionSize, questionColor, questionDescriptionSize, questionDescriptionColor, answerSize, answerColor, baseFont, " &_
			 "oddRowColor, evenRowColor, headerColor " &_
			 "FROM usd_SurveyItem SI, usd_styleTemplates ST, usd_survey S " &_
			 "WHERE itemID = " & intItemID &_
			 " AND SI.surveyID = S.surveyID " &_
			 " AND ST.templateID = S.templateID"
	
	Set rsResults = utility_getRecordset(strSQL)
	
	If not rsResults.EOF Then
	
		strItemText = rsResults("itemText")
		strItemDescription = rsResults("itemDescription")
		boolAllowOther = cbool(rsResults("allowOther"))
		boolRequired = cbool(rsResults("isRequired"))
		intLayoutStyle = rsResults("layoutStyle")
		strOtherText = rsResults("otherText")
		boolRandomize = cbool(rsResults("randomize"))
		boolNumberLabels = cbool(rsResults("numberLabels"))
		intQuestionSize = rsResults("questionSize")
		strQuestionColor = rsResults("questionColor")
		intQuestionDescriptionSize = rsResults("questionDescriptionSize")
		strQuestionDescriptionColor = rsResults("questionDescriptionColor")
		intAnswerSize = rsResults("answerSize")
		strAnswerColor = rsResults("answerColor")
		strBaseFont = rsResults("baseFont")
		strOddRowColor = rsResults("oddRowColor")
		strEvenRowColor = rsResults("evenRowColor")
		strHeaderColor = rsResults("headerColor")
		rsResults.Close
	Else
		rsResults.Close
		strSQL = "SELECT itemText, itemDescription, allowOther, isRequired, layoutStyle, otherText, " &_
			 "randomize, numberLabels " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID 
		rsResults.Open strSQL, DB_CONNECTION
		strItemText = rsResults("itemText")
		strItemDescription = rsResults("itemDescription")
		boolAllowOther = cbool(rsResults("allowOther"))
		boolRequired = cbool(rsResults("isRequired"))
		intLayoutStyle = rsResults("layoutStyle")
		strOtherText = rsResults("otherText")
		boolRandomize = cbool(rsResults("randomize"))
		boolNumberLabels = cbool(rsResults("numberLabels"))
		
		rsResults.Close
	End If
	
	intQuestionSize = 5
	
	If strOtherText = "" Then
		strOtherText = "Other:"
	End If
	
	
	
	Call itemDisplay_displayMatrix(intItemID, "",0,False, intQuestionSize, strQuestionColor, _
									intQuestionDescriptionSize, strQuestionDescriptionColor, intAnswerSize, strAnswerColor, strBaseFont, _
									0, False, True, strOddRowColor, strEvenRowColor, strHeaderColor, intItemCategoryID,0)
	
	Set rsResults = NOTHING
End Function

Function editItems_moveButtons(intCounter, boolScored, intItemType, intNumberAnswerInputs)
	If intCounter < intNumberAnswerInputs Then
%>					
					<img style="cursor:hand" src="images/button-down-mini.gif" hspace="2" border="0" alt="Move Answer Down" width="15" height="15" onclick="javascript:swTextBox(document.forms.frmItem.answer<%=intCounter%>, document.forms.frmItem.answer<%=intCounter +1%>);swTextBox(document.forms.frmItem.alias<%=intCounter%>, document.forms.frmItem.alias<%=intCounter +1%>);swCheckBox(document.forms.frmItem.defaultAnswer<%=intCounter%>, document.forms.frmItem.defaultAnswer<%=intCounter +1%>);
<%
					If boolScored = True Then
%>
						swTextBox(document.forms.frmItem.points<%=intCounter%>, document.forms.frmItem.points<%=intCounter +1%>);
<%
					End If
%>						
					
					return false;">
					
<%	
	Else
%>
		&nbsp;
<%
	End If
%>
		</td>
		<td valign="middle">
<%
	If intCounter > 1 Then
%>					
					<img style="cursor:hand" hspace="2" src="images/button-up-mini.gif" border="0" alt="Move Answer Up" width="15" height="15" onclick="javascript:swTextBox(document.forms.frmItem.answer<%=intCounter%>, document.forms.frmItem.answer<%=intCounter -1%>);swTextBox(document.forms.frmItem.alias<%=intCounter%>, document.forms.frmItem.alias<%=intCounter -1%>);swCheckBox(document.forms.frmItem.defaultAnswer<%=intCounter%>, document.forms.frmItem.defaultAnswer<%=intCounter -1%>);
<%
					If boolScored = True Then
%>
						swTextBox(document.forms.frmItem.points<%=intCounter%>, document.forms.frmItem.points<%=intCounter -1%>);
<%
					End If
%>					
					return false;">
					
<%	
	Else
%>
		&nbsp;
<%
	End If
%>
	</td>
	<td valign="middle">
		<img style="cursor:hand" hspace="2" src="images/button-delete-mini.gif" border="0" alt="Delete Answer" width="15" height="15" onclick="javascript:if (confirm('Are you sure you want to delete this answer?') == true) { deleteElement(questionarray,<%=intCounter%>);deleteElement(aliasarray,<%=intCounter%>);deleteCheckbox(defaultarray,<%=intCounter%>); 
<%
	If boolScored = True Then
%>
		deleteElement(pointsarray,<%=intCounter%>);
<%
	End If
%>		
		}return false;">
<%	
End Function

Function turnOffBoxesJS(intCounter, intNumberAnswerInputs)
	Dim intNewCounter
	
	
	For intNewCounter = 1 to intNumberAnswerInputs
		If intNewCounter <> intCounter Then
%>
			document.forms.frmItem.defaultAnswer<%=intNewCounter%>.checked = false;
<%
		Else
%>
			
<%
		End If
	Next
%>
	document.forms.frmItem.defaultAnswer<%=intCounter%>.checked = true;
<%
End Function
%>
