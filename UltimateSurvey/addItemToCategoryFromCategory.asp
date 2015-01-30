<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1	
'**************************************************************************************
'
' Name:		addItemToCategoryFromCategory.asp
' Purpose:	page to add an item from one category to another
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
<!--#INCLUDE FILE="Include/copyItem_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
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
	Dim intDeleteSurveyID
	Dim strMessage
	Dim intMessage
	Dim intCategoryID
	Dim intItemID
	Dim strItemText
	Dim intNumberItems
	Dim intCopyItemID
	Dim intAddToCategoryID	
	Dim intNewItemID
	Dim intCategoryFoundID
	Dim strLibraryName
	Dim strDescription
	Dim strArray
	
	Call user_loginNetworkUser()
	
	'Get the user info out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	If intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	Call utility_setCookieExpiration("user",SV_SESSION_TIMEOUT, USD_MINUTES)

	intAddToCategoryID = Request.QueryString("addToCategoryID")
	intCategoryID = Request.QueryString("categoryID")
	
	intNumberItems = Request.Form("numberItems")
	If utility_isPositiveInteger(intNumberItems) Then
		For intCounter = 0 to cint(intNumberItems) 
			If Request.Form("selected" & intCounter) = "on" Then
				intCopyItemID = Request.Form("itemID" & intCounter)
				Call copyItem_copyItem(intCopyItemID, 0, 0, False, intNewItemID)
				strSQL = "INSERT INTO usd_itemCategoryMap(itemID, categoryID) " &_
						 "VALUES(" & intNewItemID & "," & intAddToCategoryID & ")"
				Call utility_executeCommand(strSQL)
			End If
		Next
		
		Response.Redirect("manageCategories.asp?categoryID=" & intAddToCategoryID)
	End If
	
	strLibraryName = survey_getLibraryName(intAddToCategoryID)

%>
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
	<span class="breadcrumb"><a href="manageCategories.asp">All Libraries</a> >>
	<a href="manageCategories.asp?categoryID=<%=intCategoryID%>"><%=strLibraryName%></a> >>
	Add Item From Library 
	  </span><br /><br />
	
	<span class="surveyTitle">
<%
	If utility_isPositiveInteger(intAddToCategoryID) Then
%>
		Add Item To Library From Other Library
<%
	Else
%>
		Choose Library
<%
	End If
%>		
		</span>
	<br /><span class="message"><%=strMessage%></span>
	<hr noshade color="#C0C0C0" size="2">
<%
	If not utility_isPositiveInteger(intCategoryID) Then
	
	strSQL = "SELECT categoryID, categoryName, description " &_
			 "FROM usd_itemCategories " &_
			 "WHERE categoryID IN (SELECT categoryID FROM usd_itemCategoryMap) " &_
			 "AND categoryID <> " & intAddToCategoryID 
	If utility_isPositiveInteger(intCategoryID) Then
		strSQL = strSQL & " AND parentCategoryID = " & intCategoryID
	Else
		strSQL = strSQL & " AND parentCategoryID IS NULL "
	End If
	
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
	
	strSQL = strSQL & " ORDER BY categoryName "
	
	Set rsResults = Server.CreateObject("ADODB.Recordset")
	'set up record set for paging
	rsResults.CursorLocation = adUseClient
	rsResults.PageSize = SV_RESULTS_PER_PAGE
	rsResults.Open utility_ConvertSQL(strSQL), DB_CONNECTION
	intPageCount = rsResults.PageCount
	intResultCount = rsResults.RecordCount
	
	intPageNumber = cint(Request.QueryString("pageNumber"))
	
	strPagingURL = "addItemToCategoryFromCategory.asp?searchType=" & strSearchType & "&searchText=" &_
						Server.UrlEncode(strSearchText)  
	
	If intPageNumber < 1 Then 
		intPageNumber = 1
	ElseIf intPageNumber > intPageCount Then
		Response.Redirect(strPagingURL & "&pageNumber=" & intPageCount)
	End If
	
	If not rsResults.EOF Then
		rsResults.AbsolutePage = intPageNumber


		If intResultCount > SV_RESULTS_PER_PAGE Then
