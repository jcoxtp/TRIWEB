<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 37	' Active PDF App Module Page
%>
<!-- #Include File = "Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
	<!-- #Include File = "Include/HeadStuff.asp" -->
</head>
<body>
<!-- #Include File = "Include/TopBanner.asp" -->
<!-- #Include File = "Include/LeftNavBar.asp" -->
<div id="maincontent">
<%
	Dim FileExists
	Dim PDFFileName
	Dim UserName 
	Dim SourceASPFileName
	Dim TestCodeID
	Dim PDITestSummaryID
	Dim PDITestDate
	Dim HighType1
	Dim HighType2
	Const IEEngine = 1
	
	FileExists = Request.QueryString("FE")
	'PDFFileName = Request.QueryString("PDFFN")
	PDFFileName = "mlpAppModTestPrint.pdf"
	UserName = Request.QueryString("UN")
	SourceASPFileName = Request.QueryString("SASP")
	TestCodeID = Request.QueryString("TCID")
	PDITestSummaryID = Request.QueryString("PDITSID")
	PDITestDate = Request.QueryString("TD")
	HighType1 = Request.QueryString("HT1")
	HighType2 = Request.QueryString("HT2")
	
	' Only create the file if it hasn't already been created
	If FileExists = 0 Then
		Set oConn = Nothing
		Set oCmd = Nothing
		' THE PERSON SHOULD JUST HAVE COMPLETED THE TEST IN AUTHORWARE SO WE KNOW THE PDISUMMARYTESTID IN THE PDISUMMARYTEST TABLE
		' SO WE'LL GRAB THE PDITESTSUMMARYID THERE WILL BE A PREVIOUS PAGE CALLED BY THE AUTHORWARE PIECE TO COMPLETE THE
		' TEST - THIS PREVIOUS PAGE WILL INSERT ALL ANSWERS AND GET THE PDITESTSUMMARYID AND THE PDFFILENAME FROM THE DATABASE
		'Response.Write strPDITestSummaryID
		'Response.Write "<br>"
		'Response.Write strPDIFileName
		'FOR TESTING ONLY: Get Application Module URL 
		'If SourceASPFileName = "AppModuleTeamwork" Then
		'   Response.Write "http://" & Application("SiteDomain") & "/pdi/ReportGeneration/" & SourceASPFileName & ".asp?UID=" & Request.Cookies("UserID") & "&HT1=" & HighType1 & "&HT2=" & HighType2 & "&PDITSID=" & PDITestSummaryID & "&lid=" & intLanguageID & "&TCID=" & TestCodeID
		'   Response.End
		'End If
		
		'   Create the object
		Set APW = Server.CreateObject("APWebGrabber.Object")
		Set PDF = Server.CreateObject("APServer.Object")
		pdf.NewDocumentName = PDFFileName
		pdf.OutputDirectory = Application("PDFOut_DiskPath")
		
		' Set the URL : the report page gets the user's name and all other info from the database using the PDITestSummaryID
		' THIS COULD CAUSE A BUG
		APW.URL = "http://" & Application("SiteDomain") & "/pdi/ReportGeneration/" & SourceASPFileName & ".asp?UID=" & Request.Cookies("UserID") & "&HT1=" & HighType1 & "&HT2=" & HighType2 & "&PDITSID=" & PDITestSummaryID & "&lid=" & intLanguageID & "&TCID=" & TestCodeID
		'APW.URL = "http://www.yahoo.com"
		APW.Prt2DiskSettings = PDF.ToString()

		Response.Write PDF.ToString()

		
		'This conditional argument was added when we created the Financial Advising module in order to gain 
		'CSS support for it. Marc L. Porlier, 2/1/2005 
		If SourceASPFileName <> "LeadingApp" AND SourceASPFileName <> "AppModuleTimeMgt" Then
			APW.EngineToUse = IEEngine 'IE Engine (not built-in one, which lacks CSS support)
			APW.IETopMargin = 0.5 'inches
			APW.IELeftMargin = 1.0
			APW.IEBottomMargin = 0.35
			APW.IERightMargin = 1.0
			APW.FooterHTML = "<HTML><BODY BGCOLOR=white><div style='color:gray;font-family:Tahoma,Helvetica,Arial; font-size: 8pt;width:100%;border-top: solid 1px gray'><div style='float:right'>Page %cp% of %tp%.</div>Copyright &copy; Team Resources, Inc. All Rights Reserved</div></BODY></HTML>"
		Else
			APW.EngineToUse = 0
			APW.TopBottomMargin = 125
			APW.LeftRightMargin = 125
			APW.FooterHTML = "<HTML><BODY BGCOLOR=white><hr><CENTER><font size=""1"">Copyright &copy; Team Resources, Inc." + strTextAllRightsReserved + "&nbsp;&nbsp;Page %cp% of %tp%.</font></CENTER></BODY></HTML>"
			APW.FooterHeight = .35
			APW.FooterStatic = false
		End If

		' Tell WebGrabber to GO
		' Help Says - DoPrint starts the actual WebGrabber session
		R = APW.DoPrint(strActivePDFIP,64320)
		
		'  Now wait for a result
		' Help Says - Wait forces the page to wait for a specific result
		Result = APW.Wait(strActivePDFIP,64320,300,"")
		
		' To get the name of the PDF, you have to use the activePDF Server object
		If Result = "019" Then ' This was a good request
		Else
			Response.Write "Error! " & Result
			APW.Cleanup strActivePDFIP,64320
			Response.End
		End If
		
		APW.Cleanup strActivePDFIP,64320

	End If
	%>

	<br><br>
	<h2><%=strTextYourDISCProfileSystemApplicationReportHas%></h2>
	<br><br><a href="http://<%=Application("SiteDomain")%><%=Application("PDFOut_SitePath")%><%=PDFFileName%>?res=<%=intResellerID%>">
<%=strTextDownload%></a>&nbsp;<%=strTextYourReport%>.</p>
</div>
</body>
</html>
