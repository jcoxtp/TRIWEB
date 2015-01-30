<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1	
'****************************************************
'
' Name:		manageItemConditions.asp 
' Purpose:	page to manage conditions for a survey item
'
'
' Author:	    Ultimate Software Designs
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/response_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/surveyCreation_inc.asp"-->
<!--#INCLUDE FILE="Include/itemDisplay_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim intUserType
	Dim intUserID
	Dim strSQL
	Dim rsResults
	Dim strSurveyTitle
	Dim strDescription
	Dim intSurveyType 
	Dim intSurveyID
	Dim intDelete
	Dim intItemID
	Dim intQuestionID
	Dim intConditionType
	Dim strConditionValue
	Dim intPageID
	Dim intAnswerID
	Dim intConditionGroupID
	Dim strAction
	Dim intPresetConditionID
	Dim strPage
	Dim strError
	Dim boolShowEntireItem
	Dim boolConditionsAvailable

	Call user_loginNetworkUser()

	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	
	'get necessary values from page request
	intSurveyID = cint(Request.QueryString("surveyID"))
	intItemID = Request.QueryString("itemID")
	intPageID = cint(Request.QueryString("pageID"))
	
	'if for any reason a valid item was not specified
	If not  utility_isPositiveInteger(intItemID) Then
		'redirect to index page with error message
		Response.Redirect("index.asp?message=" & SV_MESSAGE_UNKNOWN_ERROR)
	End If
	
	'check user's credentials
	If ((survey_getOwnerID(intSurveyID) <> intUserID) _
			and intUserType = SV_USER_TYPE_CREATOR) _
			or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	'extend user cookie
	

	If not utility_isPositiveInteger(intPageID) Then
		Response.Redirect("editSurvey.asp?surveyID=" & intSurveyID)
	End If

	intDelete = Request.QueryString("delete")
	If utility_isPositiveInteger(intDelete) Then
		intConditionGroupID = Request.QueryString("groupID")
		'delete condition from this item (condition is still available to other items)
		Call surveyCreation_deleteCondition(intItemID, intDelete, intConditionGroupID)
	End If
	
	'get requested action from form
	strAction = Request.Form("submit")
	
	'if adding a new condition or adding a preset condition
	If strAction = "Add Condition" Then
		intConditionGroupID = Request.Form("conditionGroup")
		'if condition group not specified
		If not utility_isPositiveInteger(intConditionGroupID) Then
			'get next condition group for item
			intConditionGroupID = surveyCreation_getNextConditionGroupID(intItemID, "", "")
		End If
		
		'if adding new condition
		If Request.Form("preset") <> "true" Then
			'get form values
			intQuestionID = Request.Form("questionID")
			intConditionType = Request.Form("conditionType")
			If utility_isPositiveInteger(intConditionType) Then
				intConditionType = cint(intConditionType)
			Else
				intConditionType = 0
			End If
			
			intAnswerID = Request.Form("answer")
			'if user chose answer from dropdown
			If utility_isPositiveInteger(intAnswerID) Then
				'get the text value of the answer
				strConditionValue = response_getAnswerText(intAnswerID,"")
			Else 
				'get value from "other" field
				strConditionValue = Request.Form("conditionValue")
			End If
			
			'validate form values
			If strConditionValue = "" and intConditionType <> SV_CONDITION_DID_NOT_ANSWER _
										and intConditionType <> SV_CONDITION_ANSWERED Then
				strError = strError & "Please choose a condition value.<br />"
			End If
			If not utility_isPositiveInteger(intConditionType) Then
				strError = strError & "Please choose a condition type.<br />"
			End If
			If not utility_isPositiveInteger(intQuestionID) Then
				strError = strError & "Please choose a question.<br />"
			End If
			
			'if form is validated
			If strError = "" Then
				'add the condition
				Call surveyCreation_addCondition(intItemID, "","",intQuestionID, strConditionValue, _ 
							intConditionType, intConditionGroupID, intAnswerID) 
			End If
		'if user adding a condition that already exists for another item or group
		Else
			'get ID of existing condition
			intPresetConditionID = Request.Form("presetCondition")
			'add condition to specified group
			Call surveyCreation_addPresetCondition(intItemID, "","",intPresetConditionID, intConditionGroupID) 
		End If
		
		
	End If
	
	'toggle showing item details
	If Request.QueryString("showEntireItem") = "True" Then
		boolShowEntireItem = True
	Else
		boolShowEntireItem = False
	End If
	
	
	strPage = "manageItemConditions.asp?surveyID=" & intSurveyID & "&itemID=" &_
				intItemID & "&pageID=" & intPageID 
	
	'get information on this survey
	strSQL = "SELECT surveyType, surveyTitle, surveyDescription " &_
			 "FROM usd_Survey " &_
			 "WHERE surveyID = " & intSurveyID
	
	Set rsResults = utility_getRecordset(strSQL)
