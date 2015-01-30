<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/editItems_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/itemDisplay_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/surveyCreation_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%

Dim strSQL
Dim rsResults
Dim intItemID
Dim intNumberAnswers
Dim strAnswer
Dim intNumberFields
Dim intUserID
Dim intSurveyID
Dim intUserType
Dim strAlias
Dim intCounter
Dim intPageID
Dim intItemType
Dim intAnswerSetID
Dim intSetType
Dim intPoints
Dim boolDefault
Dim boolRequired
Dim strSetText
Dim strScaleStartText
Dim strScaleEndText
Dim intScaleStart
Dim intScaleEnd
Dim strPageHeader
Dim strSetTypeText
Dim intItemCategoryID
Dim strError
Dim boolUnique
Dim boolScored
Dim strArray
Dim strAliasArray
Dim strDefaultArray
Dim strPointsArray
Dim intFieldLength

'Get the userid and usertype out of the session or cookie
Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
		
'get values from page request
intSurveyID = cint(Request.QueryString("surveyID"))
	
intPageID = Request.QueryString("pageID")
intItemType = Request.QueryString("itemType")
intAnswerSetID = Request.QueryString("setID")	
intItemCategoryID = Request.QueryString("categoryID")

If utility_isPositiveInteger(intAnswerSetID) Then
	strPageHeader = "Edit Answer Set"
Else
	intAnswerSetID = 0
	strPageHeader = "Add Answer Set"
End If

'validate user credentials
If utility_isPositiveInteger(intSurveyID) Then
	If ((survey_getOwnerID(intSurveyID) <> intUserID) _
			and intUserType = SV_USER_TYPE_CREATOR) _
			or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If
Else
	If not utility_isPositiveInteger(intItemCategoryID) Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If
End If

intItemID = Request.QueryString("itemID")

intSetType = cint(Request.QueryString("setType"))

intNumberFields = Request.Form("numberFields")

boolScored = survey_isScored(intSurveyID)
If Request.Form("submitted") = "submit" Then
	If Request.Form("isRequired") = "on" Then
		boolRequired = True
	Else
		boolRequired = False
	End If
	
	If Request.Form("enforceUnique") = "on" Then
		boolUnique = True
	Else
		boolUnique = False
	End If
	
	intAnswerSetID = Request.Form("answerSetID")
	strAlias = Request.Form("setAlias")
	strSetText = Request.Form("setText")
	strScaleStartText = Request.Form("scaleStartText")
	strScaleEndText = Request.Form("scaleEndText")
	intScaleStart = Request.Form("scaleStart")
	intScaleEnd = Request.Form("scaleEnd")
	intFieldLength = Request.Form("fieldLength")
	
	If intSetType = SV_MATRIX_LAYOUT_SCALE and (not utility_isPositiveInteger(intScaleStart) or not utility_isPositiveInteger(intScaleEnd)) Then
		strError = "Start of Scale and End of Scale must both be positive numbers." 
	Else
		If not utility_isPositiveInteger(intAnswerSetID) Then
			intAnswerSetID = surveyCreation_addAnswerSet(intItemID, intSetType, boolRequired, strSetText)
		End If
		
		If not utility_isPositiveInteger(intFieldLength) Then
			intFieldLength = 20
		End If
		
		strSQL = "UPDATE usd_matrixSets SET isRequired = " & abs(cint(boolRequired)) & ", setText = " & utility_SQLEncode(strSetText, True) &_
				 ", alias = " & utility_SQLEncode(strAlias, True) &_
				 ", scaleStart = " & utility_SQLEncode(intScaleStart, True) &_
				 ", scaleEnd = " & utility_SQLEncode(intScaleEnd, True) &_
				 ", scaleStartText = " & utility_SQLEncode(strScaleStartText,True) &_
				 ", scaleEndText = " & utility_SQLEncode(strScaleEndText, True) &_ 
				 ", enforceUnique = " & abs(cint(boolUnique)) &_ 
				 ", fieldLength = " & intFieldLength &_
				 " WHERE matrixSetID = " & intAnswerSetID
		Call utility_executeCommand(strSQL)
	
			
		intNumberAnswers = Request.Form("numberAnswers")

		'strSQL = "DELETE FROM usd_matrixAnswers " &_
		'		 "WHERE matrixSetID = " & intAnswerSetID
		'Call utility_executeCommand(strSQL)

		If utility_isPositiveInteger(intNumberAnswers) Then
	
			For intCounter = 0 to cint(intNumberAnswers)
				strAnswer = trim(Request.Form("category" & intCounter))
				intPoints = Request.Form("points" & intCounter)
				strAlias = trim(Request.Form("alias" & intCounter))
				
				
					If Request.Form("default" & intCounter) = "on" Then
						boolDefault = True
					Else
						boolDefault = False
					End If
				
						
				If len(strAnswer) > 0 Then
					Call surveyCreation_addMatrixAnswer(intAnswerSetID, strAnswer, boolDefault, intPoints, strAlias, intCounter)
				End If
			Next
		ElseIf intSetType = SV_MATRIX_LAYOUT_SCALE Then
			For intCounter = cint(intScaleStart) to cint(intScaleEnd)
				Call surveyCreation_addMatrixAnswer(intAnswerSetID, intCounter, False, 0, intCounter, intCounter)
			Next
		End If
	End If
	
	If not utility_isPositiveInteger(intNumberFields) and strError = "" Then
