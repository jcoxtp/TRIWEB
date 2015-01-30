<%@language = "vbscript"%>
<%
Option Explicit
Response.Expires = 0
Response.ContentType="text/xml"
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/reports_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<%
'We specify the HTTP content type for the response object
'to be text/xml. The content type tells the browser
'what type of content to expect
Dim intItemType
Dim intItemID
Dim intSurveyID 
Dim boolDrilldown
Dim boolAliases
Dim intDrilldownItemID
Dim intConditionType
Dim strDrilldownResponse
Dim intCategoryID
Dim intLowScore
Dim intHighScore
Dim boolPointSearch
Dim intMatrixSetID
Dim intAnswerID
Dim intMatrixCategoryID

intItemType = cint(Request.QueryString("itemType"))
intItemID = Request.QueryString("itemID")
intSurveyID = cint(Request.QueryString("surveyID"))
boolDrilldown = cbool(Request.QueryString("boolDrilldown"))
boolAliases = cbool(Request.QueryString("aliases"))
intDrilldownItemID = Request.QueryString("drilldownItemID")
intConditionType = Request.QueryString("conditionType")
strDrilldownResponse = Request.QueryString("response")
intCategoryID = Request.QueryString("category")
intHighScore = Request.QueryString("highScore")
intLowScore = Request.QueryString("lowScore")
boolPointSearch = cbool(Request.QueryString("searchScore"))	
intMatrixSetID = Request.QueryString("matrixSetID")
intAnswerID = Request.QueryString("answerID")
intMatrixCategoryID = Request.QueryString("matrixCategoryID")

'If intItemType = SV_ITEM_TYPE_MATRIX Then
	'Call matrixGraph(intItemID, intItemType, intSurveyID, boolDrilldown, intDrilldownItemID, intConditionType, _
						'strDrilldownResponse, intCategoryID, intLowScore, intHighScore, boolPointSearch, intMatrixSetID, intAnswerID)
'Else

	Call graph(intItemID, intItemType, intSurveyID, boolDrilldown, intDrilldownItemID, intConditionType, _
						strDrilldownResponse, intLowScore, intHighScore, boolPointSearch, intAnswerID, intMatrixCategoryID, intMatrixSetID)
'End If


Function matrixGraph(intItemID, intItemType, intSurveyID, boolDrilldown, intDrilldownItemID, intConditionType, _
						strDrilldownResponse, intDrilldownCategory, intLowScore, intHighScore, boolPointSearch, intMatrixSetID, intAnswerID)


Dim strXML
Dim strSQL
Dim rsResults
Dim strGraphNode
Dim strCategories
Dim strDataSets
Dim intCategory
Dim intCurrentCategoryID
Dim strResponse
Dim strDrilldownURL
Dim strCurrentResponse
Dim rsAnswers
Dim intNumberResponses
Dim intMaxResponses
Dim strColor
Dim intCounter
Dim strItemText
Dim strCategoryAlias
Dim strAnswerAlias
Dim arrSets
Dim intSetCounter
Dim intCurrentAnswerID
Dim strCategory
Dim intMatrixAnswerID

Set rsResults = Server.CreateObject("ADODB.Recordset")


If boolPointSearch = True Then
	strSQL = "SELECT distinct(R.responseID) as maxResponses FROM usd_response R, usd_responseDetails RD " &_
			 "WHERE R.points >=" & intLowScore & " AND R.points <= " & intHighScore &_
			 " AND R.surveyID = " & intSurveyID & " AND R.completed = 1" &_
		     " AND RD.itemID = " & intItemID &_
		     " AND RD.responseID = R.responseID" &_
		     " AND RD.matrixSetID = " & intMatrixSetID
		     
	rsResults.CursorLocation = adUseClient
	rsResults.Open strSQL, DB_CONNECTION
	If not rsResults.EOF Then
		intMaxResponses = rsResults.RecordCount
	Else
		intMaxResponses = 0 
	End If
	rsResults.Close
