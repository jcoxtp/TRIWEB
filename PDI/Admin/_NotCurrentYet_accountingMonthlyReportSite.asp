<%@ Language=VBScript %>
<!--#Include FILE="Include/CheckAdminLogin.asp" -->
<!--#Include FILE="../Include/common.asp" -->
<% pageID = "home" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Home Page</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
	<!--#Include FILE="../Include/HeadStuff.asp" -->	
</head>
<body>
<!--#Include FILE="Include/header.asp" -->
<div class="TopNav">
	<a href="../main.asp?res=<%=intResellerID%>">PDI Home</a>&nbsp;|
	<a href="../logout.asp?res=<%=intResellerID%>">Logout</a>&nbsp;
</div>
<div id="maincontent">
	<%
	'********************************************************************************************
	'*
	'* Created By: John Tisdale
	'* Creation Date: Thursday, October 7, 2002
	'* Copyright (c) 2003 VoyageSoft, Inc.
	'*
	'* ----  Code Settings ----
	'*
	'* Returns Recordset: YES
	'* Purpose: This ASP page calls the stored procedure sel_Purchase_Daily_Summary_Day using ADO.
	'*********************************************************************************************
	
	on error resume next
	
	Dim bSubmitted
	bSubmitted = Request.Form ("txtSubmit")
	Dim bFilledOutProperly, strErrMsg
	Dim Date2
	bFilledOutProperly = FALSE
	If bSubmitted <> "" Then
		SelectedYear = CInt(Request.Form("intYear"))
		SelectedMonth = CInt(Request.Form("intMonth"))
	else
		SelectedMonth = CInt(month(Now()))
		SelectedYear = CInt(year(Now()))
	End If
	Dim SiteID
	SiteID = Request.Form ("txtSiteID")
	bFilledOutProperly = TRUE
	%>
	<html>
	<head>
		<title></title>
	</head>
	<body>
	<form name="thisForm" id="thisForm" method="post" action="accountingMonthlyReportSite.asp">
	<STRONG>Site Monthly Sales Report</STRONG>
	<br><br>
	Enter date to display accounting numbers.
	<table>
	<%
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRsResellers = CreateObject("ADODB.Recordset")
		With oCmd
			  .CommandText = "sel_Resellers"
			  .CommandType = 4
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		End With
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oRsResellers.CursorLocation = 3
		oRsResellers.Open oCmd, , 0, 1
		
		
		
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRsSites = CreateObject("ADODB.Recordset")
		With oCmd
			  .CommandText = "sel_Sites"
			  .CommandType = 4
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		End With
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oRsSites.CursorLocation = 3
		oRsSites.Open oCmd, , 0, 1
		If oConn.Errors.Count < 1 then
			Response.Write "<tr><td>Site</td>" & VbCrLf
			Response.Write "<td><select name='txtSiteID'>" & VbCrLf
			Response.Write VbTab & "<option value ='0'>Select a Site</option>" & VbCrLf
			Do While oRsSites.EOF = FALSE
				Response.Write "<option Value='" & oRsSites("SiteID") & "' "
				If CInt(oRsSites("SiteID")) = CInt(SiteID) Then
					Response.Write "selected"
				End If
				Response.Write ">" & oRsSites("SiteName") & "</option>" & VbCrLf
				oRsSites.MoveNext
			Loop
			Response.Write "</select></td>" & VbCrLf
			
			
			
			
			Response.Write "</tr>" & VbCrLf
		End If
	%>
		<tr>
			<td>Date</td>
			<td>
				<select name="intMonth" id="intMonth">
					<option value="1" <% If SelectedMonth=1 Then Response.Write " selected" End If %>>January
					<option value="2" <% If SelectedMonth=2 Then Response.Write " selected" End If %>>February
					<option value="3" <% If SelectedMonth=3 Then Response.Write " selected" End If %>>March
					<option value="4" <% If SelectedMonth=4 Then Response.Write " selected" End If %>>April
					<option value="5" <% If SelectedMonth=5 Then Response.Write " selected" End If %>>May
					<option value="6" <% If SelectedMonth=6 Then Response.Write " selected" End If %>>June
					<option value="7" <% If SelectedMonth=7 Then Response.Write " selected" End If %>>July
					<option value="8" <% If SelectedMonth=8 Then Response.Write " selected" End If %>>August
					<option value="9" <% If SelectedMonth=9 Then Response.Write " selected" End If %>>September
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
		</tr>
	</table>
	<br>
	<input type="hidden" name="txtSubmit" id="txtSubmit" value=1>
	<input type="submit" border=0 value="submit" id=add name=add>
	</form>
	<%
	If bSubmitted <> "" AND bFilledOutProperly Then
		Dim oConn
		Dim oCmd
		Dim oRs
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
		With oCmd
			  .CommandText = "sel_Accounting_Monthly_Site_Report"
			  .CommandType = 4
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				.Parameters.Append .CreateParameter("@SiteID",3, 1,4, CInt(SiteID))
			  .Parameters.Append .CreateParameter("@Month",3, 1, 4, CInt(SelectedMonth))
			  .Parameters.Append .CreateParameter("@Year",3, 1, 4, CInt(SelectedYear))
		End With
	
		Dim RunPDIQnty, RunPDIAmt, RunAppQnty, RunAppAmt, RunTtlQnt, RunTtlAmt, RunTtlDisc, RunTtlComm
		RunPDIQnty = 0
		RunPDIAmt = 0
		RunAppQnty = 0
		RunAppAmt = 0
		RunTtlQnt = 0
		RunTtlAmt = 0
		RunTtlDisc = 0
		RunTtlComm = 0
	
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
		If oConn.Errors.Count < 1 then
			Dim Field, nColumns
			Response.Write "<TABLE BORDER=1 CELLPADDING=0 CELLSPACING=0>"
			Response.Write "<TR>"
			Response.Write "	<TD VALIGN='TOP'><STRONG>Day</STRONG></TD>"
			Response.Write "	<TD VALIGN='TOP'><STRONG>PDI Qnty</STRONG></TD>"
			Response.Write "	<TD VALIGN='TOP'><STRONG>PDI Amount</STRONG></TD>"
			Response.Write "	<TD VALIGN='TOP'><STRONG>App Qnty</STRONG></TD>"
			Response.Write "	<TD VALIGN='TOP'><STRONG>App Amount</STRONG></TD>"
			Response.Write "	<TD VALIGN='TOP'><STRONG>Total Qnty</STRONG></TD>"
			Response.Write "	<TD VALIGN='TOP' WIDTH='80'><STRONG>Total Pre-Disc Amount</STRONG></TD>"
			Response.Write "	<TD VALIGN='TOP'><STRONG>Total Disc</STRONG></TD>"
			Response.Write "	<TD VALIGN='TOP'><STRONG>Total Comm</STRONG></TD>"
			Response.Write "	<TD VALIGN='TOP'><STRONG>Total Amount</STRONG></TD>"
	
			Dim altLoop
			Response.Write "</TR>"
			If oRs.EOF = FALSE then
				oRs.MoveFirst
				altLoop = 0
				do while oRs.EOF = FALSE
					If altLoop = 0 Then
						Response.Write "<TR bgcolor='#EEEEEE'>"
						altLoop = 1
					Else
						Response.Write "<TR bgcolor='#FFFFFF'>"
						altLoop = 0
					End If
					Response.Write "	<TD ALIGN=RIGHT><B><I>" & oRs("Day") & "</I></B></TD>"
					Response.Write "	<TD ALIGN=RIGHT><FONT color='#000080'>" & oRs("PDITotalQuantity") & "</FONT></TD>"
					Response.Write "	<TD ALIGN=RIGHT><FONT color='#000080'>" & FormatCurrency(oRs("PDITotalAmount"),2) & "</FONT></TD>"
					Response.Write "	<TD ALIGN=RIGHT><FONT color='#800080'>" & oRs("AppTotalQuantity") & "</FONT></TD>"
					Response.Write "	<TD ALIGN=RIGHT><FONT color='#800080'>" & FormatCurrency(oRs("AppTotalAmount"),2) & "</FONT></TD>"
					Response.Write "	<TD ALIGN=RIGHT>" & oRs("GrandTotalQuantity") & "</TD>"
					Response.Write "	<TD ALIGN=RIGHT><I>" & FormatCurrency(oRs("GrandTotalAmount"),2) & "</I></TD>"
					Response.Write "	<TD ALIGN=RIGHT><FONT color='#800000'>" & FormatCurrency(oRs("TotalDiscount"),2) & "</FONT></TD>"
					Response.Write "	<TD ALIGN=RIGHT><FONT color='#800000'>" & FormatCurrency(oRs("TotalCommission"),2) & "</FONT></TD>"
					Response.Write "	<TD ALIGN=RIGHT><B><I>" & FormatCurrency((oRs("GrandTotalAmount") - oRs("TotalDiscount")),2) & "</I></B></TD>"
					Response.Write "</TR>"
	
					RunPDIQnty = RunPDIQnty + oRs("PDITotalQuantity")
					RunPDIAmt = RunPDIAmt + oRs("PDITotalAmount")
					RunAppQnty = RunAppQnty + oRs("AppTotalQuantity")
					RunAppAmt = RunAppAmt + oRs("AppTotalAmount")
					RunTtlQnty = RunTtlQnty + oRs("GrandTotalQuantity")
					RunTtlAmt = RunTtlAmt + oRs("GrandTotalAmount")
	
					RunTtlDisc = RunTtlDisc + oRs("TotalDiscount")

					RunTtlComm = RunTtlComm + oRs("TotalCommission")
	
					oRs.MoveNext
				Loop
			End If
			Response.Write "<TR>"
			Response.Write "	<TD ALIGN=RIGHT><B>TOTALS</B></TD>"
			Response.Write "	<TD ALIGN=RIGHT><B>" & RunPDIQnty & "</B></TD>"
			Response.Write "	<TD ALIGN=RIGHT><B>" & FormatCurrency(RunPDIAmt,2) & "</B></TD>"
			Response.Write "	<TD ALIGN=RIGHT><B>" & RunAppQnty & "</B></TD>"
			Response.Write "	<TD ALIGN=RIGHT><B>" & FormatCurrency(RunAppAmt,2) & "</B></TD>"
			Response.Write "	<TD ALIGN=RIGHT><B>" & RunTtlQnty & "</B></TD>"
			Response.Write "	<TD ALIGN=RIGHT><B>" & FormatCurrency(RunTtlAmt,2) & "</B></TD>"
			Response.Write "	<TD ALIGN=RIGHT><B>" & FormatCurrency(RunTtlDisc,2) & "</B></TD>"
			Response.Write "	<TD ALIGN=RIGHT><B>" & FormatCurrency(RunTtlComm,2) & "</B></TD>"
			Response.Write "	<TD ALIGN=RIGHT><B>" & FormatCurrency((RunTtlAmt - RunTtlDisc),2) & "</B></TD>"
			Response.Write "</TR>"
			Response.Write "</TABLE>"
			Response.End
		Else
			  strErrMsg = Err.description
			  Err.Clear
		End If
	End If
	If strErrMsg <> "" Then
		  Response.Write "<br>"
		  Response.Write strErrMsg
		  Response.Write "<br><br>"
	End If %>
	</body>
	</html>
</div>
</body>
</html>
