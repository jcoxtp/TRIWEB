<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	'On Error Resume Next
	intPageID = 57	' Print Your PDI Profile Page
	Dim TestCodeID, nextLink
	Dim intUserID
	TestCodeID = Request.QueryString("TCID")
	intUserID = Request.Cookies("UserID")
%>
<!-- #Include File = "Include/CheckLogin.asp" -->
<!-- #Include File = "Include/Common.asp" -->
<%
' TODO: Remove this line of code when the German site is complete
If intLanguageID = 2 Then
	intLanguageID = 1
End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
<!--<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>-->
	<script src="findDOM.js"></script>
	<script src="CtrlBehavior.js"></script>
	<!-- #Include File = "Include/HeadStuff.asp" -->
</head>
<body>
<!-- #Include File = "Include/TopBanner.asp" -->
   <div id="main">
<div id="tabgraphic">
	<img src="images/s6p1<%=strLanguageCode%>.gif" width="692" height="82" alt="" usemap="#tab" />
	<map name="tab">
		<area shape="poly" alt="" coords="633,53,672,53,680,59,673,65,632,66,617,59,634,53,637,53" HREF="PDIProfileSANDW2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>">
	</map>
</div>
<div id="maincontent_tab">
<%
	Dim nP, nE
	nP = Request.QueryString("PRNT")
	nE = Request.QueryString("EXIT")
	Dim bChoseRepProfile, bQuestionsCompleted
	Dim oConn
	Dim oCmd
	Dim oRs
	
	'TODO: Analyze code below to determine if it is necessary. -- mlp 12/06/2006
	bChoseRepProfile = True 'False
	bQuestionsCompleted = True 'False
	
	' First see if the user has completed the questions and has chosen at least 
	' 1 profile - if they have not then warn the user the PDI cannot be produced 
	' and allow them to quit anyway - but don't produce the PDF report for them
	
'	Set oConn = CreateObject("ADODB.Connection")
'	Set oCmd = CreateObject("ADODB.Command")
'	Set oRs = CreateObject("ADODB.Recordset")
'	With oCmd
'		.CommandText = "spTestSummarySelect"
'		.CommandType = 4
'		.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
'		.Parameters.Append .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)
'	End With
'	oConn.Open strDbConnString
'	oCmd.ActiveConnection = oConn
'	oRs.CursorLocation = 3
'	oRs.Open oCmd, , 0, 1
'	If oConn.Errors.Count > 0 Then
'		Response.Write "<br><br>" & strTextUnableToUpdateDatabaseThatFileWasCreated & VbCrLf
'		Response.End
'	End If
	
'	If oRs.EOF = False Then
'		oRs.MoveFirst
'		If CInt(oRs("QuestionsCompleted")) = 1 Then
'			bQuestionsCompleted = True
'		End If
'		If oRs("ProfileName1") <> "" Then ' [SM] Deleted reference to Profile 2
'			bChoseRepProfile = True
'		End If
'	Else
'		Response.Write "<br><br>" & strTextCannotFindTestInformationInDatabasePlease & VbCrLf
'		Response.End
'	End If
	
'	Set oConn = Nothing
'	Set oCmd = Nothing
'	Set oRs = Nothing
	
	If bQuestionsCompleted = False Then
		If nP = "1" Then
			Response.Write "<p>" & strTextYouHaveNotCompletedTheQuestionsPortion & "</p>" & VbCrLf
			Response.End
		Else
			Response.Write "<p>" & strTextYouHaveNotCompletedTheQuestionsIfYouQuit & "</p>" & VbCrLf
			Response.Write "<p><a href='main.asp?st=" & Site & "'>" & strTextClickHereToExitThePDIProfile & "</a>.</p>" & VbCrLf
		End If
	Else
		If bChoseRepProfile = False Then
			Response.Write "<p>" & strTextYouHaveNotChosenARepresentativeProfileAs & "</p>" & VbCrLf
			Response.Write "<p>" & strTextAreYouSureYouWantToExitNowIfYes & "</p>" & VbCrLf
			Response.Write "<p><a href='main.asp?st=" & Site & "'>" & strTextClickHereToExitNow & "</a>.</p>" & VbCrLf
		Else %>
			<h2><%=strTextCongratulationsYouHaveCompletedThePDI%></h2>
			<p style="margin-bottom:0px">
			<table border="0" cellspacing="0" cellpadding="6" width="100%">
				<tr>
					<td valign="top" align="center" width="32">
						<br><a href="javascript:confirmPDIPDFCreation()" onMouseOver="javascript:window.status='<%=strTextClickThisIconToCreateYourPerso%>';return true;" onMouseOut="javascript:window.status='';return true;"><img src="images/CreateReport<%=strLanguageCode%>.gif" alt="" width="50" height="63" /></a>
					</td>
					<td valign="top">
