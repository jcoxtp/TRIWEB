<%@ Language=VBScript %>
<% Response.Buffer = TRUE %>
<!--#INCLUDE FILE="include/common.asp" -->
<%
Dim TestCodeID
TestCodeID = Request.QueryString("TCID")
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Download Your PDI Report</title>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8" />
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>
<%
Dim oConn
Dim oCmd
Dim strPDFFileName
Dim strPDITestSummaryID

intUserID = Request.Cookies("UserID")
If intUserID = "" Then
	Response.Write "<br><br>Unfortunately, your browser is configured to block cookies. We require the use of cookies for our system to function. Please enable the storage of cookies and try again."
	Response.End
End If

'Response.Write "<br>DECLARE @PDFFileName varchar(255)"
'Response.Write "<br>DECLARE @PDITestSummaryID int"
'Response.Write "<br>Exec sel_PDI_PDFFileName_Ex " & TestCodeID & ", " & intUserID & ", '" & CStr(strPDFFileName) & "' output, " & CLng(strPDITestSummaryID) & " output"
'Response.Write "<br>SELECT @PDFFileName, @PDITestSummaryID"

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
oConn.Open strDBaseConnString
oCmd.ActiveConnection = oConn
oCmd.Execute , , 128
strPDFFileName = oCmd.Parameters("@PDFFileName").value
strPDITestSummaryID = oCmd.Parameters("@PDITestSummaryID").value

If oConn.Errors.Count < 1 then ' [SM] Begin creating the PDF Report
	If strPDITestSummaryID = "" or strPDFFileName = "" then
		Response.Write "Proper param values must be passed to this page. PDF File creation failed."
		Response.End
	End If
	' First detect if the file is already created, just in case the user presses
	' the refresh button - we don't want to create the file again
	Dim CreateFile
	CreateFile = 0

	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")

	With oCmd
		.CommandText = "spTestSummaryFileCreationInProgressUpdate"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		.Parameters.Append .CreateParameter("@CreateFile",3, 3,4, CLng(CreateFile))
		.Parameters.Append .CreateParameter("@PDITestSummaryID",3, 1,4, strPDITestSummaryID)
	End With
	oConn.Open strDBaseConnString
	oCmd.ActiveConnection = oConn
	oCmd.Execute , , 128
	CreateFile = oCmd.Parameters("@CreateFile").value
	Set oConn = Nothing
	Set oCmd = Nothing

'Response.Write "<br><a target='_blank' href='http://" & Application("SiteDomain") & "/ChinesePDI/pdi/PDIReport.asp?SID=" & strPDITestSummaryID & "&TCID=" & TestCodeID & "&res=" & intResellerID & "'>"
'Response.Write "http://" & Application("SiteDomain") & "/ChinesePDI/pdi/PDIReport.asp?SID=" & strPDITestSummaryID & "&TCID=" & TestCodeID & "&res=" & intResellerID
'Response.Write "</a>"

'Response.Write "http://" & Application("SiteDomain") & "/ChinesePDI/pdi/PDIReport.asp?SID=" & strPDITestSummaryID & "&TCID=" & TestCodeID & "&res=" & intResellerID

'Response.Redirect("printPDF.aspx?SID=" & strPDITestSummaryID & "&TCID=" & TestCodeID & "&res=" & intResellerID)

'Response.End

	' Only create the file if it hasn't already been created
	If (CreateFile = 1) OR (CreateFile = 0) then
		Set APW = Server.CreateObject("APWebGrabber.Object")
		Set PDF = Server.CreateObject("APServer.Object")
		PDF.NewDocumentName = strPDFFileName
		PDF.OutputDirectory = Application("PDFOut_DiskPath")

		APW.URL = "http://" & Application("SiteDomain") & "/ChinesePDI/pdi/PDIReport.asp?SID=" & strPDITestSummaryID & "&TCID=" & TestCodeID & "&res=" & intResellerID
		'APW.URL = "http://www.pdiprofile.com/ChinesePDI/pdi/login.asp?res=1" 
		'APW.URL = "http://www.pdiprofile.com/ChinesePDI/pdi/PDIReport.asp?SID=36411&TCID=325531&res=1"
		
		APW.Prt2DiskSettings = PDF.ToString()

		' [SM] Specify various report preferences
		APW.EngineToUse = 1 'IE Engine (not built-in one, which lacks CSS support)
		APW.IETopMargin = 1.0 'inches
		APW.IELeftMargin = 1.0
		APW.IEBottomMargin = 1.0
		APW.IERightMargin = 1.0
		'APW.IEFooter = ""
		' Tell WebGrabber to GO
		R = APW.DoPrint(strActivePDFIP,64320)
		' [SM] Wait until WebGrabber successfully completes the processing (result "019")
		Result = APW.Wait(strActivePDFIP,64320,120,"")
		If Result = "019" Then
			APW.Cleanup strActivePDFIP,64320
			' toggle the File Created Flag
			Set oConn = CreateObject("ADODB.Connection")
			Set oCmd = CreateObject("ADODB.Command")
			With oCmd
				.CommandText = "spTestSummaryFileCreatedUpdate"
				.CommandType = 4
				.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				.Parameters.Append .CreateParameter("@PDITestSummaryID",3, 1,4, strPDITestSummaryID)
				.Parameters.Append .CreateParameter("@PDFFileName",200, 1,50, strPDFFileName)
			End With
			oConn.Open strDBaseConnString
			oCmd.ActiveConnection = oConn
			oCmd.Execute , , 128
			'[SM] Display download link %>
			<h2>你的个性鉴别清单报告创立成功！</h2>
			<p><a href="http://<%=Application("SiteDomain")%><%=Application("PDFOut_SitePath")%><%=strPDFFileName%>">下载你的报告。</a></p>
		<%
		Else
			Response.Write "<br>Error! " & Result & " while attempting to create file http://" & Application("SiteDomain") & Application("PDFOut_SitePath") & strPDFFileName
			APW.Cleanup strActivePDFIP,64320
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
