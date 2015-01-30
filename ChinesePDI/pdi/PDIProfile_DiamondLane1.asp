<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/checklogin.asp" -->
<!--#INCLUDE FILE="include/common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | PDI Profile Questions 1</title>
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
<div id="maincontent">
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td valign="top"><h1>Select Your Primary Behavioral Characteristic</h1></td>
			<td valign="top" align="right"><a href="PDIProfile_DiamondLane.asp?res=<%=intResellerID%>"><img src="images/back.gif" alt="" width="73" height="16" /></a></td>
		</tr>
	</table>
	<table border="0" cellspacing="0" cellpadding="3" width="100%">
		<form name="thisForm" id="thisForm" method="post" action="PDIProfile_DiamondLane2.asp?res=<%=intResellerID%>">
		<tr>
			<td><input type="radio" name="HP1" value="D"></td>
			<td><b>Dominance</b></td>
			<td>The drive to control, to achieve results. The basic intent is to overcome.</td>
		</tr>
		<tr>
			<td><input type="radio" name="HP1" value="I"></td>
			<td><b>Influence</b></td>
			<td>The drive to influence, to be expressive, to be heard. The basic intent is to persuade.</td>
		</tr>
		<tr>
			<td><input type="radio" name="HP1" value="S"></td>
			<td><b>Steadiness</b></td>
			<td>The drive to be stable and consistent. The basic intent is to support.</td>
		</tr>
		<tr>
			<td><input type="radio" name="HP1" value="C"></td>
			<td><b>Conscientiousness</b></td>
			<td>The drive to be right, sure and safe. The basic intent is to be correct.</td>
		</tr>
		<tr>
			<td colspan=100%>
				<br>
				<input type="submit" name="Submit" value="Submit">
			</td>
		</tr>
		</form>
	</table>
</div>
</body>
</html>
