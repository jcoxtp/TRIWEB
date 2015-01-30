<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		listProperties.asp
' Purpose:	page to create and edit email list properties
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/response_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim intUserType
	Dim intPageCount
	Dim intResultCount
	Dim intPageNumber
	Dim intCounter
	Dim intMessage
	Dim strMessage
	Dim intListID
	Dim strListName
	Dim strDescription
	Dim strSQL
	Dim rsResults
	Dim strError
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo("", intUserType, "","", "",True)
	
	If intUserType <> SV_USER_TYPE_ADMINISTRATOR Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	
	intListID = Request.QueryString("listID")
	
	If Request.Form("submit") = "true" Then
		strListName = trim(Request.Form("listName"))
		strDescription = Request.Form("description")
		
		If strListName = "" Then
			strError = "List Name is required."
		ElseIf utility_isPositiveInteger(intListID) Then
			If user_listNameExists(strListName) and strListName <> Request.form("oldListName") Then
				strError = "List Name already exists."
			Else
				Call user_updateList(intListID, strListName, strDescription)
				
				strSQL = "UPDATE usd_emailListDetails SET listName = " & utility_SQLEncode(strListName,True) & " WHERE listName = " &_
							utility_SQLEncode(Request.Form("oldListName"),True)
				Call utility_executeCommand(strSQL) 
				
			End If
		Else
			If user_listNameExists(strListName) Then
				strError = "List Name already exists."
			Else
				Call user_addEmailList(strListName, strDescription)
			End If
		End If
		
		If strError = "" Then
			Response.Redirect("manageLists.asp")
		End If
	Else
		If utility_isPositiveInteger(intListID) Then
			strSQL = "SELECT listName, description FROM usd_emailLists WHERE listID = " & intListID

			Set rsResults = utility_getRecordset(strSQL)
			If not rsResults.EOF Then
				strListName = rsResults("listName")
				strDescription = rsResults("description")
			End If
			rsResults.Close
			Set rsResults = NOTHING
	
		End If
	End If
%>	

<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_USERS)%>
<%
	
	If utility_isPositiveInteger(intListID) Then
%>
			
			<span class="breadcrumb" align="left">
			<a href="manageLists.asp">All Lists</a> >>
			List Properties
	</span><br /><br /><span class="surveyTitle">List Properties</span><br />
<%
	Else
%>
			<span class="breadcrumb" align="left">
			<a href="manageLists.asp">All Lists</a> >>
			Add List
	</span><br /><br />
	<span class="surveyTitle">Add List</span><br />
		
<%
	End If
%>

	<span class="message"><%=strError%></span>
		<form method="post" action="listProperties.asp?listID=<%=intListID%>">
		<hr noshade color="#C0C0C0" size="2">
		<table border="0" cellpadding="0" cellspacing="0" class="normal">
			<tr>
				<td class="normalBold-Big" width="150" valign="top">
					List Properties
				</td>
				<td class="normalBold" width="150" valign="top">
					List Name
				</td>
				<td>
					<input type="text" name="listName" value="<%=strListName%>" size="50">
				</td>
			</tr>
			<tr>
				<td class="normalBold-Big" width="150">
					&nbsp;
				</td>
				<td class="normalBold" width="150" valign="top">
					Description
				</td>
				<td>
					<textarea name="description" rows="5" cols="70"><%=strDescription%></textarea>
				</td>
			</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table border="0" cellpadding="0" cellspacing="0" class="normal">
			<tr>
				<td class="normalBold-Big" width="150">
					&nbsp;
				</td>
				<td>
					<input type="hidden" name="submit" value="true">
					<input type="image" src="images/button-submit.gif" alt="Submit"
<%
					If utility_isPositiveInteger(intListID) Then
%>
						onclick="javascript:return confirmAction('Are you sure you want to change the list properties?');"
<%
					End If
%>
					>
					<input type="hidden" name="oldListName" value="<%=strListName%>">
				</td>
			</tr>
		</table>
	</form>
	
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

