<%
'****************************************************
'
' Name:		addItems_inc.asp Server-Side Include
' Purpose:		Provides functions to add items of various types
'
' Date Written:	6/18/2002
' Modified:		
'
'****************************************************

'**************************************************************************************
'Name:			itemTypes_addHeader
'
'Purpose:		create form to allow user to add a header to the survey
'
'Inputs:		None
'**************************************************************************************
Function itemTypes_addHeader()
%>
	<table class="normal" cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" width="200" valign="top">
				Header Options
			</td>
			<td class="normalBold" valign="top">
				Header Text:<br />
				<input type="text" name="itemText" size="50">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Sub Text:<br />
				<textarea name="description" rows="4" cols="40"></textarea>
			</td>
		</tr>
	</table>
<%
End Function		

'**************************************************************************************
'Name:			itemTypes_addSingleLine
'
'Purpose:		create form to allow user to add a single line text field
'
'Inputs:		None
'**************************************************************************************
Function itemTypes_addSingleLine()
%>
	<table class="normal" cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" width="200">
				Question
			</td>
			<td class="normalBold" valign="top">
				Question Text:<br /><input type="text" name="itemText" size="50">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Sub Text:<span class="normal">(Instructional or other text to appear below the question)</span> 
				<br /><textarea name="description" rows="4" cols="40"></textarea>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Alias:<span class="normal">(Short alias for the question that can be used to make reports easier to view)</span> 
				<br /><input type="text" name="questionAlias" size="50">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table>
		<tr>
			<td class="normalBold-Big" width="200">
				Required?
			</td>
			<td class="normalBold" valign="bottom">
				Answer is Required
			</td>
			<td valign="bottom">
				<input type="checkbox" name="required">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" width="200">
				Other Options
			</td>
			<td class="normalBold" valign="bottom">
				Required Answer Format:
			</td>
			<td valign="bottom">
				<select name="dataType">
					<option value="">
						None
					</option>
					<option value="<%=SV_DATA_TYPE_NUMBER%>">
						Numbers Only
					</option>
					<option value="<%=SV_DATA_TYPE_INTEGER%>">
						Integers Only
					</option>
					<option value="<%=SV_DATA_TYPE_DECIMAL%>">
						Decimals Only
					</option>
					<option value="<%=SV_DATA_TYPE_MONEY%>">
						Money
					</option>
					<option value="<%=SV_DATA_TYPE_EMAIL%>">
						Email Address
					</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td>
				<span class="normalBold">Minimum Value:</span>
			</td>
			<td>
				<input type="text" name="minimumValue" size="4">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td>
				<span class="normalBold">Maximum Value:</span>
			</td>
			<td>
				<input type="text" name="maximumValue" size="4">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="bottom">
				Default Value:
			</td>
			<td valign="bottom">
				<input type="text" name="defaultValue" size="30">
			</td>
		</tr>
	</table>

<%
End Function	

'**************************************************************************************
'Name:			itemTypes_addHTML
'
'Purpose:		create form to allow user to add an html item 
'
'Inputs:		None
'**************************************************************************************
Function itemTypes_addHTML()
%>
	<table class="normal">
		<tr>
			<td class="normalBold-Big" valign="top" width="200">
				HTML:
			</td>
			<td>
				<textarea name="itemText" rows="20" cols="50"></textarea>
			</td>
		</tr>
	</table>
<%
End Function

'**************************************************************************************
'Name:			itemTypes_addMessage
'
'Purpose:		create form to allow user to add a message item
'
'Inputs:		none
'**************************************************************************************
Function itemTypes_addMessage()
%>
	<table class="normal">
		<tr>
			<td class="normalBold-Big" valign="top" width="200">
				Message
			</td>
			<td>
				<textarea name="itemText" rows="6" cols="50"></textarea>
			</td>
		</tr>
	</table>
<%
End Function

'**************************************************************************************
'Name:			itemTypes_addLine
'
'Purpose:		create form to allow user to add a horizontal line as an item
'
'Inputs:		none
'**************************************************************************************
Function itemTypes_addLine()
%>
	<table class="normal">
		<tr>
			<td class="normalBold-Big" valign="top">
				Sample:
			</td>
		</tr>
	</table>
	<hr>
<%
End Function

