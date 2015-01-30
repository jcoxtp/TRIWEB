<%@ Language=VBScript %>
<% intPageID = 62 %>
<!--#Include virtual="/pdi/Include/common.asp" -->
<html>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<link rel="stylesheet" href="AppModStyle.css" type="text/css">
<style>
	ul.no-indent {margin-left: 0.66em; padding-left: 0;}
   li.no-indent {margin-left: 0.66em; padding-left: 0;}
   
</style>
</head>
<body style="font-family:verdana,arial,helvetica,sans-serif;font-size:10pt">
<%
Dim strTopPgSpacing
Dim AppModTitleFont
Dim EndAppModTitleFont
Dim HighType1
Dim HighType2
Dim AppModParaFont
Dim EndAppModParaFont
Dim UserName
Dim FirstName
Dim PDITestSummaryID
Dim nC1
Dim nC2
Dim nC3
Dim nC4
Dim UserID
Dim oConn
Dim oCmd
Dim oRs

strTopPgSpacing = ""
HighType1 = UCase(Request.QueryString("HT1"))
HighType2 = UCase(Request.QueryString("HT2"))
AppModTitleFont = "<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>"
EndAppModTitleFont = "</strong></font>"
AppModParaFont = "<br><font face='verdana,arial,helvetica,sans-serif' size='2'>" '"<blockquote><font size=3>"
EndAppModParaFont = "</font><br>" '"</font></blockquote>"
PDITestSummaryID = Request.QueryString("PDITSID")
UserID = Request.QueryString("UID")
If ((intUserID = "" Or intUserID = 0) And UserID <> "") Then
	intUserID = UserID
End If

Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
Set oRs = CreateObject("ADODB.Recordset")
With oCmd
	.CommandText = "sel_PDITestSummary_Ex"
	.CommandType = 4
	.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	.Parameters.Append .CreateParameter("@UserID", 3, 1, 4, intUserID)
	.Parameters.Append .CreateParameter("@PDITestSummaryID", 3, 1, 4, PDITestSummaryID)
End With
oConn.Open strDbConnString
oCmd.ActiveConnection = oConn
oRs.CursorLocation = 3
oRs.Open oCmd, , 0, 1
If oConn.Errors.Count > 0 Then
	Response.Write "Unable to retrieve PDI Profile information from database. Please try again."
	Response.End
End If

If oRs.EOF = False Then
	nC1 = oRs("C_NumberD")
	nC2 = oRs("C_NumberI")
	nC3 = oRs("C_NumberS")
	nC4 = oRs("C_NumberC")	
	FirstName = oRs("FirstName")
	UserName = oRs("FirstName") & " " & oRs("LastName")
	Dim TestDate
	TestDate = oRs("FileCreationDate")
	'==================================================================================================
	'MG: 2/9/2004 - Added to handle fake test scenarios
	Dim IsFakeResults : IsFakeResults = False
	If (nC1=0) and (nC2=0) and (nC3=0) and (nC4=0) then
		If (oRs("M_NumberD")=0) and (oRs("M_NumberI")=0) and (oRs("M_NumberS")=0) and (oRs("M_NumberC")=0) then
			If (oRs("L_NumberD")=0) and (oRs("L_NumberI")=0) and (oRs("L_NumberS")=0) and (oRs("L_NumberC")=0) then 
				If (isNull(oRs("CPD"))) and (isNull(oRs("CPI"))) and (isNull(oRs("CPS"))) and (isNull(oRs("CPC"))) then 
					IsFakeResults = True
				End If
			End If
		End If
	End If
	'==================================================================================================
Else
	Response.Write "Unable to retrieve PDI Profile information from database. Please try again."
	Response.End
End If

Response.Write VbCrLf & "<!-- PAGE 1 -->" & VbCrLf
%>
<!-- Beginning of PAGE 1 --------------------------------------------------------------------------------->
<br><br>
<TABLE WIDTH="612" BORDER="0" align="center" CELLPADDING="0" CELLSPACING="0">
	<TR>
		<TD COLSPAN="4"><IMG SRC="images/LeadingWithStyleLogo<%= strLanguageCode %>.jpg" WIDTH="620" HEIGHT="410" ALT=""></td>
	</TR>
	<TR>
		<TD background="images/leading_pdf_cover_06.gif" WIDTH="612" HEIGHT="265" COLSPAN="4">
			<%= UserName %>
			<br><%= TestDate %>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN="2"><IMG SRC="images/PDICover<%= strLanguageCode %>.gif" WIDTH="123" HEIGHT="75" ALT=""></td>
		<TD COLSPAN="2"><IMG SRC="images/leading_pdf_cover_08.gif" WIDTH="489" HEIGHT="75" ALT=""></td>
	</TR>
	<TR>
		<TD><IMG SRC="images/spacer.gif" WIDTH="36" HEIGHT="1" ALT=""></td>
		<TD><IMG SRC="images/spacer.gif" WIDTH="87" HEIGHT="1" ALT=""></td>
		<TD><IMG SRC="images/spacer.gif" WIDTH="321" HEIGHT="1" ALT=""></td>
		<TD><IMG SRC="images/spacer.gif" WIDTH="168" HEIGHT="1" ALT=""></td>
	</TR>
</TABLE>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 1 ------------------------------------------------------------------------------------------------------->



<!-- Beginning of PAGE 2 ---------------------------------------------------------------------------------------------------->
<table align="center" border='0' cellpadding='10' WIDTH="750" ID="Table1"><tr><td>
<h1><%= strTextLeadershipInARealTimeWorld %></h1>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextWhenYouCompletedThePersonalDis %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= UserName %>, <%= strTextBasedOnThecompositeGraphOfYour %>&nbsp;<%= HighType1%>.
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
	<img src="../DISCCompositeSmall.asp?nD1=<%=nC1%>&nD2=<%=nC2%>&nD3=<%=nC3%>&nD4=<%= nC4%>" align="left" hspace="12" v:shapes="_x0000_s1026">
