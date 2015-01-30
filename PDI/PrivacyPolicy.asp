<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 10	' Privacy Policy Page
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
    <div id="main">

<div id="maincontent">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td valign="top"><h1><%=strTextPrivacyPolicy%></h1></td>
		<td valign="top" align="right"><!--#Include file="Include/BackLink.asp" --></td>
	</tr>
</table>

<%
If intResellerID = 2 Then
	Response.Write "<p>" & strTextPrivacyPolicyPar1a & "</p>"
Else
	If strSiteType <> "Focus3" Then
		Response.Write "<p>" & strTextPrivacyPolicyPar1b & "</p>"
	Else
		Response.Write "<p>Focus3, the sponsor of this site, cares about how your personal information is used.</p>"
	End If
End If
Response.Write "<p>" & OurPrivacyPolicyIsAsFollows & "</p>"
Response.Write "<ul>"
Response.Write "<li>" & strTextPrivacyPolicyPar2
Response.Write " <a href=""http://www.authorize.net"" target=""_blank"">Authorize.net</a> "
Response.Write strTextPrivacyPolicyPar3 & "</li>"
Response.Write "<li>" & strTextPrivacyPolicyPar4 & "</li>"
If intResellerID = 2 Then
	Response.Write "<li>" & strTextPrivacyPolicyPar5a & "</li>"
Else
	Response.Write "<li>" & strTextPrivacyPolicyPar5a & "</li>"
End If
Response.Write "<li>" & strTextPrivacyPolicyPar6 & "</li>"
%>
</ul>
</div>
    </div>

</body>
</html>