%>
		<body onload="javascript:closeAndSave();"></body>
<%	
	End If
End If

Select Case intSetType
	Case SV_MATRIX_LAYOUT_RADIO, SV_MATRIX_LAYOUT_ALPHASCALE 'new type
		strSetTypeText = "Radio Buttons"
	Case SV_MATRIX_LAYOUT_CHECKBOX
		strSetTypeText = "Checkboxes"
	Case SV_MATRIX_LAYOUT_DROPDOWN
		strSetTypeText = "Dropdown Menus"
	Case SV_MATRIX_LAYOUT_SINGLE
		strSetTypeText = "Single Line Inputs"
	Case SV_MATRIX_LAYOUT_SCALE
		strSetTypeText = "Radio Button Scale"
End Select

If not utility_isPositiveInteger(intNumberFields) Then
	intNumberFields = SV_NUMBER_ANSWERS
End If

	If not utility_isPositiveInteger(intAnswerSetID) Then
		boolRequired = False
		strAlias = ""
		intFieldLength = 20
	Else
		strSQL = "SELECT setText, scaleStart, scaleEnd, scaleStartText, scaleEndText, alias, isRequired, enforceUnique, fieldLength " &_
				 "FROM usd_matrixSets WHERE matrixSetID = " & intAnswerSetID
		Set rsResults = utility_getRecordset(strSQL)
		strSetText = rsResults("setText")
		intScaleStart = rsResults("scaleStart")
		intScaleEnd = rsResults("scaleEnd")		
		strScaleStartText = rsResults("scaleStartText")
		strScaleEndText = rsResults("scaleEndText")
		strAlias = rsResults("alias")
		boolRequired = cbool(rsResults("isRequired"))
		boolUnique = cbool(rsResults("enforceUnique"))
		intFieldLength = rsResults("fieldLength")
	
		rsResults.Close
		Set rsResults = NOTHING
	
	End If	
	
	If not utility_isPositiveInteger(intFieldLength) Then
		intFieldLength = 20
	End If
	
	If utility_isPositiveInteger(intSetType) Then
		intSetType = cint(intSetType)
	End If
