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
	
	Call user_loginNetworkUser()
	
	'Get the user info
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
				
					strAlias = trim(Request.Form("alias" & intCounter))
			
					Call surveyCreation_addAnswer(intItemID, strAnswerText, boolDefault, intPoints, strAlias)
				End If
				intCounter = intCounter + 1
			Loop 
		End If
		
		
		Response.Redirect("editSurvey.asp?surveyID=" & intSurveyID & "&message=" & SV_MESSAGE_ITEM_EDITED & "&pageID=" & intPageID)

	End If

%>
<%=header_htmlTop("white","")%>
	<span class="normalBold" align="left">
	Current Survey:&nbsp;&nbsp;<%=survey_getSurveyTitle(intSurveyID)%></span>
	<br />

<!--#INCLUDE FILE="Include/footer_inc.asp"-->

