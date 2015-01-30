<%@  language="VBScript" codepage="65001" %>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 3	' Main authenticated Page

%>

<!--#Include file="Include/Common.asp" -->
<%
' TODO: Remove this line of code when the German site is complete
If strLanguageCode = "DE" Then
	strLanguageCode = "EN"
End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title><%=strTextPageName%></title>
    <meta http-equiv="Cache-Control" content="no-cache" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="Include/Default.css" type="text/css">
    <link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
    <style type="text/css">
        a.pCode:link {
            background-color: blue;
            color: white;
            font-size: 18pt;
            margin-left: 2px;
            margin-right: 2px;
        }

        a.pCode:active {
            background-color: magenta;
            color: white;
            font-size: 18pt;
            margin-left: 2px;
            margin-right: 2px;
        }

        a.pCode:visited {
            background-color: blue;
            color: white;
            font-size: 18pt;
            margin-left: 2px;
            margin-right: 2px;
        }

        a.pCode:hover {
            background-color: magenta;
            color: white;
            font-size: 18pt;
            margin-left: 2px;
            margin-right: 2px;
        }
    </style>
    <!--<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>-->
    <!--#Include File="Include/HeadStuff.asp" -->
</head>
<body>
    <!--#Include file="Include/TopBanner.asp" -->
    <div id="main">
        <div id="maincontent">
            <script type="text/javascript" language="Javascript">
	        <!--
    function displayPopup(url, height, width) {
        properties = "toolbar=0,location=0,scrollbars=0,height=" + height;
        properties = properties + ",width=" + width;
        properties = properties + ",left=0,top=0";
        poppupHandle = window.open(url, "DISCProfile", properties);
    }
    // -->
            </script>
            <%
            
	        Dim strUserName, strUserID, strCompanyName, strCompanyID
	        strUserName = Request.Cookies("UserName")
	        strUserID = Request.Cookies("UserID")
	        strCompanyName = Request.Cookies("CompanyName")
	        strCompanyID = Request.Cookies("CompanyID")

	        Dim TCID
	        TCID = Request.QueryString("TCID")
	        ' the user is just completing a test if TCID is not blank
	        if TCID <> "" then
		        ' so mark the test as completed so that the PDF file will
		        ' display in the list?
	        end if
	
	        Dim NewUser
	        NewUser = Request.QueryString("NewUser")
	        if NewUser = 1 then
		        welcomeMsg = strTextThanksForRegistering & "!"
	        else
		        welcomeMsg = ""
	        end if
	
	        Dim UserID
	        UserID = Request.Cookies("UserID")
	        If UserID = "" Then
		        UserID = ""
                Response.Redirect "Login.asp?intResellerID=" & intResellerId

	        End If

	        ' [SM] TRI wants both PDI and application reports to appear in the "Previous Results" section. The first one pulls the info
	        ' [SM] for the PDI reports. The second one pulls the info for the application reports.
	        ' [SM] It's messy, but I couldn't determine a quicker way to fulfill TRI's request.
	        Dim oConn, oCmd, oRs
	        Set oConn = CreateObject("ADODB.Connection")
	        Set oCmd = CreateObject("ADODB.Command")
	        Set oRs = CreateObject("ADODB.Recordset")
	        With oCmd
		          .CommandText = "sel_PDITest_PDFFileName_TTID"
		          .CommandType = 4
		          .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		          .Parameters.Append .CreateParameter("@TestTakerID",3, 1,4, UserID)
	        End With
	        oConn.Open strDbConnString
	        oCmd.ActiveConnection = oConn
	        oRs.CursorLocation = 3
	        oRs.Open oCmd, , 0, 1
	
	        ' [SM] Calling the second stored procedure (same one used in pcoderecon.asp, which is a page from the old site)
	        Dim oConn2, oCmd2, oRs2
	        Set oConn2 = CreateObject("ADODB.Connection")
	        Set oCmd2 = CreateObject("ADODB.Command")
	        Set oRs2 = CreateObject("ADODB.Recordset")
	        With oCmd2
		        .CommandText = "spTestStatusSelect"
		        .CommandType = 4
		        .Parameters.Append .CreateParameter("@RETURN_VALUE", 3,  4, 0)
		        .Parameters.Append .CreateParameter("@PurchaserID", 3, 1, 4, UserID)
		        ' getting tests that have been redeemed but not started
		        .Parameters.Append .CreateParameter("@TestStatus", 3, 1, 4, 4)
	        End With
	        oConn2.Open strDbConnString
	        oCmd2.ActiveConnection = oConn2
	        oRs2.CursorLocation = 3
	        oRs2.Open oCmd2, , 0, 1
	
	        If oConn2.Errors.Count > 0 Then
		        Response.Write "<font color=""#ff0000""><br><br><strong>Unfortunately, you have cookies disabled and this site requires cookies to function properly.</strong>"
		        Response.Write "<br><br>To change your cookie settings in Internet Explorer, go to Tools, Internet Option and click on the Privary tab and drag the slider bar down to Low. Then, click OK. Now, close out this browser and open a new one and visit this site again. The system will then work correctly. Thank you for your help and understanding.</font>"
                Response.Redirect "Login.asp?intResellerID=" & intResellerId
	        End If
	
	        Dim PDFReportDir, PDIReportName, PDIReportPath, appReportName, appReportPath, PDIReportsAvail
	        PDIReportsAvail = TRUE ' [SM] To determine if we should insert a placeholder if no records found.
        '	PDFReportDir = "../trmain/PDFReports/"
	        PDFReportDir = "/PDFReports/"
	
	        If (oConn.Errors.Count < 1) AND (oConn2.Errors.Count < 1) Then
		        Response.Write "<h2>"  &Application("strTextWelcome" & strLanguageCode) & " " & strFirstName & "! " & welcomeMsg & "</h2>"
		        Response.Write "<p>" & strTextPleaseChooseFromOptionsBelow & "</p>"
		        Response.Write "<table class=""addtable"" border=""0"" cellspacing=""0"" cellpadding=""3"" width=""100%"">" & VbCrLf
		        Response.Write VbTab & "<tr>" & VbCrLf
		        Response.Write VbTab & VbTab & "<td valign=""top"" style=""padding-right:12px"" width=""50%"">" & VbCrLf
		        If strSiteType <> "Focus3" Then
			        Response.Write VbTab & VbTab & VbTab & "<p class=""aligncenter""><span class=""heading"">" & strTextNeedToPurchaseAProfile & "?</span></p>" & VbCrLf
			        Response.Write VbTab & VbTab & VbTab & "<p class=""aligncenter"">" & strTextIfYouDoNotHaveAProfileCode & "</p>" & VbCrLf
			        Response.Write VbTab & VbTab & VbTab & "<p class=""aligncenter"">"

			        If intResellerID = 2 Then 
				        'Response.Write "<a href=""purchaseDG.asp?res=" & intResellerID & """>" & StrTextPurchaseProfile & "</a></p>" & VbCrLf
				        Response.Write "<input type=""button"" onclick=""window.location='purchaseDG.asp?res=" & intResellerID & "'"" value=""Purchase Now"">"
			        Else
				        Response.Write "<a href=""purchasetest.asp?res=" & intResellerID & """>" & StrTextPurchaseProfile & "</a></p>" & VbCrLf
			        End If

			        If strSiteType <> "Focus3" Then 'Focus3 does not want to display these options
				        Response.Write VbTab & VbTab & VbTab & "<p class=""aligncenter"">" & strTextHaveYouAlreadyTakenTheDISC & "</p>" & VbCrLf
				        Response.Write VbTab & VbTab & VbTab & "<p class=""aligncenter""><a href=""PDIProfileBypassPDI.asp?res=" & intResellerID & """>" & strTextClickHere & "</a></p>" & VbCrLf
			        End If
			        Response.Write VbTab & VbTab & "</td>" & VbCrLf
			        Response.Write VbTab & VbTab & "<td valign=""top"" width=""50%"">" & VbCrLf
			        Response.Write VbTab & VbTab & VbTab & "<p class=""aligncenter""><span class=""heading"">" & strTextNeedToUseAProfile & "?</span></p>" & VbCrLf
			        Response.Write "<p class=""aligncenter"">" & strTextHaveAProfileCodeAlreadyAnd & "</p>" & VbCrLf
    		
    
    
                    Response.Write "<p class=""aligncenter""><a href=""EnterTestCode.asp?res=" & intResellerID & "&lid=" & intLanguageID & """>" & strTextUseProfileCode & "</a></p>" & VbCrLf
			        'Response.Write "<p class=""aligncenter""><a href=""EnterTestCodeCopy.asp?res=" & intResellerID & "&lid=" & intLanguageID & """>" & strTextUseProfileCode & "</a></p>" & VbCrLf
		
                Else
			        Response.Write "<table width='100%'><tr><td><span style='font-size:10pt;font-weight:bold'>" & strTextClickHereToCompleteYourDisc & ":</span> <a class='pCode' href=""EnterTestCode.asp?res=" & intResellerID & """>&nbsp;" & strTextUseProfileCode & "&nbsp;</a>" 
			        Response.Write "<BR>(" & strTextNoteAtTheEndOfThisProcess & ")</td></tr></table>"
		        End If
            %>
				        </td>		
			        </tr>
		        </table>
		        <!--#Include file="Include/divider.asp" -->
            <table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
                <tr>
                    <td valign="top" style="padding-right: 12px" width="50%">
                        <p class="aligncenter"><span class="heading"><%=strTextPreviousResults%></span></p>
                        <% If strSiteType = "Focus3" Then
							        Response.Write strTextReturningUsersClickBelowTo & "<BR><BR>"
						         End If
                        %>
                        <table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
                            <%
	        ' [SM] Start listing PDI Reports
	        If oRs.EOF = False Then
		        oRs.MoveFirst
		        Do While oRs.EOF = False
			        PDIReportName = oRs("PDFFileName")
			        PDIReportPath = PDFReportDir & PDIReportName
			        Response.Write "<tr>" & VbCrLf
			        Response.Write "<td valign=""top"">" & VbCrLf
			        Response.Write strTextPersonalDISCernmentInventory & "<sup>&reg;</sup><br />" & VbCrLf
			        Response.Write "<a href=""" & PDIReportPath & """>" & strTextCompleteReportPDF & "</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=""PDIProfileResults.asp?PTSID=" & oRs("PDITestSummaryID") & "&P1=" & oRs("ProfileID1") & "&P2=" & oRs("ProfileID2") & "&TCID=" & oRs("TestCodeID") & "&CP=" & oRs("CustomProfile") & "&res=" & intResellerID & """>" & strTextOnlineSummary & "</a><br />" & VbCrLf
			        Response.Write "<span class=""bodytext_gray"">" & strTextReportCreated & " " & oRs("FileCreationDate") & "</span>" & VbCrLf
			        Response.Write "</td>" & VbCrLf
			        Response.Write "</tr>" & VbCrLf
		        oRs.MoveNext
		        Loop
	        Else '[SM] There are no PDI reports, so update the flag
		        PDIReportsAvail = False
	        End If
	
	        ' [SM] Start listing Application Reports
	        If oRs2.EOF = False Then
		        oRs2.MoveFirst
		        Do While oRs2.EOF = False
			        appReportName = oRs2("AppModFileName")
			        appReportPath = PDFReportDir & appReportName
			
			        If InStr(1, oRs2("AppModFileName"), "SELL", 0) > 0 Then
				        Response.Write "<tr>" & VbCrLf
				        Response.Write "	<td valign=""top"">" & VbCrLf
				        Response.Write VbTab & VbTab & strTextSellingWithStyle & "<sup>&reg;</sup><br />" & VbCrLf
				        Response.Write VbTab & VbTab & "<a href=""" & appReportPath & "?res=" & intResellerID & """>" & strTextCompleteReportPDF & "</a><br />" & VbCrLf
				        Response.Write VbTab & VbTab & "<span class=""bodytext_gray"">" & strTextReportCreated & " " & oRs2("RedeemDate") & "</span>" & VbCrLf
				        Response.Write VbTab & "</td>" & VbCrLf
				        Response.Write "</tr>" & VbCrLf
			        ElseIf InStr(1, oRs2("AppModFileName"), "COMM", 0) > 0 Then
				        Response.Write "<tr>" & VbCrLf
				        Response.Write VbTab & "<td valign=""top"">" & VbCrLf
				        Response.Write VbTab & VbTab & strTextCommunicatingWithStyle & "<sup>&reg;</sup><br />" & VbCrLf
				        Response.Write VbTab & VbTab & "<a href=""" & appReportPath & "?res=" & intResellerID & """>" & strTextCompleteReportPDF & "</a><br />" & VbCrLf
				        Response.Write VbTab & VbTab & "<span class=""bodytext_gray"">" & strTextReportCreated & " " & oRs2("RedeemDate") & "</span>" & VbCrLf
				        Response.Write VbTab & "</td>" & VbCrLf
				        Response.Write "</tr>" & VbCrLf
			        ElseIf InStr(1, oRs2("AppModFileName"), "TEAM", 0) > 0 Then
				        Response.Write "<tr>" & VbCrLf
				        Response.Write VbTab & "<td valign=""top"">" & VbCrLf
				        Response.Write VbTab & VbTab & strTextTeamworkWithStyle & "<sup>&reg;</sup><br />" & VbCrLf
				        Response.Write VbTab & VbTab & "<a href=""" & appReportPath & "?res=" & intResellerID & """>" & strTextCompleteReportPDF & "</a><br />" & VbCrLf
				        Response.Write "<span class=""bodytext_gray"">" & strTextReportCreated & " " & oRs2("RedeemDate") & "</span>" & VbCrLf
				        Response.Write VbTab & "</td>" & VbCrLf
				        Response.Write "</tr>" & VbCrLf
			        ElseIf InStr(1, oRs2("AppModFileName"), "LEAD", 0) > 0 Then
				        Response.Write "<tr>" & VbCrLf
				        Response.Write VbTab & "<td valign=""top"">" & VbCrLf
				        Response.Write VbTab & VbTab & strTextLeadingWithStyle & "<sup>&reg;</sup><br />" & VbCrLf
				        Response.Write VbTab & VbTab & "<a href=""" & appReportPath & "?res=" & intResellerID & """>" & strTextCompleteReportPDF & "</a><br />" & VbCrLf
				        Response.Write "<span class=""bodytext_gray"">" & strTextReportCreated & " " & oRs2("RedeemDate") & "</span>" & VbCrLf
				        Response.Write VbTab & "</td>" & VbCrLf
				        Response.Write "</tr>" & VbCrLf
			        ElseIf InStr(1, oRs2("AppModFileName"), "TIME", 0) > 0 Then
				        Response.Write "<tr>" & VbCrLf
				        Response.Write VbTab & "<td valign=""top"">" & VbCrLf
				        Response.Write 	VbTab & VbTab & strTextTimeManagementWithStyle & "<sup>&reg;</sup><br />" & VbCrLf
				        Response.Write "<a href=""" & appReportPath & "?res=" & intResellerID & """>" & strTextCompleteReportPDF & "</a><br />" & VbCrLf
				        Response.Write "<span class=""bodytext_gray"">" & strTextReportCreated & " " & oRs2("RedeemDate") & "</span>" & VbCrLf
				        Response.Write VbTab & "</td>" & VbCrLf
				        Response.Write "</tr>" & VbCrLf
			        ElseIf InStr(1, oRs2("AppModFileName"), "DRMA", 0) > 0 Then
				        Response.Write "<tr>" & VbCrLf
				        Response.Write VbTab & "<td valign=""top"">" & VbCrLf
				        Response.Write VbTab & VbTab & strTextTheDreamAssessment & "<sup>&reg;</sup><br />" & VbCrLf
				        Response.Write VbTab & VbTab & "<a href=""" & appReportPath & "?res=" & intResellerID & """>" & strTextCompleteReportPDF & "</a><br />" & VbCrLf
				        Response.Write VbTab & VbTab & "<span class=""bodytext_gray"">" & strTextReportCreated & " " & oRs2("RedeemDate") & "</span>" & VbCrLf
				        Response.Write VbTab & "</td>" & VbCrLf
				        Response.Write "</tr>" & VbCrLf
			        End If
				        oRs2.MoveNext
			        Loop
	        Else '[SM] There are no application records, so insert a placeholder if necessary
		        If PDIReportsAvail = FALSE Then
				        Response.Write "<tr>" & VbCrLf
				        Response.Write VbTab & "<td valign=""top"">" & VbCrLf
				        Response.Write VbTab & VbTab & "<em>" & strTextNoReportsAvailable & ".</em>" & VbCrLf
				        Response.Write VbTab & "</td>" & VbCrLf
				        Response.Write "</tr>" & VbCrLf
		        End If
	        End If
	        Response.Write "			</table>" & VbCrLf
	        Response.Write "		</td>" & VbCrLf
	        Response.Write "		<td valign=""top"" width=""50%"">" & VbCrLf
	        '***************Edit your personal information section******************************************************************
	        If strSiteType <> "Focus3" Then
		        Response.Write "			<p class=""aligncenter""><span class=""heading"">" & strTextEditYourPersonalInformation & "</span></p>" & VbCrLf
		        Response.Write "			<p class=""aligncenter"">" & strTextUpdateThePersonalInformationYou & "</p>" & VbCrLf
		        Response.Write "			<p class=""aligncenter""><a href=""UserRegistrationInfo.asp?res=" & intResellerID & """>" & strTextEditInformation & "</a></p>" & VbCrLf
	        End If
	        '***********************************************************************************************************************
	        Response.Write "		</td>" & VbCrLf
	        Response.Write "	</tr>" & VbCrLf
	        Response.Write "</table>" & VbCrLf
        Else
	        Response.Write "<BR><BR>" & strTextTransactionFailed & "<BR><BR>" & VbCrLf
	        Response.Write Err.description
	        Err.Clear
        End If
                            %>
                            <!--#Include file="Include/divider.asp" -->
                            <%
	        Response.Write "<H2>" & strTextLearnMore & "</H2>" & VbCrLf
            Response.Write "<div>" & VbCrLf
	        Response.Write "<ul>" & VbCrLf
	        Response.Write "<li class=""login_learnmore"">" & Application("strTextThe" & strLanguageCode) & " <a class=""login_learnmore_link"" href=""DISCBackground.asp?res=" & intResellerID & """ & target=""_top"">" & strTextHistoryAndTheory & "</a> " & strTextOfDISC & "</li>" & VbCrLf
	        Response.Write "<li class=""login_learnmore"">" & Application("strTextThe" & strLanguageCode) & " <a class=""login_learnmore_link"" href=""OnlinePDIReport.asp?res=" & intResellerID & """ target=""_top"">" & strTextOnline & "</a>" & VbCrLf
 	        Response.Write strTextPersonalDISCernmentInventoryRegMark & "</li>" & VbCrLf
	        If strSiteType <> "Focus3" Then 'Focus3 does not want to display these options
		        If IntResellerID = 2 Then
			        Response.Write "<li class=""login_learnmore"">" & Application("strTextThe" & strLanguageCode) & " <a class=""login_learnmore_link"" href=""DGAssessment.asp?res=" & intResellerID & """ target=""_top""> " & strTextTheDreamAssessment & "</a></li>" & VbCrLf
			        Response.Write "<li class=""login_learnmore"">" & Application("strTextThe" & strLanguageCode) & " <a class=""login_learnmore_link"" href=""disc_profile.asp?res=" & intResellerID & """ target=""_top""> " & strTextDISCProfile & "</a>" & VbCrLf
			        Response.Write strTextSystem & "<sup>&reg;</sup></li>" & VbCrLf
		        Else
			        Response.Write "<li class=""login_learnmore"">" & strTextTailored & " <a class=""login_learnmore_link"" href=""PDIAppReports.asp?res=" & intResellerID & """ target=""_top""> " & strTextApplicationReports & "</a></li>" & VbCrLf
			        Response.Write "<li class=""login_learnmore""><a class=""login_learnmore_link"" href=""VolumeDiscounts.asp?res=" & intResellerID & """ target=""_top"">" & strTextMultipleCopies & "</a> / " & strTextVolumeDiscounts & "</li>" & VbCrLf
		        End If
	        Response.Write "<li class=""login_learnmore""><a class=""login_learnmore_link"" href=""PrivacyPolicy.asp?res=" & intResellerID & """ target=""_top"">" & strTextPrivacyPolicy & "</a></li>" & VbCrLf
	        End If
	        Response.Write "</ul>" & VbCrLf
            Response.Write "</div>" & VbCrLf
	        'Response.Write "<br><br>" & VbCrLf
	        'Response.Write "UserTypeID = " & Request.Cookies("UserTypeID") & "<br><br>"

	        '=====================================================================================
	        ' If a non-admin user has special rights then show them the appropriate links
	        '=====================================================================================
	        Dim IsProfileMgr
	        IsProfileMgr = Request.Cookies("IsProfileMgr")
	        If IsProfileMgr = "" Then
		        IsProfileMgr = 0
	        End If
	        If IsProfileMgr = 1 Then
		        Response.Write("<hr style=""color:#000000;height:1px;""><a href=""http://www.pdiprofile.com/epdicorp/profiletracker.aspx?res=" & intResellerID & "&userID=" & UserID & """ class=""login_learnmore_link;"">Test Results Tracking</a><br><br>")
	        End If
	
	        Dim IsFinancialsViewer
	        IsFinancialsViewer = Request.Cookies("IsFinancialsViewer")
	        If IsFinancialsViewer = "" Then
		        IsFinancialsViewer = 0
	        End If
	        If IsFinancialsViewer = 1 Then
		        Response.Write("<hr style=""color:#000000;height:1px;""><a href=""Admin/ReportingResellerDetailMonthlyByDay.asp?res=" & intResellerID & """ class=""login_learnmore_link;"">View Financials</a><br><br>")
	        End If
	
	        '=====================================================================================
	        ' only show this to internal admin users											  
	        '=====================================================================================
	
	        Dim UserTypeID
	        UserTypeID = Request.Cookies("UserTypeID")
	        If UserTypeID = "" Then
		        UserTypeID = 0
	        End If
	        If UserTypeID = 4 Then %>
                            <h1><%=strTextInternalMenu%></h1>
                            <a href="Admin/Default.asp?res=<%=intResellerID%>"><%=strTextGoToAdminArea%></a>
                            <br>
                            <br>
                            <a href="Translation/TextPageInsertion.asp?res=<%=intResellerID%>">Enter New Page Text into Database</a>
                            <br>
                            <br>
                            <a href="Translation/TextSearchList.asp?res=<%=intResellerID%>">Translate Existing Text in Database</a>

                            <br>
                            <br>
                            <hr>
                            <font color="#FF0000">Items below this line have not been reworked to accomodate recent system changes and should not be used.</font><br>
                            <hr>
                            <a href="Admin/sel_priceplan_all.asp?res=<%=intResellerID%>">Add/Edit Price Plans</a>
                            <br>
                            <br>
                            <a href="Admin/accountingMonthlyReportSite.asp?res=<%=intResellerID%>">Accounting Monthly Site Report</a>
                            <br>
                            <br>
                            <a href="Admin/ReportingResellerTotalsMonthly.asp?res=<%=intResellerID%>">Accounting Monthly Site Report</a>
                            <br>
                            <br>
                            <a href="Admin/ReportingResellerTotalsMonthly.asp?res=<%=intResellerID%>">Accounting Monthly Reseller Report</a>
                            <br>
                            <br>
                            <a href="Admin/accountingDailyReportSite.asp?res=<%=intResellerID%>">Accounting Daily Report</a>
                            <br>
                            <br>
                            <a href="Admin/accountingDailyReportCompanySite.asp?res=<%=intResellerID%>">Accounting Daily Report by Company</a>
                            <br>
                            <br>
                            <br>
                            <br>
                            <a href="Admin/companysrch.asp?res=<%=intResellerID%>">Edit Company Information including Price Plan</a>
                            <br>
                            <br>
                            <a href="Admin/usersrch.asp?res=<%=intResellerID%>">Edit User Information including User Type (Regular, Admin, etc)</a>
                            <br>
                            <br>
                            <a href="Admin/viewtestcodeinfo.asp?res=<%=intResellerID%>">View Profile Code Information</a>
                            <br>
                            <br>
                            <a href="Admin/ins_companyalias.asp?res=<%=intResellerID%>">Add Alias Company</a>
                            <br>
                            <br>
                            <% End If %>

                            <script>
		        function genappmod(TCID)
		        {
			        var x = confirm("<%=strTextAreYouSureYouWantToRedeemApplication%>")
			        if(x) {
				        window.location = "AppModuleCreatePDF.asp?res=<%=intResellerID%>&TCID=" + TCID;
			        }
			        return;
		        }
                            </script>
        </div>

    </div>
</body>
</html>
