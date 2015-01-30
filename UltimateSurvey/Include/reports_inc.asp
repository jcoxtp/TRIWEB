<%
'****************************************************
'
' Name:		reports_inc.asp Server-Side Include
' Purpose:		Provides functions relating to survey reports
'
' Date Written:	6/18/2002
' Modified:		
'
' Changes:
'****************************************************


'**************************************************************************************
'Name:			reports_displayResults
'
'Purpose:		display basic survey results
'
'Inputs:		intSurveyID - unique ID of survey to display results for
'				intPageNumber - page of survey to get results for
'				boolShowFreeText - whether or not to show free text responses
'				boolDrilldown - whether or not to allow user to drill down to detailed results
'**************************************************************************************
Function reports_displayResults(intSurveyID, intStartPage, intEndPage, boolShowFreeText, boolDrilldown, boolChange, _
			intDrilldownItemID, intConditionType, strResponse, intDrilldownCategoryID, boolAliases, intLowPoints, intHighPoints, _
			boolPointSearch, boolFlash, intAnswerID)
	Dim strSQL
	Dim rsResults
	Dim intItemID
	Dim strItemText
	Dim intItemType
	Dim strSetText
	Dim intMatrixSetID
	Dim intGraphType
	Dim intMatrixSetType
	Dim intCategoryID
	Dim strCategory
	
	'get all items for survey that are questions
	strSQL = "SELECT SI.itemID, SI.itemText, SI.alias, SI.itemType, SI.graphType, MS.setText, MS.alias as matrixAlias, MS.matrixSetID, MS.matrixSetType, MC.categoryID, MC.category  " &_
			 "FROM (usd_SurveyItem SI " &_
			 "LEFT JOIN usd_matrixCategories MC ON SI.itemID = MC.itemID) " &_
			 "LEFT JOIN usd_matrixSets MS ON SI.itemID = MS.itemID " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " AND itemType " &_
				"IN(" & SV_ITEM_TYPE_TEXTAREA & "," & SV_ITEM_TYPE_SINGLE_LINE &_
					"," & SV_ITEM_TYPE_DATE & "," & SV_ITEM_TYPE_CHECKBOXES  &_
					"," & SV_ITEM_TYPE_RADIO & "," & SV_ITEM_TYPE_DROPDOWN & "," & SV_ITEM_TYPE_MATRIX & "," & SV_HIDDEN_FIELD_TYPE_QUERYSTRING &_
					"," & SV_HIDDEN_FIELD_TYPE_COOKIE & "," & SV_HIDDEN_FIELD_TYPE_SESSION & ")" &_
					" AND pageID >= " & intStartPage &_
					" AND pageID <= " & intEndPage 

	strSQL = strSQL & " ORDER BY pageID, SI.orderByID, MS.orderByID " 
			 
	Set rsResults = utility_getRecordset(strSQL)
	If rsResults.EOF Then
%>
		<p class="message">There are no questions in the selected survey/page</p>
<%
	Else
		Do until rsResults.EOF
			'display results for individual survey item
			intItemID = rsResults("itemID")
			If boolAliases = True Then
				strItemText = rsResults("alias")
			Else
				strItemText = rsResults("itemText")
			End If
			
			intItemType = rsResults("itemType")
			intGraphType = rsResults("graphType")
			If boolAliases = True Then
				strSetText = rsResults("matrixAlias")
			Else
				strSetText = rsResults("setText")
			End If
			intMatrixSetID = rsResults("matrixSetID")
			intMatrixSetType = rsResults("matrixSetType")
			
			intCategoryID = rsResults("categoryID")
			strCategory = rsResults("category")
			
			If not utility_isPositiveInteger(intCategoryID) Then
				intCategoryID = 0
			End If
			
			If boolFlash = True and (intMatrixSetType <> SV_MATRIX_LAYOUT_SINGLE or utility_isPositiveInteger(intMatrixSetType) = False) Then
				Call reports_displayItemResultsFlash(intItemID, intSurveyID, boolDrilldown, _
						intItemType, intGraphType, intStartPage, intEndPage, _
						strItemText, boolChange, intDrilldownItemID, intConditionType, strResponse, intDrilldownCategoryID, _
						boolAliases, intLowScore, intHighScore, boolPointSearch, strSetText, intMatrixSetID, intMatrixSetType, intAnswerID, intCategoryID, strCategory)
			ElseIf intMatrixSetType <> SV_MATRIX_LAYOUT_SINGLE or utility_isPositiveInteger(intMatrixSetType) = False Then
				Call reports_displayItemResults(intItemID, intSurveyID, boolDrilldown, _
						intDrillDownItemID, intConditionType, strResponse, intDrilldownCategoryID, boolAliases, strItemText, _
						intMatrixSetID, intMatrixSetType, strSetText, intAnswerID,boolPointSearch,intHighScore, intLowScore, intCategoryID, strCategory)
			Else
				Call reports_singleLineMatrixResults(intItemID, intSurveyID, boolChange, _ 
					intDrillDownItemID, intConditionType, strResponse, "", intMatrixSetID, boolAliases, boolPointSearch, intLowScore, intHighScore, intAnswerID, strItemText, strSetText, intCategoryID, strCategory)
			End If
			rsResults.MoveNext
		Loop
	End If		
	rsResults.Close
	Set rsResults = NOTHING
End Function


Function reports_displayItemResultsFlash(intItemID, intSurveyID, boolDrilldown, intItemType, _
			intGraphType, intStartPage, intEndPage, strItemText, boolChange, _ 
			intDrillDownItemID, intConditionType, strResponse, intDrilldownCategoryID, boolAliases, _
			intLowScore, intHighScore, boolPointSearch, strSetText, intMatrixSetID, intMatrixSetType, intAnswerID,intCategoryID, strCategory)
%>
<br /><br /><span class="normalBold-Big"><%=strItemText%>
<%
If len(strCategory) > 0 Then
%>
	- <%=strCategory%>
<%
End If

If len(strSetText) > 0 Then
%>
	( <%=strSetText%> )
<%
End If
%>
</span>
<%

	Dim strChangeURL
	Dim strSQL
	strChangeURL = "viewResults.asp?surveyID=" & intSurveyID & "&editGraphType=" & intItemID &_
				 "&startPage=" & intStartPage & "&endPage=" & intEndPage & "&pages=range" &_
				 "&drilldownItemID=" & intDrillDownItemID & "&conditionType=" & intConditionType & "&response=" & server.URLEncode(strResponse) &_
				 "&category=" & strCategory & "&lowScore=" & intLowScore  & "&highScore=" & intHighScore &_
				 "&searchScore=" & boolPointSearch & "&flash=" & cstr(boolFlash) & "&answerID=" & intAnswerID
	
	If intItemType = SV_ITEM_TYPE_CHECKBOXES or _
	   intItemType = SV_ITEM_TYPE_RADIO or _
	   intItemType = SV_ITEM_TYPE_DROPDOWN or _
	   (intItemType = SV_ITEM_TYPE_MATRIX and intMatrixSetType <> SV_MATRIX_LAYOUT_SINGLE) Then
	
	
		strSQL = "SELECT top 1 itemID FROM usd_responseDetails RD WHERE itemID = " & intItemID &_
					" AND (response IS NOT NULL or answerID > 0) " 
		
		If utility_isPositiveInteger(intMatrixSetID) Then
			strSQL = strSQL & " AND matrixSetID = " & intMatrixSetID & " AND matrixCategoryID = " & intCategoryID
		End If
		
		If utility_isPositiveInteger(intDrilldownItemID) and utility_isPositiveInteger(intConditionType) Then
			strSQL = strSQL & " AND " & reports_getItemSQL(intSurveyID, intDrilldownItemID, intConditionType, strResponse, intAnswerID)
		End If
		
		If boolPointSearch = True Then
			strSQL = strSQL & " AND responseID IN(SELECT responseID FROM usd_response " &_
				 "WHERE points >= " & intLowScore & " AND points <= " & intHighScore &_
				 " AND surveyID = " & intSurveyID & " AND completed = 1)"
		End If


		If utility_checkForRecords(strSQL) = False Then

