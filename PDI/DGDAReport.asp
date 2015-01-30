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
<!-- #Include File = "Include/Common.asp" -->
<!-- #Include File = "Include/PDIBehavioralRelationships.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
	<!-- #Include File = "Include/HeadStuff.asp" -->
</head>
<body>
<%
Dim intUserID
intUserID = Request.QueryString("u")
If CStr(intUserID) = "" Then
	intUserID = Request.Cookies("UserID")
End If
If CStr(intUserID) = "" Then
	intUserID = 0
Else
	intUserID = CLng(intUserID)
End If

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

nTableWidth = 600
PDITestSummaryID = Request.QueryString("SID")
TestCodeID = Request.QueryString ("TCID")

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
	If Not oRs.EOF Then
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
		Response.Write "<br><br>" & strTextErrorInCreatingPDFReportPlease
		Response.End
	End If
Else
	Response.Write "<br><br>" & strTextErrorInCreatingPDFReportPlease
	Response.Write "<br><br>-" & oConn.Errors.Count
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
<p style="page-break-after: always"></p>
<!--***** End Page 1 *****-->

<!--***** Begin Page 2 *****-->
<h1><%=strTextPersonalDISCernmentInventoryRegMark%></h1>
<h2><i><%=strTextIncreasingPersonalEffectiveness%></i></h2>
<hr>

<br>
<% 	If strSiteType = "DG" Then %>
		<img class="report_image_left" align="left" src="images/TakingDISC_TDG.gif"  alt="" />
<% 	Else %>
		<img class="report_image_left" align="left" src="images/TakingDISC.gif"  alt="" />
<%
	End If
	Response.Write "<br><br>" & strTextEachOfUsHasStrengthsAndWeaknessesThat
	Response.Write "<br><br>" & strTextTheAbilityToPredictHowWeAndOtherPeopleWill
	Response.Write "<br><br>" & strTextBehaviorIsInfluencedByANumberOf
	Response.Write "<br><br>" & strTextManyOfUsHavediscoveredThatTheMoreWeKnow
	Response.Write "<br><br>" & strTextThePDIWillEnableYouToDiscoverAndDefine
%>
<br><hr>
<!--#Include FILE="Include/footercopyright.asp" -->
<p style="page-break-after: always"></p>
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
	Response.Write "<br><br><strong>II. " & strTextPrivateConcept & "</strong> (" & strLEASTResponses & "): " & strTextThisIsYourNaturalBehaviorWhatYou & VbCrLf
	Response.Write "<br><br><strong>III. " & strTextPublicConcept & "</strong> (" & UCase(strTextCOMPOSITE) & "): " & strTextTheCompositeGraphRepresentsTheNet & VbCrLf
	Response.Write "<br><hr>" & VbCrLf
%>
<!--#Include FILE="Include/footercopyright.asp" -->
<p style="page-break-after: always"></p>
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
	Response.Write "<br><hr>" & VbCrLf
%>
<!--#Include FILE="Include/footercopyright.asp" -->
<p style="page-break-after: always"></p>
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
	Response.Write "<br><br><hr>" & VbCrLf
%>
<!--#Include FILE="Include/FooterCopyright.asp" -->
<p style="page-break-after: always"></p>
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
<!-- #Include File = "Include/FooterCopyright.asp" -->
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
<br><br><hr>
<!-- #Include File = "Include/FooterCopyright.asp" -->
<p style="page-break-after: always"></p>
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
<hr>
<!--#Include FILE="Include/footercopyright.asp" -->
<p style="page-break-after: always"></p>
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
		Response.Write "				<td valign=""top"" align=""left">"" & VbCrLf
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
End If
%>
<hr>
<p style="page-break-after: always"></p>
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
If nRepProfile1 >= 1 and nRepProfile1 <= 28 Then %>
<hr>
<!--#Include FILE="Include/footercopyright.asp" -->
<p style="page-break-after: always"></p>
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
	<table border="0" cellspacing="0" cellpadding="6" width="100%">
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
					
					<h2><%=strDreamTitle%></h2>
					<p><%=strDreamText%></p>
				<% End If %>
			</td>
		</tr>
	</table>
<%
End If %>
<hr>
<p style="page-break-after: always"></p>
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

<!--***** End Page 11 *****-->

