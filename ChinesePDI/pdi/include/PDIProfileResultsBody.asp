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
		<td valign="top" align="right"><!--#INCLUDE FILE="back_link.asp" --></td>		
	</tr>
</table>

<!--#INCLUDE FILE="PDIProfileScoringSummary2Body.asp" -->
<!--#INCLUDE FILE="divider.asp" -->
<!--#INCLUDE FILE="PDIProfileBehavioralChar2Body.asp" -->
<!--#INCLUDE FILE="divider.asp" -->

<% 

Select Case profileID

Case 0 ' [SM] No profile chosen, so don't include anything
Case 1 
	profileName = "Director" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 2
	profileName = "Entrepreneur" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 3
	profileName = "Organizer" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 4
	profileName = "Pioneer" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 5
	profileName = "Cooperator" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 6
	profileName = "Affiliator" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 7
	profileName = "Negotiator" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 8
	profileName = "Motivator" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 9
	profileName = "Persuader" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 10
	profileName = "Strategist" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 11
	profileName = "Persister" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 12
	profileName = "Investigator" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 13
	profileName = "Specialist" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 14
	profileName = "Advisor" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 15
	profileName = "Whirlwind" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 16
	profileName = "Perfectionist" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 17
	profileName = "Analyst" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 18
	profileName = "Adaptor" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 19
	profileName = "Creator" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 20
	profileName = "Individualist" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% Case 21
	profileName = "Flat Pattern" %>
	<!--#INCLUDE FILE="PDIProfileRepProfileDesc_Body.asp" -->
	<!--#INCLUDE FILE="divider.asp" -->
<% End Select %>

<!--#INCLUDE FILE="PDIProfileSANDW1Body.asp" -->
<!--#INCLUDE FILE="divider.asp" -->
<!--#INCLUDE FILE="PDIProfileSANDW2Body.asp" -->
<!--#INCLUDE FILE="divider.asp" -->
<!--#INCLUDE FILE="PDIBehavioralRelationships.asp" -->
<!--#INCLUDE FILE="PDIProfileCustomBody.asp" -->
