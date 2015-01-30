<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		editItem.asp 
' Purpose:	page to edit a particular item
'
' Changes:
'****************************************************
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
	Dim intUserType
	Dim intUserID
	Dim intSurveyID
	Dim strSQL
	Dim rsResults
	Dim intItemTypeSelected
	Dim intItemType
	Dim strItemText
	Dim strDescription
	Dim intDataType
	Dim strMinimumValue
	Dim strMaximumValue
	Dim strDefaultValue
	Dim intCounter
	Dim strAnswerText
	Dim boolDefault
	Dim boolRequired
	Dim boolAllowOther
	Dim strOtherText
	Dim intPageID
	Dim intItemID
	Dim intNumberAnswers
	Dim intOrderByID
	Dim intPoints
	Dim intNumberAnswerInputs
	Dim strCurrentPage
	Dim intLayoutStyle
	Dim strUploadedImage
	Dim boolRandomize
	Dim boolNumberLabels
	Dim intPresetAnswerGroup
	Dim boolScored
	Dim strAlias
	Dim strQuestionAlias
	Dim strCategoryText
	Dim strCategoryAlias
	Dim intNumberCategories
	Dim intAnswerSetID
	Dim intAnswerSetType
	Dim intDeleteMatrixSet
	Dim intItemCategoryID
	Dim strLibraryName
	Dim intNumberRows
	Dim intNumberColumns
	Dim strAnswers
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = cint(Request.QueryString("surveyID"))
	intItemTypeSelected = Request("itemType")
	intItemID = cint(Request.QueryString("itemID"))
	intPageID = Request.QueryString("pageID")
	intItemCategoryID = Request.QueryString("categoryID")
	
	If utility_isPositiveInteger(intItemCategoryID) Then
		strLibraryName = survey_getLibraryName(intItemCategoryID)
	End If
	
	strCurrentPage = "editItem.asp?surveyID=" & intSurveyID & "&itemID=" &_
					 intItemID & "&itemType=" & intItemTypeSelected & "&pageID=" & intPageID &_
					 "&categoryID=" & intItemCategoryID
	
	
	If utility_isPositiveInteger(intSurveyID) = True and utility_isPositiveInteger(intItemCategoryID) = False Then
		If utility_isPositiveInteger(intUserID) Then
			If ((survey_getOwnerID(intSurveyID) <> intUserID) _
					and intUserType = SV_USER_TYPE_CREATOR) _
					or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
				Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
			End If
		Else
			Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
		End If
	End If
	

	If utility_isPositiveInteger(intItemTypeSelected) Then
		intItemTypeSelected = cint(intItemTypeSelected)
	Else
		intItemTypeSelected = 1
	End If
	
	intDeleteMatrixSet = Request.QueryString("deleteMatrixSet")
	If utility_isPositiveInteger(intDeleteMatrixSet) Then
		strSQL = "DELETE FROM usd_matrixSets WHERE matrixSetID = " & intDeleteMatrixSet
		Call utility_executeCommand(strSQL)
		
		strSQL = "DELETE FROM usd_matrixAnswers WHERE matrixSetID = " & intDeleteMatrixSet
		Call utility_executeCommand(strSQL)
	End If
	
	
	If Request.Form("submit") = "Submit" Then
		If intItemTypeSelected <> SV_ITEM_TYPE_MATRIX Then
		
			strItemText = Request.Form("itemText")
			strDescription = Request.Form("description")
			intDataType = Request.Form("dataType")
			If intItemTypeSelected <> SV_ITEM_TYPE_DATE Then
				strMinimumValue = Request.Form("minimumValue")
				strMaximumValue = Request.Form("maximumValue")
				strDefaultValue = Request.Form("defaultValue")
			Else
				strMinimumValue = Request.Form("minimumMonth") & "/" &_
								  Request.Form("minimumDay") & "/" &_
								  Request.Form("minimumYear") 
				If not(isDate(strMinimumValue)) Then
					strMinimumValue = "" 
				End If
				
				strMaximumValue = Request.Form("maximumMonth") & "/" &_
								  Request.Form("maximumDay") & "/" &_
								  Request.Form("maximumYear") 
				If not(isDate(strMaximumValue)) Then
					strMaximumValue = ""
				End If
				
				strDefaultValue = Request.Form("defaultMonth") & "/" &_
								  Request.Form("defaultDay") & "/" &_
								  Request.Form("defaultYear") 
				If not(isDate(strDefaultValue)) Then
					strDefaultValue = ""
				End If
			End If
		
		
			intNumberAnswers = cint(Request.Form("numberAnswers"))
			If Request.form("required") = "on" Then
				boolRequired = True
			Else 
				boolRequired = False
			End If
		
			If Request.Form("allowOther") = "on" Then
				boolAllowOther = True
				strOtherText = Request.Form("otherText")
			Else
				boolAllowOther = False
			End If
		
			If Request.Form("randomize") = "on" Then
				boolRandomize = True
			Else
				boolRandomize = False
			End If
	
			If Request.Form("numberLabels") = "on" Then
				boolNumberLabels = True
			Else
				boolNumberLabels = False
			End If
	
			intLayoutStyle = cint(Request.Form("layoutStyle"))
		
			strQuestionAlias = trim(Request.Form("questionAlias"))		
			
			intNumberRows = request.Form("numberRows")
			intNumberColumns = request.Form("numberColumns")
		
			If not utility_isPositiveInteger(intNumberRows) Then
				intNumberRows = 5
			End If
			
			If not utility_isPositiveInteger(intNumberColumns) Then
				intNumberColumns = 70
			End If
			Call surveyCreation_editItem(intSurveyID, intItemTypeSelected, strItemText, strDescription, _
								intDataType, strMinimumValue, strMaximumValue, _
								strDefaultValue, boolRequired, boolAllowOther, _
								strOtherText, intLayoutStyle, intItemID, boolRandomize, boolNumberLabels, strQuestionAlias,intNumberRows, intNumberColumns)
		
		
	
			intPresetAnswerGroup = Request.Form("presetAnswerGroup")
			If utility_isPositiveInteger(intPresetAnswerGroup) Then
				strSQL = "SELECT answerText, isDefault, points, alias " &_
						 "FROM usd_Answers " &_
						 "WHERE itemID = " & intPresetAnswerGroup &_
						 " ORDER by answerID"
				Set rsResults = utility_getRecordset(strSQL)
				If not rsResults.EOF Then
					intCounter = 0
					Do until rsResults.EOF
						intCounter = intCounter + 1
						strAnswerText = rsResults("answerText")
						Call surveyCreation_addAnswer(intItemID, strAnswerText, rsResults("isDefault"), rsResults("points"), rsResults("alias"), intCounter)
						rsResults.MoveNext
					Loop
				End If
				rsResults.Close
				Set rsResults = NOTHING
			ElseIf utility_isPositiveInteger(intNumberAnswers) Then
				intCounter = 1
				Do until intCounter > intNumberAnswers
					strAnswerText = trim(Request.Form("answer" & intCounter))
					
					If strAnswerText <> "" Then
						If Request.Form("defaultAnswer" & intCounter) = "on" Then
							boolDefault = True
						Else
							boolDefault = False
						End If
						
						intPoints = Request.Form("points" & intCounter)
						If intPoints = "" or Not isNumeric(intPoints) Then
							intPoints = 0
						End If
						strAlias = trim(Request.Form("alias" & intCounter))
				
						If intItemTypeSelected <> SV_ITEM_TYPE_MATRIX Then
							If intCounter > 1 Then
								strAnswers = strAnswers & ","
							End If
							strAnswers = strAnswers & utility_SQLEncode(strAnswerText,True)
							Call surveyCreation_addAnswer(intItemID, strAnswerText, boolDefault, intPoints, strAlias, intCounter)
						End If
					Else
						strSQL = "DELETE FROM usd_answers WHERE itemID = " & intItemID & " AND orderByID = " & intCounter
						Call utility_executeCommand(strSQL)
					End If
					intCounter = intCounter + 1
				Loop 
			End If
		
			If len(strAnswers) > 0 Then
				strSQL = "DELETE FROM usd_answers WHERE itemID = " & intItemID & " AND answerText NOT IN(" & strAnswers & ")"
				Call utility_executeCommand(strSQL)	
			End If
	
			
		
		End If	
		If utility_isPositiveInteger(intSurveyID) Then
			Response.Redirect("editSurvey.asp?surveyID=" & intSurveyID & "&message=" & SV_MESSAGE_ITEM_EDITED & "&pageID=" & intPageID)
		ElseIf utility_isPositiveInteger(intItemCategoryID) Then
			Response.Redirect("manageCategories.asp?categoryID=" & intItemCategoryID)
		End If

	End If