<!--***** Begin Page 12a *****-->
<%
'Response.Write "<h2><i>" & strTextStrengthsAndWeaknesses & "</i></h2>" & VbCrLf
'Response.Write "<hr>" & VbCrLf
Response.Write strText2IdentifyingAndAcknowledgingThePresence & VbCrLf
Response.Write "<br>" & VbCrLf
Response.Write "<ul style=""list-style-type: lower-alpha"">" & VbCrLf
Response.Write "	<li><em>" & strTextDevelopCompensatingSkills & "</em>: " & strTextRememberThatTheWeaknessesOnThisListAreNot & "</li>" & VbCrLf
Response.Write "	<li><em>" & strTextRecognizeYourVulnerabilityAndPrepareFor & "</li>" & VbCrLf
Response.Write "	<li><em>" & strTextStaffToYourWeaknesses & "</em>: " & strTextSynergyFlowsFromDiversityIdentifying & "</li>" & VbCrLf
Response.Write "</ul>" & VbCrLf
%>
<hr>
<!--#Include FILE="Include/footercopyright.asp" -->
<p style="page-break-after: always"></p>
<!--***** End Page 12a *****-->

<!--***** Begin Page 12 *****-->
<h2><i><%=strTextStrengthsAndWeaknesses%></i></h2>
<hr>
<h1><%=strTextPossibleStrengths%></h1>
<img src="http://www.pdiprofile.com/pdi/SWStrengthsChart.asp?TCID=<%=TestCodeID%>&LC=<%=strLanguageCode%>">
<br><br><hr>
<!--#Include FILE="Include/footercopyright.asp" -->
<p style="page-break-after: always"></p>
<!--***** End Page 12 *****-->

<!--***** Begin Page 13 *****-->
<h2><i><%=strTextStrengthsAndWeaknesses%></i></h2>
<hr>
<h1><%=strTextPossibleWeaknesses%></h1>
<img src="http://www.pdiprofile.com/pdi/SWWeaknessesChart.asp?TCID=<%=TestCodeID%>&LC=<%=strLanguageCode%>">
<br><hr>
<!--#Include FILE="Include/footercopyright.asp" -->
<p style="page-break-after: always"></p>
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
<hr>
<!--#Include FILE="Include/footercopyright.asp" -->
<p style="page-break-after: always"></p>
<!--***** End Page 14 *****-->

<!--***** Begin Page 15 *****-->
<%
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
%>

<ul>
	<li>
		<strong><%=strTextTimeManagementWithStyle%></strong><br />
		<%=strTextOurPersonalitiesOftenDetermineOur%>
	</li>
</ul>
<br><%=strTextForMoreInformationCallTeamResourcesIncAt%>
<hr>
<!--#Include FILE="Include/footercopyright.asp" -->
<p style="page-break-after: always"></p>
<!--***** End Page 15 *****-->

<!--*********** E N D OF PDI  R E P O R T ***********-->


<!--*** BEGINNING OF DREAM ASSESSMENT REPORT ********-->
<%
			Dim strTopPgSpacing
			Dim AppModTitleFont
			Dim EndAppModTitleFont
			Dim AppModHugeFont
			Dim AppModParaFont
			Dim EndAppModParaFont
			
			strTopPgSpacing = "<center><img SRC='ReportGeneration/images/DreamAssessmentTopBanner2.jpg' width='600' height='83'></center><br><br>"
			AppModBigGreyFont = "<strong><font face='helvetica,arial,sans-serif' size=7 color='#999999'>"
			AppModHugeFont = "<strong><font face='helvetica,arial,sans-serif' size=5>"
			AppModTitleFont = "<strong><font face='helvetica,arial,sans-serif' size=4>"
			EndAppModTitleFont = "</strong></font>"
			AppModParaFont = "<p><font face='verdana,helvetica,arial,sans-serif'>"
			EndAppModParaFont = "</font></p>"
%>

<br><br><br><br><br>
<font face="helvetica,arial,sans-serif">
<wxprinter PageBreak><%=strTopPgSpacing%>
<%=AppModParaFont%>
<center>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<IMG SRC="ReportGeneration/images/DreamAssessmentTitle2.jpg" WIDTH="600" HEIGHT="430" ALT="">
			<br><br><br><br><br><br>
			<%=strUserName%><br><%=TestDate%>
			<br>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>
</center>
<br><br>
<p style="page-break-after: always"></p>


<wxprinter PageBreak><%=strTopPgSpacing%>
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
<%=AppModParaFont%>
<%=AppModTitleFont%>
<i>Welcome to the Dreamscape...</i>
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Everyone's personality contains both strengths and weaknesses. In many cases our
weaknesses are simply our strengths taken to extremes. For example, perseverance 
can become stubbornness, or optimism can become overconfidence.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
When we find ourselves in an environment that lends itself to our strengths, we 
generally move quickly and easily through that situation. On the other hand, when 
we find ourselves in a circumstance that highlights our weaknesses, the going gets 
extremely difficult.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
So it is at various stages along the way to fulfilling our dream. Certain stages 
will pose greater challenges than others, largely because of our personal style 
and the environment in which that style excels or struggles.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Think about your own style as you identified it in the Personal DISCernment 
Inventory. How do you respond to change? What is your risk tolerance? What 
about peer pressure-from a large group or a single person? Do you need quick 
results, or can you persevere without seeing much progress? How do you handle 
conflict, either external or internal? Disapproval? Delay? Let's look at the 
various places you will visit on the way to fulfilling your Dream and explore 
the major issue or challenge that each one presents.
<%=EndAppModParaFont%>
</td></tr></table>
</center>

