<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 2	' userRegistration Page
	isDebugOn = False
	'isDebugOn = True
%>
<!--#Include file="Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=65001">
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
	<!--#Include file="Include/HeadStuff.asp" -->
</head>
<body>
<!--#Include file="Include/TopBanner.asp" -->

<div id="maincontent">
<%
	'=========================================================================================
	' Initialize variables
	'=========================================================================================
		' Objects for database operations
			Dim oConn, oCmd
		' Pageflow related data
			Dim bFilledOutProperly : bFilledOutProperly = FALSE
			Dim bSubmitted	: bSubmitted = Request.Form ("txtSubmit")
			If bSubmitted <> "" Then
				bSubmitted = CInt(bSubmitted)
			End If
			Dim strErrMsg
		' System data (and everything else... mg)
			Dim nCount
		' Form Variables
			Dim UserName, Password, PasswordConfirm
			Dim FirstName, LastName, EmailAddress
			Dim CompanyName
			Dim Address1, Address2, City, ProvinceID, PostalCode
			Dim Position, Department, TeamName
			Dim GenderValue, AgeValue, EducationValue, OccupationValue, MgtRespValue
		' Arrays for option lists
			Dim Gender(2) '-------------------------------------------
				Gender(1) = strTextMale
				Gender(2) = strTextFemale
			Dim Age(6) '-------------------------------------------
				Age(1) = "18-25"
				Age(2) = "26-35"
				Age(3) = "36-45"
				Age(4) = "46-55"
				Age(5) = "56-65"
				Age(6) = strTextOver & " 65"
			Dim Education(6) '-------------------------------------------
				Education(1) = strTextSomeHighSchool
				Education(2) = strTextHighSchoolGraduate
				Education(3) = strTextSomeCollege
				Education(4) = strTextCollegeGraduate
				Education(5) = strTextSomeGraduateSchool
				Education(6) = strTextPostGraduateDegree
			Dim Occupation(20) '-------------------------------------------
				Occupation(1) = strTextAccountingFinance
				Occupation(2) = strTextComputerRelated
				Occupation(3) = strTextConsulting
				Occupation(4) = strTextCustomerService
				Occupation(5) = strTextEducationTraining
				Occupation(6) = strTextEngineering
				Occupation(7) = strTextSeniorManagement
				Occupation(8) = strTextAdministrative
				Occupation(9) = strTextGovernmentMilitary
				Occupation(10) = strTextHomemaker
				Occupation(11) = strTextManufacturing
				Occupation(12) = strTextMedicalLegal
				Occupation(13) = strTextRetired
				Occupation(14) = strTextMarketingAdvising
				Occupation(15) = strTextSelfEmployedOwner
				Occupation(16) = strTextSales
				Occupation(17) = strTextTradesmanCraftsman
				Occupation(18) = strTextStudent
				Occupation(19) = strTextBetweenJobs
				Occupation(20) = strTextOther
			Dim MgtResp(2) '-------------------------------------------
				MgtResp(1) = Application("strTextYes" & strLanguageCode)
				MgtResp(2) = Application("strTextNo" & strLanguageCode)

	'=========================================================================================
	'  Receive and validate incomming form data
	'=========================================================================================
		strErrMsg = ""
		If bSubmitted = 1 Then
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
InStr(1,CStr(EmailAddress),".",1) = 0
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

If isDebugOn Then
	Response.Write "<br>Exec spRegistrationInsert '" & UserName & "', '" & Password & "', '" & FirstName & "', '" & LastName & "', '" & EmailAddress & "', '" & CompanyName & "', '" & Address1 & "', '" & Address2 & "', '" & City & "', " & ProvinceID & ", '" & PostalCode & "', '" & Position & "', '" & Department & "', '" & TeamName & "', '" & GenderValue & "', " & AgeValue & ", " & EducationValue & ", " & OccupationValue & ", '" & MgtRespValue & "', " & cInt(intResellerID) & ", " & CLng(UserID)
