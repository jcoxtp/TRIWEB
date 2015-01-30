<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		editItemCategory.asp
' Purpose:	page to edit a category in a library
'
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
<!--#INCLUDE FILE="Include/categories_inc.asp"-->
<%
	Dim intUserType
	Dim strCategoryName
	Dim strSQL
	Dim rsResults
	Dim intUserID
	Dim intTemplateID
	Dim strError
	Dim intParentCategoryID
	Dim intCategoryID
	Dim strDescription
		
	Call user_loginNetworkUser()
	
	'Get the user info out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
			
	If intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	intCategoryID = Request.QueryString("categoryID")
	
	'If form submitted
	If Request.Form("submitted") = "true" Then
		strDescription = trim(Request.Form("description"))
		strCategoryName = trim(Request.Form("categoryName"))

		strSQL = "UPDATE usd_itemCategories " &_
				 "SET description = " & utility_SQLEncode(strDescription, True) &_
				 ", categoryName = " & utility_SQLEncode(strCategoryName, True) &_
				 " WHERE categoryID = " & intCategoryID
		Call utility_executeCommand(strSQL)
			
				
		intParentCategoryID = categories_getParentCategory(intCategoryID)
		Response.Redirect("manageCategories.asp?message=" & SV_MESSAGE_CATEGORY_EDITED &_
									 "&categoryID=" & intParentCategoryID)
	
			
			
			
	 Else
		strSQL = "SELECT categoryName, description FROM usd_itemCategories WHERE categoryID = " & intCategoryID
		Set rsResults = utility_getRecordset(strSQL)
		strCategoryName = rsResults("categoryName")
		strDescription = rsResults("description")
	 End If
%>	
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
<span class="breadcrumb">		<a href="manageCategories.asp">All Libraries</a> >>
		Library Properties</span><br /><br />
<span class="surveyTitle">Library Properties</span><br />
<hr noshade color="#C0C0C0" size="2">
<p class="message"><%=strError%></p>
<form method="post" action="editItemCategory.asp?categoryID=<%=intCategoryID%>">
	<table border="0" cellpadding="0" cellspacing="0" class="normal">
		<tr>
			<td align="left" class="normalBold-Big" width="200" valign="top">
				Library Name:
			</td>
			<td valign="top">
				<input type="text" size="50" name="categoryName" value="<%=strCategoryName%>">
			</td>
		</tr>
		<tr>
			<td align="left" class="normalBold-Big" width="200" valign="top">
				Description
			</td>
			<td valign="top">
				<textarea name="description" rows="3" cols="70"><%=strDescription%></textarea>
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table border="0" cellpadding="0" cellspacing="0" class="normal">
		<tr>
			<td align="left" class="normalBold-Big" width="200" valign="top">
			<td>
				<input type="image" src="images/button-submit.gif" alt="Submit" border="0"
					onclick="javascript:return confirmAction('Are you sure you want to edit these properties?');">
				<input type="hidden" name="submitted" value="true">
			</td>
		</tr>
	</table>
	</form>


<!--#INCLUDE FILE="Include/footer_inc.asp"-->

