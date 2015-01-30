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
<script language="JavaScript" src="Include/calendar.js"></script>
<tr>
	<td valign="top" class="leftnav"><!--#Include FILE="Include/navigation.asp" --></td>
	<td valign="top" class="maincontent">
		<%
			on error resume next
			Dim bSubmitted : bSubmitted = Request.Form ("txtSubmit")
			Dim bFilledOutProperly : bFilledOutProperly = FALSE
			Dim strErrMsg
			
			If bSubmitted <> "" Then
				SelectedDate = Request("txtDate")
			else
				SelectedDate = getToday()' returns "Now" in yyyy-mm-dd
			End If 
			bFilledOutProperly = TRUE
		%>
		<form name="thisForm" id="thisForm" method="post" action="ReportingResellerTotalsDaily.asp">
		<h1>Daily Financials</h1>
		<hr>
		<strong>Select a date to display accounting numbers:</strong>
		<br><br>
		<table border="0" cellpadding="0" cellspacing="5">
			<tr>
				<td>Date</td>
				<td>
					<input type="text" name="txtDate" class="" value="<%=SelectedDate%>" maxlength="10" style="width:80px;">
					<a class="" href="javascript:show_calendar('thisForm.txtDate')"><img src="images/calendar.gif" width="16" height="16" border="0" alt="Calendar" align=absmiddle></a>		
				</td>
				<td align="right">
					<input type="hidden" name="txtSubmit" id="txtSubmit" value=1>
					<input type="submit" border=0 value="Generate Report" id=add name=add>
				</td>
			</tr>
		</table>	</form>
		<hr>
		<%
			If bFilledOutProperly Then
				'== Prepare the dates for the stored proc ===============
				Dim SelectedMonthDays
				SelectedMonthDays = getDaysInMonth(SelectedMonth,SelectedYear) ' DateTimeFunctions.asp
				Dim StartDate, EndDate
				StartDate = SelectedDate & " 00:00:00"		
				EndDate = SelectedDate & " 23:59:59"		
				'Response.Write("StartDate=" & StartDate & "<br>")	
				'Response.Write("EndDate=" & EndDate & "<br>")	
		
				'== Get the data for the given timeframe
				Dim oConn, oCmd, oRs
				Set oConn = CreateObject("ADODB.Connection")
				Set oCmd = CreateObject("ADODB.Command")
				Set oRs = CreateObject("ADODB.Recordset")
				With oCmd
					.CommandText = "spAdminReportingGetSalesTotals"
					.CommandType = 4
					.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
					'-- Incoming DateTimes Use ODBC canonical (24hrs)--> yyyy-mm-dd hh:mi:ss
					.Parameters.Append .CreateParameter("@StartDate",200,1,19,StartDate)
					.Parameters.Append .CreateParameter("@EndDate",200,1,19,EndDate)
					.Parameters.Append .CreateParameter("@csvResellerID",200,1,8000,"")' contains a comma delimited string of reseller id's
					.Parameters.Append .CreateParameter("@GroupByDatePart",200,1,20,"") ' contains sql datepart identifiers (month,day,year,etc.)
				End With
			
				oConn.Open strDbConnString
				oCmd.ActiveConnection = oConn
				oRs.CursorLocation = 3
				oRs.Open oCmd, , 0, 1
				If oConn.Errors.Count < 1 then
					Dim intSales, intDisc, intCommis, intDiscSales, intItemsSold, intPDIP, intPDDG, intSELL, intCOMM, intTEAM, intLEAD, intTIME, intDRMA
					intSales = 0 : intDisc = 0 : intCommis = 0 : intDiscSales = 0 : intItemsSold = 0 : intPDIP = 0 : intPDDG = 0 : intSELL = 0 : intCOMM = 0 : intTEAM = 0 : intLEAD = 0 : intTIME = 0 : intDRMA = 0
					Response.Write("<h1>" & MonthName(Month(StartDate)) & " " & Day(StartDate) & ", " & Year(StartDate) & "</h1>")
					Response.Write ("<TABLE BORDER=""0"" CELLPADDING=""0"" CELLSPACING=""2"" CLASS=""dgDataGrid"">")
					'== Write the Header Row ===================
					Response.Write ("	<TR CLASS=""dgHeaderRow"">")
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""25%"">Reseller</TD>")
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">Sales</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">Disc.</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">Comm.</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">Disc. Sales</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">Items Sold</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">PDIP</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">PDDG</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">SELL</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">COMM</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">TEAM</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">LEAD</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">TIME</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">DRMA</TD>" & VbCrLf)
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
						Response.Write ("		<TD CLASS=""dgItemCell"">" & oRs("Reseller") & "</TD>")
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FormatCurrency(oRs("TotalAmount"),2) & "</TD>")
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FormatCurrency(oRs("TotalDiscount"),2) & "</TD>")
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FormatCurrency(oRs("TotalCommission"),2) & "</TD>")
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FormatCurrency(oRs("DiscountedTotal"),2) & "</TD>")
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("NoTestsPurchased") & "</TD>")
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("PDIP") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("PDDG") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("SELL") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("COMM") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("TEAM") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("LEAD") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("TIME") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("DRMA") & "</TD>" & VbCrLf)
						Response.Write ("	</TR>")
						' Add these values to the totals...
						intSales = intSales + oRs("TotalAmount") : intDisc = intDisc + oRs("TotalDiscount")
						intCommis = intCommis + oRs("TotalCommission") : intDiscSales = intDiscSales + oRs("DiscountedTotal")
						intItemsSold = intItemsSold + oRs("NoTestsPurchased") : intPDIP = intPDIP + oRs("PDIP")
						intPDDG = intPDDG + oRs("PDDG") : intSELL = intSELL + oRs("SELL")	:	intCOMM = intCOMM + oRs("COMM")
						intTEAM = intTEAM + oRs("TEAM") : intLEAD = intLEAD + oRs("LEAD") 	:	intTIME = intTIME + oRs("TIME")
						intDRMA = intDRMA + oRs("DRMA")
					oRS.MoveNext
					Loop
					'== Write out the totals ==================
					Response.Write ("	<TR CLASS=""dgHeaderRow"">")
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""25%"">Totals</TD>")
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">" & FormatCurrency(intSales,2) & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">" & FormatCurrency(intDisc,2) & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">" & FormatCurrency(intCommis,2) & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">" & FormatCurrency(intDiscSales,2) & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">" & intItemsSold & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">" & intPDIP & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">" & intPDDG & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">" & intSELL & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">" & intCOMM & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">" & intTEAM & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">" & intLEAD & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">" & intTIME & "</TD>" & VbCrLf)
					Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""5%"">" & intDRMA & "</TD>" & VbCrLf)
					Response.Write ("	</TR>")
					Response.Write ("</TABLE>")
				Else
					  strErrMsg = Err.description
					  Err.Clear
				End If
			End If ' Closes ==> If bFilledOutProperly Then
			If strErrMsg <> "" Then
				  Response.Write "<br>"
				  Response.Write strErrMsg
				  Response.Write "<br><br>"
			End If
		%>
	</td>
</tr>
<!--#Include FILE="Include/footer.asp" -->