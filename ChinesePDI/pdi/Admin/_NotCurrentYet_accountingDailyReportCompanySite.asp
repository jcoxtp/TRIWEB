<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/CheckAdminLogin.asp" -->
<!--#INCLUDE FILE="../include/common.asp" -->
<% pageID = "home"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>DISC Profile System | Home Page</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="../include/head_stuff.asp" -->	
</head>
<body>
<!--#INCLUDE FILE="include/header.asp" -->
<div class="TopNav">
	<a href="../main.asp?res=<%=intResellerID%>">PDI Home</a>&nbsp;|
	<a href="../logout.asp?res=<%=intResellerID%>">Logout</a>&nbsp;
</div>
<div id="maincontent">
	<%
	'*****************************************************************************************
	'* ----  Code Settings ----
	'* Returns Recordset: YES
	'* Purpose: This ASP page calls the stored procedure sel_Purchase_Daily_Summary_Co_Day using ADO.
	'**********************************************************************************************************************************

	on error resume next
	
	Dim bSubmitted
	bSubmitted = Request.Form ("txtSubmit")
	Dim bFilledOutProperly, strErrMsg
	Dim BeginDate
	Dim EndDate
	Dim CompanyName
	bFilledOutProperly = FALSE
	Dim SiteID
	SiteID = Request.Form ("txtSiteID")
	
	If bSubmitted <> "" Then
		  BeginDate = Request.Form("txtBeginDate")
		  EndDate = Request.Form("txtEndDate")
		  CompanyName = Request.Form("txtCompanyName")
	Else
		BeginDate = CStr(month(now())) + "/1/" + CStr(year(Now()))
		EndDate = CStr(month(now())) + "/" + Cstr(day(now())) + "/" + CStr(year(Now()))
	End If
	
	BeginDate = Trim(BeginDate)
	EndDate = Trim(EndDate)
	CompanyName = Trim(CompanyName)
	
	If bSubmitted <> "" Then
		  If BeginDate = "" Then
				 strErrMsg = " Please enter a value for - Begin Date"
		  ElseIf BeginDate <> "" and IsDate(BeginDate) = FALSE Then
				 strErrMsg = " Please enter a valid date for Begin Date."
		  ElseIf EndDate <> "" and IsDate(EndDate) = FALSE Then
				 strErrMsg = " Please enter a valid date for End Date."
		'ElseIf CompanyName = "" then
				 'strErrMsg = " Please enter a value for - CompanyName"
		  Else
				 bFilledOutProperly = TRUE
		  End If
		  If EndDate = "" and bFilledOutProperly = true Then
				 EndDate = BeginDate
		  'else
			' add on the end minutes so if they are searching by date range
			' it will include everything in the end date
			'EndDate = EndDate 
		End if
	End If
	
	Dim oConn
	Dim oCmd
	Dim oRs
	%>
	
	<html>
	<head>
		<title></title>
	</head>
	<body>
	
	<form name="thisForm" id="thisForm" method="post" action="accountingDailyReportCompanySite.asp">
		<br><br>
		<STRONG>Accounting Report by Company - Search by Date and Company Name</STRONG>
		<br><br>
		Leave company name blank to return all companies.
		<br>
		<table>
	<%
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRsSites = CreateObject("ADODB.Recordset")
		With oCmd
			  .CommandText = "sel_Sites"
			  .CommandType = 4
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		End With
		oConn.Open strDBaseConnString
		oCmd.ActiveConnection = oConn
		oRsSites.CursorLocation = 3
		oRsSites.Open oCmd, , 0, 1
		If oConn.Errors.Count < 1 then
			Response.Write "<tr><td>Site</td>"
			Response.Write "<td><select name='txtSiteID'>"
			Do While oRsSites.EOF = FALSE
				Response.Write "<option Value='" & oRsSites("SiteID") & "' "
				If CInt(oRsSites("SiteID")) = CInt(SiteID) Then
					Response.Write "selected"
				End If
				Response.Write ">" & oRsSites("SiteName") & "</option>"
				oRsSites.MoveNext
			Loop
			Response.Write "</select></td></tr>"
		End If
	%>
			<tr>
				<td>BeginDate</td>
				<td><input type="text" name="txtBeginDate" id="txtBeginDate" Value="<%=BeginDate%>" ></td>
			</tr>
			<tr>
				<td>EndDate</td>
				<td><input type="text" name="txtEndDate" id="txtEndDate" Value="<%=EndDate%>" ></td>
			</tr>
			<tr>
				<td>CompanyName</td>
				<td><input type="text" name="txtCompanyName" id="txtCompanyName" MaxLength=100 Value="<%=CompanyName%>" ></td>
			</tr>
		</table>
		<br>
		<input type="hidden" name="txtSubmit" id="txtSubmit" value=1>
		<input type="submit" border=0 value="submit" id=add name=add>
	</form>
	<%
	Dim TotalPurchases, TotalDiscounts, TotalCommissions
	
	TotalPurchases = 0
	TotalDiscounts = 0
	TotalCommissions = 0
	
	If bSubmitted <> "" AND bFilledOutProperly Then
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
		With oCmd
			  .CommandText = "sel_DM_Purchase_Daily_Summary_Co_Site_Day"
			  .CommandType = 4
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
							 .Parameters.Append .CreateParameter("@BeginDate",135, 1,16, BeginDate)
							 .Parameters.Append .CreateParameter("@EndDate",135, 1,16, EndDate)
							 .Parameters.Append .CreateParameter("@CompanyName",200, 1,100, CompanyName)
							 .Parameters.Append .CreateParameter("@SiteID",3, 1,4, SiteID)
		End With
		oConn.Open strDBaseConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
	
		If oConn.Errors.Count < 1 then
			Response.Write "No. Of Records: " & oRs.RecordCount
			Response.Write "<BR><BR>"
			Dim CompanyName2
			If oRs.EOF = FALSE then
				oRs.MoveFirst
				Response.Write "<TABLE BORDER=1>"
				Response.Write "<TR>"
				Response.Write "	<TD><font size=2><STRONG>Company Name</STRONG></TD>"
				Response.Write "	<TD><font size=2><STRONG>Company Type</STRONG></TD>"
				Response.Write "	<TD><font size=2><STRONG>Date</STRONG></TD>"
				Response.Write "	<TD><font size=2><STRONG>Total Purchases</STRONG></TD>"
				Response.Write "	<TD><font size=2><STRONG>Total Discounts</STRONG></TD>"
				Response.Write "	<TD><font size=2><STRONG>Discount Percent</STRONG></TD>"
				Response.Write "	<TD><font size=2><STRONG>Total Commissions</STRONG></TD>"
				Response.Write "	<TD><font size=2><STRONG>Commission Percent</STRONG></TD>"
				Response.Write "	<TD><font size=2><STRONG>Reseller Name</STRONG></TD>"
				Response.Write "	<TD><font size=2><STRONG>Reseller Commission</STRONG></TD>"
				Response.Write "	<TD><font size=2><STRONG>Reseller Commission Percent</STRONG></TD>"
				Response.Write "</TR>"
	
				Set oConn = Nothing
				Set oCmd = Nothing
				Dim oCoTypes
				Set oConn = CreateObject("ADODB.Connection")
				Set oCmd = CreateObject("ADODB.Command")
				Set oCoTypes = CreateObject("ADODB.Recordset")
				With oCmd
					  .CommandText = "sel_CompanyType_all"
					  .CommandType = 4
					  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				End With
				oConn.Open strDBaseConnString
				oCmd.ActiveConnection = oConn
				oCoTypes.CursorLocation = 3
				oCoTypes.Open oCmd, , 0, 1
	
				Dim TotalResellerCommission
				TotalResellerCommission = 0 
				do while oRs.EOF = FALSE
					Response.Write "<TR>"
					Response.Write "<TD><font size=2><A HREF='editcompany.asp?CID=" & oRs("CompanyID") & "'>" &  oRs("CompanyName")  & "</a></TD>"
					Response.Write "<TD><FONT Size=2>"
					oCoTypes.MoveFirst
					while oCoTypes.EOF = FALSE
						if oCoTypes("CompanyTypeID") = oRs("CompanyTypeID") then
							Response.Write oCoTypes("CompanyType")
						end if
						oCoTypes.MoveNext
					wend
					oCoTypes.MoveFirst
					Response.Write "</TD>"
					Response.Write "<TD><font size=2>" & CStr(Month(oRs("T_Date"))) & "/" & CStr(Day(oRs("T_Date"))) & "/" & CStr(Year(oRs("T_Date"))) & "</TD>"
					Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatCurrency(oRs("TotalPurchases"),2) & "</TD>"
					Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatCurrency(oRs("TotalDiscounts"),2) & "</TD>"
					Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatPercent(oRs("TotalDiscounts")/oRs("TotalPurchases"),2) & "</TD>"
					Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatCurrency(oRs("TotalCommissions"),2) & "</TD>"
					Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatPercent(oRs("TotalCommissions")/oRs("TotalPurchases"),2) & "</TD>"
					If IsNULL(oRs("ResellerID")) = FALSE then
						Set oConn = Nothing
						Set oCmd = Nothing
						Set oConn = CreateObject("ADODB.Connection")
						Set oCmd = CreateObject("ADODB.Command")
						With oCmd
							  .CommandText = "sel_Company_output"
							  .CommandType = 4
							  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
								  .Parameters.Append .CreateParameter("@CompanyID",3, 1,4, oRs("ResellerID"))
							  .Parameters.Append .CreateParameter("@CompanyName",200, 3,100, CStr(CompanyName2))
						End With
						oConn.Open strDBaseConnString
						oCmd.ActiveConnection = oConn
						oCmd.Execute , , 128
						CompanyName2 = oCmd.Parameters("@CompanyName").value
	
						Response.Write "<TD><font size=2><a href='editcompany.asp?CID=" & oRs("ResellerID") & "'>" & CompanyName2 & "</a>"
						Response.Write "</TD>"
						Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatCurrency(oRs("ResellerCommission"),2)
						Response.Write "</TD>"
						TotalResellerCommission = TotalResellerCommission + oRs("ResellerCommission")
						Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatPercent(oRs("ResellerCommission") / oRs("TotalPurchases"),2)
						Response.Write "</TD>"
					Else
						Response.Write "<TD>&nbsp;</TD>"
						Response.Write "<TD>&nbsp;</TD>"
						Response.Write "<TD>&nbsp;</TD>"
					End If
					Response.Write "</TR>"
					TotalPurchases = TotalPurchases + oRs("TotalPurchases")
					TotalDiscounts = TotalDiscounts + oRs("TotalDiscounts")
					TotalCommissions = TotalCommissions + oRs("TotalCommissions")
					oRs.MoveNext
				Loop
				Response.Write "<TR>"
				Response.Write "<TD><font size=2>Totals</TD>"
				Response.Write "<TD COLSPAN=2>&nbsp;</TD>"
				Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatCurrency(TotalPurchases,2) & "</TD>"
				Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatCurrency(TotalDiscounts,2) & "</TD>"
				Response.Write "<TD>&nbsp;</TD>"
				Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatCurrency(TotalCommissions,2) & "</TD>"
				Response.Write "<TD>&nbsp;</TD>"
				Response.Write "<TD>&nbsp;</TD>"
				Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatCurrency(TotalResellerCommission,2) & "</TD>"
				Response.Write "<TD>&nbsp;</TD>"
				Response.Write "</TR>"
				Response.Write "</TABLE>"
			End If
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