<%= strTextThePersonalDiscernmentInventor %>
<br><br>
<%= strTextHoweverInOrderToMaximizeUnders %>
</font><br>
<br>
<br>
<br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextTheOrganizationalLandscapeIsCh %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextInTodaysWorldOfRapidDiscontinu %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<%= strTextManagerOrLeader %>
</strong></font>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextMuchIsMadeOfTheDifferenceBetwe %>
</font><br>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<!-- Ending of PAGE 2 ------------------------------------------------------------------------------------------------------->


<!-- Beginning of PAGE 3 ---------------------------------------------------------------------------------------------------->
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextJohnKotterCorrectlyObservesInA %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<ul>
	<li><%= strText149managersKeepThingsOperating %><br><br></li>
	<li><%= strText149leadersBringAboutSignifican %></li>
</ul>
</font>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextWeFrequentlyNoteThatLeadership %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextLeadershipIsAllAboutRelationsh %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextSomeLeadershipPunditsWouldTryT %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextInOrderToAchieveThisFormidable %>
</font><br>

<ul>
	<li>	<%= strTextWhatMotivatesThem %></li>
	<li>	<%= strTextHowDoYouNeedToCommunicateWithT %></li>
	<li>	<%= strTextWhatCreatesTensionOrTriggersRe %></li>
	<li>	<%= strTextWhatParticularStrengthsAndGift %></li>
	<li>	<%= strTextHowDoYouBringOutTheBestInEachP %></li>
</ul>

<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextWhenYouCompletedThePersonalDisc %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextInThisApplicationModuleYouWill %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextNoOnePersonalLeadershipStyleHa %>
</font>
<br>


<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 3 ------------------------------------------------------------------------------------------------------->


<!-- Beginning of PAGE 4 ---------------------------------------------------------------------------------------------------->
<h1><%= strTextTheRoleOfLeadership %></h1>

<font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextToReallyUnderstandHowYourTempe %>
</font><br>

<p style="margin-left:30px">
<b><%= strTextEnvisioning %></b> &mdash;
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextLooksAheadWithTheEndInMindHasA %></font>
</p>

<p style="margin-left:30px">
<b><%= strTextEnrolling %></b> &mdash;
<font face='verdana,arial,helvetica,sans-serif' size='2'>
	<%= strTextRecruitsOthersIntoAVisionOfWhe %></font>
</p>

<p style="margin-left:30px">
<b><%= strTextEmpowering %></b> &mdash;
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextLeveragesTheSkillsAndExpertise %></font>
</p>

<p style="margin-left:30px">
<b><%= strTextEnergizing %></b> &mdash;
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextAlwaysLookingForOpportunitiesT %></font>
</p>

<p><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextInThisApplicationModuleYouWillL %></font></p>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 4 ------------------------------------------------------------------------------------------------------->

<!-- Beginning of PAGE 4 ---------------------------------------------------------------------------------------------------->
<h1><%= strTextLeadershipStyles %></h1>

<font face='verdana,arial,helvetica,sans-serif' size='2'> 
<% Response.Write FirstName & ", " & strTextYourPredominantStyleIsAHigh & " " & _
						HighType1 & strTextInTheVeryBroadestOfTermsWeMigh & " " & _
						HighType1 & " " & strTextLeaderAsFollows %>
</font><br>

<% If UCase(HighType1) = "D" Then %>
	<!-- #Include File = "LeadingAppDescD.asp" -->
<% ElseIf UCase(HighType1) = "I" Then %>
	<!-- #Include File = "LeadingAppDescI.asp" -->
<% ElseIf UCase(HighType1) = "S" Then %>
	<!-- #Include File = "LeadingAppDescS.asp" -->
<% ElseIf UCase(HighType1) = "C" Then %>
	<!-- #Include File = "LeadingAppDescC.asp" -->
<% End If %>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 4 ------------------------------------------------------------------------------------------------------->


<!-- Beginning of PAGE 5 ---------------------------------------------------------------------------------------------------->
<h1><%= strTextStrengthsAndWeaknesses %></h1>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<% Response.Write 	FirstName & ", " & strTextAsAHigh & " " & HighType1 & " " & strTextAspectsOfYourWorkOrSocialStyle & " " & HighType1 & " " & strTextTemperamentOrganizedAroundTheK & VbCrLf %>
</font>
<br>
<br>
<% If UCase(HighType1) = "D" Then %>
	<!-- #Include File = "LeadingAppSwD.asp" -->
<% ElseIf UCase(HighType1) = "I" Then %>
	<!-- #Include File = "LeadingAppSwI.asp" -->
<% ElseIf UCase(HighType1) = "S" Then %>
	<!-- #Include File = "LeadingAppSwS.asp" -->
<% ElseIf UCase(HighType1) = "C" Then %>
	<!-- #Include File = "LeadingAppSwC.asp" -->
<% End If %>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 7 ------------------------------------------------------------------------------------------------------->



<!-- Beginning of PAGE 8 ---------------------------------------------------------------------------------------------------->

<h1><%= strTextLeadershipSituationsPerplexing %></h1>

<font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextEachOfUsHasADistinctivePersona %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextHoweverOtherPeoplesStylesMayDi %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextToClarifyThisConceptAnswerTheF %>
</font><br>
<br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<b><%= strTextThinkOfAPersonYouLeadWhoFrustr %></b>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table7">
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
</table>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><b><%= strTextNowDescribeSomeoneWithWhomYouW %></b>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table8">
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
</table>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><b><%= strTextInASituationWhereYouHaveFoundY %></b>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table9">
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
	<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
</table>
</font><br>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<!-- Ending of PAGE 8 ------------------------------------------------------------------------------------------------------->



<!-- Beginning of PAGE 9 --------------------------------------------------------------------------------------------------->

<h1><%= strTextDiscCompatibilityMatrix %></h1>

<font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextAsYouObservedInThePreviousExer %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextFirstLetsConsiderRelationalCom %>
</font><br>
<br>

<div style="text-align:center">
<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<br><%= strTextRelationalCompatibility %>
</strong></font>
<br>
<br>

<font face='verdana,arial,helvetica,sans-serif' size='2'>
<div align="center"><!--#Include FILE="relationshipcompatibility.asp" --></div>
</font>
</div>

<br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextNextLetsLookAtTaskCompatibilit %>
</font><br>
<br>

