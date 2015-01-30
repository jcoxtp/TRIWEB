<%@ Language=VBScript %>
<% Response.Buffer = TRUE %>
<!--#INCLUDE FILE="include/common.asp" -->
<% pageID = "onlinePDIReport" %>

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
		<td valign="top"><img src="images/online.gif"></td>
		<td valign="top" align="right"><!--#INCLUDE FILE="include/back_link.asp" --></td>		
	</tr>
</table>
<table class="addtable" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr> 
		<td valign="top">
			<p>Taking the <!--#INCLUDE FILE="include/pdi.asp" --> (PDI) online provides a quick, easy method of gaining powerful insight into your behavioral style in both work and social settings.</p><p>To take the instrument, you will answer 24 short questions that describe your tendencies. You can then view, save, and print a comprehensive report that provides:</p>
			<ul>
				<li>Three different graphs of your DISC Profile for a balanced explanation of your personality</li>
				<li>An overview of your primary and secondary behavioral styles</li>
				<li>A Representative Profile that shows how all four DISC elements create your unique behavioral style</li>
				<li>An overview of the strengths and weaknesses that may affect your style, with some broad suggestions on how to leverage your strengths and deflect your weaknesses</li>
			</ul>
			<p>After taking the inventory, you may also receive additional customized <a href="PDIAppReports.asp?res=<%=intResellerID%>">reports</a> that allow you to specifically apply these insights to the areas of leadership, communication, teamwork, sales, and time management.</p><p>Volume discounts are available when you purchase multiple inventories or application reports. Please contact us for more information.</p>
<% If intResellerID = 2 Then %>
			<p>The <!--#INCLUDE FILE="include/pdi.asp" --> is $20.</p>
<% Else %>
			<p>The <!--#INCLUDE FILE="include/pdi.asp" --> is <!--#INCLUDE FILE="include/pdf_price.asp" -->. <a href="PDIAppReports.asp?res=<%=intResellerID%>"">Application reports</a> are <!--#INCLUDE FILE="include/app_price.asp" --> each.</p>
<% End If %>
		</td>

		<td valign="top" align="center" style="left-margin:12px">
			<strong>Specialist Profile</strong><br />
			<a href="javascript:openAnyWindow('RepProfile.asp','Sample',175,350)"><img src="images/RepProfile13_small.jpg" alt="" width="80" height="195" /></a><br/>
			<span class="captiontext">Click image for enlarged view</span>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
