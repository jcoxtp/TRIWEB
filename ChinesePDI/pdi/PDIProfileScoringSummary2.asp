<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/checklogin.asp" -->
<!--#INCLUDE FILE="include/common.asp" -->
<%
pageID = "scoringSummary"
Dim TestCodeID, nextLink
TestCodeID = Request.QueryString("TCID")
nextLink = "PDIProfileBehavioralChar1.asp?TCID=" & TestCodeID & "&res=" & intResellerID
Dim oConn, oCmd, oRs ' [SM] To avoid redefinition errors in condensed summary
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | PDI Profile Summary</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->

<div id="tabgraphic">
	<img src="images/s2p1.gif" width="692" height="82" alt="" usemap="#tab" />
	<map name="tab">
		<area shape=poly alt="" coords="622,53,663,53,678,60,663,66,621,66,615,58,622,53,625,53" href="PDIProfileBehavioralChar1.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>">
	</map>
</div>
<div id="maincontent_tab">
	<!--#INCLUDE FILE="include/PDIProfileScoringSummary2Body.asp" -->
</div>
</body>
</html>