'**************************************************************************************
'Name:			itemTypes_addTextArea
'
'Purpose:		create form to allow user to add a textarea type question to the survey
'
'Inputs:		None
'**************************************************************************************
Function itemTypes_addTextArea()
%>
	<table class="normal" cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" width="200">
				Question/SubText
			</td>
			<td class="normalBold" valign="top">
				Question Text:<br /><input type="text" name="itemText" size="50">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Sub Text:<span class="normal">(Instructional or other text to appear below the question)</span> 
				<br /><textarea name="description" rows="4" cols="40"></textarea>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Alias:<span class="normal">(Short alias for the question that can be used to make reports easier to view)</span> 
				<br /><input type="text" name="questionAlias" size="50">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table class="normal" cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" valign="top" width="200">
				Required?
			</td>
			<td class="normalBold" valign="top">
				Answer is Required
			</td>
			<td valign="top">
				<input type="checkbox" name="required">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table class="normal" cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" width="200">
				Item Options
			</td>
			<td class="normalBold" valign="top">
				Default Value:<br /><textarea name="defaultValue" rows="4" cols="40"></textarea>
			</td>
		</tr>
	</table>
<%
End Function	

'**************************************************************************************
'Name:			itemTypes_addDate
'
'Purpose:		create form to allow user to add a date type question to the survey
'
'Inputs:		None
'**************************************************************************************
Function itemTypes_addDate()
%>
	<input type="hidden" name="dataType" value="<%=SV_DATA_TYPE_DATE%>">
	<table class="normal" cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" width="200">
				Question/SubText
			</td>
			<td class="normalBold" valign="top">
				Question Text:<br />
				<input type="text" name="itemText" size="50">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Sub Text:<span class="normal">(Instructional or other text to appear below the question)
				</span><br /> 
				<textarea name="description" rows="4" cols="40"></textarea>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Alias:<span class="normal">(Short alias for the question that can be used to make reports easier to view)</span> 
				<br /><input type="text" name="questionAlias" size="50">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table class="normal" cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" width="200">
				Required?
			</td>
			<td class="normalBold" valign="top">
				Answer is Required
			</td>
			<td valign="top">
				<input type="checkbox" name="required">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table class="normal" cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" width="200">
				Item Options
			</td>
			<td class="normalBold" valign="top">
				Default Date:
			</td>
			<td>
				<%=common_dateSelect("default", DATE(), 1900, 200)%>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Earliest Date Allowed:
			</td>
			<td>
				<%=common_dateSelect("minimum", SV_EARLIEST_DATE, 1900, 200)%>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Last Date Allowed:
			</td>
			<td>
				<%=common_dateSelect("maximum", SV_LATEST_DATE, 1900, 200)%>
			</td>
		</tr>
	</table>
<%
End Function	

'**************************************************************************************
'Name:				itemTypes_addCheckboxes
'
'Purpose:			create form to allow user to add a checkbox type question to the survey
'
'Inputs:			intNumberAnswerInputs - number of input fields for answers
'					intSurveyID - unique ID of survey checkboxes being added to
'					boolScored - whether or not survey is scored
'**************************************************************************************
Function itemTypes_addCheckboxes(intNumberAnswerInputs, intSurveyID, boolScored)
	Dim intCounter 
	
%>
	<table class="normal" cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" width="200">
				Question/SubText
			</td>
			<td class="normalBold">
				Question Text:<br />
				<input type="text" name="itemText" size="50">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold">
				Sub Text:<span class="normal">
				(Instructional or other text to appear below the question)
				</span><br /><textarea name="description" rows="4" cols="40"></textarea>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Alias:<span class="normal">(Short alias for the question that can be used to make reports easier to view)</span> 
				<br /><input type="text" name="questionAlias" size="50">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table class="normal" cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" width="200" valign="top">
				Enter Answers
			</td>
				<td class="normal">
					<table>
						<tr>
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
	Do until intCounter = intNumberAnswerInputs
		intCounter = intCounter + 1
%>
				<tr>
					<td valign="top">
						<input type="text" name="answer<%=intCounter%>" size="20">
					</td>
<%
					If boolScored = True Then
%>
						<td valign="top">
							<input type="text" size="4" name="points<%=intCounter%>"><br />
						</td>
<%
					End If
%>
					<td valign="top" align="middle">
						<input type="checkbox" name="checked<%=intCounter%>"><br />
					</td>
					<td valign="top">
						<input type="text" name="alias<%=intCounter%>">
					</td>
				</tr>
<%
		
	Loop		
