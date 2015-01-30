<%@language = "vbscript"%>
<%
Option Explicit
Response.Buffer = True	
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
Server.ScriptTimeout = 6000
%>
<!--#INCLUDE FILE="Include/adovbs_inc.asp"-->
<!--#INCLUDE FILE="Include/common_ui_inc.asp"-->
<!--#INCLUDE FILE="Include/constants_inc.asp"-->
<!--#INCLUDE FILE="Include/header_inc.asp"-->
<!--#INCLUDE FILE="Include/SurveyConnection_inc.asp"-->
<!--#INCLUDE FILE="Include/survey_inc.asp"-->
<!--#INCLUDE FILE="Include/inviteUsers_inc.asp"-->
<!--#INCLUDE FILE="Include/user_inc.asp"-->
<!--#INCLUDE FILE="Include/utility_inc.asp"-->
<%
	Dim intUserType
	Dim intUserID
	Dim strSQL
	Dim rsResults
	Dim intCounter
	Dim intUserCount
	Dim boolSendEmail
	Dim strEmailContent
	Dim strEmailSubject
	Dim intPermittedUserID
	Dim intSurveyType
	Dim intNewUserFields
	Dim strToAddress
	Dim strPassword
	Dim intUserIDOut
	Dim arrEmails
	Dim strEmails
	Dim intMaxCounter
	Dim strEmailBody
	Dim strUserEmail
	Dim boolBlockDuplicate
	Dim strFromAddress
	Dim strFieldText
	Dim boolEmail
	Dim intNewUserType
	Dim strMessage
	Dim strFailed
	Dim boolAdded
	Dim boolError
	Dim strError
	Dim intListID
	Dim strListName
	Dim strEmailAddress

	
	Call user_loginNetworkUser()
	
	Call user_getSessionInfo(intUserID, intUserType,"","","",True)

	
	If intUserType <> SV_USER_TYPE_ADMINISTRATOR Then
		Response.Redirect("index.asp?message=" & SV_MESSAGE_NO_PERMISSION)
	End If
	
	boolError = False
	
		
	intListID = Request.querystring("listID")
	strListName = user_getEmailListName(intListID)


	If Request.Form("submit") = "Submit" Then
				
		On Error Resume Next
			
		arrEmails = split(Request.Form("emailAddresses"), vbCrlf)
		If Err.number <> 0 then
		
			strError = "Error: You entered too many rows. Please reduce the number of rows and try again" 
			
			boolError = True

		End If
		
	If Not boolError Then
		intMaxCounter = ubound(arrEmails)

		FOR intCounter = 0 TO intMaxCounter
			strEmailAddress = arrEmails(intCounter)
			If len(strEmailAddress) > 0 Then
				If utility_isValidEmail(strEmailAddress) = True Then
					strSQL = "SELECT email FROM usd_emailListDetails WHERE listName = " & utility_SQLEncode(strListName, True) &_
							 " AND email = " & utility_SQLEncode(strEmailAddress, True)
					If utility_checkForRecords(strSQL) = False Then		
						strSQL = "INSERT INTO usd_emailListDetails(listName, email) VALUES(" &_
								 utility_SQLEncode(strListName, True) & "," & utility_SQLEncode(strEmailAddress,True) & ")"
						Call utility_executeCommand(strSQL)
					Else
						strError = strError & strEmailAddress & " is already in this list.  Address not added.<br />"
						strFailed = strFailed & strEmailAddress & vbcrlf
					End If
				Else
					strError = strError & strEmailAddress & " is not a valid email address.  Address not added.<br />"
					strFailed = strFailed & strEmailAddress & vbcrlf
				End If	
			End If
		NEXT	
		
		If len(trim(strMessage)) = 0 and len(trim(strError)) = 0 Then
			Response.Redirect("manageLists.asp?message=" & SV_MESSAGE_USERS_ADDED)
		End If
				
	End If
	

	End If

	If not utility_isPositiveInteger(intNewUserType) Then
		intNewUserType = SV_DEFAULT_USER_TYPE
	End If

	
	boolEmail = False
%>
	<%=header_htmlTop("white","")%>
	<%=header_writeHeader(intUserType, SV_PAGE_TYPE_USERS)%>
	<form method="post" action="addAddressesToList.asp?listID=<%=intListID%>" name="frmUser">
	<span class="breadcrumb" align="left">
			<a href="manageLists.asp">All Lists</a> >>
			<a href="editList.asp?listID=<%=intListID%>"><%=strListName%></a> >>
			Add Addresses
	</span><br /><br />

			<span class="surveyTitle">Add Email Addresses to "<%=strListName%>"</span><br>
			<span class="message"><%=strError%></span><br>
			<span class="normal"><%=strMessage%></span>

			<hr noshade color="#C0C0C0" size="2">
			<table cellpadding="0" cellspacing="0" class="normal">
				<tr>
					<td class="normalBold-Big" width="200" valign="top">
						Enter Email Addresses
					</td>
					<td>
						<span class="normal">Please add only one email address per line.</span><br /><br />
						<span style="color:red; font-weight: bold">Note: Approximately 1500 addresses can be added in each batch.</span><br />
						
						<textarea name="emailAddresses" rows="20" cols="100"><%=strFailed%></textarea>
					</td>
				</tr>
			</table>	
			<hr noshade color="#C0C0C0" size="2">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td width="200">
						&nbsp;
					</td>
					<td>
						<input type="image" src="images/button-submit.gif" alt="Submit" border="0">
						<input type="hidden" name="numberFields" value="<%=intCounter%>">
						<input type="hidden" name="submit" value="Submit">
					</td>
				</tr>
			</table>
			
		
		</form>

					
<!--#INCLUDE FILE="Include/footer_inc.asp"-->

