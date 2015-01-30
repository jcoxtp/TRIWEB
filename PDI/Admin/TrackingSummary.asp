<%@ Language=VBScript %>
<% intPageID = 63 %>
<!-- #Include File = "Include/CheckAdminLogin.asp" -->
<!-- #Include virtual = "pdi/Include/Common.asp" -->
<!-- #Include File = "Include/FormattingFunctions.asp" -->
<%
	pageID = ""
	'If Not IsAuthorized(4) Then 
	'	Response.Redirect("/pdi/login.asp?res=" & intResellerID)
	'End If
	strSortColumn = Request.Form("SortColumn")
	If strSortColumn = "" Then
		strSortColumn = "TC"
	End If
%>
<!--#Include File = "Include/Header.asp" -->
<script language="JavaScript">
<!--
	function sortColumn(val) {
		document.SorterForm.action = "TrackingSummary.asp";
		document.SorterForm.SortColumn.value = val;
		window.status=val;
		document.SorterForm.submit();
	}
-->
</script>

<STYLE TYPE="text/css">
.BUT {
	font: 8pt verdana;
	color: #003399;
	font-weight: bold;
	height: 2.2em;
	padding: 0em;
	vertical-align: 0%;
}
.BUT.middle {
	vertical-align: middle
}
</STYLE>
<tr>
<%	If IsAuthorized(4) Then ' If they aren't an administrator, they can see the page but cannot navigate to other pages %>
	<td valign="top" class="leftnav"><!--#INCLUDE FILE="include/navigation.asp" --></td>
<%	End If %>
	<td valign="top" class="maincontent">
