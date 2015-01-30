<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		surveyProperties.asp 
' Purpose:	page to edit properties of a specified survey
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
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
Dim strAction
Dim strSurveyTitle
Dim strDescription
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
Dim dtmFirstYear
Dim intSurveyID
Dim strMessage
Dim strCompletionMessage
Dim strCompletionRedirect
Dim intPrivacyLevelID
Dim boolAllowContinue
Dim strResultsEmail
Dim boolShowProgress
Dim boolScored
Dim boolLogNTUser
Dim boolEmailUser
Dim boolNumberLabels
Dim intTemplateID
Dim boolEditable
Dim boolUserInfoAvailable
Call user_loginNetworkUser()

'Get the userid and usertype out of the session or cookie
Call user_getSessionInfo(intUserID, intUserType, "","", "",True)

intSurveyID = cint(Request.QueryString("surveyID"))

If ((survey_getOwnerID(intSurveyID) <> intUserID) _
		and intUserType = SV_USER_TYPE_CREATOR) _
		or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
	Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
End If

strAction = Request.Form("submit")

'If form submitted
If strAction = "Submit" Then
	'get form values
	strSurveyTitle = trim(Request.Form("surveyTitle"))
	strDescription = trim(Request.Form("description"))
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
	strResultsEmail = trim(Request.Form("resultsEmail"))
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
	boolLOgNTUser = False
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



'Response.Write "Got to here..."
'Response.End



	'if all values are in correct format, add this survey to the database
	If strError = "" Then
		Call surveyCreation_editSurvey(intSurveyID, strSurveyTitle, strDescription, _
				dtmStartDate, dtmEndDate, intMaxResponses, _
				intResponsesPerUser, strCompletionMessage, _
				strCompletionRedirect, intPrivacyLevelID, boolAllowContinue, strResultsEmail, _
				boolShowProgress, boolScored, boolLogNTUser, boolEmailUser, boolNumberLabels, intTemplateID, boolEditable, boolUserInfoAvailable)
		Response.Redirect("manageIndividualSurvey.asp?surveyID=" & intSurveyID & "&message=" & SV_MESSAGE_PROPERTIES_EDITED)
	Else 
		strError = "No changes were made:<br /><br />" & strError
	End If
End If

strSQL = "SELECT surveyTitle, surveyDescription, templateID, allowContinue, editable, showProgress, isScored, numberLabels, logNTUser, " &_
			"emailUser, startDate, endDate, responsesPerUser, isActive, createdDate, numberResponses, " &_
			"maxResponses, privacyLevel, userInfoAvailable, completionMessage, completionRedirect, " &_
			"resultsEmail " &_
		 "FROM usd_Survey " &_
		 "WHERE surveyID = " & intSurveyID
Set rsResults = utility_getRecordset(strSQL)
If rsResults.EOF Then
	rsResults.Close
	Set rsResults = NOTHING
	Response.Redirect("index.asp?message=" & SV_MESSAGE_UNKNOWN_ERROR)
End If

dtmFirstYear = datePart("yyyy",date())
strSurveyTitle = rsResults("surveyTitle")
strDescription = rsResults("surveyDescription")
intTemplateID = rsResults("templateID")
%>
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>

	<span class="breadcrumb" align="left">
	<a href="manageSurveys.asp">All Surveys</a> >>
	<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=survey_getSurveyTitle(intSurveyID)%></a> >>
	Survey Properties
	</span><br /><br />
	
	<span class="surveyTitle">Survey Properties</span>
<%
	If len(strMessage) > 0 Then
%>
		<br /><span class="message"><%=strMessage%></span>
<%
	End If
	
	If len(strError) > 0 Then
%>
		<br /><span class="message"><%=strError%></span>
<%
	End If
%>	
	
		<form method="post" action="surveyProperties.asp?surveyID=<%=intSurveyID%>">
			<hr noshade color="#C0C0C0" size="2">
			<table border="0" cellpadding="2" cellspacing="2" width="100%" style="border-collapse: collapse" bordercolor="#C0C0C0">
			<tr>
			<td>
			<table border="0" cellpadding="0" cellspacing="0" class="normal">
				<tr>
					<td class="normalBold-Big" width="200">
						Title/Description
					</td>
					<td align="left" class="normalBold">
						<%=common_helpLink("surveys/properties/surveyTitle.asp",SV_SMALL_HELP_IMAGE)%>Survey Title<%=common_requiredFlag()%>
					</td>
					<td>
						<input type="text" name="surveyTitle" value="<%=strSurveyTitle%>" size="53">
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td align="left" class="normalBold">
						<%=common_helpLink("surveys/properties/description.asp",SV_SMALL_HELP_IMAGE)%>Description
					</td>
					<td>
						<textarea name="description" 
							rows="4" cols="40"><%=strDescription%></textarea>
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td align="left" class="normalBold">
						Style Template
					</td>
					<td>
						<%=surveyCreation_templateDropdown(intTemplateID)%>
					</td>
				</tr>
			</table>
			<hr noshade color="#C0C0C0" size="2">
			<table border="0" cellpadding="0" cellspacing="2" class="normal">
				<tr>
					<td class="normalBold-Big" width="200">
						Basic Options
					</td>
					<td align="left" class="normalBold">
						<input type="checkbox" name="allowContinue"
<%	
						If cbool(rsResults("allowContinue")) = True Then
%>
							checked
<%
						End If
%>
						>
						Allow Users to Resume<%=common_helpLink("surveys/properties/allowResume.asp",SV_SMALL_HELP_IMAGE)%>
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td align="left" class="normalBold">
							<input type="checkbox" name="editable"
<%	
						If cbool(rsResults("editable")) = True Then
%>
							checked