End If

	'=========================================================================================
	'  If postback and the data is good - write to the database
	'=========================================================================================
		If bSubmitted <> "" AND bFilledOutProperly Then
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
				Response.Redirect("main.asp?newuser=1&res=" & intResellerID )
			Else
				Dim strError
				strError = FormatSQLError(Err.description)
				If InStr(1,strError,"DUPEMAIL") <> 0 Then
					strErrMsg = "The email address entered already exists for a registered user in the system. Please try again."
				Else
					strErrMsg = strError
					If IsDebugOn Then
						Response.Write ("@UserName = " & UserName & "<br>")
						Response.Write ("@Password = " & Password & "<br>")
						Response.Write ("@FirstName = " & FirstName & "<br>")
						Response.Write ("@LastName = " & LastName & "<br>")
						Response.Write ("@EmailAddress = " & EmailAddress & "<br>")
						Response.Write ("@CompanyName = " & CompanyName & "<br>")
						Response.Write ("@Address1 = " & Address1 & "<br>")
						Response.Write ("@Address2 = " & Address2 & "<br>")
						Response.Write ("@City = " & City & "<br>")
						Response.Write ("@ProvinceID = " & ProvinceID & "<br>")
						Response.Write ("@PostalCode = " & PostalCode & "<br>")
						Response.Write ("@Position = " & Position & "<br>")
						Response.Write ("@Department = " & Department & "<br>")
						Response.Write ("@TeamName = " & TeamName & "<br>")
						Response.Write ("@Gender = " & GenderValue & "<br>")
						Response.Write ("@Age = " & AgeValue & "<br>")
						Response.Write ("@Education = " & EducationValue & "<br>")
						Response.Write ("@Occupation = " & OccupationValue & "<br>")
						Response.Write ("@MgtResp = " & MgtRespValue & "<br>")
						Response.Write ("@ResellerID = " & intResellerID & "<br>")
					End If
				End If
				Err.Clear
			End If
			Set oConn = Nothing
			Set oCmd = Nothing
		End If
%>
<h1><%=strTextPageTitle%></h1>
<form name="thisForm" id="thisForm" method="post" action="UserRegistration.asp?res=<%=intResellerID%>">
<input type="hidden" name="txtSubmit" id="txtSubmit" value="1">
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr>
	  	<td valign="middle" colspan="2">
<%
	Response.Write VbTab & "<span class=""headertext2"">" & Application("StrTextUserInformation" & stLanguageCode) & "</span><br>" & VbCrLf
	Response.Write StrTextPleaseEnterInformationUserRegistration
	Response.Write "</td>"
	Response.Write "</tr>"
	If strErrMsg <> "" Then
		Response.Write "<tr><td valign=""middle"" colspan=""2"">"
		Response.Write "<span class=""errortext"">" & strErrMsg & "</span>"
		Response.Write "</td></tr>"
	End If
	%>
	<tr>
	  	<td valign="middle" align="right" width="35%"><span class="required">*&nbsp;</span><strong><%=strTextChooseAUsername%>:</strong></td>
	  	<td valign="middle" width="65%"><input type="text" name="txtUserName" id="txtUserName" MaxLength="50" Size="15" Value="<%=UserName%>"></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong><%=strTextChooseAPassword%>:</strong></td>
	  	<td valign="middle"><input type="password" name="txtPassword" id="txtPassword" MaxLength="50" Size="15" Value="<%=Password%>">&nbsp;&nbsp;&nbsp;(<%=strTextMustBeAtLeast6Characters%>)</td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong><%=strTextRetypePassword%>:</strong></td>
	  	<td valign="middle"><input type="password" name="txtPasswordConfirm" id="txtPasswordConfirm" MaxLength="50" Size="15" Value="<%=PasswordConfirm%>"></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong><%=strTextFirstName%>:</strong></td>
	  	<td valign="middle"><input type="text" name="txtFirstName" id="txtFirstName" MaxLength="100" Size="50" Value="<%=FirstName%>"></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong><%=strTextLastName%>:</strong></td>
	  	<td valign="middle"><input type="text" name="txtLastName" id="txtLastName" MaxLength="100" Size="50" Value="<%=LastName%>"></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong><%=strTextEmailAddress%>:</strong></td>
	  	<td valign="middle"><input type="text" name="txtEmailAddress" id="txtEmailAddress" MaxLength="100" Size="50" Value="<%=EmailAddress%>"></td>
	</tr>