<div style="text-align:center">
<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<br><%= strTextTaskCompatibility %>
</strong></font>

<br>
<br>

<font face='verdana,arial,helvetica,sans-serif' size='2'>
<div align="center"><!--#Include FILE="taskcompatibility.asp" --></div>
</font><br>
</div>

<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<BR><%= strTextNoticeAlsoThatTheseAreemtenden %>
</font><br>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 9 ------------------------------------------------------------------------------------------------------>


<!-- Beginning of PAGE 10 --------------------------------------------------------------------------------------------------->
<h1><%= strTextIdentifyingTheStyleOfOthers %></h1>

<font face='verdana,arial,helvetica,sans-serif' size='2'>
<BR><%= strTextToAdaptOnesLeadershipStyleToBe %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<br><%= strTextInIdentifyingTheStylesOfOthers %>
</strong></font>
</font><br>
<ul class="no-indent">
	<li class="no-indent"><em><%= strTextUnderstandTheLimitationsOfTryi %><br><br></li>
	<li class="no-indent"><em><%= strTextWithholdFinalJudgmentUntilYouH %><br><br></li>
	<li class="no-indent"><em><%= strTextPayParticularAttentionToNonver %><br><br></li>
	<li class="no-indent"><em><%= strTextUseYourKnowledgeToIncreaseYour %><br><br></li>
</ul>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 10 ------------------------------------------------------------------------------------------------------>


<!-- Beginning of PAGE 11 --------------------------------------------------------------------------------------------------->
<h1><%= strTextIdentifyingTheStyleOfOthers %></h1>

<font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextLetsReviewTheFourelementModelT %>
</font>
<br>
<div style="text-align:center">
	<img SRC="images/<%=strLanguageCode%>/fourelementmodel.gif"><br>
	<b><%= strTextFigure1 %></b>
</div>

<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextOnTheFollowingPagesWeExpandOnT %>
</font><br>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 11 ------------------------------------------------------------------------------------------------------>


<!-- Beginning of PAGE 12 --------------------------------------------------------------------------------------------------->
<h1><%= strTextPeopleVsTask %></h1>

<font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextUsingThisModelWeCanSeeInFigure %>
</font><br>
<br>
<div style="text-align:center">
	<img SRC="images/<%=strLanguageCode%>/peoplevtaskvertical.gif"><br>
	<b><%= strTextFigure2 %></b>
</div>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 12 ------------------------------------------------------------------------------------------------------>



<!-- Beginning of PAGE 13 --------------------------------------------------------------------------------------------------->
<h1><%= strTextActionVsResponse %></h1>

<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextNowNoticeTheHorizontalLinePeop %>
</font><br>
<br>
<div style="text-align:center">
	<img SRC="images/<%=strLanguageCode%>/peoplevtaskhorizontal.gif"><br>
	<b><%= strTextFigure3 %></b>
</div>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 13 ------------------------------------------------------------------------------------------------------>



<!-- Beginning of PAGE 14 --------------------------------------------------------------------------------------------------->
<h1><%= strTextDifferentStylesDifferentNeeds %></h1>

<font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextLeadershipIsAllAboutHelpingPeo %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextSinceCommitmentIsAChoiceThePeo %>
</font><br>
<br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextHereAreAFewGuidelinesForLeadin %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<table WIDTH="100%" CELLSPACING="1" CELLPADDING="1" ID="Table12" class="with-border">
	<TR>
		<td class="with-border" width="50%" height="285px" valign="top">
			<div style="position: relative; top: 0px; height: 100%"> 
				<div class="type-watermark">
					D
				</div>
				<div style="LEFT: 0px; POSITION: absolute; TOP: 10px; Z-Index:100">
			<ul>
				<li><%= strTextFreedom %></li>
				<li><%= strTextAuthority %></li>
				<li><%= strTextPower %></li>
				<li><%= strTextMaterialRewards %></li>
				<li><%= strTextOpportunityToGrow %></li>
				<li><%= strTextDiversification %></li>
				<li><%= strTextInnovation %></li>
				<li><%= strTextChallenge %></li>
				<li><%= strTextOpportunityForAchievement %></li>
				<li><%= strTextAdditionalResponsibility %></li>
				<li><%= strTextBusinesslikeAttitudeInOthers %></li>
				<li><%= strTextEfficientUseOfTime %></li>
				<li><%= strTextCompetenceAndSelfconfidenceInO %></li>
				<li><%= strTextPossibilitiesAssociatedWithRis %></li>
				<li><%= strTextProgress %></li>
				<li><%= strTextQuickResults %></li>
			</ul>
			</div>
			</div>
		</td>		
		<td class="with-border" width="50%">
			<div style="position: relative; top: 0px; height: 100%"> 
				<div class="type-watermark">
					I
				</div>
				<div style="LEFT: 0px; POSITION: absolute; TOP: 10px; Z-Index:100">
			<ul>
				<li><%= strTextPopularity %></li>
				<li><%= strTextPrestigeTitle %></li>
				<li><%= strTextGroupActivities %></li>
				<li><%= strTextFriendlyRelationships %></li>
				<li><%= strTextFavorableWorkingConditions %></li>
				<li><%= strTextRecognition %></li>
				<li><%= strTextOpportunitiesToBeInTheSpotligh %></li>
				<li><%= strTextIncentivesForTakingOnTasks %></li>
				<li><%= strTextHumor %></li>
				<li><%= strTextToleranceOfCasualAttitudeAbout %></li>
				<li><%= strTextQuickResults %></li>
				<li><%= strTextKnowledgeOfHowOthersThinkAndFe %></li>
				<li><%= strTextSupportFromOthers %></li>
				<li><%= strTextPositiveFeedback %></li>
				<li><%= strTextApproval %></li>
				<li><%= strTextChangeVariety %></li>
			</ul>
			</div>
			</div>
		</td>
	</TR>
	<TR>
		<td height="295px" class="with-border">
			<div style="position: relative; top: 0px; height: 100%"> 
				<div class="type-watermark">
					C
				</div>
				<div style="LEFT: 0px; POSITION: absolute; TOP: 10px; Z-Index:100">
			<ul>
				<li><%= strTextFactsAndData %></li>
				<li><%= strTextSafeEnvironment %></li>
				<li><%= strTextTeamParticipation %></li>
				<li><%= strTextLimitedExposureToRisk %></li>
				<li><%= strTextNoSuddenChanges %></li>
				<li><%= strTextPersonalAttention %></li>
				<li><%= strTextSecurityAndProtection %></li>
				<li><%= strTextReassurance %></li>
				<li><%= strTextAppealsToPrinciples %></li>
				<li><%= strTextHighStandards %></li>
				<li><%= strTextOpportunityToHelp %></li>
				<li><%= strTextAppealsToExcellenceAccuracyDet %></li>
				<li><%= strTextTimeToConsiderKeyPointsThought %></li>
				<li><%= strTextEstablishedProceduresGuideline %></li>
				<li><%= strTextExactJobDescription %></li>
				<li><%= strTextTheRightOrBestAnswer %></li>
			</ul>
			</div>
			</div>
		</td>
		<td class="with-border">
			<div style="position: relative; top: 0px; height: 100%"> 
				<div class="type-watermark">
					S
				</div>
				<div style="LEFT: 0px; POSITION: absolute; TOP: 10px; Z-Index:100">
			<ul>
				<li><%= strTextAppreciation %></li>
				<li><%= strTextSincerity %></li>
				<li><%= strTextTraditionalProcedures %></li>
				<li><%= strTextLimitednoTravel %></li>
				<li><%= strTextSpecialization %></li>
				<li><%= strTextNewIdeasTiedToOldMethods %></li>
				<li><%= strTextLogicFactsAndStructure %></li>
				<li><%= strTextMinimumRisk %></li>
				<li><%= strTextAssuranceOfSupport %></li>
				<li><%= strTextSecurePersonalAgreeableEnviron %></li>
				<li><%= strTextPersonalAsWellAsBusinessRelati %></li>
				<li><%= strTextSlowDeliberateProcess %></li>
				<li><%= strTextGuaranteesAndAssurances %></li>
				<li><%= strTextAffirmationFromOthers %></li>
				<li><%= strTextNoslowRateOfChange %></li>
				<li><%= strTextReliability %></li>
				<li><%= strTextQuality %></li>
			</ul>
			</div>
			</div>
		</td>
	</TR>
