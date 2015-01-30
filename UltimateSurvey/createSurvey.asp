<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		createSurvey.asp
' Purpose:	page to begin to create a new survey
'
'
' Author:	    Ultimate Software Designs
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
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/surveyCreation_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim intUserType
	Dim strAction
	Dim strSurveyTitle
	Dim strDescription
	Dim intSurveyType 
	Dim dtmStartMonth
	Dim dtmStartDay
	Dim dtmStartYear
	Dim dtmStartDate
	Dim dtmEndMonth
	Dim dtmEndDay
	Dim dtmEndYear
	Dim dtmEndDate
	Dim intMaxResponses
	Dim intResponsesPerUser
	Dim strError
	Dim intSurveyIDOut
	Dim intUserID
	Dim dtmFirstYear
	Dim strCompletionMessage
	Dim strCompletionRedirect
	Dim intPrivacyLevelID
	Dim boolAllowContinue
	Dim strResultsEmail
	Dim boolScored
	Dim boolShowProgress
	Dim boolLogNTUser
	Dim boolEmailUser
	Dim boolNumberLabels
	Dim intTemplateID
	Dim boolEditable
	Dim boolUserInfoAvailable

	Call user_loginNetworkUser()

		'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
			
	If intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	strAction = Request.Form("submit")

	strCompletionMessage = SV_DEFAULT_COMPLETION_MESSAGE

	strResultsEmail = user_getUserEmail(intUserID)

	'If form submitted
	If strAction = "Submit" Then
		'get form values
		strSurveyTitle = trim(Request.Form("surveyTitle"))
		strDescription = trim(Request.Form("description"))
		intSurveyType = cint(Request.Form("surveyType"))
		dtmStartMonth = Request.Form("startMonth")
		dtmStartDay = Request.Form("startDay")
		dtmStartYear = Request.Form("startYear")
		dtmEndMonth = Request.Form("endMonth")
		dtmEndDay = Request.Form("endDay")
		dtmEndYear = Request.Form("endYear")
		intMaxResponses = trim(Request.Form("maxResponses"))
		intResponsesPerUser = trim(Request.Form("responsesPerUser"))
		strCompletionMessage = trim(Request.Form("completionMessage"))
		strCompletionRedirect = trim(Request.Form("completionRedirect"))
		intPrivacyLevelID = Request.Form("privacyLevel")
		strResultsEmail = Request.Form("resultsEmail")
		intTemplateID = Request.Form("templateID")
		
		If Request.Form("allowContinue") = "on" Then
			boolAllowContinue = True
		Else
			boolAllowContinue = False
		End If
		
		If Request.Form("showProgress") = "on" Then
			boolShowProgress = True
		Else
			boolShowProgress = False
		End If
				
		If Request.Form("scored") = "on" Then
			boolScored = True
		Else
			boolScored = False
		End If

		If Request.Form("logNTUser") = "on" Then
			boolLogNTUser = True
		Else
			boolLogNTUser = False
		End If

		If Request.Form("emailUser") = "on" Then
			boolEmailUser = True
		Else
			boolEmailUser = False
		End If

		If Request.Form("numberLabels") = "on" Then
			boolNumberLabels = True
		End If

		If Request.Form("editable") = "on" Then
			boolEditable = True
		Else
			boolEditable = False
		End If
		
		If Request.Form("userInfoAvailable") = "on" Then
			boolUserInfoAvailable = True
		Else
			boolUserInfoAvailable = False
		End If
		
		'VALIDATE FORM 
		
		'check existence and uniqueness of survey title
		If strSurveyTitle = "" Then
			strError = strError & "Survey must have a title.<br />"
		ElseIf surveyCreation_titleExists(strSurveyTitle) = True Then
			strError = strError & "Survey title has been taken.<br />"
		End If
		
		'if user inputted any part of start date
		If dtmStartMonth <> "" or dtmStartDay <> "" or dtmStartYear <> "" Then
			'compose the start date
			dtmStartDate = dtmStartMonth & "/" & dtmStartDay & "/" & dtmStartYear
			'check validity of the date
			If not isDate(dtmStartDate) Then
				strError = strError & "Your start date is invalid.<br />"
			End If
		End If
		
		'if user inputted any part of end date
		If dtmEndMonth <> "" or dtmEndDay <> "" or dtmEndYear <> "" Then
			'compose the end date
			dtmEndDate = dtmEndMonth & "/" & dtmEndDay & "/" & dtmEndYear
			'check validity of the date
			If not isDate(dtmEndDate) Then
				strError = strError & "Your end date is invalid.<br />"
			End If
		End If
		
		'make sure max responses is blank or a positive integer
		If intMaxResponses <> "" Then
			If not utility_isPositiveInteger(intMaxResponses) = True Then
				strError = strError & "Maximum responses must be a positive integer or left blank.<br />"
			End If
		End If
		
		If intResponsesPerUser <> "" and not utility_isPositiveInteger(intResponsesPerUser) Then
			strError = strError & "Responses Per User must be a positive integer or left blank.<br />"
		End If
		
		If len(strDescription) > 255 Then
			strError = strError & "Description cannot exceed 255 characters.<br />"
		End If
				
		'if all values are in correct format, add this survey to the database
		If strError = "" Then
			Call surveyCreation_addSurvey(strSurveyTitle, strDescription, intSurveyType, dtmStartDate, _
					dtmEndDate, intMaxResponses, intResponsesPerUser, _ 
					strCompletionMessage, strCompletionRedirect, _
					intPrivacyLevelID, intUserID, boolAllowContinue, strResultsEmail, intSurveyIDOut, _
					boolShowProgress, boolScored, boolLogNTUser, boolEmailUser, boolNumberLabels, intTemplateID, boolEditable, boolUserInfoAvailable)
			Response.Redirect("manageIndividualSurvey.asp?surveyID=" & intSurveyIDOut)
		End If
	Else
		intResponsesPerUser = 1
		boolUserInfoAvailable = True
	End If
