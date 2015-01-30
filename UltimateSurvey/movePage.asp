<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		movePage.asp 
' Purpose:	page to move an entire page of items
'
'
' Author:	    Ultimate Software Designs
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
	Dim intSurveyID
	Dim intItemID
	Dim intNewPageID
	Dim intOldPageID
	Dim intCounter
	Dim intLastPageNumber
	Dim strItemIDS

	Call user_loginNetworkUser()

	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	
	'get necessary values from page request
	intSurveyID = cint(Request.QueryString("surveyID"))
	intItemID = Request.QueryString("itemID")
	intOldPageID = cint(Request.QueryString("pageID"))
	
	intNewPageID = Request.QueryString("newPageID")
	
	'if for any reason a valid item was not specified
	If not  utility_isPositiveInteger(intOldPageID) Then
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
	

	intLastPageNumber = surveyCreation_getLastPageNumber(intSurveyID)

	'conditions cannot be added to first page of a survey
	If utility_isPositiveInteger(intNewPageID)  Then
		If cint(intNewPageID) <> intOldPageID Then
			strItemIDs = Request.QueryString("itemIDs")			
		
			If Request.QueryString("moveLocation") = "before" Then
				strSQL = "UPDATE usd_surveyItem " &_
						 "SET pageID = pageID + 1 " &_
						 " WHERE pageID >= " & intNewPageID &_
						 " AND pageID < " & intOldPageID &_
						 " AND surveyID = " & intSurveyID
				Call utility_executeCommand(strSQL)
				strSQL = "UPDATE usd_surveyItem " &_
						 "SET pageID = " & intNewPageID &_
						 " WHERE itemID IN(" & strItemIDs & ")"
				Call utility_executeCommand(strSQL)
				
				strSQL = "UPDATE usd_conditionMapping " &_
						 "SET pageID = " & intNewPageID &_
						 " WHERE pageID = " & intOldPageID &_
						 " AND surveyID = " & intSurveyID
				Call utility_executeCommand(strSQL)
				
			Else
				If cint(intNewPageID) = intLastPageNumber Then
					strSQL = "UPDATE usd_surveyItem " &_
							 "SET pageID = pageID - 1 " &_
							 "WHERE pageID = " & intNewPageID
					Call utility_executeCommand(strSQL)
					strSQL = "UPDATE usd_surveyItem " &_
							 "SET pageID = " & intNewPageID &_
							 " WHERE itemID IN(" & strItemIDs & ")"
					Call utility_executeCommand(strSQL)
					
					strSQL = "UPDATE usd_conditionMapping " &_
						 "SET pageID = " & intNewPageID &_
						 " WHERE pageID = " & intOldPageID &_
						 " AND surveyID = " & intSurveyID
					Call utility_executeCommand(strSQL)
				ElseIf intOldPageID = 1 Then
					strSQL = "UPDATE usd_surveyItem " &_
							 "SET pageID = pageID + 1 " &_
							 "WHERE pageID > 1"
							 Response.End
					Call utility_executeCommand(strSQL)
					strSQL = "UPDATE usd_surveyItem " &_
							 "SET pageID = 2 " &_
							 "WHERE itemID IN(" & strItemIDs & ")"
					Call utility_executeCommand(strSQL)
				
					strSQL = "UPDATE usd_conditionMapping " &_
						 "SET pageID = 2 " &_
						 " WHERE pageID = " & intOldPageID &_
						 " AND surveyID = " & intSurveyID
					Call utility_executeCommand(strSQL)
					
				ElseIf intOldPageID < intNewPageID Then
					strSQL = "UPDATE usd_surveyItem " &_
							 "SET pageID = pageID + 1 " &_
							 "WHERE pageID > " & intNewPageID

					Call utility_executeCommand(strSQL)
					strSQL = "UPDATE usd_surveyItem " &_
							 "SET pageID = " & intNewPageID + 1 &_
							 " WHERE itemID IN(" & strItemIDs & ")"
					Call utility_executeCommand(strSQL)


					strSQL = "UPDATE usd_conditionMapping " &_
						 "SET pageID = " & intNewPageID + 1 &_
						 " WHERE pageID = " & intOldPageID &_
						 " AND surveyID = " & intSurveyID
					Call utility_executeCommand(strSQL)

				ElseIf intOldPageID <> intNewPageID Then
					strSQL = "UPDATE usd_surveyItem " &_
							 "SET pageID = pageID + 1 " &_
							 " WHERE pageID > " & intNewPageID &_
							 " AND surveyID = " & intSurveyID
					Call utility_executeCommand(strSQL)
					strSQL = "UPDATE usd_surveyItem " &_
							 "SET pageID = " & intNewPageID + 1 &_
							 " WHERE itemID IN(" & strItemIDs & ")"
					Call utility_executeCommand(strSQL)
					intNewPageID = intNewPageID + 1
					
					strSQL = "UPDATE usd_conditionMapping " &_
						 "SET pageID = " & intNewPageID + 1 &_
						 " WHERE pageID = " & intOldPageID &_
						 " AND surveyID = " & intSurveyID
					Call utility_executeCommand(strSQL)
				End If
			End If		
		End If
		
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
	<a href="editSurvey.asp?surveyID=<%=intSurveyID%>">Edit Survey</a> >>
	Move Page
	</span><br /><br />
<%

	rsResults.Close
	
	strSQL = "SELECT itemID " &_
			 "FROM usd_surveyItem " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " AND pageID = " & intOldPageID
	rsResults.Open strSQL, DB_CONNECTION
	
	If not rsResults.EOF Then
		Do until rsResults.EOF
			If strItemIDs <> "" Then
				strItemIDs = strItemIDs & ","
			End If
			strItemIDs = strItemIDs & rsResults("itemID")
			rsResults.MoveNext
		Loop
	End If
	
	Set rsResults = NOTHING
	
	
%>
	<span class="surveyTitle">Move Page <%=intOldPageID%></span>
	<hr noshade color="#C0C0C0" size="2">
	<p class="normal">Please select a page to move this page before or after.  For example, if you choose to move page 4 before
	page 2, page 4 becomes page 2 and page 2 becomes page 3, and so on.</p>
	<form method="get" action="movePage.asp">
		<input type="hidden" name="surveyID" value="<%=intSurveyID%>">
		<input type="hidden" name="pageID" value="<%=intOldPageID%>">
		<input type="hidden" name="itemIDs" value="<%=strItemIDs%>">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td class="normalBold-Big" width="100">
					Location
				</td>
				<td class="normalBold">
					Before
				</td>
				<td>
					<input type="radio" name="moveLocation" value="before" checked></input>
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td class="normalBold">
					After
				</td>
				<td>
					<input type="radio" name="moveLocation" value="after"></input>
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td class="normalBold">Page: </td>
				<td>
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
					</select>
				</td>
			</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td width="100">
					&nbsp;
				</td>
				<td>
					<input type="hidden" value="Move Page">
					<input type="image" src="images/button-movePage.gif" alt="Move Page">
				</td>
			</tr>
		</table>
		

<!--#INCLUDE FILE="Include/footer_inc.asp"-->

