<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/itemDisplay_inc.asp"-->
<!--#INCLUDE FILE="Include/response_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/surveyCreation_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim intUserType
	Dim intUserID
	Dim intItemID
	Dim intItemType
	
	Call user_loginNetworkUser()
	
	'Get the userid and usertype out of the session or cookie
	Call user_getSessionInfo(intUserID, intUserType, "","", "",True)
	
	
	intItemID = Request.QueryString("itemID")
	intItemType = Request.QueryString("itemType")
	
	'if for any reason a valid item was not specified
	If not  utility_isPositiveInteger(intItemID) Then
		'redirect to index page with error message
		Response.Redirect("index.asp?message=" & SV_MESSAGE_UNKNOWN_ERROR)
	End If
%>	
	<%=header_htmlTop("white","")%>
	<table width="100%" bgcolor="<%=SV_TOP_COLOR%>"></tr><td>
		<span style="font-size: 24px; font-family: Arial; font-weight: bold; color: <%=SV_TITLE_COLOR%>"><%=SV_SITENAME%></span>
	</td></tr></table>
	<%=header_padding()%>
	<br /><span class="surveyTitle">Item:</span><br /><br />
<%
		Select Case cint(intItemType)
			Case SV_ITEM_TYPE_HEADER
				Call itemDisplay_displayHeader(intItemID)
			Case SV_ITEM_TYPE_MESSAGE
				Call itemDisplay_displayMessage(intItemID)
			Case SV_ITEM_TYPE_IMAGE
				Call itemDisplay_displayImage(intItemID)
			Case SV_ITEM_TYPE_LINE
				Call itemDisplay_displayLine()
			Case SV_ITEM_TYPE_HTML
				Call itemDisplay_displayHTML(intItemID)
			Case SV_ITEM_TYPE_TEXTAREA
				Call itemDisplay_displayTextArea(intItemID,0,False, 4, "", _
				2, "", "arial",0,False,0,"")
			Case SV_ITEM_TYPE_SINGLE_LINE
				Call itemDisplay_displaySingleLine(intItemID,0,False, 4, "", _
				2, "", "arial",0,False,"","")
			Case SV_ITEM_TYPE_DATE
				Call itemDisplay_displayDate(intItemID,0,False, 4, "", _
				2, "", "arial",0,False,"","")
			Case SV_ITEM_TYPE_CHECKBOXES
				Call itemDisplay_displayCheckboxes(intItemID, "",0,False, 4, "", _
				2, "", 2, "", "arial",0,False,0)
			Case SV_ITEM_TYPE_RADIO
				Call itemDisplay_displayRadio(intItemID,0,False, 4, "", _
				2, "", 2, "", "arial",0,False,0,"")
			Case SV_ITEM_TYPE_DROPDOWN
				Call itemDisplay_displayDropdown(intItemID,0,False, 4, "", _
				2, "", "arial",0,False,"","")
			Case SV_ITEM_TYPE_MATRIX
				Call itemDisplay_displayMatrix(intItemID, "",0,False, 4, "", _
				2, "", 2, "", "arial",0,False,False,"","","",0,"")
		End Select
%>	
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

