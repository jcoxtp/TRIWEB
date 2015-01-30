<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1	
'**************************************************************************************
'
' Name:		manageCategories.asp
' Purpose:	page to manage categories in question libraries
'**************************************************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/surveyCreation_inc.asp"-->
<!--#INCLUDE FILE="Include/copySurvey_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<!--#INCLUDE FILE="Include/categories_inc.asp"-->
<%
	Dim intUserType
	Dim intPageCount
	Dim intResultCount
	Dim intPageNumber
	Dim intCounter
	Dim strSQL
	Dim strSearchText
	Dim strSearchType
	Dim rsResults
	Dim strPagingURL
	Dim intUserID
	Dim intSurveyID
	Dim intCopySurveyID
	Dim intDeleteSurveyID
	Dim strMessage
	Dim intMessage
	Dim intParentCategory
	Dim intCategoryID
	Dim intDeleteCategory
	Dim strCategoryName
	Dim strCategories
	Dim intItemType
	Dim intDeleteItemID
	Dim intNumberItems
	Dim strDescription
	Dim strLibraryName
	Dim strOrderBy
	Dim strOrderByDirection
	Dim strSortingURL

	
	Call user_loginNetworkUser()
	
	'Get the user info out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)

	If intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	Call utility_setCookieExpiration("user",SV_SESSION_TIMEOUT, USD_MINUTES)

	intParentCategory = Request.QueryString("categoryID")
	
	
	intDeleteCategory = Request.QueryString("deleteCategory")
	If utility_isPositiveInteger(intDeleteCategory) Then
		strSQL = "DELETE FROM usd_itemCategories WHERE categoryID = " & intDeleteCategory &_
				 " OR parentCategoryID = " & intDeleteCategory
		Call utility_executeCommand(strSQL)
		strSQL = "DELETE FROM usd_itemCategories WHERE parentCategoryID NOT IN(SELECT categoryID FROM usd_itemCategories)"
		Call utility_executeCommand(strSQL)
		
	End If
	
	Call categories_deleteInvalidItems()
	
	intMessage = Request.QueryString("message") 
	If utility_isPositiveInteger(intMessage) Then
		Select case cint(intMessage)
			Case SV_MESSAGE_CATEGORY_ADDED
				strMessage = "Library successfully added"
			Case SV_MESSAGE_CATEGORYITEM_ADDED
				strMessage = "Item successfully added to library"
			Case SV_MESSAGE_CATEGORY_EDITED
				strMessage = "Library successfully edited"
		End Select
	End If
	
	intDeleteItemID = Request.QueryString("deleteItemID") 
	If utility_isPositiveInteger(intDeleteItemID) Then
		strSQL = "DELETE FROM usd_itemCategoryMap WHERE itemID = " & intDeleteItemID &_
				 " AND categoryID = " & intParentCategory
		Call utility_executeCommand(strSQL)
		Call surveyCreation_deleteItem(0, intDeleteItemID)
	End If		
	
	strOrderBy = Request.QueryString("orderBy")
	strOrderByDirection = Request.QueryString("orderByDirection")
	
	If len(strOrderBy) = 0 Then
		strOrderBy = "categoryName"
	End If
	
	If len(strOrderByDirection) = 0 Then
		strOrderByDirection = "asc"
	End If 
	
	strSQL = "SELECT categoryID, categoryName, description " &_
			 "FROM usd_itemCategories " 
	
	
	'Add search parameters if user trying to search
	strSearchText = trim(Request.QueryString("searchText"))
	strSearchType = Request.QueryString("searchType")
		
	If strSearchText <> "" Then
		If inStr(1,strSQL,"WHERE") = 0 Then
			strSQL = strSQL & " WHERE " 
		Else
			strSQL = strSQL & " AND "
		End If
		strSQL = strSQL & strSearchType & " like '%" &_
			 strSearchText & "%'"
	End If
	
	strSQL = strSQL & " ORDER BY " & strOrderBy & " " & strOrderByDirection
%>
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
	
<%
	If not utility_isPositiveInteger(intParentCategory) Then