%>
			<br /><span class="message">No Responses</span><br />
<%
		Else
			Dim strURL
			Dim strFlashFile
		
			strURL = "getGraphXML.asp?itemType=" & intItemType & "&itemID=" & intItemID & "&surveyID=" & intSurveyID &_
					 "&boolDrilldown=" & cstr(boolDrilldown) & "&drilldownItemID=" & intDrilldownItemID & "&conditionType=" & intConditionType &_
					  "&response=" & server.URLEncode(strResponse) & "&category=" & intDrilldownCategoryID & "&aliases=" & boolAliases &_
					  "&lowScore=" & intLowScore  & "&highScore=" & intHighScore & "&searchScore=" & boolPointSearch & "&matrixSetID=" & intMatrixSetID &_
					  "&answerID=" & intAnswerID & "&matrixCategoryID=" & intCategoryID

			'Response.Write strURL

			strURL = FusionCharts(strURL)



			If intItemType = SV_ITEM_TYPE_MATRIX Then
				'strFlashFile = "FCMSColumn.swf"
				'strFlashFile = "FCColumn.swf"
				strFlashFile = "FCPie.swf"
			Else
				If intGraphType = SV_GRAPH_TYPE_COLUMN Then
					strFlashFile = "FCColumn.swf"
				ElseIf intGraphType = SV_GRAPH_TYPE_PIE Then
					strFlashFile = "FCPie.swf"
				ElseIf intGraphType = SV_GRAPH_TYPE_DONUT Then
					strFlashFile = "FCDough.swf"
				ElseIf intGraphType = SV_GRAPH_TYPE_LINE Then
					strFlashFile = "FCLine.swf"
				End If
			End If
%>
			<table><tr><td valign="top">
			<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" 
			codebase="http://download.macromedia.com/pub/shockwave/
			cabs/flash/swflash.cab#version=5,0,0,0"
			WIDTH="565" HEIGHT="420" id="FCColumn" ALIGN="" VIEWASTEXT>
			<PARAM NAME=movie VALUE="<%=strFlashFile%>?dataurl=<%=strURL%>">
			<PARAM NAME=quality VALUE=high>
			<PARAM NAME=bgcolor VALUE=#FFFFFF>
			<EMBED src="<%=strFlashFile%>?dataurl=<%=strURL%>" quality=high 
			bgcolor=#FFFFFF WIDTH="565" HEIGHT="420" NAME="FCColumn" 
			TYPE="application/x-shockwave-flash" 
			PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer"></EMBED>
			</OBJECT></td>


<%
			If boolChange = True and intItemType <> SV_ITEM_TYPE_MATRIX Then
%>	
				<td>
				<table cellpadding="2" ID="Table1">
					<tr><td <% If intGraphType = SV_GRAPH_TYPE_PIE Then %>bgcolor="#E0E0E0"<% End If%>>
					<a href="<%=strChangeURL%>&graphType=<%=SV_GRAPH_TYPE_PIE%>"><img border="0" src="images/charts-pie.gif"  alt="Change To Pie Charts"></a><br />
					</td></tr>
					<tr><td <% If intGraphType = SV_GRAPH_TYPE_COLUMN Then %>bgcolor="#E0E0E0"<% End If%>>
					<a href="<%=strChangeURL%>&graphType=<%=SV_GRAPH_TYPE_COLUMN %>"><img border="0" src="images/charts-bar.gif"  alt="Change To Bar Charts"></a><br />
					</td></tr>
					<tr><td <% If intGraphType = SV_GRAPH_TYPE_DONUT Then %>bgcolor="#E0E0E0"<% End If%>>
					<a href="<%=strChangeURL%>&graphType=<%=SV_GRAPH_TYPE_DONUT %>"><img border="0" src="images/charts-donut.gif" alt="Change To Donut Charts"></a><br />
					</td></tr>
					<tr><td <% If intGraphType = SV_GRAPH_TYPE_LINE Then %>bgcolor="#E0E0E0"<% End If%>>
					<a href="<%=strChangeURL%>&graphType=<%=SV_GRAPH_TYPE_LINE %>"><img border="0" src="images/charts-line.gif" alt="Change To Line Charts"></a><br />
					</td></tr>
		
				</table>
				</td>	
<%
			End If
%>


			</tr></table>
<%
		End If
	
	Else
		If intGraphType = SV_GRAPH_TYPE_HIDDEN Then
			If boolChange = True Then%>
	
		  <span class="normal"><a href="<%=strChangeURL%>&graphType=<%=SV_GRAPH_TYPE_SHOWN%>">
			( Show Responses )</a></span>
		
<%
			End If
		Else
			If boolChange = True Then
%>
			 <span class="normal"><a href="<%=strChangeURL%>&graphType=<%=SV_GRAPH_TYPE_HIDDEN%>">
			( Hide Responses )</a></span>
<%
			End If
		
							Call reports_openEndedResults(intItemID, intSurveyID, boolChange, _ 
					intDrillDownItemID, intConditionType, strResponse, strCategory, intMatrixSetID, boolAliases, boolPointSearch, intLowScore, intHighScore, intAnswerID)

		
		End If
	End If
%>
	<hr noshade color="#C0C0C0" size="2">
<%
End Function

Function reports_openEndedResults(intItemID, intSurveyID, boolChange, _ 
			intDrillDownItemID, intConditionType, strDrilldownResponse, strCategory, intMatrixSetID, boolAliases, boolPointSearch, intLowScore, intHighScore, intAnswerID)
	Dim strSQL
	Dim rsResults
	Dim strResponse
	Dim intNumberResponses
	Dim intCounter
	Dim strMatrixCategory
	Dim strCurrentMatrixCategory
	Dim intResponseID
	
	If utility_isPositiveInteger(intDrilldownItemID) and (len(strDrilldownResponse) > 0 or intConditionType = SV_CONDITION_DID_NOT_ANSWER or intConditionType = SV_CONDITION_ANSWERED or utility_isPositiveInteger(intAnswerID)) Then
		strSQL = "SELECT RD.responseID, RD.response as responseText " 
		 		 
		 		 
		 		 If utility_isPositiveInteger(intMatrixSetID) Then
					strSQL = strSQL & ", MC.category, MC.alias FROM usd_responseDetails RD INNER JOIN usd_matrixCategories MC ON MC.category LIKE RD.matrixCategory "
				 Else
					strSQL = strSQL & " FROM usd_responseDetails RD "
				 End If
		 		 
				 strSQL = strSQL & "WHERE RD.itemID = " & intItemID & " AND (RD.response IS NOT NULL AND RD.response NOT LIKE '') "
				 
				 If utility_isPositiveInteger(intMatrixSetID) Then
					strSQL = strSQL & " AND matrixSetID = " & intMatrixSetID 
				 End If
				 
				strSQL = strSQL & " AND " & reports_getItemSQL(intSurveyID, intDrilldownItemID, intConditionType, strDrilldownResponse, 0)  &_
				 " ORDER BY matrixCategory, responseID"
				 
				 
	Else
		
			strSQL = "SELECT RD.responseID, RD.response as responseText "  		 
			If utility_isPositiveInteger(intMatrixSetID) Then
				strSQL = strSQL & ", MC.category, MC.alias  FROM usd_responseDetails RD INNER JOIN usd_matrixCategories MC ON MC.category LIKE RD.matrixCategory "
			Else
				strSQL = strSQL & " FROM usd_responseDetails RD "
			End If
		 		
			 strSQL = strSQL & "WHERE RD.itemID = " & intItemID & " AND (RD.response IS NOT NULL AND RD.response NOT LIKE '') "
				 
			 If utility_isPositiveInteger(intMatrixSetID) Then
				strSQL = strSQL & " AND matrixSetID = " & intMatrixSetID 
			 End If
			 
			  If boolPointSearch = True Then
					strSQL = strSQL & " AND responseID IN(SELECT responseID FROM usd_response " &_
						"WHERE points >= " & intLowScore & " AND points <= " & intHighScore &_
						" AND surveyID = " & intSurveyID & " AND completed = 1)"
				End If
		
		strSQL = strSQL & " ORDER BY matrixCategory, responseID"
		
	
	End If
	
		
	Set rsResults = utility_getRecordset(strSQL)
	If rsResults.EOF Then