</table>
</font><br>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 14 ------------------------------------------------------------------------------------------------------>



<!-- Beginning of PAGE 15-16 ------------------------------------------------------------------------------------------------>
<h1><%= strTextLeadingOthersWithStyle %></h1>

<font face='verdana,arial,helvetica,sans-serif' size='2'>
<% Response.Write 	"<br>" & FirstName & ", " & strTextAsALeaderItsImportantToLearnHo & VbCrLf %>
</font><br>

<% If UCase(HighType1) = "D" Then %>
	<!-- #Include File = "LeadingAppStratD.asp" -->
<% ElseIf UCase(HighType1) = "I" Then %>
	<!-- #Include File = "LeadingAppStratI.asp" -->
<% ElseIf UCase(HighType1) = "S" Then %>
	<!-- #Include File = "LeadingAppStratS.asp" -->
<% ElseIf UCase(HighType1) = "C" Then %>
	<!-- #Include File = "LeadingAppStratC.asp" -->
<% End If %>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 16-17 --------------------------------------------------------------------------------------------------->



<!-- Beginning of PAGE 18 --------------------------------------------------------------------------------------------------->
<h1><%= strTextWhenTheHeatIsOnLeadingUnderStr %></h1>

<font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextLeadershipChallengingAtBestBec %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextInThePdiInstrumentWeIntroduced %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextBecauseDsAndIsTendToSeeThemsel %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextNoticeWeDescribedTheAboveBehav %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextUnderStressTheHighIWillInitial %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextTheHighSsNormallyAgreeableDisp %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextHighCsWillInitiallyDealWithStr %>
</font><br>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 18 ------------------------------------------------------------------------------------------------------>


<!-- Beginning of PAGE 19 --------------------------------------------------------------------------------------------------->
<h1><%= strTextWhenTheHeatIsOnLeadingUnderStr %></h1>
<br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextTheTableBelowShowsTheInitialAn %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>

