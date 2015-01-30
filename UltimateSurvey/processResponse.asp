<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		processResponse.asp
' Purpose:	page to record responses to a survey
'
'
' Date Written:	6/24/2002
' Modified:		
'
' Changes:
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/response_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<%
	Dim intUserType
	Dim intUserID
	Dim strSQL
	Dim rsResults
	Dim strSurveyTitle
	Dim strDescription
	Dim intSurveyType 
	Dim strError
	Dim intSurveyID
	Dim boolIsActive
	Dim strGUID
	Dim intPageNumber
	Dim intItemID
	Dim strResponse
	Dim intDataType
	Dim strMinimumValue
	Dim strMaximumValue
	Dim strItemText
	Dim intItemType
	Dim strOtherText
	Dim intResponseID
	Dim boolAddResponse
	Dim intCounter
	Dim intNumberChecked
	Dim boolOtherAdded
	Dim intNextPageID
	Dim intNumberCategories
	Dim intCategoryCounter
	Dim intMatrix
	Dim intCategoryID
	Dim intLastQuestionNumber
	Dim intLayoutStyle
	Dim intEditResponseID
	Dim boolIsOther
	Dim intMatrixSetType
	Dim intMatrixSetID
	Dim intAnswerID
	Dim boolAllowOther
	
	Call user_loginNetworkUser()
	
	'Get the user info out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",False)

	intSurveyID = cint(Request.QueryString("surveyID"))
	intPageNumber = Request.Form("pageNumber")
	intLastQuestionNumber = Request.Form("lastQuestionNumber")

	intEditResponseID = Request.QueryString("editResponseID")
	
	
	
	If SV_SECURITY_TYPE = SV_SECURITY_TYPE_COOKIES Then
		strGUID = Request.Cookies(SV_COOKIE_NAME & "survey" & intSurveyID)("userID" & intUserID & "responseGUID")
	ElseIf SV_SECURITY_TYPE = SV_SECURITY_TYPE_SESSION Then
		strGUID = Session("survey" & intSurveyID & "responseGUID")
	End If		
	
	
	intResponseID = response_getResponseInProgressID(strGUID, intUserID, intSurveyID)
		
	If not utility_isPositiveInteger(intResponseID) Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If
	
		strSQL = "DELETE FROM usd_responseDetails " &_
			 "WHERE responseID = " & intResponseID &_
			 " AND itemID IN (SELECT itemID FROM usd_surveyItem " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " AND itemType " &_
			 "In(" & SV_ITEM_TYPE_TEXTAREA & "," &_
					SV_ITEM_TYPE_SINGLE_LINE & "," &_
					SV_ITEM_TYPE_DATE & "," &_
					SV_ITEM_TYPE_CHECKBOXES & "," &_
					SV_ITEM_TYPE_RADIO & "," &_
					SV_ITEM_TYPE_DROPDOWN & "," &_
					SV_ITEM_TYPE_MATRIX & ")" &_
			 " AND pageID = " & intPageNumber & ")"
	Call utility_executeCommand(strSQL)
	
	'Validate all values
	strSQL = "SELECT SI.itemID, itemType, itemText, minimumValue, maximumValue, dataType, MS.matrixSetType, MS.matrixSetID " &_
			 "FROM usd_SurveyItem SI " &_
			 "LEFT OUTER JOIN usd_matrixSets MS " &_
			 "ON MS.itemID = SI.itemID " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " AND itemType " &_
			 "In(" & SV_ITEM_TYPE_TEXTAREA & "," &_
					SV_ITEM_TYPE_SINGLE_LINE & "," &_
					SV_ITEM_TYPE_DATE & "," &_
					SV_ITEM_TYPE_CHECKBOXES & "," &_
					SV_ITEM_TYPE_RADIO & "," &_
					SV_ITEM_TYPE_DROPDOWN & "," &_
					SV_ITEM_TYPE_MATRIX & ")" &_
			 " AND pageID = " & intPageNumber &_
			 " ORDER BY pageID, SI.orderByID "
			 
	Set rsResults = utility_getRecordset(strSQL)
	
	Do until rsResults.EOF
		boolOtherAdded = False
		intItemID = rsResults("itemID")
		If Request.Form("itemShown" & intItemID) <> "" Then
		intItemType = rsResults("itemType")
		strItemText = rsResults("itemText")
		strMinimumValue = rsResults("minimumValue")
		strMaximumValue = rsResults("maximumValue")
		intDataType = rsResults("dataType")
			
		boolAddResponse = True
		
		If intItemType = SV_ITEM_TYPE_DATE Then
			strResponse = Request.Form("item" & intItemID & "month") & "/" &_
						  Request.Form("item" & intItemID & "day") & "/" &_
						  Request.Form("item" & intItemID & "year")
			If strResponse = "//" Then 
				strResponse = ""
			End If
		Else
			strResponse = Request.Form("item" & intItemID)
		End If
		
		If intItemType = SV_ITEM_TYPE_CHECKBOXES Then
			intCounter = 0
			intNumberChecked = 0
			Do until intCounter > cint(Request.Form("numberCheckboxes" & intItemID))
				If Request.Form("item" & intItemID & "_check" & intCounter) = "on" Then
					intNumberChecked = intNumberChecked + 1
				End If
				intCounter = intCounter + 1
			Loop
			If Request.Form("item" & intItemID & "_other") = "on" Then
				intNumberChecked = intNumberChecked + 1
			End If
			
			If utility_isPositiveInteger(strMaximumValue) Then
				If intNumberChecked > cint(strMaximumValue) Then 
					boolAddResponse = False
					strError =  "You can only choose " & strMaximumValue & " answers to " &_
								strItemText & "."
				End If
			End If
			If utility_isPositiveInteger(strMinimumValue) Then
				If intNumberChecked < cint(strMinimumValue) Then 
					boolAddResponse = False
					strError =  "You must choose " & strMinimumValue & " answers to " &_
								strItemText & "."
				End If
			End If
		End If
		
		If utility_isPositiveInteger(intDataType) and strResponse <> "" Then
			Select Case intDataType
				Case SV_DATA_TYPE_NUMBER
					If not isNumeric(strResponse) Then
						boolAddResponse = False
						strError =  "Response to " & strItemText & " must be a number."
					End If
				Case SV_DATA_TYPE_INTEGER
					If not isNumeric(strResponse) or not instr(1,strResponse,".") = 0 Then
						boolAddResponse = False
						strError =  "Response to " & strItemText & " must be an integer."
					End If
				Case SV_DATA_TYPE_DECIMAL
					If not isNumeric(strResponse) or instr(1,strResponse,".") = 0 Then
						boolAddResponse = False
						strError =  "Response to " & strItemText & " must be a decimal."
					End If
				Case SV_DATA_TYPE_MONEY 
					If not utility_isMoney(strResponse) Then
						boolAddResponse = False
						strError =  "Response to " & strItemText & " must be in money format."
					End If
				Case SV_DATA_TYPE_DATE
					If not isDate(strResponse) Then
						boolAddResponse = False
						strError =  "Response to " & strItemText & " must be a valid date."
					End If
				Case SV_DATA_TYPE_EMAIL
					If utility_isValidEmail(strResponse) = False Then
						boolAddResponse = False
						strError =  "Response to " & strItemText & " must be a valid email address."
					End If
			End Select
		
			
			If strMinimumValue <> "" Then
				If intDataType = SV_DATA_TYPE_DATE Then
					If not isDate(strResponse) Then
						boolAddResponse = False
						strError =  "Response to " & strItemText &_
								" is invalid."	
					ElseIf cdate(strResponse) < cdate(strMinimumValue) Then
						boolAddResponse = False
						strError =  "Response to " & strItemText &_
								" must be at least " & strMinimumValue & "."	
					End If
				Else
					If isNumeric(strResponse) and isNumeric(strMinimumValue) Then
						If cdbl(strResponse) < cdbl(strMinimumValue) Then
							boolAddResponse = False
							strError =  "Response to " & strItemText &_
									" must be at least " & strMinimumValue & "."		
						End If
					Else
						boolAddResponse = False
						strError =  "Response to " & strItemText &_
									" must be numeric and greater than or equal to " & strMinimumValue & "."
					End If
				End If
			End If
		
			If strMaximumValue <> "" Then
				If intDataType = SV_DATA_TYPE_DATE Then
					If not isDate(strResponse) Then
						boolAddResponse = False
						strError =  "Response to " & strItemText &_
								" is invalid."	
					ElseIf cdate(strResponse) > cdate(strMaximumValue) Then
						boolAddResponse = False
						strError =  "Response to " & strItemText &_
								" must be at most " & strMaximumValue & "."	
					End If
				Else
					If isNumeric(strResponse) and isNumeric(strMaximumValue) Then
						If cdbl(strResponse) > cdbl(strMaximumValue) Then
							boolAddResponse = False
							strError =  "Response to " & strItemText &_
									 " must be no greater than " & strMaximumValue & "."		
						End If
					Else
						boolAddResponse = False
						strError =  "Response to " & strItemText &_
									" must be numeric and less than or equal to " & strMaximumValue & "."
					End If
				End If
			End If
			
		End If
	
		If boolAddResponse = True Then
			Call response_deleteResponseItem(intResponseID, intItemID, "",0)
		End If
	
		If intItemType = SV_ITEM_TYPE_CHECKBOXES and boolAddResponse = True Then
			intCounter = 1
			Do until intCounter > cint(Request.Form("numberCheckboxes" & intItemID))
				If Request.Form("item" & intItemID & "_check" & intCounter) = "on" Then
					intAnswerID = Request.Form("item" & intItemID & "_value" & intCounter)
					strResponse = ""
					Call response_addResponse(intResponseID, intItemID, strResponse, False, False, "",0,0, intAnswerID)
				Else
					Call response_addResponse(intResponseID, intItemID, "", False, False, "",0,0,0)
				End If
				intCounter = intCounter + 1
			Loop
		
			If Request.Form("item" & intItemID & "_other") = "on" and boolOtherAdded = False Then
				strResponse = Request.Form("item" & intItemID & "_otherText")
				Call response_addResponse(intResponseID, intItemID, strResponse, False, True, "",0,0,0)
				boolOtherAdded = True
			ElseIf Request.Form("otherAllowed" & intItemID) = "true" Then
				Call response_addResponse(intResponseID, intItemID, "", False, True, "",0,0,0)
			End If
		
		ElseIf intItemType = SV_ITEM_TYPE_MATRIX Then
			'intLayoutStyle = rsResults("layoutStyle")
			intMatrixSetType = rsResults("matrixSetType")
			intMatrixSetID = rsResults("matrixSetID")
			
			intNumberCategories = Request.Form("numberCategories" & intItemID)
			
			If utility_isPositiveInteger(intNumberCategories) Then
			
				For intCategoryCounter = 1 to cint(intNumberCategories)
					intCategoryID = Request.Form("categoryID" & intCategoryCounter & "itemID" & intItemID)
					
					If intMatrixSetType <> SV_MATRIX_LAYOUT_CHECKBOX Then
						If intMatrixSetType <> SV_MATRIX_LAYOUT_SINGLE Then
							intMatrix = Request.Form("item" & intItemID & "category" & intCategoryID & "setID" & intMatrixSetID)
							If utility_isPositiveInteger(intMatrix) Then
								strResponse = ""		
			
								Call response_addResponse(intResponseID, intItemID, strResponse, False, False, intCategoryID,intMatrixSetID, intMatrixSetType, intMatrix)
							Else
								Call response_addResponse(intResponseID, intItemID, "", False, False, intCategoryID,intMatrixSetID, intMatrixSetType,0)
							End If
						Else
							strResponse = Request.Form("item" & intItemID & "category" & intCategoryID & "setID" & intMatrixSetID)
							If len(trim(strResponse)) > 0 Then
								Call response_addResponse(intResponseID, intItemID, strResponse, False, False, intCategoryID, intMatrixSetID, intMatrixSetType, 0)
							Else
								Call response_addResponse(intResponseID, intItemID, "", False, False, intCategoryID, intMatrixSetID, intMatrixSetType, 0)
							End If
						End If
					Else
						For intCounter = 1 to cint(Request.Form("numberAnswers" & intItemID & "setID" & intMatrixSetID))
											
							
							If Request.Form("item" & intItemID & "category" & intCategoryID & "counter" & intCounter & "setID" & intMatrixSetID) = "on" Then
								intMatrix = Request.Form("item" & intItemID & "category" & intCategoryID & "counter" & intCounter & "value" & "setID" & intMatrixSetID)
								
								If utility_isPositiveInteger(intMatrix) Then
									strResponse = ""		
									Call response_addResponse(intResponseID, intItemID, strResponse, False, False, intCategoryID, intMatrixSetID, intMatrixSetType, intMatrix)
								End If
							Else
								Call response_addResponse(intResponseID, intItemID, "", False, False, intCategoryID, intMatrixSetID, intMatrixSetType, 0)
							End If
						Next
					End If
			
			
				Next
			End If	
		ElseIf boolAddResponse = True Then
			intAnswerID = Request.Form("item" & intItemID)
			If not utility_isPositiveInteger(intAnswerID) Then
				intAnswerID = 0
			End If
			
			If strResponse = "" Then
				strResponse = Request.Form("item" & intItemID & "_otherText")
				boolIsOther = True
			End If
			If intItemType = SV_ITEM_TYPE_RADIO or intItemType = SV_ITEM_TYPE_DROPDOWN Then
				If strResponse <> "" Then
					If strResponse = 0 Then
						strResponse = Request.Form("item" & intItemID & "_otherText")
						boolISOther = True
					Else
						strResponse = ""
						boolIsOther = False
					End If
				End If
			Else
				boolIsOther = False
			End If
			If intItemType = SV_ITEM_TYPE_SINGLE_LINE or intItemType = SV_ITEM_TYPE_DATE or intItemType = SV_ITEM_TYPE_TEXTAREA Then
				intAnswerID = 0
			End If
			Call response_addResponse(intResponseID, intItemID, strResponse, True, boolIsOther, "",0,0,intAnswerID)
		End If
		End If
		rsResults.MoveNext
	Loop
	

	If strError = "" Then
		Call  response_updateLastPageAnswered(intResponseID, intPageNumber)
		
		If Request.Form("completeSurvey") = "true" Then
			If utility_isPositiveInteger(intEditResponseID) Then
				Response.Redirect("surveyComplete.asp?surveyID=" & intSurveyID & "&editResponseID=" & intEditResponseID)
			Else
				Response.Redirect("surveyComplete.asp?surveyID=" & intSurveyID)
			End If
		Else
			If Request.Form("moveToPageDirection") = "prev" Then
				intNextPageID = response_getPreviousPage(intPageNumber, intResponseID)
			Else
				intNextPageID = response_getNextPage(intPageNumber, intResponseID)
			End If
			If utility_isPositiveInteger(intEditResponseID) Then
				Response.Redirect("takeSurvey.asp?surveyID=" & intSurveyID & "&pageNumber=" & intNextPageID &_
									"&lastQuestionNumber=" & intLastQuestionNumber & "&editResponseID=" & intEditResponseID)
			Else
				Response.Redirect("takeSurvey.asp?surveyID=" & intSurveyID & "&pageNumber=" & intNextPageID &_
								"&lastQuestionNumber=" & intLastQuestionNumber)
			End If
		End If
	End If
%>

<body onload="javascript:showError('<%=strError%>');">
		
</body>
<script language="javascript">
	function showError(strError)
	{
		alert(strError);
		history.go(-1);
	}
</script>


