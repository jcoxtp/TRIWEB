<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/checklogin.asp" -->
<!--#INCLUDE FILE="include/common.asp" -->
<%
 pageID = "sandw"

Dim TestCodeID
TestCodeID = Request.QueryString("TCID")
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Possible Strengths</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
<div id="tabgraphic">
	<img src="images/s5p1.gif" width="692" height="82" alt="" usemap="#tab" />
	<map name="tab">
		<area shape="poly" alt="" coords="567,53,607,53,613,58,610,65,565,65,550,58,568,53,570,53" href="PDIProfileCustom.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>">
		<area shape="poly" alt="" coords="624,53,662,53,677,59,663,65,625,66,616,60,623,53,625,53" href="PDIProfileSANDW1.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>">
	</map>
</div>
<div id="maincontent_tab">
	
	<h1>Strengths and Weaknesses</h1>
	
	<table class="addtable" border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr> 
			<td valign="top">
				<p>
				Everyone's personality contains both strengths and weaknesses. In many cases, our weaknesses are simply our strengths taken to their extremes. Identifying these strengths and weaknesses is a key step to personal growth.
				</p>
	
				<p>
				On the next two pages you will see your composite graph overlayed on words that describe your probable strengths and possible weaknesses. Read the words in the boxed sections to identify those traits.
				</p>
			</td>
			
			<td valign="top" align="center" style="padding-left:6px"><img src="images/SW_strength_chart_small.gif" alt="" width="249" height="313" /><br/>
					<span class="captiontext">To see a larger version of your graph, continue to the next page (this is a sample graph).</span>
			</td>
		</tr>
	</table>
	
	<% if (SPN <> "0") and (oldButtons = true) then %>
		
		<table border="0" cellspacing="0" cellpadding="0" width="570">
			<tr>
				<td align="right">
					<a HREF="PDIProfileRepProfile2.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>"><img SRC="images/PDIPrevPage.gif" alt="" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a HREF="PDIProfileSANDW2.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>"><img SRC="images/PDINextPage.gif" alt="" /></a>
				</td>
			</tr>
		</table>
		
	<% end if %>
	
	
</div>
</body>
</html>
