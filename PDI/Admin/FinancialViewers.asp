<%@ Language=VBScript %>
<% intPageID = 63 %>
<!-- #Include File="include/CheckAdminLogin.asp" -->
<!-- #Include virtual="pdi/include/common.asp" -->
<!-- #Include File="include/DateTimeFunctions.asp" -->
<!-- #Include File="include/FormattingFunctions.asp" -->
<%
	If Not IsAuthorized(4) Then
		Response.Redirect("/pdi/login.asp?res=" & intResellerID)
	End If
	strSortColumn = Request.Form("SortColumn")
	If strSortColumn = "" Then
		strSortColumn = "ID"
	End If
%>
<!-- #Include File="include/header.asp" -->
<script language="JavaScript">
<!--
	function sortColumn(val) {
		document.SorterForm.action = "FinancialViewers.asp";
		document.SorterForm.SortColumn.value = val;
		window.status=val;
		document.SorterForm.submit();
	}
-->
</script>
<tr>
	<td valign="top" class="leftnav"><!-- #Include File="Include/Navigation.asp" --></td>
	<td valign="top" class="maincontent">
		<h1>Financials Viewers</h1>
		<a href="FinancialViewersAddNew.asp?res=<%=intResellerID%>">Create New Financials Viewer</a><br><br>
		<br><em>Click a column header button to sort by that column</em>
<%
	'== Get the data for the given timeframe
	Dim oConn, oCmd, oRs
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	With oCmd
		.CommandText = "spAdminGetFinancialsViewers"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@SortColumn", 200, 1, 2, strSortColumn)
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	If oConn.Errors.Count < 1 Then
		Response.Write "<form name=""SorterForm"" method=""post"">"
		Response.Write "	<input type=""hidden"" name=""SortColumn"" value=""" & strSortColumn & """>"
		Response.Write "<TABLE BORDER=""0"" CELLPADDING=""0"" CELLSPACING=""2"" CLASS=""dgDataGrid"">"
		'== Write the Header Row ===================
		Response.Write "	<TR CLASS=""dgHeaderRow"">"
		Response.Write "			<TD CLASS=""dgHeaderCell""><input type=""button"" name=""ID"" value="" ID "" onClick=""javascript:sortColumn('ID')"";></TD>" & VbCrLf
		Response.Write "			<TD CLASS=""dgHeaderCell""><input type=""button"" name=""UN"" value="" Username "" onClick=""javascript:sortColumn('UN')"";></TD>" & VbCrLf
		Response.Write "			<TD CLASS=""dgHeaderCell""><input type=""button"" name=""FN"" value="" First Name "" onClick=""javascript:sortColumn('FN')"";></TD>" & VbCrLf
		Response.Write "			<TD CLASS=""dgHeaderCell""><input type=""button"" name=""LN"" value="" Last Name "" onClick=""javascript:sortColumn('LN')"";></TD>" & VbCrLf
		Response.Write "			<TD CLASS=""dgHeaderCell""><input type=""button"" name=""EM"" value="" Email Address "" onClick=""javascript:sortColumn('EM')"";></TD>" & VbCrLf
		Response.Write "			<TD CLASS=""dgHeaderCell""><input type=""button"" name=""RS"" value="" Reseller "" onClick=""javascript:sortColumn('RS')"";></TD>" & VbCrLf
		Response.Write "	</TR>"
		'== Write the Table Rows =================
		Dim bAltItem : bAltItem = False
		Do While Not oRs.EOF
			If bAltItem Then
				Response.Write "<TR CLASS=""dgAltItemRow"" onmouseover=""this.className='dgItemRowHover'"" onmouseout=""this.className='dgAltItemRow'"">" : bAltItem = Not bAltItem
			Else
				Response.Write "<TR CLASS=""dgItemRow"" onmouseover=""this.className='dgItemRowHover'"" onmouseout=""this.className='dgItemRow'"">" : bAltItem = Not bAltItem
			End If
			'== Write the table cells ================
			Response.Write "		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("UserID") & "</TD>" & VbCrLf
			Response.Write "		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("UserName") & "</TD>" & VbCrLf
			Response.Write "		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("FirstName") & "</TD>" & VbCrLf
			Response.Write "		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("LastName") & "</TD>" & VbCrLf
			Response.Write "		<TD CLASS=""dgItemCell"" align=""left"">" & oRs("EmailAddress") & "</TD>" & VbCrLf
			Response.Write "		<TD CLASS=""dgItemCell"" align=""left"">" & oRs("ResellerName") & "</TD>" & VbCrLf
			Response.Write "	</TR>"
		oRS.MoveNext
		Loop
		Response.Write "</Table>"
		Response.Write "</form>"
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
<!-- #Include File="Include/Footer.asp" -->