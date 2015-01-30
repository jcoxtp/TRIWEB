<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/editItems_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/itemDisplay_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/surveyCreation_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%

Dim strSQL
Dim rsResults
Dim intItemID
Dim intNumberCategories
Dim strCategory
Dim intNumberFields
Dim intUserID
Dim intSurveyID
Dim intUserType
Dim strAlias
Dim intCounter
Dim intPageID
Dim intItemType
Dim boolNumberLabels
Dim intItemCategoryID
Dim strArray
Dim strAliasArray

'Get the userid and usertype out of the session or cookie
Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
		
'get values from page request
intSurveyID = cint(Request.QueryString("surveyID"))
	
intPageID = Request.QueryString("pageID")
intItemType = Request.QueryString("itemType")
intItemCategoryID = Request.QueryString("categoryID")

'validate user credentials
If utility_isPositiveInteger(intSurveyID) Then
	If ((survey_getOwnerID(intSurveyID) <> intUserID) _
			and intUserType = SV_USER_TYPE_CREATOR) _
			or intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If
Else
	If not utility_isPositiveInteger(intItemCategoryID) Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If
End If

intItemID = Request.QueryString("itemID")

intNumberFields = Request.Form("numberFields")

intNumberCategories = Request.Form("numberCategories")

If utility_isPositiveInteger(intNumberCategories) Then
	If Request.Form("numberLabels") = "on" Then
		boolNumberLabels = True
	Else
		boolNumberLabels = False
	End If
	
	strSQL = "UPDATE usd_surveyItem SET numberLabels = " & abs(cint(boolNumberLabels)) & " WHERE itemID = " & intItemID
	Call utility_executeCommand(strSQL)
	
	'strSQL = "DELETE FROM usd_matrixCategories " &_
	'		 "WHERE itemID = " & intItemID
	'Call utility_executeCommand(strSQL)
	
	For intCounter = 0 to cint(intNumberCategories)
		strCategory = trim(Request.Form("category" & intCounter))
		strAlias = trim(Request.Form("alias" & intCounter))
		If len(strCategory) > 0 Then
			Call surveyCreation_addMatrixCategory(intItemID, strCategory, strAlias, intCounter)
		End If
		
		If not utility_isPositiveInteger(intNumberFields) Then
%>
			<body onload="javascript:closeAndSave();"></body>
<%	
		End If
	Next
End If

If not utility_isPositiveInteger(intNumberFields) Then
	intNumberFields = SV_NUMBER_ANSWERS
End If

strSQL = "SELECT numberLabels FROM usd_surveyItem WHERE itemID = " & intItemID

Set rsResults = utility_getRecordset(strSQL)
If not rsResults.EOF Then
	boolNumberLabels = cbool(rsResults("numberLabels"))
End If
rsResults.Close

strSQL = "SELECT category, alias FROM usd_matrixCategories WHERE itemID = " & intItemID & " ORDER BY orderByID,categoryID"
rsResults.Open strSQL, DB_CONNECTION

intCounter = 0

%>
	<%=header_htmlTop("white","")%>
		<table width="100%" bgcolor="<%=SV_TOP_COLOR%>"></tr><td>
		<span style="font-size: 24px; font-family: Arial; font-weight: bold; color: <%=SV_TITLE_COLOR%>">Edit Matrix Categories</span>
	</td></tr></table>
	<table cellpadding="4" cellspacing="0" width="100%"><tr><td>
	<form method="post" name="frmCategories"
		action="editMatrixCategories.asp?itemID=<%=intItemID%>&surveyID=<%=intSurveyID%>&itemType=<%=intItemType%>&pageID=<%=intPageID%>&categoryID=<%=intItemCategoryID%>">
	
	<table cellpadding="0" cellspacing="0" border="0" class="normal">
		<tr>
			<td>
				Category
			</td>
			<td>
				Alias
			</td>
		</tr>
<%
	strArray = "new Array("
	strAliasArray = "new Array("
	
	Do until rsResults.EOF and intCounter >= cint(intNumberFields)
		intCounter = intCounter + 1
		If not rsResults.EOF Then
			strCategory = rsResults("category")
			strAlias = rsResults("alias")
	
			rsResults.MoveNext
		Else
			strCategory = ""
			strAlias = ""
		End If
		
		If intCounter > 1 Then
			strArray = strArray & ","
			strAliasArray = strAliasArray & ","
		End If
		
		strArray = strArray & "document.forms.frmCategories.category" & intCounter
		strAliasArray = strAliasArray & "document.forms.frmCategories.alias" & intCounter
%>
		<tr><td><input type="text" name="category<%=intCounter%>" value="<%=strCategory%>"></td>
			<td><input type="text" name="alias<%=intCounter%>" value="<%=strAlias%>">
<%
				If intCounter < intNumberFields Then
%>					
					<img style="cursor:hand" src="images/button-down-mini.gif" hspace="2" border="0" alt="Move Answer Down" width="15" height="15" onclick="javascript:swTextBox(document.forms.frmCategories.category<%=intCounter%>, document.forms.frmCategories.category<%=intCounter +1%>);swTextBox(document.forms.frmCategories.alias<%=intCounter%>, document.forms.frmCategories.alias<%=intCounter +1%>);return false;">
					
<%	
	Else
%>
		&nbsp;
<%
	End If
%>
		</td>
		<td valign="middle">
<%
	If intCounter > 1 Then
%>					
					<img style="cursor:hand" hspace="2" src="images/button-up-mini.gif" border="0" alt="Move Answer Up" width="15" height="15" onclick="javascript:swTextBox(document.forms.frmCategories.category<%=intCounter%>, document.forms.frmCategories.category<%=intCounter -1%>);swTextBox(document.forms.frmCategories.alias<%=intCounter%>, document.forms.frmCategories.alias<%=intCounter -1%>);return false;">
					
<%	
	Else
%>
		&nbsp;
<%
	End If
%>
	</td>
	<td valign="middle">
		<img style="cursor:hand" hspace="2" src="images/button-delete-mini.gif" border="0" alt="Delete Answer" width="15" height="15" onclick="javascript:if (confirm('Are you sure you want to delete this category?') == true) { deleteElement(categoryarray,<%=intCounter%>);deleteElement(aliasarray,<%=intCounter%>);}return false;"> 
		</tr>
<%
	Loop
%>
	</table>
	<a class="normal" href="#" onclick="javascript:addFields(<%=cint(intCounter) + SV_NUMBER_ANSWERS%>);">Add <%=SV_NUMBER_ANSWERS%> Fields</a>
	<hr noshade color="#C0C0C0" size="2">
	<span class="normal">Show Number Labels</span>
	<input type="checkbox" name="numberLabels" 
<%
	If boolNumberLabels = True Then
%>
		checked
<%
	End If
%>	
	>	
	<hr noshade color="#C0C0C0" size="2">
	<input type="hidden" name="numberCategories" value="<%=intCounter%>">
	<input type="hidden" name="numberFields" value="">
	<input type="image" src="images/button-submit.gif" alt="Submit" border="0">
	</form>
	</td></tr></table>
	
	<script language="javascript">
		function closeAndSave()
		{
			var url = 'editItem.asp?surveyID=<%=intSurveyID%>&itemID=<%=intItemID%>&itemType=12&pageID=<%=intPageID%>&categoryID=<%=intItemCategoryID%>';
			self.opener.location = url;
		    self.close();
		}
		
		function addFields(numFields)
		{
			frmCategories.numberFields.value = numFields;
			document.frmCategories.submit();
		}
		categoryarray = <%=strArray%>);
		aliasarray = <%=strAliasArray%>);
	</script>