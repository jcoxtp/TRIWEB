<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1	
'**************************************************************************************
'
' Name:		addItemFromCategory.asp
' Purpose:	Add items from a category
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
	Dim intSurveyID
	Dim intCopySurveyID
	Dim intDeleteSurveyID
	Dim strMessage
	Dim intMessage
	Dim intParentCategory
	Dim intCategoryID
	Dim intPageID
	Dim intItemID
	Dim strItemText
	Dim intNumberItems
	Dim intCopyItemID
	Dim intItemType
	Dim strArray
			
		
	Call user_loginNetworkUser()
	
	'Get the user info out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	If intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	Call utility_setCookieExpiration("user",SV_SESSION_TIMEOUT, USD_MINUTES)

	intSurveyID = Request.QueryString("surveyID")
	intPageID = Request.QueryString("pageID")
	intParentCategory = Request.QueryString("parentCategory")
	
	If not utility_isPositiveInteger(intPageID) Then
		intPageID = 0
	End If
	
	intNumberItems = Request.Form("numberItems")
	If utility_isPositiveInteger(intNumberItems) Then
		For intCounter = 0 to cint(intNumberItems) 
			If Request.Form("selected" & intCounter) = "on" Then
				intCopyItemID = Request.Form("itemID" & intCounter)
				Call copyItem_copyItem(intCopyItemID, intSurveyID, intPageID, False, "")
			End If
		Next
		Response.Redirect("editSurvey.asp?surveyID=" & intSurveyID & "&pageID=" & intPageID)
	End If
	
	

%>
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
	<span class="surveyTitle">
<%
If not utility_isPositiveInteger(intParentCategory) Then	
%>
	Choose Library
<%
Else
%>
	Choose Item(s)
<%
End If
%>	
	</span>
	<br /><span class="message"><%=strMessage%></span>
	<hr noshade color="#C0C0C0" size="2">

<%
	If not utility_isPositiveInteger(intParentCategory) Then
	
		strSQL = "SELECT categoryID, categoryName " &_
				 "FROM usd_itemCategories " 
	
		If utility_isPositiveInteger(intParentCategory) Then
			strSQL = strSQL & " WHERE parentCategoryID = " & intParentCategory
		Else
			strSQL = strSQL & " WHERE parentCategoryID IS NULL "
		End If
	
		strSQL = strSQL & " AND categoryID IN (SELECT distinct(categoryID) FROM usd_itemCategoryMap) "
	
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
		If intPageNumber < 1 Then 
			intPageNumber = 1
		End If
	
		If not rsResults.EOF Then
			rsResults.AbsolutePage = intPageNumber
			strPagingURL = "addItemFromCategory.asp?searchType=" & strSearchType & "&searchText=" &_
							Server.UrlEncode(strSearchText)  & "&surveyID=" & intSurveyID & "&pageID=" & intPageID

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
			<table border="1" cellpadding="2" bordercolor="#CCCCCC" cellspacing="0" width="100%" ID="Table2">
			<tr bgcolor="black" class="tableHeader">
				<td valign="middle" class="gridheader">
					Library Name
				</td>
				
			</tr>
<%
			If rsResults.EOF Then
%>
				<%=common_tableRow(0)%>
					<td class="message">No libraries found...</td>
				</tr>
<%		
		
			Else	
			
				intCounter = 0
				Do while rsResults.AbsolutePage = intPageNumber and not rsResults.EOF
					intCounter = intCounter + 1
					intCategoryID = rsResults("categoryID")
%>
					<%=common_tableRow(intCounter)%>
						<td>
							<a href="addItemFromCategory.asp?parentCategory=<%=intCategoryID%>&surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>" class="normalBold">
								<%=rsResults("categoryName")%></a>
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

	If utility_isPositiveInteger(intParentCategory) Then
	
		strSQL = "SELECT CM.itemID, SI.itemText, SI.itemType " &_
				 "FROM usd_itemCategoryMap CM, usd_surveyItem SI " &_
				 "WHERE CM.itemID = SI.itemID " &_
				 "AND CM.categoryID = " & intParentCategory
	
		If DATABASE_TYPE = "MSAccess" Then
			strSQL = strSQL & " ORDER BY SI.itemText"
		Else
			strSQL = strSQL & " ORDER BY cast(SI.itemText as varchar(255)) "
		End If
	
		Set rsResults = utility_getRecordset(strSQL)
	
		strArray = "new Array("
		

%>
		<form method="post" action="addItemFromCategory.asp?surveyID=<%=intSurveyID%>&pageID=<%=intPageID%>" name="frmItems">
		<table border="1" cellpadding="2" bordercolor="#CCCCCC" cellspacing="0" width="100%" ID="Table1">
			<tr bgcolor="black" class="tableHeader">
				<td class="gridheader">
					<%=common_checkAllLink("checkedArray","document.forms.frmItems.selectedAll")%>
					&nbsp;
				</td>
				<td class="gridheader">
					Item Text
				</td>
				<td class="gridheader" align="center">
					Item Type
				</td>
				<td class="gridheader" width="50">
					&nbsp;
				</td>
			</tr>
<%

	If rsResults.EOF Then
	
%>
		<%=common_tableRow(0)%>
			<td class="message">No items found...</td>
<%	
	Else	
			intCounter = 0
			Do until rsResults.EOF
				intCounter = intCounter + 1
				intItemID = rsResults("itemID")
				strItemText = rsResults("itemText")
				intItemType = rsResults("itemType")
				
				If intCounter > 1 Then
					strArray = strArray & ","
				End If
				
				strArray = strArray & "document.forms.frmItems.selected" & intCounter
%>
				<%=common_tableRow(intCounter)%>
					<td>
						<input type="checkbox" name="selected<%=intCounter%>">
						<input type="hidden" name="itemID<%=intCounter%>" value="<%=intItemID%>">
					<td class="griddata">
						<%=strItemText%>
					</td>
					<td class="griddata" align="center">
						<%=survey_getItemTypeText(intItemType)%>
					</td>
					<td align="center" width="50">
						<a href="#" 
							onclick="javascript:popup('previewItem.asp?itemID=<%=intItemID%>&itemType=<%=intItemType%>','preview',0,1,0,0,0,1,600,600,100,100)">
							<img alt="View" src="images/button-view.gif" border="0"></a>
					</td>
				</tr>
<%
				rsResults.MoveNext
			Loop
%>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<input type="image" name="submit" src="images/button-submit.gif" alt="Submit" border="0">
		<input type="hidden" name="surveyID" value="<%=intSurveyID%>">
		<input type="hidden" name="pageID" value="<%=intPageID%>">
		<input type="hidden" name="numberItems" value="<%=intCounter%>">				
		<input type="hidden" name="selectedAll" value="0">
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

