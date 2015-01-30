<%@ Language=VBScript %>
<%
Response.Buffer = TRUE
Dim intPageID
intPageID = 59
Dim TestCodeID
TestCodeID = Request.QueryString("TCID")
Dim intUserID
intLanguageID = Request.QueryString("LID")
%>
<!-- #Include File = "Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Download Your PDI Report and Dream Assessment Report</title>
			<meta name="generator" content="BBEdit 7.0.1">
			<link rel="stylesheet" href="Include/Default.css" type="text/css">
			<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
			<!-- #Include File = "Include/HeadStuff.asp" -->

	<script language="Javascript">
	<!--
		function openPDF(strPDFFileName) {
			window.location = "http://<%=Application("SiteDomain") & Application("PDFOut_SitePath")%>" + strPDFFileName;
		}
	// -->
	</script>

	</head>
<body>
<%
intUserID = Request.QueryString("u")
If intUserID = "" Then
	intUserID = Request.Cookies("UserID")
End If

Dim oConn
Dim oCmd
Dim strPDFFileName
Dim strPDITestSummaryID
Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
With oCmd
	.CommandText = "sel_PDI_PDFFileName_Ex"
	.CommandType = 4
	.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	.Parameters.Append .CreateParameter("@TestCodeID", 3, 1, 4, TestCodeID)
	.Parameters.Append .CreateParameter("@UserID", 3, 1, 4, intUserID)
	.Parameters.Append .CreateParameter("@PDFFileName", 200, 3, 50, CStr(strPDFFileName))
	.Parameters.Append .CreateParameter("@PDITestSummaryID", 3, 3, 4, CLng(strPDITestSummaryID))
End With
oConn.Open strDbConnString
oCmd.ActiveConnection = oConn
oCmd.Execute , , 128
strPDFFileName = oCmd.Parameters("@PDFFileName").value
strPDITestSummaryID = oCmd.Parameters("@PDITestSummaryID").value

If oConn.Errors.Count < 1 then ' [SM] Begin creating the PDF Report
	If strPDITestSummaryID = "" or strPDFFileName = "" Then
		Response.Write "Proper param values must be passed to this page. PDF File creation failed."
		Response.End
	End If
	' First detect if the file is already created, just in case the user presses
	' the refresh button - we don't want to create the file again
	Dim CreateFile
	CreateFile = 0
	Set oConn = NOTHING
	Set oCmd = NOTHING
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	With oCmd
		.CommandText = "spTestSummaryFileCreationInProgressUpdate"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		.Parameters.Append .CreateParameter("@CreateFile", 3, 3, 4, CLng(CreateFile))
		.Parameters.Append .CreateParameter("@PDITestSummaryID", 3, 1, 4, strPDITestSummaryID)
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oCmd.Execute , , 128
	CreateFile = oCmd.Parameters("@CreateFile").value
	Set oConn = Nothing
	Set oCmd = Nothing
	' Only create the file if it hasn't already been created

'If intUserID = 210 Then
'	Set APW = Server.CreateObject("APWebGrabber.Object")
'	Set PDF = Server.CreateObject("APServer.Object")
'	Response.Write "<br><br>http://" & Application("SiteDomain") & "/PDI/DGDAReport.asp?SID=" & strPDITestSummaryID & "&u="& intUserID & "&TCID=" & TestCodeID & "&res=" & intResellerID & "&LID=" & intLanguageID
'	Response.End
'End If

	If (CreateFile = 1) OR (CreateFile = 0) Then
		Set APW = Server.CreateObject("APWebGrabber.Object")
		Set PDF = Server.CreateObject("APServer.Object")
		PDF.NewDocumentName = strPDFFileName
		PDF.OutputDirectory = Application("PDFOut_DiskPath")
		APW.URL = "http://" & Application("SiteDomain") & "/PDI/DGDAReport.asp?SID=" & strPDITestSummaryID & "&u="& intUserID & "&TCID=" & TestCodeID & "&res=" & intResellerID & "&LID=" & intLanguageID
		APW.Prt2DiskSettings = PDF.ToString()
		' [SM] Specify various report preferences
		APW.EngineToUse = 1 'IE Engine (not built-in one, which lacks CSS support)
		APW.IETopMargin = 0.25 'inches
		APW.IELeftMargin = 0.5
		APW.IEBottomMargin = 0.25
		APW.IERightMargin = 0.5
		' APW.IEFooter = ""
		' Tell WebGrabber to GO
		R = APW.DoPrint(strActivePDFIP,64320)
		' [SM] Wait until WebGrabber successfully completes the processing (result "019")
		' Now wait for a result
		' Help Says - Wait forces the page to wait for a specific result
		Result = APW.Wait(strActivePDFIP, 64320, 300, "")
		If Result = "019" Then
			APW.Cleanup strActivePDFIP, 64320
			' toggle the File Created Flag
			Set oConn = Nothing
			Set oCmd = Nothing
			Set oConn = CreateObject("ADODB.Connection")
			Set oCmd = CreateObject("ADODB.Command")
			With oCmd
				.CommandText = "spTestSummaryFileCreatedUpdate"
				.CommandType = 4
				.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				.Parameters.Append .CreateParameter("@PDITestSummaryID", 3, 1, 4, strPDITestSummaryID)
				.Parameters.Append .CreateParameter("@PDFFileName", 200, 1, 50, strPDFFileName)
			End With
			oConn.Open strDbConnString
			oCmd.ActiveConnection = oConn
			oCmd.Execute , , 128
			'[SM] Display download link
			Response.Write "<h2>Your Personal DISCernment Inventory<sup>&reg;</sup> report and Dream Assessment<sup>&reg;</sup> have been successfully created!</h2>"
			Response.Write "<br><br>You may open your report by clicking the button below."
			Response.Write "<table width=""600"" border=""0"" cellspacing=""0"" cellpadding=""0"">"
			Response.Write "<tr><td>"
			Response.Write "<form name=""DownloadForm"" method=""post"">"
			Response.Write "<br><input type=""button"" name=""submitIt"" value=""Open Report"" onClick=""javascript:openPDF('" & strPDFFileName & "');"">"
			Response.Write "</form>"
			Response.Write "</td></tr>"
			Response.Write "</table>"
		Else
			Response.Write "Error! " & Result
			APW.Cleanup strActivePDFIP, 64320
			Response.End
		End If
	End If
Else
	Response.Write "Unable to update database. Please try again."
	Response.End
End If
%>
</body>
</html>
