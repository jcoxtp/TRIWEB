<%@ Language=VBScript %>
<% intPageID = 63 %>
<!--#Include FILE="Include/checklogin.asp" -->
<!--#Include FILE="Include/common.asp" -->
<% pageID = "home" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Home Page</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
	<!--#Include FILE="Include/HeadStuff.asp" -->	
</head>
<body>
<!--#Include FILE="Include/TopBanner.asp" -->

<div id="maincontent">
	<%
	'**********************************************************************************************************************************
	'* Purpose: This ASP page calls the stored procedure sel_PricePlan using ADO.
	'**********************************************************************************************************************************
	Dim PricePlanName
	Dim PricePlanID
	PricePlanID = Request.QueryString("PPres")
	
	Dim oConn, oCmd, oRs
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	With oCmd
		  .CommandText = "sel_PricePlan"
		  .CommandType = 4
		  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		  .Parameters.Append .CreateParameter("@PricePlanID",3, 1,4, PricePlanID)
	End With
	
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	
	If oConn.Errors.Count < 1 then
		Response.Write "<BR><BR><STRONG>Pricing Plan</STRONG><BR><BR>"
		Dim Field, nColumns
		If oRs.EOF = FALSE then
			oRs.MoveFirst
			Response.Write "<TABLE BORDER=1>"
			Response.Write "<TR>"
			Response.Write "<TD>Price Plan Name" 
			Response.Write "</TD>"
			Response.Write "<TD>Description"
			Response.Write "</TD>"
			Response.Write "<TD>Receives Discount"
			Response.Write "</TD>"
			Response.Write "<TD>Receives Commission"
			Response.Write "</TD>"
			Response.Write "<TD>Active"
			Response.Write "</TD>"
			Response.Write "</TR>"
			do while oRs.EOF = FALSE
				Response.Write "<TR>"
				Response.Write "<TD>" & oRs("PricePlanName") 
				Response.Write "</TD>"
				PricePlanName = oRs("PricePlanName") 
				Response.Write "<TD>" & oRs("Description")
				Response.Write "</TD>"
				Response.Write "<TD>" 
				if oRs("ReceivesDiscount") = 1 then
					Response.Write "YES"
				else
					Response.Write "NO"
				end if
				Response.Write "</TD>"
				Response.Write "<TD>" 
				if oRs("ReceivesCommission") = 1 then
					Response.Write "YES"
				else
					Response.Write "NO"
				end if
				Response.Write "</TD>"
				Response.Write "<TD>" 
				if oRs("Active") = 1 then
					Response.Write "YES"
				else
					Response.Write "NO"
				end if
				Response.Write "</TD>"
				Response.Write "</TR>"
				oRs.MoveNext
			Loop
			Response.Write "</TABLE>"
			End If
		else
			Response.Write "<BR><BR>Transaction Failed<BR><BR>"
			Response.Write Err.description
			Err.Clear
		End If
	End If
	%>
	<br><br>
	<STRONG>Price Plan Details</STRONG>
	<br><br>
	<STRONG>Custom Test Pricing</STRONG>
	<br><br>
	<%
	Set oConn = Nothing
	Set oCmd = Nothing
	
	Dim oTestRS 
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oTestRS = CreateObject("ADODB.Recordset")
	With oCmd
		  .CommandText = "sel_TRTest_All"
		  .CommandType = 4
		  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		  .Parameters.Append .CreateParameter("@userID", 3, 1,4, Request.cookies("UserID"))
	End With
	
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oTestRS.CursorLocation = 3
	oTestRS.Open oCmd, , 0, 1

	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRs = Nothing
	
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")

	With oCmd
		  .CommandText = "sel_PricePlan_TRTest_PricePlanID"
		  .CommandType = 4
		  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		  .Parameters.Append .CreateParameter("@PricePlanId",3, 1,4, PricePlanId)
	End With
	
	Dim bFoundCustom
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	
	If oConn.Errors.Count < 1 then
		If oTestRS.EOF = FALSE then
			oTestRS.MoveFirst
			Response.Write "<TABLE BORDER=1>"
			Response.Write "<TR>"
			Response.Write "<TD>Test Name"
			Response.Write "</TD>"
			Response.Write "<TD>Test Price"
			Response.Write "</TD>"
			Response.Write "<TD>Custom Price"
			Response.Write "</TD>"
			Response.Write "<TD>Custom Price Creation Date"
			Response.Write "</TD>"
			Response.Write "<TD>Edit Custom Test Price"
			Response.Write "</TD>"
			Response.Write "<TD>Remove Custom Test Price"
			Response.Write "</TD>"
			Response.Write "</TR>"
					
			while oTestRS.EOF = FALSE
				Response.Write "<TR>"
				Response.Write "<TD>" & oTestRS("TestName")
				Response.Write "</TD>"
				Response.Write "<TD ALIGN=RIGHT>" & FormatCurrency(oTestRS("BaseTestPrice"),2)
				Response.Write "</TD>"
				bFoundCustom = FALSE 
				if oRs.EOF = FALSE then
					oRs.MoveFirst
					while oRs.EOF = FALSE
						if oTestRS("TRTestID") = oRs("TRTestID") then
							bFoundCustom = TRUE 
							Response.Write "<TD ALIGN=RIGHT>" & FormatCurrency(oRs("CustomPrice"),2)
							Response.Write "</TD>"
							Response.Write "<TD>" & oRs("CustomCreationDate")
							Response.Write "</TD>"
						end if 
						oRs.MoveNext
					wend
					oRS.MoveFirst
					IF bFoundCustom = FALSE then
						Response.Write "<TD>NA"
						Response.Write "</TD>"
						Response.Write "<TD>NA"
						Response.Write "</TD>"
	
					End If 
				else
					Response.Write "<TD>NA"
					Response.Write "</TD>"
					Response.Write "<TD>NA"
					Response.Write "</TD>"
				end if
				Response.Write "<TD><a href='editcustomtestprice.asp?TN=" & Server.URLEncode(oTestRS("TestName")) & "&PPN=" & Server.URLEncode(PricePlanName) & "&PPID=" & PricePlanID & "&TID=" & oTestRS("TRTestID") & "'>Edit</a>"
				Response.Write "</TD>"
				if oRs.EOF = FALSE then
					Response.Write "<TD><a href='delcustomtestprice.asp?TN=" & Server.URLEncode(oTestRS("TestName")) & "&PPN=" & Server.URLEncode(PricePlanName) & "&PPID=" & PricePlanID & "&TID=" & oTestRS("TRTestID") & "'>Remove</a>"
					Response.Write "</TD>"
				else
					Response.Write "<TD>&nbsp;"
					Response.Write "</TD>"
				end if
				Response.Write "</TR>"
				oTestRS.MoveNext
			wend
			Response.Write "</TABLE>"
		End If
	Else
		Response.Write Err.description
		Err.Clear
	End If

	%>
	<br><br>
	<STRONG>Volume Grid</STRONG>
	<br><br>
	<a href='addpriceplandetail.asp?PPID=<%=PricePlanID%>'>Add Detail Pricing Record</a>
	<br>
	<%
	
	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRs = Nothing
	
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	
	With oCmd
	
		  .CommandText = "sel_PricePlanDetail_priceplanid"
		  .CommandType = 4
		  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		  .Parameters.Append .CreateParameter("@PricePlanId",3, 1,4, PricePlanId)
	End With

	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	
	If oConn.Errors.Count < 1 then
		Response.Write "<BR>"
		Response.Write "No. of Price Plan Detail Records: " & oRs.RecordCount 
		Response.Write "<BR><BR>"
		If oRs.EOF = FALSE then
			oRs.MoveFirst
			Response.Write "<TABLE BORDER=1>"
			Response.Write "<TR>"
			Response.Write "<TD>Min Volume Amt"
			Response.Write "</TD>"
			Response.Write "<TD>Max Volume Amt"
			Response.Write "</TD>"
			Response.Write "<TD>Discount Percent"
			Response.Write "</TD>"
			Response.Write "<TD>Commission Percent"
			Response.Write "</TD>"
			Response.Write "<TD>Edit"
			Response.Write "</TD>"
			Response.Write "<TD>Delete"
			Response.Write "</TD>"
			Response.Write "</TR>"
			do while oRs.EOF = FALSE
				Response.Write "<TR>"
				Response.Write "<TD>"
				Response.Write FormatNumber(oRs("MinVolumeAmt"),2)
				Response.Write "</TD>"
				Response.Write "<TD>"
				Response.Write FormatNumber(oRs("MaxVolumeAmt"),2)
				Response.Write "</TD>"
				Response.Write "<TD>"
				Response.Write FormatPercent(oRs("DiscountPercent"),2)
				Response.Write "</TD>"
				Response.Write "<TD>"
				Response.Write FormatPercent(oRs("CommissionPercent"),2)
				Response.Write "</TD>"
				Response.Write "<TD>"
				Response.Write "<a href='editpriceplandetail.asp?PPDID=" & oRs("PricePlanDetailID") & "'>Edit</a>"
				Response.Write "</TD>"
				Response.Write "<TD>"
				Response.Write "<a href='delpriceplandetail.asp?PPDID=" & oRs("PricePlanDetailID") & "&PPID=" & PricePlanID & "'>Delete</a>"
				Response.Write "</TD>"
				Response.Write "</TR>"
				oRs.MoveNext
			Loop
			Response.Write "</TABLE>"
		End If
	Else
		Response.Write Err.description
		Err.Clear
	End If
	%>
</div>
</body>
</html>
