<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/checklogin.asp" -->
<!--#INCLUDE FILE="include/common.asp" -->
<!--#INCLUDE FILE="include/PDIBehavioralRelationships.asp" -->
<%
pageID = "custom"
Dim TestCodeID
TestCodeID = Request.QueryString("TCID")
Dim oConn, oCmd, oRs ' [SM] To avoid redefinition errors in condensed summary
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Behavior Relationships</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
<div id="tabgraphic">
	<img src="images/s4p3.gif" width="692" height="82" alt="" usemap="#tab" />
	<map name="tab">
		<area shape="poly" alt="" coords="567,53,607,53,613,58,610,65,565,65,550,58,568,53,570,53" href="PDIProfileRepProfile2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>">
		<area shape="poly" alt="" coords="624,53,662,53,677,59,663,65,625,66,616,60,623,53,625,53" href="PDIProfileSANDW.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>">
	</map>
</div>
<div id="maincontent_tab">
	<!--#INCLUDE FILE="include/PDIProfileCustomBody.asp" -->
</div>
</body>
</html>