<table WIDTH="100%" CELLSPACING="0" CELLPADDING="5" ID="Table4">
	<tr>
		<td COLSPAN="3" ALIGN="MIDDLE"><font size="2"><strong><%= strTextInitialStressResponse %><!--Initial Stress Response--></strong></td>
		<td COLSPAN="2" ALIGN="MIDDLE"><font size="2"><strong><%= strTextAlternativeStressResponse %><!--Alternative Stress Response--></strong></td>
	</tr>
	<tr>
		<td style="border-bottom: solid 1px #bbbbbb;"><font size="4"><strong>D</strong></td>
		<td style="border-bottom: solid 1px #bbbbbb; border-left: solid 1px black; border-top: solid 1px black;"><font size="3"><%= strTextDemands %><!--Demands--></td>
		<td style="border-bottom: solid 1px #bbbbbb; border-top: solid 1px black;"><font size="2"><%= strTextMessageWhatDoYouMeanWeDo %><!--Message: &quot;What do you mean we don't have the budget to complete my project? No way will I accept that.&quot;--></td>
		<td style="border-bottom: solid 1px #bbbbbb; border-left: solid 1px #bbbbbb; border-top: solid 1px black;"><font size="3"><%= strTextDetaches %><!--Detaches--></td>
		<td style="border-right: solid 1px black; border-bottom: solid 1px #bbbbbb; border-top: solid 1px black;"><font size="2"><%= strTextMessageemquotiDontHaveTimeToBo %><!--Message: &quot;I don't have time to bother with this. I have bigger issues to be concerned with.&quot;--></td>
	</tr>
	<tr>
		<td style="border-bottom: solid 1px #bbbbbb;"><font size="4"><strong>I</strong></td>
		<td style="border-left: solid 1px black; border-bottom: solid 1px #bbbbbb;"><font size="3"><%= strTextAttacks %><!--Attacks--></td>
		<td style="border-bottom: solid 1px #bbbbbb;"><font size="2"><%= strTextMessageImNotAboutToGoToT %><!--Message: &quot;I'm not about to go to the board with this absurd proposal. We'll get killed if we present it this way.&quot;--></td>
		<td style="border-left: solid 1px #bbbbbb; border-bottom: solid 1px #bbbbbb;"><font size="3"><%= strTextAgrees %><!--Agrees--></td>
		<td style="border-right: solid 1px black; border-bottom: solid 1px #bbbbbb;"><font size="2"><%= strTextMessageOkayWellTryItYour %><!--Message: &quot;Okay, we'll try it your way. But don't forget that I warned you.&quot;--></td>
	</tr>
	<tr>
		<td style="border-bottom: solid 1px #bbbbbb;"><font size="4"><strong>S</strong></td>
		<td style="border-left: solid 1px black; border-bottom: solid 1px #bbbbbb;"><font size="3"><%= strTextAgrees %><!--Agrees--></td>
		<td style="border-bottom: solid 1px #bbbbbb;"><font size="2"><%= strTextMessageIKnowYouveBeenSwamped %><!--Message: &quot;I know you've been swamped, or you wouldn't have missed that critical deadline.&quot;--></td>
		<td style="border-left: solid 1px #bbbbbb; border-bottom: solid 1px #bbbbbb;"><font size="3"><%= strTextAttacks %><!--Attacks--></td>
		<td style="border-right: solid 1px black; border-bottom: solid 1px #bbbbbb;"><font size="2"><%= strTextMessageYouveTakenAdvantageOfMy %><!--Message: &quot;You've taken advantage of my good nature for the last time!&quot;--></td>
	</tr>
	<tr>
		<td style="border-bottom: solid 1px #bbbbbb;"><font size="4"><strong>C</strong></td>
		<td style="border-left: solid 1px black; border-bottom: solid 1px black;"><font size="3"><%= strTextDetaches %><!--Detaches--></td>
		<td style="border-bottom: solid 1px black;"><font size="2"><%= strTextMessageIJustDontHaveTimeHaveTime %><!--Message: &quot;I just don't have time to consider your request. I have too much on my plate as it is.&quot;--></td>
		<td style="border-left: solid 1px #bbbbbb; border-bottom: solid 1px black;"><font size="3"><%= strTextDemands %><!--Demands--></td>
		<td style="border-right: solid 1px black; border-bottom: solid 1px black;"><font size="2"><%= strTextMessageIfIBendTheRulesForYouIll %><!--Message: &quot;If I bend the rules for you, I'll have to bend them for everyone, and that's not going to happen. We'll stick to procedure.&quot;--></td>
	</tr>
</table>

</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextConflictIsNotTheOnlyCauseOfStr %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextBelowIsAListOfMoreSourcesOfStr %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextAsAHigh %>&nbsp;<%= HighType1 %>&nbsp;<%= strTextYouMayEncounterStressWhen %>
</font><br>

<% If UCase(HighType1) = "D" Then %>
	<!-- #Include File = "LeadingAppEsD.asp" -->
<% ElseIf UCase(HighType1) = "I" Then %>
	<!-- #Include File = "LeadingAppEsI.asp" -->
<% ElseIf UCase(HighType1) = "S" Then %>
	<!-- #Include File = "LeadingAppEsS.asp" -->
<% ElseIf UCase(HighType1) = "C" Then %>
	<!-- #Include File = "LeadingAppEsC.asp" -->
<% End If %>

<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextNowThinkOfThoseYouLeadWhatSitu %>
</font>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 19 ------------------------------------------------------------------------------------------------------>

<!-- Beginning of PAGE 20 --------------------------------------------------------------------------------------------------->
<h1><%= strTextReactingToStress %></h1>

<font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextInMostCasesTheFourTemperaments %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<ol type="1">
	<li> <%= strTextReadThroughTheListForYourTempe %></li>
	<li> <%= strTextThinkOfSomeoneOnYourTeamWhoHas %></li>
</ol>
</font><br>

<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<%= strTextTheHighDUnderStress %>
</strong></font>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table14">
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextCanBecomeVeryControlling %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextTriesEvenHarderToImposeWillOnO %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextAssertsSelfWithBodyOrLanguageM %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextMayDemonstrateStonySilenceOrGe %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextBecomesEvenLessWillingToCompro %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextPullsRankOnThoseWithLessPower %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextIfStressProducesConflictGetsOv %></td>
	</TR>
</table>
</font>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<%= strTextTheHighIUnderStress %>
</strong></font>
</font><br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table15">
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextFocusesFrustrationsOnOtherPeop %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextBlamesOthers %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
	<td><font size="2"><%= strTextCanBecomeEmotionalEvenToThePoi %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextMakesWoundingSarcasticRemarks %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextAttemptsToControlOthersThrough %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextIfStressProducesConflictGetsOve %></td>
	</TR>
</table>
</font>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<%= strTextTheHighSUnderStress %>
</strong></font>
</font><br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table16">
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextVoiceFacialExpressionsAndGestu %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextMayLackCommitmentEvenThoughVoi %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextCanBePassiveAggressiveIeUninvo %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextOftenCompliesRatherThanCoopera %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextIfStressProducesConflictIsSome %></td>
	</TR>
	<TR>
</table>
</font>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<%= strTextTheHighCUnderStress %>
</strong></font>
</font><br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table17">
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextBecomesEvenLessResponsive %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextLimitsVocalIntonationFacialExp %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextWithdrawsEmotionally %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextMayAvoidContactWithOthersIfCon %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextMayBecomeHypersensitiveToWorkr %></td>
	</TR>
	<TR>
		<td valign="top"><span style="font-family:webdings">c</span></td>
		<td><font size="2"><%= strTextMayAdoptAVictimizedAttitude %></td>
	</TR>
	<TR>
</table>
</font>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 20 ------------------------------------------------------------------------------------------------------>



<!-- Beginning of PAGE 21 --------------------------------------------------------------------------------------------------->
<h1><%= strTextReactingToStress %></h1>

<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<%= strTextLeadingWhenYoureUnderStressHow %>
</strong></font>
<br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextWhenYoureUnderStressYouCanTake %>
</font><br>