%>
	<span class="surveyTitle">Question Libraries</span>
	<%=common_helpLink("questionLibraries/general.asp",SV_SMALL_HELP_IMAGE)%><br />
	<span class="normal">Question Libraries allow you to store questions to be used in any survey.  Click the help link for more information.</span>
	<br /><span class="message"><%=strMessage%></span>
	<form>
	<hr noshade color="#C0C0C0" size="2">
	<table width="100%">
		<tr><td width="15%"><a href="addItemCategory.asp?categoryID=<%=intCategoryID%>">
						<img src="images/button-addLibrary.gif" alt="Add Library" border="0" width="125" height="17"></a></td>
		<td width="85%" align="right" nowrap>
		</tr></table>
	
	<hr noshade color="#C0C0C0" size="2">
	</form>
<%
	Else
		strLibraryName = survey_getLibraryName(intParentCategory)
%>
		<span class="breadcrumb">		<a href="manageCategories.asp">All Libraries</a> >>
		<%=strLibraryName%> </span><br /><br />
<%
	End If
%>
	
<%
	If utility_isPositiveInteger(intParentCategory) Then
		strSQL = "SELECT categoryName FROM usd_itemCategories WHERE categoryID = " & intParentCategory
		Set rsResults = utility_getRecordset(strSQL)
		If not rsResults.EOF Then
			strLibraryName = rsResults("categoryName")		
		End If
		rsResults.Close
		Set rsResults = NOTHING
	Else
	
	Set rsResults = Server.CreateObject("ADODB.Recordset")
	'set up record set for paging
	rsResults.CursorLocation = adUseClient
	rsResults.PageSize = SV_RESULTS_PER_PAGE
	rsResults.Open utility_ConvertSQL(strSQL), DB_CONNECTION
	intPageCount = rsResults.PageCount
	intResultCount = rsResults.RecordCount
	
	strPagingURL = "manageCategories.asp?searchType=" & strSearchType & "&searchText=" &_
					Server.UrlEncode(strSearchText)  & "&categoryID=" & intParentCategory & "&orderBy=" & strOrderBy & "&orderByDirection=" & strOrderByDirection

	
	strSortingURL = "manageCategories.asp?searchType=" & strSearchType & "&searchText=" &_
					Server.UrlEncode(strSearchText)  & "&categoryID=" & intParentCategory 
	
	intPageNumber = cint(Request.QueryString("pageNumber"))
	If intPageNumber < 1 Then 
		intPageNumber = 1
	ElseIf intPageNumber > intPageCount Then
		Response.Redirect(strPagingURL & "&pageNumber=" & intPageCount)
	End If
	

	If not rsResults.EOF Then
		rsResults.AbsolutePage = intPageNumber


%>
			<table width="100%">
			 <tr>
			  <td width="30%"><span class="normalBold"><%=intResultCount%> library(s) found.</span></td>
			  <td width="40%" align="center">
			
<%	
		
			'paging links
			If intPageNumber > 1 Then
%>
			
				<a class="normalBold" 
					href="<%=strPagingURL%>&pageNumber=1"><< First</a>
				&nbsp;
				<a class="normalBold" 
					href="<%=strPagingURL%>&pageNumber=<%=intPageNumber - 1%>">< Prev</a>
			
<%
			Else
%>
				<span class="greyedText"><< First&nbsp;< Prev</span>
<%
			End If
%>
				&nbsp;<span class="normalBold">Page</span>&nbsp;

<%
			If intPageNumber < intPageCount Then
%>
				<a  class="normalBold" 
					href="<%=strPagingURL%>&pageNumber=<%=intPageNumber + 1%>">
					Next ></a>
				&nbsp;
				<a  class="normalBold" 
					href="<%=strPagingURL%>&pageNumber=<%=intPageCount%>">Last >></a>
<%
			Else
%>
				<span class="greyedText">Next >&nbsp;Last >></span>
<%
			End If
%>
			</td>
			<td width="30%" align="right">
			</td>
			
			</tr></table>
<%
		End If
%>


			<%=common_basicTableTag()%>
			<tr bgcolor="black" class="tableHeader">
				<td class="gridheader">
<%
				If not utility_isPositiveInteger(intParentCategory) Then
%>
					<%=common_orderByLinks("Library Name", strOrderBy, strOrderByDirection, strSortingURL, "categoryName")%>	
<%
				Else
