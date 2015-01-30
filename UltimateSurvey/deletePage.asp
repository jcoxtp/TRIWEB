<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		deletePage.asp 
' Purpose:	copies an entire page of a survey
'
'
' Author:	    Ultimate Software Designs
' Date Written:	10/31/2002
' Modified:		
'
' Changes:
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/surveyCreation_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim strSQL
	Dim rsResults 
	Dim intAnswerID
	Dim strAnswerText
	Dim intPoints
	Dim strItemText
	Dim strItemDescription
	Dim strDefaultValue
	Dim intItemID
	Dim rsItems
	Dim strGUID
	Dim intNewItemID
	Dim intNewConditionID
	Dim rsConditions
	Dim intConditionID
	Dim intPageID
	Dim intConditionGroupID
	Dim intItemDifferential	
	Dim intSurveyID
	Dim intLastPageNumber
	Dim intNewPageNumber	

	
	
	intSurveyID = Request.QueryString("surveyID")
	intPageID = Request.QueryString("pageID")
	intLastPageNumber = surveyCreation_getLastPageNumber(intSurveyID)
	intNewPageNumber = intLastPageNumber + 1
	
	strSQL = "DELETE FROM usd_conditionMapping " &_
			 "WHERE pageID = " & intPageID	& " AND surveyID = " & intSurveyID
	Call utility_executeCommand(strSQL)
	
	
	strSQL = "SELECT itemID " &_
			 "FROM usd_surveyItem WHERE surveyID = " & intSurveyID & " AND pageID = " & intPageID
	Set rsResults = utility_getRecordset(strSQL)

	If not rsResults.EOF Then
		Do until rsResults.EOF
			intItemID = rsResults("itemID")
			
			Call surveyCreation_deleteItem(intSurveyID, intItemID)
			
			rsResults.MoveNext
		Loop
	End If
	rsResults.Close
	Set rsResults = NOTHING
	
	strSQL = "DELETE FROM usd_branching WHERE currentPage = " & intPageID & " AND surveyID = " & intSurveyID
	Call utility_executeCommand(strSQL)
	
	strSQL = "DELETE FROM usd_surveyItem WHERE surveyID = " & intSurveyID & " AND pageID = " & intPageID
	Call utility_executeCommand(strSQL)
	
	Call surveyCreation_updatePages(intSurveyID)
	
	Response.Redirect("editSurvey.asp?surveyID=" & intSurveyID)
%>