<%
	Dim UserID : UserID = Request.Cookies("UserID")
	'Response.Write("UserID=") : Response.Write(UserID) : Response.Write("<hr>")
	'== Get the data
	Dim oConn, oCmd, oRs
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	With oCmd
		.CommandText = "spAdminTrackPurchasedTestResults"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		.Parameters.Append .CreateParameter("@UserID",3, 1,4, UserID)
		.Parameters.Append .CreateParameter("@SortColumn", 200, 1, 2, strSortColumn)
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	If oConn.Errors.Count < 1 Then
		Response.Write "<h1>Test Results</h1>"
		Response.Write "<br><em>Click a column header button to sort by that column</em>"
		Response.Write "<form name=""SorterForm"" method=""post"">"
		Response.Write "	<input type=""hidden"" name=""SortColumn"" value=""" & strSortColumn & """>"
		Response.Write "<TABLE BORDER=""0"" CELLPADDING=""0"" CELLSPACING=""2"" CLASS=""dgDataGrid"">"
		'== Write the Header Row ===================
		Response.Write "	<TR CLASS=""dgHeaderRow"">"
		Response.Write "		<TD CLASS=""dgHeaderCell"" Width=""10%""><input type=""button"" class=""BUT"" name=""TC"" value=""Test Code"" onClick=""javascript:sortColumn('TC')"";></TD>" & VbCrLf
		Response.Write "		<TD CLASS=""dgHeaderCell"" Width=""10%""><input type=""button"" class=""BUT"" name=""PU"" value=""Purchased"" onClick=""javascript:sortColumn('PU')"";></TD>" & VbCrLf
		Response.Write "		<TD CLASS=""dgHeaderCell"" Width=""10%""><input type=""button"" class=""BUT"" name=""US"" value=""Used"" onClick=""javascript:sortColumn('US')"";></TD>" & VbCrLf
		Response.Write "		<TD CLASS=""dgHeaderCell"" Width=""10%""><input type=""button"" class=""BUT"" name=""TT"" value=""Test Taker"" onClick=""javascript:sortColumn('TT')"";></TD>" & VbCrLf
		Response.Write "		<TD CLASS=""dgHeaderCell"" Width=""10%""><input type=""button"" class=""BUT"" name=""ST"" value=""Started"" onClick=""javascript:sortColumn('ST')"";></TD>" & VbCrLf
		Response.Write "		<TD CLASS=""dgHeaderCell"" Width=""10%""><input type=""button"" class=""BUT"" name=""CP"" value=""Completed"" onClick=""javascript:sortColumn('CP')"";></TD>" & VbCrLf
		Response.Write "		<TD CLASS=""dgHeaderCell"" Width=""10%"" nowrap><input type=""button"" class=""BUT"" name=""T1"" value=""Type 1"" onClick=""javascript:sortColumn('T1')"";></TD>" & VbCrLf
		Response.Write "		<TD CLASS=""dgHeaderCell"" Width=""10%"" nowrap><input type=""button"" class=""BUT"" name=""T2"" value=""Type 2"" onClick=""javascript:sortColumn('T2')"";></TD>" & VbCrLf
		Response.Write "		<TD CLASS=""dgHeaderCell"" Width=""10%""><input type=""button"" class=""BUT"" name=""PR"" value=""Profile"" onClick=""javascript:sortColumn('PR')"";></TD>" & VbCrLf
		Response.Write "		<TD CLASS=""dgHeaderCell"" Width=""10%""><input type=""button"" class=""BUT"" name=""AR"" value="" Area "" onClick=""javascript:sortColumn('AR')"";></TD>" & VbCrLf
		Response.Write "	</TR>"
		'== Write the Table Rows =================
		Dim bAltItem : bAltItem = False
		Do While Not oRs.EOF
			If bAltItem Then
				Response.Write "<TR CLASS=""dgAltItemRow"" onmouseover=""this.className='dgItemRowHover'"" onmouseout=""this.className='dgAltItemRow'"">" : bAltItem = NOT bAltItem
			Else
				Response.Write "<TR CLASS=""dgItemRow"" onmouseover=""this.className='dgItemRowHover'"" onmouseout=""this.className='dgItemRow'"">" : bAltItem = NOT bAltItem
			End If
			'== Write the table cells ================
			' Determine if there is a pdf related to this row - if so, link to it.
			If IsPDF(oRs("TestCode"), oRs("FileCreated"), oRs("AppModCreated")) Then
				Select Case LEFT(oRs("TestCode"),4)
					Case "PDIP"
						Response.Write "		<TD CLASS=""dgItemCell""><a class=""dgItem"" HREF=""http://" & Application("SiteDomain") & Application("PDFOut_SitePath") & oRs("PDFFileName") & """ target=""_blank"">" & oRs("TestCode") & "</a></TD>"
					Case "PDDG"
						Response.Write "		<TD CLASS=""dgItemCell""><a class=""dgItem"" HREF=""http://" & Application("SiteDomain") & Application("PDFOut_SitePath") & oRs("PDFFileName") & """ target=""_blank"">" & oRs("TestCode") & "</a></TD>"
					Case Else
						Response.Write "		<TD CLASS=""dgItemCell""><a class=""dgItem"" HREF=""http://" & Application("SiteDomain") & Application("PDFOut_SitePath") & oRs("AppModFileName") & """ target=""_blank"">" & oRs("TestCode") & "</a></TD>"
				End Select
			Else
				Response.Write "		<TD CLASS=""dgItemCell"">" & oRs("TestCode") & "</TD>"
			End If
			Response.Write "		<TD CLASS=""dgItemCell"" align=""center"">" & FmtGetDate(oRs("PurchaseDate")) & "</TD>" & VbCrLf
			Response.Write "		<TD CLASS=""dgItemCell"" align=""left"" nowrap>" & FmtBool(oRs("Redeemed"),"Yes","No") & "</TD>" & VbCrLf
			Response.Write "		<TD CLASS=""dgItemCell"" align=""left"" nowrap>" & oRs("TestTaker") & "</TD>" & VbCrLf
			Response.Write "		<TD CLASS=""dgItemCell"" align=""center"">" & FmtGetDate(oRs("TestStartDate")) & "</TD>" & VbCrLf
			Response.Write "		<TD CLASS=""dgItemCell"" align=""center"">" & FmtGetDate(oRs("TestCompleteDate")) & "</TD>" & VbCrLf
			Response.Write "		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("HighFactorType1") & "</TD>" & VbCrLf
			Response.Write "		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("HighFactorType2") & "</TD>" & VbCrLf
			Response.Write "		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("RepProfileName") & "</TD>" & VbCrLf
			Response.Write "		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("Area") & "</TD>" & VbCrLf
			Response.Write "	</TR>"
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
<!-- #Include File = "Include/Footer.asp" -->
<%
	Function IsPDF(TestCode,FileCreated,AppModCreated)
		IsPDF = False
		Select Case LEFT(TestCode,4)
			Case "PDIP"
				If FileCreated = 1 Then IsPDF = True
			Case "PDDG"
				If FileCreated = 1 Then IsPDF = True
			Case Else
				If AppModCreated = 1 Then IsPDF = True
		End Select
	End Function
%>