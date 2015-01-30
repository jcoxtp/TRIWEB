<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	'On Error Resume Next
	intPageID = 49	' Behavioral Characteristics Page
	Dim TestCodeID, nextLink
	TestCodeID = Request.QueryString("TCID")
%>
<!--#Include file="Include/CheckLogin.asp" -->
<!--#Include file="Include/Common.asp" -->
<%
' TODO: Remove this line of code when the German site is complete
If strLanguageCode = "DE" Then
	strLanguageCode = "EN"
	intLanguageID = 1
	Response.Cookies("intLanguageID") = 1
End If
%>
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
<% nextLink = "PDIProfileBehavioralChar2.asp?TCID=" & TestCodeID & "&res=" & intResellerID & "&lid=" & intLanguageID %>
<!--#Include file="Include/TopBanner.asp" -->
    <div id="main">

<div id="tabgraphic">
	<img src="images/S3P1<%=strLanguageCode%>.gif" width="692" height="82" alt="" usemap="#tab" />
	<map name="tab">
		<area shape=poly alt="" coords="567,53,607,53,613,58,610,65,565,65,550,58,568,53,570,53" href="PDIProfileScoringSummary2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>&lid=<%=intLanguageID%>">
		<area shape=poly alt="" coords="624,53,662,53,677,59,663,65,625,66,616,60,623,53,625,53" href="PDIProfileBehavioralChar2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>&lid=<%=intLanguageID%>">
	</map>
</div>
<div id="maincontent_tab">
	<h1><%=strTextHistoryAndTheoryOfDISC%></h1>
	<p class="aligncenter"><img src="images/ArrowChart<%=strLanguageCode%>.gif" alt="" width="570" height="350" /></p>
	<p><%=strTextDrWilliamMarstonAPsychologistAndProfessorAtColumbiaUniversityIn%></p>
	<p><%=strTextDISCBackgroundPar1%></p>
	<p><%=strTextMostPeopleTendToBeEitherTask%></p>
	<div align="center">
	<p class="addtable">
	<table class="imageborder" cellspacing="0" cellpadding="6" width="85%">
		<tr>
			<td valign="top" align="left"><span class="headertext">D</span>ominant 
<%
				If intLanguageID <> 1 Then
					Response.Write "(" & strTextDominant & ")" & VbCrLf
				End If
				Response.Write ": " & strTextTaskOrientedAndAssertiveThisIs
%>
			</td>
		</tr>
		<tr>
			<td valign="top" align="left"><span class="headertext">I</span>nfluential
<%
				If intLanguageID <> 1 Then
					Response.Write "(" & strTextInfluential & ")" & VbCrLf
				End If
				Response.Write ": " & strTextPeopleOrientedAndAssertiveThisIs
%>
			</td>
		</tr>
		<tr>
			<td valign="top" align="left"><span class="headertext">S</span>teady
<%
				If intLanguageID <> 1 Then
					Response.Write "(" & strTextSteady & ")" & VbCrLf
				End If
				Response.Write ": " & strTextPeopleOrientedAndResponsiveThisIs
%>
			</td>
		</tr>
		<tr>
			<td valign="top" align="left"><span class="headertext">C</span>onscientious
<%
				If intLanguageID <> 1 Then
					Response.Write "(" & strTextConscientious & ")" & VbCrLf
				End If
				Response.Write ": " & strTextTaskOrientedAndResponsiveThisIs
%>
			</td>
		</tr>
	</table>
	</p>
	</div>
	<p><%=strTextYouWillDiscoverWhichOfTheseFour%></p>
	<% If strSiteType <> "Focus3" Then %>
	<!--#Include File="Include/PrintProfileLink.asp" -->
	<% End If %>
	<% If oldButtons = True Then %>
	<table border="0" cellspacing="0" cellpadding="0" width="570">
			<tr>
				<td align="right">
					<a HREF="PDIProfileScoringSummary2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>&lid=<%=intLanguageID%>"><img alt="" SRC="images/PDIPrevPage.gif" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a HREF="PDIProfileBehavioralChar2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>&lid=<%=intLanguageID%>"><img alt="" SRC="images/PDINextPage.gif" /></a>
				</td>
			</tr>
	</table>
	<% End If %>
</div>
</div>
</body>
</html>
