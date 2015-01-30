<%
' you probably need to query the database so that you will 
' know that the custom profile was generated

DIM SPN
SPN = 0
Dim CP
CP = Request.QueryString("CP")
Dim profileID, ProfileID2, profileName

profileID = Request.QueryString("P1")
ProfileID2 = Request.QueryString("P2") ' [SM] Not needed
PDITestSummaryID = Request.QueryString("PTSID")
%>

<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td valign="top"><h1>Your PDI Online Summary</h1></td>
		<td valign="top" align="right"><!--#Include FILE="BackLink.asp" --></td>		
	</tr>
</table>

<!--#Include FILE="PDIProfileScoringSummary2Body.asp" -->
<!--#Include FILE="divider.asp" -->
<!--#Include FILE="PDIProfileBehavioralChar2Body.asp" -->
<!--#Include FILE="divider.asp" -->

<% 

Select Case profileID

Case 0 ' [SM] No profile chosen, so don't Include anything
Case 1 
	profileName = "Director" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 2
	profileName = "Entrepreneur" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 3
	profileName = "Organizer" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 4
	profileName = "Pioneer" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 5
	profileName = "Cooperator" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 6
	profileName = "Affiliator" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 7
	profileName = "Negotiator" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 8
	profileName = "Motivator" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 9
	profileName = "Persuader" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 10
	profileName = "Strategist" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 11
	profileName = "Persister" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 12
	profileName = "Investigator" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 13
	profileName = "Specialist" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 14
	profileName = "Advisor" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 15
	profileName = "Whirlwind" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 16
	profileName = "Perfectionist" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 17
	profileName = "Analyst" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 18
	profileName = "Adaptor" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 19
	profileName = "Creator" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 20
	profileName = "Individualist" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% Case 21
	profileName = "Flat Pattern" %>
	<!--#Include FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#Include FILE="divider.asp" -->
<% End Select %>

<!--#Include FILE="PDIProfileSANDW1Body.asp" -->
<!--#Include FILE="divider.asp" -->
<!--#Include FILE="PDIProfileSANDW2Body.asp" -->
<!--#Include FILE="divider.asp" -->
<!--#Include FILE="PDIBehavioralRelationships.asp" -->
<!--#Include FILE="PDIProfileCustomBody.asp" -->
