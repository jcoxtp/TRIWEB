<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/CheckAdminLogin.asp" -->
<!--#INCLUDE FILE="../include/common.asp" -->
<!--#INCLUDE FILE="include/FormattingFunctions.asp" -->
<%
	pageID = ""
	'If Not IsAuthorized(4) Then 
	'	Response.Redirect("/pdi/login.asp?res=" & intResellerID)
	'End If
%>
<!--#INCLUDE FILE="include/header.asp" -->
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
			End With
		
			oConn.Open strDBaseConnString
			oCmd.ActiveConnection = oConn
			oRs.CursorLocation = 3
			oRs.Open oCmd, , 0, 1
			If oConn.Errors.Count < 1 then
				Response.Write("<h1>Test Results</h1>")
				Response.Write ("<TABLE BORDER=""0"" CELLPADDING=""0"" CELLSPACING=""2"" CLASS=""dgDataGrid"">")
				'== Write the Header Row ===================
				Response.Write ("	<TR CLASS=""dgHeaderRow"">")
				Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">Test Code</TD>" & VbCrLf)
				Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">Purchased</TD>" & VbCrLf)
				Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">Used</TD>" & VbCrLf)
				Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">Test Taker</TD>" & VbCrLf)
				Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">Started</TD>" & VbCrLf)
				Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">Completed</TD>" & VbCrLf)
				Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"" nowrap>Type 1</TD>" & VbCrLf)
				Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"" nowrap>Type 2</TD>" & VbCrLf)
				Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">Profile</TD>" & VbCrLf)
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
					' Determine if there is a pdf related to this row - if so, link to it.
					If IsPDF(oRs("TestCode"), oRs("FileCreated"), oRs("AppModCreated")) Then
						Select Case LEFT(oRs("TestCode"),4)
							Case "PDIP"
								Response.Write ("		<TD CLASS=""dgItemCell""><a class=""dgItem"" HREF=""http://" & Application("SiteDomain") & Application("PDFOut_SitePath") & oRs("PDFFileName") & """ target=""_blank"">" & oRs("TestCode") & "</a></TD>")
							Case Else
								Response.Write ("		<TD CLASS=""dgItemCell""><a class=""dgItem"" HREF=""http://" & Application("SiteDomain") & Application("PDFOut_SitePath") & oRs("AppModFileName") & """ target=""_blank"">" & oRs("TestCode") & "</a></TD>")
						End Select
					Else
						Response.Write ("		<TD CLASS=""dgItemCell"">" & oRs("TestCode") & "</TD>")
					End If						
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FmtGetDate(oRs("PurchaseDate")) & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""left"" nowrap>" & FmtBool(oRs("Redeemed"),"Yes","No") & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""left"" nowrap>" & oRs("TestTaker") & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FmtGetDate(oRs("TestStartDate")) & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FmtGetDate(oRs("TestCompleteDate")) & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("HighFactorType1") & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("HighFactorType2") & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("RepProfileName") & "</TD>" & VbCrLf)
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
<%
	function IsPDF(TestCode,FileCreated,AppModCreated)
		IsPDF = False
		Select Case LEFT(TestCode,4)
			Case "PDIP"
				If FileCreated = 1 Then IsPDF = True
			Case Else
				If AppModCreated = 1 Then IsPDF = True
		End Select
	end function

%>