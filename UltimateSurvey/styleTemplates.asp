<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1	
'**************************************************************************************
'
' Name:		styleTemplates.asp
' Purpose:	page to view, search, and generally manage style templates
'
'
' Author:	    Ultimate Software Designs
' Date Written:	01/29/03
' Modified:		
'
' Changes:
'**************************************************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
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
	Dim intTemplateID
	Dim intMessage
	Dim strMessage
	Dim intDeleteTemplateID
	Dim strOrderBy
	Dim strOrderByDirection
	Dim strSortingURL
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	
	If intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	

	intDeleteTemplateID = Request.Querystring("deleteTemplateID")
	
	If utility_isPositiveInteger(intDeleteTemplateID) Then		
		strSQL = "SELECT surveyID FROM usd_survey WHERE templateID = " & intDeleteTemplateID
			
		If utility_checkForRecords(strSQL) = True Then
			strMessage = "Template is in use by at least one survey.  Template not deleted."
		Else
			strSQL = "DELETE FROM usd_styleTemplates " &_
				 "WHERE templateID = " & intDeleteTemplateID
			If intUserType <> SV_USER_TYPE_ADMINISTRATOR Then
				strSQL = strSQL & " AND ownerUserID = " & intUserID
			End if
			Call utility_executeCommand(strSQL)
			strMessage = "Template successfully deleted."
		End If
	End If

	strOrderBy = Request.QueryString("orderBy")
	strOrderByDirection = Request.QueryString("orderByDirection")

	If len(strOrderBy) = 0 Then
		strOrderBy = "templateName"
	End If
	
	If len(strOrderByDirection) = 0 Then
		strOrderByDirection = "asc"
	End If 

	strSQL = "SELECT templateID, templateName " &_
			 "FROM usd_styleTemplates " 
	'Add search parameters if user trying to search
	strSearchText = trim(Request.QueryString("searchText"))
	strSearchType = Request.QueryString("searchType")
		
	If strSearchText <> "" Then
		strSQL = strSQL & " WHERE " & strSearchType & " like '%" &_
			 strSearchText & "%'"
	End If
	
	If intUserType = SV_USER_TYPE_CREATOR Then
		'If no where clause yet exists
		If inStr(1,strSQL,"WHERE") = 0 Then
			strSQL = strSQL & " WHERE "
		Else
			strSQL = strSQL & " AND " 
		End If
		strSQL = strSQL & "ownerUserID = " & intUserID
	End If
	
	strSQL = strSQL & " ORDER BY " & strOrderBy & " " & strOrderByDirection
	

	
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
	
	intMessage = Request.QueryString("message")
	If utility_isPositiveInteger(intMessage) Then
		If cint(intMessage) = SV_MESSAGE_TEMPLATE_EDITED Then
			strMessage = "Template successfully edited.<br />"
		End If
	End If
%>
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
	<span class="surveyTitle">Style Templates</span><br />
	<span class="message"><%=strMessage%></span><br />
	<span class="normal">
	Style templates allow you to make survey styles so that different surveys can have different looks.  Any survey creator 
	may use any template.<br />A template may only be edited by its creator, or a system administrator.</span><br /><br />
	<form method="get" action="styleTemplates.asp">
	<hr noshade color="#C0C0C0" size="2">
	<table width="100%">
		<tr><td width="15%">
			<a href="addTemplate.asp"><img src="images/button-addTemplate.gif" alt="Add Template" border="0"></a>
		</td>
		<td width="85%" align="right" nowrap>
		<span class="normalBold">Search: </span>
		<input type="text" name="searchText">
		<select name="searchType">
			<option value="templateName">Name</option>
			<option value="header">Header</option>
			<option value="footer">Footer</option>
			<option value="baseFont">Font</option>
		</select>
		<input type="hidden" name="submit" value="Search">
		<input type="image" src="images/button-search.gif" alt="Style Templates" border="0">
		<a class="normalBold" href="styleTemplates.asp"><img src="images/button-cancelSearch.gif" alt="Cancel Search" border="0"></a>
		</td></tr></table>
		<hr noshade color="#C0C0C0" size="2">
	</form>
	

<%
	If not rsResults.EOF Then
		rsResults.AbsolutePage = intPageNumber
		strPagingURL = "styleTemplates.asp?searchType=" & strSearchType & "&searchText=" &_
						Server.UrlEncode(strSearchText)  & "&orderBy=" & strOrderBy & "&orderByDirection=" & strOrderByDirection
		
		strSortingURL = "styleTemplates.asp?searchType=" & strSearchType & "&searchText=" &_
						Server.UrlEncode(strSearchText) 

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
%>
				<span class="normalBold"><%=intResultCount%> template(s) found.</span>

<%
	End If
%>
		
		<table border="1" cellpadding="2" bordercolor="#CCCCCC" cellspacing="0" width="100%" ID="Table1">
			<tr bgcolor="black" class="tableHeader">
				<td valign="middle" class="gridheader">
					<%=common_orderByLinks("Template Name", strOrderBy, strOrderByDirection, strSortingURL, "templateName")%>
				</td>
				<td valign="middle" class="gridheader" width="50">
					Delete?
				</td>
			</tr>
<%
			If rsResults.EOF Then
%>
				<%=common_tableRow(intCounter)%>
				<td class="message" colspan="2">
					No templates found...
				</td>
				</tr>				
<%
			
			Else
			
			Do while rsResults.AbsolutePage = intPageNumber and not rsResults.EOF
				intCounter = intCounter + 1
				intTemplateID = rsResults("templateID")
%>
				<%=common_tableRow(intCounter)%>
					<td>
						<a href="editTemplate.asp?templateID=<%=intTemplateID%>" class="normalBold">
							<%=rsResults("templateName")%></a>
					</td>
					<td width="50" align="center">
						<a href="styleTemplates.asp?pageNumber=<%=intPageNumber%>&deleteTemplateID=<%=intTemplateID%>" onclick="javascript:return confirmAction('Are you sure you want to delete the selected template?');">
							<img src="images/button-delete-small.gif" alt="Delete"  border="0"></a>
				</tr>
<%
				rsResults.MoveNext
			Loop
	
	End If
	rsResults.Close
	Set rsResults = NOTHING
%>
</table>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

