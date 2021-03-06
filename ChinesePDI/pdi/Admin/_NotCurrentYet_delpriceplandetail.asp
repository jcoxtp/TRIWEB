<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/checklogin.asp" -->
<!--#INCLUDE FILE="include/common.asp" -->
<% pageID = "home" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Home Page</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->	
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
<div id="maincontent">
	<%
	'*****************************************************************************************
	'*
	'* Generated By: TierBuilder V3.2 - www.tierbuilder.com
	'* Created By: David Brackin
	'* Creation Date: Wednesday, January 16, 2002  21:18:26
	'* Copyright (c) 2002 VoyageSoft, Inc.
	'*
	'* ----  Code Settings ----
	'*
	'* Returns Recordset: NO
	'* Purpose: This ASP page calls the stored procedure del_PricePlanDetail using ADO.
	'**********************************************************************************************************************************
	
	on error resume next
	
	Dim bSubmitted
	
	bSubmitted = Request.Form ("txtSubmit")
	
	Dim bFilledOutProperly, strErrMsg
	
	Dim PricePlanDetailID
	Dim ModifiedBy
	Dim PricePlanID
	
	bFilledOutProperly = FALSE
	
	If bSubmitted <> "" Then
	
		  PricePlanDetailID = Request.Form("txtPricePlanDetailID")
	
		  ModifiedBy = Request.Form("txtModifiedBy")
	
		 PricePlanID = Request.Form("txtPricePlanID")
	
	Else
	
		ModifiedBy = Request.Cookies("UserID")
		PricePlanDetailID = Request.QueryString("PPDID")
		PricePlanID = Request.QueryString("PPID")
		
	End If
	
	PricePlanDetailID = Trim(PricePlanDetailID)
	ModifiedBy = Trim(ModifiedBy)
	
	
	If bSubmitted <> "" Then
	
		  If PricePlanDetailID = "" then 
	
				 strErrMsg = " Please enter a value for - PricePlanDetailID"
	
		  ElseIf ModifiedBy = "" then 
	
				 strErrMsg = " Please enter a value for - ModifiedBy"
	
		  Else
	
				 bFilledOutProperly = TRUE
	
		  End If
	
	End If%>
	
	
	<html>
	
	<head>
	
	<title></title>
	
	</head>
	
	<body>
	
	
	
	<%
	
	
	If bSubmitted <> "" AND bFilledOutProperly Then
	
	Dim oConn
	
	Dim oCmd
	
	
	
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	
	
	
	With oCmd
	
		  .CommandText = "del_PricePlanDetail"
		  .CommandType = 4
	
	
		  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		  .Parameters.Append .CreateParameter("@PricePlanDetailID",3, 1,4, PricePlanDetailID)
	
		  .Parameters.Append .CreateParameter("@ModifiedBy",3, 1,4, ModifiedBy)
	
	
	
	End With
	
	oConn.Open strDBaseConnString
	
	oCmd.ActiveConnection = oConn
	
	oCmd.Execute , , 128
	
	If oConn.Errors.Count < 1 then
	
		Response.Redirect("editpriceplan.asp?PPID=" & PricePlanID)	
	
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
	
	Are you sure you want to delete this price plan detail entry?
	
	<%
	
	Set oConn = Nothing
	Set oCmd = Nothing
	Dim oRs
	
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	
	With oCmd
	
		  .CommandText = "sel_PricePlanDetail"
		  .CommandType = 4
	
		  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		  .Parameters.Append .CreateParameter("@PricePlanDetailID",3, 1,4, PricePlanDetailID)
	
	End With
	
	oConn.Open strDBaseConnString
	oCmd.ActiveConnection = oConn
	
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	
	If oConn.Errors.Count < 1 then
	
		Response.Write "<br><br><TABLE BORDER=1><TR><TD>"
		Response.Write "Min Volume Amt: </TD><TD>" & oRs("MinVolumeAmt")
		Response.Write "<TR><TD>"
		Response.Write "Max Volume Amt: </TD><TD>" & oRs("MaxVolumeAmt")
		Response.Write "<TR><TD>"
		Response.Write "Discount Percent: </TD><TD>" & oRs("DiscountPercent")
		Response.Write "<TR><TD>"
		Response.Write "Commission Percent: </TD><TD>" & oRs("CommissionPercent")
		Response.Write "</TD></TR></TABLE>"	
	End IF
	
	%>
	
	<form name="thisForm" id="thisForm" method="post" action="delpriceplandetail.asp">
	
	
	
	<table>
	
	<tr>
	<td>
	
	</td>
	<td>
	
	<input type="hidden" name="txtPricePlanDetailID" id="txtPricePlanDetailID" Value="<%=PricePlanDetailID%>" >
	<input type="hidden" name="txtPricePlanID" id="txtPricePlanID" Value="<%=PricePlanID%>" >
	
	</td>
	</tr><tr>
	<td>
	
	
	</td>
	<td>
	
	<input type="hidden" name="txtModifiedBy" id="txtModifiedBy" Value="<%=ModifiedBy%>" >
	
	</td>
	</tr></table><br>
	
	<input type="hidden" name="txtSubmit" id="txtSubmit" value=1>
	
	<input type="submit" border=0 value="Delete" id=add name=add>
	
	</form>
	
	
	</body>
	
	</html>
	
</div>
</body>
</html>
