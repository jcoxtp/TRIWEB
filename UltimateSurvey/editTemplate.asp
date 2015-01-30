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
	Dim strHeader
	Dim strFooter
	Dim strBaseFont
	Dim strBackgroundColor
	Dim intTitleSize
	Dim strTitleColor
	Dim intSurveyDescriptionSize
	Dim strSurveyDescriptionColor
	Dim intQuestionSize
	Dim strQuestionColor
	Dim intQuestionDescriptionSize
	Dim strQuestionDescriptionColor
	Dim intAnswerSize
	Dim strAnswerColor
	Dim boolUseStandardUI
	Dim strOddRowColor
	Dim strEvenRowColor
	Dim strHeaderColor
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
		
	intTemplateID = Request.QueryString("templateID")	
	
	If intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If

	
	
	If Request.Form("submitted") = "true" Then
	
		strTemplateName = trim(request.form("templateName"))
		strHeader = trim(request.form("header"))
		strFooter = trim(request.form("footer"))
		strBaseFont = trim(request.form("baseFont"))
		strBackgroundColor = trim(request.form("backgroundColor"))
		intTitleSize = trim(request.form("titleSize"))
		strTitleColor = trim(request.form("titleColor"))
		intSurveyDescriptionSize = trim(request.form("surveyDescriptionSize"))
		strSurveyDescriptionColor = trim(request.form("surveyDescriptionColor"))
		intQuestionSize = trim(request.form("questionSize"))
		strQuestionColor = trim(request.form("questionColor"))
		intQuestionDescriptionSize = trim(request.form("questionDescriptionSize"))
		strQuestionDescriptionColor = trim(request.form("questionDescriptionColor"))
		intAnswerSize = trim(request.form("answerSize"))
		strAnswerColor = trim(request.form("answerColor"))
		strOddRowColor = trim(Request.Form("oddRowColor"))
		strEvenRowColor = trim(Request.Form("evenRowColor"))
		strHeaderColor = trim(Request.Form("headerColor"))
		
		If Request.Form("useStandardUI") = "on" Then
			boolUseStandardUI = True
		Else
			boolUseStandardUI = False
		End If

		strSQL = "UPDATE usd_styleTemplates SET " &_
				 "templateName = " & utility_SQLEncode(strTemplateName, True) & ", " &_
				 "header = " & utility_SQLEncode(strHeader, True) & ", " &_
				 "footer = " & utility_SQLEncode(strFooter, True) & ", " &_
				 "baseFont = " & utility_SQLEncode(strBaseFont, True) & ", " &_
				 "backgroundColor = " & utility_SQLEncode(strBackgroundColor, True) & ", " &_
				 "titleSize = " & utility_SQLEncode(intTitleSize, True) & ", " &_
				 "titleColor = " & utility_SQLEncode(strTitleColor, True) & ", " &_
				 "surveyDescriptionSize = " & utility_SQLEncode(intSurveyDescriptionSize, True) & ", " &_
				 "surveyDescriptionColor = " & utility_SQLEncode(strSurveyDescriptionColor, True) & ", " &_
				 "questionSize = " & utility_SQLEncode(intQuestionSize, True) & ", " &_
				 "questionColor = " & utility_SQLEncode(strQuestionColor, True) & ", " &_
				 "questionDescriptionSize = " & utility_SQLEncode(intQuestionDescriptionSize, True) & ", " &_
				 "questionDescriptionColor = " & utility_SQLEncode(strQuestionDescriptionColor, True) & ", " &_
				 "answerSize = " & utility_SQLEncode(intAnswerSize, True) & ", " &_
				 "answerColor = " & utility_SQLEncode(strAnswerColor, True) & "," &_
				 "useStandardUI = " & utility_SQLEncode(cint(boolUseStandardUI),True) & "," &_
				 "oddRowColor = " & utility_SQLEncode(strOddRowColor, True) & "," &_
				 "evenRowColor = " & utility_SQLEncode(strEvenRowColor, True) & "," &_
				 "headerColor = " & utility_SQLEncode(strHeaderColor, True) &_
				 " WHERE templateID = " & intTemplateID

		Call utility_executeCommand(strSQL)
		
		Response.Redirect("styleTemplates.asp?message=" & SV_MESSAGE_TEMPLATE_EDITED)
				 
	End If
	
	strSQL = "SELECT templateName, header, footer, baseFont, backgroundColor, titleSize, titleColor, " &_
			 "surveyDescriptionSize, surveyDescriptionColor, questionSize, questionColor, " &_
			 "questionDescriptionSize, questionDescriptionColor, answerSize, answerColor, " &_
			 "useStandardUI, oddRowColor, evenRowColor, headerColor " &_
			 "FROM usd_styleTemplates " &_
			 "WHERE templateID = " & intTemplateID
	If intUserType <> SV_USER_TYPE_ADMINISTRATOR Then
		strSQL = strSQL & "AND ownerUserID = " & intUserID
	End If
	
	Set rsResults = utility_getRecordset(strSQL)
		
	strTemplateName = rsResults("templateName")
	strHeader = rsResults("header")
	strFooter = rsResults("footer")
	strBaseFont = rsResults("baseFont")
	strBackgroundColor = rsResults("backgroundColor")
	intTitleSize = rsResults("titleSize")
	strTitleColor = rsResults("titleColor")
	intSurveyDescriptionSize = rsResults("surveyDescriptionSize")
	strSurveyDescriptionColor = rsResults("surveyDescriptionColor")
	intQuestionSize = rsResults("questionSize")
	strQuestionColor = rsResults("questionColor")
	intQuestionDescriptionSize = rsResults("questionDescriptionSize")
	strQuestionDescriptionColor = rsResults("questionDescriptionColor")
	intAnswerSize = rsResults("answerSize")
	strAnswerColor = rsResults("answerColor")
	boolUseStandardUI = cbool(rsResults("useStandardUI"))
	strOddRowColor = rsResults("oddRowColor")
	strEvenRowColor = rsResults("evenRowColor")
	strHeaderColor = rsResults("headerColor")

	rsResults.Close
	Set rsResults = NOTHING

