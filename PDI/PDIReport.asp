<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 59
	Dim TestCodeID
	TestCodeID = Request.QueryString("TCID")
	intLanguageID = Request.QueryString("lid")

%>
<!-- #Include File="Include/Common.asp" -->
<!-- #Include File = "Include/PDIBehavioralRelationships.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
	<!--#Include file="Include/HeadStuff.asp" -->
</head>
<body>
<%
Dim nTitleSize
Dim strUserName
Dim strUser2Name
Dim nRepProfile1
Dim nRepProfile2
Dim TestDate
Dim nCustomProfileExists
Dim nM1, nM2, nM3, nM4, nL1, nL2, nL3, nL4, nC1, nC2, nC3, nC4
Dim CPD, CPI, CPS, CPC
Dim PDITestSummaryID
Dim HP(4)
Dim HPValue(4)
Dim HPHPT(4)
Dim CHPT(4)
Dim oConn
Dim oCmd
Dim oRs


nTableWidth = 700
PDITestSummaryID = Request.QueryString("SID")
TestCodeID = Request.QueryString ("TCID")

If intLanguageID = 40 Then
	intLanguageID = 1
End If

Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
Set oRs = CreateObject("ADODB.Recordset")
With oCmd
     .CommandText = "sel_PDITestSummary"
     .CommandType = 4
     .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
     .Parameters.Append .CreateParameter("@PDITestSummaryID", 3, 1, 4, PDITestSummaryID)
End With
oConn.Open strDbConnString
oCmd.ActiveConnection = oConn
oRs.CursorLocation = 3
oRs.Open oCmd , , 0, 1

If oConn.Errors.Count < 1 Then
	If oRs.EOF = FALSE Then
		nM1 = oRs("M_NumberD")
		nM2 = oRs("M_NumberI")
		nM3 = oRs("M_NumberS")
		nM4 = oRs("M_NumberC")
		nL1 = oRs("L_NumberD")
		nL2 = oRs("L_NumberI")
		nL3 = oRs("L_NumberS")
		nL4 = oRs("L_NumberC")
		nC1 = oRs("C_NumberD")
		nC2 = oRs("C_NumberI")
		nC3 = oRs("C_NumberS")
		nC4 = oRs("C_NumberC")
		CPD = oRs("CPD")
		CPI = oRs("CPI")
		CPS = oRs("CPS")
		CPC = oRs("CPC")
		HP(1) = oRs("HighFactorType1")
		HP(2) = oRs("HighFactorType2")
		HP(3) = oRs("HighFactorType3")
		HP(4) = oRs("HighFactorType4")
		HPValue(1) = oRs("HighFactorType1Value")
		HPValue(2) = oRs("HighFactorType2Value")
		HPValue(3) = oRs("HighFactorType3Value")
		HPValue(4) = oRs("HighFactorType4Value")
		nRepProfile1 = oRs("ProfileID1")
		nRepProfile2 = oRs("ProfileID2")
		nCustomProfileExists = oRs("CustomProfile")
		strUserName = oRs("FirstName") & " " & oRs("LastName")
		strUser2Name = oRs("FirstName")	
		TestDate = oRs("TestDate")
		HighType1 = oRs("HighFactorType1")
		HighType2 = oRs("HighFactorType2")
	Else
		Response.Write "<br><br>" & strTextErrorInCreatingPDFReportPlease & " (EOF ERROR - No Record for this user)"
		Response.End
	End If
Else
	Response.Write "<br><br>" & strTextErrorInCreatingPDFReportPlease & " (SQL ERROR)"
	Response.End
End If

Set oConn = Nothing
Set oCmd = Nothing
Set oRs = Nothing

If IsNull(HPValue(1)) = True Then
	HPValue(1) = 0
End If

If IsNull(HPValue(2)) = True Then
	HPValue(2) = 0
End If

If IsNull(HPValue(3)) = True Then
	HPValue(3) = 0
End If

If IsNull(HPValue(4)) = True Then
	HPValue(4) = 0
End If

HPHPT(1) = 0
HPHPT(2) = 0
HPHPT(3) = 0
HPHPT(4) = 0

CHPT(1) = 0
CHPT(2) = 0
CHPT(3) = 0
CHPT(4) = 0

' Calculate what items are the highpoints
' You have the highpoints in letter in order and their values
' but you have to calculate because you don't know which ones are equal etc, etc.
' HPValue array contains the value of the highpoint in order of highest point to lowest point
' The HP array contains the character of the highpoint in order of highest point to lowest point
If CInt(HPValue(1)) = CInt(HPValue(2)) AND CInt(HPValue(2)) = CInt(HPValue(3)) AND CInt(HPValue(3)) = CInt(HPValue(4)) Then
	HPHPT(1) = 1
	HPHPT(2) = 1
	HPHPT(3) = 1
	HPHPT(4) = 1
Else
	If HPValue(1) = HPValue(2) AND HPValue(2) = HPValue(3) Then
		HPHPT(1) = 1
		HPHPT(2) = 1
		HPHPT(3) = 1
	Else
		' the 4 pts are not equal
		' the 3 pts are not equal
		' then check for 2 points equal
		If HPValue(1) = HPValue(2) Then
			' 2 points are equal
			HPHPT(1) = 1
			HPHPT(2) = 1
		Else
			' display the 2 highest points
			HPHPT(1) = 1
			' [SM] Disabled the following if...end if block because TR only wants the highest point shown, not
			' [SM] the highest and second highest points, unless of course they are equal, which is addressed above.
			'if ISNULL(HP(2)) = FALSE then
				'Your second highest point is HP(2)
				'HPHPT(2) = 1
			'end if
		End If
	End If
End If

Dim nCounter
' the highpoints are in an array listed in order of the highpoint, convert this to the
' order of the params passed into the asp chart page
' CHPT(1) - if 1 means that D is the highpoint
' CHPT(2) - if 1 means that I is the highpoint
' CHPT(3) - if 1 means that S is the highpoint
' CHPT(4) - if 1 means that C is the highpoint

For nCounter = 1 to 4
	If HP(nCounter) = "D" and CInt(HPHPT(nCounter)) = 1 Then
		CHPT(1) = 1
	End If
	If HP(nCounter) = "I" and CInt(HPHPT(nCounter)) = 1 Then
		CHPT(2) = 1
	End If
	If HP(nCounter) = "S" and CInt(HPHPT(nCounter)) = 1 Then
		CHPT(3) = 1
	End If
	If HP(nCounter) = "C" and CInt(HPHPT(nCounter)) = 1 Then
		CHPT(4) = 1
	End If
Next
%>

<!--************* B E G I N  R E P O R T *************-->

<!--***** Begin Page 1 *****-->
<TABLE WIDTH=612 BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
<% If 	strSiteType = "DG" Then %>
	<TR>
		<TD COLSPAN=4><IMG SRC="images/DreamGiverTitle2.jpg" WIDTH=600 HEIGHT=400 ALT=""></TD>
	</TR>
<% Else %>
	<TR>
		<TD COLSPAN=4><IMG SRC="images/personal_disc_pdf_cover_01.gif" WIDTH=612 HEIGHT=44 ALT=""></TD>
	</TR>
	<TR>
		<TD><IMG SRC="images/personal_disc_pdf_cover_02.gif" WIDTH=36 HEIGHT=282 ALT=""></TD>
		<TD COLSPAN=2><IMG SRC="images/personal_disc_pdf_cover_03.jpg" WIDTH=407 HEIGHT=282 ALT=""></TD>
		<TD><IMG SRC="images/personal_disc_pdf_cover_04.gif" WIDTH=169 HEIGHT=282 ALT=""></TD>
	</TR>
	<TR>
		<TD COLSPAN=4><IMG SRC="images/PDICover5<%=strLanguageCode%>.gif" WIDTH=612 HEIGHT=136 ALT=""></TD>
	</TR>
