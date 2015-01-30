<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 36	' App Report Creation Module Page
%>
<!--#Include file="Include/CheckLogin.asp" -->
<!--#Include file="Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
	<!--#Include file="Include/HeadStuff.asp" -->
</head>
<body>
<!--#Include file="Include/TopBanner.asp" -->

<div id="maincontent">
<%
	Dim bSubmitted
	bSubmitted = 1
	
	If bSubmitted = "" Then
		' Don't do anything at this point
	Else
		Dim TestCodeID
		Dim UserID
		Dim HighPoint
		Dim HighPoint2
		Dim FileAlreadyExists
		Dim PDFFileName
		Dim TestCode
		Dim PDITestSummaryID
		Dim PDITestDate
		Dim reportPage
		
		TestCodeID = Request.QueryString("TCID")
		UserID = Request.Cookies("UserID")
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
			.Parameters.Append .CreateParameter("@TestCodeID", 3, 1, 4, TestCodeID)
			.Parameters.Append .CreateParameter("@UserID", 3, 1, 4, UserID)
			.Parameters.Append .CreateParameter("@HighPoint", 129, 3, 1, CStr(HighPoint))
			.Parameters.Append .CreateParameter("@HighPoint2", 129, 3, 1, CStr(HighPoint2))
			.Parameters.Append .CreateParameter("@FileAlreadyExists", 3, 3, 4, CLng(FileAlreadyExists))
			.Parameters.Append .CreateParameter("@PDFFileName", 200, 3, 50, CStr(PDFFileName))
			.Parameters.Append .CreateParameter("@TestCode", 200, 3, 50, CStr(TestCode))
			.Parameters.Append .CreateParameter("@PDITestSummaryID", 3, 3, 4, CLng(PDITestSummaryID))
			.Parameters.Append .CreateParameter("@PDITestDate", 135, 3, 16, CStr(PDITestDate))
		End With
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oCmd.Execute , , 128
		
		HighPoint = oCmd.Parameters("@HighPoint").value
		HighPoint2 = oCmd.Parameters("@HighPoint2").value
		FileAlreadyExists = oCmd.Parameters("@FileAlreadyExists").value
		PDFFileName = oCmd.Parameters("@PDFFileName").value
		TestCode = oCmd.Parameters("@TestCode").value
		PDITestSummaryID = oCmd.Parameters("@PDITestSummaryID").value
		PDITestDate = oCmd.Parameters("@PDITestDate").value
		
		reportPage = "http://" & Application("SiteDomain") & "/ePDICorp/getAppModuleReport.aspx"
		
		If oConn.Errors.Count < 1 Then
			Response.Write "<BR><BR>Transaction Successful<BR><BR>"
			Response.Write "<BR><BR>Output Params<BR><BR>"
			Response.Write "HighPoint = " & HighPoint & "<BR><BR>"
			Response.Write "FileAlreadyExists = " & FileAlreadyExists & "<BR><BR>"
			Response.Write "PDFFileName = " & PDFFileName & "<BR><BR>"
			Response.Write "TestCode = " & TestCode & "<BR><BR>"
			Response.Write "PDITestDate = " & PDITestDate & "<BR><BR>"
			If UCASE(Left(TestCode,4)) = "SELL" Then
				'Response.Write "<a href='ActivePDFAppModule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleSelling&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & " target="_blank"'>Here's the link</a>"
				Response.Redirect (reportPage & "?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleSelling&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "&lid=" & intLanguageID & "&UID=" & Request.Cookies("UserID") )
			ElseIf UCASE(Left(TestCode,4)) = "TEAM" Then
				'Response.Write "<a href='ActivePDFAppModule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleTeamwork&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "'>Here's the link</a>"
				Response.Redirect (reportPage & "?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleTeamwork&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "&lid=" & intLanguageID & "&UID=" & Request.Cookies("UserID") )
			ElseIf UCASE(Left(TestCode,4)) = "LEAD" Then
				'Response.Write "<a href='ActivePDFAppModule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleLeading&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "'>Here's the link</a>"
				Response.Redirect (reportPage & "?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=LeadingApp&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "&lid=" & intLanguageID & "&UID=" & Request.Cookies("UserID") )
			ElseIf UCASE(Left(TestCode,4)) = "COMM" Then
				'Response.Write "<a href='ActivePDFAppModule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleCommunicating&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "'>Here's the link</a>"
				Response.Redirect (reportPage & "?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleCommunicating&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "&lid=" & intLanguageID & "&UID=" & Request.Cookies("UserID") )
			ElseIf UCASE(Left(TestCode,4)) = "TIME" Then
				'Response.Write "<a href='ActivePDFAppModule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleTimeMgt&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "'>Here's the link</a>"
				Response.Redirect (reportPage & "?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleTimeMgt&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "&lid=" & intLanguageID & "&UID=" & Request.Cookies("UserID") )
			ElseIf UCASE(Left(TestCode,4)) = "DRMA" Then
				'Response.Write "<a href='ActivePDFAppModule.asp?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleTimeMgt&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "'>Here's the link</a>"
				Response.Redirect (reportPage & "?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleDream&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "&lid=" & intLanguageID & "&UID=" & Request.Cookies("UserID") )
			ElseIf UCASE(Left(TestCode,4)) = "FINP" Then 
				Response.Redirect (reportPage & "?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModuleFinancial&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "&lid=" & intLanguageID & "&UID=" & Request.Cookies("UserID") )
			ElseIf UCASE(Left(TestCode,4)) = "PMGT" Then
				Response.Redirect (reportPage & "?HT1=" & HighPoint & "&HT2=" & HighPoint2 & "&TD=" & Server.URLEncode(PDITestDate) & "&FE=" & FileAlreadyExists & "&PDFFN=" & Server.URLEncode(PDFFileName) & "&SASP=AppModulePerformance&TCID=" & TestCodeID & "&PDITSID=" & PDITestSummaryID & "&lid=" & intLanguageID & "&UID=" & Request.Cookies("UserID") )
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
