<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	'On Error Resume Next
	intPageID = 55	' Possible Strengths Page
	Dim TestCodeID, nextLink
	TestCodeID = Request.QueryString("TCID")
%>
<!--#Include file="Include/CheckLogin.asp" -->
<!--#Include file="Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
<!--<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>-->
	<!--#Include file="Include/HeadStuff.asp" -->
</head>
<body>
<!--#Include file="Include/TopBanner.asp" -->
    <div id="main">

<div id="tabgraphic">
	<img src="images/S5P1<%=strLanguageCode%>.gif" width="692" height="82" alt="" usemap="#tab" />
	<map name="tab">
		<area shape="poly" alt="" coords="567,53,607,53,613,58,610,65,565,65,550,58,568,53,570,53" href="PDIProfileCustom.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>&lid=<%=intLanguageID%>">
		<area shape="poly" alt="" coords="624,53,662,53,677,59,663,65,625,66,616,60,623,53,625,53" href="PDIProfileSANDW1.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>&lid=<%=intLanguageID%>">
	</map>
</div>
<div id="maincontent_tab">
	<h1><%=strTextStrengthsAndWeaknesses%></h1>
	<table class="addtable" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr> 
			<td valign="top">
				<p><%=strTextEveryonesPersonalityContainsBothStrengthsAnd%></p>
				<p><%=strTextOnTheNextTwoPagesYouWillSeeYourComposite%></p>
			</td>
			<td valign="top" align="center" style="padding-left:6px"><img src="images/SW_strength_chart_small.gif" alt="" width="249" height="313" /><br/>
					<span class="captiontext"><%=strTextToSeeALargerVersionOfYourGraphContinueTo%></span>
			</td>
		</tr>
	</table>
	<% If (SPN <> "0") And (oldButtons = True) Then %>
		<table border="0" cellspacing="0" cellpadding="0" width="570">
			<tr>
				<td align="right">
					<a HREF="PDIProfileRepProfile2.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>"><img SRC="images/PDIPrevPage.gif" alt="" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a HREF="PDIProfileSANDW2.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>"><img SRC="images/PDINextPage.gif" alt="" /></a>
				</td>
			</tr>
		</table>
	<% End If %>
</div>
        </div>
</body>
</html>
