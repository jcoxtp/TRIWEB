<%@ Language=VBScript %>
<% Response.Buffer = TRUE %>
<!--#INCLUDE FILE="include/common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | PDI Application Report PDF</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
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
	
	FileExists = Request.QueryString("FE")
	PDFFileName = Request.QueryString("PDFFN")
	UserName = Request.QueryString("UN")
	SourceASPFileName = Request.QueryString("SASP")
	TestCodeID = Request.QueryString("TCID")
	PDITestSummaryID = Request.QueryString("PDITSID")
	PDITestDate = Request.QueryString("TD")
	HighType1 = Request.QueryString("HT1")
	HighType2 = Request.QueryString("HT2")
	
	' Only create the file if it hasn't already been created
	if FileExists = 0 then
	
		Set oConn = Nothing
		Set oCmd = Nothing
	
		' THE PERSON SHOULD JUST HAVE COMPLETED THE TEST IN AUTHORWARE SO WE KNOW THE PDISUMMARYTESTID IN THE PDISUMMARYTEST TABLE
		' SO WE'LL GRAB THE PDITESTSUMMARYID THERE WILL BE A PREVIOUS PAGE CALLED BY THE AUTHORWARE PIECE TO COMPLETE THE
		' TEST - THIS PREVIOUS PAGE WILL INSERT ALL ANSWERS AND GET THE PDITESTSUMMARYID AND THE PDFFILENAME FROM THE DATABASE
	
		'Response.Write strPDITestSummaryID
		'Response.Write "<br>"
		'Response.Write strPDIFileName
	
		'   Create the object
		Set APW = Server.CreateObject("APWebGrabber.Object")
		Set PDF = Server.CreateObject("APServer.Object")
	
		pdf.NewDocumentName = PDFFileName
		pdf.OutputDirectory = Application("PDFOut_DiskPath")
	
		' Set the URL : the report page gets the user's name and all other info from the database using the PDITestSummaryID
		' THIS COULD CAUSE A BUG
		APW.URL = "http://" & Application("SiteDomain") & "/pdi/ReportGeneration/" & SourceASPFileName & ".asp?UID=" & Request.Cookies("UserID") & "&HT1=" & HighType1 & "&HT2=" & HighType2 & "&PDITSID=" & PDITestSummaryID
		APW.Prt2DiskSettings = PDF.ToString()
	
		' Tell WebGrabber to GO
		' Help Says - DoPrint starts the actual WebGrabber session
		R = APW.DoPrint(strActivePDFIP,64320)
	
		'  Now wait for a result
		' Help Says - Wait forces the page to wait for a specific result
		Result = APW.Wait(strActivePDFIP,64320,60,"")
	
		' To get the name of the PDF, you have to use the activePDF Server object
		If Result = "019" Then ' This was a good request
		Else
			Response.Write "Error! " & Result
			APW.Cleanup strActivePDFIP,64320
			Response.End
		End If
	
		APW.Cleanup strActivePDFIP,64320
		' toggle the File Created Flag
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		With oCmd
			.CommandText = "upd_Purchase_TestCode_AppModuleFileCreated"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			.Parameters.Append .CreateParameter("@AppModCreated",3, 1,4, 1)
			.Parameters.Append .CreateParameter("@AppModFileName",200, 1,50, PDFFileName)
			.Parameters.Append .CreateParameter("@AppModPDITestSummaryID",3, 1,4, PDITestSummaryID)
			.Parameters.Append .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)
		End With
		oConn.Open strDBaseConnString
		oCmd.ActiveConnection = oConn
		oCmd.Execute , , 128
	
		If oConn.Errors.Count > 0 then
			Response.Write "Unable to update database that file was created. The official error was:"
			Response.Write "<br>"
			Response.Write Err.description
			Response.End
		end if
		Set oConn = Nothing
		Set oCmd = Nothing
	End If
	%>
	
	<h2>Your <!--#INCLUDE FILE="include/disc.asp" --> application report has been successfully created!</h2>
	<p><a href="http://<%=Application("SiteDomain")%><%=Application("PDFOut_SitePath")%><%=PDFFileName%>?res=<%=intResellerID%>" target="_blank">Download</a> your report.</p>
</div>
</body>
</html>