%>	
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
<span class="surveyTitle">Create Survey<%=common_helpLink("surveys/createSurvey.asp",SV_SMALL_HELP_IMAGE)%></span>
<hr noshade color="#C0C0C0" size="2">
<p class="message"><%=strError%></p>
<form method="post" action="createSurvey.asp" id=form1 name=form1>
	<table border="0" cellpadding="0" cellspacing="0" class="normal">
		<tr>
			<td align="left" class="normalBold-Big" width="200">
				Title/Description
			</td>
			<td align="left" class="normalBold">
				<%=common_helpLink("surveys/properties/surveyTitle.asp",SV_SMALL_HELP_IMAGE)%>Survey Title:<%=common_requiredFlag()%>
			</td>
			<td>
				<input type="text" name="surveyTitle" value="<%=strSurveyTitle%>" size="52">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold">
				<%=common_helpLink("surveys/properties/description.asp",SV_SMALL_HELP_IMAGE)%>Description:
			</td>
			<td>
				<textarea name="description"  rows="4" cols="40"><%=strDescription%></textarea>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold">
				Template:
			</td>
			<td>
				<%=surveyCreation_templateDropdown(0)%>
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table border="0" cellpadding="0" cellspacing="0" class="normal">
		<tr>
			<td align="left" class="normalBold-Big" width="200">
				Basic Options
			</td>
			<td align="left" class="normalBold">
				<input type="checkbox" name="allowContinue">
				Allow Users to Resume<%=common_helpLink("surveys/properties/allowResume.asp",SV_SMALL_HELP_IMAGE)%>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold">
				<input type="checkbox" name="editable">
				Allow Users to Edit Response
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold">
				<input type="checkbox" name="showProgress">
				Show Survey Progress<%=common_helpLink("surveys/properties/showProgress.asp",SV_SMALL_HELP_IMAGE)%>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold">
				<input type="checkbox" name="scored">
				Scored Survey<%=common_helpLink("surveys/properties/scoredSurvey.asp",SV_SMALL_HELP_IMAGE)%>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold">
				<input type="checkbox" name="numberLabels">
				Number Labels<%=common_helpLink("surveys/properties/numberLabels.asp",SV_SMALL_HELP_IMAGE)%>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold">
				<input type="checkbox" name="logNTUser">
				Log NT User<%=common_helpLink("surveys/properties/logNTUser.asp",SV_SMALL_HELP_IMAGE)%>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold">
				<input type="checkbox" name="emailUser">
				Email User Response
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table border="0" cellpadding="0" cellspacing="0" class="normal">
		<tr>
			<td class="normalBold-Big" width="200">
				Response Options
			</td>
			<td class="normalBold">
				<%=common_helpLink("surveys/properties/surveyType.asp",SV_SMALL_HELP_IMAGE)%>Survey Type:<%=common_requiredFlag()%>
			</td>
			<td>
				<select name="surveyType">
					<option value="<%=SV_SURVEY_TYPE_PUBLIC%>"
