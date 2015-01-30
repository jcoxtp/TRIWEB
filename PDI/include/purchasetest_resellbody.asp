
<%
'*****************************************************************************************
'*
'* Generated By: TierBuilder V3.2 - www.tierbuilder.com
'* Created By: David Brackin
'* Creation Date: Thursday, February 28, 2002  20:12:11
'* Copyright (c) 2002 Team Resources, Inc.
'*
'* ----  Code Settings ----
'*
'* Returns Recordset: NO
'* Purpose: This ASP page calls the stored procedure ins_Purchase_RegularUser using ADO.
'**********************************************************************************************************************************

on error resume next

Response.Buffer = TRUE

Dim NoTestsPurchased

Dim nTestCount
Dim nCount

Dim oConn
Dim oCmd
Dim oTestsRs

Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
Set oTestsRs = CreateObject("ADODB.Recordset")

With oCmd

    .CommandText = "sel_TRTest_all"
    .CommandType = 4

    .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	
	.Parameters.Append .CreateParameter("@UserID",3, 1,4, Request.Cookies("UserID"))

End With

oConn.Open strDbConnString

oCmd.ActiveConnection = oConn

oTestsRs.CursorLocation = 3

oTestsRs.Open oCmd, , 0, 1

If oConn.Errors.Count > 0 then

	Response.Write "Unable to retrieve products from database. Please try again."
	Response.End
	
end if 

nCount = 0 

If oTestsRs.EOF = FALSE then

	oTestsRs.MoveFirst

	while oTestsRs.EOF = FALSE 

		nCount = nCount + 1 

		oTestsRs.MoveNext
		
	wend 

	Set oComm = Nothing
	Set oCmd = Nothing

	ReDim NoTestsPurchased(nCount)

else 

	Response.Write "Unable to retrieve products from database. Please try again."
	Response.End

end if 

Dim bSubmitted

bSubmitted = Request.Form ("txtSubmit")

Dim bFilledOutProperly, strErrMsg

Dim UserID
Dim CreditApproved
Dim TotalAmount
Dim PurchaseComplete

Dim TRTestID
Dim PurchaseID
Dim DiscountPercent
Dim CommissionPercent
Dim CompanyName
Dim Address1
Dim Address2
Dim Address3
Dim Address4
Dim City
Dim ProvinceID
Dim PostalCode
Dim CompanyID

Dim R_CompanyName 
Dim R_Address1 
Dim R_City
Dim R_ProvinceName 
Dim R_PostalCode 
Dim UserEmailAddress 

bFilledOutProperly = FALSE

Dim nNoOfTests
Dim nLoop
Dim TotalTestsPurchased
     
If bSubmitted <> "" Then

	 UserID = Request.Cookies("UserID")

     CreditApproved = Request.Form("txtCreditApproved")

     TotalAmount = Request.Form("txtTotalAmount")

     PurchaseComplete = Request.Form("txtPurchaseComplete")
     
     nNoOfTests = Request.Form("txtNoOfTests")
     
     nCount = 1 
     
     TotalTestsPurchased = 0 
     
     oTestsRs.MoveFirst
     
     while oTestsRs.EOF = FALSE
     
      	strTemp = "txtNoTestsPurchased" & nCount

		NoTestsPurchased(nCount) = Trim(Request.Form(strTemp))
		
		TotalTestsPurchased = TotalTestsPurchased + CInt(NoTestsPurchased(nCount))
     
		'Response.Write NoTestsPurchased(nCount)
		'Response.Write "<br>"
		
		nCount = nCount + 1
		
		oTestsRs.MoveNext
				
     wend 
     
     oTestsRs.MoveFirst
     
     PurchaseID = Request.Form("txtPurchaseID")

     DiscountPercent = Request.Form("txtDiscountPercent")

     CommissionPercent = Request.Form("txtCommissionPercent")

     CompanyName = Request.Form("txtCompanyName")

     Address1 = Request.Form("txtAddress1")

     Address2 = Request.Form("txtAddress2")

     Address3 = Request.Form("txtAddress3")

     Address4 = Request.Form("txtAddress4")

     City = Request.Form("txtCity")

     ProvinceID = Request.Form("txtProvinceID")

     PostalCode = Request.Form("txtPostalCode")

     CompanyID = Request.Form("txtCompanyID")

Else

	UserID = Request.Cookies("UserID")
	PurchaseComplete = 0 

End If

UserID = Trim(UserID)
CreditApproved = Trim(CreditApproved)
TotalAmount = Trim(TotalAmount)
PurchaseComplete = Trim(PurchaseComplete)