ElseIf utility_isPositiveInteger(intDrilldownItemID) and (len(strDrilldownResponse) > 0 or utility_isPositiveInteger(intAnswerID)) Then
	strSQL = "SELECT distinct(RD.responseID) as maxResponses FROM usd_responseDetails RD " &_
			 " WHERE  " & reports_getItemSQL(intSurveyID, intDrilldownItemID, intConditionType, strDrilldownResponse, intAnswerID) &_
			 " AND RD.matrixSetID = " & intMatrixSetID
	rsResults.CursorLocation = adUseClient
	rsResults.Open strSQL, DB_CONNECTION
	If not rsResults.EOF Then
		intMaxResponses = rsResults.RecordCount
	Else
		intMaxResponses = 0 
	End If
	rsResults.Close
Else	
	strSQL = "SELECT max(numberResponses) as maxResponses FROM usd_itemResponses WHERE itemID = " & intItemID &_
			 " AND matrixSetID = " & intMatrixSetID
	rsResults.CursorLocation = adUseClient
	rsResults.Open strSQL, DB_CONNECTION
	If not rsResults.EOF Then
		intMaxResponses = rsResults("maxResponses")
	Else
		intMaxResponses = 0 
	End If
	rsResults.Close
	
End If

rsResults.CursorLocation = adUseClient
rsResults.Open strSQL, DB_CONNECTION
If not rsResults.EOF Then
	intMaxResponses = rsResults.RecordCount
Else
	intMaxResponses = 0 
End If
rsResults.Close

strSQL = "SELECT SI.alias as itemAlias, SI.itemText, MC.alias as categoryAlias, MC.category, MC.categoryID " &_
		 "FROM usd_itemResponses IR, usd_surveyItem SI, usd_matrixCategories MC " &_
		 "WHERE IR.itemID = SI.itemID " &_
		 " AND IR.matrixCategoryID = MC.categoryID " &_
		 " AND IR.itemID = " & intItemID &_
		 " AND SI.itemID = IR.itemID " &_
		 " AND IR.itemID = SI.itemID " &_
		 " AND IR.itemID = MC.itemID " &_
		 " AND IR.matrixSetID = " & intMatrixSetID &_
		 " ORDER by MC.categoryID"

