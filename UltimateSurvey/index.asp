<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		index.asp 
' Purpose:	default page for survey application
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
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim intMessage
	Dim intUserType
	Dim strMessage
	
	Call user_loginNetworkUser()
	
				
	If Not utility_IsPositiveInteger(intUserType) Then
		intUserType = 0
	End If
	intMessage = cint(Request.QueryString("message"))
	'determine any messages that need to be displayed
	Select Case intMessage
		Case SV_MESSAGE_USER_ADDED
			strMessage = "You have successfully registered."
		Case SV_MESSAGE_LOGGED_IN 
			strMessage = "Login successful."
		Case SV_MESSAGE_NO_PERMISSION
			strMessage = "You do not have permission to view the requested page."
			Call user_clearSessionInfo()
		Case SV_MESSAGE_LOGIN_INFO_CHANGED
			strMessage = "Your login information has been updated."
		Case SV_MESSAGE_UNKNOWN_ERROR
			strMessage = "Unknown error occurred.  This could be the result of manually " &_
						 "changing the URL in the address bar."
		Case SV_MESSAGE_SURVEY_UNAVAILABLE
			strMEssage = "Survey unavailable.  Survey may be inactive, may not exist, or you may not have permission."
		Case SV_MESSAGE_OTHER_USER_LOGGED_IN
			strMessage = "You have been logged out because someone logged in with this username from another computer."
			Call user_clearSessionInfo()
		Case SV_MESSAGE_SECURITY_SETTINGS_CHANGED
			strMessage = "You were logged out because your security settings changed.  Please log in again."
			Call user_clearSessionInfo()
	End Select

	'Get the user info out of the session or cookie
	Call user_getSessionInfo("", intUserType, "","", "",False)

%>
<%=header_htmlTop("white","")%>
<%=header_writeHeader(intUserType, "")%>
<span class="message"><%=strMessage%></span>
<p class="heading"><%=SV_INDEX_PAGE_HEADER%></p>
<p class="normal"><%=SV_INDEX_PAGE_TEXT%></p>
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