</table>
<span class="required">*&nbsp;<%=strTextRequired%></span>
<br><br>
<!--#Include file="Include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr>
		<td valign="middle" colspan="2">
	  		<span class="headertext2"><%=strTextOrganizationalInformation%></span><br>
			<p><%=strTextIfYourOrganizationHasAnAccount%></p>
		</td>
	</tr>
	<tr>
		<td valign="middle" align="right" width="35%"><span class="required">**&nbsp;</span><strong><%=strTextOrganization & " " & strTextName%>:</strong></td>
		<td valign="middle" width="65%"><input type="text" name="txtCompanyName" id="txtCompanyName" MaxLength="100" Size="50" Value="<%=CompanyName%>"></td>
	</tr>
	<tr>
		<td valign="middle" align="right"><span class="required">**&nbsp;</span><strong><%=strTextOrganization & " " & strTextAddress%>:</strong></td>
		<td valign="middle"><input type="text" name="txtAddress1" id="txtAddress1" MaxLength="100" Size="50" Value="<%=Address1%>"></td>
	</tr>
	<tr>
		<td valign="middle" align="right"><strong><%=strTextAddress%>:</strong></td>
		<td valign="middle"><input type="text" name="txtAddress2" id="txtAddress2" MaxLength="100" Size="50" Value="<%=Address2%>"></td>
	</tr>
	<tr>
		<td valign="middle" align="right"><span class="required">**&nbsp;</span><strong><%=strTextCity%>:</strong></td>
		<td valign="middle"><input type="text" name="txtCity" id="txtCity" MaxLength="100" Size="50" Value="<%=City%>"></td>
	</tr>
	<tr>
		<td valign="middle" align="right"><span class="required">**&nbsp;</span><strong><%=strTextStateProvince%>:</strong></td>
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
			If oConn.Errors.Count < 1 then
				if bSubmitted = "" then
					while oRs.EOF = FALSE
						Response.Write("<option value=""" & oRs("ProvinceID") & """>" & oRs("Prv_Name") & "</option>")
						oRs.MoveNext
					wend
				else
					while oRs.EOF = FALSE
						if CInt(oRs("ProvinceID")) = CInt(ProvinceID) then
							Response.Write("<option value=""" & oRs("ProvinceID") & """ selected>" & oRs("Prv_Name") & "</option>")
						else
							Response.Write("<option value=""" & oRs("ProvinceID") & """>" & oRs("Prv_Name") & "</option>")
						end if
						oRs.MoveNext
					wend
				end if
			end if
			Set oConn = Nothing : Set oCmd = Nothing : Set oRs = Nothing
			%>
			</select>
	  	</td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><span class="required">**&nbsp;</span><strong><%=strTextZipPostalCode%>:</strong></td>
	  	<td valign="middle"><input type="text" name="txtPostalCode" id="txtPostalCode" MaxLength="5" Size="5" Value="<%=PostalCode%>"></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong><%=strTextPosition%>:</strong></td>
	  	<td valign="middle"><input type="text" name="txtPosition" id="txtPosition" MaxLength="100" Size="50" Value="<%=Position%>"></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong><%=strTextDepartment%>:</strong></td>
	  	<td valign="middle"><input type="text" name="txtDepartment" id="txtDepartment" MaxLength="100" Size="50" Value="<%=Department%>"></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong><%=strTextTeam & " " & strTextName%>:</strong></td>
	  	<td valign="middle"><input type="text" name="txtTeamName" id="txtTeamName" MaxLength="100" Size="50" Value="<%=TeamName%>"></td>
	</tr>
</table>
<span class="required">**&nbsp;<%=strTextRequiredIfOrganizationNameIsEntered%></span>
<br><br>
<!--#Include FILE="Include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">	
	<tr> 
	  	<td valign="middle" colspan="2">
	  		<span class="headertext2"><strong><%=strTextOptionalDemographicInformation%></strong></span><br />
			<%=strtextDemographicsWillBeUsedForResearchPurposes%>
	  	</td>
	</tr>
	<tr>
	  	<td valign="middle" align="right" width="35%"><strong><%=strTextGender%>:</strong></td>
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
	  	<td valign="middle" align="right"><strong><%=strTextAge%>:</strong></td>
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
	  	<td valign="middle" align="right"><strong><%=strTextEducation%>:</strong></td>
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
	  	<td valign="middle" align="right"><strong><%=strTextOccupation%>:</strong></td>
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
	  	<td valign="middle" align="right"><strong><%=strTextDoYouHaveManagementResponsibilities%>?</strong></td>
	  	<td valign="middle">
	  		<select name="txtMgtResp">
<%
				Response.Write("<option value=""0"">")
				For nCount = 1 To 2
					If CInt(nCount) = CInt(MgtRespValue) Then
						Response.Write("<option value=""" & nCount & """ SELECTED>" & MgtResp(nCount) & "</option>")
					Else
						Response.Write("<option value=""" & nCount & """>" & MgtResp(nCount) & "</option>")
					End If
				Next
%>
			</select>
		</td>
	</tr>
</table>
<!--#Include FILE="Include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="100%">
	<tr>
	  	<td valign="top"><%=strTextCheckOur%> <a href="PrivacyPolicy.asp?res=<%=intResellerID%>"><%=Application("strTextPrivacyPolicy" & strLanguageCode)%></a></td>
	  	<td valign="top" align="right"><input type="submit" border="0" value="<%=strTextRegister%>" id="add" name="add"></td>
	</tr>
</table>
</form>
</div>
</body>
</html>