<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/CheckAdminLogin.asp" -->
<!--#INCLUDE FILE="../include/common.asp" -->
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
		<h1>Current Resellers</h1>
		<hr>
		<%
			on error resume next
			Dim strErrMsg
			Dim oConn, oCmd, oRs
			Set oConn = CreateObject("ADODB.Connection")
			Set oCmd = CreateObject("ADODB.Command")
			Set oRs = CreateObject("ADODB.Recordset")
			With oCmd
				.CommandText = "spAdminResellerGetAllOverview"
				.CommandType = 4
				.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			End With
		
			oConn.Open strDBaseConnString
			oCmd.ActiveConnection = oConn
			oRs.CursorLocation = 3
			oRs.Open oCmd, , 0, 1
			If oConn.Errors.Count < 1 then
				Response.Write ("<TABLE BORDER=""0"" CELLPADDING=""0"" CELLSPACING=""2"" CLASS=""dgDataGrid"">")
				'== Write the Header Row ===================
				Response.Write ("	<TR CLASS=""dgHeaderRow"">")
				Response.Write ("		<TD CLASS=""dgHeaderCell"">Reseller</TD>")
				Response.Write ("		<TD CLASS=""dgHeaderCell"">City</TD>")
				Response.Write ("		<TD CLASS=""dgHeaderCell"">State</TD>")
				Response.Write ("		<TD CLASS=""dgHeaderCell"">Created</TD>")
				Response.Write ("		<TD CLASS=""dgHeaderCell"">Discount</TD>")
				Response.Write ("		<TD CLASS=""dgHeaderCell"">Commission</TD>")
				Response.Write ("		<TD CLASS=""dgHeaderCell"">Companies</TD>")
				Response.Write ("		<TD CLASS=""dgHeaderCell"">Users</TD>")
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
					Response.Write ("		<TD CLASS=""dgItemCell""><a class=""dgItem"" HREF=""ResellerDetail.asp?res=" & intResellerID & "&ActiveRes=" & oRs("ID") & """>" & oRs("Reseller") & "</a></TD>")
					Response.Write ("		<TD CLASS=""dgItemCell"">" & oRs("City") & "</TD>")
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("State") & "</TD>")
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("Created") & "</TD>")
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FmtBool(oRs("Discount"),"Yes","No") & "</TD>")
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FmtBool(oRs("Discount"),"Yes","No") & "</TD>")
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("Companies") & "</TD>")
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("Users") & "</TD>")
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