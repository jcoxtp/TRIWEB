<%@ Language=VBScript %>
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
	'*****************************************************************************************
	'*
	'* Generated By: TierBuilder V3.2 - www.tierbuilder.com
	'* Created By: David Brackin
	'* Creation Date: Saturday, March 09, 2002  17:12:11
	'* Copyright (c) 2002 Team Resources, Inc.
	'*
	'* ----  Code Settings ----
	'*
	'* Returns Recordset: YES
	'* Purpose: This ASP page calls the stored procedure sel_v_Reseller_Commissions_RID using ADO.
	'**********************************************************************************************************************************
	
	
	on error resume next
	
	
	Dim bSubmitted
	
	bSubmitted = Request.Form ("txtSubmit")
	
	
	Dim bFilledOutProperly, strErrMsg
	
	Dim ResellerID
	Dim BeginDate
	Dim EndDate
	
	
	
	
	bFilledOutProperly = FALSE
	
	If bSubmitted <> "" Then
	
	
		  ResellerID = Request.Form("txtResellerID")
	
		  BeginDate = Request.Form("txtBeginDate")
	
		  EndDate = Request.Form("txtEndDate")
	
	else
		ResellerID = Request.QueryString("RID")
		
		BeginDate = CStr(month(now())) + "/1/" + CStr(year(Now())) 
		EndDate = CStr(month(now())) + "/" + Cstr(day(now())) + "/" + CStr(year(Now())) 
	
	
	End If
	
	ResellerID = Trim(ResellerID)
	BeginDate = Trim(BeginDate)
	EndDate = Trim(EndDate)
	
	
	If bSubmitted <> "" Then
	
		  If ResellerID = "" then 
	
				 strErrMsg = " Please enter a value for - ResellerID"
	
		  ElseIf BeginDate = "" then 
	
				 strErrMsg = " Please enter a value for - Begin Date"
	
		  ElseIf EndDate = "" then 
		  
			  EndDate = BeginDate
	
		  
		 ElseIf IsDate(BeginDate) = FALSE then 
	
				 strErrMsg = " Please enter a valid Begin Date"
	
		  ElseIf IsDate(EndDate) = FALSE then 
	
				 strErrMsg = " Please enter a valid End Date"
				 
		  Else
	
				 bFilledOutProperly = TRUE
	
		  End If
	
	End If%>
	
	
	<html>
	
	<head>
	
	<title></title>
	
	</head>
	
	<body>
	
	
	<form name="thisForm" id="thisForm" method="post" action="resellercommissions.asp">
	<br><br>
	<STRONG>Reseller Commission Report</STRONG>
	
	<br><br>
	
	<table>
	
	<tr>
	<td>
	
	
	</td>
	<td>
	
	<input type="hidden" name="txtResellerID" id="txtResellerID" Value="<%=ResellerID%>" >
	
	</td>
	</tr><tr>
	<td>
	
	Begin Date
	
	</td>
	<td>
	
	<input type="text" name="txtBeginDate" id="txtBeginDate" Value="<%=BeginDate%>" >
	
	</td>
	</tr><tr>
	<td>
	
	End Date
	
	</td>
	<td>
	
	<input type="text" name="txtEndDate" id="txtEndDate" Value="<%=EndDate%>" >
	
	</td>
	</tr></table><br>
	
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
	
			  .CommandText = "sel_v_Reseller_Commissions_RID"
			  .CommandType = 4
	
	
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			  .Parameters.Append .CreateParameter("@ResellerID",3, 1,4, ResellerID)
	
			  .Parameters.Append .CreateParameter("@BeginDate",135, 1,16, BeginDate)
	
			  .Parameters.Append .CreateParameter("@EndDate",135, 1,16, EndDate)
	
		End With
	
		oConn.Open strDbConnString
	
		oCmd.ActiveConnection = oConn
	
		oRs.CursorLocation = 3
	
		oRs.Open oCmd, , 0, 1
	
		If oConn.Errors.Count < 1 then
	
			
			Response.Write "No. Of Records: " & oRs.RecordCount
			Response.Write "<BR><BR>"
	
			Dim TotalPurchaseAmount
			Dim TotalTestsPurchased
			Dim TotalResellerCommission
			
			TotalPurchaseAmount = 0 
			TotalTestsPurchased = 0 
			TotalResellerCommission = 0
			
			If oRs.EOF = FALSE then
	
				oRs.MoveFirst
	
				Response.Write "<TABLE BORDER=1>"
	
				Response.Write "<TR>"
	
				Response.Write "<TD><font size=2><STRONG>Consumer Company Name</STRONG>"
				Response.Write "</TD>"
	
				Response.Write "<TD><font size=2><STRONG>Consumer Name</STRONG>"
				Response.Write "</TD>"
	
				Response.Write "<TD><font size=2><STRONG>Purchase Date</STRONG>"
				Response.Write "</TD>"
	
				Response.Write "<TD><font size=2><STRONG>Purchase Amount</STRONG>"
				Response.Write "</TD>"
	
				Response.Write "<TD><font size=2><STRONG>No. Tests Purchased</STRONG>"
				Response.Write "</TD>"
	
				Response.Write "<TD><font size=2><STRONG>Price per Test</STRONG>"
				Response.Write "</TD>"
	
				Response.Write "<TD><font size=2><STRONG>Reseller Commission</STRONG>"
				Response.Write "</TD>"
	
				Response.Write "<TD><font size=2><STRONG>Reseller Commission Percent</STRONG>"
				Response.Write "</TD>"
				
				Response.Write "</TR>"
	
				do while oRs.EOF = FALSE
	
					Response.Write "<TR>"
	
					Response.Write "<TD><font size=2><a href='editcompany.asp?CID=" & oRs("ConsumerCompanyID") & "'>" & oRs("ConsumerCompanyName") & "</a>"
					Response.Write "</TD>"
	
					Response.Write "<TD><font size=2><a href='edituser_int.asp?UID=" & oRs("PurchaserID") & "'>" & oRs("ConsumerLastName") & ", " & oRs("ConsumerFirstName") & "</a>"
					Response.Write "</TD>"
	
					Response.Write "<TD><font size=2>" & oRs("T_Month") & "/" & oRs("T_Day") & "/" & oRs("T_Year")
					Response.Write "</TD>"
	
					Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatCurrency(oRs("TotalAmount"),2)
					Response.Write "</TD>"
					TotalPurchaseAmount = TotalPurchaseAmount + oRs("TotalAmount")
	
					Response.Write "<TD ALIGN=RIGHT><font size=2>" & oRs("NoTestsPurchased")
					Response.Write "</TD>"
					TotalTestsPurchased = TotalTestsPurchased + oRs("NoTestsPurchased")
					
					Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatCurrency(oRs("TotalAmount") / oRs("NoTestsPurchased"),2)
					Response.Write "</TD>"
	
					Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatCurrency(oRs("ResellerCommission"),2)
					Response.Write "</TD>"
					TotalResellerCommission = TotalResellerCommission + oRs("ResellerCommission")
	
					Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatPercent(oRs("ResellerCommission")/oRs("TotalAmount"),2)
					Response.Write "</TD>"
	
					Response.Write "</TR>"
	
					oRs.MoveNext
	
				Loop
				
				
				
				Response.Write "<TR>"
	
				Response.Write "<TD><font size=2><STRONG>Totals</STRONG>"
				Response.Write "</TD>"
	
				Response.Write "<TD><font size=2>&nbsp;"
				Response.Write "</TD>"
	
				Response.Write "<TD><font size=2>&nbsp;"
				Response.Write "</TD>"
	
				Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatCurrency(TotalPurchaseAmount,2)
				Response.Write "</TD>"
	
				Response.Write "<TD ALIGN=RIGHT><font size=2>" & TotalTestsPurchased
				Response.Write "</TD>"
	
				Response.Write "<TD><font size=2>&nbsp;"
				Response.Write "</TD>"
	
				Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatCurrency(TotalResellerCommission,2)
				Response.Write "</TD>"
	
				Response.Write "<TD ALIGN=RIGHT><font size=2>" & FormatPercent(TotalResellerCommission/TotalPurchaseAmount,2)
				Response.Write "</TD>"
				
				Response.Write "</TR>"
				
	
				Response.Write "</TABLE>"
	
			End If
	
			Response.End
	
		else
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
