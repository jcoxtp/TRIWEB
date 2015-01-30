<%@ Language=VBScript Codepage = 65001%>
<!--#Include FILE="Include/Common.asp" -->
<% pageID = "register" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Register</title>
	<link rel="stylesheet" href="Include/Default.css" type="text/css"><link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css
" type="text/css">
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
	<!--#Include FILE="Include/HeadStuff.asp" -->
</head>
<body>
<!--#Include FILE="Include/TopBanner.asp" -->

<div id="maincontent">
<%'=======================================================================================================
On Error Resume Next

	'=========================================================================================
	' Initialize variables
	'=========================================================================================
		'Objects for database operations
		Dim oConn, oCmd
		
		'Pageflow related data
		Dim bFilledOutProperly : bFilledOutProperly = FALSE
		Dim bSubmitted
		bSubmitted = Request.Form ("txtSubmit")
		If bSubmitted <> "" Then
			bSubmitted = CInt(bSubmitted)
		End If
		Dim strErrMsg
	
		'System data (and everything else... mg)
		Dim nCount
	
		'Form Variables
		Dim UserName, Password, PasswordConfirm
		Dim FirstName, LastName, EmailAddress
		Dim CompanyName
		Dim Address1, Address2, City, ProvinceID, PostalCode
		Dim Position, Department, TeamName
		Dim GenderValue, AgeValue, EducationValue, OccupationValue, MgtRespValue
	
		'-- Include registration demographic data -----------------------------------
		'- for some reason all the demographic data was hard coded into the asp pages
		'- its still working for the most part so we are waiting to change this until 
		'- it can be incorporated into new feature requests : mg 2/16/2004
		%><!--#Include FILE="UserRegistration_demographic_data.asp" --><%

	'=========================================================================================
	'  Receive and validate incomming form data
	'=========================================================================================
		strErrMsg = ""
		If bSubmitted = 99 Then
			ResetCookies
			'-- User Info---------------------
			UserName = Request.Form("txtUserName") : UserName = Trim(UserName)
				If UserName = "" Then strErrMsg = strErrMsg & "Please enter a value for: <strong>Username</strong><br>"
			Password = Request.Form("txtPassword") : Password = Trim(Password)
			PasswordConfirm = Request.Form("txtPasswordConfirm") : PasswordConfirm = Trim(PasswordConfirm)
				If Password = "" Then strErrMsg = "Please enter a value for: <strong>Password</strong><br>"
				If PasswordConfirm <> Password Then strErrMsg = strErrMsg &  "Password and Retype Password values do not match. Please try again.<br>"
				If Len(Password) < 6 Then strErrMsg = strErrMsg & "Password must be at least 6 characters in length.<br>"
			FirstName = Request.Form("txtFirstName") : FirstName = Trim(FirstName)
				If FirstName = "" Then strErrMsg = strErrMsg & "Please enter a value for: <strong>First Name</strong><br>"
			LastName = Request.Form("txtLastName") : LastName = Trim(LastName)
				If LastName = "" Then strErrMsg = strErrMsg & "Please enter a value for: <strong>Last Name</strong><br>"
			EmailAddress = Request.Form("txtEmailAddress") : EmailAddress = Trim(EmailAddress)
				If EmailAddress = "" Then strErrMsg = strErrMsg & "Please enter a value for: <strong>Email Address</strong><br>"
				If InStr(1,CStr(EmailAddress),"@",1) = 0 Then strErrMsg = strErrMsg & "Please enter a proper email address"
				If InStr(1,CStr(EmailAddress),".",1) = 0 Then strErrMsg = strErrMsg & "Please enter a proper email address"
			'-- Company Info ---------------------
			CompanyName = Request.Form("txtCompanyName") : CompanyName = Trim(CompanyName)
			Address1 = Request.Form("txtAddress1") : Address1 = Trim(Address1)
			Address2 = Request.Form("txtAddress2") : Address2 = Trim(Address2)
			City = Request.Form("txtCity") : City = Trim(City)
			ProvinceID = Request.Form("txtProvinceID") : ProvinceID = Trim(ProvinceID)
			PostalCode = Request.Form("txtPostalCode") : PostalCode = Trim(PostalCode)
			Country = Request.Form("txtCountry") : Country = Trim(Country)
			Position = Request.Form("txtPosition") : Position = Trim(Position)
			Department = Request.Form("txtDepartment") : Department = Trim(Department)
			TeamName = Request.Form("txtTeamName") : TeamName = Trim(TeamName)
				If (CompanyName <> "" or Address1 <> "" or City <> "" or PostalCode <> "") Then
					If CompanyName = "" Then strErrMsg = strErrMsg & "Please enter a value for: <strong>Organization Name</strong><br>"
					If Address1 = "" Then strErrMsg = strErrMsg & "Please enter a value for: <strong>Organization Address</strong><br>"
					If City = "" Then strErrMsg = strErrMsg & "Please enter a value for: <strong>City</strong><br>"
					If ProvinceID = "" Then strErrMsg = strErrMsg & "Please enter a value for: <strong>State</strong><br>"
					If PostalCode = "" Then strErrMsg = strErrMsg & "Please enter a value for: <strong>Zip Code</strong><br>"
				End If
			'-- Demographics ---------------------
			GenderValue = Request.Form("txtGender")
				If GenderValue = 1 Then
					GenderValue = "M"
				ElseIf GenderValue = 2 Then
					GenderValue = "F"
				Else
					GenderValue = ""
				End If
			AgeValue = Request.Form("txtAge")
			EducationValue = Request.Form("txtEducation")
			OccupationValue = Request.Form("txtOccupation")
			MgtRespValue = Request.Form("txtMgtResp")
				If MgtRespValue = 1 Then
					MgtRespValue = "Y"
				ElseIf MgtRespValue = 2 Then
					MgtRespValue = "N"
				Else
					MgtRespValue = ""
				End If
			'-- Check for an error message ----------------
			If strErrMsg = "" Then
				bFilledOutProperly = TRUE
			End If
		End If
	
	'=========================================================================================
	'  If postback and the data is good - write to the database
	'=========================================================================================
		If bSubmitted = 99 AND bFilledOutProperly Then
			CompanyNameRet = ""
			Set oConn = CreateObject("ADODB.Connection")
			Set oCmd = CreateObject("ADODB.Command")
			With oCmd
				.CommandText = "spRegistrationInsert"
				.CommandType = 4
				.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				'-- User Info---------------------
				.Parameters.Append .CreateParameter("@UserName",200, 1,50, UserName)
				.Parameters.Append .CreateParameter("@Password",200, 1,50, Password)
				.Parameters.Append .CreateParameter("@FirstName",200, 1,100, FirstName)
				.Parameters.Append .CreateParameter("@LastName",200, 1,100, LastName)
				.Parameters.Append .CreateParameter("@EmailAddress",200, 1,100, EmailAddress)
				'-- Company Info ---------------------
				.Parameters.Append .CreateParameter("@CompanyName",200, 1,100, CompanyName)
				.Parameters.Append .CreateParameter("@Address1",200, 1,100, Address1)
				.Parameters.Append .CreateParameter("@Address2",200, 1,100, Address2)
				.Parameters.Append .CreateParameter("@City",200, 1,100, City)
				.Parameters.Append .CreateParameter("@ProvinceID",3, 1,4, ProvinceID)
				.Parameters.Append .CreateParameter("@PostalCode",200, 1,50, PostalCode)
				.Parameters.Append .CreateParameter("@Position",200, 1,100, Position)
				.Parameters.Append .CreateParameter("@Department",200, 1,100, Department)
				.Parameters.Append .CreateParameter("@TeamName",200, 1,100, TeamName)
				'-- Demographics ---------------------
				.Parameters.Append .CreateParameter("@Gender",129, 1,1, GenderValue)
				.Parameters.Append .CreateParameter("@Age",3, 1,4, AgeValue)
				.Parameters.Append .CreateParameter("@Education",3, 1,4, EducationValue)
				.Parameters.Append .CreateParameter("@Occupation",3, 1,4, OccupationValue)
				.Parameters.Append .CreateParameter("@MgtResp",129, 1,1, MgtRespValue)
				'-- Other ---------------------
				.Parameters.Append .CreateParameter("@ResellerID",3, 1, 4, cInt(intResellerID))
				'-- Returning Parameters ----------
				.Parameters.Append .CreateParameter("@UserID",3, 3,4, CLng(UserID))
			End With
			oConn.Open strDbConnString
			oCmd.ActiveConnection = oConn
			oCmd.Execute , , 128
			If oConn.Errors.Count < 1 Then
				UserID = oCmd.Parameters("@UserID").value
				Response.Cookies("UserID") = UserID
				Response.Cookies("Login") = 1
				Response.Cookies("FirstName") = FirstName
				If intResellerID = 10 Then
					Response.Redirect("PurchaseDGBypass.asp?res=" & intResellerID)
				Else
					Response.Redirect("main.asp?newuser=1&res=" & intResellerID)
				End If
			Else
				Dim strError
				strError = FormatSQLError(Err.description)
				If InStr(1,strError,"DUPEMAIL") <> 0 Then
					strErrMsg = "The email address entered already exists for a registered user in the system. Please try again."
				Else
					strErrMsg = strError