%>
		<br /><span class="message">No responses</span><br />
<%		
	Else
		intCounter = 0
%>	
		<table border="1" cellpadding="2" bordercolor="#CCCCCC" cellspacing="0" width="100%">
				<tr bgcolor="black" class="tableHeader">
<%
					If boolChange = True Then
%>
						<td class="gridheader" width="80">
							Response ID
						</td>
<%
					End If
%>
					
					<td class="gridHeader">
						Response
					</td>
				</tr>
<%
		Do until rsResults.EOF 
			intCounter = intCounter + 1
			intResponseID = rsResults("responseID")
			strResponse = rsResults("responseText")
						
			If utility_isPositiveInteger(intMatrixSetID) Then			
				If boolAliases = True Then
					strMatrixCategory = rsResults("category")
				Else
					strMatrixCategory = rsResults("alias")
				End If	
			If strMatrixCategory <> strCurrentMatrixCategory and len(strMatrixCategory) > 0 Then
				
%>
			
				<%=common_tableRow(intCounter)%>
<%
					If boolChange = True Then
%>
						<td class="gridheader">
							&nbsp;
						</td>
<%
					End If
%>				
					<td class="gridHeader"><b><%=strMatrixCategory%></b></td>
				</tr>
<%
			End If
			End If
%>
			
			<%=common_tableRow(intCounter)%>
<%
					If boolChange = True Then
%>
						<td class="griddata">
							<a href="viewResponseDetails.asp?responseID=<%=intResponseID%>&surveyID=<%=intSurveyID%>">
								<%=intResponseID%></a>
						</td>
<%
					End If
%>			
				<td class="gridData"><%=strResponse%></td>
			</tr>
<%
				strCurrentMatrixCategory = strMatrixCategory
			rsResults.MoveNext
		Loop
%>
		</table>
	
<%
	End If

End Function

Function reports_singleLineMatrixResults(intItemID, intSurveyID, boolChange, _ 
			intDrillDownItemID, intConditionType, strDrilldownResponse, intDrilldownCategory, intMatrixSetID, boolAliases, boolPointSearch, intLowScore, intHighScore, intAnswerID,strItemText,strSetText, intCategoryID, strCategory)
	Dim strSQL
	Dim rsResults
	Dim strResponse
	Dim intNumberResponses
	Dim intCounter
	Dim strMatrixCategory
	Dim strCurrentMatrixCategory
	Dim intResponseID

%>
<br /><br /><span class="normalBold-Big"><%=strItemText%>
<%
If len(strCategory) > 0 Then
%>
	- <%=strCategory%>
<%
End If

If len(strSetText) > 0 Then
%>
	( <%=strSetText%> )
<%
End If
%>
</span>
<%
	
	If utility_isPositiveInteger(intDrilldownItemID) and (len(strDrilldownResponse) > 0 or intConditionType = SV_CONDITION_DID_NOT_ANSWER or intConditionType = SV_CONDITION_ANSWERED or utility_isPositiveInteger(intAnswerID)) Then
		strSQL = "SELECT RD.responseID, RD.response as responseText " 
		 		 
		 		 
		 		 If utility_isPositiveInteger(intMatrixSetID) Then
					strSQL = strSQL & ", MC.category, MC.alias FROM usd_responseDetails RD INNER JOIN usd_matrixCategories MC ON MC.categoryID = RD.matrixCategoryID "
				 Else
					strSQL = strSQL & " FROM usd_responseDetails RD "
				 End If
		 		 
				 strSQL = strSQL & "WHERE RD.itemID = " & intItemID & " AND (RD.response IS NOT NULL AND RD.response NOT LIKE '') "
				 
				 If utility_isPositiveInteger(intMatrixSetID) Then
					strSQL = strSQL & " AND matrixSetID = " & intMatrixSetID 
				 End If
				strSQL = strSQL & " AND MC.categoryID = " & intCategoryID
				strSQL = strSQL & " AND " & reports_getItemSQL(intSurveyID, intDrilldownItemID, intConditionType, strDrilldownResponse, 0)  &_
				 " ORDER BY matrixCategoryID, responseID"
				 
				 
	Else
		
			strSQL = "SELECT RD.responseID, RD.response as responseText "  		 
			If utility_isPositiveInteger(intMatrixSetID) Then
				strSQL = strSQL & ", MC.category, MC.alias  FROM usd_responseDetails RD INNER JOIN usd_matrixCategories MC ON MC.categoryID = RD.matrixCategoryID "
			Else
				strSQL = strSQL & " FROM usd_responseDetails RD "
			End If
		 		
			 strSQL = strSQL & "WHERE RD.itemID = " & intItemID & " AND (RD.response IS NOT NULL AND RD.response NOT LIKE '') "
				 
			 If utility_isPositiveInteger(intMatrixSetID) Then
				strSQL = strSQL & " AND matrixSetID = " & intMatrixSetID 
			 End If
			 strSQL = strSQL & " AND MC.categoryID = " & intCategoryID
			  If boolPointSearch = True Then
					strSQL = strSQL & " AND responseID IN(SELECT responseID FROM usd_response " &_
						"WHERE points >= " & intLowScore & " AND points <= " & intHighScore &_
						" AND surveyID = " & intSurveyID & " AND completed = 1)"
				End If
		
		strSQL = strSQL & " ORDER BY matrixCategoryID, responseID"
		
	
	End If
	
		
	Set rsResults = utility_getRecordset(strSQL)
	If rsResults.EOF Then
%>
		<br /><span class="message">No responses</span><br />
<%		
	Else
		intCounter = 0
%>	
		<table border="1" cellpadding="2" bordercolor="#CCCCCC" cellspacing="0" width="100%">
				<tr bgcolor="black" class="tableHeader">
<%
					If boolChange = True Then
%>
						<td class="gridheader" width="80">
							Response ID
						</td>
<%
					End If
%>
					
					<td class="gridHeader">
						Response
					</td>
				</tr>
