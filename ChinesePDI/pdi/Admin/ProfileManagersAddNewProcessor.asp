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
			Dim intNewPMuid, oConn, oCmd
			If IsEmpty(Request("NewPMuid")) Then 
				intNewPMuid = 0
			Else
				intNewPMuid = 0
				If IsNumeric(Request("NewPMuid")) Then intNewPMuid = Request("NewPMuid")
			End If
			If intNewPMuid > 0 then
				'==================================================================================
				'=== Make the user a Profile Manager in the db ====================================
				'==================================================================================
				Set oConn = CreateObject("ADODB.Connection")
				Set oCmd = CreateObject("ADODB.Command")
				With oCmd
					.CommandText = "spAdminMakeProfileManager"
					.CommandType = 4
					.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
					.Parameters.Append .CreateParameter("@UserID",3, 1,4, intNewPMuid)
				End With
				oConn.Open strDBaseConnString
				oCmd.ActiveConnection = oConn
				oCmd.Execute , , 128

				'==================================================================================
				'=== Send them on their way or throw an error message =============================			
				'==================================================================================
				If oConn.Errors.Count < 1 Then
					Response.Redirect("ProfileManagers.asp?res=" & intResellerID )
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
				Response.Write("Ooops!<br><br>Something went wrong and I did not receive a user id.<br>Grab a donut and get help from a tech support person.")
			End If
		%>
	</td>
</tr>
<!--#INCLUDE FILE="include/footer.asp" -->