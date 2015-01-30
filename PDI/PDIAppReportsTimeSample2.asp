<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 27	' Communicating with Style Sample 2 Page
%>
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
<div class="center">
<table border="0" cellspacing="0" cellpadding="3">
	<tr>			
		<td valign="top"><img src="images/timestyle_sample2.gif" alt="" width="400" height="511" /></td>
		<td valign="top"><a href="PDIAppReportsTimeSample1.asp?res=<%=intResellerID%>"><img src="images/back.gif" alt="" width="73" height="16" /></a></td>
	</tr>
</table>
</div>
</body>
</html>