%>	
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, SV_PAGE_TYPE_SURVEYS)%>
<span class="surveyTitle">Edit Style Template</span>
<hr noshade color="#C0C0C0" size="2">
<p class="message"><%=strError%></p>
<form method="post" action="editTemplate.asp?templateID=<%=intTemplateID%>" name="frmTemplate">
	<table border="0" cellpadding="0" cellspacing="0" class="normal">
		<tr valign="top">
			<td align="left" class="normalBold-Big" width="200">
				Survey Template Name
			</td>
			<td>
				<input type="text" name="templateName" value="<%=strTemplateName%>" size="52">
			</td>
		</tr>
	</table>
	<hr noshade color="C0C0C0" size="2">
	<table border="0" cellpadding="0" cellspacing="0" class="normal">
		<tr valign="top">
			<td align="left" class="normalBold-Big" width="200">
				HTML
			</td>
			<td align="left" class="normalBold">
				Header<br />
				<textarea name="header" rows="5" cols="70"><%=strHeader%></textarea>
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold" width="200">
				Footer<br />
				<textarea name="footer" rows="5" cols="70"><%=strFooter%></textarea>
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold">
				Also Use Standard UI
				<input type="checkbox" name="useStandardUI" 
<%
				If boolUseStandardUI = True Then
%>
					checked
<%
				End If