%>
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
	<span class="breadcrumb" align="left">
<%
	If utility_isPositiveInteger(intSurveyID) Then
%>
	<a href="manageSurveys.asp">All Surveys</a> >>
	<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=survey_getSurveyTitle(intSurveyID)%></a> >>
	<a href="editSurvey.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>">Edit Survey</a> >>
	Edit Item
<%
	Else
%>
	<a href="manageCategories.asp">All Libraries</a> >>
	<a href="manageCategories.asp?categoryID=<%=intItemCategoryID%>"><%=strLibraryName%></a> >>
	Edit Item
	
<%	
	End If
%>
	</span><br />
<%
	'get item types from database
	strSQL = "SELECT itemTypeID, itemTypeText " &_
			 "FROM usd_ItemTypes " &_
			 "ORDER by orderByID "
	
	Set rsResults = utility_getRecordset(strSQL)

	If rsResults.EOF Then
%>
		<p class="message">No Question/Item Types Found</p>
<%
	Else
		
%> 
		
		<br /><span class="surveyTitle">Edit Item</span><br />
		<hr noshade color="#C0C0C0" size="2">
		<form method="get" name="frmChooseType"
				action="<%=strCurrentPage%>">
		<table>
			<tr>
				<td class="normalBold-Big" width="200">Item Type</td> 
				<td>
					<select name="itemType" onchange="javascript:document.frmChooseType.submit();">
