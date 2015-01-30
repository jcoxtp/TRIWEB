<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/checklogin.asp" -->
<!--#INCLUDE FILE="include/common.asp" -->
<%
pageID = "quit"
Dim TestCodeID
TestCodeID = Request.QueryString("TCID")
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Print Your PDI Profile</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
<div id="tabgraphic">
	<img src="images/s6p1.gif" width="692" height="82" alt="" usemap="#tab" />
	<map name="tab">
		<area shape="poly" alt="" coords="633,53,672,53,680,59,673,65,632,66,617,59,634,53,637,53" HREF="PDIProfileSANDW2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>">
	</map>
</div>
<div id="maincontent_tab">
	<%
	Dim nP, nE
	nP = Request.QueryString("PRNT")
	nE = Request.QueryString("EXIT")
	Dim bChoseRepProfile, bQuestionsCompleted
	Dim oConn
	Dim oCmd
	Dim oRs
	
	bChoseRepProfile = FALSE
	bQuestionsCompleted = FALSE
	
	' first see if the user has completed the questions and has chosen at least 
	' 1 profile - if they have not then warn the user the PDI cannot be produced 
	' and allow them to quit anyway - but don't produce the PDF report for them
	
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	
	With oCmd
		  .CommandText = "sel_PDITestSummary_TCID"
		  .CommandType = 4
		  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		  .Parameters.Append .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)
	End With
	oConn.Open strDBaseConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	
	If oConn.Errors.Count > 0 then
		Response.Write "Unable to update database. Please try again."
		Response.End
	end if
	
	if oRs.EOF = FALSE then
		oRs.MoveFirst
		if CInt(oRs("QuestionsCompleted")) = 1 then
			bQuestionsCompleted = TRUE
		end if
		if oRs("ProfileName1") <> "" then ' [SM] Deleted reference to Profile 2
			bChoseRepProfile = TRUE
		end if
	else
		Response.Write "<font size=2>Cannot find test information in database. Please try again.</font>"
		Response.End
	end if
	
	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRs = Nothing
	
	if bQuestionsCompleted = FALSE then
		if nP = "1" then
			Response.Write "<p>You have not completed the questions portion of the PDI Profile. You must complete the questions to print the PDI PDF report.</p>"
			Response.End
		else
			Response.Write "<p>You have not completed the questions portion of the PDI Profile. If you quit now you will be able to return and complete the questions.</p>"
			Response.Write "<p><a href='main.asp?st=" & Site & "'>Click here to exit the PDI Profile</a>.</p>"
		end if
	else
		if bChoseRepProfile = FALSE then
			Response.Write "<p>You have not chosen a representative profile. As a result your PDI PDF Profile will not be created.</p>"
			Response.Write "<p>Are you sure you want to exit now? If yes, then you can return to choose a representative profile later.</p>"
			Response.Write "<p><a href='main.asp?st=" & Site & "'>Click here to exit now</a>.</p>"
		else %>
			<h2>Congratulations! You have completed the  <!--#INCLUDE FILE="include/pdi.asp" -->.</h2>
			
			<p style="margin-bottom:0px">
			<table border="0" cellspacing="0" cellpadding="6" width="100%">
				<tr>
					<td valign="top" align="center" width="32"><a href="javascript:confirmPDIPDFCreation()"><img src="images/printer.gif" alt="" width="32" height="32" /></a></td>
					<td valign="top">
						<h2>View and Print Your Complete Report (PDF Format)</h2>
	<p>Click on the 'Print' Icon to the left to create your customized DISC report in Adobe's PDF format. Viewing the report will allow you to save and print it. Close the window of the PDF report to return to this screen. You are finished with the <!--#INCLUDE FILE="include/pdi.asp" -->. You are now ready to either quit or generate a customized <% If intResellerID = 2 then %>Dream Assessment report<% Else %>Application Report<% End If %> below.</p>
						
						<div align="right">
						<p style="margin-bottom:0px">
						<table border="0" cellspacing="0" cellpadding="2" width="100%">
							<tr>
								<td valign="top" align="right" width="25%"><a href="http://www.adobe.com/products/acrobat/readstep2.html" target="_blank"><img src="images/get_acrobat_reader.gif" alt="" width="88" height="31" /></a></td>
								<td valign="top" align="left" width="75%">
									<strong>NOTE:</strong> You must have Adobe<sup>&reg;</sup> Acrobat<sup>&reg;</sup> Reader<sup>&reg;</sup> installed to view your reports. Please <a href="http://www.adobe.com/products/acrobat/readstep2.html" target="_blank">download</a> this free program from the Adobe website.
								</td>
							</tr>
						</table>
						</p>
						</div>
					</td>
				</tr>
			</table>
			</p>
			<!--#INCLUDE FILE="include/divider.asp" -->
			<p style="margin-bottom:0px">
			<table border="0" cellspacing="0" cellpadding="6" width="100%">
				<tr>
					<td valign="top" align="center" width="32"><a href="purchasetest.asp?res=<%=intResellerID%>"><img src="images/reports.gif" alt="" width="32" height="32" /></a></td>
					<td valign="top">
						<h2>Purchase a Customized <% If intResellerID = 2 then %>Dream Assessment Report - $15<% Else %>Application Report - <!--#INCLUDE FILE="include/app_price.asp" --><% End If %> each</h2>
						<p>
						<% If intResellerID = 2 then %>
							After taking the DISC Profile System®, you may purchase a customized DreamGiver Assessment that allows you to specifically apply these insights to your Dream Journey. This report explores the seven stages of the Journey and defines the issues and challenges unique to your style. You will receive a detailed analysis of the strengths, weaknesses, fears and motivators you will encounter in each stage, as well as a tailored strategy for navigating each challenge.
						<ul>
							<li><a href="DGAssessment.asp?res=<%=intResellerID%>">Dream Assessment Report<sup>&reg;</sup></a></li>
						</ul>
						<% Else %>
							Application reports are	customized based on the results of your <!--#INCLUDE FILE="include/pdi.asp" -->. These reports provide additional information about each behavioral style as it relates to a specific area and suggest how you can immediately apply this information to yourself and others. Click on a title below to read more about each report. To make a purchase, click on the paper graphic to the left to go to the purchase page. If you have already purchased an application report, look below for the profile code to use.
						<ul>
							<li><a href="PDIAppReports_teamwork.asp?res=<%=intResellerID%>">Teamwork with Style<sup>&reg;</sup></a></li>
							<li><a href="PDIAppReports_leading.asp?res=<%=intResellerID%>">Leading with Style<sup>&reg;</sup></a></li>
							<li><a href="PDIAppReports_communicating.asp?res=<%=intResellerID%>">Communicating with Style<sup>&reg;</sup></a></li>
							<li><a href="PDIAppReports_selling.asp?res=<%=intResellerID%>">Selling with Style<sup>&reg;</sup></a></li>
							<li><a href="PDIAppReports_time.asp?res=<%=intResellerID%>">Time Management with Style<sup>&reg;</sup></a></li>
						</ul>
						<% End If %>
						</p>
					</td>
				</tr>
			</table>
			</p>
			<!--#INCLUDE FILE="include/divider.asp" -->
			<p style="margin-bottom:0px">
			<table border="0" cellspacing="0" cellpadding="6" width="100%">
				<tr>
					<td valign="top" align="center" width="32"><img src="images/printer.gif" alt="" width="32" height="32" /></td>
					<td valign="top">
						<h2>View and Print a Previously Purchased <% If intResellerID = 2 then %>Dream Assessment Report<% Else %> Application Report<% End If %></h2>
						<p>To create <% If intResellerID = 2 then %>a Dream Assessment report<% Else %>an application report<% End If %>, click on the code you would like to use.</p>
						<div align="center">
						<p class="addtable">
						<table border="0" cellspacing="0" cellpadding="6" width="85%">
						<tr>
							<td valign="middle" align="left"><span class="headertext2">Title</span></td>
							<td valign="middle" align="left"><span class="headertext2">Profile Code</span>
							</td>
						</tr>
					<%
						Set oConn = CreateObject("ADODB.Connection")
						Set oCmd = CreateObject("ADODB.Command")
						Set oRs = CreateObject("ADODB.Recordset")
						With oCmd
							.CommandText = "sel_Tests_First"
							.CommandType = 4
							.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
							.Parameters.Append .CreateParameter("@UserID",3, 1,4, Request.Cookies("UserID"))
						End With
						oConn.Open strDBaseConnString
						oCmd.ActiveConnection = oConn
						oRs.CursorLocation = 3
						oRs.Open oCmd, , 0, 1
						If oConn.Errors.Count < 1 then
							if oRs.RecordCount = 0 then %>
								<tr>
									<td valign="middle" align="center" colspan="2">You have not purchased or redeemed any application reports.
									</td>
								</tr>
							<%
							Else
								oRs.MoveFirst
								do while oRs.EOF = FALSE
									if Left(oRs("TestCode"),4) = "PDIP" then
									else %>
										<tr>
											<td valign="top" align="left">
												<a href="<%=oRs("DescLink")%>?res=<%=intResellerID%>"><%=oRs("TestName")%></a><br />
												<span class="bodytext_gray">Purchased <%=oRs("DatePurchased")%></span>
											</td>
											<td valign="top" align="left"><a href="javascript:confirmAppPDFCreation(<%=oRs("TestCodeID")%>)"><%=oRs("TestCode")%></a></td>
										</tr>
									<% 
									end if
								oRs.MoveNext
								Loop
								Set oConn = Nothing
								Set oCmd = Nothing
								Set oRs = Nothing
							End If
						else
							Response.Write "<BR><BR>Transaction Failed<BR><BR>"
							Response.Write Err.description
							Err.Clear
						End If
						%>
						</table>
						</p>
						</div>					
					</td>
				</tr>
			</table>
			</p>
			
		<%
		end if
	end if
	%>
	<script type="text/javascript">
	// alerts user to delay while generating the PDF and application reports
	function confirmAppPDFCreation(TCID)
	{
		if (window.confirm("It will take about a minute to generate your application report."))
		{
			var goToNextURL;
		
			goToNextURL = "AppModuleCreatePDF.asp?TCID=" + TCID + "&res=<%=intResellerID%>";
		
			document.location = goToNextURL;
		}
	}
	
	function confirmPDIPDFCreation()
	{
		if (window.confirm("It will take about a minute to generate your PDI report."))
		{	
			var goToNextURL;
			
			goToNextURL = "activePDF.asp?TCID=" + <%=TestCodeID%> + "&res=<%=intResellerID%>";
			
			openAnyWindow(goToNextURL,'Download',"height=240,width=450,menubar=1,resizable=1,scrollbars=1,status=1,titlebar=1,toolbar=1,z-lock=0");
		}
	}
	</script>
</div>
</body>
</html>
