<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		addItem.asp 
' Purpose:	page to add items to a survey
'
'
' Author:	    Ultimate Software Designs
' Date Written:	6/24/2002
' Modified:		
'
' Changes:
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/addItems_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/surveyCreation_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim intUserType
	Dim intUserID
	Dim intSurveyID
	Dim strSQL
	Dim rsResults
	Dim intItemTypeSelected
	Dim intItemType
	Dim strItemText
	Dim strDescription
	Dim intDataType
	Dim strMinimumValue
	Dim strMaximumValue
	Dim strDefaultValue
	Dim intCounter
	Dim strAnswerText
	Dim boolDefault
	Dim boolRequired
	Dim boolAllowOther
	Dim strOtherText
	Dim intPageID
	Dim intItemIDOut
	Dim intNumberAnswers
	Dim intOrderByID
	Dim intNumberAnswerInputs
	Dim strCurrentPage
	Dim intLayoutStyle
	Dim strUploadedImage
	Dim boolRandomize
	Dim boolNumberLabels
	Dim intPresetAnswerGroup
	Dim boolScored
	Dim intPoints
	Dim strAlias
	Dim strQuestionAlias
	Dim strCategoryText
	Dim strCategoryAlias
	Dim intNumberCategories
	Dim strItemType
	Dim intItemCategoryID
	Dim strLibraryName
	Dim intMessage
	Dim strMessage
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	

	
	'get values from page request
	intSurveyID = cint(Request.QueryString("surveyID"))
	intItemTypeSelected = cint(Request.QueryString("itemType"))
	intPageID = cint(Request.QueryString("pageID"))
	intItemCategoryID = Request.QueryString("categoryID")
	
	'validate user credentials
	If utility_isPositiveInteger(intSurveyID) = True and utility_isPositiveInteger(intItemCategoryID) = False Then
		If ((survey_getOwnerID(intSurveyID) <> intUserID) _
				and intUserType = SV_USER_TYPE_CREATOR) _
				or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
			Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
		End If
	End If

	intMessage = request.QueryString("message")
	If utility_isPositiveInteger(intMessage) Then
		Select Case cint(intMessage)
			Case SV_MESSAGE_NO_ITEMS
				strMessage = "Survey contains no items.  Please choose an item to add."
		End Select
	End If
	
	'extend user cookie
	'if page ID not selected
	If not utility_isPositiveInteger(intPageID) Then
		'get next pageID for this survey
		intPageID = surveyCreation_getNextPageID(intSurveyID)
	End If

	If utility_isPositiveInteger(intItemTypeSelected) Then
		If utility_isPositiveInteger(intItemCategoryID) Then
			Call surveyCreation_addItem(0, intItemTypeSelected,"","","", _
					"", "", "", False, _ 
 					False, "", 0, 0, 0, _
 					intItemIDOut, False, False, "")
			strSQL = "INSERT INTO usd_itemCategoryMap(categoryID, itemID) " &_
					 "VALUES(" & intItemCategoryID & "," & intItemIDOut & ")"
			Call utility_executeCommand(strSQL)
		Else
			'Get next order by ID for survey/page combination
			intOrderByID = surveyCreation_getNextOrderByID(intSurveyID, intPageID)
		
			'add the item to the database
			Call surveyCreation_addItem(intSurveyID, intItemTypeSelected, "", "", _
								"", "", "", _
								"", False, False, _
								"Other:", intPageID, intOrderByID, "", _
								intItemIDOut, False, False, "")
			
		End If
			
		Response.Redirect("editItem.asp?surveyID=" & intSurveyID & "&pageID=" & intPageID & "&itemID=" & intItemIDOut &_
							 "&itemType=" & intItemTypeSelected & "&categoryID=" & intItemCategoryID)
	End If

	'get item types from database
	strSQL = "SELECT itemTypeID, itemTypeText, description " &_
			 "FROM usd_itemTypes " &_
			 "ORDER by orderByID "
	
	Set rsResults = utility_getRecordset(strSQL)
	If rsResults.EOF Then
		rsResults.Close
		Set rsResults = NOTHING
		Response.Redirect("index.asp?message=" & SV_MESSAGE_UNKNOWN_ERROR)
	End If
	

		
%> 
	<%=header_htmlTop("white","")%>
	<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>

	
<%
	If utility_isPositiveInteger(intSurveyID) Then
%>
	<span class="breadcrumb" align="left">
	<a href="manageSurveys.asp">All Surveys</a> >>
	<a href="manageIndividualSurvey.asp?surveyID=<%=intSurveyID%>"><%=survey_getSurveyTitle(intSurveyID)%></a> >>
	<a href="editSurvey.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>">Edit Survey</a> >>
	Add Item
	</span><br /><br />
				<span class="surveyTitle">
			Add Item to Survey
		</span>
<%
	If len(strMessage) > 0 Then
%>
		<br /><span class="message"><%=strMessage%></span>
<%
	End If
%>
		<hr noshade color="#C0C0C0" size="2">
		<table width="100%" class="normal" border="0"><tr>
		<td class="normalBold-Big" width="150" valign="top">Existing Item</td>
		<td valign="top">Add a pre-existing item from a question library. Question libraries are used to store questions that can be 
		used in any survey.<br />
		<a href="addItemFromCategory.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>">
				<img alt="Add From Library" src="images/button-addFromLibrary.gif" width="125" height="17" border="0"></a>

		</td></tr></table>
		

<%
	Else
		strLibraryName = survey_getLibraryName(intItemCategoryID)
%>
	<span class="breadcrumb" align="left">
	<a href="manageCategories.asp">All Libraries</a> >>
	<a href="manageCategories.asp?categoryID=<%=intItemCategoryID%>"><%=strLibraryName%></a> >>
	Add Item
	</span><br /><br />
			<span class="surveyTitle">
			Add Item to Library
		</span><br />
<%	
	End If
%>
	

		<hr noshade color="#C0C0C0" size="2">
		<table width="100%" class="normal" border="0" ID="Table2"><tr>
		<td class="normalBold-Big" width="200">New Item</td>
		</tr></table>
			<table border="1" cellpadding="2" bordercolor="#CCCCCC" cellspacing="0" width="100%" ID="Table1">
			<tr bgcolor="black" class="tableHeader">
				<td valign="top" class="gridheader">
					&nbsp;
				</td>
				<td valign="middle" class="gridheader" width="150">
					Item Type
				</td>
				<td valign="middle" class="gridheader">
					Description
				</td>

			</tr>
			
<%
					Do until rsResults.EOF
						intItemType = rsResults("itemTypeID")
						strItemType = rsResults("itemTypeText")
						strDescription = rsResults("description")
%>
						<tr>	
						<td  class="griddata" align="center" valign="top">
							<a href="addItem.asp?surveyID=<%=intSurveyID%>&itemType=<%=intItemType%>&pageID=<%=intPageID%>&categoryID=<%=intItemCategoryID%>">
								<img alt="Add" src="images/button-add.gif" border="0"></a>
						</td>
						<td  class="normalBold" valign="top" align="left">						
							<%=strItemType%>
						</td>	
						<td  class="griddata" valign="top" align="left">
							<%=strDescription%>
						</td>
						</tr>
<%
							rsResults.MoveNext
							Loop
%>

	</table><br />

<%
	rsResults.Close
	Set rsResults = NOTHING
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