<%
			Response.Write "<h2>" & strTextViewAndPrintYourCompleteReport & "</h2>" & VbCrLf
			
			If strSiteType = "DG" Then
				Response.Write "<p>" & strTextClickOnTheCreateReportIconToCreateYourDA
			Else
				If strSiteType <> "Focus3" Then
					Response.Write "<p>" & strTextClickOnTheCreateReportIconToCreateYourApp
				Else
					Response.Write "<p>" & ClickOnTheCreateReportIco
				End If
			End If
			Response.Write ".</p>"
			Response.Write "<div align=""right"">"
			Response.Write "<p style=""margin-bottom:0px"">"
			Response.Write "<table border=""0"" cellspacing=""0"" cellpadding=""2"" width=""100%"">"
			Response.Write "	<tr>"
			Response.Write "		<td valign=""top"" align=""right"" width=""25%""><a href=""http://www.adobe.com/products/acrobat/readstep2.html"" target=""_blank""><img src=""images/get_acrobat_reader.gif"" alt="""" width=""88"" height=""31"" /></a></td>"
			Response.Write "		<td valign=""top"" align=""left"" width=""75%"">"
			Response.Write "			<strong>" & UCase(Application("strTextNote" & strLanguageCode)) & ":</strong> "
			Response.Write strTextYouMustHaveAdobeAcrobatReader
			Response.Write " " & Application("strTextPlease" & strLanguageCode) & " "
			Response.Write "<a href=""http://www.adobe.com/products/acrobat/readstep2.html"" target=""_blank"">"
			Response.Write strTextDownload & "</a> "
			Response.Write strTextThisFreeProgramFromTheAdobeWebsite & "."
%>
								</td>
							</tr>
						</table>
						</p>
						</div>
					</td>
				</tr>
			</table>
			</p>
<% 	If strSiteType <> "Focus3" And strSiteType <> "DG" Then
	' Now that the e-PDI and DA have been combined, we do not want to show any app reports
	' Focus3 doesn't want to display any App report info %>
			<!-- #Include File = "Include/divider.asp" -->
			<p style="margin-bottom:0px">
			<table border="0" cellspacing="0" cellpadding="6" width="100%">
				<tr>
					<td valign="top" align="center" width="32"><a href="purchasetest.asp?res=<%=intResellerID%>"><img src="images/reports.gif" alt="" width="32" height="32" /></a></td>
					<td valign="top">
<%
						Response.Write "<h2>"
						Response.Write strTextPurchaseACustomizedApplicationReport
						Response.Write " " & Application("strTextEach" & strLanguageCode) & "</h2>"
						Response.Write "<p>"
						Response.Write strTextApplicationReportsAreCustomizedBasedOnTheResultsOf
						Response.Write "<ul>"
						Response.Write "	<li><a href=""PDIAppReportsTeamwork.asp?res=" & intResellerID & """>"
						Response.Write strTextTeamworkWithStyleRegMark & "</sup></a></li>"
						Response.Write "	<li><a href=""PDIAppReportsLeading.asp?res=" & intResellerID & """>"
						Response.Write strTextLeadingWithStyleRegMark & "</sup></a></li>"
						Response.Write "	<li><a href=""PDIAppReportsCommunicating.asp?res=" & intResellerID & """>"
						Response.Write strTextCommunicatingWithStyleRegMark & "</sup></a></li>"
						Response.Write "	<li><a href=""PDIAppReportsSelling.asp?res=" & intResellerID & """>"
						Response.Write strTextSellingWithStyleRegMark & "</sup></a></li>"
						Response.Write "	<li><a href=""PDIAppReportsTime.asp?res=" & intResellerID & """>"
						Response.Write strTextTimeManagementWithStyleRegMark & "</sup></a></li>"
						Response.Write "</ul>"
