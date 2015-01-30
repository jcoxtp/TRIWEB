<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 2	' userRegistration Page
	'isDebugOn = False
	isDebugOn = True
%>

<!-- #Include virtual="PDI/Include/Common.asp" -->
<!--#Include FILE="Admin/Include/SendMail.asp" -->

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <style type="text/css">
        #main {
            margin-top: 30px;
            margin-bottom: 30px;
        }
    </style>
    <!-- #Include virtual="PDI/Include/HeadStuff.asp" -->

</head>
<body>
    <div>
        <!-- #Include virtual="PDI/Include/header.asp" -->
    </div>
    <div id="main">
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
			Dim FirstName, LastName, EmailAddress, Area
			Dim CompanyName
			Dim Address1, Address2, City, ProvinceID, PostalCode, CountryID
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
			
			'Set Defaults in case this is a Focus3 entry, which will not have values for these variables
			AgeValue = "0"
			EducationValue = "0"
			OccupationValue = "0"
			ProvinceID = "56"
			CountryID = "0"
			
			'-- User Info---------------------
			UserName = Request.Form("txtUserName") : UserName = Trim(UserName)
				If UserName = "" Then strErrMsg = strErrMsg & " " & strTextPleaseEnterAValueForUsername & "<br>"
			Password = Request.Form("txtPassword") : Password = Trim(Password)
			PasswordConfirm = Request.Form("txtPasswordConfirm") : PasswordConfirm = Trim(PasswordConfirm)
				If Password = "" Then strErrMsg = strErrMsq & " " & strTextPleaseEnterAValueForPassword & "<br>"
				If PasswordConfirm <> Password Then strErrMsg = strErrMsg & " " & strTextPasswordAndRetypePasswordValuesDoNotMatch & "<br>"
				'If Len(Password) < 6 Then strErrMsg = strErrMsg & " " & strTextPasswordMustBeAtLeast6Characters & "<br>"
            	If Len(Password) < 8 or Len(Password) > 20 Then strErrMsg = strErrMsg & " Password must be between 8-20 characters.<br>"

			FirstName = Request.Form("txtFirstName") : FirstName = Trim(FirstName)
				If FirstName = "" Then strErrMsg = strErrMsg & " " & strTextPleaseEnterAValueForFirstName & "<br>"
			LastName = Request.Form("txtLastName") : LastName = Trim(LastName)
				If LastName = "" Then strErrMsg = strErrMsg & " " & strTextPleaseEnterAValueForLastName & "<br>"
			EmailAddress = Request.Form("txtEmailAddress") : EmailAddress = Trim(EmailAddress)
            EmailConfirm = Request.Form("txtEmailAddress2") : EmailConfirm = Trim(EmailConfirm)
				If EmailAddress = "" Then strErrMsg = strErrMsg & " " & strTextPleaseEnterAValueForEmailAddress & "<br>"
				If InStr(1,CStr(EmailAddress),"@",1) = 0 Then strErrMsg = strErrMsg & " " & strTextPleaseEnterAValueForEmailAddress & "<br>"
				If InStr(1,CStr(EmailAddress),".",1) = 0 Then strErrMsg = strErrMsg & " " & strTextPleaseEnterAValueForEmailAddress & "<br>"
                If EmailConfirm <> EmailAddress Then strErrMsg = strErrMsg & " Email addresses much be identical.<br>"

			Area = Request.Form("txtArea") : Area = Trim(Area)
			'-- Company Info ---------------------
			CompanyName = Request.Form("txtCompanyName") : CompanyName = Trim(CompanyName)
			Address1 = Request.Form("txtAddress1") : Address1 = Trim(Address1)
			Address2 = Request.Form("txtAddress2") : Address2 = Trim(Address2)
			City = Request.Form("txtCity") : City = Trim(City)
			'Made a decision to collect "Country" instead of "State/Province" in order to make this page more globally-oriented --MLP 3/1/2005
			'ProvinceID = Request.Form("txtProvinceID") : ProvinceID = Trim(ProvinceID)
			CountryID = Request.Form("txtCountryID") : CountryID = Trim(CountryID)
			If Len(CountryID) < 1 Then
				CountryID = "1"
			End If
			PostalCode = Request.Form("txtPostalCode") : PostalCode = Trim(PostalCode)
			Country = Request.Form("txtCountry") : Country = Trim(Country)
			Position = Request.Form("txtPosition") : Position = Trim(Position)
			Department = Request.Form("txtDepartment") : Department = Trim(Department)
			TeamName = Request.Form("txtTeamName") : TeamName = Trim(TeamName)
				If (CompanyName <> "" or Address1 <> "" or City <> "" or PostalCode <> "") Then
					If CompanyName = "" Then strErrMsg = strErrMsg & " " & strTextPleaseEnterAValueForOrganizationName & "<br>"
					If Address1 = "" Then strErrMsg = strErrMsg & " " & strTextPleaseEnterAValueForOrganizationAddress & "<br>"
					If City = "" Then strErrMsg = strErrMsg & " " & strTextPleaseEnterAValueForCity & "<br>"
					If ProvinceID = "" Then strErrMsg = strErrMsg & " " & strTextPleaseEnterAValueForState & "<br>"
					If PostalCode = "" Then strErrMsg = strErrMsg & " " & strTextPleaseEnterAValueForZipCode & "<br>"
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
			If Len(AgeValue) < 1 Then
				AgeValue = "0"
			End If
			EducationValue = Request.Form("txtEducation")
			If Len(EducationValue) < 1 Then
				EducationValue = "0"
			End If
			OccupationValue = Request.Form("txtOccupation")
			If Len(OccupationValue) < 1 Then
				OccupationValue = "0"
			End If
			
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

