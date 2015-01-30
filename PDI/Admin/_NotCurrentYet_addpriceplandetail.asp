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
	'* Creation Date: Saturday, January 12, 2002  20:26:59
	'* Copyright (c) 2002 VoyageSoft, Inc.
	'*
	'* ----  Code Settings ----
	'*
	'* Returns Recordset: NO
	'* Purpose: This ASP page calls the stored procedure ins_PricePlanDetail using ADO.
	'**********************************************************************************************************************************
	
	on error resume next
	
	Dim bSubmitted
	
	bSubmitted = Request.Form ("txtSubmit")
	
	Dim bFilledOutProperly, strErrMsg
	
	Dim PricePlanID
	Dim MinVolumeAmt
	Dim MaxVolumeAmt
	Dim DiscountPercent
	Dim CommissionPercent
	Dim CreatedBy
	Dim Active
	
	
	
	
	bFilledOutProperly = FALSE
	
	If bSubmitted <> "" Then
	
	
		  PricePlanID = Request.Form("txtPricePlanID")
	
		  MinVolumeAmt = Request.Form("txtMinVolumeAmt")
	
		  MaxVolumeAmt = Request.Form("txtMaxVolumeAmt")
	
		  DiscountPercent = Request.Form("txtDiscountPercent")
	
		  CommissionPercent = Request.Form("txtCommissionPercent")
	
		  CreatedBy = Request.Form("txtCreatedBy")
	
		  Active = Request.Form("txtActive")
	
	Else
	
		PricePlanID = Request.QueryString("PPID")
		
		CreatedBy = Request.Cookies("UserID")
	
	End If
	
	PricePlanID = Trim(PricePlanID)
	MinVolumeAmt = Trim(MinVolumeAmt)
	MaxVolumeAmt = Trim(MaxVolumeAmt)
	DiscountPercent = Trim(DiscountPercent)
	CommissionPercent = Trim(CommissionPercent)
	CreatedBy = Trim(CreatedBy)
	Active = Trim(Active)
	
	
	If bSubmitted <> "" Then
	
		  If PricePlanID = "" then 
	
				 strErrMsg = " Please enter a value for - PricePlanID"
	
		  ElseIf MinVolumeAmt = "" then 
	
				 strErrMsg = " Please enter a value for - MinVolumeAmt"
	
		  ElseIf MaxVolumeAmt = "" then 
	
				 strErrMsg = " Please enter a value for - MaxVolumeAmt"
	
		 ElseIf CDbl(MaxVolumeAmt) <= CDbl(MinVolumeAmt) then 
	
				 strErrMsg = " Max Volume Amt must be greater than Min Volume Amt - Please Correct"
				 
		  ElseIf DiscountPercent = "" then 
	
				 strErrMsg = " Please enter a value for - DiscountPercent"
	
		 ElseIf DiscountPercent >= 1.0 then 
	
				 strErrMsg = " Please enter a value less than 1 for DiscountPercent"
	
		  ElseIf CommissionPercent = "" then 
	
				 strErrMsg = " Please enter a value for - CommissionPercent"
	
		 ElseIf CommissionPercent >= 1.0 then 
	
				 strErrMsg = " Please enter a value less than 1 for CommissionPercent"
	
		  ElseIf CreatedBy = "" then 
	
				 strErrMsg = " Please enter a value for - CreatedBy"
	
		  ElseIf Active = "" then 
	
				 strErrMsg = " Please enter a value for - Active"
	
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
			.CommandText = "ins_PricePlanDetail"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			.Parameters.Append .CreateParameter("@PricePlanID",3, 1,4, PricePlanID)
			.Parameters.Append .CreateParameter("@MinVolumeAmt",6, 1,21, MinVolumeAmt)
			.Parameters.Append .CreateParameter("@MaxVolumeAmt",6, 1,21, MaxVolumeAmt)
			.Parameters.Append .CreateParameter("@DiscountPercent",5, 1,8, DiscountPercent)
			.Parameters.Append .CreateParameter("@CommissionPercent",5, 1,8, CommissionPercent)
			.Parameters.Append .CreateParameter("@CreatedBy",3, 1,4, CreatedBy)
			.Parameters.Append .CreateParameter("@Active",3, 1,4, Active)
		End With
	
		oConn.Open strDbConnString
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
	
	<form name="thisForm" id="thisForm" method="post" action="addpriceplandetail.asp">
	
	<STRONG>Price Plan Detail Information</STRONG>
	
	<br><br>
	
	<table>
	
	<tr>
	<td>
	
	
	</td>
	<td>
	
	<input type="hidden" name="txtPricePlanID" id="txtPricePlanID" Value="<%=PricePlanID%>" >
	
	</td>
	</tr><tr>
	<td>
	
	*MinVolumeAmt
	
	</td>
	<td>
	
	<input type="text" name="txtMinVolumeAmt" id="txtMinVolumeAmt" Value="<%=MinVolumeAmt%>" >
	
	</td>
	</tr><tr>
	<td>
	
	*MaxVolumeAmt
	
	</td>
	<td>
	
	<input type="text" name="txtMaxVolumeAmt" id="txtMaxVolumeAmt" Value="<%=MaxVolumeAmt%>" >
	
	</td>
	</tr><tr>
	<td>
	
	*DiscountPercent
	
	</td>
	<td>
	
	<input type="text" name="txtDiscountPercent" id="txtDiscountPercent" Value="<%=DiscountPercent%>" >
	
	</td>
	</tr><tr>
	<td>
	
	*CommissionPercent
	
	</td>
	<td>
	
	<input type="text" name="txtCommissionPercent" id="txtCommissionPercent" Value="<%=CommissionPercent%>" >
	
	</td>
	</tr><tr>
	<td>
	
	
	
	</td>
	<td>
	
	<input type="hidden" name="txtCreatedBy" id="txtCreatedBy" Value="<%=CreatedBy%>" >
	
	</td>
	</tr><tr>
	<td>
	</td>
	<td>
	
	<input type="hidden" name="txtActive" id="txtActive" Value=1>
	
	</td>
	</tr></table><br>
	
	<input type="hidden" name="txtSubmit" id="txtSubmit" value=1>
	
	<input type="submit" border=0 value="submit" id=add name=add>
	
	</form>
	* - Required
	
	</body>
	
	</html>
	
</div>
</body>
</html>
