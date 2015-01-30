<%@ Language=VBScript %>
<!--#Include FILE="Include/CheckLogin.asp" -->
<!--#Include FILE="Include/Common.asp" -->
<% pageID = "authorizeNet" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Review Your Purchase</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
	<!--#Include FILE="Include/HeadStuff.asp" -->
<%
Dim x_Amount
Dim x_First_Name
Dim x_Last_Name
Dim x_Cust_ID
Dim x_Description
Dim x_Invoice_Num
Dim x_freight
Dim x_po_num

x_Amount = Request.QueryString("x_Amount")
x_First_Name = Request.QueryString("x_First_Name")
x_Last_Name = Request.QueryString("x_Last_Name")
x_Cust_ID = Request.QueryString("x_Cust_ID")
x_Description = Request.QueryString("x_Description")
x_Invoice_Num = Request.QueryString("x_Invoice_Num")
x_freight = Request.QueryString("x_freight")
x_po_num = Request.QueryString("x_po_num")

x_Email = Request.QueryString("EM")
x_Address = Request.QueryString("UA")
x_City = Request.QueryString("UC")
x_State = Request.QueryString("US")
x_Zip = Request.QueryString("UZ")

Dim sequence
Dim amount
Dim ret

' Trim $ dollar sign if it exists
amount = x_Amount
'amount=23.45

' Seed random number for more security and more randomness
Randomize
sequence = Int(1000 * Rnd)
' Now we need to add the SIM related data like fingerprint to the HTML form.

' See whether this user is a TestUser? - someone testing the system
' so that we don't count their purchase as the real thing...JT
Dim intTestAccount
Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
With oCmd
    .CommandText = "sel_TRUser_TestAccount"
	.CommandType = 4
	.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	.Parameters.Append .CreateParameter("@UserID",3, 1, 4, x_Cust_ID)
    .Parameters.Append .CreateParameter("@IsTest", 3, 3, 4, cInt(intTestAccount))
End With
oConn.Open strDbConnString
oCmd.ActiveConnection = oConn
oCmd.Execute , , 128
If oConn.Errors.Count < 1 then
	intTestAccount = oCmd.Parameters("@IsTest").value
Else
	intTestAccount = 0
End If
 %>

<script language="JavaScript">
	window.status = '<%=x_Description%>';
</script>

</head>
<body>

<!--#Include FILE="simlib.asp"-->
<!--#Include FILE="Include/TopBanner.asp" -->


<FORM METHOD=POST ACTION="https://secure.authorize.net/gateway/transact.dll">
<div id="maincontent">
<%ret = InsertFP ("pdicards", "LhuReUtn8roZkbGY", amount, sequence)%>

<INPUT TYPE=HIDDEN NAME="x_Version" VALUE="3.1">
<INPUT TYPE=HIDDEN NAME="x_Login" VALUE="pdicards">

<input type="hidden" name="x_Cust_ID" id="x_Cust_ID" Value='<%=x_Cust_ID%>' >
<input type="hidden" readonly name="x_Description" id="x_Description" Value='<%=x_Description%>' >
<input type="hidden" readonly name="x_Invoice_Num" id="x_Invoice_Num" Value='<%=x_Invoice_Num%>' >
<input type="hidden" name="x_freight" id="x_freight" Value='<%=x_freight%>' >
<input type="hidden" name="x_po_num" id="x_po_num" Value='<%=x_po_num%>' >

<% If intTestAccount = 1 Then %>
	<input type="hidden" name="x_test_request" id="x_test_request" Value='True' >
<% Else %>
	<input type="hidden" name="x_test_request" id="x_test_request" Value='False' >
<% End If %>

<img src="images/payment.gif">
						
<table border="0" cellspacing="0" cellpadding="6" width="570">
	<tr> 
		<td valign="top" align="right" width="250"><strong>Amount:</strong></td>
		<td valign="top" width="320">
		<input type="hidden" readonly name="x_Amount" id="x_Amount" Value='<%=x_Amount%>' >
		<%=FormatCurrency(x_Amount, 2)%>
		<td>
	</tr>

	<tr> 
		<td valign="top" align="right" width="250"><strong>Credit Card #:</strong></td>
		<td valign="top" width="320">
		<INPUT TYPE="text" NAME="x_Card_Num">
		<td>
	</tr>
	<tr> 
		<td valign="top" align="right" width="250"><strong>Exp. Date (MM/DD/YYYY):</strong></td>
		<td valign="top" width="320">
		<INPUT TYPE="text" NAME="x_Exp_Date" SIZE="10">
		<td>
	</tr>
	<tr> 
		<td valign="top" align="right"><strong>First Name:</strong></td>
		<td valign="top">
		<input type="text" name="x_First_Name" id="x_First_Name" Value='<%=x_First_Name%>' >
		</td>
	</tr>
	<tr> 
		<td valign="top" align="right"><strong>Last Name:</strong></td>
		<td valign="top">
		<input type="text" name="x_Last_Name" id="x_Last_Name" Value='<%=replace(x_Last_Name,"'","")%>' >
		</td>
	</tr>
	<tr> 
		<td valign="top" align="right"><strong>Email Address for Receipt Mailing:</strong></td>
		<td valign="top">
		<input type="text" name="x_Email" id="x_Email"  Value='<%=x_Email%>' SIZE="50">
		</td>
	</tr>
	<tr> 
		<td valign="top" align="right"><strong>Bill To Address:</strong></td>
		<td valign="top"><INPUT TYPE="text" NAME="x_Address" Value="<%=x_Address%>" SIZE="50">
		</td>
	</tr>
	<tr> 
		<td valign="top" align="right"><strong>City:</strong></td>
		<td valign="top">
		<INPUT TYPE="text" NAME="x_City" Value='<%=x_City%>' SIZE="30">
		</td>
	</tr>
	<tr> 
		<td valign="top" align="right"><strong>State:</strong></td>
		<td valign="top">
		<INPUT TYPE="text" NAME="x_State" Value='<%=x_State%>' SIZE="25">
		</td>
	</tr>
	<tr> 
		<td valign="top" align="right"><strong>Zip:</strong></td>
		<td valign="top"><INPUT TYPE="text" NAME="x_Zip" Value='<%=x_Zip%>' SIZE="25"></td>
	</tr>
	<tr> 
		<td valign="top" align="center" colspan="2"><input type="submit" value="Process Payment" id="add" name="add"></td>
	</tr>
</table>				
</form>
</div>
</body>
</html>
