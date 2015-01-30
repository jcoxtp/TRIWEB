<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1	
'****************************************************
'
' Name:		scoringMessages.asp
' Purpose:	page to add/remove scoring messages for a survey
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
	Dim intLowPoints
	Dim intHighPoints
	Dim strMessage
	Dim strError
	Dim intCounter
	Dim intMessageID
	Dim intDeleteMessageID

	'Get the user info out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)

	intSurveyID = cint(Request.QueryString("surveyID"))
	
	If ((survey_getOwnerID(intSurveyID) <> intUserID) _
			and intUserType = SV_USER_TYPE_CREATOR) _
			or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	

	intDeleteMessageID = request.QueryString("deleteMessageID")
	If utility_isPositiveInteger(intDeleteMessageID) Then
		strSQL = "DELETE FROM usd_scoringMessages WHERE messageID = " & intDeleteMessageID
		Call utility_executeCommand(strSQL)
	End If
	
	If Request.Form("submit") = "Add Message" Then
		strMessage = trim(Request.Form("message"))
		intLowPoints = Request.Form("lowPoints")
		intHighPoints = Request.Form("highPoints")
		If strMessage = "" Then
			strError = strError & "You must specify a message.<br />"
		End If
		
		If not isNumeric(intLowPoints) Then
			strError = strError & "Low point value must be an integer.<br />"
		ElseIf intLowPoints < 0 Then
			strError = strError & "Low point value must be an integer.<br />"
		End If
		
		If not isNumeric(intHighPoints) Then
			strError = strError & "High point value must be an integer.<br />"
		ElseIf intHighPoints < 0 Then
			strError = strError & "High point value must be an integer.<br />"
		End If
		
		If strError = "" Then
			strSQL = "INSERT INTO usd_scoringMessages " &_
					 "(surveyID, lowPoints, highPoints, message) " &_
					 "VALUES(" & intSurveyID & "," & intLowPoints & "," & intHighPoints & "," &_
					 utility_SQLEncode(strMessage,True) & ")"
			Call utility_executeCommand(strSQL)
			intLowPoints = ""
			intHighPoints = ""
			strMessage = ""
		End If
		
		
	End If
	
	strSQL = "SELECT surveyType, surveyTitle " &_
			 "FROM usd_Survey " &_
			 "WHERE surveyID = " & intSurveyID
	
	Set rsResults = utility_getRecordset(strSQL)
	If rsResults.EOF Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_UNKNOWN_ERROR)
	End If
	intSurveyType = rsResults("surveyType")
	strSurveyTitle = rsResults("surveyTitle")

%>
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
	
	<span class="normalBold" align="left">
	<span class="breadcrumb" align="left">
	<a href="manageSurveys.asp">All Surveys</a> >>
	<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=survey_getSurveyTitle(intSurveyID)%></a> >>
	Scoring Messages</span><br /><br />
<span class="surveyTitle">Set Scoring Messages</span>
<br /><span class="normal">Scoring messages are used in conjunction with scored surveys to display a message to the user
	based on their final score on the survey.</span>
		
	<p>
		<a class="normalBold" href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>">
			<img src="images/button-save.gif" alt="Save" border="0">
		</a>
	</p>
<%
	If len(strError) > 0 Then
%>
		<br /><span class="message"><%=strError%></span>
<%
	End If
%>

	<form method="post" action="scoringMessages.asp?surveyID=<%=intSurveyID%>">
		<hr noshade color="#C0C0C0" size="2">
		<table width="100%" border="0" cellpadding="0">
			<tr>
				<td class="normalBold-Big" width="200">
					Add Scoring Message
				</td>
				<td class="normalBold">
					Min Points
				</td>
				<td>
					<input type="text" name="lowPoints" size="4" value="<%=intLowPoints%>">
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td class="normalBold">
					Max Points
				</td>
				<td>
					<input type="text" name="highPoints" size="4" value="<%=intHighPoints%>">
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td class="normalBold">
					Message
				</td>
				<td>
					<textarea name="message" rows="5" cols="80"><%=strMessage%></textarea>
				</td>
			</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table width="100%" border="0" cellpadding="0">
			<tr>
				<td width="200">
					&nbsp;
				</td>
				<td>
					<input type="image" src="images/button-addMessage.gif" alt="Add Message" border="0">
					<input type="hidden" name="submit" value="Add Message">
				</td>
			</tr>
		</table>
		</form>
		<table width="100%" border="0" cellpadding="0">
			<tr>
				<td class="normalBold-Big" colspan="2">
					Current Messages<br>
					<hr noshade color="#C0C0C0" size="2">
				</td>
			</tr>
		</table>
<%
		strSQL = "SELECT messageID, lowPoints, highPoints, message " &_
				 "FROM usd_scoringMessages " &_
				 "WHERE surveyID = " & intSurveyID &_
				 " ORDER BY lowPoints, highPoints"
		Set rsResults = utility_getRecordset(strSQL)
%>
	
		<%=common_basicTableTag()%>
			<tr bgcolor="black" class="tableHeader">
				<td class="gridheader" align="middle">
					Min Points
				</td>
				<td class="gridheader" align="middle">
					Max Points
				</td>
				<td class="gridheader" align="middle">
					Message
				</td>
				<td class="gridheader" align="middle" width="50">
					&nbsp;
				</td>
			</tr>
<%
			If rsResults.EOF Then
%>
			<%=common_tableRow(0)%>
			<td class="message" colspan="4">No messages found...</td>
			</tr></table>
<%
			Else
			
			intCounter = 0
			Do until rsResults.EOF
				intCounter = intCounter + 1
				intMessageID = rsResults("messageID")
				intLowPoints = rsResults("lowPoints")
				intHighPoints = rsResults("highPoints")
				strMessage = rsResults("message")
				
%>
				<%=common_tableRow(intCounter)%>
					<td class="griddata" align="middle">
						<%=intLowPoints%>
					</td>
					<td class="griddata" align="middle">
						<%=intHighPoints%>
					</td>
					<td class="griddata" align="middle">
						<%=strMessage%>
					</td>
					<td class="griddata" align="middle">
						<a href="scoringMessages.asp?surveyID=<%=intSurveyID%>&deleteMessageID=<%=intMessageID%>"
							onclick="javascript:return confirmAction('Are you sure you want to delete this message?');">
							<img src="images/button-delete-small.gif" alt="Delete" border="0" width="45" height="17"></a>
					</td>
				</tr>
<%
				rsResults.MoveNext
			Loop
%>
				</table>


<%
		End If
%>
	<!--#INCLUDE FILE="Include/footer_inc.asp"-->