<%
					If intSurveyType = SV_SURVEY_TYPE_PUBLIC Then
%>
						selected
<%
					End If
%>
					>
						<%=survey_getSurveyTypeText(SV_SURVEY_TYPE_PUBLIC)%>
					</option>
					<option value="<%=SV_SURVEY_TYPE_REGISTERED_ONLY%>"
<%
					If intSurveyType = SV_SURVEY_TYPE_REGISTERED_ONLY Then
%>
						selected
<%
					End If
%>
					>
						<%=survey_getSurveyTypeText(SV_SURVEY_TYPE_REGISTERED_ONLY)%>
					</option>
					<option value="<%=SV_SURVEY_TYPE_RESTRICTED%>"
<%
					If intSurveyType = SV_SURVEY_TYPE_RESTRICTED Then
%>
						selected
<%
					End If
%>
					>
						<%=survey_getSurveyTypeText(SV_SURVEY_TYPE_RESTRICTED)%>
					</option>
			</td>
		</tr>
<%
		dtmFirstYear = datePart("yyyy",date())
%>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold">
				<%=common_helpLink("surveys/properties/startDate.asp",SV_SMALL_HELP_IMAGE)%>Start Date:
			</td>
			<td>
				<%=common_dateSelect("start", dtmStartDate, dtmFirstYear, USD_DROPDOWN_YEARS)%>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold">
				<%=common_helpLink("surveys/properties/endDate.asp",SV_SMALL_HELP_IMAGE)%>End Date:
			</td>
			<td>
				<%=common_dateSelect("end", dtmEndDate, dtmFirstYear, USD_DROPDOWN_YEARS)%>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold">
				<%=common_helpLink("surveys/properties/maxRespondents.asp",SV_SMALL_HELP_IMAGE)%>Max Respondants:
			</td>
			<td>
				<input type="text" name="maxResponses" size="8" value="<%=intMaxResponses%>">
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold">
				<%=common_helpLink("surveys/properties/responsesPerUser.asp",SV_SMALL_HELP_IMAGE)%>Responses Per User:
			</td>
			<td align="left">
				<input type="text" name="responsesPerUser" size="4" value="<%=intResponsesPerUser%>">
			</td>
		</tr>
		
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table border="0" cellpadding="0" cellspacing="0" class="normal">
		<tr>
			<td class="normalBold-Big" width="200">
				Reporting Options
			</td>
			<td align="left" class="normalBold">
				<%=common_helpLink("surveys/properties/privacyLevel.asp",SV_SMALL_HELP_IMAGE)%>Privacy Level:
			</td>
			<td align="left">
				<%surveyCreation_privacyLevelDropdown(intPrivacyLevelID)%>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold">
				<input type="checkbox" name="userInfoAvailable" 
<%
				If boolUserInfoAvailable = True Then
%>
					checked
<%
				End If
%>			
				>
				User Information Available
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table border="0" cellpadding="0" cellspacing="0" class="normal">

		<tr valign="top">
			<td class="normalBold-Big" width="200">
				Completion Options
			</td>
			
			<td align="left" class="normal" valign="top">
				<%=common_helpLink("surveys/properties/displayMessage.asp",SV_SMALL_HELP_IMAGE)%>Display Message:<br />
				<textarea name="completionMessage" rows="4" cols="40"><%=strCompletionMessage%></textarea>
			</td>
		</tr>
		<tr>
			<td align="left">
				&nbsp;
			</td>
			<td>
				<%=common_helpLink("surveys/properties/redirectToURL.asp",SV_SMALL_HELP_IMAGE)%>Redirect to URL:<br>
				<input type="text" name="completionRedirect" size="50" 
					value="<%=strCompletionRedirect%>">
				<br /><br />
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td align="left" class="normal">
				<%=common_helpLink("surveys/properties/emailResponsesTo.asp",SV_SMALL_HELP_IMAGE)%>Email Responses to:
				<br />
				<input type="text" name="resultsEmail" size="50" 
					value="<%=strResultsEmail%>">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table cellpadding="0" cellspacing="0">
		<tr>
			<td width="200">
				&nbsp;
			</td>
			<td>
				<input type="hidden" name="submit" value="Submit">
				<input type="image" src="images/button-submit.gif" alt="Submit" border="0">
			</td>
		</tr>
	</table>
</form>


<!--#INCLUDE FILE="Include/footer_inc.asp"-->