PurchaseID = Trim(PurchaseID)
DiscountPercent = Trim(DiscountPercent)
CommissionPercent = Trim(CommissionPercent)
CompanyName = Trim(CompanyName)
Address1 = Trim(Address1)
Address2 = Trim(Address2)
Address3 = Trim(Address3)
Address4 = Trim(Address4)
City = Trim(City)
ProvinceID = Trim(ProvinceID)
PostalCode = Trim(PostalCode)
CompanyID = Trim(CompanyID)

If bSubmitted <> "" Then

	 'Response.Write CompanyID
	 
	 'Response.End
	 
     If UserID = "" then 

          strErrMsg = " Please enter a value for - UserID"

     'ElseIf CreditApproved = "" then 

          'strErrMsg = " Please enter a value for - CreditApproved"

	  ElseIf CInt(TotalTestsPurchased) = 0 then
	  
		  strErrMsg = " Please enter a quantity to purchase."	

	  ElseIf TotalAmount = "" then 

          strErrMsg = " Please enter a value for - TotalAmount"

     'ElseIf PurchaseComplete = "" then 

          'strErrMsg = " Please enter a value for - PurchaseComplete"

     'ElseIf PurchaseID = "" then 

          'strErrMsg = " Please enter a value for - PurchaseID"

     'ElseIf DiscountPercent = "" then 

          'strErrMsg = " Please enter a value for - DiscountPercent"

     'ElseIf CommissionPercent = "" then 

          'strErrMsg = " Please enter a value for - CommissionPercent"
     
     Else

	       bFilledOutProperly = TRUE

     End If
     
     if bFilledOutProperly = TRUE then
     
		if (CompanyID <> "9999991" AND CompanyID <> "9999990") and (CompanyName <> "" or Address1 <> "" or City <> "" or PostalCode <> "") then 
		                  
			'Response.Write CompanyID
		
			strErrMsg = " Please either choose a company or enter company information."
		
			bFilledOutProperly = FALSE
							
		end if    
		
     end if
     
     if bFilledOutProperly = TRUE then
     
			if CompanyName <> "" or Address1 <> "" or City <> "" or PostalCode <> "" then 
     
				If CompanyName = "" then 

				     strErrMsg = " Please enter a value for - Company Name"

				ElseIf Address1 = "" then 

				     strErrMsg = " Please enter a value for - Address1"

				'ElseIf Address2 = "" then 

				     'strErrMsg = " Please enter a value for - Address2"

				'ElseIf Address3 = "" then 

				     'strErrMsg = " Please enter a value for - Address3"

				'ElseIf Address4 = "" then 

				     'strErrMsg = " Please enter a value for - Address4"

				ElseIf City = "" then 

				     strErrMsg = " Please enter a value for - City"

				ElseIf ProvinceID = "" then 

				     strErrMsg = " Please enter a value for - State"

				ElseIf PostalCode = "" then 

				     strErrMsg = " Please enter a value for - Postal Code"

				'ElseIf Country = "" then 

				     'strErrMsg = " Please enter a value for - Country"
				Else

					bFilledOutProperly = TRUE
					
				End If
						
			Else	
		
				' need to set these to blank for the stored procedure
				' to work properly
				CompanyName = ""
				Address1 = ""
				Address2 = ""
				Address3 = ""
				Address4 = ""
				City = ""
				ProvinceID = 0
				PostalCode = ""
				Country = ""
			
				' this is required by the stored procedure
				if (CompanyID = "9999991" OR CompanyID = "9999990") AND bFilledOutProperly = TRUE then
		
					CompanyID = 0 
		
				end if
					
			End if
			
	  End if
		
End If%>


<html>

<head>

<title></title>

</head>

<body>
<br><br>
<table width="70%" border="0" cellspacing="2" cellpadding="0">
	<tr> 
	  <td><img src="images/user_information_top.gif"></td>
	</tr>
	<tr> 
		<td bgcolor="#CCCCCC" valign="top"> 
		<table width="100%" border="0" cellspacing="2" cellpadding="3">
		<tr>
		<td>
		
			
			<table>

				<tr>
				<td width="25%" class="linkbold" valign="middle" height="24" bgcolor="#999999"> 
                        <div align="right">User:&nbsp;</div>
                      </td>
				

				<td width="75%" valign="middle" class="normbodytext"><%=Request.Cookies("UserName")%>

				</td>
				</tr>
				
				<% if Request.Cookies("CompanyID") = "" OR ISNULL(Request.Cookies("CompanyID")) = TRUE then
					else
				%>
				
				<tr>
				<td width="25%" class="linkbold" valign="middle" height="24" bgcolor="#999999"> 
                        <div align="right">Company:&nbsp;</div>
                      </td>
				

				<td width="75%" valign="middle" class="normbodytext"><%=Request.Cookies("CompanyName")%>

				</td>
				</tr>
				<% end if %>
				
			</table>
				
		</td>
		</tr>
		
		</table>	
</td>
</tr>
		
</table>	

