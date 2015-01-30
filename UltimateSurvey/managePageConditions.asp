<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1	
'****************************************************
'
' Name:		managePageConditions.asp
' Purpose:	page to manage conditions for an entire page of items
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
	Dim intQuestionID
	Dim intConditionType
	Dim strConditionValue
	Dim intPageID
	Dim intAnswerID
	Dim intConditionGroupID
	Dim strAction
	Dim intPresetConditionID
	Dim strPage
	Dim boolConditionsAvailable
	Dim strError

	Call user_loginNetworkUser()

	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = cint(Request.QueryString("surveyID"))
	intPageID = cint(Request.QueryString("pageID"))
	
	If ((survey_getOwnerID(intSurveyID) <> intUserID) _
			and intUserType = SV_USER_TYPE_CREATOR) _
			or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	

	If utility_isPositiveInteger(intPageID) = False Then
		Response.Redirect("editSurvey.asp?surveyID=" & intSurveyID)
	End If

	intDelete = Request.QueryString("delete")
	If utility_isPositiveInteger(intDelete) Then
		intConditionGroupID = Request.QueryString("groupID")
		Call survey_deletePageCondition(intSurveyID, intPageID, intDelete, intConditionGroupID)
	End If
	
	
	strAction = Request.Form("submit")
	
	If strAction = "Add Condition" Then
		intQuestionID = Request.Form("questionID")
		intConditionType = Request.Form("conditionType")
		
		If utility_isPositiveInteger(intConditionType) Then
			intConditionType = cint(intConditionType)
		End If
		
		intAnswerID = Request.Form("answer")
		intConditionGroupID = Request.Form("conditionGroup")
		If utility_isPositiveInteger(intAnswerID) Then
			strConditionValue = response_getAnswerText(intAnswerID,"")
		Else 
			strConditionValue = Request.Form("conditionValue")
		End If
	
		If not utility_isPositiveInteger(intConditionGroupID) Then
			intConditionGroupID = surveyCreation_getNextConditionGroupID("",intSurveyID, intPageID)
		End If
	
		If Request.Form("preset") <> "true" Then
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
		End If
		
		If utility_isPositiveInteger(intPageID) and strError = "" Then
			If Request.Form("preset") <> "true" Then
				Call surveyCreation_addCondition("", intSurveyID, intPageID, intQuestionID, strConditionValue, _ 
							intConditionType, intConditionGroupID, intAnswerID) 
			Else
				intPresetConditionID = Request.Form("presetCondition")
				Call surveyCreation_addPresetCondition("", intSurveyID, intPageID, intPresetConditionID, intConditionGroupID) 
			End If
		End If
	
	End If
	
	strSQL = "SELECT surveyType, surveyTitle, surveyDescription, isActive " &_
			 "FROM usd_Survey " &_
			 "WHERE surveyID = " & intSurveyID
	
	Set rsResults = utility_getRecordset(strSQL)
%>
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
<%
	If rsResults.EOF Then
%>
		<p class="message">No Survey Found</p>
<%
	Else
		intSurveyType = rsResults("surveyType")
%> 

	<span class="breadcrumb" align="left">
	<a href="manageSurveys.asp">All Surveys</a> >>
	<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=rsResults("surveyTitle")%></a> >>
	<a href="editSurvey.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>">Edit Survey</a> >>
	Page Conditions
	</span><br /><br />
		<a class="normalBold" href="editSurvey.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>">
			<img src="images/button-save.gif" alt="Save and Continue" border="0">
		</a>
	</p>
	<p class="surveyTitle">Conditions For Page <%=intPageID%></p>

	<p class="message"><%=strError%></p>
<%
	End If
	
	strPage = "managePageConditions.asp?surveyID=" & intSurveyID & "&pageID=" & intPageID
%>
	<table border="1"><tr><td><%=surveyCreation_showConditions("", intPageID, intSurveyID, strPage)%></td></tr></table>
	<%=surveyCreation_conditionForm(intSurveyID, "", intPageID, strPage, boolConditionsAvailable)%>

<%
	If boolConditionsAvailable = False Then
		Response.Redirect("editSurvey.asp?surveyID=" & intSurveyID & "&pageID=" &_
						 intPageID & "&message=" & SV_MESSAGE_CONDITIONS_UNAVAILABLE)
	End If
%>
	<!--#INCLUDE FILE="Include/footer_inc.asp"-->

