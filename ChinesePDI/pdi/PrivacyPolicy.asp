<%@ Language=VBScript %>
<% Response.Buffer = TRUE %>
<!--#INCLUDE FILE="include/common.asp" -->
<%
pageID = "privacy"
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Privacy Policy</title>
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
		<td valign="top"><img src="images/privacy.gif"></td>
		<td valign="top" align="right"><!--#INCLUDE FILE="include/back_link.asp" --></td>		
	</tr>
</table>
						
<p>
<% If intResellerID = 2 Then %>
<!--#INCLUDE FILE="include/company_name.asp" -->, the publisher of the <!--#INCLUDE FILE="include/pdi.asp" -->, as well as Global Vision Resources and Bruce Wilkinson, understand that you care about how your personal information is used.
<% Else %>
<!--#INCLUDE FILE="include/company_name.asp" -->, the sponsor of this site and publisher of the <!--#INCLUDE FILE="include/pdi.asp" -->, understands that you care about how your personal information is used.
<% End If %>
</p>

<p>Our privacy policy is as follows:</p>

<ul>
	<li>Information you share to purchase the <!--#INCLUDE FILE="include/pdi.asp" --> report (e.g., credit card numbers, name, billing address, etc.) is sent directly to <a href="http://www.authorize.net" target="_blank">Authorize.net</a> for processing and approval. Authorize.net is a highly secure, credible credit processing firm used by many of the most reputable web vendors. This data is not retained on our servers.</li>
	<li>Information used in generating your <!--#INCLUDE FILE="include/pdi.asp" --> report (e.g., answers to specific word choices) as well as any voluntary demographic information you choose to share is stored on our secure server. It will be retained in anonymous summary form and used for research with the objective of developing new and more effective educational tools to teach people about themselves and others.</li>
<% If intResellerID = 2 Then %>
	<li>Your actual profile report will be retained in our database so that you can access it at any time using your unique username and password. You will be able to review it on-screen or save it to your hard disk for ongoing reference. 
<% Else %>
	<li>Your actual profile report will be retained in our database so that you can access it at any time using your unique username and password. You will be able to review it on-screen or save it to your hard disk for ongoing reference. If you would like to purchase application reports tailored for your specific temperament, you will be able to do so without incurring the time and cost of retaking the <!--#INCLUDE FILE="include/pdi.asp" -->.</li>
<% End If %>
	<li>Under no circumstances will <!--#INCLUDE FILE="include/company_name.asp" --> share or sell your data <strong>in any form</strong> to other organizations.</li>
</ul>
</div>
</body>
</html>