<%

If bSubmitted <> "" AND bFilledOutProperly Then

Dim TestsPurchased

TestsPurchased = ""

oTestsRs.MoveFirst

nCount = 1 

while oTestsRS.EOF = FALSE

	if nCount > 1 then
		TestsPurchased = TestsPurchased & "," & oTestsRS("TRTestID") & "|" & NoTestsPurchased(nCount)
	else
		TestsPurchased = oTestsRS("TRTestID") & "|" & NoTestsPurchased(nCount)
	end if 
	
	nCount = nCount + 1

	oTestsRS.MoveNext

wend 

oTRTestRs.MoveFirst

TestsPurchased = TestsPurchased & ","


' All of these are always blank
CreditApproved = 0 
PurchaseID = 0 
DiscountPercent = 0 
CommissionPercent = 0 

'CompanyID = 0 

Dim FirstName, LastName

FirstName = ""
LastName = ""

'Response.Write "<br>UserID	" & 	UserID
'Response.Write "<br>CreditApproved	" & 	CreditApproved
'Response.Write "<br>TotalAmount	" & 	TotalAmount
'Response.Write "<br>PurchaseComplete	" & 	PurchaseComplete
'Response.Write "<br>TestsPurchased	" & 	TestsPurchased
'Response.Write "<br>TRTestID	" & 	TRTestID
'Response.Write "<br>PurchaseID	" & 	PurchaseID
'Response.Write "<br>DiscountPercent	" & 	DiscountPercent
'Response.Write "<br>CommissionPercent	" & 	CommissionPercent
'Response.Write "<br>CompanyName	" & 	CompanyName
'Response.Write "<br>Address1	" & 	Address1
'Response.Write "<br>Address2	" & 	Address2
'Response.Write "<br>Address3	" & 	Address3
'Response.Write "<br>Address4	" & 	Address4
'Response.Write "<br>City	" & 	City
'Response.Write "<br>ProvinceID	" & 	ProvinceID
'Response.Write "<br>PostalCode	" & 	PostalCode
'Response.Write "<br>CompanyID	" & 	CompanyID

'Response.end

Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")

With oCmd

     .CommandText = "ins_Purchase_Reseller"
     .CommandType = 4


     .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
        .Parameters.Append .CreateParameter("@UserID",3, 1,4, UserID)

        .Parameters.Append .CreateParameter("@CreditApproved",3, 1,4, CreditApproved)

        .Parameters.Append .CreateParameter("@TotalAmount",6, 3,21, CStr(TotalAmount))

        .Parameters.Append .CreateParameter("@PurchaseComplete",3, 1,4, PurchaseComplete)

        .Parameters.Append .CreateParameter("@NoTestsPurchased",200, 1,100, CStr(TestsPurchased))

        .Parameters.Append .CreateParameter("@PurchaseID",3, 3,4, CLng(PurchaseID))

        .Parameters.Append .CreateParameter("@DiscountPercent",5, 3,8, CStr(DiscountPercent))

        .Parameters.Append .CreateParameter("@CommissionPercent",5, 3,8, CStr(CommissionPercent))

		.Parameters.Append .CreateParameter("@ResellerCompanyID",3, 1,4, Request.Cookies("CompanyID"))

        .Parameters.Append .CreateParameter("@CompanyName",200, 1,100, CompanyName)

        .Parameters.Append .CreateParameter("@Address1",200, 1,100, Address1)

        .Parameters.Append .CreateParameter("@Address2",200, 1,100, Address2)

        .Parameters.Append .CreateParameter("@Address3",200, 1,100, Address3)

        .Parameters.Append .CreateParameter("@Address4",200, 1,100, Address4)

        .Parameters.Append .CreateParameter("@City",200, 1,100, City)

        .Parameters.Append .CreateParameter("@ProvinceID",3, 1,4, ProvinceID)

        .Parameters.Append .CreateParameter("@PostalCode",200, 1,50, PostalCode)

        .Parameters.Append .CreateParameter("@CompanyID",3, 3,4, CLng(CompanyID))
                
        .Parameters.Append .CreateParameter("@FirstName",200, 3,100, CStr(FirstName))

        .Parameters.Append .CreateParameter("@LastName",200, 3,100, CStr(LastName))

		' Receiving reseller information
        
        .Parameters.Append .CreateParameter("@R_CompanyName",200, 3,100, CStr(R_CompanyName))

        .Parameters.Append .CreateParameter("@R_Address1",200, 3,100, CStr(R_Address1))

        .Parameters.Append .CreateParameter("@R_City",200, 3,100, CStr(R_City))

        .Parameters.Append .CreateParameter("@R_ProvinceName",200, 3,50, CStr(R_ProvinceName))

        .Parameters.Append .CreateParameter("@R_PostalCode",200, 3,50, CStr(R_PostalCode))

        .Parameters.Append .CreateParameter("@UserEmailAddress",200, 3,50, CStr(UserEmailAddress))