<%
							Do until rsResults.EOF
								intItemType = rsResults("itemTypeID")
%>
								<option value="<%=intItemType%>"
<%
								If intItemType = intItemTypeSelected Then
%>
									selected
<%
								End If
%>
					
								>
									<%=rsResults("itemTypeText")%>
								</option>
<%
				rsResults.MoveNext
				Loop
%>
						</select>
					</td>
				</tr>
			</table>
<%
		If utility_isPositiveInteger(intItemTypeSelected) Then
%>
			<hr noshade color="#C0C0C0" size="2">
			<table>
			<tr valign="top">
				<td class="normalBold-Big" width="200">
					Item Type Description
				</td>
				<td>
					<%=common_itemTypeDescription(intItemTypeSelected)%>
				</td>
			</tr>
			</table>

<%
		End If
%>
		<br />
			<input type="hidden" name="pageID" value="<%=intPageID%>">
			<input type="hidden" name="surveyID" value="<%=intSurveyID%>">
			<input type="hidden" name="itemID" value="<%=intItemID%>">
		</form>
<%
	End If
	rsResults.Close
	Set rsResults = NOTHING

	If not utility_isPositiveInteger(intItemTypeSelected) Then
%>
		<%=common_allTypeDescriptions()%>
<%
	Else

	If intItemTypeSelected = SV_ITEM_TYPE_CHECKBOXES or _
		   intItemTypeSelected = SV_ITEM_TYPE_RADIO or _
		   intItemTypeSelected = SV_ITEM_TYPE_DROPDOWN Then 
		
			intNumberAnswerInputs = Request.QueryString("numberAnswerInputs")
			If not utility_isPositiveInteger(intNumberAnswerInputs)  Then
				intNumberAnswerInputs = SV_NUMBER_ANSWERS
			Else
				intNumberAnswerInputs = cint(intNumberAnswerInputs)
			End If
