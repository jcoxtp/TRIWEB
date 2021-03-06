<%@ Language=VBScript %>
<!--#Include FILE="Include/CheckAdminLogin.asp" -->
<!--#Include FILE="../Include/common.asp" -->
<% pageID = "home"
%>

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
	'*****************************************************************************************
	'*
	'* Generated By: TierBuilder V3.2 - www.tierbuilder.com
	'* Created By: David Brackin
	'* Creation Date: Thursday, January 17, 2002  16:33:02
	'* Copyright (c) 2002 VoyageSoft, Inc.
	'*
	'* ----  Code Settings ----
	'*
	'* Returns Recordset: YES
	'* Purpose: This ASP page calls the stored procedure sel_v_TRUser_UserInfo_UserType_srch using ADO.
	'**********************************************************************************************************************************
	
	on error resume next
	
	Dim bSubmitted, nFontSize
	
	nFontSize = 2
	
	bSubmitted = Request.Form ("txtSubmit")
	
	Dim bFilledOutProperly, strErrMsg
	
	Dim LastName
	
	bFilledOutProperly = FALSE
	
	If bSubmitted <> "" Then
	
		  LastName = Request.Form("txtLastName")
	
	End If
	
	LastName = Trim(LastName)
	
	If bSubmitted <> "" Then
	
		  If LastName = "" then 
	
				 strErrMsg = " Please enter a value for - LastName"
	
		  Else
	
				 bFilledOutProperly = TRUE
	
		  End If
	
	End If%>
	
	
	<html>
	
	<head>
	
	<title></title>
	
	</head>
	
	<body>
	
	
	<form name="thisForm" id="thisForm" method="post" action="usersrch.asp">
	
	<STRONG>Search for User</STRONG>
	
	<br><br>
	
	<table>
	
	<tr>
	<td>
	
	*LastName
	
	</td>
	<td>
	
	<input type="text" name="txtLastName" id="txtLastName" MaxLength=100 Value="<%=LastName%>" >
	
	</td>
	</tr></table><br>
	
	<input type="hidden" name="txtSubmit" id="txtSubmit" value=1>
	
	<input type="submit" border=0 value="submit" id=add name=add>
	
	</form>
	* - Required
	
	<%
	If bSubmitted <> "" AND bFilledOutProperly Then
		Dim oConn
		Dim oCmd
		Dim oRs
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
	
		With oCmd
			  .CommandText = "sel_v_TRUser_UserInfo_UserType_srch"
			  .CommandType = 4
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				.Parameters.Append .CreateParameter("@LastName",200, 1,100, LastName)
		End With
	
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
	
		If oConn.Errors.Count < 1 then
			Response.Write "<BR><BR>"
			Response.Write "No. Of Records: " & oRs.RecordCount
			Dim Field, nColumns
	
			If oRs.EOF = FALSE then
				'Response.Write "<BR><BR>Users not related to a company are listed with a company name of 'NOT DETERMINED'"
				Response.Write "<BR>Click on the company name to view the user's company information."
				oRs.MoveFirst
				Response.Write "<TABLE WIDTH=100% BORDER=1>"
				Response.Write "<TR>"
				Response.Write "<TD><FONT SIZE=" & nFontSize & "><STRONG>Last Name</STRONG>"
				Response.Write "</TD>"
				Response.Write "<TD><FONT SIZE=" & nFontSize & "><STRONG>First Name</STRONG>"
				Response.Write "</TD>"
				Response.Write "<TD><FONT SIZE=" & nFontSize & "><STRONG>User Name</STRONG>"
				Response.Write "</TD>"
				Response.Write "<TD><FONT SIZE=" & nFontSize & "><STRONG>Position</STRONG>"
				Response.Write "</TD>"
				Response.Write "<TD><FONT SIZE=" & nFontSize & "><STRONG>Team Name</STRONG>"
				Response.Write "</TD>"
				Response.Write "<TD><FONT SIZE=" & nFontSize & "><STRONG>Dept.</STRONG>"
				Response.Write "</TD>"
				Response.Write "<TD><FONT SIZE=" & nFontSize & "><STRONG>Email Address</STRONG>"
				Response.Write "</TD>"
				Response.Write "<TD><FONT SIZE=" & nFontSize & "><STRONG>User Type</STRONG>"
				Response.Write "</TD>"
				Response.Write "<TD><FONT SIZE=" & nFontSize & "><STRONG>Company Name</STRONG>"
				Response.Write "</TD>"
				Response.Write "</TR>"
	
				do while oRs.EOF = FALSE
					Response.Write "<TR>"
					Response.Write "<TD><FONT SIZE=" & nFontSize & "><a href='edituser_int.asp?UID=" & oRs("UserID") & "'>&nbsp;" & oRs("LastName") & "</a>"
					Response.Write "</TD>"
					Response.Write "<TD><FONT SIZE=" & nFontSize & ">&nbsp;" & oRs("FirstName")
					Response.Write "</TD>"
					Response.Write "<TD><FONT SIZE=" & nFontSize & ">&nbsp;" & oRs("UserName")
					Response.Write "</TD>"
					Response.Write "<TD><FONT SIZE=" & nFontSize & ">&nbsp;" & oRs("Postition")
					Response.Write "</TD>"
					Response.Write "<TD><FONT SIZE=" & nFontSize & ">&nbsp;" & oRs("TeamName")
					Response.Write "</TD>"
					Response.Write "<TD><FONT SIZE=" & nFontSize & ">&nbsp;" & oRs("Department")
					Response.Write "</TD>"
					Response.Write "<TD><A HREF='mailto:" & oRs("EmailAddress") & "'><FONT SIZE=" & nFontSize & ">&nbsp;" & oRs("EmailAddress") & "</a>"
					Response.Write "</TD>"
					Response.Write "<TD><FONT SIZE=" & nFontSize & ">&nbsp;" & oRs("UserType")
					Response.Write "</TD>"
					'Response.Write "<TD><a href='companysrch_userchangeco.asp?UFN=" & oRs("FirstName") & "&ULN=" & oRs("LastName") & "&CONM=" & oRs("CompanyName") & "&UID=" & oRs("UserID") & "'><FONT SIZE=" & nFontSize & "><FONT SIZE=" & nFontSize & ">&nbsp;" & oRs("CompanyName") & "</a>"
					Response.Write "<TD><FONT SIZE=" & nFontSize & "><a href='editcompany.asp?CID=" & oRs("CompanyID") & "'>" & oRs("CompanyName") & "</a>"
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
