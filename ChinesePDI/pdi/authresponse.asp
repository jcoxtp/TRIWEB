<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/checklogin.asp" -->
<!--#INCLUDE FILE="include/common.asp" -->
<% pageID = "authorizeResponse" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<title>DISC Profile System | Purchase Status</title>
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css">
	<!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
<div id="maincontent">
<%
Response.Buffer = True
Dim oConn			' Database connection string
Dim oCmd			' 
Dim x_Amount		' Total amount of purchase
Dim x_First_Name	' User's First name
Dim x_Last_Name		' User's Last name
Dim x_Cust_ID		' Contains the UserID
Dim x_Description	' A description containing code to identity the items purchased
Dim x_Invoice_Num	' Contains the PurchaseID
Dim x_freight		' Contains the Quantity
Dim x_Auth_Code		' 
Dim x_Response_Code	' Whether the transaction was approved or not (1=APPROVED,2=DECLINED,3=ERROR)
Dim x_po_num		' 
Dim oRs				' Recordset object holder
Dim intCount
Dim strEmailAddress

x_Amount = Request.Form("x_Amount")
x_First_Name = Request.Form("x_First_Name")
x_Last_Name = Request.Form("x_Last_Name")
x_Cust_ID = Request.Form("x_Cust_ID")
x_Description = Request.Form("x_Description")
x_Invoice_Num = Request.Form("x_Invoice_Num")
x_freight = Request.Form("x_freight")
x_Auth_Code = Request.Form("x_Auth_Code")
x_Response_Code = Request.Form("x_Response_Code")
x_po_num = Request.Form("x_po_num")

