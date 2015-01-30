<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 74	' Financial Planning with Style Page
%>
<!--#Include file="Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Advising with Style</title>
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

<div id="maincontent">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td valign="top"><h1><%=strTextDISCProfileSystemRegMark & " " & strTextCustomizedApplicationReports%></h1></td>
		<td valign="top" align="right"><!--#Include file="Include/BackLink.asp" --></td>
	</tr>
</table>

<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr>
		<td valign="top" align="center"><img src="images/aws_thumb.gif" alt="" width="100" height="137" /></td>
		<td valign="top">
			<h2>Advising with Style<sup>&reg;</sup></h2>
			<P>The role of financial advisor goes well beyond leadership and providing 
				technical expertise. A very short list of the more typical responsibilities and 
				activities of a financial advisor might include the following:
			</P>
			<ul type="square">
				<li>
				<b>Business Development:</b><br>
				Networking, Handling Referrals, Establishing Relationships</li>
				<li>
				<b>Client Interaction:</b><br>
				Gathering Information<br>
				Delivering Plan and Gaining Alignment<br>
				Implementing Plan and Performing Ongoing Follow Through</li>
				<li>
				<b>Practice Management:</b><br>
				Hiring, Staff Development, Goal Setting, Dealing with Operational Issues</li>
			</ul>
			<P>This specially designed application module will provide insight into how the 
				strengths and weaknesses of your God-given temperament play out as you work 
				through the five responsibilities shown above. Not only that, but you will be 
				able to recognize the temperament of your clients and discern how best to 
				communicate, serve, and lead them based on their temperament, while at the same 
				time taking your own temperament into account. This module will help you apply 
				the insights that you gained from your Personal DISCernment Inventory<SUP style="FONT-SIZE: 8pt">®</SUP>
				to become effective in finding clients, serving them, and managing your 
				practice.
			</P>
		</td>
	</tr>
</table>
						
<div align="center">
<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="450">
	<tr>
		<td valign="middle" align="center"><span class="headertext2">Sample Text&nbsp;1</span></td>
		<td valign="middle" align="center"><span class="headertext2">Sample Text&nbsp;2</span></td>
	</tr>
	<tr>
		<td valign="middle" align="center"><a href="javascript:openAnyWindow('PDIAppReportsCommunicatingSample1.asp?res=<%=intResellerID%>','Sample',525,550)"><img src="images/communicatingstyle_sample1_sm.gif" class="imageborder" alt="" width="200" height="254" /></a><br />
			<span class="captiontext"><%=strTextClickImageForEnlargedView%></span>
		</td>
		<td valign="middle" align="center"><a href="javascript:openAnyWindow('PDIAppReportsCommunicatingSample2.asp?res=<%=intResellerID%>','Sample',525,550)"><img src="images/communicatingstyle_sample2_sm.gif" class="imageborder" alt="" width="200" height="254" /></a><br />
			<span class="captiontext"><%=strTextClickImageForEnlargedView%></span>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