End With

oConn.Open strDbConnString

oCmd.ActiveConnection = oConn

oCmd.Execute , , 128

PurchaseID = oCmd.Parameters("@PurchaseID").value
DiscountPercent = oCmd.Parameters("@DiscountPercent").value
CommissionPercent = oCmd.Parameters("@CommissionPercent").value

CompanyID = oCmd.Parameters("@CompanyID").value
FirstName = oCmd.Parameters("@FirstName").value
LastName = oCmd.Parameters("@LastName").value



R_CompanyName = oCmd.Parameters("@R_CompanyName").value
R_Address1 = oCmd.Parameters("@R_Address1").value
R_City = oCmd.Parameters("@R_City").value
R_ProvinceName = oCmd.Parameters("@R_ProvinceName").value
R_PostalCode = oCmd.Parameters("@R_PostalCode").value
UserEmailAddress = oCmd.Parameters("@UserEmailAddress").value

If oConn.Errors.Count < 1 then

	' THIS IS JUST FOR SIMULATION PURPOSES
	
	Response.Redirect("authorizenet.asp?x_po_num=" & CompanyID & "&x_Amount=" & TotalAmount & "&x_First_Name=" & Server.URLEncode(FirstName) & "&x_Last_Name=" & Server.URLEncode(LastName) & "&x_Cust_ID=" & Request.Cookies("UserID") & "&x_Description=" & Server.URLEncode("DISC Test") & "&x_Invoice_Num=" & PurchaseID & "&x_freight=1")
	
	'Response.Redirect("authorizenet.asp")
	
	' DO THIS TO GO TO PRODUCTION
	%>
	<form NAME="AUTHFORM2" METHOD="POST" ACTION="HTTPS://secure.authorize.net/gateway/transact.dll">
	<input TYPE="HIDDEN" NAME="x_Version" VALUE="3.1">
	<input TYPE="HIDDEN" NAME="x_Login" VALUE="pdicards">
	<input TYPE="HIDDEN" NAME="x_Password" VALUE="profile4pdi">
	<input TYPE="HIDDEN" NAME="x_Show_Form" VALUE="PAYMENT_FORM">
	<input TYPE="HIDDEN" NAME="x_Amount" VALUE="<%=TotalAmount%>">
	<input TYPE="HIDDEN" NAME="x_First_Name" VALUE="<%=FirstName%>">
	<input TYPE="HIDDEN" NAME="x_Last_Name" VALUE="<%=LastName%>">
	<input TYPE="HIDDEN" NAME="x_Cust_ID" VALUE="<%=Request.Cookies("UserID")%>">
	<input TYPE="HIDDEN" NAME="x_Description" VALUE="PDI Profile and/or Application Modules">
	<input TYPE="HIDDEN" NAME="x_Invoice_Num" VALUE="<%=PurchaseID%>">
	<input TYPE="HIDDEN" NAME="x_po_num" VALUE="<%=CompanyID%>">
	
	<input TYPE="HIDDEN" NAME="x_Company" VALUE="<%=R_CompanyName%>">
	<input TYPE="HIDDEN" NAME="x_Address" VALUE="<%=R_Address1%>">
	<input TYPE="HIDDEN" NAME="x_City" VALUE="<%=R_City%>">
	<input TYPE="HIDDEN" NAME="x_State" VALUE="<%=R_ProvinceName%>">
	<input TYPE="HIDDEN" NAME="x_Zip" VALUE="<%=R_PostalCode%>">
	<input TYPE="HIDDEN" NAME="x_Email" VALUE="<%=UserEmailAddress%>">
	
	<input TYPE="submit" name="mysubmitbutton">
	</form>
	<script language="JavaScript"><!--
	document.AUTHFORM2.mysubmitbutton.click();
	//--></script>
	<%

	Response.End

	if NoTestsPurchased > 1 then
	
		Response.Write "Profile codes purchased successfully."
		
	else
	
		Response.Write "Profile code purchased successfully."
	
	end if
	
	Response.Write "<br><br>"
	
	
	' display the list of test codes purchased here
	Dim oRs

	Set oConn = Nothing
	Set oCmd = Nothing
	
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")

	With oCmd

	     .CommandText = "sel_Purchase_TestCode_PurchaseID"
	     .CommandType = 4

	     .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
         .Parameters.Append .CreateParameter("@PurchaseID",3, 1,4, PurchaseID)

	End With

	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn

	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	
	Dim nTCCounter
	
	nTCCounter = 1 

	If oConn.Errors.Count < 1 then

		if oRs.EOF = FALSE then
		
			Response.Write "<TABLE BORDER=1 CELLPADDING=2 CELLSPACING=2>"
		
			Response.Write "<TR>"
			Response.Write "<TD>No."
			Response.Write "</TD>"
			Response.Write "<TD>Profile Code Purchased"
			Response.Write "</TD>"
			Response.Write "</TR>"

			while oRs.EOF = FALSE 
			
				Response.Write "<TR>"
				Response.Write "<TD>" & nTCCounter
				Response.Write "</TD>"
				Response.Write "<TD>" & oRs("TestCode")
				Response.Write "</TD>"
				Response.Write "</TR>"
				
				oRs.MoveNext
				
				nTCCounter = nTCCounter + 1 
		
			wend

			Response.Write "</TABLE>"
		
		end if

	end if
	
	' end of displaying list of purchased test codes
	
	Response.End

