<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 5	' DISCBackground Page
%>
<!--#Include file="Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Background: Dr. William M. Marston's Theory of Human Behavior</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
	<!--#Include FILE="Include/HeadStuff.asp" -->
</head>
<body>
<!--#Include FILE="Include/TopBanner.asp" -->
    <div id="main">
        <div id="maincontent">
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td valign="top"><h1><%=strTextPageTitle%></h1></td>
			<td valign="top" align="right"></td>
		</tr>
	</table>

	<p class="aligncenter"><img src="images/arrowchart<%= strLanguageCode %>.gif" alt="" width="570" height="350" /></p>

	<p><%=strTextDISCBackgroundPar1%></p>
	<p><%=strTextDISCBackgroundPar2%></p>
	<p><%=strTextDISCBackgroundPar3%></p>

	<div align="center">
		<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="570">
			<tr>
				<td valign="top" align="left" width="150"><span class="headertext">D</span>ominance (<%=strTextDominance%>)</td>
				<td valign="top" align="left"width="420"><%=strTextTheDriveToControl%></td>
			</tr>
			<tr>
				<td valign="top" align="left"><span class="headertext">I</span>nfluence (<%=strTextInfluence%>)</td>
				<td valign="top" align="left"><%=strTextTheDriveToInfluence%></td>
			</tr>
			<tr>
				<td valign="top" align="left"><span class="headertext">S</span>teadiness (<%=strTextSteadiness%>)</td>
				<td valign="top" align="left"><%=strTextTheDriveToBeStable%></td>
			</tr>
			<tr>
				<td valign="top" align="left"><span class="headertext">C</span>onscientiousness (<%=strTextConscientiousness%>)</td>
				<td valign="top" align="left"><%=strTextTheDriveToBeRight%></td>
			</tr>
		</table>
	</div>
</div>
    </div>
</body>
</html>
