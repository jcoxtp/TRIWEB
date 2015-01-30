<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		viewResponseDetails.asp
' Purpose:	page to view details of a specific survey response
'
'
' Author:	    Ultimate Software Designs
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/reports_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/response_inc.asp"-->
<%
	Dim intUserType
	Dim intUserID
	Dim strSQL
	Dim rsResults
	Dim strSurveyTitle
	Dim strDescription
	Dim intSurveyType 
	Dim strError
	Dim intSurveyID
	Dim boolIsActive
	Dim intDelete
	Dim intMoveItem
	Dim intDirection
	Dim intPageID
	Dim boolActive
	Dim boolShowFreeText
	Dim intResponseID
	Dim boolIsOwner
	Dim boolScored
	Dim boolLogNTUser
	Dim boolUserInfoAvailable

	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",False)
	
	intResponseID = cint(Request.QueryString("responseID"))

	intSurveyID = reports_getSurveyIDByResponseID(intResponseID)

	

	strSQL = "SELECT surveyType, surveyTitle, surveyDescription, isScored, logNTUser, userInfoAvailable " &_
			 "FROM usd_Survey " &_
			 "WHERE surveyID = " & intSurveyID
	
	Set rsResults = utility_getRecordset(strSQL)
	
	If survey_getOwnerID(intSurveyID) = intUserID Then
		boolIsOwner = True
	Else
		boolIsOwner = False
	End If
	
%>
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_REPORTS)%>
<%
	If rsResults.EOF Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_UNKNOWN_ERROR)
	ElseIf reports_getReportingLevel(intUserID, intUserType, intSurveyID) <> SV_REPORT_PERMISSION_FULL Then
			Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If
%> 

	<span class="breadcrumb" align="left">
	<a href="chooseReport.asp">Reports</a> >> <%=rsResults("surveyTitle")%> >> Response Details
	</span><br /><br />
	<span class="surveyTitle">Response Details</span>
	
<%
	If boolIsOwner = True or intUserType = SV_USER_TYPE_ADMINISTRATOR Then
%>
		<p><a class="normalBold" href="deleteResponse.asp?surveyID=<%=intSurveyID%>&responseID=<%=intResponseID%>"
			onclick="javascript:return confirmAction('Are you sure you want to delete this response?');">
				<img src="images/button-deleteResponse.gif" alt="Delete Response" border="0"></a>
		<a class="normalBold" href="takeSurvey.asp?surveyID=<%=intSurveyID%>&editResponseID=<%=intResponseID%>&adminEditing=true"
			onclick="javascript:return confirmAction('Are you sure you want to edit this response?');">
				<img src="images/button-editResponse.gif" alt="Edit Response" border="0"></a>
		</p>
<%
	End If
%>
	<p>
	<p class="normal">
		<span class="normalBold">Description:</span><%=rsResults("surveyDescription")%>
	</p>
<%
		boolScored = cbool(rsResults("isScored"))
		boolLogNTUser = cbool(rsResults("logNTUser"))
		boolUserInfoAvailable = cbool(rsResults("userInfoAvailable"))
		
		If boolUserInfoAvailable = True Then
%>
			<%=reports_displayResponseSummary(intResponseID, boolScored, boolLogNTUser)%>
<%
		End If
%>
		<%=reports_displayResponseDetails(intResponseID)%>
<%
	rsResults.Close
	Set rsResults = NOTHING
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