<%
						End If
%>
						>
					
						Allow Users to Edit Response
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td align="left" class="normalBold">
							<input type="checkbox" name="showProgress"
<%	
						If cbool(rsResults("showProgress")) = True Then
%>
							checked
<%
						End If
%>
						>
					
						Show Progress<%=common_helpLink("surveys/properties/showProgress.asp",SV_SMALL_HELP_IMAGE)%>
					</td>
				</tr>


				<tr>
					<td>
						&nbsp;
					</td>
					<td align="left" class="normalBold">
						<input type="checkbox" name="scored"
<%	
						If cbool(rsResults("isScored")) = True Then
%>
							checked
<%
						End If
%>
						>
						Scored<%=common_helpLink("surveys/properties/scoredSurvey.asp",SV_SMALL_HELP_IMAGE)%>
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td align="left" class="normalBold">
						<input type="checkbox" name="numberLabels"
<%	
						If cbool(rsResults("numberLabels")) = True Then
%>
							checked
<%
						End If
%>
						>
						Number Labels<%=common_helpLink("surveys/properties/numberLabels.asp",SV_SMALL_HELP_IMAGE)%>
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td align="left" class="normalBold">
							<input type="checkbox" name="logNTUser"
<%	
						If cbool(rsResults("logNTUser")) = True Then
%>
							checked
<%
						End If
%>
						>
					
						Log NT User<%=common_helpLink("surveys/properties/logNTUser.asp",SV_SMALL_HELP_IMAGE)%>
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td align="left" class="normalBold">
							<input type="checkbox" name="emailUser"
<%	
						If cbool(rsResults("emailUser")) = True Then
%>
							checked
<%
						End If
%>
						>
						Email User Response
					</td>
				</tr>
			</table>
			<hr noshade color="#C0C0C0" size="2">
			<table border="0" cellpadding="0" cellspacing="2" class="normal">
				<tr>
					<td class="normalBold-Big" width="200">
						Response Options
					</td>
					<td align="left" class="normalBold">
						<%=common_helpLink("surveys/properties/startDate.asp",SV_SMALL_HELP_IMAGE)%>Start Date:
					</td>
					<td>
						<%=common_dateSelect("start", rsResults("startDate"), dtmFirstYear, USD_DROPDOWN_YEARS)%>
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
						<%=common_dateSelect("end", rsResults("endDate"), dtmFirstYear, USD_DROPDOWN_YEARS)%>
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
						<input type="text" name="maxResponses" size="8" 
							value="<%=rsResults("maxResponses")%>">
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td align="left" class="normalBold">
						<%=common_helpLink("surveys/properties/responsesPerUser.asp",SV_SMALL_HELP_IMAGE)%>Responses Per User:
					</td>
					<td>
						<input type="text" name="responsesPerUser" size="4" 
							value="<%=rsResults("responsesPerUser")%>">
					</td>
				</tr>
			</table>
			<hr noshade color="#C0C0C0" size="2">
			<table border="0" cellpadding="0" cellspacing="2" class="normal">
				<tr>
					<td class="normalBold-Big" width="200">
						Reporting Options
					</td>
					<td align="left" class="normalBold">
						<br />
						<%=common_helpLink("surveys/properties/privacyLevel.asp",SV_SMALL_HELP_IMAGE)%>Privacy Level:
					</td>
					<td align="left">
						<br />
						<%surveyCreation_privacyLevelDropdown(rsResults("privacyLevel"))%>
					</td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="2" class="normal">
				<tr>
					<td class="normalBold-Big" width="200">
						&nbsp;
					</td>

					<td align="left" class="normalBold">
							<input type="checkbox" name="userInfoAvailable"
<%	
						If cbool(rsResults("userInfoAvailable")) = True Then
%>
							checked
<%
						End If
%>
						>
						<td align="left" class="normalBold">
						User Info Available
					</td>
					</td>
				</tr>
			</table>
			<hr noshade color="#C0C0C0" size="2">
			<table border="0" cellpadding="0" cellspacing="2" class="normal">
				<tr>
					<td class="normalBold-Big" width="200" valign="top">
						Completion Options
					</td>
					<td>
						<%=common_helpLink("surveys/properties/displayMessage.asp",SV_SMALL_HELP_IMAGE)%>Display Message:<br />
						<textarea name="completionMessage" rows="4" cols="40"><%=rsResults("completionMessage")%></textarea>
					</td>
				</tr>
				<tr>
					<td align="left" class="normalBold" valign="top">
						&nbsp;
					</td>
					<td>
						<%=common_helpLink("surveys/properties/redirectToURL.asp",SV_SMALL_HELP_IMAGE)%>Redirect to URL:<br />
						<input type="text" name="completionRedirect" size="53" 
							value="<%=rsResults("completionRedirect")%>">
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td align="left" class="normal">
						<%=common_helpLink("surveys/properties/emailResponsesTo.asp",SV_SMALL_HELP_IMAGE)%>Email Responses To:
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
					<td>
						<input type="text" name="resultsEmail" size="53" 
							value="<%=rsResults("resultsEmail")%>">
					</td>
				</tr>
			</table>
			<hr noshade color="#C0C0C0" size="2">
			<table border="0" cellpadding="0" cellspacing="2" class="normal">
				<tr>
					<td width="200">
						&nbsp;
					</td>
					<td>
						<input type="hidden" name="submit" value="Submit">
						<input type="image" src="images/button-submitChanges.gif" alt="Submit Changes" border="0"
							onclick="javascript:return confirmAction('Are you sure you want to edit the properties of this survey?');">
					</td>
				</tr>
			</table>
			</td>
			</tr>
			</table>
		</form>
<%
	rsResults.Close
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