%>
			<hr noshade color="#C0C0C0" size="2">
			<form method="get" action="<%=strCurrentPage%>">
				<table>		
					<tr>
						<td class="normalBold-Big" width="200">
							Form Options
						</td>
						<td class="normalBold">
							<%=common_helpLink("surveys/items/numberAnswerInputs.asp",SV_SMALL_HELP_IMAGE)%>Number answer inputs:
						</td>
						<td>
							<input type="text" name="numberAnswerInputs" value="<%=intNumberAnswerInputs%>" size="3">
							<input type="image" src="images/button-change.gif" alt="Change" border="0">
							<input type="hidden" name="submit" value="Change">
						</td>
					</tr>
				</table>
				<input type="hidden" name="pageID" value="<%=intPageID%>">
				<input type="hidden" name="surveyID" value="<%=intSurveyID%>">
				<input type="hidden" name="itemID" value="<%=intItemID%>">
				<input type="hidden" name="itemType" value="<%=intItemTypeSelected%>">
			</form>
<%
		End If
%>
		<hr noshade color="#C0C0C0" size="2">
<%
			If (intPageID > 1 or survey_hasHiddenFields(intSurveyID)) and _
				intItemTypeSelected <> SV_ITEM_TYPE_LINE and intItemTypeSelected <> SV_ITEM_TYPE_IMAGE and utility_isPositiveInteger(intSurveyID) Then
%>				<table>
				<tr><td class="normalBold-Big" width="200">
				Piping</td>
				<td class="normalBold">
				<a href="javascript:popup('piping.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>&itemID=<%=intItemID%>','Piping','0','0','0','0','0','0','700','700','150','150')">Set Piping</a>
				</td></td></tr></table>
				<hr noshade color="#C0C0C0" size="2">

<%
			End If
%>				
		<form method="post" action="<%=strCurrentPage%>" name="frmItem">
<%
			boolScored = survey_isScored(intSurveyID)
			
			Select Case cint(intItemTypeSelected)
				Case SV_ITEM_TYPE_HEADER
					Call editItems_editHeader(intItemID)
				Case SV_ITEM_TYPE_MESSAGE
					Call editItems_editMessage(intItemID)
				Case SV_ITEM_TYPE_IMAGE
					strUploadedImage = Request.QueryString("fileUploaded")
					Call editItems_editImage(intItemID, strCurrentPage,strUploadedImage, intSurveyID)
				Case SV_ITEM_TYPE_LINE
					Call editItems_editLine()
				Case SV_ITEM_TYPE_HTML
					Call editItems_editHTML(intItemID)
				Case SV_ITEM_TYPE_TEXTAREA
					Call editItems_editTextArea(intItemID)
				Case SV_ITEM_TYPE_SINGLE_LINE
					Call editItems_editSingleLine(intItemID)
				Case SV_ITEM_TYPE_DATE
					Call editItems_editDate(intItemID)
				Case SV_ITEM_TYPE_CHECKBOXES
					Call editItems_editCheckboxes(intNumberAnswerInputs, intItemID, boolScored)
				Case SV_ITEM_TYPE_RADIO
					Call editItems_editRadio(intNumberAnswerInputs, intItemID, boolScored)
				Case SV_ITEM_TYPE_DROPDOWN
					Call editItems_editDropdown(intNumberAnswerInputs, intItemID, boolScored)
				Case SV_ITEM_TYPE_MATRIX
					Call editItems_editMatrix(intNumberAnswerInputs, intItemID, boolScored, intItemCategoryID)
			End Select
%>
			<hr noshade color="#C0C0C0" size="2">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td width="200">
						&nbsp;
					</td>
					<td>
						<input type="hidden" name="submit" value="Submit">
						<input type="image" src="images/button-submitChanges.gif" alt="Submit Changes" border="0" onclick="return confirmAction('Are you sure you want to edit this item?');">
					</td>
				</tr>
			</table>
		</form>
<%
	End If
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