<% End If %>
	<TR>


		<TD background="images/personal_disc_pdf_cover_06.gif" WIDTH=612 HEIGHT=215 COLSPAN=4><%=strUserName%><br><%=TestDate%></TD>
	</TR>
	<TR>
		<TD COLSPAN=2><IMG SRC="images/PDICover<%=strLanguageCode%>.gif" WIDTH=124 HEIGHT=79 ALT=""></TD>
		<TD COLSPAN=2><IMG SRC="images/personal_disc_pdf_cover_08.gif" WIDTH=488 HEIGHT=79 ALT=""></TD>
	</TR>
	<TR>
		<TD><IMG SRC="images/spacer.gif" WIDTH=36 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=88 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=319 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=169 HEIGHT=1 ALT=""></TD>
	</TR>
</TABLE>
<p style="page-break-after: always">
<!--***** End Page 1 *****-->

<!--***** Begin Page 2 *****-->
<%
If strResellerType = "Secular" Then
%>
	<!--#Include FILE="PDI_Frontpage_Sec.asp" -->
<%
Else
%>
	<!--#Include FILE="PDI_Frontpage_Bib.asp" -->
<%
End If
%>
<p style="page-break-after: always">
<!--***** End Page 2 *****-->

<!--***** Begin Page 3 *****-->
<%
	Response.Write "<h1>" & strTextYourPersonalDISCProfile & "</h1>" & VbCrLf
	Response.Write "<h2><i>" & strTextSeeingBehaviorFromThreeDifferentPerspectives & "</i></h2>" & VbCrLf
	Response.Write "<hr>" & VbCrLf
	Response.Write strUser2Name & ", " & strTextThisIsTheScoringSummaryForYourPDIInstrumentThree & VbCrLf
	Response.Write "<br>" & VbCrLf
	Response.Write "<div align=""center"">" & VbCrLf
	Response.Write "<table class=""addtable"" border=""0"" cellspacing=""0"" cellpadding=""3"" width=""85%"">" & VbCrLf
	Response.Write "<tr>" & VbCrLf
	Response.Write "	<td align=""center"" width=""33%""><strong>" & UCase(strTextMost) & "</strong></td>" & VbCrLf
	Response.Write "	<td align=""center"" width=""33%""><strong>" & UCase(strTextLeast) & "</strong></td>" & VbCrLf
	Response.Write "	<td align=""center"" width=""34%""><strong>" & UCase(strTextComposite) & "</strong></td>" & VbCrLf
	Response.Write "</tr>" & VbCrLf
	Response.Write "<tr>" & VbCrLf
	Response.Write "	<td align=""center"">" & VbCrLf
	Response.Write "		<img src=""DISCMostSmall.asp?nD1=" & nM1 & "&nD2=" & nM2 & "&nD3=" & nM3 & "&nD4=" & nM4 & """ alt="""" />" & VbCrLf
	Response.Write "		<br /><span class=""captiontext""><strong>I. " & strTextProjectedConcept & "</strong></span>" & VbCrLf
	Response.Write "	</td>" & VbCrLf
	Response.Write "	<td align=""center"">" & VbCrLf
	Response.Write "		<img src=""DISCLeastSmall.asp?nD1=" & nL1 & "&nD2=" & nL2 & "&nD3=" & nL3 & "&nD4=" & nL4 & """ alt="""" />" & VbCrLf
	Response.Write "		<br /><span class=""captiontext""><strong>II. " & strTextPrivateConcept & "</strong></span>" & VbCrLf
	Response.Write "	</td>" & VbCrLf
	Response.Write "	<td align=""center"">" & VbCrLf
	Response.Write "		<img src=""DISCCompositeSmall.asp?nD1=" & nC1 & "&nD2=" & nC2 & "&nD3=" & nC3 & "&nD4=" & nC4 & """ alt="""" />" & VbCrLf
	Response.Write "		<br /><span class=""captiontext""><strong>III. " & strTextPublicConcept & "</strong></span>" & VbCrLf
	Response.Write "	</td>" & VbCrLf
	Response.Write "</tr>" & VbCrLf
	Response.Write "</table>" & VbCrLf
	Response.Write "</div>" & VbCrLf
	Response.Write "<br><strong>I. " & strTextProjectedConcept & "</strong> (" & strTextMOSTresponses & "): " & strTextTheProjectedConceptReflectsHow & VbCrLf
	Response.Write "<br><br><strong>II. " & strTextPrivateConcept & "</strong> (" & strTextLEASTResponses & "): " & strTextThisIsYourNaturalBehaviorWhatYou & VbCrLf
	Response.Write "<br><br><strong>III. " & strTextPublicConcept & "</strong> (" & UCase(strTextCOMPOSITE) & "): " & strTextTheCompositeGraphRepresentsTheNet & VbCrLf
	Response.Write "<br>" & VbCrLf
%>

<p style="page-break-after: always">
<!--***** End Page 3 *****-->

<!--***** Begin Page 4 *****-->
<%
	Response.Write "<h2><i>" & strTextInterpretingTheResults & "</i></h2>" & VbCrLf
	Response.Write "<hr>" & VbCrLf
	Response.Write strTextThePDIAllowsUsToViewOurBehaviorFrom & VbCrLf
	Response.Write "<br><br>" & strTextSomePeopleHoweverWillFindTheirMOSTAndLEASTGraphs & VbCrLf
	Response.Write "<br><br>" & strTextRememberTheMOSTGraphDescribesTheBehaviorThatYouFeel & VbCrLf
	Response.Write "<br><br><h2><i>" & strTextDiscoveringYourPredominantBehavioralStyle & "</i></h2>" & VbCrLf
	Response.Write "<table border=""0"" cellspacing=""0"" cellpadding=""6"" width=""100%"">" & VbCrLf
	Response.Write "<tr>" & VbCrLf
	Response.Write "	<td valign=""top"" align=""center"" width=""120"">" & VbCrLf
	Response.Write "		<img src=""DISCCompositeSmallWithHPtsCircled.asp?nD1H=" & CHPT(1) & "&D2H=" & CHPT(2) & "&nD3H=" & CHPT(3) & "&nD4H=" & CHPT(4) & "&nD1=" & nC1 & "&nD2=" & nC2 & "&nD3=" & nC3 & "&nD4=" & nC4 & """ class=""report_image"" align=""top"" alt="""" /><br />" & VbCrLf
	Response.Write "		<strong>" & strTextCompositeGraph & "</strong>" & VbCrLf
	Response.Write "	</td>" & VbCrLf
	Response.Write "	<td valign=""top"">" & VbCrLf
	Response.Write "		<br><br>" & strtextEveryPersonalityContainsSomeDegreeOfAllFourBehavioral
	Response.Write " " & strUser2Name
	Response.Write ", " & strTextNoticeTheHighPointThatIsCircledOn
	Response.Write " " & HighType1 & "." & VbCrLf
	Response.Write "<br><br>" & strTextOnTheNextFewPagesYouWillFindDetailed & VbCrLf
	Response.Write "	</td>" & VbCrLf
	Response.Write "</tr>" & VbCrLf
	Response.Write "</table>" & VbCrLf
	Response.Write "<br>" & VbCrLf