%>
			</table>
			<input type="hidden" name="numberAnswers" value="<%=intNumberAnswerInputs%>">
			</td>
		</tr>
	</table>
	<table>
		<tr>
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
			<td>
				<%=surveyCreation_presetAnswerDropdown(intSurveyID, "")%>
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table>
		<tr>
			<td class="normalBold-Big" width="200">
				Other Options
			</td>
			<td class="normalBold" valign="middle">
				Allow "other"?
			</td>
			<td valign="middle">
				<input type="checkbox" name="allowOther">
				<span class="normalBold">"Other" text</span>
				<input type="text" name="otherText" value="Other:" size="20">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="middle">
				Randomize Answer Order
			</td>
			<td valign="middle">
				<input type="checkbox" name="randomize" >
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Number Labels (e.g. 1.,2.,3.)
			</td>
			<td valign="top">
				<input type="checkbox" name="numberLabels" >
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="middle">
				Maximum To Choose:
			</td>
			<td valign="middle">
				<input type="text" name="maximumValue" size="4">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="middle">
				Minimum To Choose:
			</td>
			<td valign="middle">
				<input type="text" name="minimumValue" size="4">
			</td>
		</tr>
	</table>
<%
End Function

'**************************************************************************************
'Name:				itemTypes_addRadio
'
'Purpose:			create form to allow user to add a radio button type question to the survey
'
'Inputs:			intNumberAnswerInputs - number of input fields for answers
'					boolScored - whether or not survey is scored
'**************************************************************************************
Function itemTypes_addRadio(intNumberAnswerInputs, boolScored)
	Dim intCounter 
%>
	<table class="normal" cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" width="200">
				Question/SubText
			</td>
			<td class="normalBold" valign="top" width="200px">
					Question Text:<br /><input type="text" name="itemText" size="50">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Sub Text:<span class="normal">(Instructional or other text to appear below the question)</span>
				<br />
				<textarea name="description" rows="4" cols="40"></textarea>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Alias:<span class="normal">(Short alias for the question that can be used to make reports easier to view)</span> 
				<br /><input type="text" name="questionAlias" size="50">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table class="normal" cellpadding="0" cellspacing="0">	
		<tr>
			<td class="normalBold-Big" width="200" valign="top">
				Enter Answers
			</td>
			<td>
				<table class="normalBold">
					<tr>
						<td>
							Answer Text
						</td>
<%
						If boolScored = True Then
%>
							<td valign="top">
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
				Do until intCounter = intNumberAnswerInputs
					intCounter = intCounter + 1
%>
					<tr>
						<td align="middle">
							<input type="text" name="answer<%=intCounter%>" size="20">
						</td>
<%
						If boolScored = True Then
%>
						<td valign="top">
							<input type="text" size="4" name="points<%=intCounter%>"><br />
						</td>
<%
						End If
%>
						<td align="middle">
							<input type="radio" name="default" value="<%=intCounter%>">
						</td>
						<td align="middle">
							<input type="text" name="alias<%=intCounter%>">
						</td>
					</tr>
<%
		
				Loop		
%>
			</table>
			<input type="hidden" name="numberAnswers" value="<%=intNumberAnswerInputs%>">
			</td>
		</tr>
	</table>
	<table class="normal" cellpadding="0" cellspacing="0">	
		<tr>
			<td width="200">
				&nbsp;
			</td>
			<td class="message" align="center">
				OR
			</td>
		</tr>		
		<tr>
			<td class="normalBold" valign="top">
				Same Answers As:
			</td>
			<td class="normal">
				<%=surveyCreation_presetAnswerDropdown(intSurveyID, "")%>
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table class="normal" cellpadding="0" cellspacing="0">	
		<tr>
			<td class="normalBold-Big" width="200">
				Required?
			</td>
			<td class="normalBold" valign="middle">
				Answer is Required
			</td>
			<td valign="middle">
				<input type="checkbox" name="required" >
			</td>
		</tr>
	</table>		
	<hr noshade color="#C0C0C0" size="2">
	<table class="normal" cellpadding="0" cellspacing="0">	
		<tr>
			<td class="normalBold-Big" width="200">
				Other Options
			</td>
			<td class="normalBold" valign="middle">
				Allow "other"?
			</td>
			<td valign="middle">
				<input type="checkbox" name="allowOther">
				<span class="normalBold">"Other" text</span>
				<input type="text" name="otherText" value="Other:" size="20">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="middle">
				Randomize Answer Order
			</td>
			<td valign="middle">
				<input type="checkbox" name="randomize" >
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="middle">
				Number Labels (e.g. 1.,2.3.)
			</td>
			<td valign="middle">
				<input type="checkbox" name="numberLabels" >
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="middle">
				Answer Layout Style
			</td>
			<td>
				<select name="layoutStyle">
					<option value="<%=SV_RADIO_LAYOUT_HORIZONTAL%>">Horizontal</option>
					<option value="<%=SV_RADIO_LAYOUT_VERTICAL%>">Vertical</option>
				</select>
			</td>
		</tr>
	</table>