%>
	<%=header_htmlTop("white","")%>
	<form method="post" name="frmSet"
		action="editMatrixSet.asp?itemID=<%=intItemID%>&surveyID=<%=intSurveyID%>&itemType=<%=intItemType%>&pageID=<%=intPageID%>&setType=<%=intSetType%>&categoryID=<%=intItemCategoryID%>">


	<table width="100%" bgcolor="<%=SV_TOP_COLOR%>"></tr><td>
		<span style="font-size: 24px; font-family: Arial; font-weight: bold; color: <%=SV_TITLE_COLOR%>"><%=strPageHeader%></span>
	</td></tr></table>
	<span class="message"><%=strError%></span>
	<table cellpadding="4" cellspacing="0" border="0" width="100%"><tr><td>
	<span class="normalBold">Set Type:&nbsp;</span><span class="normal"><%=strSetTypeText%></span>
	<hr noshade color="#C0C0C0" size="2">
		<table border="0" cellpadding="0" cellspacing="0" class="normal">
			<tr>
				<td width="100" class="normalBold">
					Set Text:
				</td>
				<td>
					Text
				</td>
				<td>
					<input type="text" name="setText" value="<%=strSetText%>">
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					Alias
				</td>
				<td>
					<input type="text" name="setAlias" value="<%=strAlias%>">
				</td>
			</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table border="0" cellpadding="0" cellspacing="0" class="normal">
		
			<tr>
				<td width="100" class="normalBold">Required?</td>
				<td>
					<input type="checkbox" name="isRequired"
<%
					If boolRequired = True Then
%>
						checked
<%
					End If
%>					
					>
				</td>
				<td>Answer is required</td>
			</tr>
		</table>
			<hr noshade color="#C0C0C0" size="2">
<%
		If intSetType <> SV_MATRIX_LAYOUT_CHECKBOX and intSetType <> SV_MATRIX_LAYOUT_SCALE Then				
%>
		<table border="0" cellpadding="0" cellspacing="0" class="normal">
		
			<tr>
				<td width="100" class="normalBold">
				Unique?</td>
				<td>
					<input type="checkbox" name="enforceUnique"
<%
					If boolUnique = True Then
%>
						checked
<%
					End If
%>					
					>
				</td>
				<td>Each Response In The Set Must Be Unique</td>
			</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
<%
	ElseIf intSetType = SV_MATRIX_LAYOUT_SCALE Then
%>
		<table border="0" cellpadding="0" cellspacing="0" class="normal">
		
			<tr>
				<td width="100" class="normalBold">
				Ranking?</td>
				<td>
					<input type="checkbox" name="enforceUnique"
<%
					If boolUnique = True Then
%>
						checked
<%
					End If
%>					
					>
				</td>
				<td>Checking this box ensures that each value in the scale to be selected only once.</td>
			</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
<%
	End If
	
	If intSetType = SV_MATRIX_LAYOUT_SINGLE Then
%>
		<table border="0" cellpadding="0" cellspacing="0" class="normal">
		
			<tr>
				<td width="100" class="normalBold">
				Field Length</td>
				<td>
					<input type="text" name="fieldLength" value="<%=intFieldLength%>" size="4">
				</td>
			</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
<%
	End If
%>
		
<%
	If intSetType <> SV_MATRIX_LAYOUT_SINGLE and intSetType <> SV_MATRIX_LAYOUT_SCALE Then	
%>
	
	<table border="0" cellpadding="0" cellspacing="0" class="normal">
	<tr><td width="100" class="normalBold" valign="top">Answers:</td><td valign="top">
	<table border="0" cellpadding="0" cellspacing="0" class="normal">
		<tr>
			<td>
				Answer
			</td>
			<td>
				Alias
			</td>
<%
	If boolScored Then
%>			
			<td>
				Points
			</td>
<%
	End If
%>
			<td>
				Default?
			</td>
		</tr>
