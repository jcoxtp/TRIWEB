<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/checklogin.asp" -->
<!--#INCLUDE FILE="include/common.asp" -->

<% dim pageTitle, TestCodeID, profileID, profileName
pageID = "profileDesc"
profileID = Request.QueryString("pID")
profileName = Request.QueryString("pName")
TestCodeID = Request.QueryString("TCID")
pageTitle = "DISC Profile System | Profile Description: " & profileName
Dim oConn, oCmd, oRs ' [SM] To avoid redefinition errors in condensed summary
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=pageTitle%></title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->

<div id="tabgraphic">
	<img src="images/s4p4.gif" width="692" height="82" alt="" usemap="#tab" />
	<map name="tab">
		<area shape=poly alt="" coords="633,53,672,53,680,59,673,65,632,66,617,59,634,53,637,53" href="PDIProfileRepProfile2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>">
	</map>
</div>
<div id="maincontent_tab">
	<!--#INCLUDE FILE="include/PDIProfileRepProfileDesc_Body.asp" -->
</div>
</body>
</html>
