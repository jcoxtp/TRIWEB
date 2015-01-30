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
	'* Creation Date: Thursday, January 17, 2002  15:47:29
	'* Copyright (c) 2002 VoyageSoft, Inc.
	'*
	'* ----  Code Settings ----
	'*
	'* Returns Recordset: NO
	'* Purpose: This ASP page calls the stored procedure upd_Company using ADO.
	'**********************************************************************************************************************************
	
	on error resume next
	
	Dim bSubmitted
	
	bSubmitted = Request.Form ("txtSubmit")
	
	Dim bFilledOutProperly, strErrMsg
	
	Dim CompanyName
	Dim Address1
	Dim Address2
	Dim Address3
	Dim Address4
	Dim City
	Dim ProvinceID
	Dim PostalCode
	Dim Country
	Dim PricePlanID
	Dim LastModifiedBy
	Dim Active
	Dim CompanyID
	Dim CompanyTypeID
	Dim OriginationCoID
		 
	Dim ResellUserPricePlanID
	 
	bFilledOutProperly = FALSE
	
	If bSubmitted <> "" Then
	
		  CompanyName = Request.Form("txtCompanyName")
	
		  Address1 = Request.Form("txtAddress1")
	
		  Address2 = Request.Form("txtAddress2")
	
		  Address3 = Request.Form("txtAddress3")
	
		  Address4 = Request.Form("txtAddress4")
	
		  City = Request.Form("txtCity")
	
		  ProvinceID = Request.Form("txtProvinceID")
	
		  PostalCode = Request.Form("txtPostalCode")
	
		  Country = Request.Form("txtCountry")
	
		  PricePlanID = Request.Form("txtPricePlanID")
	
		  LastModifiedBy = Request.Form("txtLastModifiedBy")
	
		  Active = Request.Form("txtActive")
	
		  CompanyID = Request.Form("txtCompanyID")
		  
		  CompanyTypeID = Request.Form("txtCompanyTypeID")
		  
		  OriginationCoID = Request.Form("txtOriginationCoID")
		  
		  ResellUserPricePlanID = Request.Form("txtResellUserPricePlanID")
		  
		  if Active = "on" then
			Active = 1 
		 else
			 Active = 0
		 end if
	
	else
	
		CompanyID = Request.QueryString("CID")
		
		LastModifiedBy = Request.Cookies("UserID")
		
		
	
		' get the company information
		
		Dim oConn
		Dim oCmd
		Dim oRs
	
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
	
		With oCmd
	
			  .CommandText = "sel_Company"
			  .CommandType = 4
	
	
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				.Parameters.Append .CreateParameter("@CompanyID",3, 1,4, CompanyID)
	
		End With
	
		oConn.Open strDBaseConnString
	
		oCmd.ActiveConnection = oConn
	
		oRs.CursorLocation = 3
	
		oRs.Open oCmd, , 0, 1
		
		If oConn.Errors.Count >= 1 then
		
			Response.Write "Cannot retrieve company information."
			Response.End
		
		end if
		
		CompanyName = oRs("CompanyName")
		Address1 = oRs("Address1")
		Address2 = oRs("Address2")
		Address3 = oRs("Address3")
		Address4 = oRs("Address4")
		 City = oRs("City")
		ProvinceID = oRs("ProvinceID")
		PostalCode = oRs("PostalCode")   
		Country = oRs("Country")   
		PricePlanID = oRs("PricePlanID")   
		CompanyTypeID = oRs("CompanyTypeID")
		Active = oRs("Active")   
		OriginationCoID = oRs("OriginationCoID")
		ResellUserPricePlanID = oRs("Resell_User_Def_PricePlanID")
		
		set oConn = nothing
		set oCmd = nothing
		set ors = nothing
		
	End If
	
	CompanyName = Trim(CompanyName)
	Address1 = Trim(Address1)
	Address2 = Trim(Address2)
	Address3 = Trim(Address3)
	Address4 = Trim(Address4)
	City = Trim(City)
	ProvinceID = Trim(ProvinceID)
	PostalCode = Trim(PostalCode)
	Country = Trim(Country)
	PricePlanID = Trim(PricePlanID)
	LastModifiedBy = Trim(LastModifiedBy)
	Active = Trim(Active)
	CompanyID = Trim(CompanyID)
	CompanyTypeID = Trim(CompanyTypeID)
	OriginationCoID = Trim(OriginationCoID)
	
	
	If bSubmitted <> "" Then
	
		  If CompanyName = "" then 
	
				 strErrMsg = " Please enter a value for - CompanyName"
	
		  ElseIf Address1 = "" then 
	
				 strErrMsg = " Please enter a value for - Address1"
	
		  'ElseIf Address2 = "" then 
	
				 'strErrMsg = " Please enter a value for - Address2"
	
		  'ElseIf Address3 = "" then 
	
				 'strErrMsg = " Please enter a value for - Address3"
	
		  'ElseIf Address4 = "" then 
	
				 'strErrMsg = " Please enter a value for - Address4"
	
		  ElseIf City = "" then 
	
				 strErrMsg = " Please enter a value for - City"
	
		  ElseIf ProvinceID = "" then 
	
				 strErrMsg = " Please enter a value for - ProvinceID"
	
		  ElseIf PostalCode = "" then 
	
				 strErrMsg = " Please enter a value for - PostalCode"
	
		  'ElseIf Country = "" then 
	
				 'strErrMsg = " Please enter a value for - Country"
	
		  ElseIf PricePlanID = "" then 
	
				 strErrMsg = " Please enter a value for - PricePlanID"
	
		  ElseIf LastModifiedBy = "" then 
	
				 strErrMsg = " Please enter a value for - LastModifiedBy"
	
		  ElseIf Active = "" then 
	
				 strErrMsg = " Please enter a value for - Active"
	
		  ElseIf CompanyID = "" then 
	
				 strErrMsg = " Please enter a value for - CompanyID"
	
		 ElseIf CompanyTypeID = "" then 
	
				 strErrMsg = " Please enter a value for - CompanyTypeID"
	
	
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
	
	
	
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	
	ResellUserPricePlanID = TRIM(ResellUserPricePlanID)
	
	if ResellUserPricePlanID = "" then
	
		ResellUserPricePlanID = 0
	
	end if
	
	With oCmd
	
		  .CommandText = "upd_Company"
		  .CommandType = 4
	
	
		  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
						 .Parameters.Append .CreateParameter("@CompanyName",200, 1,100, CompanyName)
	
						 .Parameters.Append .CreateParameter("@Address1",200, 1,100, Address1)
	
						 .Parameters.Append .CreateParameter("@Address2",200, 1,100, Address2)
	
						 .Parameters.Append .CreateParameter("@Address3",200, 1,100, Address3)
	
						 .Parameters.Append .CreateParameter("@Address4",200, 1,100, Address4)
	
						 .Parameters.Append .CreateParameter("@City",200, 1,100, City)
	
						 .Parameters.Append .CreateParameter("@ProvinceID",3, 1,4, ProvinceID)
	
						 .Parameters.Append .CreateParameter("@PostalCode",200, 1,50, PostalCode)
	
						 .Parameters.Append .CreateParameter("@Country",200, 1,50, Country)
	
						 .Parameters.Append .CreateParameter("@PricePlanID",3, 1,4, PricePlanID)
	
						 .Parameters.Append .CreateParameter("@LastModifiedBy",3, 1,4, LastModifiedBy)
	
						 .Parameters.Append .CreateParameter("@Active",3, 1,4, Active)
	
					.Parameters.Append .CreateParameter("@CompanyTypeID",3, 1,4, CompanyTypeID)
	
					.Parameters.Append .CreateParameter("@Resell_User_Def_PricePlanID",3, 1,4, ResellUserPricePlanID)
	
						 .Parameters.Append .CreateParameter("@CompanyID",3, 1,4, CompanyID)
						 
						 
						 
	
	
	
	End With
	
	
	
	
	oConn.Open strDBaseConnString
	
	oCmd.ActiveConnection = oConn
	
	
	oCmd.Execute , , 128
	
	If oConn.Errors.Count < 1 then
	
		Response.Write "<BR><BR>Company information updated successfully.<BR><BR>"
		Response.End
	
	else
	
		  strErrMsg = FormatSQLError(Err.description)
		  Err.Clear
	
	End If
	
	
	End If
	
	
	If strErrMsg <> "" Then
	
		  Response.Write "<br>"
		  Response.Write "<font color=red>" & strErrMsg & "</font>"
		  Response.Write "<br><br>"
	
	
	End If %>
	
	
	<form name="thisForm" id="thisForm" method="post" action="editcompany.asp">
	
	<br><br>
	<STRONG>Company Information</STRONG>
	
	
	
	<TABLE>
	<TR>
	<TD>
	
	<% if CompanyTypeID <> 4 then %>
	
		<a href='companysnap.asp?NM=<%=server.URLEncode(CompanyName)%>&CID=<%=CompanyID%>'>Company Snapshot</a>
	
	<%
	end if
	
	if CompanyTypeID = 4 then
		Response.Write "&nbsp;&nbsp;<a href='companyalias.asp?NM=" & Server.URLEncode(CompanyName) & "&CID=" & CompanyID & "'>Additional Alias List</a>"
		
	else
		Response.Write "&nbsp;&nbsp;<a href='companyusers.asp?NM=" & Server.URLEncode(CompanyName) & "&CID=" & CompanyID & "'>User List</a>"
		
	end if
	
	if CompanyTypeID = 3 then
		Response.Write "&nbsp;&nbsp;<a href='reselleraliaslist.asp?NM=" & Server.URLEncode(CompanyName) & "&RID=" & CompanyID & "'>Related Alias Company List</a>"
		
	else
		Response.Write "&nbsp;&nbsp;"
	end if
	%>
	</td>
	</tr>
	
	<%
	if CompanyTypeID = 3 then
		Response.Write "<tr><td>"
		Response.Write "<a href='resellerconsumerco.asp?NM=" & Server.URLEncode(CompanyName) & "&RID=" & CompanyID & "'>View All Reseller to Alias to Consumer Relationships</a>"
		Response.Write "</td></tr>"
	end if
	%>		
	
	<%
	if CompanyTypeID = 3 then
		Response.Write "<tr><td>"
		Response.Write "<a href='resellercommissions.asp?RID=" & CompanyID & "'>Reseller Commissions</a>"
		Response.Write "</td></tr>"
	end if
	%>		
	
		
	</table>
	<br>
	<table border=1>
	
	<tr>
	<td>
	*Company Name
	
	</td>
	<td>
	
	<input type="text" name="txtCompanyName" id="txtCompanyName" MaxLength=100 Size=50 Value="<%=CompanyName%>" >
	
	</td>
	</tr>
	
	<tr>
	<td>
	
	*Address1
	
	</td>
	<td>
	
	<input type="text" name="txtAddress1" id="txtAddress1" MaxLength=100 Size=50 Value="<%=Address1%>" >
	
	</td>
	</tr><tr>
	<td>
	
	Address2
	
	</td>
	<td>
	
	<input type="text" name="txtAddress2" id="txtAddress2" MaxLength=100 Size=50 Value="<%=Address2%>" >
	<input type="hidden" name="txtAddress3" id="txtAddress3" MaxLength=100 Value="<%=Address3%>" >
	<input type="hidden" name="txtAddress4" id="txtAddress4" MaxLength=100 Value="<%=Address4%>" >
	
	</td>
	</tr>
	
	<tr>
	<td>
	
	*City
	
	</td>
	<td>
	
	<input type="text" name="txtCity" id="txtCity" MaxLength=100 Value="<%=City%>" >
	
	</td>
	</tr><tr>
	<td>
	
	*State
	
	</td>
	<td>
	
	
	<%
	
	
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	
	
	
	With oCmd
	
		  .CommandText = "sel_Province_all"
		  .CommandType = 4
	
	
		  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	
	
	End With
	
	
	
	
	oConn.Open strDBaseConnString
	
	oCmd.ActiveConnection = oConn
	
	
	oRs.CursorLocation = 3
	
	oRs.Open oCmd, , 0, 1
	
	
	
	
	If oConn.Errors.Count < 1 then
	
		%>
		<select name="txtProvinceID">
	
		<%
		
			while oRs.EOF = FALSE
			
				if CInt(oRs("ProvinceID")) = CInt(ProvinceID) then
				
			
				%>
					<option value="<%=oRs("ProvinceID")%>" selected><%=oRs("Prv_Name")%>
				<%
				else
			%>
					<option value="<%=oRs("ProvinceID")%>"><%=oRs("Prv_Name")%>
			<%
				end if
			
				oRs.MoveNext
		
			wend
		
	
	end if
	
	
	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRs = Nothing
	
	
	%>
	
	</select>
	
	</td>
	</tr><tr>
	<td>
	
	*Postal Code
	
	</td>
	<td>
	
	<input type="text" name="txtPostalCode" id="txtPostalCode"  MaxLength=5 Size=5  Value="<%=PostalCode%>" >
	
	</td>
	</tr><tr>
	<td>
	
	
	
	</td>
	<td>
	
	<input type="hidden" name="txtCountry" id="txtCountry" MaxLength=50 Value="<%=Country%>" >
	
	</td>
	</tr><tr>
	<td>
	
	*<a href='sel_priceplan_all.asp'>PricePlan</a>
	
	</td>
	<td>
	
	<%
	
	
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	
	
	
	With oCmd
	
		  .CommandText = "sel_PricePlan_all"
		  .CommandType = 4
	
	
		  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	
	
	End With
	
	oConn.Open strDBaseConnString
	
	oCmd.ActiveConnection = oConn
	
	oRs.CursorLocation = 3
	
	oRs.Open oCmd, , 0, 1
	
	If oConn.Errors.Count < 1 then
	
		%>
		<select name="txtPricePlanID">
	
		<%
		
			while oRs.EOF = FALSE
			
				if CInt(oRs("PricePlanID")) = CInt(PricePlanID) then
				
			
				%>
					<option value="<%=oRs("PricePlanID")%>" selected><%=oRs("PricePlanName")%>
				<%
				else
			%>
					<option value="<%=oRs("PricePlanID")%>"><%=oRs("PricePlanName")%>
			<%
				end if
			
				oRs.MoveNext
		
			wend
		
	end if
	
	
	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRs = Nothing
	
	
	%>
	
	</select>
	
	
	</td>
	</tr>
	
	<% if CompanyTypeID = 3 then %>
	<tr>
	<td>
	
	*Reseller - User Signup<br>Default Price Plan
	
	</td>
	<td>
	
	<%
	
	
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	
	
	
	With oCmd
	
		  .CommandText = "sel_PricePlan_all"
		  .CommandType = 4
	
	
		  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	
	
	End With
	
	oConn.Open strDBaseConnString
	
	oCmd.ActiveConnection = oConn
	
	oRs.CursorLocation = 3
	
	oRs.Open oCmd, , 0, 1
	
	If oConn.Errors.Count < 1 then
	
		%>
		<select name="txtResellUserPricePlanID">
	
		<%
		
			while oRs.EOF = FALSE
			
				if CInt(oRs("PricePlanID")) = CInt(ResellUserPricePlanID) then
				
			
				%>
					<option value="<%=oRs("PricePlanID")%>" selected><%=oRs("PricePlanName")%>
				<%
				else
			%>
					<option value="<%=oRs("PricePlanID")%>"><%=oRs("PricePlanName")%>
			<%
				end if
			
				oRs.MoveNext
		
			wend
		
	end if
	
	
	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRs = Nothing
	
	
	%>
	
	</select>
	
	</td>
	</tr>
	
	<% end if %>
	
	<tr>
	<td>
	
	*Company Type
	
	</td>
	<td>
	
	
	
	<%
	
	
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	
	
	
	With oCmd
	
		  .CommandText = "sel_companytype_all"
		  .CommandType = 4
	
	
		  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	
	
	End With
	
	
	
	
	oConn.Open strDBaseConnString
	
	oCmd.ActiveConnection = oConn
	
	
	oRs.CursorLocation = 3
	
	oRs.Open oCmd, , 0, 1
	
	
	
	
	If oConn.Errors.Count < 1 then
	
	
		if CompanyTypeID = 4 or CompanyTypeID = 1 then
		%>
			 <input type="hidden" name="txtCompanyTypeID" id="txtCompanyTypeID" Value="<%=CompanyTypeID%>" >
	
			<select name="CompanyTypeID" disabled>	
					
		<%
		else
		%>
			<select name="txtCompanyTypeID">
		<%
		end if
		
		
			while oRs.EOF = FALSE
			
				if CInt(oRs("CompanyTypeID")) = CInt(CompanyTypeID) then
				
			
				%>
					<option value="<%=oRs("CompanyTypeID")%>" selected><%=oRs("CompanyType")%>
				<%
				else
			%>
					<option value="<%=oRs("CompanyTypeID")%>"><%=oRs("CompanyType")%>
			<%
				end if
			
				oRs.MoveNext
		
			wend
		
		
		
	
	end if
	
	
	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRs = Nothing
	
	
	%>
	
	</select>
	
	</td>
	</tr>
	
	<%
	if CompanyTypeID = 4 AND ISNULL(OriginationCoID) = FALSE then
			Response.Write "<TR><TD>Reseller Company"
			Resonse.Write OriginationCoID
			Response.Write "</TD>"
			Response.Write "<TD>"
						
				Set oConn = Nothing
				Set oCmd = Nothing
							
				Set oConn = CreateObject("ADODB.Connection")
				Set oCmd = CreateObject("ADODB.Command")
	
				With oCmd
	
					  .CommandText = "sel_Company_output"
					  .CommandType = 4
	
	
					  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
						.Parameters.Append .CreateParameter("@CompanyID",3, 1,4, OriginationCoID)
	
					  .Parameters.Append .CreateParameter("@CompanyName",200, 3,100, CStr(CompanyName2))
	
				End With
	
				oConn.Open strDBaseConnString
	
				oCmd.ActiveConnection = oConn
	
				oCmd.Execute , , 128
	
				CompanyName2 = oCmd.Parameters("@CompanyName").value
	
				If oConn.Errors.Count < 1 then
		
					
					%>
					<input type="hidden" name="txtOriginationCoID" id="txtOriginationCoID" Value="<%=OriginationCoID%>" >
	
					<%
					Response.Write "<a href='editcompany.asp?CID=" & OriginationCoID & "'>" & CompanyName2 & "</a>"
												
				End If					
						
				Set oConn = Nothing
				Set oCmd = Nothing
				
				Response.Write "</TD></TR>"
	end if
	%>					
	
	
	<tr>
	<td>
	
	
	
	</td>
	<td>
	
	<input type="hidden" name="txtLastModifiedBy" id="txtLastModifiedBy" Value="<%=LastModifiedBy%>" >
	
	</td>
	</tr><tr>
	<td>
	
	*Active
	
	</td>
	<td>
	
	<% 
	
	dim Enabled
	
	if CompanyTypeID = 1 then
		Enabled = "DISABLED"
	else
		Enabled = ""
	end if
	
	
	if Active = 1 then %>
		<input type="checkbox" <%=ENABLED%> CHECKED name="txtActive" id="txtActive" >
	<% else %>
		<input type="checkbox" <%=ENABLED%> name="txtActive" id="txtActive" >
	<% end if 
	
	
	%>
	
	</td>
	</tr><tr>
	<td>
	
	
	</td>
	<td>
	
	<input type="hidden" name="txtCompanyID" id="txtCompanyID" Value="<%=CompanyID%>" >
	
	</td>
	</tr></table><br>
	
	<input type="hidden" name="txtSubmit" id="txtSubmit" value=1>
	
	<input type="submit" border=0 value="Update" id=add name=add>
	
	</form>
	<br>
	* - Required
	
	</body>
	
	</html>
	

</div>
</body>
</html>
