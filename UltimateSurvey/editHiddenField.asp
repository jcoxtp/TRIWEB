<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1	
'****************************************************
'
' Name:		editHiddenField.asp
' Purpose:	page to add or edit hidden fields for a survey
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
	Dim strError
	Dim strQuestionText
	Dim strVariableName
	Dim intHiddenFieldType
	Dim intHiddenFieldID

	Call user_loginNetworkUser()

	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = cint(Request.QueryString("surveyID"))
	intHiddenFieldID = Request("hiddenFieldID")
	
	If ((survey_getOwnerID(intSurveyID) <> intUserID) _
			and intUserType = SV_USER_TYPE_CREATOR) _
			or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	intDelete = Request.QueryString("delete")
	If utility_isPositiveInteger(intDelete) Then
		strSQL = "DELETE usd_surveyItem WHERE itemID = " & intDelete
		Call utility_executeCommand(strSQL)
	End If
	
	
	If Request.Form("submit") = "True" Then
		intHiddenFieldType = Request.Form("hiddenFieldType")
		strQuestionText = trim(Request.Form("questionText"))
		strVariableName = trim(Request.Form("variableName"))	
	
		If len(strQuestionText) = 0 Then
			strError = "Please specify question text."
		ElseIf not utility_isPositiveInteger(intHiddenFieldType) Then
			strError = "Please select a field type."
		ElseIf len(strVariableName) = 0 Then
			strError = "Please specify a variable name."
		End If
			
		If len(strError) = 0 Then
			If not utility_isPositiveInteger(intHiddenFieldID) Then
				Call surveyCreation_addHiddenField(intSurveyID, intHiddenFieldType, strQuestionText, strVariableName)
			Else
				Call surveyCreation_editHiddenField(intHiddenFieldID, intHiddenFieldType, strQuestionText, strVariableName)
			End If
			Response.Redirect("hiddenFields.asp?surveyID=" & intSurveyID & "&message=" & SV_MESSAGE_HIDDEN_FIELD_ADDED)
		End If
	Else
		If utility_isPositiveInteger(intHiddenFieldID) Then
			strSQL = "SELECT itemType, itemText, variableName FROM usd_surveyItem WHERE itemID = " & intHiddenFieldID
			
			Set rsResults = utility_getRecordset(strSQL)
			If not rsResults.EOF Then
				intHiddenFieldType = rsResults("itemType")
				strQuestionText = rsResults("itemText")
				strVariableName = rsResults("variableName")
			End If
			rsResults.Close
			Set rsResults = NOTHING
			
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
	<a href="hiddenFields.asp?surveyID=<%=intSurveyID%>">Hidden Fields</a>
	</span><br /><br />
	<span class="surveyTitle">
<%
	If utility_isPositiveInteger(intHiddenFieldID) Then
%>
		Edit Hidden Field
<%
	Else
%>
		Add Hidden Field
<%
	End If
%>	
	</span>	<%=common_helpLink("surveys/hiddenFields.asp",SV_SMALL_HELP_IMAGE)%>
<%
	If len(strError) > 0 Then
%>
		<br /><span class="message"><%=strError%></span>
<%
	End If
%>
	<hr noshade color="#C0C0C0" size="2">

	<form method="post" action="editHiddenField.asp?surveyID=<%=intSurveyID%>">
	<table class="normalBold">
		<tr>
			<td width="200" class="normalBold-Big" valign="top">
				Question	
			</td>
			<td valign="top">
				<textarea rows="5" cols="70" name="questionText"><%=strQuestionText%></textarea>
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table class="normalBold">
		<tr>
			<td width="200" class="normalBold-Big" valign="top">
				Hidden Field Type	
			</td>
			<td valign="top">
				<table class="normalBold">
					<tr>
						<td>
							Query String
						</td>
						<td>
							<input type="radio" name="hiddenFieldType" value="<%=SV_HIDDEN_FIELD_TYPE_QUERYSTRING%>"
<%
							If intHiddenFieldType = SV_HIDDEN_FIELD_TYPE_QUERYSTRING Then
%>
									checked
<%
							End If
%>							
							>
						</td>
					</tr>
					<tr>
						<td>
							Session
						</td>
						<td>
							<input type="radio" name="hiddenFieldType" value="<%=SV_HIDDEN_FIELD_TYPE_SESSION%>"
<%
							If intHiddenFieldType = SV_HIDDEN_FIELD_TYPE_SESSION Then
%>
									checked
<%
							End If
%>							
							
							>
						</td>
					</tr>
					<tr>
						<td>
							Cookie
						</td>
						<td>
							<input type="radio" name="hiddenFieldType" value="<%=SV_HIDDEN_FIELD_TYPE_COOKIE%>"
<%
							If intHiddenFieldType = SV_HIDDEN_FIELD_TYPE_COOKIE Then
%>
									checked
<%
							End If
%>							
							
							>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table class="normalBold">
		<tr>
			<td width="200" class="normalBold-Big">
				Variable Name
			</td>
			<td>
				<input type="text" name="variableName" size="70" value=<%=strVariableName%>>
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table class="normalBold">
		<tr>
			<td width="200" class="normalBold-Big">
				&nbsp;
			</td>
			<td>
				<input type="hidden" name="submit" value="True">
				<input type="hidden" name="hiddenFieldID" value="<%=intHiddenFieldID%>">
				<input type="image" src="images/button-submit.gif" alt="Submit" border="0" 
<%
	If utility_isPositiveInteger(intHiddenFieldID) Then
%> 
				onclick="return confirmAction('Are you sure you want to edit this hidden field?');" 
<%
	Else
%>				
				onclick="return confirmAction('Are you sure you want to add this hidden field?');" 
<%
	End If
%>				
				
				>
			</td>
		</tr>
	</table>
	</form>
<%
	End If
%>
	<!--#INCLUDE FILE="Include/footer_inc.asp"-->

