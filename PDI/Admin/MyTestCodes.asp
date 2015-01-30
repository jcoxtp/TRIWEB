<%@ Language=VBScript %>
<% intPageID = 63 %>
<!--#Include FILE="Include/CheckAdminLogin.asp" -->
<!--#Include virtual="pdi/Include/common.asp" -->
<!--#Include FILE="Include/FormattingFunctions.asp" -->
<%
	If Not IsAuthorized(4) Then
		Response.Redirect("/pdi/login.asp?res=" & intResellerID)
	End If
	strSortColumn = Request.Form("SortColumn")
	If strSortColumn = "" Then
		strSortColumn = "TC"
	End If
%>
<!--#Include FILE="Include/header.asp" -->
<script language="JavaScript">
<!--
	function sortColumn(val) {
		document.SorterForm.action = "MyTestCodes.asp";
		document.SorterForm.SortColumn.value = val;
		window.status=val;
		document.SorterForm.submit();
	}
-->
</script>
<tr>
	<td valign="top" class="leftnav"><!--#Include FILE="Include/navigation.asp" --></td>
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
				.CommandText = "spAdminTrackUnusedPurchasedTestCodes"
				.CommandType = 4
				.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				.Parameters.Append .CreateParameter("@UserID",3, 1,4, UserID)
				.Parameters.Append .CreateParameter("@SortColumn", 200, 1, 2, strSortColumn)
			End With
			oConn.Open strDbConnString
			oCmd.ActiveConnection = oConn
			oRs.CursorLocation = 3
			oRs.Open oCmd, , 0, 1
			If oConn.Errors.Count < 1 then
				Response.Write("<h1>My Unused Test Codes</h1>")
				Response.Write "<br><em>Click a column header button to sort by that column</em>"
				Response.Write "<form name=""SorterForm"" method=""post"">"
				Response.Write "	<input type=""hidden"" name=""SortColumn"" value=""" & strSortColumn & """>"
				Response.Write ("<TABLE BORDER=""0"" CELLPADDING=""0"" CELLSPACING=""2"" CLASS=""dgDataGrid"" WIDTH=""50%"">")
				'== Write the Header Row ===================
				Response.Write ("	<TR CLASS=""dgHeaderRow"">")
				Response.Write "		<TD CLASS=""dgHeaderCell"" Width=""10%""><input type=""button"" name=""TC"" value="" Test Code "" onClick=""javascript:sortColumn('TC')"";></TD>" & VbCrLf
				Response.Write "		<TD CLASS=""dgHeaderCell"" Width=""10%""><input type=""button"" name=""PR"" value="" Purchased "" onClick=""javascript:sortColumn('PR')"";></TD>" & VbCrLf
				Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">&nbsp;</TD>" & VbCrLf)
				Response.Write ("	</TR>")
				'== Write the Table Rows =================
				Dim bAltItem : bAltItem = False
				Do While Not oRs.EOF
					If bAltItem then
						Response.Write "<TR CLASS=""dgAltItemRow"" onmouseover=""this.className='dgItemRowHover'"" onmouseout=""this.className='dgAltItemRow'"">" : bAltItem = NOT bAltItem
					Else
						Response.Write "<TR CLASS=""dgItemRow"" onmouseover=""this.className='dgItemRowHover'"" onmouseout=""this.className='dgItemRow'"">" : bAltItem = NOT bAltItem
					End If
					'== Write the table cells ================
					Response.Write ("		<TD CLASS=""dgItemCell"">" & oRs("TestCode") & "</TD>")
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FmtGetDate(oRs("PurchaseDate")) & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center""><a href=""MyTestCodesTransfer.asp?res=" & intResellerID & "&tc=" & oRs("TestCode") & """>Transfer</a></TD>" & VbCrLf)
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