<%
		Do until rsResults.EOF 
			intCounter = intCounter + 1
			intResponseID = rsResults("responseID")
			strResponse = rsResults("responseText")
						
			If utility_isPositiveInteger(intMatrixSetID) Then			
				If boolAliases = True Then
					strMatrixCategory = rsResults("alias")
				Else
					strMatrixCategory = rsResults("category")
				End If	
			If strMatrixCategory <> strCurrentMatrixCategory and len(strMatrixCategory) > 0 Then
				
%>
			
				<%=common_tableRow(intCounter)%>
		
					<td class="gridHeader"><b><%=strMatrixCategory%></b></td>
<%
					If boolChange = True Then
%>
						<td class="gridheader">
							&nbsp;
						</td>
<%
					End If
%>		
				</tr>
<%
			End If
			End If
%>
			
			<%=common_tableRow(intCounter)%>
<%
					If boolChange = True Then
%>
						<td class="griddata">
							<a href="viewResponseDetails.asp?responseID=<%=intResponseID%>&surveyID=<%=intSurveyID%>">
								<%=intResponseID%></a>
						</td>
<%
					End If
%>			
				<td class="gridData"><%=strResponse%></td>
			</tr>
<%
				strCurrentMatrixCategory = strMatrixCategory
			rsResults.MoveNext
		Loop
%>
		</table>
	
<%
	End If

End Function



Function FusionCharts(strURL)
	strURL = replace(strURL,"?","*")
	strURL = replace(strURL,"&","*")	
	FusionCharts = strURL
End Function

'**************************************************************************************
'Name:			reports_displayItemResults
'
'Purpose:		display results for a particular survey item
'
'Inputs:		intItemID - unique ID of item to get results for
'				intSurveyID - unique ID of survey the item is in
'				boolDrilldown - whether or not to allow user to drill down to detailed results
'**************************************************************************************
Function reports_displayItemResults(intItemID, intSurveyID, boolDrilldown, intDrillDownItemID, intConditionType, strDrilldownResponse, strDrilldownCategory, boolAliases, strItemText, intMatrixSetID, intMatrixSetType, strSetText, intDrilldownAnswerID, boolPointSearch, intHighScore, intLowScore, intMatrixCategoryID, strCategory)
	Dim strSQL
	Dim rsResults
	Dim strResponse
	Dim intNumberResponses
	Dim intCounter
	Dim intTotalResponses
	Dim dblPercent
	Dim intBarWidth
	Dim intItemType
	Dim intCategoryID
	Dim intAnswerID
	Dim rsResponses

Set rsResults = server.CreateObject("ADODB.Recordset")
	
If not utility_isPositiveInteger(intMatrixSetID) Then
	intMatrixSetID = 0
	intCategoryID = 0
End If	
	
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
		intTotalResponses = rsResults.RecordCount
	Else
		intTotalResponses = 0 
	End If
	rsResults.Close
ElseIf utility_isPositiveInteger(intDrilldownItemID) and (len(strDrilldownResponse) > 0 or utility_isPositiveInteger(intAnswerID) or _
						intConditionType = SV_CONDITION_DID_NOT_ANSWER or intConditionType = SV_CONDITION_ANSWERED) Then
	strSQL = "SELECT distinct(RD.responseID) as maxResponses FROM usd_responseDetails RD WHERE itemID = " & intItemID &_
			 " AND response IS NOT NULL or answerID > 0 " &_
			 " AND  " & reports_getItemSQL(intSurveyID, intDrilldownItemID, intConditionType, strDrilldownResponse, intAnswerID) &_
			 " AND RD.matrixSetID = " & intMatrixSetID
	rsResults.CursorLocation = adUseClient
	rsResults.Open strSQL, DB_CONNECTION
	If not rsResults.EOF Then
		intTotalResponses = rsResults.RecordCount
	Else
		intTotalResponses = 0 
	End If
	rsResults.Close
Else	
	strSQL = "SELECT sum(numberResponses) as maxResponses FROM usd_itemResponses WHERE itemID = " & intItemID &_
			 " AND matrixSetID = " & intMatrixSetID &_
			 " AND matrixCategoryID = " & intMatrixCategoryID
	rsResults.CursorLocation = adUseClient
	rsResults.Open strSQL, DB_CONNECTION
	If not rsResults.EOF Then
		intTotalResponses = rsResults("maxResponses")
	Else
		intTotalResponses = 0 
	End If
	rsResults.Close
End If		 
Set rsResults = NOTHING
	
	If not utility_isPositiveInteger(intMatrixSetID) Then
		strSQL = "SELECT itemText, alias, itemType " &_
				 "FROM usd_SurveyItem " &_
				 "WHERE itemID = " & intItemID 
	Else
		strSQL = "SELECT SI.itemText, SI.alias, SI.itemType, MS.numberResponses " &_
				 "FROM usd_SurveyItem SI, usd_matrixSets MS, usd_matrixCategories MC " &_
				 "WHERE SI.itemID = " & intItemID &_
				 " AND SI.itemID = MS.itemID " &_
				 " AND MS.matrixSetID = " & intMatrixSetID &_
				 " AND MC.itemID = SI.itemID " &_
				 " AND MC.categoryID = " & intMatrixCategoryID
	End If				 
	
	
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		intItemType = rsResults("itemType")
	End If

%>
	<table cellpadding="4" cellspacing="0" width="100%" class="normal" border="0" bordercolor="black">
	<tr>
		<td>
	<span class="normalBold-Big"><%=strItemText%>
<%
	If len(strCategory) > 0 Then
%>
		- <%=strCategory%>
<%
	End If
	If len(strSetText) > 0 Then
%>
		( <%=strSetText%> )
<%
	End If
%>	
	</span><br />
<%
	rsResults.Close
	Set rsResults = NOTHING
	
	If intTotalResponses = 0 Then
%>
		<span class="message">No Responses</span>
<%
	Else
	strSQL = "SELECT IR.answerID, IR.responseText, IR.numberResponses, IR.matrixCategoryID " 
	
	If utility_isPositiveInteger(intMatrixSetID) Then
		strSQL = strSQL & ", MC.category, MC.alias FROM usd_itemResponses IR INNER JOIN usd_matrixCategories MC ON IR.matrixCategoryID = MC.categoryID "
	Else 
		strSQL = strSQL & "FROM usd_itemResponses IR " 
	End If
	strSQL = strSQL &  "WHERE IR.itemID = " & intItemID &_
			 " AND ((IR.responseText IS NOT NULL and IR.responseText NOT LIKE '') or IR.answerID > 0)"
	If utility_isPositiveInteger(intMatrixSetID) Then
		strSQL = strSQL & " AND IR.matrixSetID = " & intMatrixSetID &_
						 " AND IR.matrixCategoryID = " & intMatrixCategoryID
		
	End If
	
	strSQL = strSQL & " ORDER by IR.matrixCategoryID, IR.answerID "
	
	Set rsResults = utility_getRecordset(strSQL)
	If rsResults.EOF Then
%>
		<span class="message">No Responses</span>
<%	
	Else
%>
		<table border="1" cellpadding="2" bordercolor="#CCCCCC" cellspacing="0" width="100%">
				<tr bgcolor="black" class="tableHeader">
					<td class="gridHeader">
						Response
					</td>	
					<td align="center" class="gridHeader" width="125" align="right">
						Response Count
					</td>
					<td class="gridHeader" width="125" align="right">
						Percentage
					</td>
				</tr>
