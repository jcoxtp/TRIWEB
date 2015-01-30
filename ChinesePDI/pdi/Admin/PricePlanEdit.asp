<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/CheckAdminLogin.asp" -->
<!--#INCLUDE FILE="../include/common.asp" -->
<!--#INCLUDE FILE="include/DateTimeFunctions.asp" -->
<%
	pageID = ""
	If Not IsAuthorized(4) Then 
		Response.Redirect("/pdi/login.asp?res=" & intResellerID)
	End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Admin Area</title>
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<link rel="stylesheet" href="admin.css" type="text/css">
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
		' Receive Incoming Vars
		PricePlanResellerID = Request("PPres")
			If Not PricePlanResellerID > 0 Then
				PricePlanResellerID = 0
			End If
		
		%>
		<h1>Page Heading...</h1>
		<hr>
	</div>
</body>
</html>
