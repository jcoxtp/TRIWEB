<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/checklogin.asp" -->
<!--#INCLUDE FILE="include/common.asp" -->
<%
	Dim TRUserID
	TRUserID = Request.Cookies("UserID")
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | PDI Profile Questions 1</title>
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
			<td valign="top"><h1>I Already Know my DISC Style</h1></td>
			<td valign="top" align="right"><a href="main.asp?res=<%=intResellerID%>"><img src="images/back.gif" alt="" width="73" height="16" /></a></td>
		</tr>
	</table>
	<p>
		If you have already taken DISC and remember your style, you can select D, I, S, or C and 
		purchase a customized application report without retaking the DISC assessment.	
	</p>		

	<!--#INCLUDE FILE="include/divider.asp" -->
	<h2>I already know my DISC style</h2>
	<p>
		 <a href="PDIProfile_DiamondLane1.asp?res=<%=intResellerID%>">Select my style and purchase an application report</a>
	</p>

	<!--#INCLUDE FILE="include/divider.asp" -->
	<h2>I don't know my DISC style</h2>
	<p>
		 <a href="purchasetest.asp?res=<%=intResellerID%>">Purchase the Personal DISCernment Inventory</a>
	</p>
<% '========================================================================================================= %>
</div>
</body>
</html>
