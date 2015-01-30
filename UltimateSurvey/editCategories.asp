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
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = cint(Request.QueryString("surveyID"))
	intItemTypeSelected = Request("itemType")
	intItemID = cint(Request.QueryString("itemID"))
	intPageID = Request.QueryString("pageID")
	
	strCurrentPage = "editItem.asp?surveyID=" & intSurveyID & "&itemID=" &_
					 intItemID & "&itemType=" & intItemTypeSelected & "&pageID=" & intPageID
	
	If ((survey_getOwnerID(intSurveyID) <> intUserID) _
			and intUserType = SV_USER_TYPE_CREATOR) _
			or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	

	If utility_isPositiveInteger(intItemTypeSelected) Then
		intItemTypeSelected = cint(intItemTypeSelected)
	Else
		intItemTypeSelected = 1
	End If
	
	If Request.Form("submit") = "Submit" Then
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
		
		Call surveyCreation_editItem(intSurveyID, intItemTypeSelected, strItemText, strDescription, _
							intDataType, strMinimumValue, strMaximumValue, _
							strDefaultValue, boolRequired, boolAllowOther, _
							strOtherText, intLayoutStyle, intItemID, boolRandomize, boolNumberLabels, strQuestionAlias)
		
		
		If intItemTypeSelected = SV_ITEM_TYPE_MATRIX Then
			intAnswerSetID = Request.Form("answerSetID")
			intAnswerSetType = Request.Form("layoutStyle")
				
			If not utility_isPositiveInteger(intAnswerSetID) Then
				intAnswerSetID = surveyCreation_addAnswerSet(intItemID, intAnswerSetType, boolRequired)
			End If
		End If
		
		
		intPresetAnswerGroup = Request.Form("presetAnswerGroup")
		If utility_isPositiveInteger(intPresetAnswerGroup) Then
			strSQL = "SELECT answerText, isDefault, points, alias " &_
					 "FROM usd_Answers " &_
					 "WHERE itemID = " & intPresetAnswerGroup &_
					 " ORDER by answerID"
			Set rsResults = utility_getRecordset(strSQL)
			If not rsResults.EOF Then
				Do until rsResults.EOF
					strAnswerText = rsResults("answerText")
					Call surveyCreation_addAnswer(intItemID, strAnswerText, rsResults("isDefault"), rsResults("points"), rsResults("alias"))
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
					If intItemTypeSelected = SV_ITEM_TYPE_CHECKBOXES or intItemTypeSelected = SV_ITEM_TYPE_MATRIX Then
						If Request.Form("checked" & intCounter) = "on" Then
							boolDefault = True
						Else
							boolDefault = False
						End If
					Else
						If cint(Request.Form("default")) = intCounter Then
							boolDefault = True
						Else
							boolDefault = False
						End If
					End If
				
					intPoints = Request.Form("points" & intCounter)
					If intPoints = "" or Not Utility_isPositiveInteger(intPoints) Then
						intPoints = 0
					End If
					strAlias = trim(Request.Form("alias" & intCounter))
			
					If intItemTypeSelected = SV_ITEM_TYPE_MATRIX Then
						Call surveyCreation_addMatrixAnswer(intAnswerSetID, strAnswerText, boolDefault, intPoints, strAlias)
					Else
						Call surveyCreation_addAnswer(intItemID, strAnswerText, boolDefault, intPoints, strAlias)
					End If
				End If
				intCounter = intCounter + 1
			Loop 
		End If
		
		intNumberCategories = Request.Form("numberCategories")
		If utility_isPositiveInteger(intNumberCategories) Then
			For intCounter = 1 to cint(intNumberCategories)
				strCategoryText = trim(Request.Form("categoryText" & intCounter))
				strCategoryAlias = trim(Request.Form("categoryAlias" & intCounter))
				If len(strCategoryText) > 0 Then
					Call surveyCreation_addMatrixCategory(intItemID, strCategoryText, strCategoryAlias)
				End If
			Next
		End If
		
		Response.Redirect("editSurvey.asp?surveyID=" & intSurveyID & "&message=" & SV_MESSAGE_ITEM_EDITED & "&pageID=" & intPageID)

	End If

%>
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
	<span class="normalBold" align="left">
	Current Survey:&nbsp;&nbsp;<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=survey_getSurveyTitle(intSurveyID)%></a></span>
	<br />
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
		<a href="javascript:history.go(-1);"><img src="images/button-goBack.gif" border="0"></a>
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
		<form method="post" action="<%=strCurrentPage%>">
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
					Call editItems_editMatrix(intNumberAnswerInputs, intItemID, boolScored)
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
						<input type="image" src="images/button-submitChanges.gif" alt="Submit Changes" border="0" onclick="return confirmAction('Are you sure you want to edit these categories?');">
					</td>
				</tr>
			</table>
		</form>
<%
	End If
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

