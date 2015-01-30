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
		<%
			on error resume next
			Dim bSubmitted : bSubmitted = Request.Form ("txtSubmit")
			Dim bFilledOutProperly : bFilledOutProperly = FALSE
			Dim strErrMsg
			Dim oConn, oCmd, oRs

			Dim txtSearch
			If bSubmitted <> "" Then
				If IsEmpty(Request("txtSearch")) Then 
					txtSearch = "" ' will probably return all users if it doesn't timeout first :)
				Else
					txtSearch = Request("txtSearch")
				End If
			End If 
			bFilledOutProperly = TRUE
		%>
		<form name="thisForm" id="thisForm" method="post" action="FinancialViewersAddNew.asp?res=<%=intResellerID%>">
		<h1>Create a New Financials Viewer</h1><hr>
		<table border="0" cellpadding="5" cellspacing="3" width="" class="dgDataGrid">
			<tr class="dgAltItemRow">
				<td valign="top">
					<b>To Create a New Financials Viewer follow these steps:</b><br><br>
					<ol type="1">
						<li>Enter text in the box below related to the user you wish to make a financials viewer and click "Search for Users".  
						You may enter alpha-numeric characters from the user's first or last name, username, email address, or system UserID.
						<li>You will then be shown a listing of all users matching your search text.  Identify the user you are looking for 
						and click the "Make Financials Viewer" link next to their username.
					</ol>
				</td>
			</tr>
			<tr class="dgAltItemRow">
				<td valign="middle" align="center">
					<b>Enter Search Text:</b>&nbsp;
					<input type="text" name="txtSearch" class="" value="<%=txtSearch%>" maxlength="255" style="width:240px;">
					<input type="hidden" name="txtSubmit" id="txtSubmit" value=1>
					<input type="submit" border=0 value="Search For Users">
				</td>
			</tr></form>
		</table>
		<hr>
		<%
			If ((bFilledOutProperly) and (bSubmitted = 1)) Then
				Response.Write("<h1>Search Results</h1>")
				'== Get the data
				Set oConn = CreateObject("ADODB.Connection")
				Set oCmd = CreateObject("ADODB.Command")
				Set oRs = CreateObject("ADODB.Recordset")
				With oCmd
					.CommandText = "spAdminGetUserData"
					.Parameters.Append .CreateParameter("@strSearch",200,1,255,txtSearch)
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
					Response.Write ("		<TD CLASS=""dgHeaderCell"" nowrap> First Name </TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" nowrap> Last Name </TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" nowrap> Email Address </TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" nowrap> Username </TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" nowrap> Reseller </TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell""> &nbsp </TD>" & VbCrLf)
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
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""left"" nowrap>" & oRs("FirstName") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""left"" nowrap>" & oRs("LastName") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""left"" nowrap>" & oRs("EmailAddress") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""left"" nowrap>" & oRs("UserName") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""left"" nowrap>" & oRs("ResellerName") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""left"" nowrap><a href=""FinancialViewersAddNewProcessor.asp?res=" & intResellerID & "&NewFVuid=" & oRs("UserID") & """>Make Financials Viewer</a></TD>" & VbCrLf)
						Response.Write ("	</TR>")
					oRS.MoveNext
					Loop
					Response.Write ("</TABLE>")
				Else
					  strErrMsg = Err.description
					  Err.Clear
				End If
			End If ' Closes the ... If ((bFilledOutProperly) and (bSubmitted = 1)) Then
			If strErrMsg <> "" Then
				  Response.Write "<br>"
				  Response.Write strErrMsg
				  Response.Write "<br><br>"
			End If
		%>
	</td>
</tr>
<!--#INCLUDE FILE="include/footer.asp" -->