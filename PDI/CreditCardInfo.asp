﻿<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
'	On Error Resume Next
	intPageID = 28	' Credit Card Information Collection Page
%>
<!--#Include file="Include/CheckLogin.asp" -->
<!--#Include file="Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<title>Secured Online DISC Purchase</title>	

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
<!--	<script language="javascript" type="text/javascript">
		//<![CDATA[
		var tl_loc0=(window.location.protocol == "https:")? "https://secure.comodo.net/trustlogo/javascript/trustlogo.js" :
		"http://www.trustlogo.com/trustlogo/javascript/trustlogo.js";
		document.writeln('<scr' + 'ipt language="JavaScript" src="'+tl_loc0+'" type="text\/javascript">' + '<\/scr' + 'ipt>');
		//]]>
	</script>-->

	<!--#Include file="Include/HeadStuff.asp" -->
</head>

<body>
<!--#Include file="Include/TopBanner.asp" -->
    <div id="main">

<div id="maincontent">
<%
' First, set up the variables that are passed in from the previous page
	Dim intUserID
	Dim intPurchaseID
	Dim txtProductsDescription
	Dim intNumberOfProducts
	Dim mnyTotalDiscounted
	Dim mnyTotalGrand
	Dim strProducts
	Dim arrProductID()
	Dim arrProductAmount()
	Dim arrProductQuantity()
	Dim intIsATest
    Dim testPayment

' Now, get the values form the previous form
	intUserID = Request.Cookies("UserID")
	If intUserID = "" Then
		intUserID = Request.Form("intUserID")
	End If
	intPurchaseID = Request.Form("intPurchaseID")
	txtProductsDescription = Request.Form("txtProductsDescription")
	intNumberOfProducts = Request.Form("intNumberOfProducts")
	mnyTotalDiscounted = Request.Form("mnyTotalDiscounted")
	mnyTotalGrand = Request.Form("mnyTotalGrand")
	intIsATest = 0

' Set up dimensions for the Product arrays
	ReDim arrProductID(intNumberOfProducts + 1)
	ReDim arrProductAmount(intNumberOfProducts + 1)
	ReDim arrProductQuantity(intNumberOfProducts + 1)

' Populate the Product arrays
	Dim intCount
	intCount = 1
	' Loop through all of the products displayed on the previous page and collect quantities
	While CInt(intCount) <= CInt(intNumberOfProducts)
		arrProductID(intCount) = Request.Form("intTestID" & intCount)
		arrProductAmount(intCount) = Request.Form("mnyProductAmount" & intCount)
		arrProductQuantity(intCount) = Request.Form("intProductQuantity" & intCount)
		intCount = intCount + 1
	Wend

' Next, let's make sure that the form that submitted to this one came from our server and not a hack
	If CStr(Request.ServerVariables("HTTP_HOST")) <> CStr(Application("SiteDomain")) AND Request.ServerVariables("HTTP_HOST") <> "pdiprofile.com" Then
		' This page call came from a form that didn't originate on our server, send them back to the last page with data
		Response.Write "<HTML><BODY>" & VbCrLf
		Response.Write "<FORM name=""thisForm"" action=""PurchaseTest.asp?res=" & intResellerID & " method=""post"">" & VbCrLf
        Response.Write "<input type=""hidden"" name=""ResellerID"" id=""ResellerID"" Value=""" & intResellerID & """>" & VbCrLf
		Response.Write "<input type=""hidden"" name=""intUserID"" id=""intUserID"" Value=""" & intUserID & """>" & VbCrLf
		Response.Write "<input type=""hidden"" name=""intResellerID"" id=""intResellerID"" value=""" & intResellerID & """>" & VbCrLf
		Response.Write "<input type=""hidden"" name=""intPurchaseID"" id=""intPurchaseID"" Value=""" & intPurchaseID & """>" & VbCrLf
		Response.Write "<input type=""hidden"" name=""intNumberOfProducts"" id=""intNumberOfProducts"" value=""" & intNumberOfProducts & """>" & VbCrLf
		Response.Write "<input type=""hidden"" name=""mnyTotalDiscounted"" id=""mnyTotalDiscounted"" Value=""" & mnyTotalDiscounted & """>" & VbCrLf
		intCount = 1
		' Loop through all of the products displayed on the previous page and collect quantities
		While CInt(intCount) <= CInt(intNumberOfProducts)
			Response.Write "<input type=""hidden"" name=""intTestID" & intCount & """ id=""intTestID" & intCount & """ value=""" & arrProductID(intCount) & """>" & VbCrLf
			Response.Write "<input type=""hidden"" name=""mnyProductAmount" & intCount & """ id=""mnyProductAmount" & intCount & """ value=""" & arrProductAmount(intCount) & """>" & VbCrLf
		''	Response.Write "<input type=""hidden"" name=""intProductQuantity" & intCount & """ id=""intProductQuantity" & intCount & """ value=""" & arrProductQuantity(intCount) & """>" & VbCrLf
			intCount = intCount + 1
		Wend
		Response.Write "</FORM>" & VbCrLf
		Response.Write "<script language=""JavaScript"">" & VbCrLf
		Response.Write "document.thisForm.submit();" & VbCrLf
		Response.Write "</script>" & VbCrLf
		Response.Write "</BODY></HTML>" & VbCrLf
	End If