<%
End Function

'**************************************************************************************
'Name:				itemTypes_addDropdown
'
'Purpose:			create form to allow user to add a dropdown type question to the survey
'
'Inputs:			intNumberAnswerInputs - number of input fields for answers
'					boolScored - whether or not survey is scored
'**************************************************************************************
Function itemTypes_addDropdown(intNumberAnswerInputs, boolScored)
	Dim intCounter 
%>
	<table class="normal" cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" width="200">
				Question
			</td>
			<td class="normalBold" valign="top">
				Question Text:<br />
				<input type="text" name="itemText" size="50">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Sub Text:<span class="normal">(Instructional or other text to appear below the question)
				</span><br /><textarea name="description" rows="4" cols="40"></textarea>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Alias:<span class="normal">(Short alias for the question that can be used to make reports easier to view)</span> 
				<br /><input type="text" name="questionAlias" size="50">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table class="normal" cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" width="200" valign="top">
				Enter Answers
			</td>
			<td>
				<table class="normalBold">
					<tr>
						<td>
							Answer Text
						</td>
<%
						If boolScored = True Then
%>
							<td valign="top">
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
	Do until intCounter = intNumberAnswerInputs
		intCounter = intCounter + 1
%>
				<tr>
					<td>
						<input type="text" name="answer<%=intCounter%>" size="20">
					</td>
<%
					If boolScored = True Then
%>
						<td valign="top">
							<input type="text" size="4" name="points<%=intCounter%>"><br />
						</td>
<%
					End If
%>
					<td align="middle">
						<input type="radio" name="default" value="<%=intCounter%>">
					</td>
					<td>
						<input type="text" name="alias<%=intCounter%>">
					</td>
				</tr>				
<%
		
	Loop		
%>
			</table>
			<input type="hidden" name="numberAnswers" value="<%=intNumberAnswerInputs%>">
			</td>
		</tr>
	</table>
	<table>
		<tr>
			<td width="200">
				&nbsp;
			</td>
			<td align="right" class="message">
				OR
			</td>
		</tr>
		<tr>
			<td width="200">
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Same Answers As:
			</td>
			<td class="normal">
				<%=surveyCreation_presetAnswerDropdown(intSurveyID, "")%>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" width="200">
				Required?
			</td>
			<td class="normalBold" valign="top">
				Answer is Required
			</td>
			<td valign="top">
				<input type="checkbox" name="required">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table cellpadding="0" cellspacing="0">	
		<tr valign="top"> 
			<td class="normalBold-Big" width="200" valign="top">
				Other Options
			</td>
			<td class="normalBold" valign="top">
				Allow "other"?
			</td>
			<td valign="top">
				<input type="checkbox" name="allowOther">
				<span class="normalBold">"Other" text</span>
				<input type="text" name="otherText" value="Other:" size="20">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Randomize Answer Order
			</td>
			<td valign="top">
				<input type="checkbox" name="randomize" >
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Number Labels (e.g. 1.,2.,3.)
			</td>
			<td valign="top">
				<input type="checkbox" name="numberLabels" >
			</td>
		</tr>
	</table>
<%
End Function

'**************************************************************************************
'Name:				itemTypes_addImage
'
'Purpose:			create form to allow user to add an image to the survey
'
'Inputs:			strCurrentURL - URL of page adding form to
'					strDefaulltImage - string of location of image to be default (optional)
'					intSurveyID - unique ID of survey adding image to
'**************************************************************************************
Function itemTypes_addImage(strCurrentURL, strDefaultImage, intSurveyID)

	If trim(strDefaultImage) <> "" Then
		strDefaultImage = SV_UPLOADED_IMAGE_URL & strDefaultImage
	End If
			
%>
	<img src="<%=strDefaultImage%>" border="0" />
	<table class="normal">
		<tr>
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
					<img src="images/button-upload.gif" alt="Upload" border="0"></a>
			</td>
		</tr>
	</table>
		
<%
End Function

'**************************************************************************************
'Name:				itemTypes_addMatrix
'
'Purpose:			create form to allow user to add a matrix type question to the survey
'
'Inputs:			intNumberAnswerInputs - number of input fields for answers
'					boolScored - whether or not survey is scored
'**************************************************************************************
Function itemTypes_addMatrix(intNumberAnswerInputs, boolScored)
	Dim intCounter 
