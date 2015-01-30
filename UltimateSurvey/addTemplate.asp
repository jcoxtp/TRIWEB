<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		addTemplate.asp
' Purpose:	page add a style template
'
'
' Author:	    Ultimate Software Designs
' Date Written:	01/29/2003
' Modified:		
'
' Changes:
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
	Dim strTemplateName
	Dim strSQL
	Dim rsResults
	Dim intUserID
	Dim intTemplateID
	Dim strError
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
			
	If intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	
	
		
	'get form values
	strTemplateName = trim(Request.Form("templateName"))

	
	'If form submitted
	If len(strTemplateName) > 0 Then
				
		strSQL = "SELECT templateID " &_
				 "FROM usd_styleTemplates " &_
				 "WHERE templateName = " & utility_SQLEncode(strTemplateName, True)
		If utility_checkForRecords(strSQL) = True Then
			strError = "Template by that name already exists."
		Else
			strSQL = "INSERT INTO usd_styleTemplates " &_
					 "(templateName, baseFont, backgroundColor, titleSize, titleColor, surveyDescriptionSize, " &_
					 "surveyDescriptionColor, questionSize, questionColor, questionDescriptionSize, " &_
					 "questionDescriptionColor, answerSize, answerColor, ownerUserID, useStandardUI) " &_
					 "VALUES(" & utility_SQLEncode(strTemplateName, True) & ", 'arial', '#FFFFFF', '5', '#000000', " &_
					 "'2','#000000','4','#000000','2','#000000','2','#000000'," & intUserID & ",0)"
			Call utility_executeCommand(strSQL)
			
			strSQL = "SELECT templateID FROM usd_styleTemplates " &_
					 "WHERE templateName = " & utility_SQLEncode(strTemplateName, True) 
			Set rsResults = utility_getRecordset(strSQL)
			If not rsResults.EOF Then
				intTemplateID = rsResults("templateID")
			End If
			rsResults.Close
			Set rsResults = NOTHING
			
			Response.Redirect("editTemplate.asp?templateID=" & intTemplateID)
			
	   End If
	 End If
%>	
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
<span class="surveyTitle">Create New Style Template</span>
<hr noshade color="#C0C0C0" size="2">
<p class="message"><%=strError%></p>
<form method="post" action="addTemplate.asp" id=form1 name=form1>
	<table border="0" cellpadding="0" cellspacing="0" class="normal">
		<tr>
			<td align="left" class="normalBold-Big" width="200">
				Survey Template Name
			</td>
			<td>
				<input type="text" name="templateName" value="<%=strTemplateName%>" size="52">
			</td>
			<td>
				<input type="image" src="images/button-addTemplate.gif" alt="Add Template" border="0">
			</td>
		</tr>
	</table>
	</form>


<!--#INCLUDE FILE="Include/footer_inc.asp"-->