' Loop through the Products and put the IDs and quantities into a concatenated string
	intCount = 1
	While CInt(intCount) <= Cint(intNumberOfProducts)
		If intCount > 1 Then
			strProducts = strProducts & "," & arrProductID(intCount) & "|" & arrProductQuantity(intCount)
		Else
			strProducts = arrProductID(intCount) & "|" & arrProductQuantity(intCount)
		End If
		intCount = intCount + 1
	Wend
	strProducts = strProducts & ","

' Get a listing of all Product volume discounts
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRsDiscounts = CreateObject("ADODB.Recordset")
	With oCmd
	    .CommandText = "spDiscountsGet"
	    .CommandType = 4
	    .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	    .Parameters.Append .CreateParameter("@intUserID", 3, 1, 4, intUserID)
	    .Parameters.Append .CreateParameter("@intResellerID", 3, 1, 4, intResellerID)
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRsDiscounts.CursorLocation = 3
	oRsDiscounts.Open oCmd, , 0, 1
	If oConn.Errors.Count > 0 OR oRsDiscounts.EOF = TRUE Then
		Response.Write "Unable to retrieve product information from database. Please try again."
		Response.End
	End If
	oRsDiscounts.MoveFirst

' Calculate the amount (this needs to be done in case the user didn't click the Calculate button) and for security purposes
	intCount = 1
	mnyTotalGrand = 0
	While CInt(intCount) <= CInt(intNumberOfProducts)
		' Calculate the price of this product based on volume discount
		mnyProductAmount = arrProductAmount(intCount)
		intProductQuantity = arrProductQuantity(intCount)
		If intProductQuantity = "" Then
			intProductQuantity = 0
		End If
		mnyProductTotal = (intProductQuantity * mnyProductAmount)
		If intProductQuantity <> 0 Then
			oRsDiscounts.MoveFirst
			' Go through the volume discounts until we find the right quantity
			Do While oRsDiscounts.EOF = False
				If CLng(intProductQuantity) >= CLng(oRsDiscounts("MinVolumeAmt")) AND CLng(intProductQuantity) <= CLng(oRsDiscounts("MaxVolumeAmt")) Then
					mnyProductDiscounted = (mnyProductAmount - (mnyProductAmount * oRsDiscounts("DiscountPercent")))
					mnyProductTotal = (intProductQuantity * mnyProductDiscounted)
					oRsDiscounts.MoveLast
				Else
					mnyProductDiscounted = mnyProductAmount
				End If
				oRsDiscounts.MoveNext
			Loop
		Else
			mnyProductDiscounted = mnyProductAmount
		End If
		mnyTotalGrand = mnyTotalGrand + mnyProductTotal
		intCount = intCount + 1
	Wend