<%
	strSQL = "SELECT answerText, alias, points, isDefault FROM usd_matrixAnswers WHERE matrixSetID = " & intAnswerSetID & " ORDER BY orderByID, matrixAnswerID"
	Set rsResults = utility_getRecordset(strSQL)
	intCounter = 0

	Do until rsResults.EOF and intCounter >= cint(intNumberFields)
		intCounter = intCounter + 1
		
		If intCounter > 1 Then 
			strArray = strArray & ","
			strAliasArray = strAliasArray & ","
			strDefaultArray = strDefaultArray & ","
			If boolScored = True Then
				strPointsArray = strPointsArray & ","
			End If
		End If
		
		strArray = strArray & "document.forms.frmSet.category" & intCounter 
		strAliasArray = strAliasArray & "document.forms.frmSet.alias" & intCounter
		strDefaultArray = strDefaultArray & "document.forms.frmSet.default" & intCounter
		
		If not rsResults.EOF Then
			strAnswer = rsResults("answerText")
			strAlias = rsResults("alias")
			intPoints = rsResults("points")
			boolDefault = cbool(rsResults("isDefault"))
	
			rsResults.MoveNext
		Else
			strAnswer = ""
			strAlias = ""
			intPoints = ""
			boolDefault = False
		End If
%>
		<tr><td><input type="text" name="category<%=intCounter%>" value="<%=strAnswer%>"></td>
			<td><input type="text" name="alias<%=intCounter%>" value="<%=strAlias%>">
<%
	If boolScored = True Then
		strPointsArray = strPointsArray & "document.forms.frmSet.points" & intCounter
%>
			<td><input type="text" name="points<%=intCounter%>" value="<%=intPoints%>" size="4"></td>
<%
	End If
%>
			<td>
<%
	If intSetType = SV_MATRIX_LAYOUT_CHECKBOX Then
%>			
			<input type="checkbox" name="default<%=intCounter%>" 
<%
			If boolDefault = True Then
%>
				checked
<%
			End If
%>
			>
<%
	ElseIf intSetType = SV_MATRIX_LAYOUT_CHECKBOX or intSetType = SV_MATRIX_LAYOUT_RADIO or intSetType = SV_MATRIX_LAYOUT_DROPDOWN  or intSetType = SV_MATRIX_LAYOUT_ALPHASCALE Then
%>
		<input type="checkbox" name="default<%=intCounter%>" onclick="javascript:if (document.forms.frmSet.default<%=intCounter%>.checked){oneChecked(defaultarray,<%=intCounter-1%>);}" 
<%
			If boolDefault = True Then
%>
				checked
<%
			End If
%>
			>
<%
	End If
%>
			</td><%=moveBoxes(intCounter, boolScored, intNumberFields)%>
		</tr>
<%
	Loop
	
	rsResults.Close
	Set rsResults = NOTHING
%>
	
	</table></td></tr>
	<tr><td>&nbsp;</td>
	<td><a class="normal" href="#" onclick="javascript:addFields(<%=cint(intCounter) + SV_NUMBER_ANSWERS%>);">Add <%=SV_NUMBER_ANSWERS%> Fields</a>
	</td></tr>
	</table>

	<hr noshade color="#C0C0C0" size="2">
	
<%
	End If

		If intSetType = SV_MATRIX_LAYOUT_SCALE Then
%>		
			<table cellpadding="0" cellspacing="0" border="0" class="normal">
				<tr>
					<td class="normalBold" width="100">
						Scale Options
					</td>
					<td>
						Start of Scale	
					</td>
					<td>
						<input type="text" size="4" name="scaleStart" value="<%=intScaleStart%>">
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td>
						End of Scale	
					</td>
					<td>
						<input type="text" size="4" name="scaleEnd" value="<%=intScaleEnd%>">
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					
					<td>
						Start Text	
					</td>
					<td>
						<input type="text" size="15" name="scaleStartText" value="<%=strScaleStartText%>">
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td>
						End Text	
					</td>
					<td>
						<input type="text" size="15" name="scaleEndText" value="<%=strScaleEndText%>">
					</td>
				</tr>
			</table>
			<hr noshade color="#C0C0C0" size="2">
<%
		End If