<center>
<%=AppModParaFont%>
<br>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<tr>
		<td align="left" width="100">
			<img SRC="ReportGeneration/images/feather2.jpg" WIDTH="96" HEIGHT="125">
		</td>
		<td align="left">
			<table width="460" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<tr>
						<%=AppModParaFont%>
							<%=AppModTitleFont%>
								<i>Stage 1: Recognizing and Embracing the Dream</i>
							<%=EndAppModTitleFont%>
							<br>
							<br><strong>Issue:</strong> <i>Purpose</i>
							<br><strong>Fear:</strong> <i>Inadequacy or Lack of Understanding</i>
							<br><strong>Valuable Attributes:</strong> <i>Perceptive, Discerning, Open, Prepared</i>
						<%=EndAppModParaFont%>
					</tr>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<table WIDTH="600" BORDER="0" CELLSPACING="1" CELLPADDING="1" align="center"><tr><td align="left">
<%=AppModParaFont%>At this point, the Dreamer is still safely in the land 
of the Familiar, in his recliner in front of the mesmerizing box. Over time, 
as he realizes that something very big is missing from his life, and he 
begins to realizes that he was born to do whatever the Dream requires.
<%=EndAppModParaFont%>

<%=AppModParaFont%>Deciding to pursue the Dream involves making hard choices 
and difficult changes. People who resolve to pursue the Dream struggle with 
denial and self doubt. "Maybe it's not the right time." "I'm not capable." 
"I'm trapped within my circumstances." "I have responsibilities." Embracing 
the Dream is the first step to pursuing it.
<%=EndAppModParaFont%>

<%=AppModParaFont%>Are you someone who chooses to grow in self-awareness? Do 
you spend a significant amount of time focused on the future, or do you feel 
more comfortable concentrating on the immediate and the tangible? Are you 
sensitive to nuances and open to discovering hidden meanings? Do you to take 
sole responsibility for situations or are you more comfortable operating as 
part of a group? Do you work better in a predictable pattern? Are you quick 
to make decisions or do you prefer to let time solve most problems?
<%=EndAppModParaFont%>
</td></tr></table>
</center>
<p style="page-break-after: always"></p>


<wxprinter PageBreak>
<%=strTopPgSpacing%>

<center>
<%=AppModParaFont%>
<br>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<tr>
		<td align="left" width="100">
			<img SRC="ReportGeneration/images/suitcase2.jpg" WIDTH="96" HEIGHT="125">
		</td>
		<td align="left">
			<table width="460" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<tr>
						<%=AppModParaFont%>
						<%=AppModTitleFont%>
							<i>Stage 2: Leaving the Comfort Zone and Encountering the Wall of Fear</i>
						<%=EndAppModTitleFont%>
						<br>
						<br><b>Issue:</b> <i>Change</i>
						<br><b>Fear:</b> <i>The Unknown</i>
						<br><b>Valuable Attributes:</b> <i>Goal-oriented, Confident, Decisive, Committed, Assertive</i>
						<%=EndAppModParaFont%>
					</tr>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td align="left">
<%=AppModParaFont%>Change is difficult for everyone. If it doesn't make us 
uncomfortable, it probably isn't change. However, some of us embrace change 
more quickly and enthusiastically than others. Some people tire easily of the 
status quo and look actively for new challenges and opportunities, while others 
long for the stability and familiarity of comfortable routine and well-known 
surroundings. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Regardless of our response to change, whenever we encounter 
the unknown or the deeply challenging, everyone, at some point, hits the 
invisible Wall of Fear-the deep-seated concerns that plague us all. It may be 
a fear of missing a goal, a fear of looking foolish, a fear of disapproval 
from those we admire, a fear of hurting or disappointing someone else, a fear 
of making a mistake or looking inept. We may even experience a fear of what we 
will happen if we actually do achieve our Dream. Sometimes what we want the 
most is also what we dread the most. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Are you more pleased with where you've been than where you 
might go? Do you tend to act on your own initiative or wait for instructions 
from others? Do you relish the opportunity to tackle new challenges, to strike 
out on your own into uncharted territory? Or, do you need to receive confirmation 
of the correctness of your actions from events or from others? Do you value 
predictable patterns? Do you need time to adjust to new situations? 
<%=EndAppModParaFont%>
</td></tr></table>
</center>