rsResults.Open strSQL, DB_CONNECTION
If not rsResults.EOF Then
	If boolAliases = True Then
		strItemText = rsResults("itemAlias")
	Else
		strItemText = rsResults("itemText")
	End If
	
	strGraphNode = "<graph xasisname='Categories' yaxisname='Number Responses' " &_
				   " yaxisminvalue='0' yaxismaxvalue='" & intMaxResponses & "' " &_
				   "shownames='1' showhovercap='1' animation='0' canvasbgcolor='FFFF51' gridbgcolor='EDEDC5' hovercapbg='FFFFDD' " &_
				   "hovercapborder='CECE00' divlinecolor='CECE00' showvalues='1'>"	
	Do until rsResults.EOF
		strCategoryAlias = rsResults("categoryAlias")
		strCategory = rsResults("category")
		
		strCategory = utility_XMLEncode(strCategory)
		intCategory = rsResults("categoryID")
		
		If intCurrentCategoryID <> intCategory Then
			strCategories = strCategories & "<category name='"
			If boolAliases = True Then
				strCategories = strCategories & strCategoryAlias
			Else
				strCategories = strCategories & strCategory
			End If
			strCategories = strCategories & "' />"
			intCurrentCategoryID = intCategoryID
		End If
		rsResults.MoveNext
	Loop
	rsResults.Close

	strSQL = "SELECT MA.alias, MA.matrixAnswerID, C.categoryID " &_
			 "FROM (usd_matrixAnswers MA " &_
			 "INNER JOIN usd_matrixSets S " &_ 
			 "ON MA.matrixSetID = S.matrixSetID) " &_
			 "INNER JOIN usd_matrixCategories C " &_ 
			 "ON S.itemID = C.itemID " &_ 
			 "WHERE C.itemID = " & intItemID &_ 
			 " AND MA.matrixSetID = " & intMatrixSetID &_
			 " ORDER BY MA.matrixAnswerID, C.categoryID" 	

	
	rsResults.Open strSQL, DB_CONNECTION
	If not rsResults.EOF Then
		Set rsAnswers = Server.CreateObject("ADODB.Recordset") 
		intCounter = 0
		Do until rsResults.EOF
			intMatrixAnswerID = rsResults("matrixAnswerID")
			intCategoryID = rsResults("categoryID")

			If boolPointSearch = True Then
					strSQL = "SELECT count(itemID) as numberResponses " &_
					"FROM usd_responseDetails " &_
					"WHERE itemID = " & intItemID &_
					" AND response LIKE " & utility_SQLEncode(strResponse, True) &_
					" AND matrixCategoryID = " & intCategoryID &_
					" AND matrixSetID = " & intMatrixSetID &_
					" AND responseID IN (SELECT responseID FROM usd_response " &_
					"WHERE points >= " & intLowScore & " AND points <= " & intHighScore &_
					" AND surveyID = " & intSurveyID & " AND completed = 1)" 

			ElseIf utility_isPositiveInteger(intDrilldownItemID) and (len(strDrilldownResponse) > 0 or utility_isPositiveInteger(intAnswerID)) Then
				strSQL = "SELECT count(RD.itemID) as numberResponses " &_
					"FROM usd_responseDetails RD " &_
					"WHERE RD.itemID = " & intItemID & " AND RD.answerID = " & intMatrixAnswerID &_
						" AND RD.matrixCategoryID = " & intCategoryID &_
						" AND RD.matrixSetID = " & intMatrixSetID &_
						" AND " & reports_getItemSQL(intSurveyID, intDrilldownItemID, intConditionType, strDrilldownResponse, intAnswerID) 

			Else
			
				strSQL = "SELECT IR.numberResponses, A.alias " &_
						 " FROM usd_itemResponses IR, usd_matrixAnswers A " &_
						 "WHERE IR.answerID = A.matrixAnswerID " &_
						 "AND IR.itemID = " & intItemID & " AND A.matrixAnswerID = " & intMatrixAnswerID &_
						" AND IR.matrixCategoryID = " & intCategoryID &_
						" AND IR.matrixSetID = " & intMatrixSetID
						
			End If
			
			rsAnswers.Open strSQL, DB_CONNECTION
			If rsAnswers.EOF Then
				intNumberResponses = 0
			Else
				intNumberResponses = rsAnswers("numberResponses")
			End If
			strAnswerAlias = rsResults("alias")
			rsAnswers.Close
			If intAnswerID <> intCurrentAnswerID Then
				If strDatasets <> "" Then
					strDatasets = strDatasets & "</dataset>"
				End If
				
				strColor = arrColors(0, intCounter mod intArraySize)
				intCounter = intCounter + 1
				strDatasets = strDatasets & "<dataset seriesname='"
				If boolAliases = True Then
					If len(trim(strAnswerAlias)) > 0 Then
						strDatasets = strDatasets & utility_XMLEncode(strAnswerAlias)
					End If
				Else
					If len(trim(strResponse)) > 0 Then
						strDatasets = strDatasets & utility_XMLEncode(strResponse)
					End If
				End If
				strDatasets = strDatasets & "' color='" & strColor & "'>"
				intCurrentAnswerID = intAnswerID
			End If
			
			strDatasets = strDatasets & "<set value='" & intNumberResponses & "' "

			strDatasets = strDatasets & "/>"
			
			rsResults.MoveNext
		Loop
	End If
	strXML = strGraphNode & "<categories>" & strCategories	& "</categories>" & strDataSets & "</dataset></graph>"
	Response.Write strXML
End If
End Function

