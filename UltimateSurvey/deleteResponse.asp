<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
'****************************************************
'
' Name:		deleteResponse.asp
' Purpose:	page to delete specified response
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
<!--#INCLUDE FILE="Include/response_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim intUserType
	Dim intUserID
	Dim intSurveyID
	Dim intResponseID
	Dim boolIsOwner

	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	intResponseID = cint(Request.QueryString("responseID"))
	intSurveyID = cint(Request.QueryString("surveyID"))

	

	If survey_getOwnerID(intSurveyID) = intUserID Then
		boolIsOwner = True
	Else
		boolIsOwner = False
	End If
	
	If boolIsOwner = True or intUserType = SV_USER_TYPE_ADMINISTRATOR Then
		Call response_deleteResponse(intResponseID)
	End If
	
	Response.Redirect("viewResults.asp?surveyID=" & intSurveyID & "&message=" & SV_MESSAGE_RESPONSE_DELETED)
%>