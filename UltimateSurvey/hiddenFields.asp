<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1	
'****************************************************
'
' Name:		hiddenFields.asp
' Purpose:	page to manage hidden fields for a survey
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
	Dim strMessage
	Dim strQuestionText
	Dim intHiddenFieldType
	Dim strOrderBy
	Dim strOrderByDirection
	Dim strSortingURL
	Dim intMessage
	

	Call user_loginNetworkUser()

	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = Request.QueryString("surveyID")
	
	If ((survey_getOwnerID(intSurveyID) <> intUserID) _
			and intUserType = SV_USER_TYPE_CREATOR) _
			or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	intDelete = Request.QueryString("delete")
	If utility_isPositiveInteger(intDelete) Then
		Call surveyCreation_deleteItem(intSurveyID, intDelete)
		strMessage = "Hidden field deleted."
	End If
		
	intMessage = Request.QueryString("message")
	If utility_isPositiveInteger(intMessage) Then
		Select Case cint(intMessage)
			Case SV_MESSAGE_HIDDEN_FIELD_ADDED
				strMessage = "Hidden field added."
		End Select
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
		Response.redirect("index.asp?message=" & SV_MESSAGE_UNKNOWN_ERROR)
	
	Else
		intSurveyType = rsResults("surveyType")
		strSurveyTitle = rsResults("surveyTitle")
	End If
	rsResults.Close
	Set rsResults = NOTHING
	
	strSortingURL = "hiddenFields.asp?surveyID=" & intSurveyID
	
	strOrderBy = Request.QueryString("orderBy")
	strOrderByDirection = Request.QueryString("orderByDirection")
	
	If len(strOrderBy) = 0 Then
		strOrderBy = "itemText"
	End If
	
	If len(strOrderByDirection) = 0 Then
		strOrderByDirection = "ASC"
	End If
%> 

	<span class="breadcrumb" align="left">
	<a href="manageSurveys.asp">All Surveys</a> >>
	<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=strSurveyTitle%></a> >>
	Hidden Fields
	</span><br /><br />
	<span class="surveyTitle">Manage Hidden Fields</span><%=common_helpLink("surveys/hiddenFields.asp",SV_SMALL_HELP_IMAGE)%><br />
<%
	If len(strMessage) > 0 Then
%>	
		<br /><span class="message"><%=strMessage%></span><br />
<%
	End If
%>	
	<br />
	<span class="normal">Hidden fields allow you to record information pertaining to the survey response without directly asking the user.  This 
	information can come from the query string, cookies, or the session.</span><br /><br />
		<a class="normalBold" href="editHiddenField.asp?surveyID=<%=intSurveyID%>">
			<img src="images/button-addHiddenField.gif" alt="Add Hidden Field" border="0"></a>
		<a class="normalBold" href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>">
			<img src="images/button-save.gif" alt="Save and Continue" border="0"></a>&nbsp;
		<a class="normalBold" href="pageBranching.asp?surveyID=<%=intSurveyID%>&pageID=0">
			<img src="images/button-branching.gif" alt="Branching" border="0"></a>

	<table border="1" cellpadding="2" bordercolor="#CCCCCC" cellspacing="0" width="100%" ID="Table1">
		<tr bgcolor="black" class="tableHeader">
			<td valign="middle" class="gridheader" width="400">
				<%=common_orderByLinks("Question Text", strOrderBy, strOrderByDirection, strSortingURL, "itemText")%>
			</td>
			<td valign="middle" class="gridheader" width="100">
				<%=common_orderByLinks("Field Type", strOrderBy, strOrderByDirection, strSortingURL, "itemType")%>
			</td>
			<td valign="middle" class="gridheader">
				<%=common_orderByLinks("Variable Name", strOrderBy, strOrderByDirection, strSortingURL, "variableName")%>
			</td>
			<td valign="middle" class="gridheader" width="114">
				Actions
			</td>
		</tr>
	
			
<%
	strSQL = "SELECT itemID, itemText, itemType, variableName FROM usd_surveyItem WHERE surveyID = " & intSurveyID & " AND pageID = 0 " &_
			 "ORDER BY " 
			 
		
	If strOrderBy = "itemText" and DATABASE_TYPE = "SQLServer" Then
		strSQL =  strSQL & "cast(itemText as varchar(255))"
	Else
		strSQL = strSQL & strOrderBy
	End If
	
	strSQL = strSQL & " " & strOrderByDirection
	
	Set rsResults = utility_getRecordset(strSQL)
	
	If rsResults.EOF Then
	
%>
			<%=common_tableRow(0)%>
				<td class="message" colspan="4">No hidden fields found...</td>
			</tr>
<%
	Else
		Dim intItemID
		Dim strItemText
		Dim intItemType
		Dim strItemType
		Dim strVariableName
		Dim intCounter
		
		Do until rsResults.EOF
			intCounter = intCounter + 1
			
			intItemID = rsResults("itemID")
			strItemText = rsResults("itemText")
			intItemType = rsResults("itemType")
			strVariableName = rsResults("variableName")
			
			Select Case intItemType	
				Case SV_HIDDEN_FIELD_TYPE_QUERYSTRING
					strItemType = "Query String"
				Case SV_HIDDEN_FIELD_TYPE_COOKIE 
					strItemType = "Cookie"
				Case SV_HIDDEN_FIELD_TYPE_SESSION
					strItemType = "Session"
			End Select
%>
			<%=common_tableRow(intCounter)%>
				<td width="400" class="griddata">
					<%=strItemText%>
				</td>
				<td width="100" class="griddata">
					<%=strItemType%>
				</td>
				<td class="griddata">
					<%=strVariableName%>
				</td>
				<td width="114">
					<a href="editHiddenField.asp?surveyID=<%=intSurveyID%>&hiddenFieldID=<%=intItemID%>"><img src="images/button-edit.gif" alt="Delete" border="0" height="17" width="45" vspace="0"></a>
					<a href="hiddenFields.asp?surveyID=<%=intSurveyID%>&delete=<%=intItemID%>"
						onclick="return confirmAction('Are you sure you want to delete this hidden field?');"
						><img src="images/button-surveydelete.gif" alt="Delete" border="0" height="17" width="55" vspace="0"></a>
				</td>
			</tr>
<%		
			rsResults.MoveNext
		Loop
%>
	
<%
	End If	
	rsResults.Close
	Set rsResults = NOTHING
%>
	</table>
	<!--#INCLUDE FILE="Include/footer_inc.asp"-->

