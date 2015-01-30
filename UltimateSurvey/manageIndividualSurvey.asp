<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		manageIndividualSurvey.asp 
' Purpose:	home page for chosen survey
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/itemDisplay_inc.asp"-->
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
	Dim intSurveyType 
	Dim intSurveyID
	Dim boolIsActive
	Dim boolActive
	Dim intAction
	Dim intMessage
	Dim strMessage
	Dim strSurveyTitle
	Dim strDescription
	Dim intNumberResponses
	Dim intMaxResponses
	Dim dtmStartDate
	Dim dtmEndDate
	Dim strQueryString
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = cint(Request.QueryString("surveyID"))
	
	If not utility_isPositiveInteger(intUserID) Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	
	Else
		If ((survey_getOwnerID(intSurveyID) <> intUserID) _
				and intUserType = SV_USER_TYPE_CREATOR) _
				or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
			Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	
		End If
	End If
	

	
	intMessage = cint(Request.QueryString("message"))
	Select Case intMessage
		Case SV_MESSAGE_USERS_INVITED
			strMessage = "Users successfully invited."
		Case SV_MESSAGE_PROPERTIES_EDITED
			strMessage = "Survey properties successfully edited."
		Case SV_MESSAGE_USERS_REMINDED
			strMessage = "Reminders successfully sent."
	End Select

	
	boolActive = Request.QueryString("active")
	If boolActive <> "" Then
		Call surveyCreation_changeActiveStatus(intSurveyID, cbool(boolActive))
	End If
	
	
	intAction = cint(Request.QueryString("action"))
	Select Case intAction
		Case SV_ACTION_CLEAR_RESULTS
			Call survey_clearResults(intSurveyID)
	End Select
	
	strQuerystring = survey_getQueryString(intSurveyID)
	
	strSQL = "SELECT surveyType, surveyTitle, surveyDescription, isActive, numberResponses, maxResponses, startDate, endDate " &_
			 "FROM usd_Survey " &_
			 "WHERE surveyID = " & intSurveyID
	
	Set rsResults = utility_getRecordset(strSQL)
	If rsResults.EOF Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_UNKNOWN_ERROR)
	End If
		intSurveyType = rsResults("surveyType")
		strSurveyTitle = rsResults("surveyTitle")
		strDescription = rsResults("surveyDescription")
		boolIsActive = cbool(rsResults("isActive"))
		intNumberResponses = rsResults("numberResponses")
		intMaxResponses = rsResults("maxResponses")
		dtmStartDate = rsResults("startDate")
		dtmEndDate = rsResults("endDate")
		If isNull(dtmStartDate) Then
			dtmStartDate = "n/a"
		End If
		If isNull(dtmEndDate) Then
			dtmEndDate = "n/a"
		End If
%>
		<%=header_htmlTop("white","")%>
		<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
		<form>
		<span class="breadcrumb" align="left">
	<a href="manageSurveys.asp">All Surveys</a> >>
	<%=survey_getSurveyTitle(intSurveyID)%></span>
	
		<p class="message"><%=strMessage%></p>
		<span class="surveyTitle">
			Manage Survey
		</span>
		<hr noshade color="#C0C0C0" size="2">
<%
		rsResults.Close
%>
  
  <table class="normal" ID="Table1">
		<tr>
			<td class="normalBold-Big" width="150">
				General
			</td>
			
			<td class="normalBold">
				Name:
			</td>
			<td>
				<%=survey_getSurveyTitle(intSurveyID)%>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			
		<td class="normalBold">
				Owner:
			</td>
			<td>
				<%=survey_getOwnerUsername(intSurveyID)%>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td width="80" class="normalBold">
				Start Date:
			</td>
			<td>
				<%=dtmStartDate%>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td width="80" class="normalBold">
				End Date:
			</td>
			<td>	
				<%=dtmEndDate%>
			</td>
		</tr>
				
		<tr>
			<td class="normalBold">
				&nbsp;
			</td>
			<td class="normalBold">
				Items:
			</td>
			<td>			
				<%=survey_getItemCount(intSurveyID)%>
			</td>
		</tr>
		<tr>
			<td class="normalBold">
				&nbsp;
			</td>
			<td class="normalBold">
				Pages:
			</td>
			<td>
				<%=surveyCreation_getLastPageNumber(intSurveyID)%>
			</td>
		</tr>
</table>
<hr noshade color="#C0C0C0" size="2">
  
    <table class="normal">
		<tr>
			<td class="normalBold-Big" width="150">
				Status
			</td>
			<td>
					
<%			

		If boolIsActive = True Then
%>
			Active&nbsp;&nbsp;
			(<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>&active=False"
				onclick="javascript:return confirmAction('Are you sure you want to deactivate this survey?');">Deactivate</a>)
			
<%
		Else
%>
			Not Active&nbsp;&nbsp;
			(<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>&active=True"
				onclick="javascript:return confirmAction('Are you sure you want to activate this survey?');">Activate</a>)
		
