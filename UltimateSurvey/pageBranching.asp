<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1	
'****************************************************
'
' Name:		pageBranching.asp
' Purpose:	page to manage branching for an entire page of items
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
	Dim intSurveyID
	Dim intDelete
	Dim intQuestionID
	Dim intPageID
	Dim strAction
	Dim strPage
	Dim strError
	Dim strResponse
	Dim intBranchPageID
	Dim strRedirectPage
	Dim strItemText
	Dim intItemID
	Dim intDeleteBranchID
	Dim intLastPageNumber
	Dim intCounter
	Dim intAnswerID

	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = cint(Request.QueryString("surveyID"))
	intPageID = cint(Request.QueryString("pageID"))
	intLastPageNumber = surveyCreation_getLastPageNumber(intSurveyID)
	
	If ((survey_getOwnerID(intSurveyID) <> intUserID) _
			and intUserType = SV_USER_TYPE_CREATOR) _
			or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	

	strRedirectPage = "editSurvey.asp?surveyID=" & intSurveyID & "&pageID=" & intPageID
	
	intDeleteBranchID = Request.QueryString("deleteBranch")
	If utility_isPositiveInteger(intDeleteBranchID) Then
		strSQL = "DELETE FROM usd_branching WHERE branchID = " & intDeleteBranchID
		Call utility_executeCommand(strSQL)
	End If
	
	
	If Request.Form("submit") = "Add Branch" Then
		intQuestionID = trim(Request.Form("questionID"))
		strResponse = trim(Request.Form("response"))
		intAnswerID = trim(Request.Form("presetResponse"))
		If strResponse = "" Then
			strResponse = survey_getAnswerText(intAnswerID)
		End If
		
		If not utility_isPositiveInteger(intAnswerID) Then
			intAnswerID = 0
		End If
		
		intBranchPageID = trim(Request.Form("branchPageID"))
		
		Call surveyCreation_addBranch(intQuestionID, strResponse, intBranchPageID, intPageID, intSurveyID,intAnswerID)
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
	<p class="message"><%=strError%></p>
	<span class="breadcrumb">
		<a href="manageSurveys.asp">All Surveys</a> >>
	<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=rsResults("surveyTitle")%></a> >>
<%
	If intPageID = 0 Then
%>
		<a href="hiddenFields.asp?surveyID=<%=intSurveyID%>">Hidden Fields</a>
<%
	Else
%>
		<a href="editSurvey.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>">Edit Survey</a> 
<%
	End If
%>
	>> Page Branching
	</span><br /><br />
	<span class="surveyTitle">Branching For 
<%
	If utility_isPositiveInteger(intPageID) Then
%>
		Page <%=intPageID%>
<%
	Else
%>
		Hidden Fields
<%
	End If
%>	
	</span><%=common_helpLink("surveys/branching/general.asp",SV_SMALL_HELP_IMAGE)%><br />
<%
	End If
	
	strPage = "pageBranching.asp?surveyID=" & intSurveyID & "&pageID=" & intPageID

	rsResults.Close
	strSQL = "SELECT itemID, itemText " &_
			 "FROM usd_surveyItem " &_
			 "WHERE pageID = " & intPageID &_
			 " AND surveyID = " & intSurveyID &_
			 " AND itemType " &_
			 "In(" & SV_ITEM_TYPE_TEXTAREA & "," &_
			 SV_ITEM_TYPE_SINGLE_LINE & "," &_
			 SV_ITEM_TYPE_DATE & "," &_
			 SV_ITEM_TYPE_CHECKBOXES & "," &_
			 SV_ITEM_TYPE_RADIO & "," &_
			 SV_ITEM_TYPE_DROPDOWN & "," &_
			 SV_HIDDEN_FIELD_TYPE_QUERYSTRING & "," &_
			 SV_HIDDEN_FIELD_TYPE_COOKIE & "," &_
			 SV_HIDDEN_FIELD_TYPE_SESSION & ")"
			 rsResults.Open strSQL, DB_CONNECTION
			 If rsResults.EOF Then
%>
				<span class="message">No questions to branch off of exist in the page.</span><br /><br />
				<a href="editSurvey.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>">
					<img src="images/button-goBack.gif" alt="Go Back" border="0">
				</a>
				
<% 
			 Else
%>
<%
	If intPageID = 0 Then
%>
		<a href="hiddenFields.asp?surveyID=<%=intSurveyID%>">
<%
	Else
%>
		<a href="editSurvey.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>">
<%
	End If