<%
		

		'intTotalResponses = reports_totalItemResponses(intItemID)
		intCounter = 0	
		Do until rsResults.EOF
			intAnswerID = rsResults("answerID")
			If not utility_isPositiveInteger(intAnswerID) Then
				intAnswerID = 0
			End If
			intCategoryID = rsResults("matrixCategoryID")
			
			If utility_isPositiveInteger(intAnswerID) Then
				strResponse = reports_getResponse(intAnswerID, intMatrixSetID)
			Else
				strResponse = rsResults("responseText")
			End If
			
			
			If strResponse <> "" Then

			If boolPointSearch = True Then
					strSQL = "SELECT count(itemID) as numberResponses " &_
					"FROM usd_responseDetails " &_
					"WHERE itemID = " & intItemID &_
					" AND (response LIKE " & utility_SQLEncode(strResponse, True) &_
					" OR answerID = " & intAnswerID & ") " &_
					" AND matrixCategoryID = " & intCategoryID &_
					" AND matrixSetID = " & intMatrixSetID &_
					" AND responseID IN (SELECT responseID FROM usd_response " &_
					"WHERE points >= " & intLowScore & " AND points <= " & intHighScore &_
					" AND surveyID = " & intSurveyID & " AND completed = 1)" 

			ElseIf utility_isPositiveInteger(intDrilldownItemID) and (len(strDrilldownResponse) > 0 or utility_isPositiveInteger(intDrilldownAnswerID) or _
						intConditionType = SV_CONDITION_DID_NOT_ANSWER or intConditionType = SV_CONDITION_ANSWERED) Then
				strSQL = "SELECT count(RD.itemID) as numberResponses " &_
					"FROM usd_responseDetails RD " &_
					"WHERE RD.itemID = " & intItemID & " AND RD.answerID = " & intAnswerID &_
						" AND RD.matrixCategoryID = " & intCategoryID &_
						" AND RD.matrixSetID = " & intMatrixSetID &_
						" AND " & reports_getItemSQL(intSurveyID, intDrilldownItemID, intConditionType, strDrilldownResponse, intDrilldownAnswerID) 
			Else
			
				If intItemType = SV_ITEM_TYPE_MATRIX Then
					strSQL = "SELECT IR.numberResponses, IR.responseText, A.alias " &_
							 " FROM usd_itemResponses IR LEFT JOIN usd_matrixAnswers A " &_
							 "ON IR.answerID = A.matrixAnswerID " &_
							 "WHERE IR.itemID = " & intItemID & " AND IR.answerID = " & intAnswerID &_
							" AND IR.matrixCategoryID = " & intCategoryID &_
							" AND IR.matrixSetID = " & intMatrixSetID
							
				Else
				
					strSQL = "SELECT IR.numberResponses, A.alias " &_
							 " FROM usd_itemResponses IR, usd_Answers A " &_
							 "WHERE IR.answerID = A.AnswerID " &_
							 "AND IR.itemID = " & intItemID & " AND A.AnswerID = " & intAnswerID 
							
				End If
						
			End If
			Set rsResponses = utility_getRecordset(strSQL)
			If not rsResponses.EOF Then
				intNumberResponses = rsResponses("numberResponses") 
				dblPercent = utility_getPercentage(intNumberResponses,intTotalResponses)
				
				If intNumberResponses > 0 Then
			
				intCounter = intCounter + 1
			If boolAliases = True Then
				If utility_isPositiveInteger(intAnswerID) Then
					strResponse = survey_getAlias(intItemID, strResponse, intMatrixSetID)
				End If
				
				strCategory = survey_getCategoryAlias(intItemID, strCategory)
			End If
%>
			<%=common_tableRow(intCounter)%>
			
		

				<td class="gridData">
					<%=strResponse%>&nbsp;
				</td>

				<td valign="middle" align="right" class="gridData">

<%
				If boolDrillDown = True and intItemType <> SV_ITEM_TYPE_MATRIX  and boolAliases = False Then
%>
				<a class="normalBold"
					href="viewResponses.asp?surveyID=<%=intSurveyID%>&drilldownitemID=<%=intItemID%>&response=<%=server.URLEncode(strResponse)%>">
					<%=intNumberResponses%></a>
<%
				Else
%>
					<%=intNumberResponses%>
<%
				End If
%>
				</td>
				<td valign="middle" class="gridData" align="right">
				<%=dblPercent%> %
				</td>
			</tr>

<%
			
				End If
			End If
			rsResponses.Close
			Set rsResponses = NOTHING
			
			End If
			
			rsResults.MoveNext
		Loop
%>
				<%=common_tableRow(intCounter + 1)%>

				<td class="normalBold" align="right">
					Totals
				</td>
				<td class="normalBold" align="right">
					<%=intTotalResponses%>
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
	</table>
	</td>
	</tr>
<%
	End If

	rsResults.Close
	Set rsResults = NOTHING
	
	End If	
%>
	</table>
	<hr noshade color="#C0C0C0" size="2">

<%
End Function


'**************************************************************************************
'Name:			reports_totalItemResponses
'
'Purpose:		determine the total number of times the item has been responded to
'
'Inputs:		intItemID - unique ID of item to get number of responses for
'**************************************************************************************
Function reports_totalItemResponses(intItemID)
	Dim strSQL
	Dim rsResults 
	strSQL = "SELECT numberResponses " &_
			 " FROM usd_surveyItem " &_
			 "WHERE itemID = " & intItemID
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		reports_totalItemResponses = rsResults("numberResponses")
	Else
		reports_totalItemResponses = 0
	End If
	rsResults.Close
	Set rsResults = NOTHING		
End Function


'**************************************************************************************
'Name:			reports_displayResponseDetails
'
'Purpose:		display details of a response to the survey
'
'Inputs:		intResponseID - unique ID of the response
'**************************************************************************************
Function reports_displayResponseDetails(intResponseID)
	Dim strSQL
	Dim rsResults
	Dim strCategory
	Dim intCurrentItemID
	Dim intItemID
	Dim strQuestion
	Dim boolShowQuestion
	Dim intItemType
	Dim boolMatrix
	Dim boolQuestionShown
	Dim intCounter
	Dim strSetText
	Dim strResponse
	Dim intAnswerID
	Dim intMatrixSetID
	Dim intPipedItemID1
	Dim intPipedItemID2
	Dim intPipedItemID3
	
	strSQL = "SELECT SI.itemText, SI.itemType, MC.category, RD.itemID, RD.answerID, RD.matrixSetID, RD.response, RD.setText, " &_
			 "SI.pipedItemID1, SI.pipedItemID2, SI.pipedItemID3 " &_
			 "FROM (usd_ResponseDetails RD " &_
			 "INNER JOIN usd_surveyItem SI " &_
			 "ON RD.itemID = SI.itemID) " &_
			 "LEFT OUTER JOIN usd_matrixCategories MC ON MC.categoryID = RD.matrixCategoryID " &_
			 "WHERE responseID = " & intResponseID &_
			 " AND (response IS NOT NULL OR answerID > 0) " &_
			 " ORDER BY responseDetailID "

	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		intCounter = 0
%>
		<table class="normal" width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr class="tableHeader" bgcolor="black">
				<td width="50%">
					Question
				</td>
				<td width="50%">
					Answer
				</td>
			</tr>