<center>
<br><br>
<%=AppModParaFont%>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<tr>
		<td align="left" width="100">
			<img SRC="ReportGeneration/images/boat2.jpg" WIDTH="90" HEIGHT="125">
		</td>
		<td align="left">
			<table width="460" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<tr>
						<%=AppModParaFont%>
						<%=AppModTitleFont%>
							<i>Stage 3: The Borderland</i>
						<%=EndAppModTitleFont%>
						<br>
						<br><b>Issue:</b> <i>Validation</i>
						<br><b>Fear:</b> <i>Fear of the Disapproval and Resistance of Others</i>
						<br><b>Valuable Attributes:</b> <i>Persuasive, Confident, Self-Reliant, Persistent</i>
						<%=EndAppModParaFont%>
					</tr>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td align="left">
<%=AppModParaFont%>The Borderland is filled with people whose own lives will be affected by the actions of someone pursuing a Dream. They are often people with whom we are close and whom we admire and respect. Pursuing the Dream may involve separation or even estrangement from those we respect, admire, or love.
<%=EndAppModParaFont%>

<%=AppModParaFont%>When we make difficult decisions, how easy is it for us to detach issues from people? How important are relationships in our everyday choices? Do we need the approval of others, and to what degree? How do we react when someone is obviously displeased with us or hurt by something we choose to do? How well can we differentiate between following a Dream and pursuing a selfish desire?
<%=EndAppModParaFont%>
</td></tr></table>
</center>
<p style="page-break-after: always"></p>


<wxprinter PageBreak><%=strTopPgSpacing%>

<center>
<%=AppModParaFont%>
<br>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<tr>
		<td align="left" width="100">
			<img SRC="ReportGeneration/images/tree2.jpg" WIDTH="95" HEIGHT="125">
		</td>
		<td align="left">
			<table width="460" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<tr>
						<%=AppModParaFont%>
						<%=AppModTitleFont%>
							<i>Stage 4: The Wasteland</i>
						<%=EndAppModTitleFont%>
						<br>
						<br><b>Issue:</b> <i>Unmet Expectations</i>
						<br><b>Fear:</b> <i>Not Knowing/Being Lost</i>
						<br><b>Valuable Attributes:</b> <i>Persistent, Patient, Calm, Optimistic, Adaptable</i>
						<%=EndAppModParaFont%>
					</tr>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td align="left">
<%=AppModParaFont%>The Wasteland is characterized by the absence rather than the presence of anything or anyone who poses a threat. It's barren and empty-miles and miles of nothing. Every attempt to overcome it or escape its dismal boundaries leads to a dead end. Day after day delivers a bitter sameness that makes no advancement toward the Dream.
<%=EndAppModParaFont%>

<%=AppModParaFont%>Are you someone who perseveres against great odds? How well do you deal with routine that seems to have little reward or shows limited progress? How do you deal with loneliness and isolation? How do you control disappointment and disillusionment? What happens when you feel betrayed? Do you need people around with whom you can talk through issues and setbacks?
<%=EndAppModParaFont%>
</td></tr></table>
</center>

<center>
<%=AppModParaFont%>
<br>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<tr>
		<td align="left" width="100">
			<img SRC="ReportGeneration/images/waterfall2.jpg" WIDTH="89" HEIGHT="125">
		</td>
		<td align="left">
			<table width="460" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<tr>
						<%=AppModParaFont%>
						<%=AppModTitleFont%>
							<i>Stage 5: Sanctuary</i>
						<%=EndAppModTitleFont%>
						<br>
						<br><b>Issue:</b> <i>Control</i>
						<br><b>Fear:</b> <i>Losing Control/Recognition for Achievement</i>
						<br><b>Valuable Attributes:</b> <i>Obedient, Adaptable, Accommodating, Trustworthy, Conscientious</i>
						<%=EndAppModParaFont%>
					</tr>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td align="left">
<%=AppModParaFont%>The Sanctuary is a place full of restoration, relief, and re-connection. It provides a time for self-evaluation and reflection. But it is also a place of surprises, an unexpected turn of events. After all the struggle, hardship, and self-denial, the pursuer of the Dream is asked to relinquish his or her control and possession of the Dream.
<%=EndAppModParaFont%>

<%=AppModParaFont%>Do you easily surrender control of something in which you have invested tremendous energy and emotions? How much do you need recognition for your achievements and hard work? Perhaps you are comfortable being a facilitator or an implementer, and the final credit for achievement isn't that important. Or, you may find it difficult to turn over something to another because you fear it may not retain the quality or precision that you can ensure when it's under your care. Perhaps it's difficult for you to comply with instructions that, in your opinion, just don't make any sense. You need to understand all the facts before you can make that kind of decision.
<%=EndAppModParaFont%>
</td></tr></table>
</center>
<p style="page-break-after: always"></p>


