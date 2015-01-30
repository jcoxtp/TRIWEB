<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1

%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/editItems_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/surveyCreation_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim intSurveyID
	Dim intPageID
	Dim strSQL
	Dim rsResults
	Dim intUserID
	Dim intUserType
	Dim intItemID
	Dim boolQuestionsExist
	Dim intPipedItemID
	Dim strItemText
	Dim intCounter
	Dim arrPipes
	Dim intCurrentItemID
	Dim strMessage
	Dim strPipeSQL
		
	Call user_loginNetworkUser()
	
	'Get the user info
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = Request.QueryString("surveyID")
	intPageID = Request.QueryString("pageID")
	intItemID = Request.QueryString("itemID")
	
	If ((survey_getOwnerID(intSurveyID) <> intUserID) _
			and intUserType = SV_USER_TYPE_CREATOR) _
			or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	If Request.Form("submit") = "Submit" Then
		For intCounter = 1 to 3
			intPipedItemID = Request.Form("pipedItem" & intCounter)
			strSQL = "UPDATE usd_surveyItem SET pipedItemID" & intCounter & " = " & intPipedItemID & " WHERE itemID = " & intItemID
			Call utility_executeCommand(strSQL)
		Next
		strMessage = "Pipes Updated"
	End If
%>
	<%=header_htmlTop("white","")%>
		<table width="100%" bgcolor="<%=SV_TOP_COLOR%>"></tr><td>
		<span style="font-size: 24px; font-family: Arial; font-weight: bold; color: <%=SV_TITLE_COLOR%>">Answer Piping</span>
	</td></tr></table>
	<span class="message"><%=strMessage%>&nbsp;</span><br />

	<span class="normal">Answer piping allows you to insert a user's answer to a previous question into the question text, description, or even potential answers
	for another question.
	<form method="post" action="piping.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>&itemID=<%=intItemID%>">
		<img src="images/button-save.gif" border="0" style="cursor:hand" onclick="javascript:window.close();">
<%
		strPipeSQL = "SELECT itemID, itemText FROM usd_surveyItem WHERE surveyID = " & intSurveyID & " AND pageID < " & intPageID &_
				 " AND itemType IN(" & SV_ITEM_TYPE_RADIO & "," & SV_ITEM_TYPE_DROPDOWN & "," &_
				 SV_ITEM_TYPE_SINGLE_LINE & "," & SV_ITEM_TYPE_TEXTAREA & "," & SV_ITEM_TYPE_DATE &_
				 "," & SV_HIDDEN_FIELD_TYPE_QUERYSTRING & "," & SV_HIDDEN_FIELD_TYPE_COOKIE & "," & SV_HIDDEN_FIELD_TYPE_SESSION & ")" &_
				 " ORDER BY pageID, orderByID"	
		If utility_checkForRecords(strPipeSQL) = False Then
%>
			<span class="message">No items to pipe from</span>
<%
		Else
%>
		<hr noshade color="#C0C)C0" size="2">
		<table>
<%
		
		strSQL = "SELECT pipedItemID1, pipedItemID2, pipedItemID3 FROM usd_surveyItem WHERE itemID = " & intItemID 
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
			arrPipes = rsResults.GetRows
		End If
		For intCounter = 1 to 3
%>
			<tr><td width="100" class="normal">
<%			
			intCurrentItemID = arrPipes(intCounter - 1,0)
			If utility_isPositiveInteger(intCurrentItemID) Then
				intCurrentItemID = cint(intCurrentItemID)
			Else
				intCurrentItemID = 0
			End If
			Set rsResults = utility_getRecordset(strPipeSQL)
			If not rsResults.EOF Then
%>
				@@pipe<%=intCounter%></td><td><select name="pipedItem<%=intCounter%>"><option value="0">Please Select</option>
<%
				Do until rsResults.EOF
					intItemID = rsResults("itemID")
					strItemText = rsResults("itemText")
%>
					<option value="<%=intItemID%>"
<%
					If intCurrentItemID = intItemID Then
%>
						selected
<%
					End If
%>
					
					><%=strItemText%></option>
<%			
					rsResults.MoveNext
				Loop
%>			
				</select>
<%
			End If
			rsResults.Close
			Set rsResults = NOTHING
%>
				</td></tr>
<%
		Next
%>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table>
		<tr><td width="100">&nbsp;</td><td><input type="image" alt="Change" src="images/button-change.gif" border="0">
		<input type="hidden" name="submit" value="Submit"></td></tr>
		</table>
<%
	End If
%>	
	</form>

