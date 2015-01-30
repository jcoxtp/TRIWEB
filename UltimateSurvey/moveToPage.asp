<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		moveToPage.asp 
' Purpose:	page to move an item to another page within a survey
'
'
' Author:	    Ultimate Software Designs
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
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim intUserType
	Dim intUserID
	Dim strSQL
	Dim rsResults
	Dim strSurveyTitle
	Dim strDescription
	Dim intSurveyID
	Dim intItemID
	Dim intNewPageID
	Dim intNewOrderByID
	Dim intOldPageID
	Dim intOldOrderByID
	Dim intCounter
	Dim intLastPageNumber
	Dim intItemType
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	
	'get necessary values from page request
	intSurveyID = cint(Request.QueryString("surveyID"))
	intItemID = Request.QueryString("itemID")
	intOldPageID = Cint(Request.QueryString("pageID"))
	intOldOrderByID = Request.QueryString("orderByID")
	
	intNewPageID = Request.QueryString("newPageID")
	
	'if for any reason a valid item was not specified
	If not  utility_isPositiveInteger(intItemID) Then
		'redirect to index page with error message
		Response.Redirect("index.asp?message=" & SV_MESSAGE_UNKNOWN_ERROR)
	End If
	
	'check user's credentials
	If ((survey_getOwnerID(intSurveyID) <> intUserID) _
			and intUserType = SV_USER_TYPE_CREATOR) _
			or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	'extend user cookie
	

	'conditions cannot be added to first page of a survey
	If utility_isPositiveInteger(intNewPageID)  Then
		intNewOrderByID = surveyCreation_getNextOrderByID(intSurveyID, intNewPageID)
		strSQL = "UPDATE usd_surveyItem " &_
				 "SET pageID = " & intNewPageID &_
				 ",orderByID = " & intNewOrderByID &_
				 " WHERE itemID = " & intItemID
		Call utility_executeCommand(strSQL)
		strSQL = "UPDATE usd_surveyItem " &_
				 "SET orderByID = orderByID - 1 " &_
				 " WHERE pageID = " & intOldPageID &_
				 " AND surveyID = " & intSurveyID &_
				 " AND orderByID > " & intOldOrderByID
		Call utility_executeCommand(strSQL)	 
		Call surveyCreation_updatePages(intSurveyID)
		Response.Redirect("editSurvey.asp?surveyID=" & intSurveyID & "&pageID=" & intNewPageID)
	End If

	
	'get information on this survey
	strSQL = "SELECT surveyType, surveyTitle, surveyDescription " &_
			 "FROM usd_Survey " &_
			 "WHERE surveyID = " & intSurveyID
	
	Set rsResults = utility_getRecordset(strSQL)

	If rsResults.EOF Then
%>
		Response.Redirect("index.asp?message=" & SV_MESSAGE_UNKNOWN_ERROR)
<%
	End If
%> 
	<%=header_htmlTop("white","")%>
	<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
<span class="breadcrumb" align="left">
	<a href="manageSurveys.asp">All Surveys</a> >>
	<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=rsResults("surveyTitle")%></a> >>
	<a href="editSurvey.asp?surveyID=<%=intSurveyID%>&pageID=<%=intOldPageID%>">Edit Survey</a> >>
	Move Item To Page
	</span><br /><br />
<%
	rsResults.Close
	
	intLastPageNumber = surveyCreation_getLastPageNumber(intSurveyID)
%>
	<span class="surveyTitle">Move Item to Other Page</span>
	<hr noshade color="#C0C0C0" size="2">
	<p class="normal">Item will initially be added to the bottom of the page.  You can use the up and down arrows to move
	the item within the page.
	<form method="get" action="moveToPage.asp">
		<input type="hidden" name="surveyID" value="<%=intSurveyID%>">
		<input type="hidden" name="itemID" value="<%=intItemID%>">
		<input type="hidden" name="pageID" value="<%=intOldPageID%>">
		<input type="hidden" name="orderByID" value="<%=intOldOrderByID%>">	
		<span class="normalBold">Page: </span>
		<select name="newPageID">
<%
		For intCounter = 1 to intLastPageNumber
%>
			<option value="<%=intCounter%>"
<%
			If intCounter = intOldPageID Then
%>
				selected
<%
			End If
%>
			><%=intCounter%></option>
<%
		Next
%>
		
			<option value="<%=intCounter%>">New Page</option>
		</select>
		<input type="hidden" value="Change Page">
		<input type="image" src="images/button-moveToPage.gif" alt="Move To Page">
	</form>
	<hr noshade color="#C0C0C0" size="2">
	<span class="normalBold">Item to Move:</span>
<%
	
	strSQL = "SELECT itemText, itemType " &_
				 "FROM usd_SurveyItem " &_
				 "WHERE itemID = " & intItemID
				 
	rsResults.Open strSQL, DB_CONNECTION	
	
	intItemType = rsResults("itemType")
	
	'display entire question
		Select Case intItemType
			Case SV_ITEM_TYPE_HEADER
				Call itemDisplay_displayHeader(intItemID)
			Case SV_ITEM_TYPE_MESSAGE
				Call itemDisplay_displayMessage(intItemID)
			Case SV_ITEM_TYPE_IMAGE
				Call itemDisplay_displayImage(intItemID)
			Case SV_ITEM_TYPE_LINE
				Call itemDisplay_displayLine()
			Case SV_ITEM_TYPE_HTML
				Call itemDisplay_displayHTML(intItemID)
			Case SV_ITEM_TYPE_TEXTAREA
				Call itemDisplay_displayTextArea(intItemID,0,False, 4, "", _
				2, "", "arial",0,False,"","")
			Case SV_ITEM_TYPE_SINGLE_LINE
				Call itemDisplay_displaySingleLine(intItemID,0,False, 4, "", _
				2, "", "arial",0,False,"","")
			Case SV_ITEM_TYPE_DATE
				Call itemDisplay_displayDate(intItemID,0,False, 4, "", _
				2, "", "arial",0,False,"","")
			Case SV_ITEM_TYPE_CHECKBOXES
				Call itemDisplay_displayCheckboxes(intItemID, "",0,False, 4, "", _
				2, "", 2, "", "arial",0,False,"")
			Case SV_ITEM_TYPE_RADIO
				Call itemDisplay_displayRadio(intItemID,0,False, 4, "", _
				2, "", 2, "", "arial",0,False,"","")
			Case SV_ITEM_TYPE_DROPDOWN
				Call itemDisplay_displayDropdown(intItemID,0,False, 4, "", _
				2, "", "arial",0,False,0,"")
			Case SV_ITEM_TYPE_MATRIX
				Call itemDisplay_displayMatrix(intItemID, "",0,False, 4, "", _
				2, "", 2, "", "arial",0,False,False,"","","",0,"")
		End Select
	
	rsResults.Close
	Set rsResults = NOTHING
%>	
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