<wxprinter PageBreak><%=strTopPgSpacing%>
<%=AppModParaFont%>
<br>
<center>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<tr>
		<td align="left" width="100">
			<img SRC="ReportGeneration/images/sword2.jpg" WIDTH="94" HEIGHT="125">
		</td>
		<td align="left">
			<table width="460" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<tr>
						<%=AppModParaFont%>
						<%=AppModTitleFont%>
							<i>Stage 6: Valley of the Giants</i>
						<%=EndAppModTitleFont%>
						<br>
						<br><b>Issue:</b> <i>External Obstacles</i>
						<br><b>Fear:</b> <i>Failure/Loss of the Dream</i>
						<br><b>Valuable Attributes:</b> <i>Trusting, Resourceful, Alert, Self-Controlled, Courageous</i>
						<%=EndAppModParaFont%>
					</tr>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td align="left">
<%=AppModParaFont%>Whereas the Border Bullies oppose the person, the Giants oppose the Dream (task). This gigantic opposition may take the form of loss of resources, fierce opposition by a group, or any other intimidating circumstances, even including a health crisis in the life of the Dreamer. Unlike the Border Bullies, the Giants create obstacles that cannot be reasoned away or circumvented. Nor is overcoming them within the power of the Dreamer. Only the Dream Giver can handle these obstacles, and He will receive all the credit for doing so.
<%=EndAppModParaFont%>

<%=AppModParaFont%>Are you easily intimidated, particularly by big systems or powerful people? When circumstances turn out to be greater or more difficult than you anticipated, how do you respond? Do you tend to see overwhelming resistance as just another hurdle to surmount, or do you see its magnitude as validation that perhaps you shouldn't be attempting anything of this scale.
<%=EndAppModParaFont%>

<%=AppModParaFont%>How optimistic can you be when everything around you seems destined to fail? Is it easy or difficult for you to trust what you can't see or come to terms with logically? Are impossible situations a springboard to launch your creativity to the next level?
<%=EndAppModParaFont%>

<%=AppModParaFont%>When these obstacles are shattered, how do you deal with the fact that you yourself could not overcome them?
<%=EndAppModParaFont%>
</td></tr></table>
</center>

<center>
<%=AppModParaFont%>
<br>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<tr>
		<td align="left" width="100">
			<img SRC="ReportGeneration/images/hands2.jpg" WIDTH="99" HEIGHT="125">
		</td>
		<td align="left">
			<table width="460" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<tr>
						<%=AppModParaFont%>
						<%=AppModTitleFont%>
							<i>Stage 7: Land of Promise</i>
						<%=EndAppModTitleFont%>
						<br>
						<br><b>Issue:</b> <i>Sacrifice</i>
						<br><b>Fear:</b> <i>Success Behind for a New Unknown</i>
						<br><b>Valuable Attributes:</b> <i>Flexible, Open, Enterprising, Enthusiastic, Adaptable</i>
						<%=EndAppModParaFont%>
					</tr>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td align="left">
<%=AppModParaFont%>The Land of Promise is the place where Big Needs match the Big Dream. And when this convergence occurs, the time to do the Dream has arrived-meeting the Big Needs by doing what one loves most. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>The further the Dreamer goes into doing the Dream, however, he once again feels the uncomfortable pull that leads him to yet another distant Unknown, and on the horizon he sees many more Valleys, and Wide Waters, and Lands of Promise. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>How difficult is it for you to look at something you have created with fresh eyes? Would you rather continue to refine and develop an existing situation rather than change it completely or move on to something else? How do you feel about leaving your achievements in the care of others who lack your experience and/or commitment? 
<%=EndAppModParaFont%>
</td></tr></table>
</center>
<p style="page-break-after: always"></p>


<wxprinter PageBreak><%=strTopPgSpacing%>
<br>

<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
<%=AppModParaFont%>
<%=AppModTitleFont%>
<i>Style and the Seven Stages </i>
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>
</td></tr><tr><td align="left">
<%=AppModParaFont%>Each place on the Dreamscape poses different challenges, deals with different issues, strikes at different fears, and requires different aptitudes and abilities. Rarely does one personal style possess all the strengths that are necessary at each stage of the journey. Some stages require decisive action, while others demand patience and endurance. At times the journey demands confidence, enthusiasm, and assertiveness; at other points, the need is for accommodation, self-sacrifice, adaptability, and precision. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>This application report will help you recognize how the particular strengths and weakness of your style will impact your Dream Journey. You will find that in certain stages your personal style may have strengths that assist you in meeting the challenges. However, in other stages along the way, you may need to find ways to overcome the weakness of your particular style. You can successfully navigate through the entire process to achieve your Dream, but in some instances you will need to create an action plan to help you compensate for the particular challenges that a stage presents.
<%=EndAppModParaFont%>