<%
		End If
%>
			</td>
		</tr>
	</table>
		<hr noshade color="#C0C0C0" size="2">
		<table class="normal">
		<tr>
			<td class="normalBold-Big" width="150" valign="top">
				Management
			</td>
			<td>
				<a href="editSurvey.asp?surveyID=<%=intSurveyID%>"><img src="images/button-editsurvey.gif" alt="Edit Survey" height="17" width="125" border="0" vspace="2"></a><br>
			
				<a href="surveyProperties.asp?surveyID=<%=intSurveyID%>"><img src="images/button-editproperties.gif" alt="Edit Properties" height="17" width="125" vspace="2" border="0"></a><br>
			
<%
		If survey_isScored(intSurveyID) = True Then
%>
			
				<a href="scoringMessages.asp?surveyID=<%=intSurveyID%>">
				<img src="images/button-scoringmessages.gif" alt="Set Scoring Messages" height="17" width="125" vspace="2" border="0"></a><br>
<%
		End If
%>
				<a href="hiddenFields.asp?surveyID=<%=intSurveyID%>">
				<img src="images/button-hiddenFields.gif" alt="Setup Hidden Fields" height="17" width="125" vspace="2" border="0"></a><br>

				<a href="deleteSurvey.asp?surveyID=<%=intSurveyID%>"
				onclick="javascript:return confirmAction('Are you sure you want to delete this survey?');"><img src="images/button-deletesurvey.gif" alt="Delete Survey" height="17" width="125" vspace="2" border="0"></a>
			</td>	
		</tr>
	</table>

	<hr noshade color="#C0C0C0" size="2">	
	
<table class="normal">
		<tr>
			<td class="normalBold-Big" width="150">
				Results
			<td class="normalBold" width="80">
				Responses:
			</td>
			<td>
				<%=intNumberResponses%>
<%
				If utility_isPositiveInteger(intMaxResponses) Then
%>
					out of <%=intMaxResponses%>
<%
				End If
%>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;
			</td>
			<td>
				<a href="viewResults.asp?surveyID=<%=intSurveyID%>">
				View Reports</a>
			</td>
			<td>
				<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>&action=<%=SV_ACTION_CLEAR_RESULTS%>"
				onclick="javascript:return confirmAction('Are you sure you want to delete all results for this survey?');">
					Delete Results</a>
			</td>
		</tr>
	</table>

	<hr noshade color="#C0C0C0" size="2">

	<table class="normal">
		<tr>
			<td class="normalBold-Big" width="150">
				Security
			</td>
			<td>
				<a href="surveySecurity.asp?surveyID=<%=intSurveyID%>">
				Manage Survey Security</a>
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	
	<table class="normal">
		<tr>
			<td class="normalBold-Big" width="150" valign="top">
				Invititations
			</td>
			<td>
				<a href="sendInvitations.asp?surveyID=<%=intSurveyID%>">
				Send Invitations</a><br>
				<a href="sendReminders.asp?surveyID=<%=intSurveyID%>">
				Send Reminders</a>
			</td>
		</tr>
				
	</table>
	<hr noshade color="#C0C0C0" size="2">
	
	<table class="normal">
		<tr>
			<td class="normalBold-Big" width="150">
				Survey URL
			</td>
			<td>
<%
		If intSurveyType = SV_SURVEY_TYPE_PUBLIC Then
%>

				<a href="<%=SV_ROOT_PATH%>takeSurvey.asp?surveyID=<%=intSurveyID%><%=strQuerystring%>" target="_blank"><%=SV_ROOT_PATH%>takeSurvey.asp?surveyID=<%=intSurveyID%><%=strQuerystring%></a>
		
			
<%
		Else
%>
				<a href="<%=SV_ROOT_PATH%>login.asp?surveyID=<%=intSurveyID%><%=strQuerystring%>" target="_blank"><%=SV_ROOT_PATH%>login.asp?surveyID=<%=intSurveyID%><%=strQuerystring%></a>
		
<%
		End If
		
		If len(strQueryString) > 0 Then
%>
			<br /><span class="message">This URL includes all querystring variables from "Hidden Fields", but the values are left blank.  Please fill the values in
			before sending the URL to your survey takers.
			</span>
<%
		End If
%>		
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table class="normal">
		<tr>
			<td class="normalBold-Big" width="150">
				Print
			</td>
			<td valign="middle">
				<a href="#" onclick="javascript:popup('printSurvey.asp?surveyID=<%=intSurveyID%>','print',0,0,0,0,0,0,0,0,6000,6000);">
					<img src="images/button-printSurvey.gif" alt="Print Survey" width="125" height="17" border="0"></a>
			</td>
			<td valign="middle">
					&nbsp;&nbsp;<%=common_helpLinkText("surveys/printingTips.asp","(Printing Tips)")%>
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

