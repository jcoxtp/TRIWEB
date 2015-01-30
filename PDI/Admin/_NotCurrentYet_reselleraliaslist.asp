<%@ Language=VBScript %>
<!--#Include FILE="Include/checklogin.asp" -->
<!--#Include FILE="Include/common.asp" -->
<%
pageID = "home"
%>

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
	'* Creation Date: Friday, March 08, 2002  19:32:26
	'* Copyright (c) 2002 VoyageSoft, Inc.
	'*
	'* ----  Code Settings ----
	'*
	'* Returns Recordset: YES
	'* Purpose: This ASP page calls the stored procedure sel_Company_OriginationCoID using ADO.
	'**********************************************************************************************************************************
	
	
	on error resume next
	
	
	Dim bSubmitted, ResellerCo
	
	ResellerCo = Request.QueryString("NM")
	
	bSubmitted = Request.Form ("txtSubmit")
	
	
	Dim bFilledOutProperly, strErrMsg
	
	Dim ResellerCoID
	
	
	bSubmitted = 1 
	
	bFilledOutProperly = FALSE
	
	If bSubmitted <> "" Then
	
	
		  ResellerCoID = Request.QueryString("RID")
	
	
	
	End If
	
	ResellerCoID = Trim(ResellerCoID)
	
	
	
	
	If bSubmitted <> "" Then
	
		  If ResellerCoID = "" then 
	
				 strErrMsg = " Please enter a value for - ResellerCoID"
	
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
		Dim oRs
	
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
	
		With oCmd
	
			  .CommandText = "sel_Company_OriginationCoID"
			  .CommandType = 4
	
	
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				.Parameters.Append .CreateParameter("@ResellerCoID",3, 1,4, ResellerCoID)
	
	
		End With
	
	
		oConn.Open strDbConnString
	
		oCmd.ActiveConnection = oConn
	
	
		oRs.CursorLocation = 3
	
		oRs.Open oCmd, , 0, 1
	
		If oConn.Errors.Count < 1 then
	
			Response.Write "<BR><BR>"
	
			Response.Write "<STRONG>Alias Companies Related To the Reseller:</STRONG> " & ResellerCo
	
			Response.Write "<BR><BR>"
			Response.Write "<a href='resellerconsumerco.asp?NM=" & ResellerCo & "&RID=" & ResellerCoID & "'>View All Reseller to Alias to Consumer Relationships</a>"
			Response.Write "<BR><BR>"
			Response.Write "<STRONG>No. Of Alias Companies:</STRONG> " & oRs.RecordCount
			Response.Write "<BR><BR>"
	
			Dim Field, nColumns
	
			If oRs.EOF = FALSE then
	
				oRs.MoveFirst
	
				Response.Write "<TABLE BORDER=1>"
	
				Response.Write "<TR>"
	
				Response.Write "<TD><font size=2><STRONG>Company Name</STRONG>"
				Response.Write "</TD>"
	
				Response.Write "<TD><font size=2><STRONG>Type</STRONG>"
				Response.Write "</TD>"
	
				Response.Write "<TD><font size=2><STRONG>Address</STRONG>"
				Response.Write "</TD>"
	
				Response.Write "</TR>"
	
				do while oRs.EOF = FALSE
	
					Response.Write "<TR>"
	
					Response.Write "<TD><FONT Size=2><a href='editcompany.asp?CID=" & oRs("CompanyID") & "'>" & oRs("CompanyName") & "</a>"
					Response.Write "</TD>"
	
					Response.Write "<TD><FONT Size=2>"
					
						
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
	
					oConn.Open strDbConnString
	
					oCmd.ActiveConnection = oConn
	
					oCoTypes.CursorLocation = 3
	
					oCoTypes.Open oCmd, , 0, 1
					
					while oCoTypes.EOF = FALSE 
					
						if oCoTypes("CompanyTypeID") = oRs("CompanyTypeID") then
						
							Response.Write oCoTypes("CompanyType")
						
						end if
					
					
						oCoTypes.MoveNext
					
					wend
					
					Set oCoTypes = Nothing
					
					Response.Write "</TD>"
					
					Response.Write "<TD><font size=2>"  & oRs("Address1") & " " & oRs("City") & " " & oRs("Prv_Abbreviation") & ", " & oRs("PostalCode")
					Response.Write "</TD>"
					
					Response.Write "</TR>"
	
					oRs.MoveNext
	
				Loop
	
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
	
	
	<form name="thisForm" id="thisForm" method="post" action="trash.asp">
	
	<STRONG>Form Information</STRONG>
	
	<br><br>
	
	<table>
	
	<tr>
	<td>
	
	ResellerCoID
	
	</td>
	<td>
	
	<input type="text" name="txtResellerCoID" id="txtResellerCoID" Value="<%=ResellerCoID%>" >
	
	</td>
	</tr></table><br>
	
	<input type="hidden" name="txtSubmit" id="txtSubmit" value=1>
	
	<input type="submit" border=0 value="submit" id=add name=add>
	
	</form>
	
	
	</body>
	
	</html>
	
</div>
</body>
</html>