Function graph(intItemID, intItemType, intSurveyID, boolDrilldown, intDrilldownItemID, intConditionType, _
						strDrilldownResponse, intLowScore, intHighScore, boolPointSearch, intAnswerID, intMatrixCategoryID, intMatrixSetID)
	Dim strXML
	Dim rsResults
	Dim strSQL
	Dim strResponse
	Dim strItemText
	Dim intNumberResponses
	Dim intMaxResponses
	Dim intCounter
	Dim strColor
	Dim strItemAlias
	Dim strAnswerAlias
	Dim intNumberOther
	Dim strDrilldownSQL
	Dim rsCount
	Dim intAnswerFoundID
	
	
	If boolPointSearch = True Then
		strSQL = "SELECT count(responseID) as maxResponses FROM usd_response " &_
				 "WHERE points >= " & intLowScore & " AND points <= " & intHighScore &_
				 " AND surveyID = " & intSurveyID & " AND completed = 1"
	ElseIf utility_isPositiveInteger(intDrilldownItemID) and (len(strDrilldownResponse) > 0 or utility_isPositiveInteger(intAnswerID)) Then
		strSQL = "SELECT count(responseID) as maxResponses FROM usd_responseDetails RD WHERE (answerID = " & intAnswerID & " OR response LIKE " &_
				 utility_SQLEncode(strResponse,True) & ") AND itemID = " & intItemID & " AND " &_
				  reports_getItemSQL(intSurveyID, intDrilldownItemID, intConditionType, strDrilldownResponse, intAnswerID)
	Else
		strSQL = "SELECT max(numberResponses) as maxResponses FROM usd_itemResponses WHERE itemID = " & intItemID
	End If
		
	
	Set rsResults = utility_getRecordset(strSQL)
	
	If not rsResults.EOF Then
		intMaxResponses = rsResults("maxResponses")
	Else
		intMaxResponses = 0
	End If
	
	rsResults.Close
	
	If boolPointSearch = True Then
			strSQL = "SELECT count(itemID) as numberOther " &_
				 "FROM usd_responseDetails " &_
				 "WHERE itemID = " & intItemID &_
				 " AND isOther = 1" &_
				 " AND responseID IN (SELECT responseID FROM usd_response " &_
				 "WHERE points >= " & intLowScore & " AND points <= " & intHighScore &_
				 " AND surveyID = " & intSurveyID & " AND completed = 1)"
		If utility_isPositiveInteger(intMatrixCategoryID) Then
			strSQL = strSQL & " AND matrixSetID = " & intMatrixSetID & " AND matrixCategoryID = " & intMatrixCategoryID
		End If
	ElseIf utility_isPositiveInteger(intDrilldownItemID) and (len(strDrilldownResponse) > 0 or utility_isPositiveInteger(intAnswerID)) Then
		
		strSQL = "SELECT count(RD.responseID) as numberOther " &_
				 "FROM usd_responseDetails RD " &_
				 "WHERE RD.itemID = " & intItemID & " AND RD.isOther = 1 " &_
				 " AND " & reports_getItemSQL(intSurveyID, intDrilldownItemID, intConditionType, strDrilldownResponse, intAnswerID) 
		If utility_isPositiveInteger(intMatrixCategoryID) Then
			strSQL = strSQL & " AND matrixSetID = " & intMatrixSetID & " AND matrixCategoryID = " & intMatrixCategoryID
		End If
	Else
		strSQL = "SELECT count(responseID) as numberOther " &_
			 "FROM usd_responseDetails " &_
			 "WHERE itemID = " & intItemID & " AND isOther = 1 and response IS NOT NULL"
		
		If utility_isPositiveInteger(intMatrixCategoryID) Then
			strSQL = strSQL & " AND matrixSetID = " & intMatrixSetID & " AND matrixCategoryID = " & intMatrixCategoryID
		End If
		
	End If	 

	rsResults.Open strSQL, DB_CONNECTION
	If not rsResults.EOF Then
		intNumberOther = rsResults("numberOther")
		If intNumberOther > intMaxResponses Then
			intMaxResponses = intNumberOther
		End If
	End If
	
	
	
	rsResults.Close
			 
	
	If utility_isPositiveInteger(intMatrixSetID) Then
		strSQL = "SELECT SI.itemText, SI.alias as itemAlias, MA.alias as answerAlias, MA.answerText, MA.matrixAnswerID as answerID, IR.numberResponses " &_
				 "FROM usd_itemResponses IR, usd_surveyItem SI, usd_matrixAnswers MA " &_
				 "WHERE IR.itemID = SI.itemID " &_
				 " AND MA.matrixAnswerID = IR.answerID " &_
				 "AND IR.matrixSetID = " & intMatrixSetID &_
				 " AND IR.matrixCategoryID = " & intMatrixCategoryID &_
				 " AND SI.itemID = " & intItemID & strDrilldownSQL
	Else
		strSQL = "SELECT SI.itemText, SI.alias as itemAlias, A.alias as answerAlias, A.answerText, A.answerID, IR.numberResponses " &_
				 "FROM usd_itemResponses IR, usd_surveyItem SI, usd_answers A " &_
				 "WHERE IR.itemID = SI.itemID " &_
				 " AND A.answerID = IR.answerID " &_
				 "AND A.itemID = SI.itemID " &_
				 "AND SI.itemID = " & intItemID & strDrilldownSQL
	End If			 