'					Response.Write ("@UserName = " & UserName & "<br>")
'					Response.Write ("@Password = " & Password & "<br>")
'					Response.Write ("@FirstName = " & FirstName & "<br>")
'					Response.Write ("@LastName = " & LastName & "<br>")
'					Response.Write ("@EmailAddress = " & EmailAddress & "<br>")
'					Response.Write ("@CompanyName = " & CompanyName & "<br>")
'					Response.Write ("@Address1 = " & Address1 & "<br>")
'					Response.Write ("@Address2 = " & Address2 & "<br>")
'					Response.Write ("@City = " & City & "<br>")
'					Response.Write ("@ProvinceID = " & ProvinceID & "<br>")
'					Response.Write ("@PostalCode = " & PostalCode & "<br>")
'					Response.Write ("@Position = " & Position & "<br>")
'					Response.Write ("@Department = " & Department & "<br>")
'					Response.Write ("@TeamName = " & TeamName & "<br>")
'					Response.Write ("@Gender = " & GenderValue & "<br>")
'					Response.Write ("@Age = " & AgeValue & "<br>")
'					Response.Write ("@Education = " & EducationValue & "<br>")
'					Response.Write ("@Occupation = " & OccupationValue & "<br>")
'					Response.Write ("@MgtResp = " & MgtRespValue & "<br>")
'					Response.Write ("@ResellerID = " & intResellerID & "<br>")
				End If
				Err.Clear
			End If
			Set oConn = Nothing
			Set oCmd = Nothing
		End If
