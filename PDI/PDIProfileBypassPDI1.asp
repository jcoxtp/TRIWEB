<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 32	' PDI Profile Bypass PDI Page 1
	Dim TRUserID
	TRUserID = Request.Cookies("UserID")
%>
<!--#Include file="Include/CheckLogin.asp" -->
<!--#Include file="Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextSelectYourPrimaryBehavioralCharacteristic%></title>
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
		<td valign="top"><h1><%=strTextSelectYourPrimaryBehavioralCharacteristic%></h1></td>
		<td valign="top" align="right"><!--#Include file="Include/BackLink.asp" --></td>
	</tr>
</table>
    		<form name="thisForm" id="thisForm" method="post" action="PDIProfileBypassPDI2.asp?res=<%=intResellerID%>">

	<table border="0" cellspacing="0" cellpadding="3" width="100%">
		<tr>
			<td><input type="radio" name="HP1" value="D"></td>
			<td><b><%=strTextDominance%></b></td>
			<td><%=strTextTheDriveToControl%></td>
		</tr>
		<tr>
			<td><input type="radio" name="HP1" value="I"></td>
			<td><b><%=strTextInfluence%></b></td>
			<td><%=strTextTheDriveToInfluence%></td>
		</tr>
		<tr>
			<td><input type="radio" name="HP1" value="S"></td>
			<td><b><%=strTextSteadiness%></b></td>
			<td><%=strTextTheDriveToBeStable%></td>
		</tr>
		<tr>
			<td><input type="radio" name="HP1" value="C"></td>
			<td><b><%=strTextConscientiousness%></b></td>
			<td><%=strTextTheDriveToBeRight%></td>
		</tr>
		<tr>
			<td colspan=100%>
				<br>
				<input type="submit" name="<%=Application("strTextSubmit" & strLanguageCode)%>" value="Submit">
			</td>
		</tr>
	</table>
                		</form>

</div>
    </div>
</body>
</html>
