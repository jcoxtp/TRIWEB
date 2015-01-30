<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 7	' PDI App Report Page
%>
<!--#Include file="Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="generator" content="BBEdit 7.0.1">
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

<div id="maincontent">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td valign="top"><h1><%=Application("strTextDISCProfile" & strLanguageCode) & " " & Application("strTextSystem" & strLanguageCode) & "<sup>&reg;</sup> " & strTextCustomizedApplicationReports%></h1></td>
		<td valign="top" align="right"><!--#Include file="Include/BackLink.asp" --></td>
	</tr>
</table>
<p><%=Application("strTextThe" & strLanguageCode) & " " & Application("strTextDISCProfile" & strLanguageCode) & " " & Application("strTextSystem" & strLanguageCode) & "<sup>&reg;</sup> " & strTextIncludesASeriesOfApplicationReports%></p>
<p><%=strTextFiveApplicationReportsAreAvailable%></p>

<div align="center">
<table class="addtable" border="0" cellspacing="0" cellpadding="0" width="85%">
	<tr>
		<td valign="top" align="center" width="33%">
			<a href="PDIAppReportsTeamwork.asp?res=<%=intResellerID%>"><img src="images/teamws_thumb.gif" alt="" width="100" height="137" /></a><br />
			<a href="PDIAppReportsTeamwork.asp?res=<%=intResellerID%>"><strong><%=strTextTeamworkWithStyle%><sup>&reg;</sup></strong></a>
		</td>
		<td valign="top" align="center" width="33%">
			<a href="PDIAppReportsLeading.asp?res=<%=intResellerID%>"><img src="images/lws_thumb.gif" alt="" width="100" height="137" /></a><br />
			<a href="PDIAppReportsLeading.asp?res=<%=intResellerID%>"><strong><%=strTextLeadingWithStyle%><sup>&reg;</sup></strong></a>
		</td>
		<td valign="top" align="center">
			<a href="PDIAppReportsCommunicating.asp?res=<%=intResellerID%>"><img src="images/cws_thumb.gif" alt="" width="100" height="137" /></a><br />
			<a href="PDIAppReportsCommunicating.asp?res=<%=intResellerID%>"><strong><%=strTextCommunicatingWithStyle%><sup>&reg;</sup></strong></a>
		</td>
	</tr>
</table>
</div>
<div align="center">
<table class="addtable" border="0" cellspacing="0" cellpadding="0" width="85%">				
	<tr>
		<td valign="top" align="center" width="50%">
			<a href="PDIAppReportsSelling.asp?res=<%=intResellerID%>"><img src="images/sws_thumb.gif" alt="" width="100" height="137" /></a><br />
			<a href="PDIAppReportsSelling.asp?res=<%=intResellerID%>"><strong><%=strTextSellingWithStyle%><sup>&reg;</sup></strong></a>
		</td>
		<td valign="top" align="center">
			<a href="PDIAppReportsTime.asp?res=<%=intResellerID%>"><img src="images/tws_thumb.gif" alt="" width="100" height="137" /></a><br />
			<a href="PDIAppReportsTime.asp?res=<%=intResellerID%>"><strong><%=strTextTimeManagementWithStyle%><sup>&reg;</sup></strong></a>
		</td>
	</tr>
</table>
</div>
<% If intResellerID = 15 Then %>
<div align="center">
<table class="addtable" border="0" cellspacing="0" cellpadding="0" width="85%" ID="Table1">				
	<tr>
		<td valign="top" align="center" width="50%">
			<a href="PDIAppReportsAdvising.asp?res=<%=intResellerID%>"><img src="images/aws_thumb.gif" alt="" width="100" height="137" style="margin-bottom:5px" /></a><br />
			<a href="PDIAppReportsAdvising.asp?res=<%=intResellerID%>"><strong>Advising with Style<sup>&reg;</sup></strong></a>
		</td>
	</tr>
</table>
</div>
<% End If %>
</div>
</body>
</html>
