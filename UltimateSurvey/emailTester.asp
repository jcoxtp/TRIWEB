<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1	
'**************************************************************************************
'
' Name:		manageSurveys.asp
' Purpose:	page to view, search, and generally manage surveys
'**************************************************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
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
	Dim intSurveyID
	Dim intCopySurveyID
	Dim intDeleteSurveyID
	Dim intResponseCount
	Dim intMessage
	Dim strMessage

	
	Call user_loginNetworkUser()
	
	'Get the user info out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)

	If utility_isPositiveInteger(intUserType) Then
		If intUserType = SV_USER_TYPE_TAKE_ONLY or intUserType = 0 Then
			Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
		End If
	Else
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If
	
	'Send a test message
	
	If Request.Form("submit") = "submit" Then
	
	Call utility_sendMail(Request.Form("fromaddress"), Request.Form("toaddress"), Request.Form("msgsubject"), Request.Form("msgbody"))
	
	End If 
%>


	
<%	If Request.Form("submit") = "submit" Then %>

	<%=header_htmlTop("white","")%>
	<%=header_writeHeader(intUserType,SV_PAGE_TYPE_SETTINGS)%>
	<span class="surveyTitle">Email Test - Complete</span><br>
	<span class="normal"><a href="settings.asp">Back to the Settings Page</a></span>
	<hr noshade color="#C0C0C0" size="2">
	
	<span class="message">Email sent to <%=Request.Form("toaddress")%>.  If you received it, the test was successful.</span><br /><br />
	<span class="normal">If you do not receive it, this most likely means that your "relay" settings are not configured properly on your
	SMTP/mail server. Contact your mail server administrator.</span><br /><br />

<%  Else %>

	<%=header_htmlTop("white","")%>
	<%=header_writeHeader(intUserType,SV_PAGE_TYPE_SETTINGS)%>
	<span class="surveyTitle">Email Test</span><br>
	<span class="normal">Use the form below to test the application's ability to send email with the email settings 
	currently configured on the <a href="settings.asp">Settings page</a>.</span>
	<hr noshade color="#C0C0C0" size="2">

	<table class="normal" cellpadding="0" cellspacing="0" ID="Table1">
		<form action="emailtester.asp" method="post">
			<tr>
				<td class="normalBold-Big" width="200" valign="top">
					Test Settings
				</td>
				<td valign="middle" class="normalBold">
					From Address:
				</td>
				<td>
					<input type="text" name="fromaddress" value="<%=SV_EMAIL_FROM_ADDRESS%>" size="30" ID="Text1">
				</td>
			</tr>
			<tr>
				<td class="normalBold-Big" width="200" valign="top">
					&nbsp;
				</td>
				<td valign="middle" class="normalBold">
					To Address:
				</td>
				<td>
					<input type="text" name="toaddress" value="<%=SV_EMAIL_FROM_ADDRESS%>" size="30" ID="Text2">
				</td>
			</tr>
			<tr>
				<td class="normalBold-Big" width="200" valign="top">
					&nbsp;
				</td>
				<td valign="middle" class="normalBold">
					Subject:
				</td>
				<td>
					<input type="text" name="msgsubject" value="Email Test" size="30" ID="Text3">
				</td>
			</tr>
			
			<tr>
				<td class="normalBold-Big" width="200" valign="top">
					&nbsp;
				</td>
				<td valign="top" class="normalBold">
					Body:
				</td>
				<td>
					<textarea name="msgbody" cols="50" rows="6" ID="Textarea1">Test from <%=SV_SITENAME%></textarea>
				</td>
			</tr>
			
			
			<tr>
				<td class="normalBold-Big" width="200" valign="top">
					&nbsp;
				</td>
				
				
				<td>
					&nbsp;
				</td>
				
				<td valign="top" class="normalBold">
					<br /><br />
					<input type="hidden" name="submit" value="submit" ID="Hidden1">
 					<input type="image" src="images/button-send.gif" alt="Send Mail" border="0"
 					onclick="javascript:return confirmAction('Are you sure you want to send the test email message?');"
 					 ID="Image1" NAME="Image1">
				</td>
			</tr>
			</form>
	</table>
<%  End If %>	

	
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

	