%>

<%
	If rsResults.EOF Then
%>
		Response.Redirect("index.asp?message=" & SV_MESSAGE_UNKNOWN_ERROR)
<%
	End If
		intSurveyType = rsResults("surveyType")
%> 
	<%=header_htmlTop("white","")%>
	<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
	<span class="breadcrumb" align="left">
	<a href="manageSurveys.asp">All Surveys</a> >>
	<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=rsResults("surveyTitle")%></a> >>
	<a href="editSurvey.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>">Edit Survey</a> >>
	Item Conditions
	</span><br /><br /><p>
		<a class="normalBold" href="editSurvey.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>">
			<img src="images/button-save.gif" alt="Save and Continue" border="0">
		</a>
	</p>
	<p class="surveyTitle">Conditions For:</p>
<%
	
	rsResults.Close
		
	strSQL = "SELECT itemText, itemType " &_
				 "FROM usd_SurveyItem " &_
				 "WHERE itemID = " & intItemID
				 
	rsResults.Open strSQL, DB_CONNECTION	
	
	If boolShowEntireItem = True Then
		'display entire question
		Select Case rsResults("itemType")
			Case SV_ITEM_TYPE_HEADER
				Call itemDisplay_displayHeader(intItemID)
			Case SV_ITEM_TYPE_MESSAGE
				Call itemDisplay_displayMessage(intItemID)
			Case SV_ITEM_TYPE_IMAGE
				Call itemDisplay_displayImage(intItemID)
			Case SV_ITEM_TYPE_LINE
				Call itemDisplay_displayLine()
			Case SV_ITEM_TYPE_HTML
				Call itemDisplay_displayHTML(intItemID)
			Case SV_ITEM_TYPE_TEXTAREA
				Call itemDisplay_displayTextArea(intItemID,0,False, 4, "", _
				2, "", "arial",0,False,"","")
			Case SV_ITEM_TYPE_SINGLE_LINE
				Call itemDisplay_displaySingleLine(intItemID,0,False, 4, "", _
				2, "", "arial",0,False,"","")
			Case SV_ITEM_TYPE_DATE
				Call itemDisplay_displayDate(intItemID,0,False, 4, "", _
				2, "", "arial",0,False,"","")
			Case SV_ITEM_TYPE_CHECKBOXES
				Call itemDisplay_displayCheckboxes(intItemID, "",0,False, 4, "", _
				2, "", 2, "", "arial",0,False,"","")
			Case SV_ITEM_TYPE_RADIO
				Call itemDisplay_displayRadio(intItemID,0,False, 4, "", _
				2, "", 2, "", "arial",0,False,"","")
			Case SV_ITEM_TYPE_DROPDOWN
				Call itemDisplay_displayDropdown(intItemID,0,False, 4, "", _
				2, "", "arial",0,False,"","")
			Case SV_ITEM_TYPE_MATRIX
				Call itemDisplay_displayMatrix(intItemID, "",0,False, 4, "", _
				2, "", 2, "", "arial",0,False,False,"gray","","",0,"")
		End Select
%>
				
				<a class="normalBold" href="<%=strPage%>&showEntireItem=False">
					<img src="images/button-hideItemDetails.gif" alt="Hide Item Details" border="0"></a><br />
<%
		Else
%>	
			<p class="itemTitle">
				<%=rsResults("itemText")%>
<%
				If rsResults("itemType") = SV_ITEM_TYPE_LINE Then
%>
					<%itemDisplay_displayLine()%>
<%
				End If
%>
				<br />
				<a  class="normalBold" href="<%=strPage%>&showEntireItem=True">
					<img src="images/button-showEntireItem.gif" alt="Show Entire Item" border="0"></a>
			</p>
<%
	End If
	rsResults.Close
	Set rsResults = NOTHING
	
	strPage = strPage & "&showEntireItem=" & cstr(boolShowEntireItem)
	'output form to add conditions, then show current conditions for item
%>
		<p class="message"><%=strError%></p>
	<table border="1"><tr><td><%=surveyCreation_showConditions(intItemID, intPageID, "", strPage)%></td></tr></table>
	<%=surveyCreation_conditionForm(intSurveyID, intItemID, intPageID, strPage, boolConditionsAvailable)%>
<%
	If boolConditionsAvailable = False Then
		Response.Redirect("editSurvey.asp?surveyID=" & intSurveyID & "&pageID=" &_
						 intPageID & "&message=" & SV_MESSAGE_CONDITIONS_UNAVAILABLE)
	End If
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