<ul>
	<li><%= strTextImproveYourAttitudeAndPercepti %><br><br></li>
	<li><%= strTextDiscussYourSituationOpenlyWith %><br><br></li>
	<li><%= strTextImproveYourPhysicalAbilityToCo %><br><br></li>
	<li><%= strTextCreateALessStressfulEnvironmen %></li>
</ul>
<br>
<br>
<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<%= strTextLeadingOthersWhoAreUnderStress %>
</strong></font>
<br>
<br>

<ul>
	<li><%= strTextAcknowledgeThatSomeoneIsDemons %><br><br></li>
	<li><%= strTextRecognizeTheEnvironmenteitherI %><br><br></li>
	<li><%= strTextTryToKeepFromReactingInKindMan %><br><br></li>
	<li><%= strTextIfPossibleAvoidMakingExcessive %></li>
</ul>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 21 ------------------------------------------------------------------------------------------------------>


<!-- Beginning of PAGE 22 --------------------------------------------------------------------------------------------------->
<h1><%= strTextExerciseLeadingUnderStress %></h1>

<br><font face='verdana,arial,helvetica,sans-serif' size='2'>

<ul style="margin-left:0; padding-left:8;">
	<li>
		<b><%= strTextThinkOfTheLastTimeYouWereInASt %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table10">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<b><%= strTextHowDoTheBehaviorsOfSomeOfYourC %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table5">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<b><%= strTextWhatWasTheEffectOnRelationship %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table11">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<b><%= strTextWhenTheStressSubsidedWhatChang %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table13">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<b><%= strTextWhatCanYouDoToImproveTheSituat %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table18">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table>
	</li>
</ul>
		
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 22 ------------------------------------------------------------------------------------------------------>


<!-- Beginning of PAGE 23-24 ------------------------------------------------------------------------------------------------>
<h1><%= strTextWorkingTogetherleadingAndFollo %></h1>
<br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<br><%= strTextEvenLeadersHaveLeaders %>
</strong></font>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextEvenThoughYouLeadPeopleYouMayA %>
</font><br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<br><%= strTextLetOthersKnowWhatYouNeedFromTh %>
</strong></font>
</font><br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextOnTheOtherHandYouOweItToThoseW %>
</font>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<% If UCase(HighType1) = "D" Then %>
	<!-- #Include File = "LeadingAppExpectD.asp" -->
<% ElseIf UCase(HighType1) = "I" then %>
	<!-- #Include File = "LeadingAppExpectI.asp" -->
<% ElseIf UCase(HighType1) = "S" Then %>
	<!-- #Include File = "LeadingAppExpectS.asp" -->
<% ElseIf UCase(HighType1) = "C" Then %>
	<!-- #Include File = "LeadingAppExpectC.asp" -->
<% End If %>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 23-24 --------------------------------------------------------------------------------------------------->



<!-- Beginning of PAGE 25 --------------------------------------------------------------------------------------------------->
<h1><%= strTextMaximizingYourLeadershipEffect %></h1>

<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<br><%= strTextStrengthsAndWeaknesses %>
</strong></font>

<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextEveryonesMixOfBehavioralTenden %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextInOrderToIncreaseOurEffectiven %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextUsingTheHighFactorThatYouIdent %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= UserName %>, <%= strTextBelowAreListedTheStrengthsAndW %>
</font><br>
<br>

<% If UCase(HighType1) = "D" Then %>
	<!-- #Include File = "LeadingAppSwcD.asp" -->
<% ElseIf UCase(HighType1) = "I" Then %>
	<!-- #Include File = "LeadingAppSwcI.asp" -->
<% ElseIf UCase(HighType1) = "S" Then %>
	<!-- #Include File = "LeadingAppSwcS.asp" -->
<% ElseIf UCase(HighType1) = "C" Then %>
	<!-- #Include File = "LeadingAppSwcC.asp" -->
<% End If %>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 25 ------------------------------------------------------------------------------------------------------>



<!-- Beginning of PAGE 26 --------------------------------------------------------------------------------------------------->
<h1><%= strTextDealingWithWeaknesses %></h1>

<font face='verdana,arial,helvetica,sans-serif' size='2'>
<%= strTextYouCanImplementSeveralStrategi %>
</font>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><strong><%= strTextDevelopCompensatingSkills %></strong>
<br><%= strTextRecognizeYourWeaknessesOrTende %>
</font>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextGenerallyWeCanControlTheseTend %>
</font>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><strong><%= strTextRecognizeYourOwnVulnerabilityA %></strong>
<br><%= strTextStressOftenBringsOurWeaknesses %>
</font>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><strong><%= strTextStaffToYourWeaknesses %></strong>
<br><%= strTextSynergyFlowsOutOfDiversityIden %>
</font>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextKnowingYourWeaknessesCanHelpYo %>
</font>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><strong><%= strTextAdaptYourStyleToFitTheNeedsOfO %></strong>
<br><%= strTextAdaptingCertainBehavioralDimen %>
</font>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextYouCanUseThisInformationToTail %>
</font>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextOnTheFollowingPagesWeHaveProvi %>
</font>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 27 ------------------------------------------------------------------------------------------------------>


<!-- Beginning of PAGE 28 --------------------------------------------------------------------------------------------------->
<h1><%= strTextLeadershipActionPlan %></h1>

<font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextUseThisActionPlanGuideToFormul %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table23">
	<TR>
		<TD>&nbsp;</TD>
		<td ALIGN="MIDDLE"><font size="4">D</td>
		<td ALIGN="MIDDLE"><font size="4">I</td>
		<td ALIGN="MIDDLE"><font size="4">S</td>
		<td ALIGN="MIDDLE"><font size="4">C</td>
	</TR>
	<TR>
<%

Response.Write 	"		<td ALIGN=""RIGHT"">" & strTextMyStyle & ":</td>" & VbCrLf
Response.Write 	"		<td ALIGN=""MIDDLE"">" & VbCrLf
If HighType1 = "D" Then
	Response.Write "		<img src=""images/checkbox-icon.gif"" width=""20"" height=""16"">" & VbCrLf
