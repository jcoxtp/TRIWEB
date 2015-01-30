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

<div id="maincontent">
	<script language="Javascript">
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

    'if user used the invoice number from email, then we need to check that it is a numeric value and get the record set of purchased profile codes.
    If(IsNumeric(TestCodeEntered)) Then
        'use Invoice number to retrieve Profile code.
	    Set oConn = CreateObject("ADODB.Connection")
	    Set oCmdProfileCodes = CreateObject("ADODB.Command")
	    Set oRsProfileCodes = CreateObject("ADODB.Recordset")
	    With oCmdProfileCodes
		    .CommandText = "spPurchaseGetTestCodes"
		    .CommandType = 4
		    .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		    .Parameters.Append .CreateParameter("@intPurchaseID",3, 1,4, TestCodeEntered)
	    End With
	    oConn.Open strDbConnString
	    oCmdProfileCodes.ActiveConnection = oConn
	    oRsProfileCodes.CursorLocation = 3
	    oRsProfileCodes.Open oCmd, , 0, 1
            
        'set Profile Code from returned dataset

        oRsProfileCodes.Close()
        oRsProfileCodes = nothing

    End if

	
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
	'Now, go and get all of the TestCodes just purchased
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	With oCmd
		.CommandText = "spPurchaseGetTestCodes"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		.Parameters.Append .CreateParameter("@intPurchaseID",3, 1,4, 7753)
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	
	intCount = 1
	If oConn.Errors.Count < 1 Then
		If oRs.EOF = FALSE Then %>
<!--				<img src="images/your_purchase.gif">-->
				<p style="margin-bottom:0px">
				<table border="0" cellspacing="0" cellpadding="6" width="100%">
					<tr>
<!--						<td valign="top" align="center" width="32"><img src="images/reports.gif" alt="" width="32" height="32" /></td>-->
						<td valign="top">
<!--							<h2><%=strTextTakeProfileOrCreateAnApplicationReport%></h2>
							<p><%=strTextToTakeTheProfileOrCreate%></p>-->

							<div align="center">
							<p style="margin-bottom:0px">
							<table border="0" cellspacing="0" cellpadding="6" width="90%">
								<tr>
									<td valign="top" align="center" width="5%"><strong><%=strTextNumber%></strong></td>
									<td valign="top" width="60%"><strong><%=strTextTitle%></strong></td>
									<td valign="top" width="35%"><strong><%=strTextProfileCodesPurchased%></strong></td>
								</tr>
							<%
							'Flag used to determine the type of link needed to open next page
							'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
							Dim Flag
							while oRs.EOF = FALSE %>
								<tr>
                                    <!--Number Column-->
									<td valign="top" align="center"><%=intCount%>
									</td>
                                    <!--Title Column-->
									<td valign="top">
									<% '[SM] A hack to get the titles and descriptions
										If (Left(oRs("TestCode"),4) = "PDIP") Then
											Flag=1
											Response.Write "<a href=""OnlinePDIReport.asp?res=" & intResellerID & """>" & strTextPersonalDISCernmentInventoryRegMark & "</a><br />"
											Response.Write "<span class=""bodytext_gray"">" & strTextTheCoreOfTheDISCProfileSystem & "</span>"
										ElseIf (Left(oRs("TestCode"),4) = "PDDG") Then
											Flag=1
											Response.Write "<a href=""OnlinePDDGReport.asp?res=" & intResellerID & """>" & strTextPersonalDISCernmentInventoryRegMark & "</a><br />"
											Response.Write "<span class=""bodytext_gray"">" & strTextTheCoreOfTheDISCProfileSystem & "</span>"
										ElseIf (Left(oRs("TestCode"),4) = "SELL") Then
											Response.Write "<a href=""PDIAppReports_selling.asp?res=" & intResellerID & """>" & SellingWithStyleRegMark & "</a><br />"
											Response.Write "<span class=""bodytext_gray"">" & strTextADISCProfileSystemTailoredApplicationReport & "</span>"
										ElseIf (Left(oRs("TestCode"),4) = "COMM") Then
											Response.Write "<a href=""PDIAppReports_communicating.asp?res=" & intResellerID & """>" & strTextCommunicatingWithStyleRegMark & "</a><br />"
											Response.Write "<span class=""bodytext_gray"">" & strTextADISCProfileSystemTailoredApplicationReport & "</span>"
										ElseIf (Left(oRs("TestCode"),4) = "TEAM") Then
											Response.Write "<a href=""PDIAppReports_teamwork.asp?res=" & intResellerID & """>" & strTextTeamworkWithStyleRegMark & "</a><br />"
											Response.Write "<span class=""bodytext_gray"">" & strTextADISCProfileSystemTailoredApplicationReport & "</span>"
										ElseIf (Left(oRs("TestCode"),4) = "LEAD") Then
											Response.Write "<a href=""PDIAppReports_leading.asp?res=" & intResellerID & """>" & strTextLeadingWithStyleRegMark & "</a><br />"
											Response.Write "<span class=""bodytext_gray"">" & strTextADISCProfileSystemTailoredApplicationReport & "</span>"
										ElseIf (Left(oRs("TestCode"),4) = "TIME") Then
											Response.Write "<a href=""PDIAppReports_time.asp?res=" & intResellerID & """>" & strTextTimeManagementWithStyleRegMark & "</a><br />"
											Response.Write "<span class=""bodytext_gray"">" & strTextADISCProfileSystemTailoredApplicationReport & "</span>"
										ElseIf (Left(oRs("TestCode"),4) = "DRMA") Then
											Response.Write "<a href=""DGAssessment.asp?res=" & intResellerID & """>" & strTextTheDreamAssessmentRegMark & "</a><br />"
											Response.Write "<span class=""bodytext_gray"">" & strTextADISCProfileSystemTailoredApplicationReport & "</span>"
										End If %>
									</td>
                                    <!--Profile Code Column Column-->
									<td valign="top">
									<% If Flag = 1 Then%>
										<a href="entertestcode.asp?res=<%=intResellerID%>&MPS=1&TCODE=<%=oRs("TestCode")%>"><%=oRs("TestCode")%></a>
									<%Else%>
										<a href="javascript:confirmAppPDFCreation(<%=oRs("TestCodeID")%>)"><%=oRs("TestCode")%></a>
									<%End If%>
									</td>
								</tr>
							<%
								oRs.MoveNext
								intCount = intCount + 1
							Flag=0
							Wend %>
							</table>
	<!--Javascript to make new links work (ePDI Punch List #3)-->
	<script>	
	function confirmAppPDFCreation(TCID)
	{
		if (window.confirm("It will take about a minute to generate your application report.\r\rYou will then be provided a download link."))
		{
			var goToNextURL;
			goToNextURL = "AppModuleCreatePDF.asp?res=<%=intResellerID%>&TCID=" + TCID + "";
			document.location = goToNextURL;
		}
	}
	</script>
							</p>
							</div>
						</td>
					</tr>
				</table>
				</p>
				<!--#Include FILE="Include/divider.asp" -->
			<%
			End If
		End If %>
    </body>
    </html>
