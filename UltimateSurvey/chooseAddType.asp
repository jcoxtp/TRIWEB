<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		chooseAddType.asp
' Purpose:	page to choose how you want to add an item to a library
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
	Dim strLibraryName
	
	Call user_loginNetworkUser()
	
	'Get the user info out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
			
	If intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	Call utility_setCookieExpiration("user",SV_SESSION_TIMEOUT, USD_MINUTES)
	
	intCategoryID = Request.QueryString("categoryID")
	
	strLibraryName = survey_getLibraryName(intCategoryID)
%>	
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
<span class="breadcrumb"><a href="manageCategories.asp">All Libraries</a> >>
	<a href="manageCategories.asp?categoryID=<%=intCategoryID%>"><%=strLibraryName%></a> >>
	Add Item
	  </span><br /><br />
<span class="surveyTitle">Add Item To Library</span>
<hr noshade color="#C0C0C0" size="2">
<span class="message"><%=strError%></span>


<%=common_basicTableTag()%>
	<%=common_basicTableHeaderRow()%>
		<td class="gridheader" width="100">&nbsp;</td>
		<td class="gridheader">Method</td>
		<td class="gridheader">Description</td>
	</tr>
	<tr>
		<td class="griddata" align="center">
			<a href="addItem.asp?categoryID=<%=intCategoryID%>">
				<img alt="Add Item" src="images/button-addItem.gif" border="0"></a>
		</td>
		<td class="normalBold">
			New Item
		</td>
		<td class="griddata">
			Make a new item that will be added to the library
		</td>
	</tr>
	<tr>
		<td class="griddata" align="center">
			<a href="addItemToCategoryFromCategory.asp?addToCategoryID=<%=intCategoryID%>">
				<img alt="Add Item" src="images/button-addItem.gif" border="0"></a>
		</td>
		<td class="normalBold">
			From Library
		</td>
		<td class="griddata">
			Copy item from another library
		</td>
	</tr>
	<tr>
		<td class="griddata" align="center" width="100">
			<a href="addItemToCategory.asp?category=<%=intCategoryID%>">
				<img alt="Add Item" src="images/button-addItem.gif" border="0"></a>
		</td>
	    <td class="normalBold">
			From Survey
		</td>
		<td class="griddata">
			Copy an item from an existing survey into the library
		</td>
	</tr>
</table>	



<!--#INCLUDE FILE="Include/footer_inc.asp"-->

