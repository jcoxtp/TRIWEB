<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		copyPage.asp 
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
<!--#INCLUDE FILE="Include/copy_inc.asp"-->
<!--#INCLUDE FILE="Include/copyItem_inc.asp"-->
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
	Dim intItemIDOut
	
	intSurveyID = Request.QueryString("surveyID")
	intPageID = Request.QueryString("pageID")
	intLastPageNumber = surveyCreation_getLastPageNumber(intSurveyID)
	intNewPageNumber = intLastPageNumber + 1
	
	
	strSQL = "SELECT itemID FROM usd_surveyItem WHERE surveyID = " & intSurveyID & " AND pageID = " & intPageID & " ORDER BY orderByID"


	Set rsResults = utility_getRecordset(strSQL)
	
	If not rsResults.EOF Then
		Do until rsResults.EOF
			intItemID = rsResults("itemID")
			
			Call copyItem_copyItem(intItemID, intSurveyID, intPageID + 1, True, intItemIDOut)
			
	
			
	
		rsResults.MoveNext
		Loop
		
	End If
	rsResults.Close
	
	strSQL = "SELECT conditionID, conditionGroupID " &_
			 "FROM usd_conditionMapping " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " AND pageID = " & intPageID
	rsResults.Open strSQL, DB_CONNECTION
	
	If not rsResults.EOF Then
		Do until rsResults.EOF 
			strSQL = "INSERT INTO usd_conditionMapping " &_	
					 "(conditionID, conditionGroupID, pageID, surveyID) " &_
					 "VALUES(" & rsResults("conditionID") & "," &_
					 rsResults("conditionGroupID") & "," & intNewPageNumber & "," & intSurveyID & ")"
			Call utility_executeCommand(strSQL)
			rsResults.MoveNext
		Loop
	End If
	rsResults.Close
	Set rsResults = NOTHING

	Response.Redirect("editSurvey.asp?surveyID=" & intSurveyID & "&pageID=" & intNewPageNumber)


%>