%>

<p style="page-break-after: always">
<!--***** End Page 4 *****-->

<!--***** Begin Page 5 *****-->
<%
	Response.Write "<h1>" & strTextTheHistoryAndTheoryOfDISC & "</h1>" & VbCrLf
	Response.Write "<hr>" & VbCrLf
	Response.Write strTextDrWilliamMarstonAPsychologistAndProfessorAtColumbiaUniversityIn & VbCrLf
	Response.Write "<br><br>" & strTextMarstonTheoryContendsThatTheseFourPatterns & VbCrLf
	Response.Write "<p class=""aligncenter""><img src=""images/ArrowChart" & strLanguageCode & ".gif"" alt="""" width=""570"" height=""350"" /></p>" & VbCrLf
	Response.Write strTextNoticeThatTheDominantAndTheConscientiousPersonalitiesSee & VbCrLf
	Response.Write "<br><br>" & strTextInChallengingSituationsHoweverAPersonWithAHighDegree & VbCrLf
	Response.Write "<br><br>" & strTextTheOtherTwoFactorsSeeTheEnvironmentAsPositiveOrFriendly & VbCrLf
	Response.Write "<br><br>" & VbCrLf
%>

<p style="page-break-after: always">
<!--***** End Page 5 *****-->

<!--***** Begin Page 6 *****-->
<%
	Response.Write "<h1>" & strTextBehavioralCharacteristics & "</h1>" & VbCrLf
	Response.Write "<hr>" & VbCrLf
	If strSiteType = "DG" Then
		Response.Write "<table border=""1"" cellpadding=""5"" cellspacing=""0"" width=""600"">" & VbCrLf
		Response.Write "<tr align=""left"" valign=""top"" cellpadding=""0"" cellspacing=""0"">" & VbCrLf
		Response.Write "	<td>" & VbCrLf
		Response.Write "		<img SRC=""images/HighD.gif"" width=""280"" height=""152"" alt="""" border=""0"">" & VbCrLf
		Response.Write "		<br><b>" & strTextDominant & "</b>" & VbCrLf
		Response.Write "		<br><i>" & strTextKeyToMotivation & ": " & strTextChallenge & "</i>" & VbCrLf
		Response.Write "		<br><i>" & strTextBasicIntent & ": " & strTextTo & "<b>" & strTextToOvercome & "</b></i>" & VbCrLf
		Response.Write "		<table border=""0"" cellpadding=""3"" cellspacing=""0"" width=""95%"" align=""center"">" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextActiveAndTaskOriented & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextWelcomesDifficultAssignmentsAndChallenges & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextDecisive & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextEmbracesChange & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextIndividualistic & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextHasLittleToleranceForFeedback & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextDoesntEncourageOpposingViews & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextHasDifficultyRelinquishingControl & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextNeedsToSeeClearProgress & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextRarelyShirksConflict & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextNeedsToBeInCharge & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextWillSacrificeForTheGoal & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextTakesRisks & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextReadyToAcceptBiggerChallenges & "</td></tr>" & VbCrLf
		Response.Write "		</table>" & VbCrLf
		Response.Write "	</td>" & VbCrLf
		Response.Write "	<td>" & VbCrLf
		Response.Write "		<img SRC=""images/HighI.gif"" width=""280"" height=""152"" alt="""" border=""0"">" & VbCrLf
		Response.Write "		<br><b>" & strTextInfluential & "</b>" & VbCrLf
		Response.Write "		<br><i>" & strTextKeyToMotivation & ": " & strTextRecognition & "</i>" & VbCrLf
		Response.Write "		<br><i>" & strTextBasicIntent & ": " & strTextTo & " <b>" & strTextPersuade & "</b></i>" & VbCrLf
		Response.Write "		<table border=""0"" cellpadding=""3"" cellspacing=""0"" width=""95%"" align=""center"">" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextActiveAndRelationshipOriented & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextQuickToGraspBigDreamsAndTheirPossibilities & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextReceptiveToChange & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextNeedsApprovalOfOtherPeopleForSelfAnd & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextExhibitsCreativeAndInnovativeThinking & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextEncouragesInputAndIdeasFromOthers & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextProficientAtCommunicatingDreamToOthers & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextOptimisticAndEnthusiastic & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextTrusting & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextSelfPromoting & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextTendsToOversellAndUnderestimateDifficulties & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextEnthusiasticAndPositiveEvenDuring & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextMoreEffectiveAtOvercomingObstaclesInvolving & "</td></tr>" & VbCrLf
		Response.Write "			<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextBelievesPassionatelyInTheDream & "</td></tr>" & VbCrLf
		Response.Write "		</table>" & VbCrLf
		Response.Write "	</td>" & VbCrLf
		Response.Write "</tr>" & VbCrLf
		Response.Write "</table>" & VbCrLf
%>

<p style="page-break-after: always">&nbsp;</p>
<%
	Response.Write "<h1>" & strTextBehavioralCharacteristics & " " & strTextContinued & "</h1>" & VbCrLf
	Response.Write "	<table border=""1"" cellpadding=""5"" cellspacing=""0"" width=""600"">" & VbCrLf
	Response.Write "		<tr align=""left"" valign=""top"">" & VbCrLf
	Response.Write "			<td>" & VbCrLf
	Response.Write "				<img SRC=""images/HighC.gif"" width=""280"" height=""128"" alt="""" border=""0"">" & VbCrLf
	Response.Write "				<br><b>" & strTextConscientious & "</b>" & VbCrLf
	Response.Write "				<br><i>" & strTextKeyToMotivation & ": " & strTextProtectionSecurity & "</i>" & VbCrLf
	Response.Write "				<br><i>" & strTextBasicIntent & ": " & strTextTo & " <b>" & strTextBeCorrect & "</b></i>" & VbCrLf
	Response.Write "				<table border=""0"" cellpadding=""3"" cellspacing=""0"" width=""95%"" align=""center"">" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextResponsiveAndTaskOriented & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextCarefullyWeighsProsAndConsBeforeFollowing & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextMakesExtensivePlansAndGathersInformation & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextCreatesAnAccurateAndBelievablePicture & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextConveysLevelOfExpertiseThatFosters & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextNeedsBothInternalAndExternalAssurance & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextRiskAverse & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextQuestionsAndSecondGuessesDecisionWhen & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextPessimisticAndSuspicious & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextAnticipatesEventualitiesAndCreates & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextHasDifficultyTurningTheDream & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextMotivatedByExcellenceAccuracyDetail & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextInspiresByExpertiseAndKnowledge & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextSensitiveToCriticismOfWork & "</td></tr>" & VbCrLf
	Response.Write "				</table>" & VbCrLf
	Response.Write "			</td>" & VbCrLf
	Response.Write "			<td>" & VbCrLf
	Response.Write "				<img SRC=""images/HighS.gif"" width=""280"" height=""128"" alt="""" border=""0"">" & VbCrLf
	Response.Write "				<br><b>" & strTextSteady & "</b>" & VbCrLf
	Response.Write "				<br><i>" & strTextKeyToMotivation & ": " & strTextAppreciation & "</i>" & VbCrLf
	Response.Write "				<br><i>" & strTextBasicIntent & ": " & strTextTo & " <b>" & strTextSupport & "</b></i>" & VbCrLf
	Response.Write "				<table border=""0"" cellpadding=""3"" cellspacing=""0"" width=""95%"" align=""center"">" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextResponsiveAndRelationshipOriented & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextEagerToServeSupportAndCollaborate & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextRealisticAndDownToEarth & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextStrivesToMaintainStatusQuo & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextRequiresTimeToAdjustToChange & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextNeedsSupportAndApprovalOfClose & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextHasAStrongSenseOfPossessionAndOwnership & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextEvenTempered & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextPatientAndPersistent & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextConflictAverse & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextIdentifiesWithGroup & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextEagerToShareGloryWithOthers & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextNeedsMinimumRiskAndTheAssurance & "</td></tr>" & VbCrLf
	Response.Write "					<tr><td>&nbsp;&#149&nbsp;&nbsp;</td><td>" & strTextNeedsSincereAppreciationForEffort & "</td></tr>" & VbCrLf
	Response.Write "				</table>" & VbCrLf
	Response.Write "			</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "	</table>" & VbCrLf
Else
	Response.Write "	<p align=""center"" class=""MsoNormal"">" & VbCrLf
	Response.Write "		<img SRC=""images/FourQuadrants" & strLanguageCode & ".gif"" width=""535"" height=""644"" alt="""" border=""0"">" & VbCrLf
	Response.Write "	</p>" & VbCrLf
