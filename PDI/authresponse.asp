<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = true
	On Error Resume Next
	intPageID = 30	' Credit Card Authorization Response Page
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
Response.Buffer = true
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
Dim x_test_request

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
x_test_request = Request.Form("x_test_request")





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
		.Parameters.Append .CreateParameter("@intTestCodeLanguage", 3, 1, 4, 1)
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oCmd.Execute , , 128
	If oConn.Errors.Count >= 1 Then
        Response.Write(oConn.Errors.Count)
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
        .Parameters.Append .CreateParameter("@intLanguageID",3, 1,4, 1) 'read in english by default
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	
	intCount = 1
	If oConn.Errors.Count < 1 Then
		If oRs.EOF = FALSE Then %>
				<img src="images/your_purchase.gif">
				<div style="margin-bottom:0px">
				<table border="0" cellspacing="0" cellpadding="6" width="100%">
					<tr>
						<td valign="top" align="center" width="32"><img src="images/reports.gif" alt="" width="32" height="32" /></td>
						<td valign="top">
							<h2><%=strTextTakeProfileOrCreateAnApplicationReport%></h2>
							<p><%=strTextToTakeTheProfileOrCreate%></p>
							<div align="center">
							<div style="margin-bottom:0px">
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
                                    <!--Item Count Column-->
                                    <td valign="top" align="center"><%=intCount %>
									</td>
                                    <!--Product Title & Description Column-->
                                    <td>
                                        <% 
                                            Response.Write "		<a href=""" & oRs("DescLink") & "?res=" & intResellerID & """>" & oRs("TestName") & "</a><br />" & VbCrLf
                                            If (Left(oRs("TestCode"),4) <> "PDIP" OR Left(oRs("TestCode"),4) <> "PDDG") Then
                                                Response.Write "<span class=""bodytext_gray"">" & strTextADISCProfileSystemTailoredApplicationReport & "</span>"
                                            ELSE
                                                Response.Write "<span class=""bodytext_gray"">" & strTextTheCoreOfTheDISCProfileSystem & "</span>"
                                            END IF
                                         %>
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
							</div>
							</div>
						</td>
					</tr>
				</table>
				</div>
				<!--#Include FILE="Include/divider.asp" -->
			<%
			End If
		End If %>
		<div style="margin-bottom:0px">
		<table border="0" cellspacing="0" cellpadding="6" width="100%">
			<tr>
				<td valign="top" align="center" width="32"><img src="images/Print<%=strLanguageCode%>.gif" alt="" width="40" height="36" /></td>
				<td valign="top">
					<h2><a href="logout.asp?res=<%=intResellerID%>"><%=strTextLogout%></a> <%=strTextAndUseCodesLater%></h2>
					<p><%=strTextAvailableCodesWillBestoredForFutureAccess%></p>
				</td>
			</tr>
		</table>
		</div>
		<div class="addtable">
		<table border="0" cellspacing="0" cellpadding="3" width="100%">
			<tr>
				<td valign="top" align="right"><a href="main.asp?res=<%=intResellerID%>"><img src="images/return_home.gif" alt="" width="93" height="16" /></a></td>
			</tr>
		</table>
		</div>

    				<!--#Include FILE="Include/AuthResponseResultHandler.asp" -->

</div>
</body>
</html>