Else
	Response.Write "		<img src=""images/uncheckbox-icon.gif"" width=""20"" height=""16"">" & VbCrLf
End If
Response.Write 	"		</td>" & VbCrLf
Response.Write 	"		<td ALIGN=""MIDDLE"">" & VbCrLf
If HighType1 = "I" Then
	Response.Write "		<img src=""images/checkbox-icon.gif"" width=""20"" height=""16"">" & VbCrLf
Else
	Response.Write "		<img src=""images/uncheckbox-icon.gif"" width=""20"" height=""16"">" & VbCrLf
End If
Response.Write 	"		</td>" & VbCrLf
Response.Write 	"		<td ALIGN=""MIDDLE"">" & VbCrLf
If HighType1 = "S" Then
	Response.Write "		<img src=""images/checkbox-icon.gif"" width=""20"" height=""16"">" & VbCrLf
Else
	Response.Write "		<img src=""images/uncheckbox-icon.gif"" width=""20"" height=""16"">" & VbCrLf
End If
Response.Write 	"		</td>" & VbCrLf
Response.Write 	"		<td ALIGN=""MIDDLE"">" & VbCrLf
If HighType1 = "C" Then
	Response.Write "		<img src=""images/checkbox-icon.gif"" width=""20"" height=""16"">" & VbCrLf
Else
	Response.Write "		<img src=""images/uncheckbox-icon.gif"" width=""20"" height=""16"">" & VbCrLf
End If
Response.Write 	"		</td>" & VbCrLf
%>
	</TR>
	<TR>
		<td ALIGN="RIGHT"><%= strTextTheStyleOf %>: _________________</td>
		<td ALIGN="MIDDLE"><img src="images/uncheckbox-icon.gif" width="20" height="16"></td>
		<td ALIGN="MIDDLE"><img src="images/uncheckbox-icon.gif" width="20" height="16"></td>
		<td ALIGN="MIDDLE"><img src="images/uncheckbox-icon.gif" width="20" height="16"></td>
		<td ALIGN="MIDDLE"><img src="images/uncheckbox-icon.gif" width="20" height="16"></td>
	</TR>
</table>

<ul style="margin-left:0; padding-left:8;">
	<li>
		<b><%= strTextWhichOfMySpecificLeadershipWea %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table6">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<b><%= strTextWhatLeadershipNeedsDoesAPerson %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table19">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<b><%= strTextInWhatWaysHasTheInteractionOfM %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table20">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
		
		
</ul>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 28 ------------------------------------------------------------------------------------------------------>


<!-- Beginning of PAGE 29 --------------------------------------------------------------------------------------------------->
<h1><%= strTextLeadershipActionPlan %></h1>

<ul style="margin-left:0; padding-left:8;">
	<li>
		<b><%= strTextHowWouldIDescribeTheDegreeOfTe %></b>
		<br><br>
		<table align="center" WIDTH="60%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table27">
			<TR>
				<td width="20%" ALIGN="MIDDLE"><font size="2"><%= strTextNotVeryBad %></td>
				<td width="20%" ALIGN="MIDDLE"><font size="2"><%= strTextSoSo %></td>
				<td width="20%" ALIGN="MIDDLE"><font size="2"><%= strTextBad %></td>
				<td width="20%" ALIGN="MIDDLE"><font size="2"><%= strTextVeryBad %></td>
				<td width="20%" ALIGN="MIDDLE"><font size="2"><%= strTextTerrible %></td>
			</TR>
			<TR>
				<td ALIGN="MIDDLE"><span style="font-family:webdings">c</span></td>
				<td ALIGN="MIDDLE"><span style="font-family:webdings">c</span></td>
				<td ALIGN="MIDDLE"><span style="font-family:webdings">c</span></td>
				<td ALIGN="MIDDLE"><span style="font-family:webdings">c</span></td>
				<td ALIGN="MIDDLE"><span style="font-family:webdings">c</span></td>
			</TR>
		</table>
		<br>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table28">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<b><%= strTextWhatAreTheImplicationsOfContin %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table21">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<b><%= strTextWhatSpecificBehaviorsMustIChan %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table22">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
		
	</li>
	<li>
		<b><%= strTextWhatAreTheBarriersIFaceInAdapt %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table24">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>	
</ul>
		
		
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<!-- Ending of PAGE 29 ------------------------------------------------------------------------------------------------------>



<!-- Beginning of PAGE 30 --------------------------------------------------------------------------------------------------->

<ul style="margin-left:0; padding-left:8;">
	<li>
		<b><%= strTextAreThereOtherOptionsstrategies %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table25">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<b><%= strTextWhatSpecificActionWillITake %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table26">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
</ul>

<br>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 30 ------------------------------------------------------------------------------------------------------>


<!-- Beginning of PAGE 31 --------------------------------------------------------------------------------------------------->
<h1><%= strTextLeadershipActionPlan %></h1>

<font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextUseThisActionPlanGuideToFormul %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table33">
	<TR>
		<TD>&nbsp;</TD>
		<td ALIGN="MIDDLE"><font size="4">D</td>
		<td ALIGN="MIDDLE"><font size="4">I</td>
		<td ALIGN="MIDDLE"><font size="4">S</td>
		<td ALIGN="MIDDLE"><font size="4">C</td>
	</TR>
	<TR>
<%

Response.Write 	"		<td ALIGN=""RIGHT"">" & strTextMyStyle & ":</td>" & VbCrLf
Response.Write 	"		<td ALIGN=""MIDDLE"">" & VbCrLf
If HighType1 = "D" Then
	Response.Write "		<img src=""images/checkbox-icon.gif"" width=""20"" height=""16"">" & VbCrLf
Else
	Response.Write "		<img src=""images/uncheckbox-icon.gif"" width=""20"" height=""16"">" & VbCrLf
End If
Response.Write 	"		</td>" & VbCrLf
Response.Write 	"		<td ALIGN=""MIDDLE"">" & VbCrLf
If HighType1 = "I" Then
	Response.Write "		<img src=""images/checkbox-icon.gif"" width=""20"" height=""16"">" & VbCrLf
