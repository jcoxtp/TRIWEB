<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/CheckAdminLogin.asp" -->
<!--#INCLUDE FILE="../include/common.asp" -->
<% pageID = "home" %>

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
	'*
	'* Generated By: TierBuilder V3.2 - www.tierbuilder.com
	'* Created By: David Brackin
	'* Creation Date: Wednesday, January 16, 2002  23:43:38
	'* Copyright (c) 2002 Team Resources, Inc.
	'*
	'* ----  Code Settings ----
	'*
	'* Returns Recordset: YES
	'* Purpose: This ASP page calls the stored procedure sel_Company_Srch using ADO.
	'**********************************************************************************************************************************
	
	on error resume next
	
	
	Dim bSubmitted, nFontSize
	
	nFontSize = 2
	
	bSubmitted = Request.Form ("txtSubmit")
	
	
	Dim bFilledOutProperly, strErrMsg
	
	Dim CompanyName
	
	
	
	
	bFilledOutProperly = FALSE
	
	If bSubmitted <> "" Then
	
	
		  CompanyName = Request.Form("txtCompanyName")
	
	
	
	End If
	
	CompanyName = Trim(CompanyName)
	
	
	If bSubmitted <> "" Then
	
		  If CompanyName = "" then 
	
				 strErrMsg = " Please enter a value for - CompanyName"
	
		  Else
	
				 bFilledOutProperly = TRUE
	
		  End If
		  
		
	
	End If%>
	
	
	<html>
	
	<head>
	
	<title></title>
	
	</head>
	
	<body>
	
	
	<form name="thisForm" id="thisForm" method="post" action="companysrch.asp">
	
	<STRONG>Search for Company</STRONG>
	
	<br><br>
	
	<table>
	
	<tr>
	<td>
	
	*CompanyName
	
	</td>
	<td>
	
	<input type="text" name="txtCompanyName" id="txtCompanyName" MaxLength=100 Value="<%=CompanyName%>" >
	
	</td>
	</tr></table><br>
	
	<input type="hidden" name="txtSubmit" id="txtSubmit" value=1>
	
	<input type="submit" border=0 value="submit" id=add name=add>
	
	</form>
	* - Required
	<br><br>
	
	<%
	
	dim bfoundit
	
	If bSubmitted <> "" AND bFilledOutProperly Then
	
		Set oConn = nothing
		Set oCmd = nothing
		 Dim oRs
	
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
	
		With oCmd
	
			  .CommandText = "sel_Company_Srch"
			  .CommandType = 4
	
	
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				.Parameters.Append .CreateParameter("@CompanyName",200, 1,100, CompanyName)
	
	
		End With
	
		oConn.Open strDBaseConnString
	
		oCmd.ActiveConnection = oConn
	
		oRs.CursorLocation = 3
	
		oRs.Open oCmd, , 0, 1
	
		If oConn.Errors.Count < 1 then
		
		
			' now get the price plans here
			 
			Dim oConn
			Dim oCmd
			Dim oRPPs
	
			Set oConn = CreateObject("ADODB.Connection")
			Set oCmd = CreateObject("ADODB.Command")
			Set oRPPs = CreateObject("ADODB.Recordset")
	
			With oCmd
	
				  .CommandText = "sel_PricePlan_all"
				  .CommandType = 4
	
				  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	
			End With
	
			oConn.Open strDBaseConnString
	
			oCmd.ActiveConnection = oConn
	
			oRPPs.CursorLocation = 3
	
			oRPPs.Open oCmd, , 0, 1
		
	
			Response.Write "No. Of Records: " & oRs.RecordCount
			Response.Write "<BR><BR>"
			
			
			Dim Field, nColumns
	
			If oRs.EOF = FALSE then
				
				
				%>Click on company name to edit company information.<br> <%
				
				oRs.MoveFirst
	
				Response.Write "<TABLE WIDTH=100% BORDER=1>"
	
				Response.Write "<TR>"
	
				Response.Write "<TD><FONT Size=" & nFontSize & "><STRONG>Company Name</STRONG>"
				Response.Write "</TD>"
	
				Response.Write "<TD><FONT Size=" & nFontSize & "><STRONG>Snapshot</STRONG>"
				Response.Write "</TD>"
				
				Response.Write "<TD><FONT Size=" & nFontSize & "><STRONG>User List</STRONG>"
				Response.Write "</TD>"
				
				
				Response.Write "<TD><FONT Size=" & nFontSize & "><STRONG>Company Type</STRONG>"
				Response.Write "</TD>"
				
				Response.Write "<TD><FONT Size=" & nFontSize & "><STRONG>Reseller Related Alias Company List</STRONG>"
				Response.Write "</TD>"
							
				Response.Write "<TD><FONT Size=" & nFontSize & "><STRONG>Alias Co Related Reseller</STRONG>"
				Response.Write "</TD>"
				
				Response.Write "<TD><FONT Size=" & nFontSize & "><STRONG>Additional Alias List</STRONG>"
				Response.Write "</TD>"
				
				Response.Write "<TD><FONT Size=" & nFontSize & "><STRONG>Price Plan</STRONG>"
				Response.Write "</TD>"
	
				Response.Write "<TD><FONT Size=" & nFontSize & "><STRONG>Address</STRONG>"
				Response.Write "</TD>"
	
				Response.Write "<TD><FONT Size=" & nFontSize & "><STRONG>Active</STRONG>"
				Response.Write "</TD>"
	
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
					
	
				do while oRs.EOF = FALSE
	
					Response.Write "<TR>"
	
					Response.Write "<TD><FONT Size=" & nFontSize & "><a href='editcompany.asp?CID=" & oRs("CompanyID") & "'>" & oRs("CompanyName") & "</a>"
					Response.Write "</TD>"
	
					if oRs("CompanyTypeID") = 4 then
						Response.Write "<TD>&nbsp;"
						Response.Write "</TD>"
					else
						Response.Write "<TD><FONT Size=" & nFontSize & "><a href='companysnap.asp?NM=" & Server.URLEncode(oRs("CompanyName")) & "&CID=" & oRs("CompanyID") & "'>Snapshot</a>"
						Response.Write "</TD>"
					end if
					
					if oRs("CompanyTypeID") = 4 then
						Response.Write "<TD>&nbsp;"
						Response.Write "</TD>"
					else
						Response.Write "<TD ALIGN=CENTER><FONT Size=" & nFontSize & "><a href='companyusers.asp?NM=" & Server.URLEncode(oRs("CompanyName")) & "&CID=" & oRs("CompanyID") & "'>List</a>"
						Response.Write "</TD>"
					end if
					
					Response.Write "<TD><FONT Size=" & nFontSize & ">"
					
					
					oCoTypes.MoveFirst
					
					while oCoTypes.EOF = FALSE 
					
						if oCoTypes("CompanyTypeID") = oRs("CompanyTypeID") then
						
							Response.Write oCoTypes("CompanyType")
						
						end if
					
					
						oCoTypes.MoveNext
					
					wend
					
					oCoTypes.MoveFirst
					
					Response.Write "</TD>"
					
					if oRs("CompanyTypeID") = 3 then
						Response.Write "<TD ALIGN=CENTER><FONT Size=2><a href='reselleraliaslist.asp?NM=" & Server.URLEncode(oRs("CompanyName")) & "&RID=" & oRs("CompanyID") & "'>List</a>"
						Response.Write "</TD>"
					else
						Response.Write "<TD>&nbsp;"
						Response.Write "</TD>"
					end if
					
					Dim CompanyName2
					
					if oRs("CompanyTypeID") = 4 AND ISNULL(oRs("OriginationCoID")) = FALSE then
						Response.Write "<TD ALIGN=CENTER><FONT Size=2>"
	
							Set oConn = Nothing
							Set oCmd = Nothing
							Set oConn = CreateObject("ADODB.Connection")
							Set oCmd = CreateObject("ADODB.Command")
							With oCmd
								  .CommandText = "sel_Company_output"
								  .CommandType = 4
								  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
										.Parameters.Append .CreateParameter("@CompanyID",3, 1,4, oRs("OriginationCoID"))
								  .Parameters.Append .CreateParameter("@CompanyName",200, 3,100, CStr(CompanyName2))
							End With
							oConn.Open strDBaseConnString
							oCmd.ActiveConnection = oConn
							oCmd.Execute , , 128
							CompanyName2 = oCmd.Parameters("@CompanyName").value
	
							If oConn.Errors.Count < 1 then
								Response.Write "<a href='editcompany.asp?CID=" & oRs("OriginationCoID") & "'>" & CompanyName2 & "</a>"
							End If
							Response.Write "</TD>"
	
					elseif oRs("CompanyTypeID") = 4 AND ISNULL(oRs("OriginationCoID")) = TRUE then
						Response.Write "<TD ALIGN=CENTER><font size=2>TRI"
						Response.Write "</TD>"
					else
						Response.Write "<TD>&nbsp;"
						Response.Write "</TD>"
					end if
					
					
					Response.Write "<TD ALIGN=CENTER><FONT Size=" & nFontSize & ">"
					
					if oRs("CompanyTypeID") = 4 then
						Response.Write "<a href='companyalias.asp?NM=" & Server.URLencode(oRs("CompanyName")) & "&CID=" & oRs("CompanyID") & "'>List</a>"
					
					else
						Response.Write "&nbsp;"
						
					end if
					
					Response.Write "</TD>"
						
					oRPPs.MoveFirst
					
					Response.Write "<TD><FONT Size=" & nFontSize & ">"
					
					bfoundit = false
					
					while oRPPs.EOF = false and bfoundit = false
						
						if oRs("PricePlanID") = oRPPS("PricePlanID") then
					
							Response.Write "<a href='editpriceplan.asp?PPID=" & oRs("PricePlanID") & "'>" & oRPPS("PricePlanName") & "</a>"
					
							bfoundit = true	
							
						end if
						
						oRPPs.MoveNext
					
					wend
					
					if bfoundit = false then
					
						Response.Write "Error - Not Found"
					
					end if
									
					Response.Write "</TD>"
					Response.Write "<TD><FONT Size=" & nFontSize & ">" & oRs("Address1") & " " & oRs("City") & " " & oRs("Prv_Abbreviation") & ", " & oRs("PostalCode")
					Response.Write "</TD>"
	
	
					Response.Write "<TD><FONT Size=" & nFontSize & ">"
					
					if oRs("Active") = 1 then
						Response.Write "Yes"
					else
						Response.Write "No"
					end if
					
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
	
	
	
	</body>
	
	</html>
	
</div>
</body>
</html>
