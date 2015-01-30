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
	function getData() {
		// check the date fields for proper length
		if ((document.thisForm.txtStartDate.value.length < 10) || (document.thisForm.txtEndDate.value.length < 10)) {
			alert ("Date fields must be formatted \nas shown below.   \n\n       YYYY-MM-DD \n\n");
			return;
		}
		buildResellerIDcsv();
		document.thisForm.action = 'ReportingResellerCustom.asp?res=' + <%=intResellerID%>;
		//alert(document.thisForm.action);
		document.thisForm.submit();
	}

	function buildResellerIDcsv()
	{
		var options_string = "";
		var the_select = window.document.thisForm.selResellerID;
		for (loop=0; loop < the_select.options.length; loop++)
		{
			if (the_select.options[loop].selected == true)
			{
				 options_string += the_select.options[loop].value + ",";
			}
		}
		//alert("you selected: " + options_string);
		options_string = options_string.substr(0, (options_string.length-1))
		//alert("you selected: " + options_string);
		document.thisForm.csvResellerID.value = options_string;
	}
	
	function writeResellerIDList()
	{
		var reseller_list = "";
		var the_select = window.document.thisForm.selResellerID;
		for (loop=0; loop < the_select.options.length; loop++)
		{
			if (the_select.options[loop].selected == true)
			{
				 reseller_list += the_select.options[loop].text + ", ";
			}
		}
		//alert("you selected: " + options_string);
		reseller_list = reseller_list.substr(0, (reseller_list.length-2))
		if (reseller_list == "") {
			reseller_list = "All Resellers";
		}
		//alert("you selected: " + options_string);
		document.write(reseller_list);
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
			Dim oConn, oCmd, oRs
			
			If bSubmitted <> "" Then
				SelectedStartDate = Request("txtStartDate")
				SelectedEndDate = Request("txtEndDate")
			else
				SelectedStartDate = getToday()' returns "Now" in yyyy-mm-dd
				SelectedEndDate = getToday()' returns "Now" in yyyy-mm-dd
			End If 
			
			Dim csvResellerID
			csvResellerID = Request("csvResellerID") : If IsEmpty(Request("csvResellerID")) then csvResellerID = ""
			'Response.Write("csvResellerID=" & csvResellerID & "<br>")
			Dim txtGroupBy, bolGroupByReseller
			txtGroupBy = Request("txtGroupBy") : If IsEmpty(Request("txtGroupBy")) then txtGroupBy = ""
			' Group by reseller defaults to 0 
			' If txtGroupBy = reseller then set bolGroupByReseller to 1 and reset txtGroupBy to an empty string
			bolGroupByReseller = 0 
			If txtGroupBy = "reseller" then
				bolGroupByReseller = 1 
				txtGroupBy = ""
			End If
			bFilledOutProperly = TRUE
			
		%>
		<form name="thisForm" id="thisForm" method="post" action="">
		<h1>Custom Financial Reporting</h1><hr>
		<table border="0" cellpadding="5" cellspacing="3" width="" class="dgDataGrid">
			<tr class="dgAltItemRow">
				<td nowrap valign="top">
					<b>Start Date:</b><br>
					<input type="text" name="txtStartDate" class="" value="<%=SelectedStartDate%>" maxlength="10" style="width:80px;">
					<a class="" href="javascript:show_calendar('thisForm.txtStartDate')"><img src="images/calendar.gif" width="16" height="16" border="0" alt="Calendar" align=absmiddle></a><br>
					<b>End Date</b><br>
					<input type="text" name="txtEndDate" class="" value="<%=SelectedEndDate%>" maxlength="10" style="width:80px;">
					<a class="" href="javascript:show_calendar('thisForm.txtEndDate')"><img src="images/calendar.gif" width="16" height="16" border="0" alt="Calendar" align=absmiddle></a><br>
				</td>
				<td rowspan="2" nowrap valign="top">
					<b>Select Resellers:</b><br>
					<small>
						- Leave blank to select all resellers.<br>
						- Hold the CTRL key to select multiple.<br>
						<br>
					</small>
					<input type="hidden" name="csvResellerID" value="<%=csvResellerID%>">
					<select name="selResellerID" multiple size="13" style="width:180px;">
						<% Call WriteResellerList(csvResellerID) %>
					</select>
				</td>
			</tr>
			<tr class="dgAltItemRow">
				<td nowrap valign="top">
					<b>GroupBy:</b><br>
					<input type="radio" name="txtGroupBy" value="" <%=CheckChecked("",txtGroupBy)%>> None <br>
					<input type="radio" name="txtGroupBy" value="hour" <%=CheckChecked("hour",txtGroupBy)%>> Hour <br>
					<input type="radio" name="txtGroupBy" value="day" <%=CheckChecked("day",txtGroupBy)%>> Day of Month <br>
					<input type="radio" name="txtGroupBy" value="weekday" <%=CheckChecked("weekday",txtGroupBy)%>> Day of Week <br>
					<input type="radio" name="txtGroupBy" value="month" <%=CheckChecked("month",txtGroupBy)%>> Month <br>
					<input type="radio" name="txtGroupBy" value="year" <%=CheckChecked("year",txtGroupBy)%>> Year <br>
					<input type="radio" name="txtGroupBy" value="quarter" <%=CheckChecked("quarter",txtGroupBy)%>> Quarter <br>
					<input type="radio" name="txtGroupBy" value="reseller" <%=CheckChecked(1,bolGroupByReseller)%>> Reseller <br>
				</td>
			</tr>
			<tr class="dgAltItemRow">
				<td colspan="2" align="">
					<input type="hidden" name="txtSubmit" id="txtSubmit" value=1>
					<input type="button" border=0 onclick="javascript:getData();" value="Generate Report">
				</td>
			</tr>
		</table>	</form>
		<hr>
		<%
			If ((bFilledOutProperly) and (bSubmitted = 1)) Then
				'== Prepare the dates for the stored proc ===============
				StartDate = SelectedStartDate & " 00:00:00"		
				EndDate = SelectedEndDate & " 23:59:59"		
				'Response.Write("StartDate=" & StartDate & "<br>")	
				'Response.Write("EndDate=" & EndDate & "<br>")	
		
				'== Get the data for the given timeframe
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
					.Parameters.Append .CreateParameter("@csvResellerID",200,1,8000,csvResellerID)' contains a comma delimited string of reseller id's
					.Parameters.Append .CreateParameter("@GroupByDatePart",200,1,20,txtGroupBy) ' contains sql datepart identifiers (month,day,year,etc.)
					.Parameters.Append .CreateParameter("@bolGroupByReseller",3, 1, ,bolGroupByReseller)
				End With
			
				oConn.Open strDBaseConnString
				oCmd.ActiveConnection = oConn
				oRs.CursorLocation = 3
				oRs.Open oCmd, , 0, 1
				If oConn.Errors.Count < 1 then
					Dim intSales, intDisc, intCommis, intDiscSales, intItemsSold, intPDIP, intSELL, intCOMM, intTEAM, intLEAD, intTIME, intDRMA
					intSales = 0 : intDisc = 0 : intCommis = 0 : intDiscSales = 0 : intItemsSold = 0 : intPDIP = 0 : intSELL = 0 : intCOMM = 0 : intTEAM = 0 : intLEAD = 0 : intTIME = 0 : intDRMA = 0
					Response.Write("<b>Date Range:</b> From " & StartDate & " To " & EndDate & "<br>")
					Response.Write("<b>Resellers:</b> <script language=""JavaScript"">writeResellerIDList();</script><br>")
					Response.Write("<b>Grouped By:</b> " & txtGroupBy & "<br><br>")
					Response.Write ("<TABLE BORDER=""0"" CELLPADDING=""0"" CELLSPACING=""2"" CLASS=""dgDataGrid"">" & VbCrLf)
					'== Write the Header Row ===================
					Response.Write ("	<TR CLASS=""dgHeaderRow"">" & VbCrLf)
					If bolGroupByReseller = 1 Then
						Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">Reseller</TD>" & VbCrLf)
					End If
					If Not txtGroupBy = "" Then
						Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">" & txtGroupBy & "</TD>" & VbCrLf)
					End If
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
					Response.Write ("	</TR>" & VbCrLf)
					'== Write the Table Rows =================
					oRs.MoveFirst
					Dim bAltItem : bAltItem = False
					Do While Not oRs.EOF
						If bAltItem then
							Response.Write ("<TR CLASS=""dgAltItemRow"" onmouseover=""this.className='dgItemRowHover'"" onmouseout=""this.className='dgAltItemRow'"">" & VbCrLf) : bAltItem = NOT bAltItem
						Else
							Response.Write ("<TR CLASS=""dgItemRow"" onmouseover=""this.className='dgItemRowHover'"" onmouseout=""this.className='dgItemRow'"">" & VbCrLf) : bAltItem = NOT bAltItem
						End If
						'== Write the table cells ================
						If bolGroupByReseller = 1 Then
							Response.Write ("		<TD CLASS=""dgItemCell"" align=""left"" nowrap>" & oRs("Reseller") & "</TD>" & VbCrLf)
						End If
						If Not txtGroupBy = "" Then
							Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"" nowrap>" & FmtGetDatePart(oRs("SalesDate"),txtGroupBy) & "</TD>" & VbCrLf)
						End If
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FormatCurrency(oRs("TotalAmount"),2) & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FormatCurrency(oRs("TotalDiscount"),2) & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FormatCurrency(oRs("TotalCommission"),2) & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & FormatCurrency(oRs("DiscountedTotal"),2) & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("NoTestsPurchased") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("PDIP") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("SELL") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("COMM") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("TEAM") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("LEAD") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("TIME") & "</TD>" & VbCrLf)
						Response.Write ("		<TD CLASS=""dgItemCell"" align=""center"">" & oRs("DRMA") & "</TD>" & VbCrLf)
						Response.Write ("	</TR>" & VbCrLf)
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
					If (bolGroupByReseller = 1) or Not (txtGroupBy = "") Then
						Response.Write ("		<TD CLASS=""dgHeaderCell"" Width=""10%"">Totals</TD>")
					End If
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
			End If ' Closes ==> If bFilledOutProperly Then
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
	sub WriteResellerList(csvResellerID)
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
		With oCmd
			.CommandText = "spResellerGetAll"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		End With
		oConn.Open strDBaseConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
		If oConn.Errors.Count < 1 then
			Do While Not oRs.EOF
				Response.Write("<option value=""" & oRs("ResellerID") & """" & CheckSelectedCSV(oRs("ResellerID"),csvResellerID) & ">" & oRs("ResellerName") & "</option>")
				oRS.MoveNext
			Loop
		End If
	end sub
%>