<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1	
'****************************************************
'
' Name:		forgotLoginInfo.asp 
' Purpose:	page for user to retrieve login information based on their email address 
'
'
' Changes:
'****************************************************
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim strEmail
	Dim strError
	Dim strSQL
	Dim rsResults
	Dim intUserType
	Dim intSurveyID
	Dim strUsername
	Dim strPassword
	Dim strSubject
	Dim strBody
	
	Call user_clearSessionInfo()
	
	intSurveyID = Request.QueryString("surveyID")
	
	If Request.Form("submit") = "getInfo" Then
		
		strEmail = trim(Request.Form("email"))
				
		'check required values
		If strEmail = "" Then
			strError = strError & "Please specify an email address."
		End If
		
		'If no errors have been encountered
		If strError = "" Then
			strSQL = "SELECT username, pword " &_
					 "FROM usd_SurveyUser " &_
					 "WHERE email = " & utility_SQLEncode(strEmail, True) 
			Set rsResults = utility_getRecordset(strSQL)
			If rsResults.EOF Then
				strError = "Email address not found in the system."
			Else
				strUsername = rsResults("username")
				strPassword = rsResults("pword")
				strSubject = SV_SITENAME & " " & "Login Information"
				strBody = "Your login information for " & SV_SITENAME & " is the following:" & vbcrlf & vbcrlf &_
						  "Username: " & strUsername & vbcrlf &_
						  "Password: " & strPassword
				Call utility_sendMail(SV_MAIN_EMAIL, strEmail, strSubject, strBody)
				
				Response.Redirect("login.asp?surveyID=" & intSurveyID & "&message=" & SV_MESSAGE_INFORMATION_SENT)
				
			End If
		End If
	End If
	
%>	
	
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, "")%>
<p class="surveyTitle">Get Login Info</p>
<%
If strError = "" and Request.Form("submit") = "getInfo" Then
%>
<span class="normal">Login info successfully sent.<br /><br />
<a href="login.asp">Login now</a></span>
<br />
<%
Else
%>
<span class="normal">Enter your email address, and your login information will be sent to you.</span><br />
<span class="message"><%=strError%></span>
	<form method="post" action="forgotLoginInfo.asp?surveyID=<%=intSurveyID%>">
	<table border="0" cellpadding="0" cellspacing="2" class="normal">

		<tr>
			<td align="left" class="normalBold" width="100">
				Email Address
			</td>
			<td>
				<input type="text" name="email" size="40">
			</td>
		</tr>
	</table>
	<hr noshade color="#C0C0C0" size="2">
	<table>
		<tr>
			<td width="100">
				&nbsp;
			</td>
			<td>
				<input type="image" src="images/button-getInfo.gif" alt="Get Info" border="0">
				<input type="hidden" name="submit" value="getInfo">
			</td>
		</tr>
	</table>
	</form>
<%
End If
%>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

