<%@ Language=VBScript %>

<!--#INCLUDE FILE="include/checklogin.asp" -->
<!--#INCLUDE FILE="include/common.asp" -->
<%
pageID = "purchaseTest"
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Credit Card Information Collection</title>
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

' Now, get the values form the previous form
	intUserID = Request.Form("intUserID")
	intResellerID = Request.Form("intResellerID")
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
		Response.Write "<FORM name=""thisForm"" action=""purchaseTest.asp?res=" & intResellerID & " method=""post"">" & VbCrLf
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
			Response.Write "<input type=""hidden"" name=""intProductQuantity" & intCount & """ id=""intProductQuantity" & intCount & """ value=""" & arrProductQuantity(intCount) & """>" & VbCrLf
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
	oConn.Open strDBaseConnString
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
	oConn.Open strDBaseConnString
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
	strFirstName = ""
	strLastName = ""
	strEmail = ""
	strAddress = ""
	strCity = ""
	strState = ""
	strPostalCode = ""

' Let's test to see whether the User's info has been sent to this form or not
	strFirstName = Request("FName")
	strLastName = Request("LName")
	strEmail = Request("Email")
	
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
		strFirstName = ""
		strLastName = ""
		strEmail = ""
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		With oCmd
			.CommandText = "spUserGetInfo"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			.Parameters.Append .CreateParameter("@intUserID", 3, 1, 4, intUserID)
			.Parameters.Append .CreateParameter("@strFirstName", 200, 3, 30, strFirstName)
			.Parameters.Append .CreateParameter("@strLastName", 200, 3, 30, strLastName)
			.Parameters.Append .CreateParameter("@strEmail", 200, 3, 50, strEmail)
			.Parameters.Append .CreateParameter("@strAddress", 200, 3, 80, strAddress)
			.Parameters.Append .CreateParameter("@strCity", 200, 3, 40, strCity)
			.Parameters.Append .CreateParameter("@strState", 200, 3, 30, strState)
			.Parameters.Append .CreateParameter("@strPostalCode", 200, 3, 30, strPostalCode)
		End With
		oConn.Open strDBaseConnString
		oCmd.ActiveConnection = oConn
		oCmd.Execute , , 128
		If oConn.Errors.Count < 1 Then
			strFirstName = oCmd.Parameters("@strFirstName").value
			strLastName = oCmd.Parameters("@strLastName").value
			strEmail = oCmd.Parameters("@strEmail").value
			strAddress = oCmd.Parameters("@strAddress").value
			strCity = oCmd.Parameters("@strCity").value
			strState = oCmd.Parameters("@strState").value
			strPostalCode = oCmd.Parameters("@strPostalCode").value
		Else
			strFirstName = ""
			strLastName = ""
			strEmail = ""
			strAddress = ""
			strCity = ""
			strState = ""
			strPostalCode = ""
		End If
	End If

' Seed random number for more security and more randomness
	Randomize
	intSequence = Int(1000 * Rnd)
%>
<script language="JavaScript">

function goBack()
{
	document.thisForm.action = "PurchaseTest.asp";
	document.thisForm.submit();
}
</script>
</head>
<body>

<!--#INCLUDE FILE="simlib.asp"-->

<img src="images/payment.gif">

<FORM NAME="thisForm" METHOD=POST ACTION="https://secure.authorize.net/gateway/transact.dll">
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

	<%ret = InsertFP ("pdicards", "LhuReUtn8roZkbGY", FormatCurrency(mnyTotalGrand,2), intSequence)%>
	<INPUT TYPE=HIDDEN NAME="x_Version" VALUE="3.1"><INPUT TYPE=HIDDEN NAME="x_Login" VALUE="pdicards">
	<input type="hidden" name="x_Cust_ID" id="x_Cust_ID" Value='<%=intUserID%>' >
	<input type="hidden" readonly name="x_Description" id="x_Description" Value='<%=txtProductsDescription%>' >
	<input type="hidden" readonly name="x_Invoice_Num" id="x_Invoice_Num" Value='<%=intPurchaseID%>' >
	<input type="hidden" name="x_freight" id="x_freight" Value='1' >
	<input type="hidden" name="x_po_num" id="x_po_num" Value='<%=intCompanyID%>' >

