<%@Language=VBScript %>
<!--#INCLUDE FILE="include/CheckAdminLogin.asp" -->
<!--#INCLUDE FILE="../include/common.asp" -->
<!--#INCLUDE FILE="include/DateTimeFunctions.asp" -->
<!--#INCLUDE FILE="include/FormattingFunctions.asp" -->
<!--#INCLUDE FILE="include/SendMail.asp" -->
<%
	pageID = ""
	If Not IsAuthorized(4) Then 
		Response.Redirect("/pdi/login.asp?res=" & intResellerID)
	End If
%>
<!--#INCLUDE FILE="include/header.asp" -->
<tr>
	<td valign="top" class="maincontent">
		<%
			'==================================================================================
			' this page is designed to complete a billable purchase in the database...
			'
			'==================================================================================
		
			Dim oConn, oCmd
			Dim intUserID : intUserID = Request.Cookies("UserID")
			Dim intPurchaseID, bolEmailBuyer, bolEmailProfileMgr, txtComments, intProfileMgr
			'-- Clean the PurchaseID ------------------------
			If IsEmpty(Request("intPurchaseID")) Then 
				intPurchaseID = 0
			Else
				intPurchaseID = 0
				If IsNumeric(Request("intPurchaseID")) Then intPurchaseID = Request("intPurchaseID")
			End If
			'-- Clean the bolEmailBuyer ------------------------
			bolEmailBuyer = False : If Not IsEmpty(Request("bolEmailBuyer")) Then bolEmailBuyer = True
			'-- Clean the bolEmailProfileMgr ------------------------
			bolEmailProfileMgr = False : If Not IsEmpty(Request("bolEmailProfileMgr")) Then bolEmailProfileMgr = True
			'-- Clean the txtComments ------------------------
			txtComments = "" : If Not IsEmpty(Request("txtComments")) Then txtComments = Request("txtComments")
			'-- Clean the Profile Manager User ID ------------------------
			If IsEmpty(Request("intProfileMgr")) Then 
				intProfileMgr = 0
			Else
				intProfileMgr = 0
				If IsNumeric(Request("intProfileMgr")) Then intProfileMgr = Request("intProfileMgr")
			End If
			
			If intPurchaseID > 0 and intProfileMgr > 0 then
				'==================================================================================
				'=== Transfer the ownership of the purchase =======================================
				'==================================================================================
				Set oConn = CreateObject("ADODB.Connection")
				Set oCmd = CreateObject("ADODB.Command")
				With oCmd
					.CommandText = "spAdminTransferPurchase"
					.CommandType = 4
					.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
					.Parameters.Append .CreateParameter("@intPurchaseID", 3, 1, 4, intPurchaseID)
					.Parameters.Append .CreateParameter("@intUserID", 3, 1, 4, intProfileMgr)
				End With
				oConn.Open strDBaseConnString
				oCmd.ActiveConnection = oConn
				oCmd.Execute , , 128
				If oConn.Errors.Count >= 1 Then
					Response.Write "<span class='titletext'>Error Transferring Purchase - Please contact a system administrator.</span>"
					Response.Write "<br>"
					Response.End
				End If

				'==================================================================================
				'=== Send the necessary emails ====================================================
				'==================================================================================
				'Response.Write("bolEmailBuyer=" & bolEmailBuyer & "<br>")
				'Response.Write("bolEmailProfileMgr=" & bolEmailProfileMgr & "<br>")
				'Response.Write("txtComments=" & txtComments & "<br>")

				If bolEmailBuyer or bolEmailProfileMgr Then
					Dim strFromEmail, strFromName, strSubject, strToEmail, strCCEmail, strBody
					strFromName = "Team Resources-PDIProfile.com"
					strSubject = "Personal DISCernment Inventory : Profile Codes"

					'-- Get the buyers email address for the "from" field ------
					Set oConn = CreateObject("ADODB.Connection")
					Set oCmd = CreateObject("ADODB.Command")
					Set oRs = CreateObject("ADODB.Recordset")
					With oCmd
						.CommandText = "spUserGetEmail"
						.CommandType = 4
						.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
						.Parameters.Append .CreateParameter("@intUserID", 3, 1, 4, intUserID)
					End With
					oConn.Open strDBaseConnString
					oCmd.ActiveConnection = oConn
					oRs.CursorLocation = 3
					oRs.Open oCmd, , 0, 1
					strFromEmail = oRs("EmailAddress")
					If bolEmailBuyer Then
						strCCEmail = strFromEmail
					else
						strCCEmail = ""
					End If
					
					'-- Get the Profile Managers email ------
					If bolEmailProfileMgr Then
						Set oConn = CreateObject("ADODB.Connection")
						Set oCmd = CreateObject("ADODB.Command")
						Set oRs = CreateObject("ADODB.Recordset")
						With oCmd
							.CommandText = "spUserGetEmail"
							.CommandType = 4
							.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
							.Parameters.Append .CreateParameter("@intUserID", 3, 1, 4, intProfileMgr)
						End With
						oConn.Open strDBaseConnString
						oCmd.ActiveConnection = oConn
						oRs.CursorLocation = 3
						oRs.Open oCmd, , 0, 1
						strToEmail = oRs("EmailAddress")
					End If

				'-- Build the email body ------
					If Not txtComments = "" Then
						strBody = txtComments & vbCrLf & "-------------------------------------" & vbCrLf & vbCrLf
					Else
						strBody = ""
					End If 
					strBody = strBody & "The following profile codes on www.pdiprofile.com have been allocated for your use." & vbCrLf
					strBody = strBody & "-------------------------------------" & vbCrLf
					Set oConn = CreateObject("ADODB.Connection")
					Set oCmd = CreateObject("ADODB.Command")
					Set oRs = CreateObject("ADODB.Recordset")
					With oCmd
						.CommandText = "spPurchaseGetTestCodes"
						.CommandType = 4
						.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
						.Parameters.Append .CreateParameter("@intPurchaseID", 3, 1, 4, intPurchaseID)
					End With
					oConn.Open strDBaseConnString
					oCmd.ActiveConnection = oConn
					oRs.CursorLocation = 3
					oRs.Open oCmd, , 0, 1
					Do While Not oRs.EOF
						strBody = strBody & oRs("TestCode") & vbCrLf
					oRS.MoveNext
					Loop
					strBody = strBody & "-------------------------------------" & vbCrLf
					strBody = strBody & "" & vbCrLf
					strBody = strBody & "Simple Instructions that you can send with each profile code to the end user:" & vbCrLf
					strBody = strBody & "1. Go to the web site: www.pdiprofile.com" & vbCrLf
					strBody = strBody & "2. Register as a new user or log in if you have already registered." & vbCrLf
					strBody = strBody & "3. Go to the section 'Need to Use a Profile? - Use Profile Code'" & vbCrLf
					strBody = strBody & "4. Type in the Profile Code above starting with 'PDI' and take the DISC instrument. (You can copy and paste.)" & vbCrLf
					strBody = strBody & "5. At the end of the assessment (step 6) you can create and download the Adobe PDF report of the DISC Inventory by clicking on the printer icon." & vbCrLf
					strBody = strBody & "Thank you" & vbCrLf & vbCrLf & vbCrLf

				'-- Send the email ------
					Call SendMail(strFromEmail,strFromName,strSubject,strToEmail,strCCEmail,strBody)
				End If



				'==================================================================================
				'=== Send them on their way or throw an error message =============================			
				'==================================================================================
				If oConn.Errors.Count < 1 Then
					Response.Redirect("Default.asp?res=" & intResellerID )
				Else
					Dim strError
					strError = FormatSQLError(Err.description)
					strErrMsg = strError
					Err.Clear
				End If
				Set oConn = Nothing
				Set oCmd = Nothing
			Else
				'==================================================================================
				'something when wrong kill it and complain
				'==================================================================================
				Response.Write("Ooops!<br><br>Something went wrong and I did not receive a purchase id or a profile manager id.<br>Grab a donut and get help from a tech support person.")
			End If
		%>
	</td>
</tr>
<!--#INCLUDE FILE="include/footer.asp" -->