<%=AppModParaFont%>This application report can be a valuable tool, along with other resources, to help you arrive safely at the Land of Promise. Wherever you are in your Dreamscape, increasing your self-awareness will be of great help to you in completing the Journey to your Big Dream.
<%=EndAppModParaFont%>
</td></tr></table>

<br>
<br>
<br>
<br>
<br>
<br>
<p style="page-break-after: always"></p>



<wxprinter PageBreak><%=strTopPgSpacing%>
<center>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		<i>The Styles and Dreaming: an Overview</i>
	<%=EndAppModTitleFont%>

	<img SRC="ReportGeneration/images/PDID_High_D.jpg" WIDTH="269" HEIGHT="152" align="right">
	<table WIDTH="400" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="left">
		<tr>
			<td align="left">
				<%=AppModParaFont%>
				<%=AppModTitleFont%>
					High D
				<%=EndAppModTitleFont%>
				<br><b>Focus:</b> <i>Overcoming Opposition to Achieve the Dream</i>
				<br><b>Motivation:</b> <i>Challenge/Adventure</i>
				<br><b>Basic Intent:</b> <i>To Overcome, to Triumph</i>
				<br><b>Greatest Fear:</b> <i>Loss of Control/Being Blocked from Achieving Goal</i>
				<%=EndAppModParaFont%>
			</td>
		</tr>
	</table>
</td></tr></table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td align="left">
<%=AppModParaFont%>D quadrant people are active and task-oriented. Not usually much for extended self-reflection and inner conflict, D's will act quickly when the Dream is revealed to them. A High D won't need too many details; he or she will accumulate information on a need-to-know basis. They are energized by the fact that it's their goal rather than someone else's. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Leaving the Comfort Zone will not create much anxiety in a D. By nature, they hate routine and are prone to changing jobs until they find the challenge they need. Their encounter with the Wall of Fear should be short-lived. Since D's embrace change and risk, the only fear associated with the Wall would be the inability to surmount it-the Wall's potential ability to control the D. Once they realize that the Wall is an invisible barrier, they move through it easily.
<%=EndAppModParaFont%>

<%=AppModParaFont%>The Border Bullies will not deter the D Dreamer significantly. D's are real individualists and very self-sufficient. Once they set their course, other people have limited influence. They will make a token attempt to state their case, and then move on. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>One of the more difficult stages of the DreamScape will be when a D finds him or herself alone in the Wasteland. D's thrive on keeping their eye on the Goal, and the frustrating delay and doubt, without the encouragement of making progress, will be extremely maddening. However, the Ds' dogged perseverance will see them through.
<%=EndAppModParaFont%>

<%=AppModParaFont%>Sanctuary will create perhaps the biggest challenge for the goal-oriented D, when he or she attains the summit and sees the Land of Promise on the Horizon. Not surprisingly, the High D's difficulty with relinquishing control will be acute at this critical juncture. Making the right choice, however, the D will overcome the tendencies of his or her personal style and surrender the Dream to the Dream Giver, comforted by the knowledge that the Dream is now even more significant. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>The D Dreamer is a fighter and a striver, and he or she rarely shirks conflict. The Land of the Giants calls on a D's affinity for competition, tough assignments, stressful situations, and huge demands. Even though D's like to be in charge, the fact that the Dream Giver receives the credit is not inordinately troubling to D Dreamers as long as it moves them ever closer to their goals. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Thriving in the Promised Land, with its ever-increasing demands and overwhelming needs is exhilarating to the D, but as he or she arrives at the back gate of the city, a familiar and uncomfortable pull exerts its influence. The D Dreamer is ready to take on the next Dream and encounter bigger and bolder opportunities. The High D's discontent with the status quo creates the motivation to pursue a new Dream.
<%=EndAppModParaFont%>
</td></tr></table>
</center>
<p style="page-break-after: always"></p>


<wxprinter PageBreak><%=strTopPgSpacing%>
<%=AppModParaFont%>
<center>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
	<img SRC="ReportGeneration/images/PDID_High_I.jpg" WIDTH="242" HEIGHT="168" align="right">
	<table WIDTH="400" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="left">
		<tr>
			<td align="left">
				<%=AppModParaFont%>
				<%=AppModTitleFont%>
					High I
				<%=EndAppModTitleFont%>
				<br><b>Focus:</b> <i>Motivating and Aligning Others in Achieving the Dream</i>
				<br><b>Motivation:</b> <i>Recognition/Approval</i>
				<br><b>Basic Intent:</b> <i>To Persuade/Energize</i>
				<br><b>Greatest Fear:</b> <i>Lack of Recognition for Accomplishments or Failure that Creates Negative Recognition</i>
				<%=EndAppModParaFont%>
			</td>
		</tr>
	</table>
