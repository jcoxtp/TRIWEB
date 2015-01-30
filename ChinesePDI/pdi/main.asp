<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/checklogin.asp" -->
<!--#INCLUDE FILE="include/common.asp" -->
<%
pageID = "home"
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Home Page</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->	
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
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
	
	<%
	on error resume next
	
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
		welcomeMsg = "Thanks for Registering!"
	else
		welcomeMsg = ""
	end if
	
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
		  .Parameters.Append .CreateParameter("@TestTakerID",3, 1,4, Request.Cookies("UserID"))
	End With
	oConn.Open strDBaseConnString
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
		.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		.Parameters.Append .CreateParameter("@PurchaserID", 3, 1, 4, Request.Cookies("UserID"))
		' getting tests that have been redeemed but not started
		.Parameters.Append .CreateParameter("@TestStatus", 3, 1, 4, 4)
	End With
	oConn2.Open strDBaseConnString
	oCmd2.ActiveConnection = oConn2
	oRs2.CursorLocation = 3
	oRs2.Open oCmd2, , 0, 1
	
	Dim PDFReportDir, PDIReportName, PDIReportPath, appReportName, appReportPath, PDIReportsAvail
	PDIReportsAvail = TRUE ' [SM] To determine if we should insert a placeholder if no records found.
'	PDFReportDir = "../trmain/PDFReports/"
'	PDFReportDir = "../trmain/PDFReports/"
	PDFReportDir = "/PDFReports/"
	
	If (oConn.Errors.Count < 1) AND (oConn2.Errors.Count < 1) then %>
		<h2>Welcome, <%=Request.Cookies("FirstName")%>! <%=welcomeMsg%></h2>
		<p>Please choose from the options below:</p>
		<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="100%">
			<tr>
				<td valign="top" style="padding-right:12px" width="50%">
					<p class="aligncenter"><img src="images/purchase_profile.gif" width="254" height="21" alt="" /></p>
					<p class="aligncenter">If you do not have a profile code,<br />you will need to purchase one to begin.</p>
					<p class="aligncenter"><a href="purchasetest.asp?res=<%=intResellerID%>">Purchase Profile</a></p>
					<p class="aligncenter">Have you already taken the DISC?</p>
					<p class="aligncenter"><a href="PDIProfile_DiamondLane.asp?res=<%=intResellerID%>">Click Here</a></p>
				</td>
				<td valign="top" width="50%">
					<p class="aligncenter"><img src="images/use_profile.gif" width="256" height="21" alt="" /></p>
					<p class="aligncenter">Have a profile code already and<br />need to access the profile?</p>
					<p class="aligncenter"><a href="entertestcode.asp?res=<%=intResellerID%>">Use Profile Code</a>
					</p>
				</td>		
			</tr>
		</table>
		<!--#INCLUDE FILE="include/divider.asp" -->
		<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
			<tr>
				<td valign="top" style="padding-right:12px" width="50%">
					<p class="aligncenter"><img src="images/previous_profile.gif" width="238" height="21" alt="" /></p>
					<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
					<%
					' [SM] Start listing PDI Reports
					If oRs.EOF = FALSE then
						oRs.MoveFirst
						do while oRs.EOF = FALSE
							PDIReportName = oRs("PDFFileName")
							PDIReportPath = PDFReportDir & PDIReportName
					%>
							<tr>
								<td valign="top">
									<!--#INCLUDE FILE="include/pdi.asp" --><br />
									<a href="<%=PDIReportPath%>">Complete Report (PDF)</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="PDIProfileResults.asp?PTSID=<%=oRs("pditestsummaryid")%>&P1=<%=oRs("ProfileID1")%>&P2=<%=oRs("ProfileID2")%>PTSID=<%=oRs("PDITestSummaryID")%>&TCID=<%=oRs("TestCodeID")%>&CP=<%=oRs("CustomProfile")%>&res=<%=intResellerID%>">Online Summary</a><br />
									<span class="bodytext_gray">Report created <%=oRs("FileCreationDate")%></span>
								</td>
							</tr>
					<%
							oRs.MoveNext
						Loop
					Else '[SM] There are no PDI reports, so update the flag
						PDIReportsAvail = FALSE
					End If %>
	
					<%
					' [SM] Start listing Application Reports
					If oRs2.EOF = FALSE then
						oRs2.MoveFirst
						do while oRs2.EOF = FALSE
							appReportName = oRs2("AppModFileName")
							appReportPath = PDFReportDir & appReportName
					%>
					
							<%
							If InStr(1, oRs2("AppModFileName"), "SELL", 0) > 0 Then %>
								<tr>
									<td valign="top">
										Selling with Style<sup>&reg;</sup><br />
										<a href="<%=appReportPath%>?res=<%=intResellerID%>">Complete Report (PDF)</a><br />
										<span class="bodytext_gray">Report created <%=oRs2("RedeemDate")%></span>
									</td>
								</tr>
							<%
							ElseIf InStr(1, oRs2("AppModFileName"), "COMM", 0) > 0 Then %>
				
								<tr>
									<td valign="top">		
										Communicating with Style<sup>&reg;</sup><br />
										<a href="<%=appReportPath%>?res=<%=intResellerID%>">Complete Report (PDF)</a><br />
										<span class="bodytext_gray">Report created <%=oRs2("RedeemDate")%></span>
									</td>
								</tr>
			
							<%
							ElseIf InStr(1, oRs2("AppModFileName"), "TEAM", 0) > 0 Then %>
				
								<tr>
									<td valign="top">
										Teamwork with Style<sup>&reg;</sup><br />
										<a href="<%=appReportPath%>?res=<%=intResellerID%>">Complete Report (PDF)</a><br />
										<span class="bodytext_gray">Report created <%=oRs2("RedeemDate")%></span>
									</td>
								</tr>
													
							<%
							ElseIf InStr(1, oRs2("AppModFileName"), "LEAD", 0) > 0 Then %>
				
								<tr>
									<td valign="top">
										Leading with Style<sup>&reg;</sup><br />
										<a href="<%=appReportPath%>?res=<%=intResellerID%>">Complete Report (PDF)</a><br />
										<span class="bodytext_gray">Report created <%=oRs2("RedeemDate")%></span>
									</td>
								</tr>
					
							<%
							ElseIf InStr(1, oRs2("AppModFileName"), "TIME", 0) > 0 Then %>
				
								<tr>
									<td valign="top">
										Time Management with Style<sup>&reg;</sup><br />
										<a href="<%=appReportPath%>?res=<%=intResellerID%>">Complete Report (PDF)</a><br />
										<span class="bodytext_gray">Report created <%=oRs2("RedeemDate")%></span>
									</td>
								</tr>
							<%
							ElseIf InStr(1, oRs2("AppModFileName"), "DRMA", 0) > 0 Then %>
				
								<tr>
									<td valign="top">
										The Dream Assessment<sup>&reg;</sup><br />
										<a href="<%=appReportPath%>?res=<%=intResellerID%>">Complete Report (PDF)</a><br />
										<span class="bodytext_gray">Report created <%=oRs2("RedeemDate")%></span>
									</td>
								</tr>
									
							<%
							End If
								oRs2.MoveNext
							Loop
					Else '[SM] There are no application records, so insert a placeholder if necessary
						If PDIReportsAvail = FALSE Then %>
							<tr>
								<td valign="top" align="center"><em>No reports available.</em>
								</td>
							</tr>
						<%
						End If
					End If %>				
					</table>
				</td>
				<td valign="top" width="50%">
					<p class="aligncenter"><img src="images/edit_user_info.gif" width="306" height="21" alt="" /></p>
					<p class="aligncenter">Update the personal information<br/>you provided at registration.</p>
					<p class="aligncenter"><a href="UserRegistrationInfo.asp?res=<%=intResellerID%>">Edit Information</a></p>
				</td>
			</tr>
		</table>
	
	<%
	Else
		Response.Write "<BR><BR>Transaction Failed<BR><BR>"
		Response.Write Err.description
		Err.Clear
	End If
	%>
	<!--#INCLUDE FILE="include/divider.asp" -->
	<H2>Learn More</H2>
		<ul>
			<li class="login_learnmore">The <a class="login_learnmore_link" href="DISCBackground.asp?res=<%=intResellerID%>" target="_top">History and Theory</a> of DISC</li>
			<li class="login_learnmore">The <a class="login_learnmore_link" href="OnlinePDIReport.asp?res=<%=intResellerID%>" target="_top">Online</a> <!--#INCLUDE FILE="include/pdi.asp" --></li>
	<% If IntResellerID = 2 Then %>
			<li class="login_learnmore">The <a class="login_learnmore_link" href="DGAssessment.asp?res=<%=intResellerID%>" target="_top"> DreamGiver Assessment</a></li>
			<li class="login_learnmore">The <a class="login_learnmore_link" href="disc_profile.asp?res=<%=intResellerID%>" target="_top"> DISC Profile</a> System<sup>®</sup></li>
	<% Else %>
			<li class="login_learnmore">Tailored <a class="login_learnmore_link" href="PDIAppReports.asp?res=<%=intResellerID%>" target="_top">Application Reports</a></li>
			<li class="login_learnmore"><a class="login_learnmore_link" href="VolumeDiscounts.asp?res=<%=intResellerID%>" target="_top">Multiple Copies</a> / Volume Discounts</li>
	<% End If %>
			<li class="login_learnmore"><a class="login_learnmore_link" href="PrivacyPolicy.asp?res=<%=intResellerID%>" target="_top">Privacy Policy</a></li>
		</ul>
		<br><br>
	<%'Response.Write "UserTypeID = " & Request.Cookies("UserTypeID") & "<br><br>"
	'=====================================================================================
	' If a non-admin user has special rights then show them the appropriate links
	'=====================================================================================
	If Request.Cookies("IsProfileMgr") = 1 Then
		Response.Write("<hr style=""color:#000000;height:1px;""><a href=""Admin/TrackingSummary.asp?res=" & intResellerID & """ class=""login_learnmore_link;"">Test Results Tracking</a><br><br>")
	End If

	If Request.Cookies("IsFinancialsViewer") = 1 Then
		Response.Write("<hr style=""color:#000000;height:1px;""><a href=""Admin/ReportingResellerDetailMonthlyByDay.asp?res=" & intResellerID & """ class=""login_learnmore_link;"">View Financials</a><br><br>")
	End If

	'=====================================================================================
	' only show this to internal admin users
	'=====================================================================================
	If Request.Cookies("UserTypeID") = 4 Then %>
		<h1>Internal Menu</h1>
		<a href="Admin/Default.asp?res=<%=intResellerID%>">Go to Admin Area</a>
		<br><br><hr>
		<font color="#FF0000">Items below this line have not been reworked to accomodate recent system changes and should not be used.</font><br><hr>
		<a href="Admin/sel_priceplan_all.asp?res=<%=intResellerID%>">Add/Edit Price Plans</a>
		<br><br>
		<a href="Admin/accountingMonthlyReportSite.asp?res=<%=intResellerID%>">Accounting Monthly Site Report</a>
		<br><br>
		<a href="Admin/ReportingResellerTotalsMonthly.asp?res=<%=intResellerID%>">Accounting Monthly Site Report</a>
		<br><br>
		<a href="Admin/ReportingResellerTotalsMonthly.asp?res=<%=intResellerID%>">Accounting Monthly Reseller Report</a>
		<br><br>
		<a href="Admin/accountingDailyReportSite.asp?res=<%=intResellerID%>">Accounting Daily Report</a>
		<br><br>
		<a href="Admin/accountingDailyReportCompanySite.asp?res=<%=intResellerID%>">Accounting Daily Report by Company</a>
		<br><br>
		<br><br>
		<a href="Admin/companysrch.asp?res=<%=intResellerID%>">Edit Company Information including Price Plan</a>
		<br><br>
		<a href="Admin/usersrch.asp?res=<%=intResellerID%>">Edit User Information including User Type (Regular, Admin, etc)</a>
		<br><br>
		<a href="Admin/viewtestcodeinfo.asp?res=<%=intResellerID%>">View Profile Code Information</a>
		<br><br>
		<a href="Admin/ins_companyalias.asp?res=<%=intResellerID%>">Add Alias Company</a>
		<br><br>
	<% End If %>
	
	<script>	
		function genappmod(TCID)
		{
			var x = confirm("Are you sure you want to redeem this application module profile code and generate the PDF report?")
			if(x) {
				window.location = "AppModuleCreatePDF.asp?res=<%=intResellerID%>&TCID=" + TCID;
			}
			return;
		}
	</script>	
</div>
</body>
</html>