%>
<h1>New User Registration</h1>
<form name="thisForm" id="thisForm" method="post" action="UserRegistration.asp?res=<%=intResellerID%>">
<input type="hidden" name="txtSubmit" id="txtSubmit" value="99">
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr> 
	  	<td valign="middle" colspan="2">
	  		<span class="headertext2">User Information</span><br>
			Please enter your information in the fields below, and click "Register" at the bottom of this page.
	  	</td>
	</tr>
	<%
		If strErrMsg <> "" Then
			Response.Write("<tr><td valign=""middle"" colspan=""2"">")
			Response.Write("<span class=""errortext"">" & strErrMsg & "</span>")
			Response.Write("</td></tr>")
		End If 
	%>
	<tr> 
	  	<td valign="middle" align="right" width="35%"><span class="required">*&nbsp;</span><strong>Choose a Username:</strong></td>
	  	<td valign="middle" width="65%"><input type="text" name="txtUserName" id="txtUserName" MaxLength="50" Size="15" Value="<%=UserName%>"></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong>Choose a Password:</strong></td>
	  	<td valign="middle"><input type="password" name="txtPassword" id="txtPassword" MaxLength="50" Size="15" Value="<%=Password%>">&nbsp;&nbsp;&nbsp;(Must be at least 6 characters)</td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong>Retype Password:</strong></td>
	  	<td valign="middle"><input type="password" name="txtPasswordConfirm" id="txtPasswordConfirm" MaxLength="50" Size="15" Value="<%=PasswordConfirm%>"></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong>First Name:</strong></td>
	  	<td valign="middle"><input type="text" name="txtFirstName" id="txtFirstName" MaxLength="100" Size="50" Value="<%=FirstName%>"></td>
	</tr>			
	<tr> 
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong>Last Name:</strong></td>
	  	<td valign="middle"><input type="text" name="txtLastName" id="txtLastName" MaxLength="100" Size="50" Value="<%=LastName%>"></td>
	</tr>		
	<tr> 
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong>Email Address:</strong></td>
	  	<td valign="middle"><input type="text" name="txtEmailAddress" id="txtEmailAddress" MaxLength="100" Size="50" Value="<%=EmailAddress%>"></td>
	</tr>
