<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		addItemCategory.asp
' Purpose:	page to add a new library or category
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

	Call utility_setCookieExpiration("user",SV_SESSION_TIMEOUT, USD_MINUTES)
	
	

	intParentCategoryID = Request.QueryString("categoryID")
	
	'If form submitted
	If Request.Form("submit") = "submit" Then
		'get form values
		strCategoryName = trim(Request.Form("categoryName"))
		strDescription = trim(Request.Form("description"))
		If len(strCategoryName) > 0 Then
				strSQL = "SELECT categoryID FROM usd_itemCategories " &_
						 "WHERE categoryName = " & utility_SQLEncode(strCategoryName, True) 
				
				If utility_isPositiveInteger(intParentCategoryID) Then
					strSQL = strSQL & " AND parentCategoryID = " & utility_SQLEncode(intParentCategoryID, True)
				End If
				
				If utility_checkForRecords(strSQL) = True Then
					strError = "Library name already taken."
				Else

					strSQL = "INSERT INTO usd_itemCategories " &_
							 "(categoryName, parentCategoryID, description) VALUES(" & utility_SQLEncode(strCategoryName, True) &_
							 "," & utility_SQLEncode(intParentCategoryID, True) & "," &_
							 utility_SQLEncode(strDescription, True) & ")"
					Call utility_executeCommand(strSQL)
				
					If not utility_isPositiveInteger(intParentCategoryID) Then
						intParentCategoryID = 0
					End If
				
					intCategoryID = categories_getParentCategory(intParentCategoryID)

					Response.Redirect("manageCategories.asp?message=" & SV_MESSAGE_CATEGORY_ADDED &_
										 "&categoryID=" & intParentCategoryID)
				
				End If
		 Else
			strError = "Please specify a library name."
		 End If
	
	End If
%>	
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
<span class="breadcrumb">		<a href="manageCategories.asp">All Libraries</a> >>
		Add Library </span><br /><br />
<span class="surveyTitle">
<%
If not utility_isPositiveInteger(intParentCategoryID) Then
%>
Add Library
<%
Else
%>
Add Category
<%
End If
%>
</span>
<hr noshade color="#C0C0C0" size="2">
<p class="message"><%=strError%></p>
<form method="post" action="addItemCategory.asp?categoryID=<%=intParentCategoryID%>" id=form1 name=form1>
	<table border="0" cellpadding="0" cellspacing="0" class="normal">
		<tr>
			<td align="left" class="normalBold-Big" width="200" valign="top">
<%
If not utility_isPositiveInteger(intParentCategoryID) Then
%>				
				Library Name
<%
Else
%>				
				Category Name
<%
End If
%>
			</td>
			<td valign="top">
				<input type="text" name="categoryName" value="<%=strCategoryName%>" size="52">
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
	<table>
		<tr>
			<td width="200">
				&nbsp;
			</td>
			<td>
				<input type="hidden" name="submit" value="submit">
				<input type="image" 
<%
If not utility_isPositiveInteger(intParentCategoryID) Then
%>				
				src="images/button-addLibrary.gif" alt="Add Library"
<%
Else
%>				
				src="images/button-addCategory.gif" alt="addCategory"
<%
End If
%>
				 border="0">
			</td>
		</tr>
	</table>
	</form>


<!--#INCLUDE FILE="Include/footer_inc.asp"-->