<%

		Do until rsResults.EOF
			intItemType = rsResults("itemType")
			If intItemType = SV_ITEM_TYPE_MATRIX Then
				boolMatrix = True
			Else
				boolMatrix = False
			End If
		
			intCounter = intCounter + 1
			strQuestion = rsResults("itemText")
			strCategory = rsResults("category")
			intItemID = rsResults("itemID")
			intAnswerID = rsResults("answerID")
			intMatrixSetID = rsResults("matrixSetID")
			
			If utility_isPositiveInteger(intAnswerID) Then
				strResponse = reports_getResponse(intAnswerID, intMatrixSetID)
			Else
				strResponse = rsResults("response")
			End If
			
			If utility_isPositiveInteger(intMatrixSetID) Then
				strSetText = reports_getMatrixSetText(intMatrixSetID)
			Else		
				strSetText = rsResults("setText")
			End If
			
			intPipedItemID1 = rsResults("pipedItemID1")
			intPipedItemID2 = rsResults("pipedItemID2")
			intPipedItemID3 = rsResults("pipedItemID3")
			

			If utility_isPositiveInteger(intPipedItemID1) Then
				strResponse = response_pipeAnswer(1,intResponseID, intPipedItemID1, strResponse)
				strQuestion = response_pipeAnswer(1,intResponseID, intPipedItemID1, strQuestion)
				strSetText = response_pipeAnswer(1,intResponseID, intPipedItemID1, strSetText)
				strCategory = response_pipeAnswer(1,intResponseID, intPipedItemID1, strCategory)
			End If
		
			If utility_isPositiveInteger(intPipedItemID2) Then
				strResponse = response_pipeAnswer(2,intResponseID, intPipedItemID2, strResponse)
				strQuestion = response_pipeAnswer(2,intResponseID, intPipedItemID2, strQuestion)
				strSetText = response_pipeAnswer(2,intResponseID, intPipedItemID2, strSetText)
				strCategory = response_pipeAnswer(2,intResponseID, intPipedItemID2, strCategory)
			End If
		
			If utility_isPositiveInteger(intPipedItemID3) Then
				strResponse = response_pipeAnswer(3,intResponseID, intPipedItemID3, strResponse)
				strQuestion = response_pipeAnswer(3,intResponseID, intPipedItemID3, strQuestion)
				strSetText = response_pipeAnswer(3,intResponseID, intPipedItemID3, strSetText)
				strCategory = response_pipeAnswer(3,intResponseID, intPipedItemID3, strCategory)
			End If
					
			
			
				
			If intItemID <> intCurrentItemID Then
				boolQuestionShown = False
				intCurrentItemID = intItemID
			Else
				boolQuestionShown = True
			End If
			
			If boolQuestionShown = False and boolMatrix = True Then
				boolQuestionShown = True
%>					
			<%=common_tableRow(intCounter)%>
				<td width="50%" valign="top" class="normalBold">
						<%=strQuestion%>
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
<%
			
			End If
			
			If boolMatrix = True Then
			
%>
			<%=common_tableRow(intCounter)%>
				<td width="50%" valign="top">
						<%=strCategory%>
<%
					If len(trim(strSetText)) > 0 Then
%>
						( <%=strSetText%> )
<%
					End If
%>
				</td>
				<td width="50%" valign="top">
					<%=strResponse%>
				</td>
			</tr>

<%
			ElseIf boolMatrix = False Then
%>
			<%=common_tableRow(intCounter)%>
				<td width="50%" valign="top" class="normalBold">
						<%=strQuestion%>
				</td>
				<td width="50%" valign="top">
					<%=strResponse%>
				</td>
			</tr>
<%
			End If
			rsResults.MoveNext
		Loop
%>
		</table>
<%
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

'**************************************************************************************
'Name:			reports_getSurveyIDByResponseID
'
'Purpose:		returns the surveyID based on a responseID
'
'Inputs:		intResponseID - unique ID of the response
'**************************************************************************************
Function reports_getSurveyIDByResponseID(intResponseID)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT surveyID " &_
			 "FROM usd_Response " &_
			 "WHERE responseID = " & intResponseID 

	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		reports_getSurveyIDByResponseID = rsResults("surveyID")
	Else
		reports_getSurveyIDByResponseID = 0
	End If
	rsResults.Close
	Set rsResults = NOTHING

End Function

'**************************************************************************************
'Name:			reports_getItemText
'
'Purpose:		returns the text corresponding to an item
'
'Inputs:		intItemID - unique ID of item to get text for
'**************************************************************************************
Function reports_getItemText(intItemID)
	Dim strSQL
	Dim rsResults
	strSQL = "SELECT itemText " &_
			 "FROM usd_SurveyItem " &_
			 "WHERE itemID = " & intItemID 

	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		reports_getItemText = rsResults("itemText")
	End If
	rsResults.Close
	Set rsResults = NOTHING

End Function

'**************************************************************************************
'Name:			reports_surveyDropdown
'
'Purpose:		create a dropdown menu of surveys the user can view reports for
'
'Inputs:		intDefaultSurveyID - unique ID of survey to be selected by default in dropdown
'				intUserID - uniqueID of current user (optional)
'				intUserType - user type of current user (optional)
'
'Outputs:		boolSurveysExist - returns true/false if surveys were found
'**************************************************************************************
Function reports_surveyDropdown(intDefaultSurveyID, intUserID, intUserType, boolSurveysExist)
	Dim strSQL
	Dim rsResults
	Dim intSurveyID
	strSQL = "SELECT surveyID, surveyTitle " &_
			 "FROM usd_Survey " 
	If intUserType = SV_USER_TYPE_CREATOR Then
		strSQL = strSQL & "WHERE ownerUserID = " & intUserID &_
						  " OR (privacyLevel <> " & SV_PRIVACY_LEVEL_PRIVATE & " AND isActive = 1)"
	ElseIf intUserType <> SV_USER_TYPE_ADMINISTRATOR Then
		strSQL = strSQL & "WHERE privacyLevel <> " & SV_PRIVACY_LEVEL_PRIVATE &_
						  " AND isActive = 1"
	End If
	strSQL = strSQL & " ORDER BY surveyTitle "
	Set rsResults = utility_getRecordset(strSQL)
	If rsResults.EOF Then
		boolSurveysExist = False
	Else
		boolSurveysExist = True
%>
		<select name="surveyID">
<%
		Do until rsResults.EOF
			intSurveyID = rsResults("surveyID")
%>
			<option value="<%=intSurveyID%>"
<%
			If intSurveyID = intDefaultSurveyID Then
%>
				selected
<%
			End If
%>
			>
				<%=rsResults("surveyTitle")%>
			</option>
<%
			rsResults.MoveNext
		Loop
%>
		</select>
<%
	End If
	rsResults.Close
	Set rsResults = NOTHING
	
	
End Function

