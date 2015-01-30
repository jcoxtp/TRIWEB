<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		editSurvey.asp 
' Purpose:	page to edit survey and organize items
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/itemDisplay_inc.asp"-->
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
	Dim intSurveyType 
	Dim intSurveyID
	Dim boolIsActive
	Dim intDelete
	Dim intMoveItem
	Dim intDirection
	Dim intPageID
	Dim boolActive
	Dim intAction
	Dim intMessage
	Dim strMessage
	Dim intPagingPage
	Dim intMovePageID
	Dim intTemplateID
	
	Call user_loginNetworkUser()
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = cint(Request.QueryString("surveyID"))
	intPageID = Request.QueryString("pageID")
	
	If intUserType = "" Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	Else
		If ((survey_getOwnerID(intSurveyID) <> intUserID) _
				and intUserType = SV_USER_TYPE_CREATOR) _
				or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
			Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
		End If

	End If
	

	If not utility_isPositiveInteger(intPageID) Then
			intPageID = 1
	End If

	intMessage = cint(Request.QueryString("message"))
	Select Case intMessage
		Case SV_MESSAGE_USERS_INVITED
			strMessage = "Users successfully invited."
		Case SV_MESSAGE_ITEM_EDITED
			strMessage = "Item successfully edited."
		Case SV_MESSAGE_PROPERTIES_EDITED
			strMessage = "Survey properties successfully edited."
		Case SV_MESSAGE_CONDITIONS_UNAVAILABLE
			strMessage = "In order to create conditions, you must have at least one answerable question in a previous page."
	End Select

	intDelete = Request.QueryString("delete")
	If utility_isPositiveInteger(intDelete) Then
		Call surveyCreation_deleteItem(intSurveyID, intDelete)
		Call surveyCreation_updatePages(intSurveyID)
		strSQL = "SELECT distinct(itemID) FROM usd_surveyItem WHERE surveyID = " & intSurveyID & " AND pageID = " & intPageID
		If not utility_checkForRecords(strSQL) Then Response.Redirect("editSurvey.asp?surveyID=" & intSurveyID & "&pageID=" & (intPageID - 1))
	End If
	
	boolActive = Request.QueryString("active")
	If boolActive <> "" Then
		Call surveyCreation_changeActiveStatus(intSurveyID, cbool(boolActive))
	End If
	
	intMoveItem = cint(Request.QueryString("moveItem"))
	If utility_isPositiveInteger(intMoveItem) Then
		intDirection = cint(Request.QueryString("direction"))
		intMovePageID = Request.QueryString("pageID")
		Call surveyCreation_moveItem(intMoveItem, intDirection, intMovePageID, intSurveyID)
	End If
	
	intAction = cint(Request.QueryString("action"))
	Select Case intAction
		Case SV_ACTION_CLEAR_RESULTS
			Call survey_clearResults(intSurveyID)
	End Select
	
	strSQL = "SELECT surveyType, surveyTitle, surveyDescription, isActive, templateID " &_
			 "FROM usd_Survey " &_
			 "WHERE surveyID = " & intSurveyID
	
	Set rsResults = utility_getRecordset(strSQL)
	If rsResults.EOF Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_UNKNOWN_ERROR)
	End If
		intSurveyType = rsResults("surveyType")
		

	Call surveyCreation_updatePages(intSurveyID)
%>
		<%=header_htmlTop("white","")%>
		<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
	<span class="breadcrumb" align="left">
	<a href="manageSurveys.asp">All Surveys</a> >>
	<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=survey_getSurveyTitle(intSurveyID)%></a> >>
	Edit Survey</a>
	</span><br /><br />
		<p class="surveyTitle">
			Edit Survey - Page <%=intPageID%> <%=common_helpLink("surveys/editSurvey/general.asp",SV_SMALL_HELP_IMAGE)%></p>
<%
		If strMessage <> "" Then
%>
			<span class="message"><%=strMessage%></span>
<%
		End If
		intTemplateID = rsResults("templateID")
		rsResults.Close
		IF SV_PAGE_VIEW_SURVEY = True Then
			strSQL = "SELECT distinct(pageID) " &_
					 "FROM usd_surveyItem " &_
					 "WHERE surveyID = " & intSurveyID &_
					 " AND pageID <> 0"
			rsResults.Open strSQL, DB_CONNECTION
			If rsResults.EOF Then
				Response.Redirect("addItem.asp?surveyID=" & intSurveyID & "&message=" & SV_MESSAGE_NO_ITEMS)
			Else
%>
				<form method="get" action="editSurvey.asp">
					<input type="hidden" name="surveyID" value="<%=intSurveyID%>">
					<select name="pageID">
<%
				Do until rsResults.EOF
					intPagingPage = rsResults("pageID")
%>	
					<option value="<%=intPagingPage%>" 
<%			
					If intPagingPage = cint(intPageID) Then
%>
						selected
<%
					End If
%>
						><%=intPagingPage%></option>
<%					
					rsResults.MoveNext
				Loop
%>
				</select>
				<input type="hidden" name="submit" value="Go To Page">
				<input type="image" src="images/button-goToPage.gif" alt="Go To Page" border="0">
				<a href="addItem.asp?surveyID=<%=intSurveyID%>">
				<img border="0" src="images/button-page.gif" alt="Add Item To Page" hspace="15"></a></p>
<%
				If intPageID = 1 and survey_hasHiddenFields(intSurveyID) = False Then
%>
					<span class="message">Conditions are not available on page 1 unless you have hidden fields in your survey.</span>
<%
				End If
%>		
				</form>
<%
			End If
			rsResults.Close
		End If
		
		IF SV_PAGE_VIEW_SURVEY = True Then
%>
		<%=surveyCreation_displayItems(intSurveyID, intPageID, intTemplateID)%>
<%
		Else 
%>
		<%=surveyCreation_displayItems(intSurveyID, "", intTemplateID)%>
<%
	End If
%>
		</form>
		<p><a href="addItem.asp?surveyID=<%=intSurveyID%>">
			<img border="0" src="images/button-page.gif" alt="Add Item To Page" hspace="15"></a></p>
<%
	Set rsResults = NOTHING
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

