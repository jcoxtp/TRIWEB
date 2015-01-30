<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 31	' PDI Profile Bypass PDI Page
	Dim TRUserID
	TRUserID = Request.Cookies("UserID")
%>
<!--#Include file="Include/CheckLogin.asp" -->
<!--#Include file="Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
	<!--#Include file="Include/HeadStuff.asp" -->
</head>
<body>
<!--#Include file="Include/TopBanner.asp" -->
    <div id="main">

<div id="maincontent">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td valign="top"><h1><%=strTextIAlreadyKnowMyDISCStyle%></h1></td>
		<td valign="top" align="right"><!--#Include file="Include/BackLink.asp" --></td>
	</tr>
</table>
	<p><%=strTextIfYouHaveAlreadyTakenDISCAndRemember%></p>		

	<!--#Include File="Include/divider.asp" -->
	<h2><%=strTextIAlreadyKnowMyDISCStyle%></h2>
	<p><a href="PDIProfileBypassPDI1.asp?res=<%=intResellerID%>"><%=strTextSelectMyStyleAndPurchaseAnApplicationReport%></a></p>

	<!--#Include FIle="Include/divider.asp" -->
	<h2><%=strTextIDontKnowMyDISCStyle%></h2>
	<p><a href="purchasetest.asp?res=<%=intResellerID%>"><%=strTextPurchaseThePersonalDISCernmentInventory%></a></p>
<% '========================================================================================================= %>
</div>

    </div>
</body>
</html>
