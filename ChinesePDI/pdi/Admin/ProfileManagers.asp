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
	<td valign="top" class="leftnav"><!--#INCLUDE FILE="include/navigation.asp" --></td>
	<td valign="top" class="maincontent">
		<h1>Profile Managers</h1>
		<a href="ProfileManagersAddNew.asp?res=<%=intResellerID%>">Create New Profile Manager</a><br><br>
		<%
			'== Get the data for the given timeframe
			Dim oConn, oCmd, oRs
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
				Response.Write ("<TABLE BORDER=""0"" CELLPADDING=""0"" CELLSPACING=""2"" CLASS=""dgDataGrid"">")
				'== Write the Header Row ===================
				Response.Write ("	<TR CLASS=""dgHeaderRow"">")
				Response.Write ("		<TD CLASS=""dgHeaderCell""> ID </TD>" & VbCrLf)
				Response.Write ("		<TD CLASS=""dgHeaderCell""> Username </TD>" & VbCrLf)
				Response.Write ("		<TD CLASS=""dgHeaderCell""> First Name </TD>" & VbCrLf)
				Response.Write ("		<TD CLASS=""dgHeaderCell""> Last Name </TD>" & VbCrLf)
				Response.Write ("		<TD CLASS=""dgHeaderCell""> Email Address </TD>" & VbCrLf)
				Response.Write ("	</TR>")
				'== Write the Table Rows =================
				oRs.MoveFirst
				Dim bAltItem : bAltItem = False
				Do While Not oRs.EOF
					If bAltItem then
						Response.Write "<TR CLASS=""dgAltItemRow"" onmouseover=""this.className='dgItemRowHover'"" onmouseout=""this.className='dgAltItemRow'"">" : bAltItem = NOT bAltItem
					Else
						Response.Write "<TR CLASS=""dgItemRow"" onmouseover=""this.className='dgItemRowHover'"" onmouseout=""this.className='dgItemRow'"">" : bAltItem = NOT bAltItem
					End If
					'== Write the table cells ================
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("UserID") & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("UserName") & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("FirstName") & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("LastName") & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""left"">" & oRs("EmailAddress") & "</TD>" & VbCrLf)
					Response.Write ("	</TR>")
				oRS.MoveNext
				Loop
				Response.Write ("</TABLE>")
			Else
				  strErrMsg = Err.description
				  Err.Clear
			End If
			If strErrMsg <> "" Then
				  Response.Write "<br>"
				  Response.Write strErrMsg
				  Response.Write "<br><br>"
			End If
		%>
	</td>
</tr>
<!--#INCLUDE FILE="include/footer.asp" -->