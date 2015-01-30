<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
'	On Error Resume Next
	intPageID = 9	' Contact Us Page
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
<!--#Include file="Include/TopBanner.asp" -->
    <div id="main">

<div id="maincontent">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td valign="top"><h1><%=strTextContactUs%></h1></td>
		<td valign="top" align="right"><!--#Include file="Include/BackLink.asp" --></td>
	</tr>
</table>
<%=strTextWeWantToMakeItConvenientFor%>
<br><br>
<div align="center">

<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="85%">
	<tr>
		<td valign="top" align="center"><a href="mailto:info@teamresources.com"><img src="images/contact_email.gif" alt="" width="100" height="100" /></a>
		</td>
		<td valign="top" align="left"><h2><%=Application("strTextEmail" & strLanguageCode)%></h2>
			<a href="mailto:info@triaxiapartners.com"><%=strTextSend%></a> <%=strTextAnEmailToTeamResrouces%>
		</td>
	</tr>
	<tr>
		<td valign="top" align="center"><img src="images/contact_phone.gif" alt="" width="100" height="100" />
		</td>
		<td valign="top" align="left">
			<h2><%=strTextTelephone%></h2>
			1-800-214-3917 or 770-956-0985<br />
			<%=strTextAssistanceIsAvailableBetween%>
		</td>
	</tr>
	<tr>
		<td valign="top" align="center"><img src="images/contact_letter.gif" alt="" width="100" height="100" />
		</td>
		<td valign="top" align="left">
			<h2><%=strTextMail%></h2>
			900 Circle 75 Parkway<br />
            Suite 1650<br />
            Atlanta, GA 30339
		</td>
	</tr>
</table>
</div>
</div>
    </div>

</body>
</html>