'**************************************************************************************
'Name:			reports_getItemSQL
'
'Purpose:		gets SQL Where Clause for conditional reports
'
'Inputs:		intSurveyID - unique ID of survey to get reports for
'				intItemID - unique ID of item to get reports for
'				intConditionID - type of condition to evaluate
'				strResponse - text of response to evaluate
'**************************************************************************************
Function reports_getItemSQL(intSurveyID, intItemID, intConditionID, strResponse, intAnswerID)
	
	Dim strWhere
	Dim strResponseQuery

	strResponseQuery = strResponse

	Select case cint(intConditionID)
		Case SV_CONDITION_EQUALS_ID
			 If utility_isPositiveInteger(intAnswerID) Then
				strWhere = " (RD.responseID IN (SELECT responseID FROM usd_responseDetails RD" &_
						   " WHERE RD.answerID = " & intAnswerID &_
					       " AND RD.itemID = " & intItemID & " )) " 
			 Else	
				strWhere = " (RD.responseID IN (SELECT responseID FROM usd_responseDetails RD WHERE (RD.response LIKE " & utility_SQLEncode(strResponseQuery, True) &_
					    " AND RD.itemID = " & intItemID & ") or responseID IN  (SELECT RD.responseID FROM usd_responseDetails RD, usd_answers A WHERE " &_
					       " RD.answerID = A.answerID AND A.answerText LIKE " & utility_SQLEncode(strResponse, True) & " AND RD.itemID = " & intItemID & "))) "
			 End If
		Case SV_CONDITION_NOT_EQUAL_ID
			 If utility_isPositiveInteger(intAnswerID) Then
				strWhere = " (RD.responseID NOT IN (SELECT responseID FROM usd_responseDetails RD WHERE RD.answerID = " & intAnswerID &_
					    " AND RD.itemID = " & intItemID & ")) " 
			 Else
				strWhere = " (RD.responseID NOT IN (SELECT responseID FROM usd_responseDetails RD WHERE (RD.response LIKE " & utility_SQLEncode(strResponseQuery, True) &_
					    " AND RD.itemID = " & intItemID & ") or responseID IN  (SELECT RD.responseID FROM usd_responseDetails RD, usd_answers A WHERE " &_
					       " RD.answerID = A.answerID AND A.answerText LIKE " & utility_SQLEncode(strResponse, True) & " AND RD.itemID = " & intItemID & "))) "
			 End If
		Case SV_CONDITION_GREATER_THAN_ID
			 If DATABASE_TYPE = "SQLServer" Then
			 	strWhere = " (RD.responseID NOT IN (SELECT RD.responseID FROM usd_responseDetails RD WHERE cast(RD.response as varchar(255)) > " 
			 	
			 	If utility_isPositiveInteger(strResponse) Then
			 		strWhere = strWhere & strResponse
			 	Else
			 		strWhere = strWhere & utility_SQLEncode(strResponse,True)
			 	End If
					strWhere = strWhere & " AND RD.itemID = " & intItemID & ")" &_
					    " OR RD.responseID IN (SELECT RD.responseID FROM usd_responseDetails RD, usd_answers A WHERE RD.itemID = " & intItemID &_
						" AND RD.answerID = A.answerID AND A.answerText > " & utility_SQLEncode(strResponse,True) & ")) "
			Else
				strWhere = " (RD.responseID NOT IN (SELECT RD.responseID FROM usd_responseDetails RD WHERE  > " 
			 	
			 	If utility_isPositiveInteger(strResponse) Then
			 		strWhere = strWhere & strResponse
			 	Else
			 		strWhere = strWhere & utility_SQLEncode(strResponse,True)
			 	End If
					strWhere = strWhere & " AND RD.itemID = " & intItemID & ")" &_
					    " OR RD.responseID IN (SELECT RD.responseID FROM usd_responseDetails RD, usd_answers A WHERE RD.itemID = " & intItemID &_
						" AND RD.answerID = A.answerID AND A.answerText > " & utility_SQLEncode(strResponse,True) & ")) "
			End If
		Case SV_CONDITION_LESS_THAN_ID
			 If DATABASE_TYPE = "SQLServer" Then
			 	strWhere = " (RD.responseID NOT IN (SELECT RD.responseID FROM usd_responseDetails RD WHERE cast(RD.response as varchar(255)) < " 
			 	
			 	If utility_isPositiveInteger(strResponse) Then
			 		strWhere = strWhere & strResponse
			 	Else
			 		strWhere = strWhere & utility_SQLEncode(strResponse,True)
			 	End If
					strWhere = strWhere & " AND RD.itemID = " & intItemID & ")" &_
					    " OR RD.responseID IN (SELECT RD.responseID FROM usd_responseDetails RD, usd_answers A WHERE RD.itemID = " & intItemID &_
						" AND RD.answerID = A.answerID AND A.answerText > " & utility_SQLEncode(strResponse,True) & ")) "
			Else
				strWhere = " (RD.responseID NOT IN (SELECT RD.responseID FROM usd_responseDetails RD WHERE  < " 
			 	
			 	If utility_isPositiveInteger(strResponse) Then
			 		strWhere = strWhere & strResponse
			 	Else
			 		strWhere = strWhere & utility_SQLEncode(strResponse,True)
			 	End If
					strWhere = strWhere & " AND RD.itemID = " & intItemID & ")" &_
					    " OR RD.responseID IN (SELECT RD.responseID FROM usd_responseDetails RD, usd_answers A WHERE RD.itemID = " & intItemID &_
						" AND RD.answerID = A.answerID AND A.answerText > " & utility_SQLEncode(strResponse,True) & ")) "
			End If
		Case SV_CONDITION_CONTAINS_ID
			 strWhere = " (RD.responseID IN (SELECT RD.responseID FROM usd_responseDetails WHERE RD.response LIKE '%" & strResponse & "%'" &_
					    " AND RD.itemID = " & intItemID & ")" &_
					    " OR RD.responseID IN (SELECT RD.responseID FROM usd_responseDetails RD, usd_answers A WHERE RD.itemID = " & intItemID &_
						" AND RD.answerID = A.answerID AND A.answerText LIKE '%" & strResponse & "%' )) "
		Case SV_CONDITION_DOES_NOT_CONTAIN_ID
			 strWhere = " (RD.responseID IN (SELECT RD.responseID FROM usd_responseDetails WHERE RD.response NOT LIKE '%" & strResponse & "%'" &_
					    " AND RD.itemID = " & intItemID & ")" &_
					    " OR RD.responseID IN (SELECT RD.responseID FROM usd_responseDetails RD, usd_answers A WHERE RD.itemID = " & intItemID &_
						" AND RD.answerID = A.answerID AND A.answerText NOT LIKE '%" & strResponse & "%' )) "
		Case SV_CONDITION_ANSWERED
			 strWhere = " (itemID = " & intItemID & " AND (response is not null or answerID > 0)) " 
		Case SV_CONDITION_DID_NOT_ANSWER
			 strWhere = " ((RD.responseID IN " &_
						"(SELECT responseID FROM usd_responseDetails " &_
						"WHERE itemID = " & intItemID & " AND (response IS NULL AND answerID = 0)) OR (RD.responseID NOT IN(" &_
						"SELECT responseID FROM usd_responseDetails WHERE itemID = " & intItemID & ")))) "
		End Select
	reports_getItemSQL = strWhere
End Function



'**************************************************************************************
'Name:			reports_reportSearchForm
'
'Purpose:		create form to search results of survey
'
'Inputs:		intSurveyID - unique ID of survey to search
'				intUserID - unique ID of current user
'**************************************************************************************
Function reports_reportSearchForm(intSurveyID, intUserID)
	Dim boolQuestionsExist
	Dim boolSurveysExist
	
	boolSurveysExist = user_hasSurveys(intUserID, intUserType)

	If boolSurveysExist = False Then
%>
		<span class="message">There are no surveys for you to view reports for</span>
<%
	Else
%>
	<table class="normalBold" border="0" cellpadding="0" cellspacing="0">
	<tr>
	<td>
	<form method="get" action="viewResponses.asp" id=form1 name=form1>
		Survey:
		<%=reports_surveyDropdown(intSurveyID, intUserID, intUserType, boolSurveysExist)%>
