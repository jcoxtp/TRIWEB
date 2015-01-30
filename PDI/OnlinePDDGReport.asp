<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 6	' Online PDIReport Page
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
	<!--#Include file="Include/HeadStuff.asp" -->
</head>
<body>
<!--#Include file="Include/TopBanner.asp" -->

<div id="maincontent">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td valign="top"><h1><%=strTextPageTitle%></h1></td>
		<td valign="top" align="right"><!--#Include file="Include/BackLink.asp" --></td>
	</tr>
</table>
<table class="addtable" border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td valign="top">
			<p><%=strTextTakingThePersonalDISC%></p>
			<p><%=strTextToTakeTheInstrument%></p>
			<ul>
				<li><%=strTextThreeDifferentGraphs%></li>
				<li><%=strTextAnOverviewOfYourPrimary%></li>
				<li><%=strTextARepresentativeProfile%></li>
				<li><%=strTextAnOverviewOfTheStrengths%></li>
			</ul>
			<p>Also, you will be given a Dream Assessment report that helps you understand the obstacles you will likely face and the opportunities for fulfilling your dreams based on your personality type.</p>
		</td>
		<td valign="top" align="center" style="left-margin:12px">
			<strong><%=strTextSpecialistProfile%></strong><br />
			<a href="javascript:openAnyWindow('RepProfile.asp','Sample',175,350)"><img src="images/RepProfile13_small.jpg" alt="" width="80" height="195" /></a><br/>
			<span class="captiontext"><%=strTextClickImageForEnlargedView%></span>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