%>
	<table class="normal" cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" width="200">
				Question
			</td>
			<td class="normalBold" valign="top">
				Question Text:<br />
				<input type="text" name="itemText" size="50">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Sub Text:<span class="normal">(Instructional or other text to appear below the question)
				</span><br /><textarea name="description" rows="4" cols="40"></textarea>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Alias:<span class="normal">(Short alias for the question that can be used to make reports easier to view)</span> 
				<br /><input type="text" name="questionAlias" size="50">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table class="normal" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="normalBold-Big" width="200" valign="top">
				Enter Matrix Categories
			</td>
		</tr>
		<tr>
			<td class="normal" colspan="2">
				Enter the categories for your matrix question.  Categories are the items that you will be specifying answers for.  Categories appear vertically, with the answers next to them.
			</td>		
		</tr>
		<tr>

			<td>
				<table class="normalBold">
					<tr>
						<td width="200">
							&nbsp;
						</td>
						<td>
							Category Text
						</td>
						<td class="normalBold">
							Alias
						</td>
					</tr>
			
<%
	For intCounter = 1 To cint(intNumberAnswerInputs)
%>
				<tr>
					<td width="200">
						&nbsp;
					</td>
					<td>
						<input type="text" name="categoryText<%=intCounter%>" size="20">
					</td>
					<td>
						<input type="text" name="categoryAlias<%=intCounter%>">
					</td>
				</tr>				
<%
		
	Next		
%>
			</table>
			<input type="hidden" name="numberCategories" value="<%=intNumberAnswerInputs%>">
			</td>
		</tr>
	</table>
		<hr noshade color="#C0C0C0" size="2">
	<table class="normal" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="normalBold-Big" width="200" valign="top">
				Enter Matrix Answers
			</td>
		</tr>
		<tr>
			<td class="normal" colspan="2">
				Enter the allowed answers.  The set of answers is the same for each category.  Answer choices appear horizontally
				next to each category.
			</td>
		</tr>
		<tr>
			<td>
				<table class="normalBold">
					<tr>
						<td width="200">
							&nbsp;
						</td>
						<td>
							Answer Text
						</td>
						<td class="normalBold">
							Alias
						</td>
<%
						If boolScored = True Then
%>
							<td valign="top">
								Points
							</td>
<%
						End If
%>
						<td class="normalBold">
							Default?
						</td>

					</tr>
			
<%
	For intCounter = 1 to cint(intNumberAnswerInputs)
%>
				<tr>
					<td width="200">
							&nbsp;
						</td>
					<td>
						<input type="text" name="answer<%=intCounter%>" size="20">
					</td>
					<td>
						<input type="text" name="alias<%=intCounter%>">
					</td>
<%
					If boolScored = True Then
%>
						<td valign="top">
							<input type="text" size="4" name="points<%=intCounter%>"><br />
						</td>
<%
					End If
%>
					<td align="middle">
						<input type="checkbox" name="checked<%=intCounter%>">
					</td>

				</tr>				
<%
		
	Next		
%>
			</table>
		</td>
	</tr>
	</table>
	<table>
		<tr>
			<td width="200">
				&nbsp;
			</td>
			<td align="right" class="message">
				OR
			</td>
		</tr>
		<tr>
			<td width="200">
				&nbsp;
			</td>
			<td class="normalBold" valign="top">
				Same Answers As:
			</td>
			<td class="normal">
				<%=surveyCreation_presetAnswerDropdown(intSurveyID, "")%>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" width="200">
				Layout
			</td>
			<td class="normalBold" valign="top">
				<%=surveyCreation_matrixLayoutDropdown(0)%>
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table cellpadding="0" cellspacing="0">
		<tr>
			<td class="normalBold-Big" width="200">
				Required?
			</td>
			<td class="normalBold" valign="top">
				Answer is Required
			</td>
			<td valign="top">
				<input type="checkbox" name="required">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table cellpadding="0" cellspacing="0">	
		<tr valign="top"> 
			<td class="normalBold-Big" width="200" valign="top">
				Other Options
			</td>
			<td class="normalBold" valign="top">
				Number Labels (e.g. 1.,2.,3.)
			</td>
			<td valign="top">
				<input type="checkbox" name="numberLabels" >
			</td>
		</tr>
	</table>
	<input type="hidden" name="numberAnswers" value="<%=intNumberAnswerInputs%>">
		
<%
End Function
%>