End If
%>
<br><br>

<p style="page-break-after: always">
<!--***** End Page 6 *****-->

<!--***** Begin Page 7 *****-->
<%
	Response.Write "<h2><i>" & strTextOverviewOfYourPrimaryBehavioralCharacteristic & "</i></h2>" & VbCrLf
	Response.Write "<hr>" & VbCrLf
If UCase(HighType1) = "D" Then
	Response.Write "	<!-- <p class=""aligncenter""><img src=""images/pdi_overview_d.gif"" alt="""" width=""480"" height=""287"" /></p> -->" & VbCrLf
	Response.Write "	<br>" & VbCrLf
	Response.Write "	<table class=""addtable"" border=""0"" cellspacing=""0"" cellpadding=""6"" width=""100%"">" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""center"" colspan=""2""><span class=""headertext2"">" & strTextDominant & " (""D"")" & "</span></td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right"" width=""35%""><strong>" & strTextOtherTerms & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"" width=""65%"">" & strTextDriverDirector & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextEmphasis & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextControllingTheEnvironmentByOvercoming & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextKeyToMotivation & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextChallenge & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextBasicIntent & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextToOvercome & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextGreatestFear & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextLossOfControl & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""center"" colspan=""2""><img src=""images/dominance.gif"" alt="""" width=""370"" height=""213"" /></td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "	</table>" & VbCrLf
	Response.Write "<br>" & strUser2Name & ", " & strTextAsAHighDYouAreActiveAndTaskOriented & VbCrLf
	Response.Write "<br><br>" & strTextYouWillFightHardForWhatYouThink & VbCrLf
	Response.Write "<br><br>" & strTextDsThriveOnCompetitionToughAssignments & VbCrLf
	Response.Write "<br><br>" & strTextYouAreARealIndividualistAndVery & VbCrLf
ElseIf UCase(HighType1) = "I" Then
	Response.Write "	<!-- <p class=""aligncenter""><img src=""images/pdi_overview_i.gif"" alt="""" width=""480"" height=""287"" /></p> -->" & VbCrLf
	Response.Write "<br><br>" & VbCrLf
	Response.Write "	<table class=""addtable"" border=""0"" cellspacing=""0"" cellpadding=""6"" width=""100%"">" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""center"" colspan=""2""><span class=""headertext2"">" & strTextInfluential & " (""I"")" & "</span></td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right"" width=""35%""><strong>" & strTextOtherTerms & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"" width=""65%"">" & strTextExpressive & ", " & strTextPersuader & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextEmphasis & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextCreatingTheEnvironmentByMotivatingAnd & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextKeyToMotivation & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextRecognition & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextBasicIntent & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextToPersuade & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextGreatestFear & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextLackOfRecognitionAndAdmiration & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""center"" colspan=""2""><img src=""images/influence.gif"" alt="""" width=""331"" height=""209"" /></td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "	</table>" & VbCrLf
	Response.Write "<br>" & strUser2Name & ", " & strTextAsAHighIYouAreActiveAnd & VbCrLf
	Response.Write "<br><br>" & strTextIsAreOftenEffectiveMotivatorsUsing & VbCrLf
	Response.Write "<br><br>" & strTextYourBasicInterestIsPeopleWhether & VbCrLf
ElseIf UCase(HighType1) = "S" Then
	Response.Write "	<!-- <p class=""aligncenter""><img src=""images/pdi_overview_s.gif"" alt="""" width=""480"" height=""287"" /></p> -->" & VbCrLf
	Response.Write "	<br><br>" & VbCrLf
	Response.Write "	<table class=""addtable"" border=""0"" cellspacing=""0"" cellpadding=""6"" width=""100%"">" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""center"" colspan=""2""><span class=""headertext2"">" & strTextSteady & " (""S"")</span></td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right"" width=""35%""><strong>" & strTextOtherTerms & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"" width=""65%"">" & strTextAmicable & ", " & strTextSupporter & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextEmphasis & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextMaintainingTheEnvironmentToCarryOut & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextKeyToMotivation & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextAppreciation & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextBasicIntent & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextToSupport & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextGreatestFear & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextConflictDamageToRelationships & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""center"" colspan=""2""><img src=""images/steadiness.gif"" alt="""" width=""344"" height=""200"" /></td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "	</table>" & VbCrLf
	Response.Write "<br>" & strUser2Name & ", " & strTextAsAHighSYouAreResponsiveAndRelationship & VbCrLf
	Response.Write "<br><br>" & strTextYouAreUsuallyAmiableEasyGoing & VbCrLf
	Response.Write "<br><br>" & strTextUsuallySPeopleAreEvenTemperedLowKey & VbCrLf
	Response.Write "<br><br>" & strTextSPeopleDislikeChangeOnce & VbCrLf
ElseIf UCase(HighType1) = "C" Then
	Response.Write "	<!-- <p class=""aligncenter""><img src=""images/pdi_overview_c.gif"" alt="""" width=""480"" height=""287"" /></p> -->" & VbCrLf
	Response.Write "	<br><br>" & VbCrLf
	Response.Write "	<table class=""addtable"" border=""0"" cellspacing=""0"" cellpadding=""6"" width=""100%"">" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""center"" colspan=""2""><span class=""headertext2"">" & strTextConscientious & "(""C"")</span></td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right"" width=""35%""><strong>" & strTextOtherTerms & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"" width=""65%"">" & strTextCautious & ", " & strTextAnalytical & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextEmphasis & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextStructuringTheEnvironmentToProduce & VbCrLf
	Response.Write "			</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextKeyToMotivation & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextProtectionSecurity & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextBasicIntent & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextToBeCorrect & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextGreatestFear & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextBeingWrongMakingAMistake & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""center"" colspan=""2""><img src=""images/conscientiousness.gif"" alt="""" width=""372"" height=""187"" /></td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "	</table>" & VbCrLf
	Response.Write "	<br>" & strUser2Name & ", " & strTextAsAHighCYouAreResponsiveAndTask & VbCrLf
	Response.Write "<br><br>" & strTextCsArePreciseAndAttentiveTodetail & VbCrLf
	Response.Write "<br><br>" & strTextNaturallyCautiousYouPreferToWaitAnd & VbCrLf
