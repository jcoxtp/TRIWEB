<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1	
'****************************************************
'
' Name:		addHiddenField.asp
' Purpose:	page to add hidden fields for a survey
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
	

	Call user_loginNetworkUser()

	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = cint(Request.QueryString("surveyID"))
	
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
			Call surveyCreation_addHiddenField(intSurveyID, intHiddenFieldType, strQuestionText, strVariableName)
			Response.Redirect("hiddenFields.asp?surveyID=" & intSurveyID & "&message=" & SV_MESSAGE_HIDDEN_FIELD_ADDED)
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
	Hidden Fields
	</span><br /><br />
		<a class="normalBold" href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>">
			<img src="images/button-save.gif" alt="Save and Continue" border="0"></a>&nbsp;
		<a class="normalBold" href="pageBRanching.asp?surveyID=<%=intSurveyID%>&pageID=0">
			<img src="images/button-branching.gif" alt="Branching" border="0">
		</a>
	</p>
	<p class="message"><%=strError%></p>
	<form method="post" action="addHiddenField.asp?surveyID=<%=intSurveyID%>">
	<table class="normalBold">
		<tr>
			<td width="200" class="normalBold-Big" valign="top">
				Question	
			</td>
			<td valign="top">
				<textarea rows="5" cols="70" name="questionText"></textarea>
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
							<input type="radio" name="hiddenFieldType" value="<%=SV_HIDDEN_FIELD_TYPE_QUERYSTRING%>">
						</td>
					</tr>
					<tr>
						<td>
							Session
						</td>
						<td>
							<input type="radio" name="hiddenFieldType" value="<%=SV_HIDDEN_FIELD_TYPE_SESSION%>">
						</td>
					</tr>
					<tr>
						<td>
							Cookie
						</td>
						<td>
							<input type="radio" name="hiddenFieldType" value="<%=SV_HIDDEN_FIELD_TYPE_COOKIE%>">
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
				<input type="text" name="variableName" size="70">
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
				<input type="image" src="images/button-submit.gif" alt="Submit" border="0" onclick="return confirmAction('Are you sure you want to add this hidden field?');"> 
			</td>
		</tr>
	</table>
	</form>
<%
	End If
%>
	<!--#INCLUDE FILE="Include/footer_inc.asp"-->

