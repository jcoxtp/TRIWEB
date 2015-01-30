<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1	
'****************************************************
'
' Name:		login.asp 
' Purpose:	page for user to log in 
'
'
' Author:	    Ultimate Software Designs
' Date Written:	6/24/2002
' Modified:
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
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim strUsername
	Dim strPassword
	Dim strError
	Dim strSQL
	Dim rsResults
	Dim strAction
	Dim intUserType
	Dim intSurveyID
	Dim intLoginType
	Dim strMessage
	Dim intMessage
	Dim strGUID
	Dim intUserID

	Call user_clearSessionInfo()

	strAction = Request.QueryString("act")
	intUserType = 0
	intSurveyID = Request("id")
	intMessage = Request.QueryString("message")

	If utility_isPositiveInteger(intMessage) Then
		If cint(intMessage) = SV_MESSAGE_INFORMATION_SENT Then
			strMessage = "Your login information has been sent to your email address."
		End If
	End If

	If strAction = "Cancel" Then
		Response.Redirect("index.asp")
	'if requested to log in
	ElseIf strAction = "Login" Then
		'get all values from form post
		strUsername = trim(Request.QueryString("un"))
		strPassword = trim(Request.QueryString("pw"))

		'check required values
		If strUsername = "" Then
			strError = strError & "Username is required.<br />"
		End If
		If strPassword = "" Then
			strError = strError & "Password is required.<br />"
		End If

		'If no errors have been encountered
		If strError = "" Then
			strSQL = "SELECT userID, userType, userGUID " &_
					 "FROM usd_SurveyUser " &_
					 "WHERE userName = " & utility_SQLEncode(strUsername, False) &_
					 " AND pword = " & utility_SQLEncode(strPassword, False)
			Set rsResults = utility_getRecordset(strSQL)
			If rsResults.EOF Then
				strError = "Username/Password combination not found."
			Else
				intUserID = rsResults("userID")
				intUserType = rsResults("userType")
				strGUID = rsResults("userGUID")
				If len(trim(strGUID)) = 0 or isNull(strGUID) or SV_PREVENT_CONCURRENT_LOGIN = True Then
					strGUID = utility_createGUID()
					strSQL = "UPDATE usd_surveyUser SET userGUID = " & utility_SQLEncode(strGUID, True) & " WHERE userID = " & intUserID
					Call utility_executeCommand(strSQL)
				End If

				Call user_setSessioninfo(intUserID, intUserType, strUserName, SV_LOGIN_TYPE_PASSWORD, "true",strGUID)
				response.Cookies(SV_COOKIE_NAME & "user")("overrideNetwork") = "true"

' Response.Write "We are sorry, but we are currently making changes to the system. Please try back in 10 minutes."

				If utility_isPositiveInteger(intSurveyID) Then
					strSQL = "SELECT MAX(responseID) as responseID " &_
						 "FROM usd_Response " &_
						 "WHERE surveyID = " & intSurveyID &_
						 " AND userID = " & intUserID &_
						 " AND completed = 1 "
					Set rsResults = utility_getRecordset(strSQL)

'					Response.Write "<BR>SurveyID=" & intSurveyID
'					Response.Write "<BR>UserID=" & intUserID
'					Response.Write "<BR>Completed=" & rsResults("completed")
'					Response.End

					If rsResults.EOF = False Then
						Response.Redirect("takeSurvey.asp?surveyID=" & intSurveyID & survey_getQuerystring(intSurveyID)) & "&editResponseID=" & rsResults("responseID")
					Else
						Response.Redirect("takeSurvey.asp?surveyID=" & intSurveyID & survey_getQuerystring(intSurveyID))
					End If
				Else
					Response.Redirect("index.asp?message=" & SV_MESSAGE_LOGGED_IN)
				End If
			End If
		End If
	End If
%>	

<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, "")%>
<span class="surveyTitle">Login</span><br />
<span class="message"><%=strMessage%></span>
<hr noshade color="#C0C0C0" size="2">
	<span class="normal">Enter your login information and click "Login".&nbsp&nbsp;<a href="forgotLoginInfo.asp?surveyID=<%=intSurveyID%>">Forgot Login Info?</a>
<br /><span class="message"><%=strError%></span>
<%
	If utility_isPositiveInteger(intLoginType) Then
		If cint(intLoginType) = SV_LOGIN_TYPE_NETWORK Then
%>
			<br /><span class="normal">You may login here with a username/password combination, or you can browse to other parts
			of the site using your network credentials.</span>
<%
		End If
	End If
%>
	<form method="post" action="login.asp?surveyID=<%=intSurveyID%><%=survey_getQuerystring(intSurveyID)%>">
	<table border="0" cellpadding="0" cellspacing="2" class="normal">

		<tr>
			<td align="left" class="normalBold" width="100">
				Username
			</td>
			<td>
				<input type="text" name="username" value="<%=strUserName%>">
			</td>
		</tr>
		<tr>
			<td align="left" class="normalBold" width="100">
				Password
			</td>
			<td>
				<input type="password" name="password">
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
				<input type="image" src="images/button-login2.gif" alt="Login" border="0">
				<input type="hidden" name="submit" value="Login">
			</td>
		</tr>
	</table>
	</form>

<!--#INCLUDE FILE="Include/footer_inc.asp"-->

