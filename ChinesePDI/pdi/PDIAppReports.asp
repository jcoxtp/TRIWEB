<%@ Language=VBScript %>
<% Response.Buffer = TRUE %>
<!--#INCLUDE FILE="include/common.asp" -->
<% pageID = "appReports" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | PDI Application Modules</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
<div id="maincontent">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td valign="top"><img src="images/disc_profile.gif"></td>
		<td valign="top" align="right"><!--#INCLUDE FILE="include/back_link.asp" --></td>		
	</tr>
</table>
<p>The <!--#INCLUDE FILE="include/disc.asp" --> includes a series of application reports that will guide you in applying the insights from your DISC profile to specific situations. Your profile will be securely saved, allowing you to return to the site and purchase application reports at a later time. These reports provide additional information about each behavioral style as it relates to a specific area and suggest how you can immediately apply this information to yourself and others.</p>
<p>Five application reports are available. Click on a title to read more about that report.</p>
<div align="center">
<table class="addtable" border="0" cellspacing="0" cellpadding="0" width="85%">
	<tr>
		<td valign="top" align="center" width="33%">
			<a href="PDIAppReports_teamwork.asp?res=<%=intResellerID%>"><img src="images/teamws_thumb.gif" alt="" width="100" height="137" /></a><br />
			<a href="PDIAppReports_teamwork.asp?res=<%=intResellerID%>"><strong>Teamwork with Style<sup>&reg;</sup></strong></a>
		</td>
		<td valign="top" align="center" width="33%">
			<a href="PDIAppReports_leading.asp?res=<%=intResellerID%>"><img src="images/lws_thumb.gif" alt="" width="100" height="137" /></a><br />
			<a href="PDIAppReports_leading.asp?res=<%=intResellerID%>"><strong>Leading with Style<sup>&reg;</sup></strong></a>
		</td>
		<td valign="top" align="center">
			<a href="PDIAppReports_communicating.asp?res=<%=intResellerID%>"><img src="images/cws_thumb.gif" alt="" width="100" height="137" /></a><br />
			<a href="PDIAppReports_communicating.asp?res=<%=intResellerID%>"><strong>Communicating with Style<sup>&reg;</sup></strong></a>
		</td>
	</tr>
</table>
</div>
<div align="center">
<table class="addtable" border="0" cellspacing="0" cellpadding="0" width="85%">				
	<tr>
		<td valign="top" align="center" width="50%">
			<a href="PDIAppReports_selling.asp?res=<%=intResellerID%>"><img src="images/sws_thumb.gif" alt="" width="100" height="137" /></a><br />
			<a href="PDIAppReports_selling.asp?res=<%=intResellerID%>"><strong>Selling with Style<sup>&reg;</sup></strong></a>
		</td>
		<td valign="top" align="center">
			<a href="PDIAppReports_time.asp?res=<%=intResellerID%>"><img src="images/tws_thumb.gif" alt="" width="100" height="137" /></a><br />
			<a href="PDIAppReports_time.asp?res=<%=intResellerID%>"><strong>Time Management with Style<sup>&reg;</sup></strong></a>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