else
     strErrMsg = Err.description
     Err.Clear
End If


End If


If strErrMsg <> "" Then

     Response.Write "<br>"
     Response.Write FormatSQLError(strErrMsg)
     Response.Write "<br><br>"


End If %>


<form name="thisForm" id="thisForm" method="post" action="purchasetest_resell.asp">


<table>

<tr>
<td>


</td>
<td>

<input type="hidden" name="txtUserID" id="txtUserID" Value="<%=UserID%>">

</td>
</tr><tr>
<td>



</td>
<td>

<input type="hidden" name="txtCreditApproved" id="txtCreditApproved" Value="<%=CreditApproved%>">

</td>
</tr>


<tr>
<td>



</td>
<td>

<input type="hidden" name="txtPurchaseComplete" id="txtPurchaseComplete" Value="<%=PurchaseComplete%>">

</td>
</tr>


<tr>
<td>

</td>
<td>

<input type="hidden" name="txtPurchaseID" id="txtPurchaseID" Value="<%=PurchaseID%>">

</td>
</tr><tr>
<td>



</td>
<td>

<input type="hidden" name="txtDiscountPercent" id="txtDiscountPercent" Value="<%=DiscountPercent%>">

</td>
</tr><tr>
<td>



</td>
<td>

<input type="hidden" name="txtCommissionPercent" id="txtCommissionPercent" Value="<%=CommissionPercent%>">

</td>
</tr>
</table>

	
	<span class="titletext"><%=Request.Cookies("UserName")%>, to associate the purchased profile codes with a company
	choose from your company list below or enter the company information.</span>
	<br><br>