Else
	Response.Write "	<br><br>" & strTextOurDatabaseDoesNotContainAValid & VbCrLf
End If
%>


<p style="page-break-after: always">
<!--***** End Page 7 *****-->

<!--***** Begin Page 8 *****-->
<%
Response.Write "<h1>" & strTextYourMOSTAndLEASTGraphs & "</h1>" & VbCrLf
Response.Write "<h2><i>" & strTextInterpretingDifferences & "</i></h2>" & VbCrLf
Response.Write "<hr>" & VbCrLf
Response.Write strTextAboutHalfOfUsWillSeeASignificantDifference & VbCrLf
Response.Write "<br><br>" & strUser2Name & ", " & strTextBelowAreTheSignificantChanges & VbCrLf

Dim nDifference, bShowChart
nDifference = 15
bShowChart = false
Dim YAxisM1, YAxisM2, YAxisM3, YAxisM4
Dim YAxisL1, YAxisL2, YAxisL3, YAxisL4
YAxisM1 = 0
YAxisM2 = 0
YAxisM3 = 0
YAxisM4 = 0
YAxisL1 = 0
YAxisL2 = 0
YAxisL3 = 0
YAxisL4 = 0

Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
With oCmd
     .CommandText = "sel_ChartTranslation_MostLeast"
     .CommandType = 4
     .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
     .Parameters.Append .CreateParameter("@MostScore1",3, 1,4, CInt(nM1))
     .Parameters.Append .CreateParameter("@MostScore2",3, 1,4, CInt(nM2))
     .Parameters.Append .CreateParameter("@MostScore3",3, 1,4, CInt(nM3))
     .Parameters.Append .CreateParameter("@MostScore4",3, 1,4, CInt(nM4))
     .Parameters.Append .CreateParameter("@LeastScore1",3, 1,4, CInt(nL1))
     .Parameters.Append .CreateParameter("@LeastScore2",3, 1,4, CInt(nL2))
     .Parameters.Append .CreateParameter("@LeastScore3",3, 1,4, CInt(nL3))
     .Parameters.Append .CreateParameter("@LeastScore4",3, 1,4, CInt(nL4))
     .Parameters.Append .CreateParameter("@YAxisM1",3, 3,4, CLng(YAxisM1))
     .Parameters.Append .CreateParameter("@YAxisM2",3, 3,4, CLng(YAxisM2))
     .Parameters.Append .CreateParameter("@YAxisM3",3, 3,4, CLng(YAxisM3))
     .Parameters.Append .CreateParameter("@YAxisM4",3, 3,4, CLng(YAxisM4))
     .Parameters.Append .CreateParameter("@YAxisL1",3, 3,4, CLng(YAxisL1))
     .Parameters.Append .CreateParameter("@YAxisL2",3, 3,4, CLng(YAxisL2))
     .Parameters.Append .CreateParameter("@YAxisL3",3, 3,4, CLng(YAxisL3))
     .Parameters.Append .CreateParameter("@YAxisL4",3, 3,4, CLng(YAxisL4))
End With
oConn.Open strDbConnString
oCmd.ActiveConnection = oConn
oCmd.Execute , , 128

YAxisM1 = CInt(oCmd.Parameters("@YAxisM1").value)
YAxisM2 = CInt(oCmd.Parameters("@YAxisM2").value)
YAxisM3 = CInt(oCmd.Parameters("@YAxisM3").value)
YAxisM4 = CInt(oCmd.Parameters("@YAxisM4").value)
YAxisL1 = CInt(oCmd.Parameters("@YAxisL1").value)
YAxisL2 = CInt(oCmd.Parameters("@YAxisL2").value)
YAxisL3 = CInt(oCmd.Parameters("@YAxisL3").value)
YAxisL4 = CInt(oCmd.Parameters("@YAxisL4").value)

If oConn.Errors.Count > 0 Then
	Response.Write "<br><br>" & strTextUnableToRetrieveChartTranslation & VbCrLf
	Response.End
End If

If Abs(YAxisM1 - YAxisL1) >= nDifference OR Abs(YAxisM2 - YAxisL2) >= nDifference OR Abs(YAxisM3 - YAxisL3) >= nDifference OR Abs(YAxisM4 - YAxisL4) >= nDifference Then
	bShowChart = True