<% If intIsATest = 1 Then %>
	<input type="hidden" name="x_test_request" id="x_test_request" Value='True' >
<% Else %>
	<input type="hidden" name="x_test_request" id="x_test_request" Value='False' >
<% End If %>

<table border="0" cellspacing="0" cellpadding="6" width="600" align="left">
	<tr> 
		<td valign="top" align="right" width="250"><strong>Amount:</strong></td>
		<td valign="top" width="320">
		<input type="hidden" readonly name="x_Amount" id="x_Amount" Value='<%=FormatCurrency(mnyTotalGrand, 2)%>' >
		<%=FormatCurrency(mnyTotalGrand, 2)%>
		<td>
	</tr>

	<tr>
		<td valign="top" align="right" width="250"><strong>Credit Card #:</strong></td>
		<td valign="top" width="320">
		<INPUT TYPE="text" NAME="x_Card_Num">
		<td>
	</tr>
	<tr>
		<td valign="top" align="right" width="250"><strong>Exp. Date (MM/YYYY):</strong></td>
		<td valign="top" width="320">
		<INPUT TYPE="text" NAME="x_Exp_Date" SIZE="10">
		<td>
	</tr>
	<tr>
		<td valign="top" align="right"><strong>First Name:</strong></td>
		<td valign="top">
		<input type="text" name="x_First_Name" id="x_First_Name" Value='<%=strFirstName%>' >
		</td>
	</tr>
	<tr>
		<td valign="top" align="right"><strong>Last Name:</strong></td>
		<td valign="top">
		<input type="text" name="x_Last_Name" id="x_Last_Name" Value='<%=replace(strLastName,"'","")%>' >
		</td>
	</tr>
	<tr> 
		<td valign="top" align="right"><strong>Email Address for Receipt Mailing:</strong></td>
		<td valign="top">
		<input type="text" name="x_Email" id="x_Email"  Value='<%=strEmail%>' SIZE="50">
		</td>
	</tr>
	<tr> 
		<td valign="top" align="right"><strong>Bill To Address:</strong></td>
		<td valign="top"><INPUT TYPE="text" NAME="x_Address" SIZE="50">
		</td>
	</tr>
	<tr> 
		<td valign="top" align="right"><strong>City:</strong></td>
		<td valign="top">
		<INPUT TYPE="text" NAME="x_City" SIZE="30">
		</td>
	</tr>
	<tr> 
		<td valign="top" align="right"><strong>State/Province:</strong></td>
		<td valign="top">
		<INPUT TYPE="text" NAME="x_State" SIZE="25">
		</td>
	</tr>
	<tr> 
		<td valign="top" align="right"><strong>Zip/Postal Code:</strong></td>
		<td valign="top"><INPUT TYPE="text" NAME="x_Zip" SIZE="25"></td>
	</tr>
	<tr> 
		<td valign="top" align="right"><strong>Country:</strong></td>
		<td valign="top"><INPUT TYPE="text" NAME="x_Country" SIZE="50"></td>
	</tr>
	<tr> 
		<td valign="top" align="center" colspan="2">
			<input type="button" value="Back to Purchase Form" onClick="javascript:goBack();">&nbsp;&nbsp;
			<input type="submit" value="Process Payment" id="add" name="add">
			<%	
				' If they are an admin give them the ability to make this transaction billable
				' When clicking on the button they will be taken to a page that will mark the PurchaseID as billable in the db
				' and then let the user assign tracking/viewing rights on the associated test codes to a given user(s)
				If Request.Cookies("UserTypeID") = 4 Then 
					Response.Write("<br><br><hr style=""color:#000000;height:1px;""><br>")
					Response.Write("<input type=""button"" value=""Make Billable"" style=""color:red;font-weight:bolder;"" onClick=""document.location.href='./Admin/BillablePurchase.asp?res=" & intResellerID & "&pid=" & intPurchaseID & "'"">")
					Response.Write("<br><br><div><b>Notice:</b><br>Clicking on this button means you intend to bill for these items outside of the Online PDI System.<br>Your purchase will be included in the ""Billable Transactions"" financial reports.</div>")
					Response.Write("<br><hr style=""color:#000000;height:1px;""><br>")
				End If
			%>
		</td>
	</tr>
</table>				
</form>
</body>
</html>
