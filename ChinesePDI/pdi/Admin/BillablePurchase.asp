<%@Language=VBScript %>
<!--#INCLUDE FILE="include/CheckAdminLogin.asp" -->
<!--#INCLUDE FILE="../include/common.asp" -->
<!--#INCLUDE FILE="include/DateTimeFunctions.asp" -->
<!--#INCLUDE FILE="include/FormattingFunctions.asp" -->
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
			' this page is designed to complete a billable purchase in the database and
			' allow the user to transfer the purchased test codes to another user
			'==================================================================================
		
			Dim intPurchaseID, oConn, oCmd, strUserID
			strUserID = Request.Cookies("UserID")
			If IsEmpty(Request("pid")) Then 
				intPurchaseID = 0
			Else
				intPurchaseID = 0
				If IsNumeric(Request("pid")) Then intPurchaseID = Request("pid")
			End If
			If intPurchaseID > 0 then
				'==================================================================================
				'=== Complete the purchase and allocate the test codes ============================
				'==================================================================================
				Set oConn = CreateObject("ADODB.Connection")
				Set oCmd = CreateObject("ADODB.Command")
				With oCmd
					.CommandText = "spPurchaseApproved"
					.CommandType = 4
					.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
					.Parameters.Append .CreateParameter("@intPurchaseID", 3, 1, 4, intPurchaseID)
					.Parameters.Append .CreateParameter("@intUserID", 3, 1, 4, strUserID)
				End With
				oConn.Open strDBaseConnString
				oCmd.ActiveConnection = oConn
				oCmd.Execute , , 128
				If oConn.Errors.Count >= 1 Then
					Response.Write "<span class='titletext'>Error Processing Purchase - Please contact a system administrator.</span>"
					Response.Write "<br>"
					Response.End
				End If
				Set oConn = Nothing
				Set oCmd = Nothing
				'==================================================================================
				'=== Set the purchase to be billable in the db ====================================
				'==================================================================================
				Set oConn = CreateObject("ADODB.Connection")
				Set oCmd = CreateObject("ADODB.Command")
				With oCmd
					.CommandText = "spAdminMakePurchaseBillable"
					.CommandType = 4
					.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
					.Parameters.Append .CreateParameter("@PurchaseID",3, 1,4, intPurchaseID)
				End With
				oConn.Open strDBaseConnString
				oCmd.ActiveConnection = oConn
				oCmd.Execute , , 128

				'==================================================================================
				'=== Send them on their way or throw an error message =============================			
				'==================================================================================
				If oConn.Errors.Count < 1 Then
					'Response.Redirect("BulkTestCodesMain.asp?res=" & intResellerID )
					%>
					<form name="thisForm" id="thisForm" method="post" action="BillablePurchaseTransferPurchase.asp?res=<%=intResellerID%>">
					<h1>Billable Purchase: Transfer Test Codes</h1><hr>
					<table border="0" cellpadding="5" cellspacing="3" width="" class="dgDataGrid">
						<tr class="dgAltItemRow">
							<td valign="top" rowspan="100%">
								<b>Assign Purchase to a Profile Manager:</b><br><br>
								<ol type="1">
									<li>Select the Profile Manager you would like to have administer the test codes from this purchase.
									<li>Select your notification options.
									<li>Enter any additional comments you would like included in the email.
									<li>Click "Transfer Purchase"
								</ol>
								<br><br><hr>
								If you would like to keep the test codes for yourself and do not want the codes emailed click here: 
								<a href="../main.asp?res=<%=intResellerID%>">PDI Home</a>
							</td>
							<td valign="top" nowrap>
								<b>Profile Managers:</b><br>
								<select name="intProfileMgr">
									<%
									Set oConn = CreateObject("ADODB.Connection")
									Set oCmd = CreateObject("ADODB.Command")
									Set oRs = CreateObject("ADODB.Recordset")
									With oCmd
										.CommandText = "spAdminGetProfileManagers"
										.CommandType = 4
									End With
									oConn.Open strDBaseConnString
									oCmd.ActiveConnection = oConn
									oRs.CursorLocation = 3
									oRs.Open oCmd, , 0, 1
									If oConn.Errors.Count < 1 then
										while oRs.EOF = FALSE
											
											if CInt(oRs("UserID")) = CInt(strUserID) then
												Response.Write("<option value=""" & oRs("UserID") & """ selected>" & oRs("FirstName") & " " & oRs("LastName")  & "  -  " & oRs("EmailAddress") & "</option>")
											else
												Response.Write("<option value=""" & oRs("UserID") & """>" & oRs("FirstName") & " " & oRs("LastName")  & "  -  " & oRs("EmailAddress") & "</option>")
											end if
											oRs.MoveNext
										wend
									end if
									Set oConn = Nothing : Set oCmd = Nothing : Set oRs = Nothing
									%>
								</select>
								<br><br>
								<b>Notification Options:</b><br>
								<input type="checkbox" name="bolEmailBuyer" value="1" checked> Send email with purchased test codes to yourself.<br>
								<input type="checkbox" name="bolEmailProfileMgr" value="1" checked> Send email with purchased test codes to the Profile Manager.<br>
								<br>
								<b>Additional Comments:</b><br>
								<textarea name="txtComments" rows="14" style="width:460px"></textarea><br>
							</td>
						</tr>
						<tr class="dgAltItemRow">
							<td valign="middle" align="center">
								<input type="hidden" name="intPurchaseID" value="<%=intPurchaseID%>">
								<input type="submit" border=0 value="Transfer Purchase">
							</td>
						</tr></form>
					</table>
					<hr>
					<%
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
				Response.Write("Ooops!<br><br>Something went wrong and I did not receive a purchase id.<br>Grab a donut and get help from a tech support person.")
			End If
		%>
	</td>
</tr>
<!--#INCLUDE FILE="include/footer.asp" -->