' Execute Stored Procedure to insert Purchase and PurchaseDetails
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	With oCmd
		.CommandText = "spPurchaseInsert"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		.Parameters.Append .CreateParameter("@intUserID", 3, 1, 4, intUserID)
		.Parameters.Append .CreateParameter("@intExistingPurchaseID", 3, 1, 4, intPurchaseID)
		.Parameters.Append .CreateParameter("@strProducts", 200, 1, 200, strProducts)
		.Parameters.Append .CreateParameter("@intPurchaseID", 3, 3, 4, intPurchaseID)
		.Parameters.Append .CreateParameter("@intIsATest", 3, 3, 4, intIsATest)
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oCmd.Execute , , 128
	If oConn.Errors.Count < 1 Then
		intPurchaseID = oCmd.Parameters("@intPurchaseID").value
		intIsATest = oCmd.Parameters("@intIsATest").value
	Else
		intPurchaseID = 0
		intIsATest = 0
	End If

' Now, create new variables we will need on this page
	Dim strFirstName
	Dim strLastName
	Dim strEmail
	Dim strAddress
	Dim strCity
	Dim strState
	Dim strPostalCode
	Dim intSequence
	Dim ret

' Set initial values
	strFirstName = Null
	strLastName = Null
	strEmail = Null
	strAddress = Null
	strCity = Null
	strState = Null
	strPostalCode = Null

' Let's test to see whether the User's info has been sent to this form or not
	strFirstName = Cstr(Request("FName"))
	strLastName = CStr(Request("LName"))
	strEmail = CStr(Request("Email"))

	If strFirstName <> "" AND strLastName <> "" AND strEmail <> "" Then
		' Collection all information from form fields
		strFirstName = Request("FName")
		strLastName = Request("LName")
		strEmail = Request("Email")
		strAddress = Request("Address1")
		strCity = Request("City")
		strState = Request("State")
		strPostalCode = Request("PostalCode")
	Else
		' The User's info hasn't been sent to this form so gather it from the database
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		With oCmd
			.CommandText = "spUserGetInfo"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			.Parameters.Append .CreateParameter("@intUserID", 3, 1, 4, intUserID)
			.Parameters.Append .CreateParameter("@strFirstName", 200, 3, 30, Null)
			.Parameters.Append .CreateParameter("@strLastName", 200, 3, 30, Null)
			.Parameters.Append .CreateParameter("@strEmail", 200, 3, 50, Null)
			.Parameters.Append .CreateParameter("@strAddress", 200, 3, 80, Null)
			.Parameters.Append .CreateParameter("@strCity", 200, 3, 40, Null)
			.Parameters.Append .CreateParameter("@strState", 200, 3, 30, Null)
			.Parameters.Append .CreateParameter("@strPostalCode", 200, 3, 30, Null)
		End With
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oCmd.Execute , , 128
		strFirstName = oCmd.Parameters("@strFirstName").value
		strLastName = oCmd.Parameters("@strLastName").value
		strEmail = oCmd.Parameters("@strEmail").value
		strAddress = oCmd.Parameters("@strAddress").value
		strCity = oCmd.Parameters("@strCity").value
		strState = oCmd.Parameters("@strState").value
		strPostalCode = oCmd.Parameters("@strPostalCode").value
	End If

' Seed random number for more security and more randomness
	Randomize
	intSequence = Int(1000 * Rnd)
%>
<script type="text/javascript" language="JavaScript">

function goBack() {
	document.thisForm.action = "PurchaseTest.asp";
	document.thisForm.submit();
}

function makeBillable() {
	document.Billable.action = "./Admin/BillablePurchase.asp?res=<%=intResellerID%>&pid=<%=intPurchaseID%>";
	document.Billable.submit();	
}

</script>

<!--#Include FILE="simlib.asp"-->

<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td valign="top"><h1><%=strTextPaymentInformation%></h1></td>
		<td valign="top" align="right"><!--#Include file="Include/BackLink.asp" --></td>
	</tr>
</table>

<% testPayment = true %>
<% if testPayment = true then %>
    <FORM NAME="thisForm" METHOD=POST ACTION="https://test.authorize.net/gateway/transact.dll">
    <h2 style="color:red;">You are in payment test mode. Transactions will not be processed.</h2>

<% Else %>
    <FORM NAME="thisForm" METHOD=POST ACTION="https://secure.authorize.net/gateway/transact.dll">
