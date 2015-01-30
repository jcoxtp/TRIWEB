<%@ Language=VBScript %>
<% intPageID = 60 %>
<!--#Include FILE="Include/CheckAdminLogin.asp" -->
<!--#Include virtual="pdi/Include/common.asp" -->
<!--#Include FILE="Include/FormattingFunctions.asp" -->
<%
	pageID = ""
	If Not IsAuthorized(4) Then
		Response.Redirect("/pdi/login.asp?res=" & intResellerID)
	End If
	strSortColumn = Request.Form("SortColumn")
	If strSortColumn = "" Then
		strSortColumn = "CR"
	End If
%>
<!--#Include FILE="Include/header.asp" -->
<script language="JavaScript">
<!--
	function sortColumn(val) {
		document.SorterForm.action = "ResellerMain.asp";
		document.SorterForm.SortColumn.value = val;
		window.status=val;
		document.SorterForm.submit();
	}
-->
</script>
<tr>
	<td valign="top" class="leftnav"><!--#Include FILE="Include/navigation.asp" --></td>
	<td valign="top" class="maincontent">
		<h1>Current Resellers</h1>
		<hr>
		<br><br><em>Click a column header button to sort by that column</em>
<%
'			On Error Resume Next
			Dim strErrMsg
			Dim oConn, oCmd, oRs
			Set oConn = CreateObject("ADODB.Connection")
			Set oCmd = CreateObject("ADODB.Command")
			Set oRs = CreateObject("ADODB.Recordset")
			With oCmd
				.CommandText = "spAdminResellerGetAllOverview"
				.CommandType = 4
				.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				.Parameters.Append .CreateParameter("@SortColumn", 200, 1, 2, strSortColumn)
			End With
			oConn.Open strDbConnString
			oCmd.ActiveConnection = oConn
			oRs.CursorLocation = 3
			oRs.Open oCmd, , 0, 1
			If oConn.Errors.Count < 1 then
				Response.Write "<form name=""SorterForm"" method=""post"">"
				Response.Write "	<input type=""hidden"" name=""SortColumn"" value=""" & strSortColumn & """>"
				Response.Write ("<TABLE BORDER=""0"" CELLPADDING=""0"" CELLSPACING=""2"" CLASS=""dgDataGrid"">")
				'== Write the Header Row ===================
				Response.Write ("	<TR CLASS=""dgHeaderRow"">")
				Response.Write "		<TD CLASS=""dgHeaderCell""><input type=""button"" name=""RS"" value="" Reseller "" onClick=""javascript:sortColumn('RS')"";></TD>" & VbCrLf
				Response.Write "		<TD CLASS=""dgHeaderCell""><input type=""button"" name=""CT"" value="" City "" onClick=""javascript:sortColumn('CT')"";></TD>" & VbCrLf
				Response.Write "		<TD CLASS=""dgHeaderCell""><input type=""button"" name=""ST"" value="" State "" onClick=""javascript:sortColumn('ST')"";></TD>" & VbCrLf
				Response.Write "		<TD CLASS=""dgHeaderCell""><input type=""button"" name=""CR"" value="" Created "" onClick=""javascript:sortColumn('CR')"";></TD>" & VbCrLf
				Response.Write "		<TD CLASS=""dgHeaderCell""><input type=""button"" name=""DS"" value="" Discount "" onClick=""javascript:sortColumn('DS')"";></TD>" & VbCrLf
				Response.Write "		<TD CLASS=""dgHeaderCell""><input type=""button"" name=""CM"" value="" Commission "" onClick=""javascript:sortColumn('CM')"";></TD>" & VbCrLf
				Response.Write "		<TD CLASS=""dgHeaderCell""><input type=""button"" name=""CP"" value="" Companies "" onClick=""javascript:sortColumn('CP')"";></TD>" & VbCrLf
				Response.Write "		<TD CLASS=""dgHeaderCell""><input type=""button"" name=""US"" value="" Users "" onClick=""javascript:sortColumn('US')"";></TD>" & VbCrLf
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
<!--#Include FILE="Include/footer.asp" -->