%>
			<p align="center"><table><tr><td>
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
				</td><td>&nbsp;<span class="normalBold">Page</span>&nbsp;</td><td>

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
			</td></tr></table></p>
<%
		End If
	End If
%>
		<span class="normal">Choose a category to copy an item from</span>
		<%=common_basicTableTag%>
			<tr bgcolor="black" class="tableHeader">
				<td class="gridheader">
					Library Name
				</td>
				<td class="gridheader">
					Description
				</td>
					
			</tr>
<%
		
	If rsResults.EOF Then
%>
		<%=common_tableRow(0)%>
			<td class="message" colspan="2">
				No libraries containing items found...
			</td>
		</tr>
<%	
	
	Else	
			
			
			intCounter = 0
			Do while rsResults.AbsolutePage = intPageNumber and not rsResults.EOF
				intCounter = intCounter + 1
				intCategoryFoundID = rsResults("categoryID")
				strLibraryName = rsResults("categoryName")
				strDescription = rsResults("description")


%>
				<%=common_tableRow(intCounter)%>
					<td class="normalBold">
						<a href="addItemToCategoryFromCategory.asp?addToCategoryID=<%=intAddToCategoryID%>&categoryID=<%=intCategoryFoundID%>">
							<%=strLibraryName%></a>
					</td>
					<td class="griddata">
						<%=strDescription%>&nbsp;
					</td>
				</tr>
<%
				rsResults.MoveNext
			Loop
	End If
%>
		</table>
		<br />
<%

	rsResults.Close
	Set rsResults = NOTHING
	
	End If

	If utility_isPositiveInteger(intCategoryID) Then
	
	strSQL = "SELECT CM.itemID, SI.itemText " &_
			 "FROM usd_itemCategoryMap CM, usd_surveyItem SI " &_
			 "WHERE CM.itemID = SI.itemID " &_
			 "AND CM.categoryID = " & intCategoryID
	
	Set rsResults = utility_getRecordset(strSQL)
	
		intCounter = 0
%>
		<form method="post" action="addItemToCategoryFromCategory.asp?addToCategoryID=<%=intAddToCategoryID%>&categoryID=<%=intCategoryID%>" name="frmItems">
		<span class="normal">Choose one or more items</span>
		<%=common_basicTableTag%>
			<tr bgcolor="black" class="tableHeader">
				<td class="gridheader" width="25">
					Select
					<%=common_checkAllLink("checkedArray","document.forms.frmItems.checkedAll")%>
				</td>
				<td class="gridheader">
					Item Text
				</td>
				
			</tr>
<%
		If rsResults.EOF Then
%>
			<%=common_tableRow(0)%>
			<td class="message" colspan="2">
				No items found...
			</td></tr></table></form>
<%		
		Else
			strArray = "new Array("
			
			Do until rsResults.EOF
				intCounter = intCounter + 1
				intItemID = rsResults("itemID")
				strItemText = rsResults("itemText")
				
				If intCounter > 1 Then
					strArray = strArray & ","
				End If

				strArray = strArray & "document.forms.frmItems.selected" & intCounter
%>
				<%=common_tableRow(intCounter)%>
					<td>
						<input type="checkbox" name="selected<%=intCounter%>">
						<input type="hidden" name="itemID<%=intCounter%>" value="<%=intItemID%>">
					<td>
						<%=strItemText%>
					</td>
					
				</tr>
<%
				rsResults.MoveNext
			Loop
%>
		</table><br />
		<input type="image" name="submit" src="images/button-submit.gif" alt="Submit" border="0"
			onclick="javascript:return confirmAction('Are you sure you want to add these items to the library?');">
		<input type="hidden" name="numberItems" value="<%=intCounter%>">				
		<input type="hidden" name="checkedAll" value="0">
		<script language="javascript">
			<!--
				checkedArray = <%=strArray%>);
			-->
		</script>
		
		</form>
<%
	End If
	rsResults.Close	
	Set rsResults = NOTHING
	End If
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

