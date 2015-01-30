<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/checklogin.asp" -->
<!--#INCLUDE FILE="include/common.asp" -->
<%
pageID = "repProfile1"
Dim TestCodeID
TestCodeID = Request.QueryString("TCID")
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"     "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Representative Profile</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
<div id="tabgraphic">
	<img src="images/s4p1.gif" width="692" height="82" alt="" usemap="#tab" />
	<map name="tab">
		<area shape="poly" alt="" coords="567,53,607,53,613,58,610,65,565,65,550,58,568,53,570,53" HREF="PDIProfileBehavioralChar2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>">
		<area shape="poly" alt="" coords="624,53,662,53,677,59,663,65,625,66,616,60,623,53,625,53" HREF="PDIProfileRepProfile2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>">
	</map>
</div>
<div id="maincontent_tab">
	<table class="addtable" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr> 
			<td valign="top">
				<p>
				Every personality contains all four styles to some degree, even though some elements are high and others low. The particular ways in which the four factors combine and influence one another form a "representative" behavioral style, which we call the <strong>Representative Pattern</strong>. This style reflects most clearly how others see you.
				</p>
	
				<p>
				There is almost an infinite variety of combinations, but typical behavioral styles fall within a relatively small number of patterns. Here is your opportunity to choose one that matches your specific results.
				</p>
	
				<p>
				On the following page, you will see a larger version of the graph on the right. Review your composite graph and select the pattern which best matches your graph. It does not have to be exactly the same shape, but pay particular attention to which elements (D, I, S, and C) are above or below the center line.
				</p>
			</td>
			
			<td valign="top" align="center" style="padding-left:6px"><img src="images/RepProfile21ChartWithFlat.gif" alt=""  /><br/>
					<span class="captiontext">To see a larger version of this graph and choose your Representative Pattern, continue to the next page.</span>
			</td>
		</tr>
	</table>
	
	<%	if oldButtons = true then %>
	
	<table border="0" cellspacing="0" cellpadding="0" width="570">
			<tr>
				<td align="right">
					<a HREF="PDIProfileBehavioralChar2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>"><img SRC="images/PDIPrevPage.gif" alt="" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a HREF="PDIProfileRepProfile2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>"><img SRC="images/PDINextPage.gif" alt="" /></a>
				</td>
			</tr>
	</table>
	
	<%	end if %>
</div>
</body>
</html>