If x_Response_Code = 1 Then
	' Go ahead and handle all of the closure on this purchase transaction by calling this SP
	' This SP will automatically ensure that it doesn't run more than once
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	With oCmd
		.CommandText = "spPurchaseApproved"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		.Parameters.Append .CreateParameter("@intPurchaseID", 3, 1, 4, x_Invoice_Num)
		.Parameters.Append .CreateParameter("@intUserID", 3, 1, 4, x_Cust_ID)
	End With
	oConn.Open strDBaseConnString
	oCmd.ActiveConnection = oConn
	oCmd.Execute , , 128
	If oConn.Errors.Count >= 1 Then
		Response.Write "<span class='titletext'>Error Processing Purchase - Please contact a system administrator.</span>"
		Response.Write "<br>"
		Response.End
	End If
	Set oConn = Nothing
	Set oCmd = Nothing
	
	'Now, go and get all of the TestCodes just purchased
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	With oCmd
		.CommandText = "spPurchaseGetTestCodes"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		.Parameters.Append .CreateParameter("@intPurchaseID",3, 1,4, x_Invoice_Num)
	End With
	oConn.Open strDBaseConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	
	intCount = 1
	If oConn.Errors.Count < 1 Then
		If oRs.EOF = FALSE Then %>
				<img src="images/your_purchase.gif">
				<p style="margin-bottom:0px">
				<table border="0" cellspacing="0" cellpadding="6" width="100%">
					<tr>
						<td valign="top" align="center" width="32"><img src="images/reports.gif" alt="" width="32" height="32" /></td>
						<td valign="top">
							<h2>Take Profile or Create an Application Report</h2>
							<p>To take the profile or create an application report, click on the code you would like to use.</p>
							<div align="center">
							<p style="margin-bottom:0px">
							<table border="0" cellspacing="0" cellpadding="6" width="90%">
								<tr>
									<td valign="top" align="center" width="5%"><strong>Number</strong></td>
									<td valign="top" width="60%"><strong>Title</strong></td>
									<td valign="top" width="35%"><strong>Profile Code(s) Purchased</strong></td>
								</tr>
							<%
							'Flag used to determine the type of link needed to open next page
							'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
							Dim Flag
							while oRs.EOF = FALSE %>
								<tr>
									<td valign="top" align="center"><%=intCount%>
									</td>
									<td valign="top">
									<% '[SM] A hack to get the titles and descriptions
										If Left(oRs("TestCode"),4) = "PDIP" Then
											Flag=1
											If intResellerID = 2 Then %>
												<a href="OnlinePDIReport.asp?res=<%=intResellerID%>">Personal DISCernment Inventory<sup>&reg;</sup></a><br />
												<span class="bodytext_gray">The Core of the DISC Profile System<sup>&reg;</sup></span>
											<% Else %>
												<a href="OnlinePDIReport.asp?res=<%=intResellerID%>">Personal DISCernment Inventory<sup>&reg;</sup></a><br />
												<span class="bodytext_gray">The Core of the DISC Profile System<sup>&reg;</sup></span>
											<% End If %>
										<% ElseIf Left(oRs("TestCode"),4) = "SELL" Then %>
											<a href="PDIAppReports_selling.asp?res=<%=intResellerID%>">Selling with Style<sup>&reg;</sup></a><br />
											<span class="bodytext_gray">A DISC Profile System<sup>&reg;</sup> Tailored Application Report</span>
										<% ElseIf Left(oRs("TestCode"),4) = "COMM" Then %>
											<a href="PDIAppReports_communicating.asp?res=<%=intResellerID%>">Communicating with Style<sup>&reg;</sup></a><br />
											<span class="bodytext_gray">A DISC Profile System<sup>&reg;</sup> Tailored Application Report</span>
										<% ElseIf Left(oRs("TestCode"),4) = "TEAM" Then %>
											<a href="PDIAppReports_teamwork.asp?res=<%=intResellerID%>">Teamwork with Style<sup>&reg;</sup></a><br />
											<span class="bodytext_gray">A DISC Profile System<sup>&reg;</sup> Tailored Application Report</span>
										<% ElseIf Left(oRs("TestCode"),4) = "LEAD" Then %>
											<a href="PDIAppReports_leading.asp?res=<%=intResellerID%>">Leading with Style<sup>&reg;</sup></a><br />
											<span class="bodytext_gray">A DISC Profile System<sup>&reg;</sup> Tailored Application Report</span>
										<% ElseIf Left(oRs("TestCode"),4) = "TIME" Then %>
											<a href="PDIAppReports_time.asp?res=<%=intResellerID%>">Time Management with Style<sup>&reg;</sup></a><br />
											<span class="bodytext_gray">A DISC Profile System<sup>&reg;</sup> Tailored Application Report</span>
										<% ElseIf Left(oRs("TestCode"),4) = "DRMA" Then %>
											<a href="DGAssessment.asp?res=<%=intResellerID%>">The Dream Assessment<sup>&reg;</sup></a><br />
											<span class="bodytext_gray">A DISC Profile System<sup>&reg;</sup> Tailored Application Report</span>
										<% End If %>
									</td>
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
				<!--#INCLUDE FILE="include/divider.asp" -->
			<%
			End If
		End If %>
		<p style="margin-bottom:0px">
		<table border="0" cellspacing="0" cellpadding="6" width="100%">
			<tr>
				<td valign="top" align="center" width="32"><img src="images/printer.gif" alt="" width="32" height="32" /></td>
				<td valign="top">
					<h2><a href="logout.asp?res=<%=intResellerID%>">Logout</a> and Use Codes Later</h2>
					<p>Available codes will be stored for future access, but it is recommended that you print this page for your records.</p>
				</td>
			</tr>
		</table>
		</p>
		<p class="addtable">
		<table border="0" cellspacing="0" cellpadding="3" width="100%">
			<tr>
				<td valign="top" align="right"><a href="main.asp?res=<%=intResellerID%>"><img src="images/return_home.gif" alt="" width="93" height="16" /></a></td>
			</tr>
		</table>
		</p>
		<%
		' Send an e-mail acknowledging the purchase
		Set oConn = Nothing
		Set oCmd = Nothing
		Set oRs = Nothing
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
		With oCmd
			  .CommandText = "spUserInfoGetInfo"
			  .CommandType = 4
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			  .Parameters.Append .CreateParameter("@intUserID",3, 1,4, x_Cust_ID)
		End With
		oConn.Open strDBaseConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
		
		strEmailAddress = oRs("EmailAddress")
		If oConn.Errors.Count < 1 then
			If oRs.EOF = FALSE Then
				Dim JMail
				Set JMail = Server.CreateObject("JMail.SMTPMail")
				JMail.ServerAddress = "65.205.160.186:25"
				'JMail.ServerAddress = "www.pdiprofile.com:25"
				JMail.Sender = "support@pdiprofile.com"
				JMail.SenderName = "Team Resources, Inc."
				JMail.Subject = "Thank You for Your Purchase"
				JMail.AddRecipient(strEmailAddress)
				JMail.Body = "Thank you for your recent purchase at the Personal DISCernment Inventory website!" & VBcrLf & VBCrLf & "Here is your login information:" & VBCrLf & VBCrLf & "Username: " & oRs("UserName") & VBCrLf & "Password: " & oRs("Password") & VBCrLf & VBCrLf & VBCrLf & "Regards," & VBCrLf & VBCrLf & VBCrLf & "Team Resources, Inc."
				JMail.Priority = 3
				JMail.Execute
				Set oConn = Nothing
				Set oCmd = Nothing
				Set oRs = Nothing
				Response.End
			Else
			End If
		Else
			  strErrMsg = Err.description
			  Err.Clear
		End If
		Response.End
		
		' If the trnasaction was not successful or encountere an error,
		' delete the purchase records in the appropriate tables
	ElseIf X_RESPONSE_CODE = 2 Then
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		With oCmd
			  .CommandText = "spPurchaseDelete"
			  .CommandType = 4
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				.Parameters.Append .CreateParameter("@intPurchaseID",3, 1,4, x_Invoice_Num)
		End With
		oConn.Open strDBaseConnString		  ' REPLACES > oConn.Open "DSN=TResources;UID=sa"
		oCmd.ActiveConnection = oConn
		oCmd.Execute , , 128
		If oConn.Errors.Count < 1 then
			Response.Write "Purchase declined - Please try again."
			Response.Write "<br>"
			Response.End
		End If
		Set oConn = Nothing
		Set oCmd = Nothing
	Else
		' Else, assume that there wasn an error
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		With oCmd
			  .CommandText = "spPurchaseDelete"
			  .CommandType = 4
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				.Parameters.Append .CreateParameter("@intPurchaseID",3, 1,4, x_Invoice_Num)
		End With
		oConn.Open strDBaseConnString		  ' REPLACES > oConn.Open "DSN=TResources;UID=sa"
		oCmd.ActiveConnection = oConn
		oCmd.Execute , , 128
		If oConn.Errors.Count < 1 then
			Response.Write "Merchant Processing Error - Please try again."
			Response.Write "<br>"
			Response.End
		End If
		Set oConn = Nothing
		Set oCmd = Nothing
	End If %>
</div>
</body>
</html>
