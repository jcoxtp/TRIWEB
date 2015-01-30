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
Dim intNumberAnswers
Dim strAnswer
Dim intNumberFields
Dim intUserID
Dim intSurveyID
Dim intUserType
Dim strAlias
Dim intCounter
Dim intPageID
Dim intItemType
Dim strQuestionText
Dim strDescription
Dim intItemCategoryID


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

If Request.Form("submit") = "submit" Then

	strQuestionText = trim(Request.Form("questionText"))
	strDescription = trim(Request.Form("description"))
	strAlias = trim(Request.Form("alias"))
	
	strSQL = "UPDATE usd_surveyItem " &_
			 "SET itemText = " & utility_SQLEncode(strQuestionText, True) &_
			 ", itemDescription = " & utility_SQLEncode(strDescription, True) &_
			 ", alias = " & utility_SQLEncode(strAlias, True) &_
			 " WHERE itemID = " & intItemID
	Call utility_executeCommand(strSQL)
%>
		<body onload="javascript:closeAndSave();"></body>
<%	
	
End If


%>
	<%=header_htmlTop("white","")%>
		<table width="100%" bgcolor="<%=SV_TOP_COLOR%>"></tr><td>
		<span style="font-size: 24px; font-family: Arial; font-weight: bold; color: <%=SV_TITLE_COLOR%>">Edit Question Text</span>
	</td></tr></table>
	<table border="0" cellspacing="0" cellpadding="4" width="100%"><tr><td>
	<form method="post" action="editQuestionText.asp?itemID=<%=intItemID%>&surveyID=<%=intSurveyID%>&itemType=<%=intItemType%>&pageID=<%=intPageID%>&categoryID=<%=intItemCategoryID%>">
<%	
		strSQL = "SELECT itemText, itemDescription, alias " &_
				 "FROM usd_surveyItem WHERE itemID = " & intItemID
		Set rsResults = utility_getRecordset(strSQL)
		strQuestionText = rsResults("itemText")
		strDescription = rsResults("itemDescription")
		strAlias = rsResults("alias")
		
		rsResults.Close
		Set rsResults = NOTHING
	
	
%>
		<table border="0" cellpadding="0" cellspacing="0" class="normal" width="100%">
			<tr>
				<td width="100">
					Question
				</td>
				<td>
					<input type="text" name="questionText" value="<%=strQuestionText%>" size="70">
				</td>
			</tr>
			<tr>
				<td width="100">
					Alias
				</td>
				<td>
					<input type="text" name="alias" value="<%=strAlias%>" size="70">
				</td>
			</tr>
			
			<tr>
				<td width="100">
					Description
				</td>
				<td>
					<textarea name="description" cols="53" rows="5"><%=strDescription%></textarea>
				</td>
			</tr>
		</table>
		<hr noshade color="#C0C0C0" size="2">
		<table>
			<tr><td width="100">&nbsp;</td><td>
				<input type="hidden" name="submit" value="submit">
				<input type="image" src="images/button-submit.gif" alt="Submit" border="0">
			</td></tr>
		</table>
		
	</form>
	</td></tr></table>
	<script language="javascript">
		function closeAndSave()
		{
			var url = 'editItem.asp?surveyID=<%=intSurveyID%>&itemID=<%=intItemID%>&itemType=12&pageID=<%=intPageID%>&categoryID=<%=intItemCategoryID%>';
			self.opener.location = url;
		    self.close();
		}
	</script>