</table>
<span class="required">*&nbsp;Required</span>
<br><br>
<!--#Include FILE="Include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr> 
	  	<td valign="middle" colspan="2">
	  		<span class="headertext2">Organizational Information</span><br>
			<p>If your organization has an account with us, please fill out the fields below.</p>
	  	</td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right" width="35%"><span class="required">**&nbsp;</span><strong>Organization Name:</strong></td>
	  	<td valign="middle" width="65%"><input type="text" name="txtCompanyName" id="txtCompanyName" MaxLength="100" Size="50" Value="<%=CompanyName%>"></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><span class="required">**&nbsp;</span><strong>Organization Address:</strong></td>
	  	<td valign="middle"><input type="text" name="txtAddress1" id="txtAddress1" MaxLength="100" Size="50" Value="<%=Address1%>"></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>Address:</strong></td>
	  	<td valign="middle"><input type="text" name="txtAddress2" id="txtAddress2" MaxLength="100" Size="50" Value="<%=Address2%>"></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><span class="required">**&nbsp;</span><strong>City:</strong></td>
	  	<td valign="middle"><input type="text" name="txtCity" id="txtCity" MaxLength="100" Size="50" Value="<%=City%>"></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><span class="required">**&nbsp;</span><strong>State:</strong></td>
	  	<td valign="middle">
			<select name="txtProvinceID">
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
			If oConn.Errors.Count < 1 Then
				If bSubmitted = "" Then
					While oRs.EOF = False
						Response.Write("<option value=""" & oRs("ProvinceID") & """>" & oRs("Prv_Name") & "</option>")
						oRs.MoveNext
					Wend
				Else
					While oRs.EOF = False
						If CInt(oRs("ProvinceID")) = CInt(ProvinceID) Then
							Response.Write("<option value=""" & oRs("ProvinceID") & """ selected>" & oRs("Prv_Name") & "</option>")
						Else
							Response.Write("<option value=""" & oRs("ProvinceID") & """>" & oRs("Prv_Name") & "</option>")
						End If
						oRs.MoveNext
					Wend
				End If
			End If
			Set oConn = Nothing : Set oCmd = Nothing : Set oRs = Nothing
			%>
			</select>
	  	</td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><span class="required">**&nbsp;</span><strong>Zip Code:</strong></td>
	  	<td valign="middle"><input type="text" name="txtPostalCode" id="txtPostalCode" MaxLength="5" Size="5" Value="<%=PostalCode%>"></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>Position:</strong></td>
	  	<td valign="middle"><input type="text" name="txtPosition" id="txtPosition" MaxLength="100" Size="50" Value="<%=Position%>"></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>Department:</strong></td>
	  	<td valign="middle"><input type="text" name="txtDepartment" id="txtDepartment" MaxLength="100" Size="50" Value="<%=Department%>"></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>Team Name:</strong></td>
	  	<td valign="middle"><input type="text" name="txtTeamName" id="txtTeamName" MaxLength="100" Size="50" Value="<%=TeamName%>"></td>
	</tr>
</table>
<span class="required">**&nbsp;Required if organization name is entered</span>
<br><br>
<!--#Include FILE="Include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">	
	<tr> 
	  	<td valign="middle" colspan="2">
	  		<span class="headertext2"><strong>Optional Demographics</strong></span><br />
	  		Demographics will be used for research purposes only and will <strong>not</strong> be used for solicitation.			
	  	</td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right" width="35%"><strong>Gender:</strong></td>
	  	<td valign="middle" width="65%">
	  		<select name="txtGender">
			<%
				Response.Write("<option value=""0"">")
				for nCount = 1 to 2
					if CInt(nCount) = CInt(GenderValue) then 
						Response.Write("<option value=""" & nCount & """ SELECTED>" & Gender(nCount) & "</option>")
					else
						Response.Write("<option value=""" & nCount & """>" & Gender(nCount) & "</option>")
					end if
				next
			%>
			</select>
		</td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>Age:</strong></td>
	  	<td valign="middle">
	  		<select name="txtAge">
			<%
				Response.Write("<option value=""0"">")
				for nCount = 1 to 6
					if CInt(nCount) = CInt(AgeValue) then 
						Response.Write("<option value=""" & nCount & """ SELECTED>" & Age(nCount) & "</option>")
					else
						Response.Write("<option value=""" & nCount & """>" & Age(nCount) & "</option>")
					end if
				next
			%>
			</select>
		</td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>Education:</strong></td>
	  	<td valign="middle">
	  		<select name="txtEducation">
			<%
				Response.Write("<option value=""0"">")
				for nCount = 1 to 6
					if CInt(nCount) = CInt(EducationValue) then 
						Response.Write("<option value=""" & nCount & """ SELECTED>" & Education(nCount) & "</option>")
					else
						Response.Write("<option value=""" & nCount & """>" & Education(nCount) & "</option>")
					end if
				next
			%>
			</select>
		</td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>Occupation:</strong></td>
	  	<td valign="middle">
	  		<select name="txtOccupation">
			<%
				Response.Write("<option value=""0"">")
				for nCount = 1 to 20
					if CInt(nCount) = CInt(OccupationValue) then 
						Response.Write("<option value=""" & nCount & """ SELECTED>" & Occupation(nCount) & "</option>")
					else
						Response.Write("<option value=""" & nCount & """>" & Occupation(nCount) & "</option>")
					end if
				next
			%>
			</select>
		</td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><strong>Do you have management responsibility for others at work?</strong></td>
	  	<td valign="middle">
	  		<select name="txtMgtResp">
			<%
				Response.Write("<option value=""0"">")
				for nCount = 1 to 2
					if CInt(nCount) = CInt(MgtRespValue) then 
						Response.Write("<option value=""" & nCount & """ SELECTED>" & MgtResp(nCount) & "</option>")
					else
						Response.Write("<option value=""" & nCount & """>" & MgtResp(nCount) & "</option>")
					end if
				next
			%>
			</select>
		</td>
	</tr>
</table>
<!--#Include FILE="Include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="100%">
	<tr>
	  	<td valign="top">Check our <a href="PrivacyPolicy.asp?res=<%=intResellerID%>">Privacy Policy</a></td>
	  	<td valign="top" align="right"><input type="submit" border="0" value="Register" id="add" name="add"></td>
	</tr>
</table>
</form>
</div>
</body>
</html>