%>
		
		<table><tr><td width="100">&nbsp;</td><td>
			<input type="hidden" name="answerSetID" value="<%=intAnswerSetID%>">
			<input type="hidden" name="submitted" value="submit">
			<input type="hidden" name="numberAnswers" value="<%=intCounter%>">
			<input type="hidden" name="numberFields" value="">
			<input type="image" src="images/button-submit.gif" alt="Submit" border="0"
<%
			If intSetType = SV_MATRIX_LAYOUT_SCALE Then
%>
				onclick="return checkScaleFields();"
<%
			End If
%>>
		</td></tr></table>
	</td></tr></table>
	</form>
	
	<script language="javascript">

		function closeAndSave()
		{
			var url = 'editItem.asp?surveyID=<%=intSurveyID%>&itemID=<%=intItemID%>&itemType=12&pageID=<%=intPageID%>&categoryID=<%=intItemCategoryID%>';
			self.opener.location = url;
		    self.close();
		}
		function addFields(numFields)
		{
			frmSet.numberFields.value = numFields;
			document.frmSet.submit();
		}
		function checkScaleFields()
		{
			if (frmSet.scaleStart.value == '')
			{
				alert('Please enter an integer for the start of your scale')
				return false;
			}
			else if (frmSet.scaleEnd.value == '') 
			{
				alert('Please enter an integer for the end of your scale')
				return false;
			}
			else
			{
				return true;
			}
		}
	questionarray = new Array(<%=strArray%>);
	aliasarray = new Array(<%=strAliasArray%>);
	defaultarray = new Array(<%=strDefaultArray%>);
<%
	If boolScored = True Then
%>
	pointsarray = new Array(<%=strPointsArray%>);
<%
	End If
%>


	</script>
<%
Function moveBoxes(intCounter, boolScored, intNumberFields)
%>
	<td>
<%
	If intCounter < intNumberFields Then
%>					
					<img style="cursor:hand" src="images/button-down-mini.gif" hspace="2" border="0" alt="Move category Down" width="15" height="15" onclick="javascript:swTextBox(document.forms.frmSet.category<%=intCounter%>, document.forms.frmSet.category<%=intCounter +1%>);swTextBox(document.forms.frmSet.alias<%=intCounter%>, document.forms.frmSet.alias<%=intCounter +1%>);swCheckBox(document.forms.frmSet.default<%=intCounter%>, document.forms.frmSet.default<%=intCounter +1%>);
<%
					If boolScored = True Then
%>
						swTextBox(document.forms.frmSet.points<%=intCounter%>, document.forms.frmSet.points<%=intCounter +1%>);
<%
					End If
%>">
					
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
					<img style="cursor:hand" hspace="2" src="images/button-up-mini.gif" border="0" alt="Move category Up" width="15" height="15" onclick="javascript:swTextBox(document.forms.frmSet.category<%=intCounter%>, document.forms.frmSet.category<%=intCounter -1%>);swTextBox(document.forms.frmSet.alias<%=intCounter%>, document.forms.frmSet.alias<%=intCounter -1%>);swCheckBox(document.forms.frmSet.default<%=intCounter%>, document.forms.frmSet.default<%=intCounter -1%>);<%
					If boolScored = True Then
%>
						swTextBox(document.forms.frmSet.points<%=intCounter%>, document.forms.frmSet.points<%=intCounter -1%>);
<%
					End If
%>">
					
<%	
	Else
%>
		&nbsp;
<%
	End If
%>
	</td>
	<td valign="middle">
		<img style="cursor:hand" hspace="2" src="images/button-delete-mini.gif" border="0" alt="Delete category" width="15" height="15" onclick="javascript:if (confirm('Are you sure you want to delete this category?') == true) { deleteElement(questionarray,<%=intCounter%>);deleteElement(aliasarray,<%=intCounter%>);deleteCheckbox(defaultarray,<%=intCounter%>); 
<%
	If boolScored = True Then
%>
		deleteElement(pointsarray,<%=intCounter%>);
<%
	End If
%>		
		}"></td>
<%	
End Function
%>