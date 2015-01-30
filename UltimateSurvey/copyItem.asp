<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		copyItem.asp 
' Purpose:	page to copy an item
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
<!--#INCLUDE FILE="Include/copy_inc.asp"-->
<!--#INCLUDE FILE="Include/copyItem_inc.asp"-->
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
	Dim intPageID
	Dim intCounter
	Dim intLastPageNumber
	Dim strGUID
	Dim intNewItemID
	Dim strItemText
	Dim strItemDescription
	Dim strDefaultValue
	Dim strAnswerText
	Dim strCategory
	Dim strCategoryAlias
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	'get necessary values from page request
	intSurveyID = cint(Request.QueryString("surveyID"))
	intItemID = Request.QueryString("itemID")
	intPageID = cint(Request.QueryString("pageID"))
	
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
	If Request.QueryString("copy") = "true"  Then
		
		Dim boolCopyConditions
		
		If Request.QueryString("copyConditions") = "on" Then
			boolCopyConditions = True
		Else
			boolCopyConditions = False
		End If
		
		
		Call copyItem_copyItem(intItemID, intSurveyID, intPageID, boolCopyConditions, 0)
		
		Call surveyCreation_updatePages(intSurveyID)
		Response.Redirect("editSurvey.asp?surveyID=" & intSurveyID & "&pageID=" & intPageID)
	End If

	
	'get information on this survey
	strSQL = "SELECT surveyType, surveyTitle, surveyDescription " &_
			 "FROM usd_Survey " &_
			 "WHERE surveyID = " & intSurveyID
	
	Set rsResults = utility_getRecordset(strSQL)
	If rsResults.EOF Then

		Response.Redirect("index.asp?message=" & SV_MESSAGE_UNKNOWN_ERROR)

	End If
%> 
	<%=header_htmlTop("white","")%>
	<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
	<span class="breadcrumb" align="left">
	<a href="manageSurveys.asp">All Surveys</a> >>
	<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=survey_getSurveyTitle(intSurveyID)%></a> >>
	<a href="editSurvey.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>">Edit Survey</a> >>
	Copy Item
	</span><br /><br />
<%
	rsResults.Close
	
	intLastPageNumber = surveyCreation_getLastPageNumber(intSurveyID)
%>
	<span class="surveyTitle">Copy Item</span><br />
	<hr noshade color="#C0C0C0" size="2">
	<p class="normal">Item will initially be added to the bottom of the page.  You can use the up and down arrows to move
	the item within the page.
	<form method="get" action="copyItem.asp">
		<input type="hidden" name="copy" value="true">
		<input type="hidden" name="itemID" value="<%=intItemID%>">
		<input type="hidden" name="surveyID" value="<%=intSurveyID%>">
		<table width="100%" border="0" cellpadding="0">
			<tr>
				<td class="normalBold-Big" width="200">
					Copy to Page:
				</td>
				<td>
					<select name="pageID">
<%
					For intCounter = 1 to intLastPageNumber
%>
						<option value="<%=intCounter%>"
<%
						If intCounter = intPageID Then
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
				</td>
			</tr>
<%
		If surveyCreation_isConditional(intItemID) Then
%>
			<tr>
				<td>
					&nbsp;
				</td>
				<td class="normalBold">
					Copy Conditions:
				</td>
				<td> 
					<input type="checkbox" name="copyConditions">
				</td>
			</tr>
<%
		End If
%>
					
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td width="200">
					&nbsp;
				</td>
				<td>
					<input type="hidden" value="Copy Item">
					<input type="image" src="images/button-copyItem.gif" alt="Copy Item" border="0">
				</td>
			</tr>
		</table>
	</form>
	<hr noshade color="#C0C0C0" size="2">
	<span class="normalBold-Big">Item to Copy:</span><br />
<%
	
	strSQL = "SELECT itemText, itemType " &_
				 "FROM usd_SurveyItem " &_
				 "WHERE itemID = " & intItemID
				 
	rsResults.Open strSQL, DB_CONNECTION	
	
	'display entire question
	'display entire question
		Select Case rsResults("itemType")
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
				2, "", "arial",0,False,"",0)
			Case SV_ITEM_TYPE_SINGLE_LINE
				Call itemDisplay_displaySingleLine(intItemID,0,False, 4, "", _
				2, "", "arial",0,False,"",0)
			Case SV_ITEM_TYPE_DATE
				Call itemDisplay_displayDate(intItemID,0,False, 4, "", _
				2, "", "arial",0,False,"",0)
			Case SV_ITEM_TYPE_CHECKBOXES
				Call itemDisplay_displayCheckboxes(intItemID, "",0,False, 4, "", _
				2, "", 2, "", "arial",0,False,0)
			Case SV_ITEM_TYPE_RADIO
				Call itemDisplay_displayRadio(intItemID,0,False, 4, "", _
				2, "", 2, "", "arial",0,False,"",0)
			Case SV_ITEM_TYPE_DROPDOWN
				Call itemDisplay_displayDropdown(intItemID,0,False, 4, "", _
				2, "", "arial",0,False,"",0)
			Case SV_ITEM_TYPE_MATRIX
				Call itemDisplay_displayMatrix(intItemID, "",0,False, 4, "", _
				2, "", 2, "", "arial",0,False,False,"gray","","",0,0)
		End Select
	
	rsResults.Close
	Set rsResults = NOTHING
%>	
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

