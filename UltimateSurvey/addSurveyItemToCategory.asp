<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		addSurveyItemToCategory.asp
' Purpose:	page to add an item from a survey to a library
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/surveyCreation_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<!--#INCLUDE FILE="Include/copyItem_inc.asp"-->
<%
	Dim intUserType
	Dim strCategoryName
	Dim strSQL
	Dim rsResults
	Dim intUserID
	Dim intTemplateID
	Dim strError
	Dim intCounter
	Dim intSurveyID
	Dim strSurveyTitle
	Dim intCategoryID
	Dim intItemID
	Dim strItemText
	Dim intCopyItemID
	Dim intNumberItems
	Dim intNewItemID
	Dim strLibraryName
	Dim intItemType
	Dim strArray
	
	Call user_loginNetworkUser()
	
	'Get the user info out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
			
	If intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	Call utility_setCookieExpiration("user",SV_SESSION_TIMEOUT, USD_MINUTES)
	
	intCategoryID = Request.QueryString("category")
	intSurveyID = Request.QueryString("surveyID")
		
	intNumberItems = Request.Form("numberItems")

	If utility_isPositiveInteger(intNumberItems) Then
		For intCounter = 0 To cint(intNumberItems)
			If Request.Form("selected" & intCounter) = "on" Then
				intCopyItemID = Request.Form("itemID" & intCounter)		
				Call copyItem_copyItem(intCopyItemID, 0, 0, False, intNewItemID)
				strSQL = "INSERT INTO usd_itemCategoryMap(categoryID, itemID) " &_
						 "VALUES(" & intCategoryID & "," & intNewItemID & ")"
				Call utility_executeCommand(strSQL)
			End If
		Next
		Response.Redirect("manageCategories.asp?categoryID=" & intCategoryID & "&message=" & SV_MESSAGE_CATEGORYITEM_ADDED)
	End If 

	strLibraryName = survey_getLibraryName(intCategoryID)

	strSQL = "SELECT itemID, itemText, itemType FROM usd_surveyItem " &_
			 "WHERE surveyID = " & intSurveyID &_
			 " AND itemID NOT IN(SELECT itemID FROM usd_itemCategoryMap WHERE categoryID = " & intCategoryID & ")"
	Set rsResults = utility_getRecordset(strSQL)


%>	
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
	<span class="breadcrumb"><a href="manageCategories.asp">All Libraries</a> >>
	<a href="manageCategories.asp?categoryID=<%=intCategoryID%>"><%=strLibraryName%></a> >>
	Add Item From Survey
	  </span><br /><br />
<span class="surveyTitle" align="left">
	Add Items To "<%=strLibraryName%>"</span>
<hr noshade color="#C0C0C0" size="2">
	<form method="post" action="addSurveyItemToCategory.asp?category=<%=intCategoryID%>&surveyID=<%=intSurveyID%>" name="frmAdd">		
		<%=common_basicTableTag()%>
			<tr bgcolor="black" class="tableHeader">
				<td class="gridheader" width="30">
					Select
					<%=common_checkAllLink("checkedArray","document.forms.frmAdd.checkedAll")%>
				</td>
				<td class="gridheader">
					Item Text
				</td>
				<td class="gridheader">
					Item Type
				</td>
				<td class="gridheader">
					&nbsp;
				</td>
			</tr>
<%
		If rsResults.EOF Then
%>
			<%=common_tableRow(0)%>
			<td class="message" colspan="4">
				No items found...
			</td></tr></table></form>
<%
		Else
		
		strArray = "new Array("
		
		intCounter = 0
		Do until rsResults.EOF
			intCounter = intCounter + 1
			intItemID = rsResults("itemID")
			strItemText = rsResults("itemText")
			intItemType = rsResults("itemType")

			If intCounter > 1 Then
				strArray = strArray & ","
			End If
			
			strArray = strArray & "document.forms.frmAdd.selected" & intCounter
%>
			<%=common_tableRow(intCounter)%>
				<td width="30">
					<input type="checkbox" name="selected<%=intCounter%>">
					<input type="hidden" name="itemID<%=intCounter%>" value="<%=intItemID%>">
				</td>
				<td>
					<%=strItemText%>
				</td>
				<td>
					<%=survey_getItemTypeText(intItemType)%>
				</td>
				<td>
					<a href="#" 
							onclick="javascript:popup('previewItem.asp?itemID=<%=intItemID%>&itemType=<%=intItemType%>','preview',0,1,0,0,0,1,600,600,100,100)">
							<img alt="view" src="images/button-view.gif" border="0"></a>

				</td>
			</tr>
<%
			rsResults.MoveNext
		Loop
%>
		</table><br />
		<input type="hidden" name="numberItems" value="<%=intCounter%>">
		<input type="image" src="images/button-submit.gif" alt="Submit" border="0">
		<input type="hidden" name="checkedAll" value="0">
		<script language="javascript">
			<!--
				checkedArray = <%=strArray%>);
			-->
		</script>
		
		</form>
<%
	End If
%>

<!--#INCLUDE FILE="Include/footer_inc.asp"-->