<table width="529" border="0" cellspacing="2" cellpadding="0">
	<tr> 
	  <td><img src="images/company_information_top.gif"></td>
	</tr>
		<tr> 
		<td bgcolor="#CCCCCC" valign="top"> 
		
			<table>
	 <td width="25%" class="linkbold" valign="middle" height="14" bgcolor="#CCCCCC"> 
			                    <div align="right">Company List: </div>
			                  </td>
			
	<td>

	<%


	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")

	With oCmd

	     .CommandText = "sel_Company_Reseller"
	     .CommandType = 4


	     .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	     .Parameters.Append .CreateParameter("@ResellerCompanyID",3, 1,4, Request.Cookies("CompanyID"))


	End With

	oConn.Open strDbConnString

	oCmd.ActiveConnection = oConn

	oRs.CursorLocation = 3

	oRs.Open oCmd, , 0, 1

	If oConn.Errors.Count < 1 then

		%>
		<select name="txtCompanyID" class="normbodytext">
		
		<% if oRs.EOF = TRUE then %>
		
			<option value="9999991">No Companies Exist
		
		<% else %>
		
			<option value="9999990" selected>Choose a company
		<%
		
		end if
		
		if bSubmitted = "" or CompanyID = "9999990" or CompanyID = "9999991" then
		
			while oRs.EOF = FALSE
			%>
				<option value="<%=oRs("CompanyID")%>"><%=oRs("CompanyName")%>
			<%
				oRs.MoveNext
		
			wend
		
		else
		
			while oRs.EOF = FALSE
			
				if CInt(oRs("CompanyID")) = CInt(CompanyID) then
			
				%>
					<option value="<%=oRs("CompanyID")%>" selected><%=oRs("CompanyName")%>
				<%
				else
				%>
					<option value="<%=oRs("CompanyID")%>"><%=oRs("CompanyName")%> 
				<%
				end if
			
				oRs.MoveNext
		
			wend
		
		
		end if

	end if


	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRs = Nothing


	%>

	</select>


	</td>
	</tr>


			<tr>
			 <td width="25%" class="linkbold" valign="middle" height="14" bgcolor="#CCCCCC"> 
			                    <div align="right">Company Name: </div>
			                  </td>
			
	<td>

	<input type="text" class="normbodytext" name="txtCompanyName" id="txtCompanyName" MaxLength="100" Size="50" Value="<%=CompanyName%>">

	</td>
	</tr><tr>
	

	 <td width="25%" class="linkbold" valign="middle" height="14" bgcolor="#CCCCCC"> 
			                    <div align="right">Address1: </div>
			                  </td>

	
	<td>

	<input type="text" class="normbodytext" name="txtAddress1" id="txtAddress1" MaxLength="100" Size="50" Value="<%=Address1%>">

	</td>
	</tr><tr>
	 <td width="25%" class="linkbold" valign="middle" height="14" bgcolor="#CCCCCC"> 
			                    <div align="right">Address2: </div>
			                  </td>
	<td>

	<input type="text" class="normbodytext" name="txtAddress2" id="txtAddress2" MaxLength="100" Size="50" Value="<%=Address2%>">
	<input type="hidden" name="txtAddress3" id="txtAddress3" MaxLength="100" Value="<%=Address3%>">
	<input type="hidden" name="txtAddress4" id="txtAddress4" MaxLength="100" Value="<%=Address4%>">

	</td>
	</tr>
	<tr>
	 <td width="25%" class="linkbold" valign="middle" height="14" bgcolor="#CCCCCC"> 
			                    <div align="right">City: </div>
			                  </td>
	<td>

	<input type="text" class="normbodytext" name="txtCity" id="txtCity" MaxLength="100" Size="50" Value="<%=City%>">

	</td>
	</tr><tr>
	

	 <td width="25%" class="linkbold" valign="middle" height="14" bgcolor="#CCCCCC"> 
			                    <div align="right">State: </div>
			                  </td>

	
	<td>


	<%


	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")



	With oCmd

	     .CommandText = "sel_Province_all"
	     .CommandType = 4


	     .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)


	End With




	oConn.Open strDbConnString

	oCmd.ActiveConnection = oConn


	oRs.CursorLocation = 3

	oRs.Open oCmd, , 0, 1




	If oConn.Errors.Count < 1 then

		%>
		<select name="txtProvinceID" class="normbodytext">

		<%
		if bSubmitted = "" then
		
			while oRs.EOF = FALSE
			%>
				<option value="<%=oRs("ProvinceID")%>"><%=oRs("Prv_Name")%>
			<%
				oRs.MoveNext
		
			wend
		
		else
		
			while oRs.EOF = FALSE
			
				if CInt(oRs("ProvinceID")) = CInt(ProvinceID) then
				
			
				%>
					<option value="<%=oRs("ProvinceID")%>" selected><%=oRs("Prv_Name")%>
				<%
				else
			%>
					<option value="<%=oRs("ProvinceID")%>"><%=oRs("Prv_Name")%>
			<%
				end if
			
				oRs.MoveNext
		
			wend
		
		
		end if

	end if

	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRs = Nothing

	%>

	</select>

	</td>
	</tr><tr>
	 <td width="25%" class="linkbold" valign="middle" height="14" bgcolor="#CCCCCC"> 
			                    <div align="right">Postal Code: </div>
			                  </td>
	<td>

	<input type="text" class="normbodytext" name="txtPostalCode" id="txtPostalCode" MaxLength="5" size="5" Value="<%=PostalCode%>">

	</td>
	</tr>
	</table>
			
</td>
</tr>
</table>


<br><br>
<table BORDER="0" cellpadding="3" cellspacing="0" width="91%">

<input type="hidden" name="txtNoOfTests" id="txtNoOfTests" value="<%=nTestCount%>">
<%

oTestsRs.MoveFirst

%>
<tr bgcolor="#999999"> 
  <td width="22%" class="linkbold" valign="middle" height="14" bgcolor="#999999"> 
    <div align="left">Profile Name</div>
  </td>
  <td width="43%" valign="middle" height="14" class="normbodytext"> 
    <div align="left" class="linkbold">Description</div>
  </td>
  <td width="17%" valign="middle" height="14" class="normbodytext"> 
    <div align="left" class="linkbold">Price</div>
  </td>
  <td width="18%" valign="middle" height="14" class="normbodytext"> 
    <div align="left" class="linkbold">Qty</div>
  </td>
</tr>
<%

nCount = 1 