Else
	Response.Write "		<img src=""images/uncheckbox-icon.gif"" width=""20"" height=""16"">" & VbCrLf
End If
Response.Write 	"		</td>" & VbCrLf
Response.Write 	"		<td ALIGN=""MIDDLE"">" & VbCrLf
If HighType1 = "S" Then
	Response.Write "		<img src=""images/checkbox-icon.gif"" width=""20"" height=""16"">" & VbCrLf
Else
	Response.Write "		<img src=""images/uncheckbox-icon.gif"" width=""20"" height=""16"">" & VbCrLf
End If
Response.Write 	"		</td>" & VbCrLf
Response.Write 	"		<td ALIGN=""MIDDLE"">" & VbCrLf
If HighType1 = "C" Then
	Response.Write "		<img src=""images/checkbox-icon.gif"" width=""20"" height=""16"">" & VbCrLf
Else
	Response.Write "		<img src=""images/uncheckbox-icon.gif"" width=""20"" height=""16"">" & VbCrLf
End If
Response.Write 	"		</td>" & VbCrLf
%>
	</TR>
	<TR>
		<td ALIGN="RIGHT"><%= strTextTheStyleOf %>: _________________</td>
		<td ALIGN="MIDDLE"><img src="images/uncheckbox-icon.gif" width="20" height="16"></td>
		<td ALIGN="MIDDLE"><img src="images/uncheckbox-icon.gif" width="20" height="16"></td>
		<td ALIGN="MIDDLE"><img src="images/uncheckbox-icon.gif" width="20" height="16"></td>
		<td ALIGN="MIDDLE"><img src="images/uncheckbox-icon.gif" width="20" height="16"></td>
	</TR>
</table>
<br><br>

<ul style="margin-left:0; padding-left:8;">
	<li>
		<b><%= strTextWhichOfMySpecificLeadershipWea %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table29">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<b><%= strTextWhatLeadershipNeedsDoesAPerson %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table30">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<b><%= strTextInWhatWaysHasTheInteractionOfM %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table31">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<b><%= strTextHowWouldIDescribeTheDegreeOfTe %></b>
		<br><br>
		<table align="center" WIDTH="60%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table38">
			<TR>
				<td width="20%" ALIGN="MIDDLE"><font size="2"><%= strTextNotVeryBad %></td>
				<td width="20%" ALIGN="MIDDLE"><font size="2"><%= strTextSoSo %></td>
				<td width="20%" ALIGN="MIDDLE"><font size="2"><%= strTextBad %></td>
				<td width="20%" ALIGN="MIDDLE"><font size="2"><%= strTextVeryBad %></td>
				<td width="20%" ALIGN="MIDDLE"><font size="2"><%= strTextTerrible %></td>
			</TR>
			<TR>
				<td ALIGN="MIDDLE"><span style="font-family:webdings">c</span></td>
				<td ALIGN="MIDDLE"><span style="font-family:webdings">c</span></td>
				<td ALIGN="MIDDLE"><span style="font-family:webdings">c</span></td>
				<td ALIGN="MIDDLE"><span style="font-family:webdings">c</span></td>
				<td ALIGN="MIDDLE"><span style="font-family:webdings">c</span></td>
			</TR>
		</table>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table32">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
</ul>
		
		
		


<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 28 ------------------------------------------------------------------------------------------------------>

<!-- Beginning of PAGE 29 --------------------------------------------------------------------------------------------------->
<h1><%= strTextLeadershipActionPlan %></h1>
<ul style="margin-left:0; padding-left:8;">
	<li>
		<b><%= strTextWhatAreTheImplicationsOfContin %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table34">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<b><%= strTextWhatSpecificBehaviorsMustIChan %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table35">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<b><%= strTextWhatAreTheBarriersIFaceInAdapt %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table36">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
</ul>
		
		
<br>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<!-- Ending of PAGE 29 ------------------------------------------------------------------------------------------------------>



<!-- Beginning of PAGE 30 --------------------------------------------------------------------------------------------------->

<ul style="margin-left:0; padding-left:8;">
	<li>
		<b><%= strTextAreThereOtherOptionsstrategies %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table37">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<b><%= strTextWhatSpecificActionWillITake %></b>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table39">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
</ul>
<br>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- Ending of PAGE 32-33 --------------------------------------------------------------------------------------------------->

<!-- Beginning of PAGE 34 --------------------------------------------------------------------------------------------------->
<h1><%= strTextTheDISCProfileSystem %></h1>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
	<%= strTextThestrongdiscProfileSystemstro %>
</font><br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextThestrongpersonalDiscernmentIn %>
</font><br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextThestrongdiscProfileSystemstron %>
</font><br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<br><%= strTextFiveApplicationModulesAreAvail %>:
</strong></font>
</font><br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<br><%= strTextTeamworkWithStyle %>
</strong></font>
</font><br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextEachTemperamentBringsUniqueStr %>
</font><br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<br><%= strTextLeadingWithStyle %>
</strong></font>
</font><br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextOurBehavioralTraitsAreNotOnlyA %>
</font><br>
<br><font face='verdana,arial,helvetica,sans-serif' size='2'>
<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<%= strTextCommunicatingWithStyle %>
</strong></font>
</font><br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextThisModuleWillHelpYouRecognizeHow %>
</font><br>
<!-- DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV -->
<!-- Ending of PAGE 34 ------------------------------------------------------------------------------------------------------>


<!-- Beginning of PAGE 35 --------------------------------------------------------------------------------------------------->
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<br><%= strTextSellingWithStyle %>
</strong></font>
</font><br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextBehavioralStyleNotOnlyInfluencesHow %>
</font><br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<strong><font face='verdana,arial,helvetica,sans-serif' size='4'>
<br><%= strTextTimeManagementWithStyle %>
</strong></font>
</font><br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextOurPersonalitiesOftenDetermineOur %>
</font><br>
<font face='verdana,arial,helvetica,sans-serif' size='2'>
<br><%= strTextForMoreInformationCallTeamReso %>
</font><br>
<!-- Ending of PAGE 35 ------------------------------------------------------------------------------------------------------>

</td></tr>
</table>
</body>
</html>