End if
If bShowChart = True Then
	Response.Write "<br><br>" & VbCrLf
	Response.Write "	<div align=""center"">" & VbCrLf
	Response.Write "	<table class=""addtable"" border=""0"" cellspacing=""0"" cellpadding=""3"" width=""85%"">" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td align=""center"" width=""33%""><strong>" & UCase(strTextMost) & "</strong></td>" & VbCrLf
	Response.Write "			<td align=""center"" width=""33%""><strong>" & UCase(strTextLeast) & "</strong></td>" & VbCrLf
	Response.Write "			<td align=""center"" width=""34%""><strong>" & UCase(strTextComposite) & "</strong></td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td align=""center"">" & VbCrLf
	Response.Write "				<img src=""DISCMostSmall.asp?nD1=" & nM1 & "&nD2=" & nM2 & "&nD3=" & nM3 & "&nD4=" & nM4 & """ alt="""" /><br />" & VbCrLf
	Response.Write "				<span class=""captiontext""><strong>I. " & strTextProjectedConcept & "</strong></span>" & VbCrLf
	Response.Write "			</td>" & VbCrLf
	Response.Write "			<td align=""center"">" & VbCrLf
	Response.Write "				<img src=""DISCLeastSmall.asp?nD1=" & nL1 & "&nD2=" & nL2 & "&nD3=" & nL3 & "&nD4=" & nL4 & """ alt="""" /><br />" & VbCrLf
	Response.Write "				<span class=""captiontext""><strong>II. " & strTextPrivateConcept & "</strong></span>" & VbCrLf
	Response.Write "			</td>" & VbCrLf
	Response.Write "			<td align=""center"">" & VbCrLf
	Response.Write "				<img src=""DISCCompositeSmall.asp?nD1=" & nC1 & "&nD2=" & nC2 & "&nD3=" & nC3 & "&nD4=" & nC4 & """ alt="""" /><br />" & VbCrLf
	Response.Write "				<span class=""captiontext""><strong>III. " & strTextPublicConcept & "</strong></span>" & VbCrLf
	Response.Write "			</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "	</table>" & VbCrLf
	Response.Write "	</div>" & VbCrLf
	Response.Write "	<div align=""center"">" & VbCrLf
	Response.Write "	<table class=""addtable"" border=""1"" cellspacing=""0"" cellpadding=""6"" width=""85%"">" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""middle"" align=""left""><strong>" & strTextOnYourMostGraphYour & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""middle"" align=""center""><strong>M &nbsp;&nbsp;L</strong></td>" & VbCrLf
	Response.Write "			<td valign=""middle"" align=""left"">" & VbCrLf
	Response.Write "				<strong>" & strTextYouSeeTheNeedInYourDailyActivitiesTo & ":</strong>" & VbCrLf
	Response.Write "			</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	If YAxisM1 - YAxisL1 >= nDifference Then
		Response.Write "			<tr>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""left"">'D' " & strTextIsHigherThanOnYourLeast & "</td>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""center""><img src=""images/d_higher.gif"" width=""71"" height=""50"" /></td>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""left"">" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextBeMoreAssertive & "</p>" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextPushForResults & "</p>" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextActDecisively & "</p>" & VbCrLf
		Response.Write "				</td>" & VbCrLf
		Response.Write "			</tr>" & VbCrLf
	End If
	If YAxisL1 - YAxisM1 >= nDifference Then
		Response.Write "			<tr>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""left"">'D' " & strTextIsLowerThanOnYourLeastGraph & "</td>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""center""><img src=""images/d_lower.gif"" width=""71"" height=""50"" /></td>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""left"">" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextBeMoreLowKeyAndRelaxed & "</p>" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextBeMoreAccommodating & "</p>" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextDeliberateBeforeDeciding & "</p>" & VbCrLf
		Response.Write "				</td>" & VbCrLf
		Response.Write "			</tr>" & VbCrLf
	End If
	If YAxisM2 - YAxisL2 >= nDifference Then
		Response.Write "			<tr>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""left"">'I' " & strTextIsHigherThanOnYourLeast & "</td>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""center""><img src=""images/i_higher.gif"" width=""71"" height=""50"" /></td>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""left"">" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextBeMorePersuasiveAndEnthusiastic & "</p>" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextBeMoreOutgoingAndSocial & "</p>" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextWorkOnPeopleSkills & "</p>" & VbCrLf
		Response.Write "				</td>" & VbCrLf
		Response.Write "			</tr>" & VbCrLf
	End If
	If YAxisL2 - YAxisM2 >= nDifference Then
		Response.Write "			<tr>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""left"">'I' " & strTextIsLowerThanOnYourLeastGraph & "</td>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""center""><img src=""images/i_lower.gif"" width=""71"" height=""50"" /></td>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""left"">" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextBeMoreObjectiveInAssessing & "</p>" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextAvoidBeingOverlyOptimistic & "</p>" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextThinkLogically & "</p>" & VbCrLf
		Response.Write "				</td>" & VbCrLf
		Response.Write "			</tr>" & VbCrLf
	End If
	If YAxisM3 - YAxisL3 >= nDifference Then
		Response.Write "			<tr>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""left"">'S' " & strTextIsHigherThanOnYourLeast & "</td>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""center""><img src=""images/s_higher.gif"" width=""71"" height=""50"" /></td>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""left"">" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextBeMorePatientAndSupportive & "</p>" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextBehaveConsistentlyAndDependably & "</p>" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextDevelopSystemsAndProcesses & "</p>" & VbCrLf
		Response.Write "				</td>" & VbCrLf
		Response.Write "			</tr>" & VbCrLf
	End If
	If YAxisL3 - YAxisM3 >= nDifference Then
		Response.Write "			<tr>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""left"">'S' " & strTextIsLowerThanOnYourLeastGraph & "</td>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""center""><img src=""images/s_lower.gif"" width=""71"" height=""50"" /></td>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""left"">" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextSeekVariety & "</p>" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextPushForClosure & "</p>" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextReactMoreQuicklyToChange & "</p>" & VbCrLf
		Response.Write "				</td>" & VbCrLf
		Response.Write "			</tr>" & VbCrLf
	End If
	If YAxisM4 - YAxisL4 >= nDifference Then
		Response.Write "			<tr>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""left"">'C' " & strTextIsHigherThanOnYourLeast & "</td>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""center""><img src=""images/c_higher.gif"" width=""71"" height=""50"" /></td>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""left"">" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextFollowTheRules & "</p>" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextConcentrateOnDetails & "</p>" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextSeekAccuracyAndPrecision & "</p>" & VbCrLf
		Response.Write "				</td>" & VbCrLf
		Response.Write "			</tr>" & VbCrLf
	End If
	If YAxisL4 - YAxisM4 >= nDifference Then
		Response.Write "			<tr>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""left"">'C' " & strTextIsLowerThanOnYourLeastGraph & "</td>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""center""><img src=""images/c_lower.gif"" width=""71"" height=""50"" /></td>" & VbCrLf
		Response.Write "				<td valign=""top"" align=""left"">" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextBeMoreIndependent & "</p>" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextTakeMoreRisksAndActWithout & "</p>" & VbCrLf
		Response.Write "					<p class=""report_list"">&#149;&nbsp;&nbsp;" & strTextConsiderTheBigPicture & "</p>" & VbCrLf
		Response.Write "				</td>" & VbCrLf
		Response.Write "			</tr>" & VbCrLf
	End If
	Response.Write "	</table>" & VbCrLf
	Response.Write "	</div>" & VbCrLf
Else
	Response.Write "<br><br>" & VbCrLf
	Response.Write "	<div align=""center"">" & VbCrLf
	Response.Write strTextYouDoNotHaveASignificantDifference & VbCrLf
	Response.Write "	</div>" & VbCrLf
End If
%>

<p style="page-break-after: always">
<!--***** End Page 8 *****-->

<!--***** Begin Page 9 *****-->
<%
Response.Write "<h1>" & strTextRepresentativePattern & ": " & strUserName & "</h1>" & VbCrLf
Response.Write "<h2><i>" & strTextIncreasingPersonalEffectiveness & "</i></h2>" & VbCrLf
Response.Write "<hr>" & VbCrLf
Response.Write strTextEveryPersonalityContainsAllFourStyles & VbCrLf
Response.Write "<br><br>" & strTextThereIsAlmostAnInfiniteVarietyOf & VbCrLf
Response.Write "<br><br>" & strTextInYourPersonalPatternWeWillIdentify & VbCrLf
Response.Write "<br><br>" & VbCrLf
Response.Write "<ul>" & VbCrLf
Response.Write "	<li>" & strTextOutstandingTraits & "</li>" & VbCrLf
Response.Write "	<li>" & strTextBasicDesiresAndInternalDrive & "</li>" & VbCrLf
Response.Write "	<li>" & strTextPotentialForGrowth & "</li>" & VbCrLf
Response.Write "	<li>" & strTextIdealWorkSetting & "</li>" & VbCrLf
Response.Write "</ul>" & VbCrLf
Response.Write "<br><br>" & strTextItIsImportantToRememberThatThisPattern & VbCrLf

' Show the representative profile, if it is not zero, else skip this section
If Not (nRepProfile1 >= 1 and nRepProfile1 <= 28) Then 
	Response.Write "<br><br>Rather than choosing a representative pattern, " & _
						"you selected 'None of these match my graph'.  Although you were " & _
						"unable to find a pattern that matches your style exactly, detailed " & _
						"information about how your four factors combine and influence one " & _
						"another can be found under 'Your Unique Style: Observable Traits', " & _
						"after the Strengths and Weaknesses section of this report."
Else
%>

<p style="page-break-after: always">
<!--***** End Page 9 *****-->

<!--***** Begin Page 10 *****-->
<%
	Response.Write "<h2><i>" & strTextYourRepresentativePattern & "</i></h2>" & VbCrLf
	Response.Write "<hr>" & VbCrLf
	Response.Write strTextBelowYouWillFindThePatternsThatMostClosely & VbCrLf
	Response.Write "<br><br>" & VbCrLf
	
	Set oConn = Nothing
	Set oCmd = Nothing
	Dim strLeftTitle1, strLeftText1
	Dim strRightTitle1, strRightText1
	Dim strLeftTitle2, strLeftText2
	Dim strRightTitle2, strRightText2
	Dim strDreamTitle, strDreamText
	Dim profileName
	strLeftTitle1 = strTextOutstandingTraits
	strRightTitle1 = strTextPotentialForGrowth
	strLeftTitle2 = strTextBasicDesiresAndInternalDrive
	If strSiteType = "DG" Then
		strRightTitle2 = strTextIdealEnvironment
		strDreamTitle = strTextDreamJourney
	Else
		strRightTitle2 = strTextIdealWorkSetting
		strDreamTitle = ""
	End If
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	With oCmd
		.CommandText = "spRepProfileDescProfileID"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		.Parameters.Append .CreateParameter("@profileID", 3, 1, 4, nRepProfile1)
		.Parameters.Append .CreateParameter("@intLanguageID", 3, 1, 4, intLanguageID)
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	If oConn.Errors.Count < 1 Then
		strLeftText1 = oRs("outstandingTraits")
		strRightText1 = oRs("potentialGrowth")
		strLeftText2 = oRs("basicDesires")
		strRightText2 = oRs("workSetting")
		strDreamText = oRs("dreamJourney")
		profileName = oRs("RepProfileName")
	Else
		Response.Write strTextErrorTryingToRetrieveProfileDescription
	End If
