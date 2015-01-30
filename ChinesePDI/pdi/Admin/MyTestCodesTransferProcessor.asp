<%@ Language=VBScript %>
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
			Dim uid, oConn, oCmd
			If IsEmpty(Request("uid")) Then 
				uid = 0
			Else
				uid = 0
				If IsNumeric(Request("uid")) Then uid = Request("uid")
			End If
			
			Dim strTestCode
			If IsEmpty(Request("tc")) Then ' redirect them back 
				strTestCode = ""
			Else
				strTestCode = Request("tc")
			End If
			
			If (uid > 0) and Not (strTestCode = "") then
				'==================================================================================
				'=== Make the user a Profile Manager in the db ====================================
				'==================================================================================
				Set oConn = CreateObject("ADODB.Connection")
				Set oCmd = CreateObject("ADODB.Command")
				With oCmd
					' this stored proc "transfers" the test code by assigning the given user as the 
					' test taker and setting the code to redeemed
					.CommandText = "spAdminTransferTestCode"
					.CommandType = 4
					.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
					.Parameters.Append .CreateParameter("@UserID",3, 1,4, uid)
					.Parameters.Append .CreateParameter("@TestCode",200,1,255,strTestCode)
				End With
				oConn.Open strDBaseConnString
				oCmd.ActiveConnection = oConn
				oCmd.Execute , , 128

				'==================================================================================
				'=== Send them on their way or throw an error message =============================			
				'==================================================================================
				If oConn.Errors.Count < 1 Then
					Response.Redirect("MyTestCodes.asp?res=" & intResellerID )
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
				Response.Write("Ooops!<br><br>Something went wrong and I did not receive either a user id or test code.<br>Grab a donut and get help from a tech support person.")
			End If
		%>
	</td>
</tr>
<!--#INCLUDE FILE="include/footer.asp" -->