%>
						</p>
					</td>
				</tr>
			</table>
			</p>
<% End If %>
			<!-- #Include File = "Include/divider.asp" -->
			<p style="margin-bottom:0px">
<%
	If strSiteType <> "Focus3" Then
			Response.Write "<table border=""0"" cellspacing=""0"" cellpadding=""6"" width=""100%"">"
			Response.Write "	<tr>" & _
					"<td valign=""top"" align=""center"" width=""50"">&nbsp;</td>" & _
					"<td valign=""top"">"

					Response.Write "<h2>"
					If strSiteType = "DG" Then
						Response.Write strTextViewAndPrintAPreviouslyPurchasedDA
					Else
						Response.Write strTextViewAndPrintAPreviouslyPurchasedAR
					End If
					Response.Write "</h2>"
					Response.Write "<p>" & strTextToCreateAnAppReportClickOn & "</p>"
					Response.Write "<div align=""center"">" & VbCrLf
					Response.Write "	<p class=""addtable"">" & VbCrLf
					Response.Write "	<table border=""0"" cellspacing=""0"" cellpadding=""6"" width=""85%"">" & VbCrLf
					Response.Write "	<tr>" & VbCrLf
					Response.Write "		<td valign=""middle"" align=""left""><span class=""headertext2"">" & strTextTitle & "</span></td>" & VbCrLf
					Response.Write "		<td valign=""middle"" align=""left""><span class=""headertext2"">" & strTextProfileCode & "</span>" & VbCrLf
					Response.Write "		</td>" & VbCrLf
					Response.Write "	</tr>" & VbCrLf
						Set oConn = CreateObject("ADODB.Connection")
						Set oCmd = CreateObject("ADODB.Command")
						Set oRs = CreateObject("ADODB.Recordset")
						With oCmd
							.CommandText = "spTestsSelect"
							.CommandType = 4
							.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
							.Parameters.Append .CreateParameter("@intUserID", 3, 1, 4, Request.Cookies("UserID"))
							.Parameters.Append .CreateParameter("@intLanguage", 3, 1, 4, intLanguageID)
						End With
						oConn.Open strDbConnString
						oCmd.ActiveConnection = oConn
						oRs.CursorLocation = 3
						oRs.Open oCmd, , 0, 1
						If oConn.Errors.Count < 1 Then
							If oRs.RecordCount = 0 Then
								Response.Write "<tr>"
								Response.Write "<td valign=""middle"" align=""center"" colspan=""2"">" & strText & "</td>"
								Response.Write "</tr>"
							Else
								oRs.MoveFirst
								Do While oRs.EOF = False
									If (Left(oRs("TestCode"),4) = "PDIP") Or (Left(oRs("TestCode"),4) = "PDDG") Then
									Else
										Response.Write "<tr>" & VbCrLf
										Response.Write "	<td valign=""top"" align=""left"">" & VbCrLf
										Response.Write "		<a href=""" & oRs("DescLink") & "?res=" & intResellerID & """>"
										Response.Write oRs("TestName") & "</a><br />" & VbCrLf
										Response.Write "		<span class=""bodytext_gray"">" & strTextPurchased & " " & oRs("DatePurchased") & "</span>" & VbCrLf
										Response.Write "	</td>" & VbCrLf
										Response.Write "	<td valign=""top"" align=""left""><a href=""javascript:confirmAppPDFCreation(" & oRs("TestCodeID") & ")"">" & oRs("TestCode") & "</a></td>" & VbCrLf
										Response.Write "</tr>" & VbCrLf
									End If
								oRs.MoveNext
								Loop
							End If
						Else
							Response.Write "<br><br>" & strTextUnableToRecordAnswersInDatabasePlease & "<br><br>"
							Response.Write Err.description
							Err.Clear
						End If
		Response.Write "</table>"
End If
%>
						</p>
						</div>
					</td>
				</tr>
			</table>
			</p>
<%
		End If
	End If
	' Get the Testcode for the test just completed...
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	With oCmd
		.CommandText = "spTestCodeSelect"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		.Parameters.Append .CreateParameter("@TestCodeID", 3, 1, 4, TestCodeID)
		.Parameters.Append .CreateParameter("@TestCode", 200, 3, 50, Null)
	End With
	Dim strTestCodePrefix
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oCmd.Execute , , 128
	If oConn.Errors.Count < 1 Then
		TestCode = oCmd.Parameters("@TestCode").value
		strTestCodePrefix = Left(TestCode, 4)
	Else
		TestCode = ""
		strTestCodePrefix = ""
	End If
	oConn.Close
	
	'PDF Report has already been generated in either by an Ajax call from either PDIProfileCustom.asp
	'or EnterTestCode.asp. All that is needed is the URL to the PDF. --mlp 12/06/2006
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Dim strPDFFileName, getReportURL
	With oCmd
		.CommandText = "get_PDIFilename"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@TestCodeID", 3, 1, 4, TestCodeID)
		.Parameters.Append .CreateParameter("@PDFFileName", 200, 3, 50, CStr(strPDFFileName))
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oCmd.Execute , , 128
	strPDFFileName = "" 'oCmd.Parameters("@PDFFileName").value
	oConn.Close
	
	
	If strPDFFileName <> "" Then
		getReportURL = "http://" & Application("SiteDomain") & "/PDFReports/" & strPDFFileName
	Else
		getReportURL = "http://" & Application("SiteDomain") & "/ePDICorp/getPDIReport.aspx?TCID=" & TestCodeID & "&lid=" & intLanguageID & "&res=" & intResellerID & "&u=" & intUserID
	End If
	
%>
	<script type="text/javascript">
	// alerts user to delay while generating the PDF and application reports
	function confirmAppPDFCreation(TCID) {

		if (window.confirm("<%=strTextItWillTakeAboutAMinuteToGenerateYour%>")) {
			var goToNextURL;
			goToNextURL = "AppModuleCreatePDF.asp?TCID=" + TCID + "&res=<%=intResellerID%>";

			document.location = goToNextURL;
		}

	}
<% If (strTestCodePrefix = "PDDG" Or (strTestCodePrefix <> "" And strSiteType = "DG")) Then %>
	function confirmPDIPDFCreation() {

		if (window.confirm("<%=strTextItWillTakeAboutAMinuteToGeneratePDI%>")) {
			var goToNextURL;
			goToNextURL = "activeDGDAPDF.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>&u=<%=intUserID%>&lid=<%=intLanguageID%>";
			//openAnyWindow(goToNextURL,'Download',"height=240,width=450,menubar=1,resizable=1,scrollbars=1,status=1,titlebar=1,toolbar=1,z-lock=0");

			window.location = goToNextURL;
		}

	}
<% 	Else %>
	function confirmPDIPDFCreation() {
		//if (window.confirm("<%=strTextItWillTakeAboutAMinuteToGeneratePDI%>")) {	
			var goToNextURL;
			//goToNextURL = "activePDF.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>&u=<%=intUserID%>&lid=<%=intLanguageID%>";
			goToNextURL = "<%=getReportURL%>";
			//openAnyWindow(goToNextURL,'Download',"height=240,width=450,menubar=1,resizable=1,scrollbars=1,status=1,titlebar=1,toolbar=1,z-lock=0");
			window.location = goToNextURL;
		//}
	}
<%
	End If
	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRs = Nothing
%>
	</script>
</div>
    </div>
</body>
</html>