</td></tr></table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td align="left">
<%=AppModParaFont%>High I's, because of their innate optimism and enthusiasm, are quick to grasp new ideas and see the big picture. Because they seek recognition for their achievements, Big Dreams are part and parcel of their plans. Their natural energy and enthusiasm tend to make them restless and eager to try new things, particularly if they are able to gain agreement from other people in their endeavors. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Change is not particularly unsettling to them, as they are poised and at ease with strangers and new environments, both at work and in social situations. High I's will pursue the Dream with innovation and creativity, being willing to try new or non-traditional approaches. But as they come to the end of this stage, they encounter their particular Wall of Fear: "What if the Dream isn't a success? What if others disapprove of it?"
<%=EndAppModParaFont%>

<%=AppModParaFont%>That same concern with the recognition and approval of others makes the resistance of the Border Bullies particularly troubling to this people-focused Dreamer. Fortunately, High I's can be amazingly persuasive and excellent at getting others on board, so their powers of influence and their confidence will aid them in this situation. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Although the Wasteland will be frustrating and lonely for the people-oriented High I, their innate belief that things will turn out well will help them get through this tough period. And although surrendering the Dream to the Dream Giver at Sanctuary may be difficult, the I's urge to please and be admired will enable him or her to relinquish with grace, believing that it's ultimately for the best and will win the Dream Giver's approval. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Task-based obstacles pose difficult times for High I's because they are more accustomed to solving problems through people. For this reason, High I's will do well in some encounters in the Land of the Giants and struggle in others-depending on whether the obstacle involves systems or people. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Once High I's reach the Land of Promise, they are in their element-successful, interactive, affiliated, and probably admired. The recognition and esteem that come from their accomplishments in meeting the Big Needs fuels their energy to work even harder. They will experience mixed feelings when it is time to pursue a different and bigger Dream. But it's also their nature to look for the next great experience.
<%=EndAppModParaFont%>
</td></tr></table>
</center>
<p style="page-break-after: always"></p>


<wxprinter PageBreak><%=strTopPgSpacing%>
<%=AppModParaFont%>
<center>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
	<img SRC="ReportGeneration/images/PDID_High_S.jpg" WIDTH="239" HEIGHT="139" align="right">
	<table WIDTH="400" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="left">
		<tr>
			<td align="left">
				<%=AppModParaFont%>
				<%=AppModTitleFont%>
					High S
				<%=EndAppModTitleFont%>
				<br><b>Focus:</b> <i>Pursuing the Dream within the Status Quo</i>
				<br><b>Motivation:</b> <i>Appreciation</i>
				<br><b>Basic Intent:</b> <i>To Support/Align</i>
				<br><b>Greatest Fear:</b> <i>Conflict/Damage to Relationships/Sudden Change</i>
				<%=EndAppModParaFont%>
			</td>
		</tr>
	</table>
</td></tr></table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td align="left">
<%=AppModParaFont%>The High S's supportive and compassionate nature makes them particularly receptive to Dreams that involve service to others. Meeting needs is part of their relationship-based approach. However, High S's are by nature realistic and down-to-earth. The magnitude of the Dream may make it initially difficult for them to embrace. The High S will most likely spend extra time in the first stage of the Dream Journey, processing the idea, adjusting to the necessary change ahead, and planning for it. For the same reason, leaving the Comfort Zone may take more time, perhaps even occurring in stages. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>The Wall of Fear for High S's will relate to the possibility that their Dream may cause discomfort and pain in others. Since S's are responsive and relationship-oriented, they are most sensitive to how their actions affect close associates-friends, family, valued coworkers. The Border Bullies will pose almost overwhelming obstacles for the S, as they work best in situations where everyone stays involved in solving problems, making decisions, and reviewing progress. To strike out on one's own, without the endorsement and support of those close to the High S will be difficult indeed. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Once in the Wasteland, however, the S's even-tempered, low-key, emotionally mature nature will serve well during this difficult period. High S's are patient, predictable, and dogged in pursuit of a goal. The problems of this part of the journey will not be overwhelming. Once through the Wasteland and into the Sanctuary, the S will experience great contentment. Although they will feel a strong sense of ownership or possession about the Dream and may experience some internal disappointment about relinquishing it, turning over the Dream to the Dream Giver will be consistent with the S's supportive and amiable personal style. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>The S will have difficulty with the conflict and upheavals that occur in the Land of the Giants, but he or she will be persistent in working to overcome these external obstacles to the task. Further, a High S will be willing and happy to see the glory assigned to the Dream Giver when miraculous solutions dispel the threats to the Dream. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Once in the Land of Promise where the S's Dream meets the Big Need, the S will be in an environment that coincides with the S's natural strengths-serving, supporting, and collaborating. Because of the S's desire to maintain the status quo, however, expanding, re-shaping, and redefining the Dream leading to a new cycle will not be easy. The tendency will be to stay and work with the current demands. As in the first sequence, the S will need more time to process the concept of the New Dream and once again move out of the Comfort Zone.
<%=EndAppModParaFont%>
</td></tr></table>
</center>
<p style="page-break-after: always"></p>