'If isDebugOn Then
	'Response.Write "<br>Exec spRegistrationInsert '" & UserName & "', '" & Password & "', '" & FirstName & "', '" & LastName & "', '" & EmailAddress & "', '" & Area & "', '" & CompanyName & "', '" & Address1 & "', '" & Address2 & "', '" & City & "', " & ProvinceID & ", '" & PostalCode & "', '" & Position & "', '" & Department & "', '" & TeamName & "', '" & GenderValue & "', " & AgeValue & ", " & EducationValue & ", " & OccupationValue & ", '" & MgtRespValue & "', " & cInt(intResellerID) & ", " & CLng(UserID)
	strTemp = "Exec spRegistrationInsert '" & UserName & "', '" & Password & "', '" & FirstName & "', '" & LastName & "', '" & EmailAddress & "', '" & Area & "', '" & CompanyName & "', '" & Address1 & "', '" & Address2 & "', '" & City & "', " & ProvinceID & ", '" & PostalCode & "', '" & Position & "', '" & Department & "', '" & TeamName & "', '" & GenderValue & "', " & AgeValue & ", " & EducationValue & ", " & OccupationValue & ", '" & MgtRespValue & "', " & cInt(intResellerID) & ", " & CLng(UserID)
'End If

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
				.Parameters.Append .CreateParameter("@Area", 200, 1, 100, Area)
				'-- Company Info ---------------------
				.Parameters.Append .CreateParameter("@CompanyName",200, 1,100, CompanyName)
				.Parameters.Append .CreateParameter("@Address1",200, 1,100, Address1)
				.Parameters.Append .CreateParameter("@Address2",200, 1,100, Address2)
				.Parameters.Append .CreateParameter("@City",200, 1,100, City)
				.Parameters.Append .CreateParameter("@ProvinceID",3, 1,4, ProvinceID)
				.Parameters.Append .CreateParameter("@CountryID", 3, 1, 4, CountryID)
				.Parameters.Append .CreateParameter("@PostalCode",200, 1,50, PostalCode)
				.Parameters.Append .CreateParameter("@Position",200, 1,100, Position)
				.Parameters.Append .CreateParameter("@Department",200, 1,100, Department)
				.Parameters.Append .CreateParameter("@TeamName",200, 1,100, TeamName)
				'-- Demographics ---------------------
				.Parameters.Append .CreateParameter("@Gender",129, 1,1, CStr(GenderValue))
				.Parameters.Append .CreateParameter("@Age",3, 1,4, CInt(AgeValue))
				.Parameters.Append .CreateParameter("@Education",3, 1,4, CInt(EducationValue))
				.Parameters.Append .CreateParameter("@Occupation",3, 1,4, CInt(OccupationValue))
				.Parameters.Append .CreateParameter("@MgtResp",129, 1,1, CStr(MgtRespValue))
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
                Response.Cookies("UserName") = UserName
				
            'Send Email Confirmation of Registration
				Dim strBody
				'strBody = "Thanks for registering for your DISC profile. Below are your username and password." & vbCrLf & _
				'				"Please save this email for your records." & vbCrLf & vbCrLr & _
				'				"Username: " & UserName & vbCrLf & _
				'				"Password: " & Password
				strBody = strTextHereIsYourLoginInformation & VbCrLf & VbCrLf & _
					Application("strTextUsername" & strLanguageCode) & ": " & UserName & VbCrLf & _
					Application("strTextPassword" & strLanguageCode) & ": " & Password & VbCrLf & _
					VbCrLf & strTextYouMayLogInToTheWebsiteUsing & ": " & VbCrLf & _
					"http://www.pdiprofile.com/pdi/login.asp"
				Call SendSimpleMail("info@teamresources.com", "DISC Registrar", "DISC Registration Info", EmailAddress, strBody)
				
				If strSiteType = "Focus3" Then 'TODO: replace this hard-coded reseller switch with generalized logic.
					Response.Redirect("EnterTestCode.asp?res=" & intResellerID )
				Else
					Response.Redirect("main.asp?newuser=1&res=" & intResellerID )
				End If
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
						Response.Write ("@Area = " & Area & "<br>")
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

     <div class="page-header">
      <div class="row">
        <div class="col-md-8 col-md-offset-2 col-xs-offset-1">
          <h1>Register
            <p class="lead">Your privacy is safe. We will never sell or share your personal information.</p>
            <p>
                <%
                    If strErrMsg <> "" Then
		                Response.Write "<span class=""error-msg"">" & strErrMsg & "</span>"
	                End If
                 %>
            </p>
          </h1>
        </div>
      </div>
    </div>
    <div class="container">
      <div class="row">
        <form role="form" action="Registration.asp?res=<%=intResellerID%>" method="post" id="thisForm" name="thisForm">
          <input type="hidden" value="1" id="txtSubmit" name="txtSubmit">
            <div class="col-md-8 col-md-offset-2 col-xs-offset-1">
              <div class="well well-sm"><strong><span class="glyphicon glyphicon-asterisk small"></span> <small>Required Field</small></strong></div>
                <hr>
                <h3>Personal Information</h3>
                <div class="form-group col-md-6">
                    <label for="txtFirstName"><%=strTextFirstName %></label>
                    <div class="input-group">
                        <input type="text" class="form-control" id="txtFirstName" name="txtFirstName" value="<%=FirstName%>" placeholder="<%=strTextFirstName %>" required>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-asterisk"></span></span>
                    </div>
                </div>
                <div class="form-group col-md-6">
                    <label for="txtLastName"><%=strTextLastName %></label>
                    <div class="input-group">
                        <input type="text" class="form-control" id="txtLastName" name="txtLastName" Value="<%=LastName%>" placeholder="<%=strTextLastName %>" required>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-asterisk"></span></span>
                    </div>
                </div>
                <div class="form-group col-md-6">
                    <%If intResellerID <> 18 then %>
                    <label for="txtEmailAddress"><%=strTextEmailAddress %></label>
                    <% Else %>
                    <label for="txtEmailAddress">Your Abbott Email Address</label>
                    <%End If %>
                    <div class="input-group">
                        <input type="email" class="form-control" id="txtEmailAddress" name="txtEmailAddress" value="<%=EmailAddress%>" placeholder="<%=strTextEmailAddress %>" required>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-asterisk"></span></span>
                    </div>
                </div>
                <div class="form-group col-md-6">
                    <label for="txtEmailAddress2">Confirm Email Address</label>
                    <div class="input-group">
                        <input type="email" class="form-control" id="txtEmailAddress2" name="txtEmailAddress2" placeholder="Confirm Email" required>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-asterisk"></span></span>
                    </div>
                </div>
                <div class="form-group col-md-6">
                    <label for="txtUserName"><%=strTextChooseAUsername%></label>
                    <div class="input-group">
                        <input type="text" class="form-control" id="txtUserName" name="txtUserName" value="<%=UserName%>" placeholder="<%=strTextChooseAUsername%>" required>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-asterisk"></span></span>
                    </div>
                </div>
                <div class="form-group col-md-6">
                    <label for="txtPassword"><%=strTextChooseAPassword%></label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="txtPassword" name="txtPassword" placeholder="<%=strTextChooseAPassword%>" required>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-asterisk"></span></span>
                    </div>
                    <p class="help-block small">8-20 Characters. Allows: @ ! # $ % &amp; * " ( ) and blank spaces.</p>
                </div>


                 <div class="form-group col-md-6">
                     <label for="txtPassword">Confirm Password</label>
                     <div class="input-group">
                         <input type="password" class="form-control" id="txtPasswordConfirm" name="txtPasswordConfirm" placeholder="Choose a Password" required>
                         <span class="input-group-addon"><span class="glyphicon glyphicon-asterisk"></span></span>
                     </div>
                     <p class="help-block small">8-20 Characters. Allows: @ ! # $ % &amp; * " ( ) and blank spaces.</p>
                 </div>



                <div class="clearfix"></div>
                <div class="well well-lg optional">
                <h3>Information for Research <small><b>(optional and private)</b></small></h3>
                <p><b>Help us continue to improve the DISC instrument. Your information will rbain private and used for research purposes only.</b></p>
                
                <div class="form-group col-md-6">
                  <label for="txtGender"><%=strTextGender%></label>
                  <select class="form-control" id="txtGender" name="txtGender">
			        <%
				        Response.Write("<option value=""0"">")
				        for nCount = 1 to 2
					        if CInt(nCount) = CInt(GenderValue) then 
						        Response.Write("<option value=""" & nCount & """>" & Gender(nCount) & "</option>")
					        else
						        Response.Write("<option value=""" & nCount & """>" & Gender(nCount) & "</option>")
					        end if
				        next
			        %>
                  </select>
                </div>
               <div class="form-group col-md-6">
                <label for="txtAge"><%=strTextAge%></label>
                <select class="form-control" id="txtAge" name="txtAge">
			<%
				Response.Write("<option value=""0"">")
				for nCount = 1 to 6
					if CInt(nCount) = CInt(AgeValue) then 
						Response.Write("<option value=""" & nCount & """>" & Age(nCount) & "</option>")
					else
						Response.Write("<option value=""" & nCount & """>" & Age(nCount) & "</option>")
					end if
				next
			%>
                </select>
                </div>
                <div class="form-group col-md-6">
                <label for="txtEducation"><%=strTextEducation%></label>
                <select class="form-control" id="txtEducation" name="txtEducation">
			<%
				Response.Write("<option value=""0"">")
				for nCount = 1 to 6
					if CInt(nCount) = CInt(EducationValue) then 
						Response.Write("<option value=""" & nCount & """>" & Education(nCount) & "</option>")
					else
						Response.Write("<option value=""" & nCount & """>" & Education(nCount) & "</option>")
					end if
				next
			%>
                </select>
                </div>
                <div class="form-group col-md-6">
                <label for="txtOccupation"><%=strTextOccupation%></label>
                <select class="form-control" id="txtOccupation" name="txtOccupation">
                <!-- Jerry, I kept the original values for these, but alphabetized the list -->
			<%
				Response.Write("<option value=""0"">")
				for nCount = 1 to 20
					if CInt(nCount) = CInt(OccupationValue) then 
						Response.Write("<option value=""" & nCount & """>" & Occupation(nCount) & "</option>")
					else
						Response.Write("<option value=""" & nCount & """>" & Occupation(nCount) & "</option>")
					end if
				next
			%>
                </select>
                </div>
                <div class="form-group col-md-6">
                <label for="txtMgtResp"><%=strTextDoYouHaveManagementResponsibilities%>?</label>
                <select class="form-control" id="txtMgtResp" name="txtMgtResp">
                <!-- Jerry, I kept the original values for these, but alphabetized the list -->
<%
				Response.Write("<option value=""0"">")
				For nCount = 1 To 2
					If CInt(nCount) = CInt(MgtRespValue) Then
						Response.Write("<option value=""" & nCount & """ >" & MgtResp(nCount) & "</option>")
					Else
						Response.Write("<option value=""" & nCount & """>" & MgtResp(nCount) & "</option>")
					End If
				Next
%>
                </select>
                </div>
                <div class="clearfix"></div>
                </div>
                <div class="clearfix"></div>
                <h3><%=strTextOrganizationalInformation%></h3>
                <div class="form-group col-md-6">
                    <label for="txtCompanyName"><%=strTextNameOfOrganization%></label>
                    <input type="text" class="form-control" id="txtCompanyName" name="txtCompanyName" value="<%=CompanyName%>" placeholder="Area or Department">
                </div>
                <div class="form-group col-md-6">
                    <label for="txtArea">Area/Department</label>
                    <input type="text" class="form-control" id="txtArea" name="txtArea" placeholder="Area or Department">
                    <!-- <p class="help-block xsmall">If you are with a company and have been assigned to an area or department, please enter that here.</p> -->
                </div>
                <div class="form-group col-md-12">
                    <label for="txtAddress1"><%=strTextOrganizationAddress%></label>
                    <input type="text" class="form-control" id="ttxtAddress1" name="txtAddress1" value="<%=Address1%>" placeholder="<%=strTextOrganizationAddress%>">
                </div>
                <div class="form-group col-md-12">
                    <label for="txtAddress2">Organization Address 2</label>
                    <input type="text" class="form-control" id="txtAddress2" name="txtAddress2" value="<%=Address2%>" placeholder="Area or Department">
                </div>
                <div class="form-group col-md-4">
                    <label for="txtCity"><%=strTextCity%></label>
                    <input type="text" class="form-control" id="txtCity" name="txtCity" value="<%=City%>" placeholder="<%=strTextCity%>">
                </div>
                <div class="form-group col-md-4">
                    <label for="txtCountryID"><%=strTextCountry%></label>
                    <select class="form-control" id="txtCountryID" name="txtCountryID">
                        <!-- #Include virtual="PDI/Include/Countries.asp" -->
                     </select>
                  </div>
                  <div class="form-group col-md-4">
                    <label for="txtPostalCode"><%=strTextZipPostalCode%></label>
                    <input type="text" class="form-control" id="txtPostalCode" name="txtPostalCode" value="<%=PostalCode%>" placeholder="<%=strTextZipPostalCode%>">
                  </div>
                  <div class="form-group col-md-6">
                    <label for="txtPosition"><%=strTextPosition%></label>
                    <input type="text" class="form-control" id="txtPosition" name="txtPosition" placeholder="<%=strTextPosition%>">
                  </div>
                  <div class="form-group col-md-6">
                    <label for="txtTeamName"><%=strTextDepartment%></label>
                    <input type="text" class="form-control" id="txtTeamName" name="txtTeamName" placeholder="<%=strTextDepartment%>">
                  </div>
                  <div class="clearfix"></div>
                  <hr>
                <!--<input type="submit" name="add" id="add" value="Register" class="btn btn-info pull-right">-->
                <input type="submit" class="btn btn-info pull-right" value="<%=strTextRegister%>" id="add" name="add" >
                </div>
            </form>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>      
  </body>
</html>