%>
				<img src="images/button-save.gif" alt="Save and Continue" border="0"></a><br />
				<hr noshade color="#C0C0C0" size="2">
		<form method="post" action="<%=strPage%>" name="frmNewBranch">
		<table border="0" cellpadding="0" cellspacing="0" class="normal">
			<tr>
				<td class="normalBold-Big" width="200" valign="top">
					Add New Branching Rule
				</td>
				<td class="normalBold" valign="top">
					<%=common_helpLink("surveys/branching/questionToBranch.asp",SV_SMALL_HELP_IMAGE)%>Question to branch off of:&nbsp;&nbsp;
				</td>
				<td valign="top">
					<select name="questionID"
					onchange="javascript:updateAnswers(document.frmNewBranch.questionID.value);">
					 <option value="">Please Select</option>
<%
						Do until rsResults.EOF
							intItemID = rsResults("itemID")
							strItemText = rsResults("itemText")
							If len(trim(strItemText)) > SV_DROPDOWN_MAX_LENGTH Then
								strItemText = mid(strItemText,1,SV_DROPDOWN_MAX_LENGTH) & "..."
							End If
%>
							<option value="<%=intItemID%>"><%=strItemText%></option>
<%
							rsResults.MoveNext
						Loop
						rsResults.Close
%>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
							<td class="normalBold" valign="top">
								<%=common_helpLink("surveys/branching/response.asp",SV_SMALL_HELP_IMAGE)%>Branch if response is:&nbsp;&nbsp;
							</td>
							<td valign="top" class="normalBold">
								<select name="presetResponse">
									<option value="">Please Select</option>
								</select>
								Other:<input type="text" name="response">
							</td>
						</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td class="normalBold">
					<%=common_helpLink("surveys/branching/goToPage.asp",SV_SMALL_HELP_IMAGE)%>Go to page:&nbsp;&nbsp;
				</td>
				<td>
					<select name="branchPageID">
<%
						For intCounter = (intPageID + 1) to intLastPageNumber
%>
							<option value="<%=intCounter%>"><%=intCounter%></option>
<%
						Next
%>
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
					<input type="hidden" name="submit" value="Add Branch">
					<input type="image" src="images/button-addBranch.gif" alt="Add Branching Rule" border="0"
					onclick="javascript:return validateBranchForm();">
				</td>
			</tr>
		</table>
		</form>
		<hr noshade color="#C0C0C0" size="2">
		<table border="0" cellpadding="0" cellspacing="0" class="normal">
			<tr valign="top">
				<td class="normalBold-Big" width="200">
					Current Branching Rules
				</td>
<%
		strSQL = "SELECT itemID, response, nextPage, branchID " &_
				 "FROM usd_branching " &_
				 "WHERE currentPage = " & intPageID &_ 
				 " AND surveyID = " & intSurveyID	
		rsResults.Open strSQL, DB_CONNECTION
		If not rsResults.EOF Then
%>
			<td class="normal">
				<ul>
<%
				Do until rsResults.EOF 
%>
					<li>If answer to "<%=survey_getItemText(rsResults("itemID"))%>" equals "<%=rsResults("response")%>" then
					go to page <%=rsResults("nextPage")%>.(
					<a href="<%=strPage%>&deleteBranch=<%=rsResults("branchID")%>"
					onclick="javascript:return confirmAction('Are you sure you want to delete this branching rule?');">
						Delete</a>)
					</li>
<%
					rsResults.MoveNext
				Loop
%>
				</ul>
			</td>
<%
		Else
%>
			<td class="message">No branching rules exist.</td>
<%
		End If
%>
		</tr>
		</table>
		<script language="javascript">
			<%=survey_answersDropdownJS(intSurveyID,"frmNewBranch","presetResponse")%>
			function validateBranchForm(){
			var question = document.forms.frmNewBranch.questionID.value;
			var presetResponse = document.forms.frmNewBranch.presetResponse.value;
			var freeResponse = document.forms.frmNewBranch.response.value;
			if (question == '')
			{
				alert('Please choose a question to branch off of');
				return false;
			}
			else if (presetResponse != '' & freeResponse != '')
			{
				alert('Please choose a value from the dropdown OR a freeform answer');
				return false;
			}
			else if (presetResponse == '' & freeResponse == '')
			{
				alert('Please choose a value from the dropdown OR a freeform answer');
				return false;
			}
			}
		</script>
<%
	End If
%>				
				
	<!--#INCLUDE FILE="Include/footer_inc.asp"-->

