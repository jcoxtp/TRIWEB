<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	'On Error Resume Next
	intPageID = 43	' Your PDI Online Summary Page
	Dim oConn, oCmd, oRs ' [SM] To be used several times by the Includes in PDIProfileResultsBody.asp
	Dim CP
	Dim ProfileID, ProfileID2, ProfileName
	Dim SPN
	Dim TestCodeID
	CP = Request.QueryString("CP")
	ProfileID = Request.QueryString("P1")
	ProfileID2 = Request.QueryString("P2") ' [SM] Not needed
	PDITestSummaryID = Request.QueryString("PTSID")
	SPN = 0
	TestCodeID = Request.QueryString("TCID")
%>
<!-- #Include File = "Include/CheckLogin.asp" -->
<!-- #Include File = "Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
<!-- #Include File = "Include/TopBanner.asp" -->
    <div id="main">
        <div id="maincontent">
        <table border="0" cellspacing="0" cellpadding="0" width="100%">
	        <tr>
		        <td valign="top"><h1><%=strTextYourPDIOnlineSummary%></h1></td>
		        <td valign="top" align="right"><!-- #Include File = "Include/BackLink.asp" --></td>
	        </tr>
        </table>

        <!-- #Include File = "Include/PDIProfileScoringSummary2Body.asp" -->
        <!-- #Include File = "Include/Divider.asp" -->
        <!-- #Include File = "Include/PDIProfileBehavioralChar2Body.asp" -->
        <!-- #Include File = "Include/Divider.asp" -->

        <%
        Select Case profileID
	        Case 0
		        ' [SM] No profile chosen, so don't Include anything
	        Case 1
		        profileName = strTextDirector
	        Case 2
		        profileName = strTextEntrepreneur
	        Case 3
		        profileName = strTextOrganizer
	        Case 4
		        profileName = strTextPioneer
	        Case 5
		        profileName = strTextCooperator
	        Case 6
		        profileName = strTextAffiliator
	        Case 7
		        profileName = strTextNegotiator
	        Case 8
		        profileName = strTextMotivator
	        Case 9
		        profileName = strTextPersuader
	        Case 10
		        profileName = strTextStrategist
	        Case 11
		        profileName = strTextPersister
	        Case 12
		        profileName = strTextInvestigator
	        Case 13
		        profileName = strTextSpecialist
	        Case 14
		        profileName = strTextAdvisor
	        Case 15
		        profileName = strTextWhirlwind
	        Case 16
		        profileName = strTextPerfectionist
	        Case 17
		        profileName = strTextAnalyst
	        Case 18
		        profileName = strTextAdaptor
	        Case 19
		        profileName = strTextCreator
	        Case 20
		        profileName = strTextIndividualist
	        Case 21
		        profileName = strTextFlatPattern
        End Select
        If profileID > 0 Then %>
	        <!--#Include File="Include/PDIProfileRepProfileDescBody.asp" -->
	        <!--#Include File="Include/Divider.asp" -->
        <% End If %>

        <!--#Include File="Include/PDIProfileSANDW1Body.asp" -->
        <!--#Include File="Include/Divider.asp" -->
        <!--#Include File="Include/PDIProfileSANDW2Body.asp" -->
        <!--#Include File="Include/Divider.asp" -->
        <!--#Include File="Include/PDIBehavioralRelationships.asp" -->
        <!--#Include File="Include/PDIProfileCustomBody.asp" -->
        </div>

    </div>
</body>
</html>