do while oTestsRs.EOF = FALSE

	Response.Write "<TR  bgcolor='#CCCCCC'>"

	%>
	<td width="22%" valign="middle" height="11"> 
    <% if UCase(oTestsRs("TestCodePrefix")) = "SELL" OR UCase(oTestsRs("TestCodePrefix")) = "COMM" OR UCase(oTestsRs("TestCodePrefix")) = "LEAD" OR UCase(oTestsRs("TestCodePrefix")) = "TIME" OR UCase(oTestsRs("TestCodePrefix")) = "TEAM" then %>
		<div align="left" class="normbodytext">*&nbsp;<%=oTestsRs("TestName")%></div>
	<% else %>
		<div align="left" class="normbodytext"><%=oTestsRs("TestName")%></div>
	<% end if %>
    </td>
    
    <td width="22%" valign="middle" height="11"> 
    <div align="left" class="normbodytext"><%=oTestsRs("ShortDesc")%></div>
    </td>
    
    <td width="22%" valign="middle" height="11"> 
    <div align="left" class="normbodytext"><%=FormatCurrency(oTestsRs("TestPrice"),2)%></div>
    
    <%                  
	Response.Write "<input type='hidden' class='normbodytext' name='txtTRTestID" & nCount & "' id='txtTRTestID" & nCount & "' Value=" & oTestsRs("TRTestID") & ">"
	Response.Write "<input type='hidden' class='normbodytext' name='txtTestPrice" & nCount & "' id='txtTestPrice" & nCount & "' Value=" & oTestsRs("TestPrice") & ">"

	Response.Write "</TD>"
	 
    Response.Write "<td width='22%' valign='middle' height='11'><div align='left' class='normbodytext'>"
	
	Response.Write "<input type='text' class='normbodytext' name='txtNoTestsPurchased" & nCount & "' id='txtNoTestsPurchased" & nCount & "' MaxLength=4 Size=4 Value='" & NoTestsPurchased(nCount) & "' onChange='calctotal()'>"

	Response.Write "</TD>"

	Response.Write "</TR>"

	oTestsRs.MoveNext

	nCount = nCount + 1

Loop

Response.Write "<TR  bgcolor='#CCCCCC'>"
	Response.Write "<TD  class='linkbold' align='right' COLSPAN=2>Total - in US Dollars"
	Response.Write "</TD>"
	Response.Write "<TD><input type='button' class='normbodytext' value='Calculate' onClick='calctotal' id='button'1 name='button'1>"
	Response.Write "</TD>"
	
	Response.Write "<TD  ><input type='text' READONLY class='normbodytext' align='right' size='10' name='txtTotalAmount' id='txtTotalAmount' Value='" & TotalAmount & "'>"
	Response.Write "</TD>"
Response.Write "</TR>"


Response.Write "</TABLE>"
%>
<br>
<font class="normbodytext">* - To create report this requires a completed PDI Profile. </font>
<%
'Response.Write "Total "

'Response.Write "<input type='text' name='txtTotal' id='txtTotal' MaxLength=5 Size=5>"

Response.Write "<br><br>"




%>







<input type="hidden" name="txtSubmit" id="txtSubmit" value="1">

<input type="submit" class="normbodytext" border="0" value="Purchase" id="add" name="add">

</form>

<script>	

function calctotal()
{
	
	var mynumber;
	var mynumberformatted;
	
	mynumber = 0
	
	<%	
	oTestsRs.MoveFirst
	
	nCount = 1 
	
	while oTestsRs.EOF = FALSE 
	%>
	
	mynumber = mynumber + document.thisForm.txtNoTestsPurchased<%=nCount%>.value * document.thisForm.txtTestPrice<%=nCount%>.value;
		
	<% 
	
	nCount = nCount + 1 
	
	oTestsRs.MoveNext
	
	wend 
	
	%>	
	
	mynumberformatted = new NumberFormat(mynumber);
		
	mynumberformatted.setCurrency(false);
		
	document.thisForm.txtTotalAmount.value = mynumberformatted.toFormatted();
	
	//document.thisForm.txtTotalAmount.value = myround(document.thisForm.txtNoTestsPurchased.value * document.thisForm.txtTestPrice.value,2);
		
}

/*
 * NumberFormat 1.0.3
 * v1.0.3 - 23-March-2002
 * v1.0.2 - 13-March-2002
 * v1.0.1 - 20-July-2001
 * v1.0.0 - 13-April-2000
 * http://www.mredkj.com
 */
 
/*
 * NumberFormat -The constructor
 * num - The number to be formatted
 */
function NumberFormat(num)
{

	// member variables
	this.num;
	this.numOriginal;
	this.isCommas;
	this.isCurrency;
	this.currencyPrefix;
	this.places;

	// external methods
	this.setNumber = setNumberNF;
	this.toUnformatted = toUnformattedNF;
	this.setCommas = setCommasNF;
	this.setCurrency = setCurrencyNF;
	this.setCurrencyPrefix = setCurrencyPrefixNF;
	this.setPlaces = setPlacesNF;
	this.toFormatted = toFormattedNF;
	this.getOriginal = getOriginalNF;

	// internal methods
	this.getRounded = getRoundedNF;
	this.preserveZeros = preserveZerosNF;
	this.justNumber = justNumberNF;

	// setup defaults
	this.setNumber(num);
	this.setCommas(true);
	this.setCurrency(true);
	this.setCurrencyPrefix('$');
	this.setPlaces(2);
}