'response.write strSQL
'response.end	
	rsResults.Open strSQL, DB_CONNECTION
	
		strXML= "<graph bgcolor='ffffff' xaxisname='Answers' " &_
		"yaxisname='Number Responses' yaxismaxvalue='" & intMaxResponses & "' " &_
		"canvasbgcolor='FFFF51' animation='0' " &_
		"gridbgcolor='EDEDC5' hovercapbg='FFFFDD' hovercapborder='CECE00'" &_
		" divlinecolor='CECE00'>" 

	If not rsResults.EOF Then
		strItemText = rsResults("itemText")
		strItemAlias = rsResults("itemAlias")
	
		intCounter = 0
	
		Set rsCount = server.CreateObject("ADODB.Recordset")
	
		Do until rsResults.EOF
			strAnswerAlias = rsResults("answerAlias")
			strResponse = rsResults("answerText")
			intAnswerFoundID = rsResults("answerID")
			
			If boolPointSearch = True Then
				strSQL = "SELECT count(itemID) as numberResponses " &_
					"FROM usd_responseDetails " &_
					"WHERE itemID = " & intItemID &_
					" AND answerID = " & intAnswerFoundID &_
					" AND responseID IN (SELECT responseID FROM usd_response " &_
					"WHERE points >= " & intLowScore & " AND points <= " & intHighScore &_
					" AND surveyID = " & intSurveyID & " AND completed = 1)"
				If utility_isPositiveInteger(intMatrixCategoryID) Then
					strSQL = strSQL & " AND matrixSetID = " & intMatrixSetID & " AND matrixCategoryID = " & intMatrixCategoryID
				End If
				
				rsCount.Open strSQL, DB_CONNECTION
					
				If not rsCount.EOF Then
					intNumberResponses = rsCount("numberResponses")
				End If
				rsCount.Close
			ElseIf utility_isPositiveInteger(intDrilldownItemID) and (len(strDrilldownResponse) > 0 or utility_isPositiveInteger(intAnswerID)) Then
				
					
				strSQL = "SELECT count(itemID) as numberResponses " &_
					"FROM usd_responseDetails RD " &_
					"WHERE RD.itemID = " & intItemID 
					
					If utility_isPositiveInteger(intAnswerFoundID) Then
						strSQL = strSQL & " AND RD.answerID = " & intAnswerFoundID 
					Else
						strSQL = strSQL & " AND RD.response LIKE " & utility_SQLEncode(strResponse, False)
					End If 
					
					If utility_isPositiveInteger(intMatrixCategoryID) Then
						strSQL = strSQL & " AND matrixSetID = " & intMatrixSetID & " AND matrixCategoryID = " & intMatrixCategoryID
					End If
										
					strSQL = strSQL & " AND " &	reports_getItemSQL(intSurveyID, intDrilldownItemID, intConditionType, strDrilldownResponse, intAnswerID)
		
					rsCount.Open strSQL, DB_CONNECTION
					
					If not rsCount.EOF Then
						intNumberResponses = rsCount("numberResponses")
					End If
					rsCount.Close
			Else
				intNumberResponses = rsResults("numberResponses")
		
			End If

			If utility_isPositiveInteger(intNumberResponses) Then

				strColor = arrColors(0,intCounter mod intArraySize)
				intCounter = intCounter + 1
				strXML = strXML &  " <set name='"
				If boolAliases = True Then
					If len(strAnswerAlias) > 0 Then
						strXML = strXML & utility_XMLEncode(strAnswerAlias)
					End If
				Else
					If len(strResponse) > 0 Then
						strXML = strXML & utility_XMLEncode(strResponse)
					End If
				End If
				strXML = strXML & "' value='" & intNumberResponses & "' color='" & strColor & "' "
				If boolDrilldown = True Then
				'	strXML = strXML & "link = 'viewResponses.asp?surveyID=" & intSurveyID & "&drilldownitemID=" & intItemID &_
									'"&response=" & server.URLEncode(strResponse) & "'"
				End If
				strXML = strXML & "/> "
			End If
			rsResults.MoveNext
		Loop
	End If
	rsResults.Close
	Set rsResults = NOTHING

	intCounter = intCounter + 1
	If utility_isPositiveInteger(intNumberOther) Then
		strColor = arrColors(0,intCounter mod intArraySize)
		strXML = strXML & "<set name='Other' color='" & strColor & "' value = '" & intNumberOther & "' />"
	End If
			
		
	strXML = strXML & "</graph>" 
	
	Response.Write(strXML)
End Function


%>
