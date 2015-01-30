<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		addItemToCategory.asp
' Purpose:	page to add an item to a category from existing survey
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
	
	intUserID = Request.Cookies("user")("userID")
			
	'get form values
	strCategoryName = trim(Request.Form("categoryName"))

	intCategoryID = Request.QueryString("category")
	
	strLibraryName = survey_getLibraryName(intCategoryID)
	
	strSQL = "SELECT surveyID, surveyTitle FROM usd_survey ORDER by surveyTitle"
	Set rsResults = utility_getRecordset(strSQL)	

%>	
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
	<span class="breadcrumb"><a href="manageCategories.asp">All Libraries</a> >>
	<a href="manageCategories.asp?categoryID=<%=intCategoryID%>"><%=strLibraryName%></a> >>
	Add Item From Survey
	  </span><br /><br />
<span class="surveyTitle" align="left">
	Add Item To "<%=strLibraryName%>"
	
	</span><br /><br />

<span class="normalBold-Big">Select A Survey</span>
<hr noshade color="#C0C0C0" size="2">
		<%=common_basicTableTag()%>
			<tr bgcolor="black" class="tableHeader" height="25">
				<td>
					Survey Title
				</td>
			</tr>
<%

		If rsResults.EOF Then
%>
			<%=common_tableRow(0)%>
			<td class="message">
				No surveys found...
			</td></tr>
<%

		Else
		
		intCounter = 0
		Do until rsResults.EOF
			intCounter = intCounter + 1
			intSurveyID = rsResults("surveyID")
			StrSurveyTitle = rsResults("surveyTitle")
%>
			<%=common_tableRow(intCounter)%>
				<td class="normalBold">
					<a href="addSurveyItemToCategory.asp?category=<%=intCategoryID%>&surveyID=<%=intSurveyID%>">		
						<%=strSurveyTitle%></a>
				</td>
			</tr>
<%
			rsResults.MoveNext
		Loop

	End If
%>
</table>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