%>				
				><br /><span class="normal">Leaving this checked will keep the built in menus and footer in 
				tact while user is taking a survey, in addition to any HTML specified for the header and footer.</span>
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table border="0" cellpadding="0" cellspacing="0" class="normal">
		<tr valign="top">
			<td align="left" class="normalBold-Big" width="200">
				Appearance
			</td>
			<td class="normalBold">
				Font<br />
				<input type="text" name="baseFont" value="<%=strBaseFont%>">
			</td>
			<td align="left" class="normalBold">
				Background Color<br />
				<input type="text" name="backgroundColor" value="<%=strBackGroundColor%>">
				<a href="#" onclick="javascript:popup('chooseColor.asp?formName=frmTemplate&formField=backgroundColor','color',0,1,0,0,0,1,500,500,100,100)">
						<img src="images/button-colorPicker.gif" alt="Color Picker" border="0"></a>
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold">
				Title Size<br /><input type="text" name="titleSize" value="<%=intTitleSize%>">
			</td>
			<td align="left" class="normalBold">
				Title Color<br />
				<input type="text" name="titleColor" value="<%=strTitleColor%>">
				<a href="#" onclick="javascript:popup('chooseColor.asp?formName=frmTemplate&formField=titleColor','color',0,1,0,0,0,1,500,500,100,100)">
						<img src="images/button-colorPicker.gif" alt="Color Picker" border="0"></a>
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td class="normalBold">
				Survey Description Size<br />
				<input type="text" name="surveyDescriptionSize" value="<%=intSurveyDescriptionSize%>">
			</td>
			<td align="left" class="normalBold">
				Survey Description Color<br />
				<input type="text" name="surveyDescriptionColor" value="<%=strSurveyDescriptionColor%>">
				<a href="#" onclick="javascript:popup('chooseColor.asp?formName=frmTemplate&formField=surveyDescriptionColor','color',0,1,0,0,0,1,500,500,100,100)">
						<img src="images/button-colorPicker.gif" alt="Color Picker" border="0"></a>
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold" width="200">
				Question Size<br /><input type="text" name="questionSize" value="<%=intQuestionSize%>">
			</td>
			<td align="left" class="normalBold">
				Question Color<br />
				<input type="text" name="questionColor" value="<%=strQuestionColor%>">
				<a href="#" onclick="javascript:popup('chooseColor.asp?formName=frmTemplate&formField=questionColor','color',0,1,0,0,0,1,500,500,100,100)">
						<img src="images/button-colorPicker.gif" alt="Color Picker" border="0"></a>
			</td>
		</tr>
		<tr valign="top">
			<td align="left">
				&nbsp;
			</td>
			<td class="normalBold">
				Question Description Size<br />
				<input type="text" name="questionDescriptionSize" value="<%=intQuestionDescriptionSize%>">
			</td>
			<td align="left" class="normalBold">
				Question Description Color<br />
				<input type="text" name="questionDescriptionColor" value="<%=strQuestionDescriptionColor%>">
				<a href="#" onclick="javascript:popup('chooseColor.asp?formName=frmTemplate&formField=questionDescriptionColor','color',0,1,0,0,0,1,500,500,100,100)">
						<img src="images/button-colorPicker.gif" alt="Color Picker" border="0"></a>
			</td>
		</tr>
		<tr valign="top">
			<td align="left">
				&nbsp;
			</td>
			<td class="normalBold">
				Answer Size<br /><input type="text" name="answerSize" value="<%=intAnswerSize%>">
			</td>
			<td align="left" class="normalBold">
				Answer Color<br />
				<input type="text" name="answerColor" value="<%=strAnswerColor%>">
				<a href="#" onclick="javascript:popup('chooseColor.asp?formName=frmTemplate&formField=answerColor','color',0,1,0,0,0,1,500,500,100,100)">
						<img src="images/button-colorPicker.gif" alt="Color Picker" border="0"></a>
			</td>
		</tr>
		
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold">
				Matrix Odd Row Color<br />
				<input type="text" name="oddRowColor" value="<%=strOddRowColor%>">
				<a href="#" onclick="javascript:popup('chooseColor.asp?formName=frmTemplate&formField=oddRowColor','color',0,1,0,0,0,1,500,500,100,100)">
						<img src="images/button-colorPicker.gif" alt="Color Picker" border="0"></a>
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold">
				Matrix Even Row Color<br />
				<input type="text" name="evenRowColor" value="<%=strEvenRowColor%>">
				<a href="#" onclick="javascript:popup('chooseColor.asp?formName=frmTemplate&formField=evenRowColor','color',0,1,0,0,0,1,500,500,100,100)">
						<img src="images/button-colorPicker.gif" alt="Color Picker" border="0"></a>
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td align="left" class="normalBold">
				Matrix Header Color<br />
				<input type="text" name="headerColor" value="<%=strHeaderColor%>">
				<a href="#" onclick="javascript:popup('chooseColor.asp?formName=frmTemplate&formField=headerColor','color',0,1,0,0,0,1,500,500,100,100)">
						<img src="images/button-colorPicker.gif" alt="Color Picker" border="0"></a>
			</td>
		</tr>
	
		
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table>
		<tr>
			<td>
				<input type="hidden" name="submitted" value="true">
				<input type="image" src="images/button-submit.gif" alt="Submit" border="0"
				onclick="javascript:return confirmAction('Are you sure you want to edit this template?');">
			</td>
		</tr>
	</table>
</form>


<!--#INCLUDE FILE="Include/footer_inc.asp"-->