%>
	<table border="0" cellspacing="0" cellpadding="6" width="90%">
		<tr>
			<td valign="top" align="center" width="140"><img src="images/RepProfile<%=nRepProfile1%>.gif" alt="" /></td>
			<td valign="top">
				<h1>(<%=nRepProfile1%>)&nbsp;<%=profileName%></h1>
				<h2><%=strLeftTitle1%></h2>
				<p><%=strLeftText1%></p>
				<h2><%=strLeftTitle2%></h2>
				<p><%=strLeftText2%></p>
				<h2><%=strRightTitle1%></h2>
				<p><%=strRightText1%></p>
				<h2><%=strRightTitle2%></h2>
				<p><%=strRightText2%></p>
				<% If strSiteType = "DG" Then %>
					<p style="page-break-after: always">&nbsp;</p>
					<h2><%=strDreamTitle%></h2>
					<p><%=strDreamText%></p>
				<% End If %>
			</td>
		</tr>
	</table>
<%
End If %>

<p style="page-break-after: always">
<!--***** End Page 10 *****-->


<!--***** Begin Page 11 *****-->
<%
Response.Write "<h1>" & strTextStrengthsAndWeaknesses & "</h1>" & VbCrLf
Response.Write "<hr>" & VbCrLf
Response.Write strTextEveryonesPersonalityContainsBothStrengthsAnd
Response.Write "<br><br>" & strUser2Name & ", " & strTextHereIsAListOfTheStrengthsAnd
Response.Write "<br><br>" & VbCrLf

' Get the high factor type strengths and weaknesses here
	If intLanguageID = "" Then
		intLanguageID = 1
	End If
	
	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRs = Nothing
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	With oCmd
		.CommandText = "spPDITendencySelect"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		.Parameters.Append .CreateParameter("@HighFactorType", 129, 1, 1, HighType1)
		.Parameters.Append .CreateParameter("@intLanguageID", 3, 1, 4, intLanguageID)
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	If oConn.Errors.Count < 1 Then
		If oRs.EOF = FALSE Then
			oRs.MoveFirst %>
		<div align="center">
		<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="85%">
			<tr>
				<td valign="top" align="center" width="33%">
					<img src="DISCCompositeSmall.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" alt="" /><br />
					<strong><%=strTextComposite & " " & strTextGraph%></strong>
				</td>
				<td valign="top" align="left" width="67%">
					<table border="0" cellspacing="0" cellpadding="6" width="100%">
						<tr>
							<td valign="top" align="left"><strong><%=strTextStrengths%></strong></td>
							<td valign="top" align="left"><strong><%=strTextWeaknesses%></strong></td>
						</tr>
		<% Do While oRs.EOF = FALSE %>
						<tr>
							<td valign="top" align="left"><%=oRs("TendencyS")%></td>
							<td valign="top" align="left"><%=oRs("TendencyW")%></td>
						</tr>
<% 			oRs.MoveNext
		Loop %>
					</table>
				</td>
			</tr>
		</table>
		</div>
		
<%	End If
Else
	Response.Write strTextErrorRetrievingStrengthsAndWeaknesses
	Response.End
End If %>

<br /><br /><%=strText1ReviewTheListsAboveWhatCreative%>
<br /><br />
<ul style="list-style-type: none">
	<li>
	<!--#Include FILE="Include/divider.asp" --><br />
	<!--#Include FILE="Include/divider.asp" --><br />
	<!--#Include FILE="Include/divider.asp" --><br />
	<!--#Include FILE="Include/divider.asp" --><br />
	<!--#Include FILE="Include/divider.asp" --><br />
	</li>
</ul>

<br />

<%
Response.Write strText2IdentifyingAndAcknowledgingThePresence & VbCrLf
Response.Write "<br>" & VbCrLf
Response.Write "<ul style=""list-style-type: lower-alpha"">" & VbCrLf
Response.Write "	<li><em>" & strTextDevelopCompensatingSkills & "</em>: " & strTextRememberThatTheWeaknessesOnThisListAreNot & "</li>" & VbCrLf
Response.Write "	<li><em>" & strTextRecognizeYourVulnerabilityAndPrepareFor & "</li>" & VbCrLf
Response.Write "	<li><em>" & strTextStaffToYourWeaknesses & "</em>: " & strTextSynergyFlowsFromDiversityIdentifying & "</li>" & VbCrLf
Response.Write "</ul>" & VbCrLf
%>


<p style="page-break-after: always">
<!--***** End Page 12a *****-->

<!--***** Begin Page 12 *****-->
<h2><i><%=strTextStrengthsAndWeaknesses%></i></h2>
<hr>
<h1><%=strTextPossibleStrengths%></h1>
<!-- The reference below was absolute ("www.pdiprofile.com/pdi/..."). I changed it to relative. Marc L. Porlier 12/5/2004 -->
<img src="SWStrengthsChart.asp?TCID=<%=TestCodeID%>&LC=<%=strLanguageCode%>">
<br><br>

<p style="page-break-after: always">
<!--***** End Page 12 *****-->

<!--***** Begin Page 13 *****-->
<h2><i><%=strTextStrengthsAndWeaknesses%></i></h2>
<hr>
<h1><%=strTextPossibleWeaknesses%></h1>
<!-- The reference below was absolute ("www.pdiprofile.com/pdi/..."). I changed it to relative. Marc L. Porlier 12/5/2004 -->
<img src="SWWeaknessesChart.asp?TCID=<%=TestCodeID%>&LC=<%=strLanguageCode%>">
<br>

<p style="page-break-after: always">
<!--***** End Page 13 *****-->

<!--***** Begin Page 14 *****-->
<h1><%=strTextYourUniqueStyle & ": " & strTextObservableTraits%></h1>
<h2><i><%=strTextAFurtherDescriptionOfYourBehavior%></i></h2>
<hr>
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr> 
	  	<td valign="top" align="center" width="120">
			<img src="DISCCompositeSmall.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" alt="" /><br/>
			<strong><%=strTextCompositeGraph%></strong>
		</td>
	  	<td valign="top">
			<br><br><%=strTextTheseRatiosProvideAdditionalInformation%>
		</td>
	</tr>
</table>
<%
Set oConn = Nothing
Set oCmd = Nothing
Set oRs = Nothing
Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
Set oRs = CreateObject("ADODB.Recordset")
With oCmd
	.CommandText = "spTestSummaryCustomProfileViewSelect"
	.CommandType = 4
	.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	.Parameters.Append .CreateParameter("@PDITestSummaryID",3, 1,4, PDITestSummaryID)
