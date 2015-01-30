<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/checklogin.asp" -->
<!--#INCLUDE FILE="include/common.asp" -->
<%
pageID = "behavioralChar1"
Dim TestCodeID, nextLink
TestCodeID = Request.QueryString("TCID")
nextLink = "PDIProfileBehavioralChar2.asp?TCID=" & TestCodeID & "&res=" & intResellerID
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Behavioral Characteristics</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
<div id="tabgraphic">
	<img src="images/s3p1.gif" width="692" height="82" alt="" usemap="#tab" />
	<map name="tab">
		<area shape=poly alt="" coords="567,53,607,53,613,58,610,65,565,65,550,58,568,53,570,53" href="PDIProfileScoringSummary2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>">
		<area shape=poly alt="" coords="624,53,662,53,677,59,663,65,625,66,616,60,623,53,625,53" href="PDIProfileBehavioralChar2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>">
	</map>
</div>
<div id="maincontent_tab">
	
	<h1>History and Theory of DISC</h1>
	
	<p class="aligncenter">
	<img src="images/arrow_chart.gif" alt="" width="570" height="350" />
	</p>
	
	<p>
	Dr. William M. Marston, a Columbia University psychologist in the early 20th century, developed the theory of human behavior on which the <!--#INCLUDE FILE="include/pdi.asp" --> is based. Through his extensive research, he identified four major behavioral patterns that are present in all people, but to varying degrees.
	</p>
	
	<p>
	Most people tend to be either task-oriented or people-oriented. Another way to describe people is by their response to their environment. Some people are assertive or active; they want to shape or change their environment to better suit themselves. Others are more responsive; they tend to accept things as they are and try to do the best job possible within their environment. Using these four factors: task vs. people, assertive vs. responsive, we can place people into one of four quadrants.
	</p>
	
	<div align="center">
	<p class="addtable">
	<table class="imageborder" cellspacing="0" cellpadding="6" width="85%">
		<tr>
			<td valign="top" align="left"><span class="headertext">D</span>ominant: Task-oriented and assertive. This is the drive to control and achieve results. The basic intent of the "D" personality is to overcome.
			</td>
		</tr>
				
		<tr>
			<td valign="top" align="left"><span class="headertext">I</span>nfluential: People-oriented and assertive. This is the drive to be expressive and influence others. The basic intent of the "I" personality is to persuade.
			</td>
		</tr>
	
		<tr>
			<td valign="top" align="left"><span class="headertext">S</span>teady: People-oriented and responsive. This is the drive to be stable and consistent. The basic intent of the "S" personality is to support.
			</td>
		</tr>
	
		<tr>
			<td valign="top" align="left"><span class="headertext">C</span>onscientious: Task-oriented and responsive. This is the drive to be secure. The basic intent of the "C" personality is to be correct.
			</td>
		</tr>
	</table>
	</p>
	</div>
	
	<p>
	You will discover which of these four descriptors express themselves most strongly in your temperament by continuing to the next page.
	</p>
	
	<!--#INCLUDE FILE="include/print_profile_link.asp" -->
	
	<%	if oldButtons = true then %>
	
	<table border="0" cellspacing="0" cellpadding="0" width="570">
			<tr>
				<td align="right">
					<a HREF="PDIProfileScoringSummary2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>"><img alt="" SRC="images/PDIPrevPage.gif" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a HREF="PDIProfileBehavioralChar2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>"><img alt="" SRC="images/PDINextPage.gif" /></a>
				</td>
			</tr>
	</table>
	
	<%	end if %>
	
</div>
</body>
</html>