%>
				<%=common_orderByLinks("Category Name", strOrderBy, strOrderByDirection, strSortingURL, "categoryName")%>	

<%
				End If
%>
									</td>
				<td class="gridheader">
					Description
				</td>
				<td class="gridheader">
					Items
				</td>
				<td align="middle" class="gridheader" width="280">
					Actions
				</td>
			</tr>

<%
			If rsResults.EOF Then
%>
			<%=common_tableRow(intCounter)%>
				<td class="message" colspan="5">
					
<%
			If not utility_isPositiveInteger(intParentCategory) Then
%>
					No libraries found...
<%
			Else
%>
					No categories found...
<%
			End If
%>
				</td>
			</tr>
<%
			Else
			
			intCounter = 0
			Do while rsResults.AbsolutePage = intPageNumber and not rsResults.EOF
				intCounter = intCounter + 1
				intCategoryID = rsResults("categoryID")
				strCategoryName = rsResults("categoryName")
				strDescription = rsResults("description")
%>
				<%=common_tableRow(intCounter)%>
					<td class="normalBold">
						<a href="manageCategories.asp?categoryID=<%=intCategoryID%>">
							<%=strCategoryName%></a>
					</td>
					<td class="griddata">
						<%=strDescription%>&nbsp;
					</td>
					<td class="griddata">
						<%=categories_getNumberItems(intCategoryID)%>
					</td>
					<td align="middle" width="280">
							<a href="manageCategories.asp?categoryID=<%=intCategoryID%>">
								<img src="images/button-viewEdit.gif" alt="View/Edit" border="0" width="90" height="17"></a>
							<a href="editItemCategory.asp?categoryID=<%=intCategoryID%>">
								<img src="images/button-properties.gif" alt="Properties" border="0" width="90" height="17"></a>
							<a onclick="javascript:return confirmAction('Are you sure you want to delete this library?');"
								href="<%=strPagingURL%>&pageNumber=<%=intPageNumber%>&deleteCategory=<%=intCategoryID%>">
								<img src="images/button-delete-large.gif" alt="Delete" border="0"></a>
					</td>
				</tr>
<%
				rsResults.MoveNext
			Loop
		
	End If
	rsResults.Close
	Set rsResults = NOTHING
%>
	</table>
		<br /><br />
<%	
	End If

	If utility_isPositiveInteger(intParentCategory) Then
%>
		<span class="surveyTitle">Items In "<%=strLibraryName%>"</span>
		<hr noshade color="#C0C0C0" size="2">
		<span class="normalBold"><a href="chooseAddType.asp?categoryID=<%=intParentCategory%>">
		<img src="images/button-addItem-large.gif" alt="Add Item" border="0" width="125" height="17"></a>
		</span>
		<hr noshade color="#C0C0C0" size="2">
<%
	strOrderBy = Request.QueryString("orderBy")
	
	strSQL = "SELECT CM.itemID, SI.itemText, SI.itemType " &_
			 "FROM usd_itemCategoryMap CM, usd_surveyItem SI, usd_itemTypes  IT " &_
			 "WHERE CM.itemID = SI.itemID " &_
			 "AND CM.categoryID = " & intParentCategory &_
			 " AND SI.itemType = IT.itemTypeID"
	
	
	If len(trim(strOrderBy)) = 0 Then
		strOrderBy = "itemText"
	End If
	
	If strOrderBy = "itemText" AND DATABASE_TYPE = "SQLServer" Then
		strSQL = strSQL & " ORDER BY cast(itemText AS varchar(255)) " & strOrderByDirection
	Else
		strSQL = strSQL & " ORDER BY " & strOrderBy & " " & strOrderByDirection
	End If
		
	
	
	
	Set rsResults = Server.CreateObject("ADODB.Recordset")
	'set up record set for paging
	rsResults.CursorLocation = adUseClient
	rsResults.PageSize = SV_RESULTS_PER_PAGE
	rsResults.Open utility_ConvertSQL(strSQL), DB_CONNECTION
	intPageCount = rsResults.PageCount
	intResultCount = rsResults.RecordCount
	
	strPagingURL = "manageCategories.asp?searchType=" & strSearchType & "&searchText=" &_
					Server.UrlEncode(strSearchText)  & "&categoryID=" & intParentCategory &_
					"&orderBy=" & strOrderBy & "&orderByDirection=" & strOrderByDirection


	strSortingURL = "manageCategories.asp?searchType=" & strSearchType & "&searchText=" &_
					Server.UrlEncode(strSearchText)  & "&categoryID=" & intParentCategory
	
	intPageNumber = cint(Request.QueryString("pageNumber"))
	If intPageNumber < 1 Then 
		intPageNumber = 1
	ElseIf intPageNumber > intPageCount Then
		Response.Redirect(strPagingURL & "&pageNumber=" & intPageCount)
	End If
	

	If not rsResults.EOF Then
		rsResults.AbsolutePage = intPageNumber