/*
 * setNumber - Sets the number
 * num - The number to be formatted
 */
function setNumberNF(num)
{
	this.numOriginal = num;
	this.num = this.justNumber(num);
}

/*
 * toUnformatted - Returns the number as just a number.
 * If the original value was '100,000', then this method will return the number 100000
 * v1.0.2 - Modified comments, because this method no longer returns the original value.
 */
function toUnformattedNF()
{
	return (this.num);
}

/*
 * getOriginal - Returns the number as it was passed in, which may Include non-number characters.
 * This function is new in v1.0.2
 */
function getOriginalNF()
{
	return (this.numOriginal);
}

/*
 * setCommas - Sets a switch that indicates if there should be commas
 * isC - true, if should be commas; false, if no commas
 */
function setCommasNF(isC)
{
	this.isCommas = isC;
}

/*
 * setCurrency - Sets a switch that indicates if should be displayed as currency
 * isC - true, if should be currency; false, if not currency
 */
function setCurrencyNF(isC)
{
	this.isCurrency = isC;
}

/*
 * setCurrencyPrefix - Sets the symbol that precedes currency.
 * cp - The symbol
 */
function setCurrencyPrefixNF(cp)
{
	this.currencyPrefix = cp;
}

/*
 * setPlaces - Sets the precision of decimal places
 * p - The number of places. Any number of places less than or equal to zero is considered zero.
 */
function setPlacesNF(p)
{
	this.places = p;
}

/*
 * toFormatted - Returns the number formatted according to the settings (a string)
 */
function toFormattedNF()
{
	var pos;
	var nNum = this.num; // v1.0.1 - number as a number
	var nStr;            // v1.0.1 - number as a string

	// round decimal places
	nNum = this.getRounded(nNum);
	nStr = this.preserveZeros(Math.abs(nNum)); // this step makes nNum into a string. v1.0.1 Math.abs

	if (this.isCommas)
	{
		pos = nStr.indexOf('.');
		if (pos == -1)
		{
			pos = nStr.length;
		}
		while (pos > 0)
		{
			pos -= 3;
			if (pos <= 0) break;
			nStr = nStr.substring(0,pos) + ',' + nStr.substring(pos, nStr.length);
		}
	}
	
	nStr = (nNum < 0) ? '-' + nStr : nStr; // v1.0.1

	if (this.isCurrency)
	{
		// add dollar sign in front
		nStr = this.currencyPrefix + nStr;
	}

	return (nStr);
}

/*
 * getRounded - Used internally to round a value
 * val - The number to be rounded
 */
function getRoundedNF(val)
{
	var factor;
	var i;

	// round to a certain precision
	factor = 1;
	for (i=0; i<this.places; i++)
	{	factor *= 10; }
	val *= factor;
	val = Math.round(val);
	val /= factor;

	return (val);
}

/*
 * preserveZeros - Used internally to make the number a string
 * 	that preserves zeros at the end of the number
 * val - The number
 */
function preserveZerosNF(val)
{
	var i;

	// make a string - to preserve the zeros at the end
	val = val + '';
	if (this.places <= 0) return val; // leave now. no zeros are necessary - v1.0.1 less than or equal
	
	var decimalPos = val.indexOf('.');
	if (decimalPos == -1)
	{
		val += '.';
		for (i=0; i<this.places; i++)
		{
			val += '0';
		}
	}
	else
	{
		var actualDecimals = (val.length - 1) - decimalPos;
		var difference = this.places - actualDecimals;
		for (i=0; i<difference; i++)
		{
			val += '0';
		}
	}
	
	return val;
}

/*
 * justNumber - Used internally to parse the value into a floating point number.
 * If the value is not set, then return 0.
 * If the value is not a number, then replace all characters that are not 0-9, a decimal point, or a negative sign.
 *
 *  Note: The regular expression cleans up the number, but doesn't get rid of - and .
 *  Because all negative signs and all decimal points are allowed,
 *  extra negative signs or decimal points may corrupt the result.
 *  parseFloat will ignore all values after any character that is NaN.
 *
 *  A number can be entered using special notation.
 *  For example, the following is a valid number: 0.0314E+2
 *
 * This function is new in v1.0.2
 */
function justNumberNF(val)
{
	val = (val==null) ? 0 : val;

	// check if a number, otherwise try taking out non-number characters.
	if (isNaN(val))
	{
		var newVal = parseFloat(val.replace(/[^\d\.\-]/g, ''));

		// check if still not a number. Might be undefined, '', etc., so just replace with 0.
		// v1.0.3
		return (isNaN(newVal) ? 0 : newVal); 
	}
	// return 0 in place of infinite numbers.
	// v1.0.3
	else if (!isFinite(val))
	{
		return 0;
  }
	
	return val;
}




</script>
</body>

</html>

