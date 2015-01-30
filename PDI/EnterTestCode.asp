<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	'On Error Resume Next
	intPageID = 35	' Credit Card Information Collection Page
%>
<!--#Include file="Include/CheckLogin.asp" -->
<!--#Include file="Include/Common.asp" -->
<%
' TODO: Remove this line of code when the German site is complete
If intLanguageID = 2 Then
	strLanguageCode = "EN"
End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextUseAnExistingProfileCode%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
	<!--#Include file="Include/HeadStuff.asp" -->
</head>
<body>
<!--#Include file="Include/TopBanner.asp" -->
    <div id="main">

<div id="maincontent">
	<script type="text/javascript" language="Javascript">
	<!--
		function displayPopup(url, height, width)
		{
			properties = "toolbar=0,location=0,scrollbars=0,height=" + height;
			properties = properties + ",width=" + width;
			properties = properties + ",left=0,top=0";
			poppupHandle = window.open(url, "DISCProfile", properties);
		}
	// -->
	</script>
    <h1><%=Request.Cookies("UserID") %></h1>
<!--this is run on post-back of submit click.-->
<%
	Dim bSubmitted

    'Hidden field value set to 1
	bSubmitted = Request.Form ("txtSubmit")
	Dim bFilledOutProperly, strErrMsg
	Dim TestCodeEntered
	Dim TRUserID, TestCodeID
	
	TRUserID = Request.Cookies("UserID")
	bFilledOutProperly = FALSE
	
	If bSubmitted <> "" Then
		  TestCodeEntered = Request.Form("txtTestCodeEntered") 
	End If
	
    'Value is set when page is redirected from authreponse.asp
	Dim bMainPgSubmit
	bMainPgSubmit = Request.QueryString("MPS")

    'If page is a result of a redirect, set the test code to set on the tags href query string.
	if bMainPgSubmit <> "" then
		bSubmitted = 1
		TestCodeEntered = Request.QueryString("TCODE")
	end if
	
	TestCodeEntered = Trim(TestCodeEntered)
	TRUserID = Trim(TRUserID)
	
    'if profile code has been entered and user id has a value, then the page is filled out properly and we can proceed.
	If bSubmitted <> "" Then
		  If TestCodeEntered = "" then 
			strErrMsg = strTextPleaseEnterAValueFor & ": <strong>" & strTextProfileCode & "</strong>"
		  ElseIf TRUserID = "" then 
			strErrMsg = strTextPleaseEnterAValueFor & ": TRUserID"
		  Else
			bFilledOutProperly = TRUE
		  End If
	End If
	
	Dim strUserName
	strUserName = Request.Cookies("UserName")
	
	If bSubmitted <> "" AND bFilledOutProperly Then
		'Response.Write "<br>TestCodeEntered=" & TestCodeEntered
		'Response.Write "<br>TRUserID=" & TRUserID
		'Response.Write "<br>CompanyID=" & CompanyID
		'Response.Write "<br>CompanyName=" & CompanyName
		'Response.Write "<br>TestCodeID=" & TestCodeID
		'Response.End
    		Dim oConn
		    Dim oCmd
		    Dim oRs
		    Dim CompanyID

		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
		With oCmd
			  .CommandText = "sel_TestCode_Test"
			  .CommandType = 4
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			  .Parameters.Append .CreateParameter("@TestCodeEntered",200, 1,50, TestCodeEntered)
			  .Parameters.Append .CreateParameter("@TRUserID",3, 1,4, TRUserID)
			  .Parameters.Append .CreateParameter("@CompanyID",3, 3,4, CLng(CompanyID))
			  .Parameters.Append .CreateParameter("@CompanyName",200, 3,100, CStr(CompanyName))
			 .Parameters.Append .CreateParameter("@TestCodeID",3, 3,4, CLng(TestCodeID))
		End With
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
	
		If oConn.Errors.Count < 1 Then
			CompanyID = oCmd.Parameters("@CompanyID").value
			CompanyName = oCmd.Parameters("@CompanyName").value
			TestCodeID = oCmd.Parameters("@TestCodeID").value
			Dim CookieCompanyID : CookieCompanyID = Request.Cookies("CompanyID")
			'If CookieCompanyID = "0" or ISNULL(CookieCompanyID) = TRUE Then
			If CookieCompanyID = "0" or CookieCompanyID = "" Then
				If CompanyID <> 0 Then
					Response.Cookies("CompanyID") = CompanyID
					Response.Cookies("CompanyName") = CompanyName
				End If
			End If
			Dim Field, nColumns
			If oRs.EOF = FALSE Then
				oRs.MoveFirst
				If oRs("Success") = 0 Then
					strErrMsg = oRs("ErrMsg")
				Else
					If (Left(TestCodeEntered,4) = "PDIP") Or (Left(TestCodeEntered,4) = "PDDG") Then
						Response.Redirect("PDIProfileStartPage.asp?TCID=" & TestCodeID & "&res=" & intResellerID & "&lid=" & intLanguageID)
					Else
						Response.Redirect("AppModuleCreatePDF.asp?TCID=" & TestCodeID & "&res=" & intResellerID & "&lid=" & intLanguageID)
						' strErrMsg = "The application module report will not be generated since this code isn't ready yet."
					End If
					Response.Write "We are currently making changes to the system. Please try back later. Thank you."
					Response.End
				End If
			End If
		Else
			  strErrMsg = Err.description
			  Err.Clear
		End If
	End If
	%>
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td valign="top"><h1><% If strSiteType <> "Focus3" Then
													Response.Write strTextUseAnExistingProfileCode
												Else
													Response.Write "Use Profile Code"
												End If
										  %>
									</h1></td>
			<td valign="top" align="right"><!--#Include file="Include/BackLink.asp" --></td>
		</tr>
	</table>
	<%=strTextIfYouHaveBeenGivenAProfileCode%>
	<form name="thisForm" id="thisForm" method="post" action="entertestcode.asp?res=<%=intResellerID%>">
	<input type="hidden" name="txtTRUserID" id="txtTRUserID" Value="<%=TRUserID%>">
	<input type="hidden" name="txtSubmit" id="txtSubmit" value=1>
	<table border="0" cellspacing="0" cellpadding="3" width="100%">
		<tr> 
			<td valign="middle">&nbsp;</td>
			<td valign="middle">
				<% If strErrMsg <> "" Then
					Response.Write "<span class=""errortext"">" & strErrMsg & "</span>"
				Else
					Response.Write "&nbsp;"
				End If %>
			</td>
		</tr>
		<tr>
			<td valign="middle" align="right" width="25%"><strong><%=strTextProfileCode%>:</strong><p> &nbsp;</p></td>
			<td valign="middle" width="75%">
				<input type="text" name="txtTestCodeEntered" id="txtTestCodeEntered" maxlength="50" size="35" value="<%=TestCodeEntered%>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="submit" name="Submit" value="<%=Application("strTextSubmit" & strLanguageCode)%>"><p><em><%=strTextUseAllCapsWhenEnteringProfileCodes%></em></p>
			</td>
		</tr>
	</table>
	</form>
	
		
	<!--#Include File="Include/divider.asp" -->
	<% If strSiteType <> "Focus3" Then%>
	<h2><%=strTextPreviouslyPurchasedProfileCodes%></h2>
	<p><%=strTextToTakeAProfileOrCreateAnApplicationReport%></p>
	<% Else %>
	<p><%=strTextIfYouWereInterruptedWhileTa%></p>
	<% End If %>
	<%
    




	Dim oConn2, oCmd2, oRs2
	Set oConn2 = CreateObject("ADODB.Connection")
	Set oCmd2 = CreateObject("ADODB.Command")
	Set oRs2 = CreateObject("ADODB.Recordset")
	With oCmd2
		.CommandText = "sel_Tests_First"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		.Parameters.Append .CreateParameter("@UserID", 3, 1, 4, Request.Cookies("UserID"))
		.Parameters.Append .CreateParameter("@intLanguageID", 3, 1, 4, intLanguageID)
	End With
	oConn2.Open strDbConnString
	oCmd2.ActiveConnection = oConn2
	oRs2.CursorLocation = 3
	oRs2.Open oCmd2, , 0, 1
	If oConn2.Errors.Count < 1 Then
		If oRs2.EOF = False Then
			oRs2.MoveFirst
			Response.Write "<div align=""center"">" & VbCrLf
			Response.Write "<table class=""addtable"" border=""0"" cellspacing=""0"" cellpadding=""6"" width=""85%"">" & VbCrLf
			Response.Write "	<tr>" & VbCrLf
			Response.Write "		<td valign=""middle"" align=""left""><span class=""headertext2"">" & strTextTitle & "</span></td>" & VbCrLf
			Response.Write "		<td valign=""middle"" align=""left""><span class=""headertext2"">" & strTextProfileCode & "</span></td>" & VbCrLf
			Response.Write "	</tr>" & VbCrLf
			Do While oRs2.EOF = False
				If (Left(oRs2("TestCode"),4) = "PDIP") Or (Left(oRs2("TestCode"),4) = "PDDG") Then 'TODO: PDI Test Itself?
					Response.Write "<tr>" & VbCrLf
					Response.Write "	<td valign=""top"" align=""left"">" & VbCrLf
					Response.Write "		<a href=""" & oRs2("DescLink") & "?res=" & intResellerID & """>" & oRs2("TestName") & "</a><br />" & VbCrLf
					Response.Write "		<span class=""bodytext_gray"">" & strTextPurchased & " " & oRs2("DatePurchased") & "</span>" & VbCrLf
					Response.Write "	</td>" & VbCrLf
					Response.Write "	<td valign=""top"" align=""left""><a href=""EnterTestCode.asp?MPS=1&amp;TCODE=" & oRs2("TestCode") & "&res=" & intResellerID & """>" & oRs2("TestCode") & "</a>" & VbCrLf
					Response.Write "	</td>" & VbCrLf
					Response.Write "</tr>" & VbCrLf
				Else																				'TODO: One of the modules?
					Response.Write "<tr>" & VbCrLf
					Response.Write "	<td valign=""top"" align=""left"">" & VbCrLf
					Response.Write "		<a href=""" & oRs2("DescLink") & "?res=" & intResellerID & """>" & oRs2("TestName") & "</a><br />" & VbCrLf
					Response.Write "		<span class=""bodytext_gray"">" & strTextPurchased & " " &oRs2("DatePurchased") & "</span>" & VbCrLf
					Response.Write "	</td>" & VbCrLf
					Response.Write "	<td valign=""top"" align=""left""><a href=""javascript:confirmAppPDFCreation(" & oRs2("TestCodeID") & ")"">" & oRs2("TestCode") & "</a></td>" & VbCrLf
					Response.Write "</tr>" & VbCrLf
				End If
				oRs2.MoveNext
			Loop
			Response.Write "</table>" & VbCrLf
			Response.Write "</div>" & VbCrLf
		Else '[SM] No records founds, so insert nothing (changed from a placeholder).
		End If
	Else
		Response.Write "<BR><BR>" & strTextTransactionFailed & "<BR><BR>" & VbCrLf
		Response.Write Err.description
		Err.Clear
	End If
	If strSiteType <> "Focus3" Then
		Response.Write "<p>" & strTextIfYouDoNotHaveAProfileCodeYouWillNeedTo & " <a href=""PurchaseTest.asp?res=" & intResellerID & """>" & LCase(strTextPurchase) & "</a> " & strTextOneOrRequestOneFromPersonnelResponsibleFor & "</p>" & VbCrLf
        Response.Write "<p>If you have purchased a profile code and it is not listed above, click <a href=""TransactionSearch.asp?userId=" & TRUserID & "&res=" & intResellerID & "&lid=" & intLanguageID & """>HERE</a> to retrieve them. </p>" & VbCrLf

	End If
	Response.Write "<div align=""center"">" & VbCrLf
	Response.Write "<table class=""addtable"" border=""0"" cellspacing=""0"" cellpadding=""6"" width=""85%"">" & VbCrLf
	Response.Write "	<tr>" & VbCrLf
	Response.Write "		<td valign=""top"" align=""right"" width=""25%""><a href=""http://www.adobe.com/products/acrobat/readstep2.html"" target=""_blank""><img src=""images/get_acrobat_reader.gif"" alt="""" width=""88"" height=""31"" /></a></td>" & VbCrLf
	Response.Write "		<td valign=""top"" align=""left"" width=""75%""><strong>" & UCase(Application("strTextNote" & strLanguageCode)) & ":</strong>" &  strTextYouMustHaveAdobeAcrobatReaderInstalledTo & " <a href=""http://www.adobe.com/products/acrobat/readstep2.html"" target=""_blank"">" & strTextDownload & "</a> " & strTextThisFreeProgramFromTheAdobeWebsite & VbCrLf
	Response.Write "		</td>" & VbCrLf
	Response.Write "	</tr>" & VbCrLf
	Response.Write "</table>" & VbCrLf
	Response.Write "</div>" & VbCrLf
	Response.Write "<script>" & VbCrLf
	Response.Write "function confirmAppPDFCreation(TCID) {" & VbCrLf
	Response.Write "	if (window.confirm(""" & strTextItWillTakeAboutAMinuteToGenerateYour & "\r\r" & strTextYouWillThenBeProvidedADownloadLink & """))" & VbCrLf
	Response.Write "	{" & VbCrLf
	Response.Write "		var goToNextURL;" & VbCrLf
	Response.Write "		goToNextURL = ""AppModuleCreatePDF.asp?res=" & intResellerID & "&TCID="" + TCID + ""&lid=" & intLanguageID & """;" & VbCrLf
	Response.Write "		document.location = goToNextURL;" & VbCrLf
	Response.Write "	}" & VbCrLf
	Response.Write "}" & VbCrLf
	Response.Write "</script>" & VbCrLf
Response.Write "</div>" & VbCrLf
Response.Write "</body>" & VbCrLf
Response.Write "</html>" & VbCrLf
%>
    </div>

