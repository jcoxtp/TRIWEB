<%@ Language=VBScript %>
<% intPageID = 63 %>
<!-- #Include File="Include/CheckAdminLogin.asp" -->
<!-- #Include virtual="pdi/Include/Common.asp" -->
<!-- #Include File="Include/DateTimeFunctions.asp" -->
<!-- #Include File="Include/FormattingFunctions.asp" -->
<%
	pageID = ""
	If Not IsAuthorized(4) Then 
		Response.Redirect("/pdi/login.asp?res=" & intResellerID)
	End If
%>
<!-- #Include File="Include/header.asp" -->
<tr>
	<td valign="top" class="maincontent">
<%
			Dim intNewFVuid, oConn, oCmd
			If IsEmpty(Request("NewFVuid")) Then 
				intNewFVuid = 0
			Else
				intNewFVuid = 0
				If IsNumeric(Request("NewFVuid")) Then intNewFVuid = Request("NewFVuid")
			End If
			If intNewFVuid > 0 then
				'==================================================================================
				'=== Make the user a Financials Viewer in the db ==================================
				'==================================================================================
				Set oConn = CreateObject("ADODB.Connection")
				Set oCmd = CreateObject("ADODB.Command")
				With oCmd
					.CommandText = "spAdminMakeFinancialsViewer"
					.CommandType = 4
					.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
					.Parameters.Append .CreateParameter("@UserID",3, 1,4, intNewFVuid)
				End With
				oConn.Open strDbConnString
				oCmd.ActiveConnection = oConn
				oCmd.Execute , , 128
				
				'==================================================================================
				'=== Send them on their way or throw an error message =============================
				'==================================================================================
				If oConn.Errors.Count < 1 Then
					Response.Redirect("FinancialViewers.asp?res=" & intResellerID )
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
<!-- #Include File="Include/Footer.asp" -->