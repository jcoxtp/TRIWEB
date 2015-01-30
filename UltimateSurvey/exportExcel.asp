<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		exportExcel.asp 
' Purpose:	page to export survey data to an excel spreadsheet
'
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/reports_inc.asp"-->
<!--#INCLUDE FILE="Include/response_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim intUserType
	Dim intUserID
	Dim strSQL
	Dim rsResults
	Dim strSurveyTitle
	Dim intSurveyID
	Dim strAction

	Call user_loginNetworkUser()

	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intSurveyID = cint(Request.QueryString("surveyID"))

	If DATABASE_TYPE = "MSAccess" Then
		strAction = "executeExportAccess.asp"
	Else
		strAction = "executeExport.asp"
		strAction = "executeExportAccess.asp"
	End If

	strSurveyTitle = survey_getSurveyTitle(intSurveyID)
	

%>
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_REPORTS)%>
<span class="breadcrumb" align="left">
		<a href="searchReports.asp">Search Results</a> >>
		<%=strSurveyTitle%>
	</span>
	<br /><br />	<span class="surveyTitle"><%=strSurveyTitle%> - Export Results to CSV</span>
			<form method="post" action="<%=strAction%>" name="executeExport">
				<table class="normal" cellpadding="0" cellspacing="0">
					<tr>
						<td class="surveyTitle">
							
						</td>
					</tr>
				</table>

				<hr noshade color="#C0C0C0" size="2">
				<table class="normal" cellpadding="0" cellspacing="0">
					<tr>
						<td class="normalBold-Big" width="200">
							Options
						</td>
						<td>
							Detailed Response Info?
						</td>
						<td>
							<input type="checkbox" name="detailedResults">
						</td>
					</tr>
<%
				If survey_userInfoAvailable(intSurveyID) = True Then
%>
					<tr>
						<td>
							&nbsp;
						</td>
						<td>
							Detailed User Info?
						</td>
						<td>
							<input type="checkbox" name="userDetails">
						</td>
					</tr>
<%
				End If
%>
					<tr>
						<td>
							&nbsp;
						</td>
						<td>
							Export Aliases
						</td>
						<td>
							<input type="checkbox" name="aliases">
						</td>
					</tr>
					<tr>
						<td>
							&nbsp;
						</td>
						<td>
							Checkboxes in One Column
						</td>
						<td>
							<input type="checkbox" name="singleColumnCheckboxes">
						</td>
					</tr>
					<tr>
						<td>
							&nbsp;
						</td>
						<td>
							Export Open-Ended Questions
						</td>
						<td>
							<input type="checkbox" name="openEndedQuestions">
						</td>
					</tr>
					<tr>
						<td>
							&nbsp;
						</td>
						<td>
							Export Hidden Fields
						</td>
						<td>
							<input type="checkbox" name="hiddenFields" ID="Checkbox1">
						</td>
					</tr>
				</table>
				<hr noshade color="#C0C0C0" size="2">
				<table class="normal" cellpadding="0" cellspacing="0">
					<tr>
						<td width="200" class="normalBold-Big">
							&nbsp;
						</td>
						<td>	
							<input type="image" src="images/button-export.gif" alt="Export" border="0">
							<input type="hidden" name="submit" value="Export">
						</td>
					</tr>
				</table>
				<input type="hidden" name="surveyID" value="<%=intSurveyID%>">			
			</form>

			
			
<!--#INCLUDE FILE="Include/footer_inc.asp"-->
