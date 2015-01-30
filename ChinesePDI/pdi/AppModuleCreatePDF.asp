<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/checklogin.asp" -->
<!--#INCLUDE FILE="include/common.asp" -->
<% pageID = "appReportCreatePDF" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Redeem a Profile</title>
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
	on error resume next
	Dim bSubmitted
	bSubmitted = 1
	
	if bSubmitted = "" then
	else 
		Dim TestCodeID
		Dim UserID
		Dim HighPoint
		Dim HighPoint2
		Dim FileAlreadyExists
		Dim PDFFileName
		Dim TestCode
		Dim PDITestSummaryID
		Dim PDITestDate
	
		TestCodeID = Request.QueryString("TCID")
		UserID = Request.Cookies("UserID")
	
		'Response.Write TestCodeID
		'Response.Write "<br><br>"
		'Response.Write UserID
		'Response.END
	
		HighPoint = ""
		FileAlreadyExists = 0
		PDFFileName = ""
		TestCode = ""
		PDITestSummaryID = 0
		PDITestDate = "1/1/1990"
	
		Dim oConn
		Dim oCmd
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		With oCmd
			 .CommandText = "sel_AppModule_TCID_UserID"
			 .CommandType = 4
			 .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			 .Parameters.Append .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)
			 .Parameters.Append .CreateParameter("@UserID",3, 1,4, UserID)
			 .Parameters.Append .CreateParameter("@HighPoint",129, 3,1, CStr(HighPoint))
			 .Parameters.Append .CreateParameter("@HighPoint2",129, 3,1, CStr(HighPoint2))
			 .Parameters.Append .CreateParameter("@FileAlreadyExists",3, 3,4, CLng(FileAlreadyExists))
			 .Parameters.Append .CreateParameter("@PDFFileName",200, 3,50, CStr(PDFFileName))
			 .Parameters.Append .CreateParameter("@TestCode",200, 3,50, CStr(TestCode))
			 .Parameters.Append .CreateParameter("@PDITestSummaryID",3, 3,4, CLng(PDITestSummaryID))
			.Parameters.Append .CreateParameter("@PDITestDate",135, 3,16, CStr(PDITestDate))
		End With
		oConn.Open strDBaseConnString
		oCmd.ActiveConnection = oConn
		oCmd.Execute , , 128
	
		HighPoint = oCmd.Parameters("@HighPoint").value
		HighPoint2 = oCmd.Parameters("@HighPoint2").value
		FileAlreadyExists = oCmd.Parameters("@FileAlreadyExists").value
		PDFFileName = oCmd.Parameters("@PDFFileName").value
		TestCode = oCmd.Parameters("@TestCode").value
		PDITestSummaryID = oCmd.Parameters("@PDITestSummaryID").value
		PDITestDate = oCmd.Parameters("@PDITestDate").value
	
		If oConn.Errors.Count < 1 Then
			Response.Write "<BR><BR>Transaction Successful<BR><BR>"
			Response.Write "<BR><BR>Output Params<BR><BR>"
			Response.Write "HighPoint = " & HighPoint & "<BR><BR>"
			Response.Write "FileAlreadyExists = " & FileAlreadyExists & "<BR><BR>"
			Response.Write "PDFFileName = " & PDFFileName & "<BR><BR>"
			Response.Write "TestCode = " & TestCode & "<BR><BR>"
			Response.Write "PDITestDate = " & PDITestDate & "<BR><BR>"
			If UCASE(Left(TestCode,4)) = "SELL" Then
				'Response.Write "<a href='activepdf_appmodule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleSelling&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & " target="_blank"'>Here's the link</a>"
				Response.Redirect ("activepdf_appmodule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleSelling&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID)
			ElseIf UCASE(Left(TestCode,4)) = "TEAM" Then
				'Response.Write "<a href='activepdf_appmodule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleTeamwork&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "'>Here's the link</a>"
				Response.Redirect ("activepdf_appmodule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleTeamwork&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID)
			ElseIf UCASE(Left(TestCode,4)) = "LEAD" Then
				'Response.Write "<a href='activepdf_appmodule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleLeading&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "'>Here's the link</a>"
				Response.Redirect ("activepdf_appmodule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleLeading&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID)
			ElseIf UCASE(Left(TestCode,4)) = "COMM" Then
				'Response.Write "<a href='activepdf_appmodule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleCommunicating&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "'>Here's the link</a>"
				Response.Redirect ("activepdf_appmodule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleCommunicating&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID)
			ElseIf UCASE(Left(TestCode,4)) = "TIME" Then
				'Response.Write "<a href='activepdf_appmodule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleTimeMgt&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "'>Here's the link</a>"
				Response.Redirect ("activepdf_appmodule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleTimeMgt&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID)
			ElseIf UCASE(Left(TestCode,4)) = "DRMA" Then
				'Response.Write "<a href='activepdf_appmodule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleTimeMgt&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "'>Here's the link</a>"
				Response.Redirect ("activepdf_appmodule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleDream&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID)
			Else
				Response.Write "Invalid profile code. Please try again."
				Response.End
			End If
		Else
			Response.Write "<BR><BR>Transaction Failed<BR><BR>"
			Response.Write Err.description
			Err.Clear
		End If
	End If
	%>
</div>
</body>
</html>