<%
		If utility_isPositiveInteger(intSurveyID) Then
%>
	
			
		
			<input type="hidden" name="submit" value="Change Survey">
			<input type="image" src="images/button-changeSurvey.gif" alt="Change Survey" border="0">
			&nbsp;&nbsp;
			</form>
			</td>
			<td>
			<form method="get" action="viewResults.asp">
				<input type="hidden" name="surveyID" value="<%=intSurveyID%>"></input>
				<input type="hidden" value="View Summary Results">
				<input type="image" src="images/button-summaryResults.gif" alt="Summary Results" border="0">
			</form>
			
<%
		Else
%>
			<input type="hidden" name="submit" value="View Results">
			<input type="image" src="images/button-viewResults.gif" alt="View Results" border="0">
			</form>
<%
		End If
%>
		
		
		</td>
		</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		
<%
	End If

End Function

'**************************************************************************************
'Name:			reports_displayResponseSummary
'
'Purpose:		display summary details of a response, such as username and time taken
'
'Inputs:		intResponseID - uniqueID of response to display summary for
'				boolScored - whether or not the survey is scored
'**************************************************************************************
Function reports_displayResponseSummary(intResponseID, boolScored, boolLogNTUser)
	Dim strSQL
	Dim rsResults
	Dim dtmTimeStarted
	Dim dtmTimeCompleted
	Dim intUserID
	Dim strFirstName
	Dim strLastName
	Dim strEmail
	Dim strTitle
	Dim strCompany
	Dim strLocation
	Dim intPoints
	Dim strNetworkUsername
	
	strSQL = "SELECT userID, dateStarted, dateCompleted, userIP, points, NTUser " &_
			 "FROM usd_Response " &_
			 "WHERE responseID = " & intResponseID 
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		intUserID = rsResults("userID")
		dtmTimeStarted = rsResults("dateStarted")
		dtmTimeCompleted = rsResults("dateCompleted")
		intPoints = rsResults("points")
		strNetworkUsername = rsResults("NTUser")
	End If
	rsResults.Close
	If utility_isPositiveInteger(intUserID) Then
		strSQL = "SELECT firstName, lastName, email, title, company, location " &_
				 "FROM usd_surveyUser " &_
				 "WHERE userID = " & intUserID
		rsResults.Open strSQL, DB_CONNECTION
		If not rsResults.EOF Then
			strFirstName = rsResults("firstName")
			strLastName = rsResults("lastName")
			strEmail = rsResults("email")
			strTitle = rsResults("title")
			strCompany = rsResults("company")
			strLocation	= rsResults("location")
		End If
		rsResults.Close
	End If
	Set rsResults = NOTHING

%>
		<table class="normal">
			<tr>
				<td>
					<span class="normalBold">User:</span> 
					<%=user_getUsername(intUserID)%>
				</td>
				<td>
					<span class="normalBold">Email:</span>
					<%=strEmail%>
				</td>
			</tr>
			<tr>
				<td>
					<span class="normalBold">Name:</span> 
					<%=strFirstName%>&nbsp;<%=strLastName%>
				</td>
				<td>
					<span class="normalBold">Title:</span>
					<%=strTitle%>
				</td>
			</tr>
			<tr>
				<td>
					<span class="normalBold">Company:</span> 
					<%=strCompany%>
				</td>
				<td>
					<span class="normalBold">Location:</span>
					<%=strLocation%>
				</td>
			</tr>
<%
			If boolLogNTUser = True Then
%>
			<tr>
				<td class="normalBold">
					Network Username:
				</td>
				<td>
					<%=strNetworkUsername%>
				</td>
			</tr>
<%
			End If
%>

			<tr>
				<td>
					&nbsp;
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<table class="normal">
						<tr>
							<td class="normalBold">
								Time Started:
							</td>
							<td>
								<%=dtmTimeStarted%>
							</td>
						</tr>
						<tr>
							<td class="normalBold">
								Time Completed:
							</td>
							<td>
								<%=dtmTimeCompleted%>
							</td>
						</tr>
						<tr>
							<td class="normalBold">
								Total Time:
							</td>
							<td>
								<%=dateDiff("N",dtmTimeStarted, dtmTimeCompleted)%> Minute(s)
							</td>
						</tr>
<%
						If boolScored = True Then
%>
							<tr>
								<td class="normalBold">
									Score:
								</td>
								<td>
									<%=intPoints%>
								</td>
							</tr>
<%
						End If
%>
					</table>
				</td>
			<tr>
				<td>
					&nbsp;
				</td>
			</tr>
		</table>
	
<%
End Function

Function reports_getReportingLevel(intUserID, intUserType, intSurveyID)
	If survey_surveyExists(intSurveyID) = False Then
		reports_getReportingLevel = SV_REPORT_PERMISSION_DENIED
	ElseIf survey_getPrivacyLevel(intSurveyID) = SV_PRIVACY_LEVEL_DETAILS Then
		reports_getReportingLevel = SV_REPORT_PERMISSION_FULL
	ElseIf survey_getOwnerID(intSurveyID) = intUserID Then
		reports_getReportingLevel = SV_REPORT_PERMISSION_FULL
	ElseIf intUserType = SV_USER_TYPE_ADMINISTRATOR Then
		reports_getReportingLevel = SV_REPORT_PERMISSION_FULL
	ElseIf survey_getPrivacyLevel(intSurveyID) = SV_PRIVACY_LEVEL_PRIVATE Then
		reports_getReportingLevel = SV_REPORT_PERMISSION_DENIED
	ElseIf survey_getPrivacyLevel(intSurveyID) = SV_PRIVACY_LEVEL_SUMMARY Then
		reports_getReportingLevel = SV_REPORT_PERMISSION_SUMMARY
	End If

End Function

Function reports_getResponse(intAnswerID, intMatrixSetID)
	Dim strSQL
	Dim rsResults
	
	If utility_isPositiveInteger(intMatrixSetID) Then
		strSQL = "SELECT answerText FROM usd_matrixAnswers WHERE matrixAnswerID = " & intAnswerID
	Else	
		strSQL = "SELECT answerText FROM usd_answers WHERE answerID = " & intAnswerID
	End If
	
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		reports_getResponse = rsResults("answerText")
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function reports_getMatrixSetText(intMatrixSetID)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT setText FROM usd_matrixSets WHERE matrixSetID = " & intMatrixSetID
	
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		reports_getMatrixSetText = rsResults("setText")
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function reports_searchConditionsDropdown(intDefaultConditionID)
	Dim strSQL
	Dim rsResults
	Dim intConditionType
	strSQL = "SELECT conditionTypeID, conditionTypeText " &_
							 "FROM usd_ConditionTypes " &_
							 "WHERE conditionTypeID NOT IN(" & SV_CONDITION_GREATER_THAN_ID & "," & SV_CONDITION_LESS_THAN_ID & ") " &_
							 "ORDER by orderByID "
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
%>
		<select name="conditionType">
			<option value="">Select an Operator</option>
<%
		Do until rsResults.EOF
			intConditionType = rsResults("conditionTypeID")
%>
			<option value="<%=intConditionType%>"
<%
			If intConditionType = cint(intDefaultConditionID) Then
%>
				selected
<%
			End If
%>
			>
				<%=rsResults("conditionTypeText")%>
			</option>
<%
			rsResults.moveNext
		Loop
%>
		</select>
<%
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function
%>

