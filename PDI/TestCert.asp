<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
'	On Error Resume Next
	intPageID = 28	' Credit Card Information Collection Page
%>
<!--#Include file="Include/CheckLogin.asp" -->
<!--#Include file="Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--#include virtual="include/forceSSL.inc"-->
<html>
 <head>
  <title>Certificate Testing</title> 
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">

	<!--#Include file="Include/HeadStuff.asp" -->

<%
'WARNING: The Google Analytics script source disables the SSL page security. Remove this script from secure pages.
'<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
'</script>
'<script type="text/javascript">
'_uacct = "UA-368995-2";
'urchinTracker();
'</script>
%>

<script language="JavaScript">

function goBack() {
	document.thisForm.action = "PurchaseTest.asp";
	document.thisForm.submit();
}

function makeBillable() {
	document.Billable.action = "./Admin/BillablePurchase.asp?res=<%=intResellerID%>&pid=<%=intPurchaseID%>";
	document.Billable.submit();	
}

</script>

 </head>
 <body>
<!--#Include FILE="simlib.asp"-->
<!--#Include file="Include/TopBanner.asp" -->

<div id="maincontent">
	This ASP page is secure.
<script src="https://siteseal.thawte.com/cgi/server/thawte_seal_generator.exe">
</div>
</script> 
<% 
Dim strURL
strURL= "https://"
strURL= strURL& Request.ServerVariables("SERVER_NAME")
strURL= strURL& Request.ServerVariables("URL")
Response.Write strURL
%>
 </body>
</html>