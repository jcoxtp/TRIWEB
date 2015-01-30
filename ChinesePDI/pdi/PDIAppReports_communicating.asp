<%@ Language=VBScript %>
<% Response.Buffer = TRUE %>
<!--#INCLUDE FILE="include/common.asp" -->
<% pageID = "appReports_Comm" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Communicating With Style&reg;</title>
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
		<td valign="top"><h1><!--#INCLUDE FILE="include/disc.asp" --> Customized Application Reports</h1></td>
		<td valign="top" align="right"><!--#INCLUDE FILE="include/back_link.asp" --></td>
	</tr>
</table>

<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr>
		<td valign="top" align="center"><img src="images/cws_thumb.gif" alt="" width="100" height="137" /></td>
		<td valign="top">
			<h2>Communicating with Style<sup>&reg;</sup></h2>
									
			<p>This module will help you recognize how your personal communication style enhances or impedes the messages that you send and receive from others. In addition, you will learn to identify the styles of those receiving your messages, and discover ways to adapt your style to meet their needs. As a result, you will greatly improve the effectiveness of your written and spoken communication in a variety of situations.</p>
		</td>
	</tr>
</table>
						
<div align="center">
<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="450">
	<tr>
		<td valign="middle" align="center"><span class="headertext2">Sample 1</span></td>
		<td valign="middle" align="center"><span class="headertext2">Sample 2</span></td>
	</tr>
	<tr>
		<td valign="middle" align="center"><a href="javascript:openAnyWindow('PDIAppReports_communicating_sample1.asp?res=<%=intResellerID%>','Sample',525,550)"><img src="images/communicatingstyle_sample1_sm.gif" class="imageborder" alt="" width="200" height="254" /></a><br />
			<span class="captiontext">Click image for enlarged view</span>
		</td>
		<td valign="middle" align="center"><a href="javascript:openAnyWindow('PDIAppReports_communicating_sample2.asp?res=<%=intResellerID%>','Sample',525,550)"><img src="images/communicatingstyle_sample2_sm.gif" class="imageborder" alt="" width="200" height="254" /></a><br />
			<span class="captiontext">Click image for enlarged view</span>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
