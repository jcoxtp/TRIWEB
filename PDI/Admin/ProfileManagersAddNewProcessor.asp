<%@ Language=VBScript %>
<% intPageID = 63 %>
<!--#Include FILE="Include/CheckAdminLogin.asp" -->
<!--#Include virtual="pdi/Include/common.asp" -->
<!--#Include FILE="Include/DateTimeFunctions.asp" -->
<!--#Include FILE="Include/FormattingFunctions.asp" -->
<%
	pageID = ""
	If Not IsAuthorized(4) Then 
		Response.Redirect("/pdi/login.asp?res=" & intResellerID)
	End If
%>
<!--#Include FILE="Include/header.asp" -->
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
				oConn.Open strDbConnString
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
<!--#Include FILE="Include/footer.asp" -->