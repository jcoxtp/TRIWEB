<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 6	' Online PDIReport Page
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
		        <td valign="top"><h1><%=strTextPageTitle%></h1></td>
		        <td valign="top" align="right"><!--#Include file="Include/BackLink.asp" --></td>
	        </tr>
        </table>
            <table class="addtable" border="0" cellspacing="0" cellpadding="0" width="100%">
	        <tr>
		        <td valign="top">
			        <p><%=strTextTakingThePersonalDISC%></p>
			        <p><%=strTextToTakeTheInstrument%></p>
			        <ul>
				        <li><%=strTextThreeDifferentGraphs%></li>
				        <li><%=strTextAnOverviewOfYourPrimary%></li>
				        <li><%=strTextARepresentativeProfile%></li>
				        <li><%=strTextAnOverviewOfTheStrengths%></li>
			        </ul>
        <% 	If strSiteType <> "Focus3" Then 'Focus3 does not want to display these options %>			
		        <p><%=strTextAfterTakingTheInventory%>&nbsp;<a href="PDIAppReports.asp?res=<%=intResellerID%>"><%=LCase(strTextReports)%></a>&nbsp;<%=strTextThatAllowYouToSpecifically%></p>
		        <p><%=strTextVolumeDiscountsAreAvailable%></p>
		        <% If intResellerID = 2 Then %>
			        <p><%=Application("strTextThe" & strLanguageCode)%>&nbsp;<%=strTextPersonalDISCernmentInventory%><sup>&reg;</sup>&nbsp;<%=LCase(Application("strTextIs" & strLanguageCode))%>&nbsp;<!--#Include file="Include/dg_price.asp" -->.</p>
		        <% Else %>
			        <p><%=strTextThePDIIs22%> <a href="PDIAppReports.asp?res=<%=intResellerID%>""><%=strTextApplicationReportsAre18Each%></a></p>
		        <% End If %>
        <% End If %>
		        </td>

		        <td valign="top" align="center" style="left-margin:12px">
			        <strong><%=strTextSpecialistProfile%></strong><br />
			        <a href="javascript:openAnyWindow('RepProfile.asp','Sample',175,350)"><img src="images/RepProfile13_small.jpg" alt="" width="80" height="195" /></a><br/>
			        <span class="captiontext"><%=strTextClickImageForEnlargedView%></span>
		        </td>
	        </tr>
        </table>
        </div>
        
    </div>
</body>
</html>
