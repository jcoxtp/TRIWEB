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
<script language="JavaScript" src="include/calendar.js"></script>
<script language="JavaScript">
<!--	
	function getDetail(ActiveRes) {
		document.thisForm.ActiveRes.value = ActiveRes;
		document.thisForm.action = 'ReportingResellerDetailMonthlyByDay.asp?res=' + <%=intResellerID%>;
		//alert(document.thisForm.action);
		document.thisForm.submit();
	}
	
-->
</script>
<tr>
	<td valign="top" class="leftnav"><!--#INCLUDE FILE="include/navigation.asp" --></td>
	<td valign="top" class="maincontent">
		<%
			on error resume next
			Dim bSubmitted : bSubmitted = Request.Form ("txtSubmit")
			Dim bFilledOutProperly : bFilledOutProperly = FALSE
			Dim strErrMsg
			
			If bSubmitted <> "" Then
				SelectedYear = Request("intYear")
				SelectedMonth = Request("intMonth")
			else
				SelectedMonth = month(Now())
				SelectedYear = year(Now())
			End If 
			bFilledOutProperly = TRUE
		%>
		<form name="thisForm" id="thisForm" method="post" action="ReportingResellerTotalsMonthly.asp">
			<input type="hidden" name="ActiveRes" value="">
		<h1>Monthly Financials</h1>
		<hr>
		<strong>Select a date to display accounting numbers:</strong>
		<br><br>
		<table border="0" cellpadding="0" cellspacing="5">
			<tr>
				<td>Date</td>
				<td>
					<select name="intMonth" id="intMonth">
						<option value="01" <% If SelectedMonth=1 Then Response.Write " selected" End If %>>January
						<option value="02" <% If SelectedMonth=2 Then Response.Write " selected" End If %>>February
						<option value="03" <% If SelectedMonth=3 Then Response.Write " selected" End If %>>March
						<option value="04" <% If SelectedMonth=4 Then Response.Write " selected" End If %>>April
						<option value="05" <% If SelectedMonth=5 Then Response.Write " selected" End If %>>May
						<option value="06" <% If SelectedMonth=6 Then Response.Write " selected" End If %>>June
						<option value="07" <% If SelectedMonth=7 Then Response.Write " selected" End If %>>July
						<option value="08" <% If SelectedMonth=8 Then Response.Write " selected" End If %>>August
						<option value="09" <% If SelectedMonth=9 Then Response.Write " selected" End If %>>September
						<option value="10" <% If SelectedMonth=10 Then Response.Write " selected" End If %>>October
						<option value="11" <% If SelectedMonth=11 Then Response.Write " selected" End If %>>November
						<option value="12" <% If SelectedMonth=12 Then Response.Write " selected" End If %>>December
					</select>
					<select name="intYear" id="intYear">
					<%
					Dim LoopYear
					LoopYear = CInt(year(Now()))
					Do While LoopYear >= 2002
						Response.Write "<option value=" & LoopYear & " " 
						If CInt(SelectedYear) = CInt(LoopYear) Then
							Response.Write " selected"
						End If
						Response.Write">" & LoopYear
						LoopYear = LoopYear - 1
					Loop
					%>
					</select>
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
				StartDate = SelectedYear & "-" & SelectedMonth & "-01 00:00:00"		
				EndDate = SelectedYear & "-" & SelectedMonth & "-" & SelectedMonthDays & " 23:59:59"		
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
			
				oConn.Open strDBaseConnString
				oCmd.ActiveConnection = oConn
				oRs.CursorLocation = 3
				oRs.Open oCmd, , 0, 1
				If oConn.Errors.Count < 1 then
					Dim intSales, intDisc, intCommis, intDiscSales, intItemsSold, intPDIP, intSELL, intCOMM, intTEAM, intLEAD, intTIME, intDRMA
					intSales = 0 : intDisc = 0 : intCommis = 0 : intDiscSales = 0 : intItemsSold = 0 : intPDIP = 0 : intSELL = 0 : intCOMM = 0 : intTEAM = 0 : intLEAD = 0 : intTIME = 0 : intDRMA = 0
					Response.Write("<h1>" & MonthName(SelectedMonth) & ", " & SelectedYear & "</h1>")
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
						Response.Write ("		<TD CLASS=""dgItemCell""><a class=""dgItem"" HREF=""javascript:getDetail(" & oRs("ID") & ");"">" & oRs("Reseller") & "</a></TD>")
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FormatCurrency(oRs("TotalAmount"),2) & "</TD>")
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FormatCurrency(oRs("TotalDiscount"),2) & "</TD>")
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FormatCurrency(oRs("TotalCommission"),2) & "</TD>")
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FormatCurrency(oRs("DiscountedTotal"),2) & "</TD>")
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("NoTestsPurchased") & "</TD>")
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("PDIP") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("SELL") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("COMM") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("TEAM") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("LEAD") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("TIME") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("DRMA") & "</TD>" & VbCrLf)
						Response.Write ("	</TR>")
						' Add these values to the totals...
						intSales = intSales + oRs("TotalAmount") 					:	intDisc = intDisc + oRs("TotalDiscount") 
						intCommis = intCommis + oRs("TotalCommission") 			:	intDiscSales = intDiscSales + oRs("DiscountedTotal") 
						intItemsSold = intItemsSold + oRs("NoTestsPurchased")	:	intPDIP = intPDIP + oRs("PDIP") 
						intSELL = intSELL + oRs("SELL")	:	intCOMM = intCOMM + oRs("COMM")	:	intTEAM = intTEAM + oRs("TEAM") 
						intLEAD = intLEAD + oRs("LEAD") 	:	intTIME = intTIME + oRs("TIME") 	:	intDRMA = intDRMA + oRs("DRMA") 					
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
			End If ' Closes ==> 	If bFilledOutProperly Then
			If strErrMsg <> "" Then
				  Response.Write "<br>"
				  Response.Write strErrMsg
				  Response.Write "<br><br>"
			End If 
		%>
	</td>
</tr>
<!--#INCLUDE FILE="include/footer.asp" -->