%>
			<table width="100%">
			 <tr>
			  <td width="30%"><span class="normalBold"><%=intResultCount%> item(s) found.</span></td>
			  <td width="40%" align="center">
			
<%	
		
			'paging links
			If intPageNumber > 1 Then
%>
			
				<a class="normalBold" 
					href="<%=strPagingURL%>&pageNumber=1"><< First</a>
				&nbsp;
				<a class="normalBold" 
					href="<%=strPagingURL%>&pageNumber=<%=intPageNumber - 1%>">< Prev</a>
			
<%
			Else
%>
				<span class="greyedText"><< First&nbsp;< Prev</span>
<%
			End If
%>
				&nbsp;<span class="normalBold">Page</span>&nbsp;

<%
			If intPageNumber < intPageCount Then
%>
				<a  class="normalBold" 
					href="<%=strPagingURL%>&pageNumber=<%=intPageNumber + 1%>">
					Next ></a>
				&nbsp;
				<a  class="normalBold" 
					href="<%=strPagingURL%>&pageNumber=<%=intPageCount%>">Last >></a>
<%
			Else
%>
				<span class="greyedText">Next >&nbsp;Last >></span>
<%
			End If
%>
			</td>
			<td width="30%" align="right">
			</td>
			
			</tr></table>
<%
		End If
	
		intCounter = 0
%>

		
	
		<%=common_basicTableTag()%>
			<tr bgcolor="black" class="tableHeader">
				<td class="gridheader">
					<%=common_orderByLinks("Item Text",strOrderBy,strOrderByDirection, strSortingURL,"itemText")%>
				</td>
				<td class="gridheader">
					<%=common_orderByLinks("Item Type",strOrderBy,strOrderByDirection, strSortingURL,"itemTypeText")%>
				</td>
				<td align="center" class="gridheader" width="155">
					Actions
				</td>
			</tr>
<%
		
			If rsResults.EOF Then
%>
				<%=common_tableRow(0)%>
				<td class="message" colspan="3">
					No items found...
				</td>
				</tr>
<%
			Else
			
			Dim intItemID
			Dim strItemText

			Do until rsResults.EOF
				intCounter = intCounter + 1

				intItemID = rsResults("itemID")
				strItemText = rsResults("itemText")
				intItemType = rsResults("itemType")
%>
				<%=common_tableRow(intCounter)%>

					<td>
						<%=strItemText%>
					</td>
					<td class="griddata">
						<%=survey_getItemTypeText(intItemType)%>
					</td>
					<td align="center" width="155">
						<a href="#" 
							onclick="javascript:popup('previewItem.asp?itemID=<%=intItemID%>&itemType=<%=intItemType%>','preview',0,1,0,0,0,1,600,600,100,100)">
							<img src="images/button-view.gif" alt="View" border="0"></a>
						<a href="editItem.asp?categoryID=<%=intParentCategory%>&itemID=<%=intItemID%>&itemType=<%=intItemType%>">
							<img src="images/button-edit.gif" alt="Edit" border="0"></a>
						<a href="manageCategories.asp?deleteItemID=<%=intItemID%>&categoryID=<%=intParentCategory%>"
							onclick="javascript:return confirmAction('Are you sure you want to delete this item from this library?');">
							<img src="images/button-surveyDelete.gif" alt="Delete" border="0"></a>
					</td>
				</tr>
<%
				rsResults.MoveNext
			Loop
	End If
	rsResults.Close	
	Set rsResults = NOTHING
%>
		</table>
<%
	End If
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

