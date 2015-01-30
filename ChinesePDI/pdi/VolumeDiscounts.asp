<%@ Language=VBScript %>
<% Response.Buffer = TRUE %>
<!--#INCLUDE FILE="include/common.asp" -->
<% pageID = "discounts"
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Volume Discounts</title>
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
				<td valign="top"><img src="images/volume_discounts.gif"></td>
				<td valign="top" align="right"><!--#INCLUDE FILE="include/back_link.asp" --></td>		
			</tr>
		</table>
		<p>You can purchase multiple copies of the <!--#INCLUDE FILE="include/pdi.asp" --> and application reports to take advantage of volume discounts. When you make a purchase, you will be issued profile codes that will provide easy and immediate access, so that you and others may log in and complete the <!--#INCLUDE FILE="include/pdi.asp" --> at your convenience.</p>
		<p>Please <a href="contact_us.asp?res=<%=intResellerID%>">contact us</a> for more information on volume pricing.</p>
	</div>
</body>
</html>