<wxprinter PageBreak><%=strTopPgSpacing%>
<%=AppModParaFont%>
<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
<img SRC="ReportGeneration/images/PDID_High_C.jpg" WIDTH="258" HEIGHT="130" align="right">
	<table WIDTH="400" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="left">
		<tr>
			<td align="left">
				<%=AppModParaFont%>
				<%=AppModTitleFont%>
					High C
				<%=EndAppModTitleFont%>
				<br><b>Focus:</b> <i>Pursuing the Right Dream with the Highest Standards</i>
				<br><b>Motivation:</b> <i>Security/Accuracy</i>
				<br><b>Basic Intent:</b> <i>To Be Correct/Prepared</i>
				<br><b>Greatest Fear:</b> <i>Making a Mistake</i>
				<%=EndAppModParaFont%>
			</td>
		</tr>
	</table>
</td></tr></table>
<%=EndAppModParaFont%>

<table WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td align="left">
<%=AppModParaFont%>The High C will embrace a Dream only after doing the due diligence necessary to come to a measured and painstaking decision. He or she will research the subject extensively, pursuing the answers to a seemingly endless supply of questions. Weighing the pros and cons of following the Dream will take considerable time and energy, but once the plan is in place the C will be unwaveringly committed. Leaving the Comfort Zone will be easier for the High C if he or she has gathered facts and developed a system with adequate checkpoints and clearly defined goals.
<%=EndAppModParaFont%>

<%=AppModParaFont%>For the High C, the Wall of Fear symbolizes the concern that perhaps he or she isn't going in the right direction and is headed into harm's way. Once through the Wall, however, the C's confrontation with the Border Bullies is characterized by his or her attempt to explain logically why the decision is a right one. Even though the C prefers to avoid conflict, because the High C is more task-oriented than relationship-focused, he or she can be more objective in dealing with the resistance from people when fortified with an internal assurance about the rightness of the task.
<%=EndAppModParaFont%>

<%=AppModParaFont%>The Wasteland will be troubling to the High C because things aren't going according to plan. The delay and seeming chaos will cause this person to question and second-guess the decision. "If it's the right decision, then things should be turning out the way I planned!" Therefore, choosing to follow the path of Faith may be difficult for the C and will be an option only as a last resort.
<%=EndAppModParaFont%>

<%=AppModParaFont%>Sanctuary provides validation for the High C's decisions, who welcomes the safety and security of this stage. However, the Dream Giver's request for the Dream is most unsettling to the High C who wants to go by the book and not deviate from the original plan. High C's believe inherently that if you want something done right, you must do it yourself, and relinquishing control of a task is difficult.
<%=EndAppModParaFont%>

<%=AppModParaFont%>Circumstances in the Land of the Giants conflict with the C's desire to avoid trouble and turmoil. Even with all the careful planning, obstacles to the Dream are everywhere and ominous. Yet since the C sees the world as challenging, he or she isn't overly surprised by the turn of events and diligently looks for ways to solve problems. At times, solutions that occur miraculously rather than logically may be perplexing to the High C.
<%=EndAppModParaFont%>

<%=AppModParaFont%>The Land of Promise presents the C with the happy convergence of the Big Dream and the Big Need and the opportunity to put the careful planning and organization to work. Because the C is a master at anticipating eventualities and having clear contingency plans in place, he or she should thrive in administering the Dream. Redefining the Dream and accepting the never-ending horizon will require more thought, research, and planning.
<%=EndAppModParaFont%>
</td></tr></table>
<p style="page-break-after: always"></p>


<wxprinter PageBreak>
<% If UCase(HighType1) = "D" Then %>
	<!-- #Include File = "Dream_Style_D.asp" -->
<% ElseIf UCase(HighType1) = "I" Then %>
	<!-- #Include File = "Dream_Style_I.asp" -->
<% ElseIf UCase(HighType1) = "S" Then %>
	<!-- #Include File = "Dream_Style_S.asp" -->
<% ElseIf UCase(HighType1) = "C" Then %>
	<!-- #Include File = "Dream_Style_C.asp" -->
<% End If %>
</font>

<!--************* E N D  R E P O R T *************-->

</body>
</html>