End With
oConn.Open strDbConnString
oCmd.ActiveConnection = oConn
oRs.CursorLocation = 3
oRs.Open oCmd, , 0, 1
If oConn.Errors.Count < 1 Then
	If oRs.EOF = FALSE Then
		oRs.MoveFirst
		'Response.Write "<STRONG><font size=4>Strong</font></strong><font size=3> - These have a difference of 20 or more.</font>"
		'Response.Write "<br><br>" %>
		<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
<% Do While oRs.EOF = False
			If oRs("PDICustomProfileName") = "DOverI" AND oRs("CustomProfileType") = "S" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/doveri.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strDOVERI_Title%></h2>
						<p><%=strDOVERI%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "DOverS" AND oRs("CustomProfileType") = "S" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/dovers.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strDOVERS_Title%></h2>
						<p><%=strDOVERS%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "DOverC" AND oRs("CustomProfileType") = "S" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/doverc.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strDOVERC_Title%></h2>
						<p><%=strDOVERC%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "IOverD" AND oRs("CustomProfileType") = "S" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/ioverd.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strIOVERD_Title%></h2>
						<p><%=strIOVERD%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "IOverS" AND oRs("CustomProfileType") = "S" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/iovers.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strIOVERS_Title%></h2>
						<p><%=strIOVERS%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "IOverC" AND oRs("CustomProfileType") = "S" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/ioverc.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strIOVERC_Title%></h2>
						<p><%=strIOVERC%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "SOverD" AND oRs("CustomProfileType") = "S" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/soverd.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strSOVERD_Title%></h2>
						<p><%=strSOVERD%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "SOverI" AND oRs("CustomProfileType") = "S" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/soveri.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strSOVERI_Title%></h2>
						<p><%=strSOVERI%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "SOverC" AND oRs("CustomProfileType") = "S" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/soverc.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strSOVERC_Title%></h2>
						<p><%=strSOVERC%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "COverD" AND oRs("CustomProfileType") = "S" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/coverd.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strCOVERD_Title%></h2>
						<p><%=strCOVERD%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "COverI" AND oRs("CustomProfileType") = "S" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/coveri.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strCOVERI_Title%></h2>
						<p><%=strCOVERI%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "COverS" AND oRs("CustomProfileType") = "S" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/covers.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strCOVERS_Title%></h2>
						<p><%=strCOVERS%></p>
					</td>
				</tr>
<%
			End If
			oRs.MoveNext
		Loop
		oRs.MoveFirst
		'Response.Write "<STRONG><font size=4>Moderate</strong><font size=3> - These have a difference of less than 20.</font>"
		'Response.Write "<br><br>"
		Do While oRs.EOF = FALSE
			If oRs("PDICustomProfileName") = "DOverI" AND oRs("CustomProfileType") = "M" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/doveri.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strDOVERI_Title%></h2>
						<p><%=strDOVERI%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "DOverS" AND oRs("CustomProfileType") = "M" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/dovers.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strDOVERS_Title%></h2>
						<p><%=strDOVERS%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "DOverC" AND oRs("CustomProfileType") = "M" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/doverc.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strDOVERC_Title%></h2>
						<p><%=strDOVERC%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "IOverD" AND oRs("CustomProfileType") = "M" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/ioverd.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strIOVERD_Title%></h2>
						<p><%=strIOVERD%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "IOverS" AND oRs("CustomProfileType") = "M" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/iovers.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strIOVERS_Title%></h2>
						<p><%=strIOVERS%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "IOverC" AND oRs("CustomProfileType") = "M" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/ioverc.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strIOVERC_Title%></h2>
						<p><%=strIOVERC%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "SOverD" AND oRs("CustomProfileType") = "M" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/soverd.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strSOVERD_Title%></h2>
						<p><%=strSOVERD%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "SOverI" AND oRs("CustomProfileType") = "M" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/soveri.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strSOVERI_Title%></h2>
						<p><%=strSOVERI%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "SOverC" AND oRs("CustomProfileType") = "M" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/soverc.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strSOVERC_Title%></h2>
						<p><%=strSOVERC%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "COverD" AND oRs("CustomProfileType") = "M" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/coverd.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strCOVERD_Title%></h2>
						<p><%=strCOVERD%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "COverI" AND oRs("CustomProfileType") = "M" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/coveri.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strCOVERI_Title%></h2>
						<p><%=strCOVERI%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "COverS" AND oRs("CustomProfileType") = "M" Then %>
				<tr>
					<td valign="top" width="39"><img src="images/covers.gif" width="27" height="34" alt="" /></td>
					<td valign="top">
						<h2><%=strCOVERS_Title%></h2>
							
						<p><%=strCOVERS%></p>
					</td>
				</tr>
			<% ElseIf oRs("PDICustomProfileName") = "DEQUALC" Then %>
				<tr>
					<td valign="top" width="69"><img src="images/dequalc.gif" width="57" height="25" alt="" /></td>
					<td valign="top">
						<h2><%=strDEQUALC_Title%></h2>
						<p><%=strDEQUALC%></p>
					</td>
				</tr>
			<% End If
			oRs.MoveNext
		Loop %>
		</table>
<%
	End If
End If
Set oConn = Nothing
Set oCmd = Nothing
Set oRs = Nothing
%>
<p style="page-break-after: always">

<!-- #Include File = "reportgeneration/compatmatrix.asp" -->

<!p style="page-break-after: always">
<!--***** End Page 14 *****-->

<!--***** Begin Page 15 *****-->
<%
If intLanguageID = 4 Then
	Response.Write "<h1>" & strTextTheDISCProfileSystem & "</h1>" & VbCrLf
	Response.Write "<hr>" & VbCrLf
	Response.Write strTextTheDISCProfileSystemIsAFamilyOfInstruments & VbCrLf
	Response.Write "<br><br>" & strTextThePDITheBasicModuleProvides & VbCrLf
	Response.Write "<br><br>" & strTextTheDISCProfileSystemIncludesASeriesOfApplication & VbCrLf
	Response.Write "<br><br><strong>" & strTextFiveApplicationModulesAreAvailable & "</strong>" & VbCrLf
	Response.Write "<ul>" & VbCrLf
	Response.Write "<li>" & VbCrLf
	Response.Write "		<strong>" & strTextTeamworkWithStyle & "</strong>" & VbCrLf
	Response.Write "		<br />" & strTextEachTemperamentBringsUniqueStrengthsAnd & VbCrLf
	Response.Write "	</li>" & VbCrLf
	Response.Write "	<li>" & VbCrLf
	Response.Write "		<strong>" & strTextLeadingWithStyle & "</strong><br />" & VbCrLf
	Response.Write strTextOurBehavioralTraitsAreNotOnlyAMajor & VbCrLf
	Response.Write "	</li>" & VbCrLf
	Response.Write "	<li>" & VbCrLf
	Response.Write "		<strong>" & strTextCommunicatingWithStyle & "</strong><br />" & VbCrLf
	Response.Write strTextThisModuleWillHelpYouRecognizeHow & VbCrLf
	Response.Write "	</li>" & VbCrLf
	Response.Write "<li>" & VbCrLf
	Response.Write "		<strong>" & strTextSellingWithStyle & "</strong><br />" & VbCrLf
	Response.Write strTextBehavioralStyleNotOnlyInfluencesHow & VbCrLf
	Response.Write "	</li>" & VbCrLf
	Response.Write "</ul>" & VbCrLf
End If
%>

<!--***** End Page 15 *****-->



<!--************* E N D  R E P O R T *************-->
</body>
</html>