<% end if %>

	<input type="hidden" name="intUserID" id="intUserID" Value="<%=intUserID%>">
	<input type="hidden" name="ResellerID" id="ResellerID" value="<%=intResellerID%>">
	<input type="hidden" name="intResellerID" id="intResellerID" value="<%=intResellerID%>">
	<input type="hidden" name="intPurchaseID" id="intPurchaseID" Value="<%=intPurchaseID%>">
	<input type="hidden" name="txtProductsDescription" id="txtProductsDescription">
	<input type="hidden" name="intNumberOfProducts" id="intNumberOfProducts" value="<%=intNumberOfProducts%>">
	<input type="hidden" name="mnyTotalDiscounted" id="mnyTotalDiscounted" Value="<%=FormatCurrency(mnyTotalGrand, 2)%>">
<%
	' Put array of ProductIDs, Amounts and Quantities into hidden fields to enable return to previous page
	intCount = 1
	While CInt(intCount) <= CInt(intNumberOfProducts)
		Response.Write "	<input type=""hidden"" name=""intTestID" & intCount & """ Value=""" & arrProductID(intCount) & """>" & VbCrLf
		Response.Write "	<input type=""hidden"" name=""mnyProductAmount" & intCount & """ Value=""" & arrProductAmount(intCount) & """>" & VbCrLf
		Response.Write "	<input type=""hidden"" name=""intProductQuantity" & intCount & """ Value=""" & arrProductQuantity(intCount) & """>" & VbCrLf
		intCount = intCount + 1
	Wend
%>

    <% if testPayment = true then %>
    	<%ret = InsertFP ("6e9J4LsZ", "6ge96TapP69c3NZT", FormatCurrency(mnyTotalGrand,2), intSequence)%>
        <INPUT TYPE=HIDDEN NAME="x_Version" VALUE="3.1"><INPUT TYPE=HIDDEN NAME="x_Login" VALUE="6e9J4LsZ">
    <% else %>
        <%ret = InsertFP ("bfa66d4c6", "LhuReUtn8roZkbGY", FormatCurrency(mnyTotalGrand,2), intSequence)%>
        <INPUT TYPE=HIDDEN NAME="x_Version" VALUE="3.1"><INPUT TYPE=HIDDEN NAME="x_Login" VALUE="bfa66d4c6">

    <% end if %>
    <!--Testing purposes-->


	<input type="hidden" name="x_Cust_ID" id="x_Cust_ID" Value='<%=intUserID%>' >
	<input type="hidden" readonly name="x_Description" id="x_Description" Value='<%=txtProductsDescription%>' >
	<input type="hidden" readonly name="x_Invoice_Num" id="x_Invoice_Num" Value='<%=intPurchaseID%>' >
	<input type="hidden" name="x_freight" id="x_freight" Value='1' >
	<input type="hidden" name="x_po_num" id="x_po_num" Value='<%=intCompanyID%>' >

    <input type="hidden" name="x_test_request" id="x_test_request" Value=<%=test %> >

<table border="0" cellspacing="0" cellpadding="6" width="600" align="left">
	<tr>
		<td valign="top" align="right" width="250"><strong><%=strTextAmount%>:</strong></td>
		<td valign="top" width="320">
		<input type="hidden" readonly name="x_Amount" id="x_Amount" Value='<%=FormatCurrency(mnyTotalGrand, 2)%>' >
		<%=FormatCurrency(mnyTotalGrand, 2)%>

<!--            		<input type="hidden" readonly name="x_Amount" id="x_Amount" Value='1.00' >
		<%=FormatCurrency(mnyTotalGrand, 2)%>-->

		<td>
	</tr>
	<tr>
		<td valign="top" align="right" width="250"><strong><%=strTextCreditCardNumber%>:</strong></td>
		<td valign="top" width="320">
		<INPUT TYPE="text" NAME="x_Card_Num">
		<td>
	</tr>
	<tr>
		<td valign="top" align="right" width="250"><strong><%=strTextExpirationDateFormat%>:</strong></td>
		<td valign="top" width="320">
		<INPUT TYPE="text" NAME="x_Exp_Date" SIZE="10">
		<td>
	</tr>
	<tr>
		<td valign="top" align="right"><strong><%=strTextFirstName%>:</strong></td>
		<td valign="top">
		<input type="text" name="x_First_Name" id="x_First_Name" Value='<%=strFirstName%>' >
		</td>
	</tr>
	<tr>
		<td valign="top" align="right"><strong><%=strTextLastName%>:</strong></td>
		<td valign="top">
		<input type="text" name="x_Last_Name" id="x_Last_Name" Value='<%=replace(strLastName,"'","")%>' >
		</td>
	</tr>
	<tr>
		<td valign="top" align="right"><strong><%=strTextEmailAddressForReceipt%>:</strong></td>
		<td valign="top">
		<input type="text" name="x_Email" id="x_Email"  Value='<%=strEmail%>' SIZE="50">
		</td>
	</tr>
	<tr>
		<td valign="top" align="right"><strong><%=strTextBillToAddress%>:</strong></td>
		<td valign="top"><INPUT TYPE="text" NAME="x_Address" SIZE="50">
		</td>
	</tr>
	<tr>
		<td valign="top" align="right"><strong><%=strTextCity%>:</strong></td>
		<td valign="top">
		<INPUT TYPE="text" NAME="x_City" SIZE="30">
		</td>
	</tr>
	<tr>
		<td valign="top" align="right"><strong><%=strTextStateProvince%>:</strong></td>
		<td valign="top">
		<INPUT TYPE="text" NAME="x_State" SIZE="25">
		</td>
	</tr>
	<tr>
		<td valign="top" align="right"><strong><%=strTextZipPostalCode%>:</strong></td>
		<td valign="top"><INPUT TYPE="text" NAME="x_Zip" SIZE="25"></td>
	</tr>
	<tr>
		<td valign="top" align="right"><strong><%=strTextCountry%>:</strong></td>
		<td valign="top"><INPUT TYPE="text" NAME="x_Country" SIZE="50" value="USA"></td>
	</tr>
	<tr>
		<td valign="top" align="center" colspan="2">
			<input type="button" value="<%=strTextBackToPurchaseForm%>" onClick="javascript:goBack();">&nbsp;&nbsp;
			<input type="submit" value="<%=strTextProcessPayment%>" id="add" name="add">&nbsp;&nbsp;
</form>
<%
	' If they are an admin give them the ability to make this transaction billable
	' When clicking on the button they will be taken to a page that will mark the PurchaseID as billable in the db
	' and then let the user assign tracking/viewing rights on the associated test codes to a given user(s)
	If Request.Cookies("UserTypeID") = "4" Then
		Response.Write "<form name=""Billable"" method=""post"">"
		Response.Write "	<br><br><hr style=""color:#000000;height:1px;""><br>"
		Response.Write "	Select the language to use for generating the Testcodes:"
		Response.Write "	<br><select name=""TestCodeLanguage"">"
		Response.Write "		<option value=1>English</option>"
		Response.Write "		<option value=6>Chinese</option>"
		Response.Write "	</select>"
		Response.Write "	<br><br>"
		Response.Write "	<input type=""button"" value=""" & strTextMakeBillable & """ style=""color:red;font-weight:bolder;"" onClick=""javascript:makeBillable();"">"
		Response.Write "	<br><br><div><b>Notice:</b><br>" & strTextClickingOnThisButtonMeansYouIntend & "</div>"
		Response.Write "	<br><hr style=""color:#000000;height:1px;""><br>"
		Response.Write "</form>"
	End If
%>
		</td>
	</tr>
	<tr><td valign="top" align="center" colspan="2"><img src="/pdi/images/ComoAuth.gif" alt="SS" width="120" height="72" style="border: 0px;"><br> <span style="font-weight:bold; font-size:7pt"></span>  </td></tr>
</table>		
<!--
TrustLogo Html Builder Code:
Shows the logo at URL http://www.pdiprofile.com/pdi/images/tl_transp.gif
Logo type is  ("SC4")
Floating on the Bottom Right
//-->
<a href="http://www.instantssl.com" id="comodoTL">SSL</a>
<!--<script type="text/javascript">TrustLogo("http://www.pdiprofile.com/pdi/images/tl_transp.gif", "SC4", "bottomright");</script>-->
</div>

    </div>
</body>
</html>
