<%@ Language=VBScript %>
<!--#Include FILE="Include/checklogin.asp" -->
<!--#Include FILE="Include/common.asp" -->
<% pageID = "editUser" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Edit User Information</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
	<!--#Include FILE="Include/HeadStuff.asp" -->
</head>
<body>
<!--#Include FILE="Include/TopBanner.asp" -->

<div id="maincontent">
	
	<%
	'*****************************************************************************************
	'*
	'* Generated By: TierBuilder V3.2 - www.tierbuilder.com
	'* Created By: David Brackin
	'* Creation Date: Thursday, February 28, 2002  16:46:09
	'* Copyright (c) 2002 Team Resources, Inc.
	'*
	'* ----  Code Settings ----
	'*
	'* Returns Recordset: NO
	'* Purpose: This ASP page calls the stored procedure upd_User_Company_Info using ADO.
	'**********************************************************************************************************************************
	
	on error resume next
	
	Dim bSubmitted
	bSubmitted = Request.Form ("txtSubmit")
	Dim bFilledOutProperly, strErrMsg
	Dim CompanyName
	Dim Address1
	Dim Address2
	Dim Address3
	Dim Address4
	Dim City
	Dim ProvinceID
	Dim ProvinceName
	Dim PostalCode
	Dim FirstName
	Dim LastName
	Dim Postition
	Dim EmailAddress
	Dim UserID
	Dim CompanyID
	Dim Department
	Dim TeamName
	Dim strTemp
	Dim nPos
	Dim Gender(2)
	Dim GenderValue
	Dim Age(6)
	Dim AgeValue
	Dim Education(6)
	Dim EducationValue
	Dim Occupation(19)
	Dim MgtResp(2)
	Dim MgtRespValue
	Dim nCount
	
	Gender(1) = "Male"
	Gender(2) = "Female"
	
	Age(1) = "18-25"
	Age(2) = "26-35"
	Age(3) = "36-45"
	Age(4) = "46-55"
	Age(5) = "56-65"
	Age(6) = "Over 65"
	
	Education(1) = "Some High School"
	Education(2) = "High School Graduate"
	Education(3) = "Some College"
	Education(4) = "College Graduate"
	Education(5) = "Some Graduate School"
	Education(6) = "Post-Graduate Degree"
	
	Occupation(1) = "Accounting/Finance"
	Occupation(2) = "Computer Related"
	Occupation(3) = "Consulting"
	Occupation(4) = "Customer Service"
	Occupation(5) = "Education/Training"
	Occupation(6) = "Engineering"
	Occupation(7) = "Senior Management"
	Occupation(8) = "Administrative"
	Occupation(9) = "Government/Military"
	Occupation(10) = "Homemaker"
	Occupation(11) = "Manufacturing"
	Occupation(12) = "Medical/Legal"
	Occupation(13) = "Retired"
	Occupation(14) = "Marketing/Advising"
	Occupation(15) = "Self-Employed/Owner"
	Occupation(16) = "Sales"
	Occupation(17) = "Tradesman/Craftsman"
	Occupation(18) = "Student"
	Occupation(19) = "Between Jobs"
	Occupation(20) = "Other"
	
	MgtResp(1) = "Yes"
	MgtResp(2) = "No"
	
	UserID = Request.Cookies("UserID")
	bFilledOutProperly = FALSE
	
	If bSubmitted <> "" Then
		  FirstName = Request.Form("txtFirstName")
		  LastName = Request.Form("txtLastName")
		  Postition = Request.Form("txtPostition")
		  TeamName = Request.Form("txtTeamName")
		  Department = Request.Form("txtDepartment")
		  EmailAddress = Request.Form("txtEmailAddress")
		  CompanyName = Request.Form("txtCompanyName")
		  Address1 = Request.Form("txtAddress1")
		  Address2 = Request.Form("txtAddress2")
		  Address3 = Request.Form("txtAddress3")
		  Address4 = Request.Form("txtAddress4")
		  City = Request.Form("txtCity")
		  strTemp = Request.Form("txtProvinceID")
	
		 nPos = InStr(1,strTemp,",")
		  ProvinceID = Left(strTemp,nPos-1)
		  ProvinceName = Right(strTemp,Len(strTemp)-nPos)
		  PostalCode = Request.Form("txtPostalCode")
	
		  CompanyID = Request.Form("txtCompanyID")
		  UserID = Request.Form("txtUserID")
		  GenderValue = Request.Form("txtGender")
		 AgeValue = Request.Form("txtAge")
		 EducationValue = Request.Form("txtEducation")
		 OccupationValue = Request.Form("txtOccupation")
		 MgtRespValue = Request.Form("txtMgtResp")
	
	ELSE
		' RETRIEVE THE USER INFORMATION FROM THE DATABASE
		Dim oConn
		Dim oCmd
		Dim oRs
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
		With oCmd
			  .CommandText = "sel_UserInfo_UserID"
			  .CommandType = 4
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				.Parameters.Append .CreateParameter("@UserID",3, 1,4, UserID)
		End With
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
	
		If oConn.Errors.Count < 1 then
			FirstName = oRs("FirstName")
			LastName = oRs("LastName")
			Postition = oRs("Postition")
			TeamName = oRs("TeamName")
			Department = oRs("Department")
			EmailAddress = oRs("EmailAddress")
		ELSE
			Response.Write "Unable to retrieve user information"
			Response.End
		END IF
	
		Set oConn = Nothing
		Set oCmd = Nothing
		Set oRs = Nothing
	
		' RETRIEVE THE COMPANY INFORMATION FROM THE DATABASE
	
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
		With oCmd
			  .CommandText = "sel_user_company_info"
			  .CommandType = 4
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				.Parameters.Append .CreateParameter("@UserID",3, 1,4, UserID)
		End With
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
	
		If oConn.Errors.Count < 1 then
			if oRs.EOF = FALSE then
				CompanyName = oRs("CompanyName")
				Address1 = oRs("Address1")
				Address2 = oRs("Address2")
				Address3 = oRs("Address3")
				Address4 = oRs("Address4")
				City = oRs("City")
				ProvinceID = oRs("ProvinceID")
				PostalCode = oRs("PostalCode")
				CompanyID = oRs("CompanyID")
			else
				CompanyName = ""
				Address1 = ""
				Address2 = ""
				Address3 = ""
				Address4 = ""
				City = ""
				ProvinceID = ""
				PostalCode = ""
				CompanyID = ""
			end if
		ELSE
			Response.Write "Unable to retrieve user - company information"
			Response.End
		END IF
	
		Set oConn = Nothing
		Set oCmd = Nothing
		Set oRs = Nothing
	
		' [SM] Retrieve Demographic Info from Database
	
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
		With oCmd
			  .CommandText = "sel_UserDemographics_UserID"
			  .CommandType = 4
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				.Parameters.Append .CreateParameter("@UserID",3, 1,4, UserID)
		End With
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
	
		If oConn.Errors.Count < 1 then
			if oRs.EOF = FALSE then
				GenderValue = oRs("Gender")
				AgeValue = oRs("Age")
				EducationValue = oRs("Education")
				OccupationValue = oRs("Occupation")
				MgtRespValue = oRs("MgtResp")
				if UCase(GenderValue) = "M" then
					GenderValue = 1
				elseif UCase(GenderValue) = "F" then
					GenderValue = 2
				else GenderValue = 0
				end if
				if UCase(MgtRespValue) = "Y" then
					MgtRespValue = 1
				elseif UCase(MgtRespValue) = "N" then
					MgtRespValue = 2
				else MgtRespValue = 0
				end if
			else
				GenderValue = 0
				AgeValue = 0
				EducationValue = 0
				OccupationValue = 0
				MgtRespValue = 0
			end if
		ELSE
			Dim strError
				strError = FormatSQLError(Err.description)
			Response.Write strError
			'Response.Write "Unable to retrieve demographic information"
			Response.End
		END IF
		Set oConn = Nothing
		Set oCmd = Nothing
		Set oRs = Nothing
	End If
	
	FirstName = Trim(FirstName)
	LastName = Trim(LastName)
	Postition = Trim(Postition)
	TeamName = Trim(TeamName)
	Department = Trim(Department)
	EmailAddress = Trim(EmailAddress)
	CompanyName = Trim(CompanyName)
	Address1 = Trim(Address1)
	Address2 = Trim(Address2)
	Address3 = Trim(Address3)
	Address4 = Trim(Address4)
	City = Trim(City)
	ProvinceID = Trim(ProvinceID)
	PostalCode = Trim(PostalCode)
	CompanyID = Trim(CompanyID)
	UserID = Trim(UserID)
	
	If bSubmitted <> "" Then
		If FirstName = "" then 
			strErrMsg = "Please enter a value for: <strong>First Name</strong>"
		ElseIf LastName = "" then 
			strErrMsg = "Please enter a value for: <strong>Last Name</strong>"
		ElseIf EmailAddress = "" then 
			strErrMsg = "Please enter a value for: <strong>Email Address</strong>"
		Else
			bFilledOutProperly = TRUE
		End If
	
		If bFilledOutProperly = TRUE and (CompanyName <> "" or Address1 <> "" or City <> "" or PostalCode <> "") then 
				If CompanyName = "" then
					  strErrMsg = "Please enter a value for: <strong>Organization Name</strong>"
				ElseIf Address1 = "" then
					  strErrMsg = "Please enter a value for: <strong>Organization Address</strong>"
				ElseIf City = "" then
					  strErrMsg = "Please enter a value for: <strong>City</strong>"
				ElseIf ProvinceID = "" then
					  strErrMsg = "Please enter a value for: <strong>State</strong>"
				ElseIf PostalCode = "" then
					  strErrMsg = "Please enter a value for: <strong>Zip Code</strong>"
				Else
					bFilledOutProperly = TRUE
				End If
		End If
	End If
	
	If bSubmitted <> "" AND bFilledOutProperly Then
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		CompanyID = 0 
	
		With oCmd
			.CommandText = "upd_User_Company_Info"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				.Parameters.Append .CreateParameter("@FirstName",200, 1,100, FirstName)
			 .Parameters.Append .CreateParameter("@LastName",200, 1,100, LastName)
			 .Parameters.Append .CreateParameter("@Postition",200, 1,100, Postition)
			 .Parameters.Append .CreateParameter("@TeamName",200, 1,50, TeamName)
			 .Parameters.Append .CreateParameter("@Department",200, 1,50, Department)
			 .Parameters.Append .CreateParameter("@EmailAddress",200, 1,100, EmailAddress)
			 .Parameters.Append .CreateParameter("@CompanyName",200, 1,100, CompanyName)
			 .Parameters.Append .CreateParameter("@Address1",200, 1,100, Address1)
			 .Parameters.Append .CreateParameter("@Address2",200, 1,100, Address2)
			 .Parameters.Append .CreateParameter("@Address3",200, 1,100, Address3)
			 .Parameters.Append .CreateParameter("@Address4",200, 1,100, Address4)
			 .Parameters.Append .CreateParameter("@City",200, 1,100, City)
			 .Parameters.Append .CreateParameter("@ProvinceID",3, 1,4, ProvinceID)
			 .Parameters.Append .CreateParameter("@PostalCode",200, 1,50, PostalCode)
			 .Parameters.Append .CreateParameter("@CompanyID",3, 3,4, CLng(CompanyID))
	
			if GenderValue = 1 then
				.Parameters.Append .CreateParameter("@Gender",129, 1,1, "M")
			elseif GenderValue = 2 then
				.Parameters.Append .CreateParameter("@Gender",129, 1,1, "F")
			else
				.Parameters.Append .CreateParameter("@Gender",129, 1,1, "")
			end if
			.Parameters.Append .CreateParameter("@Age",3, 1,4, AgeValue)
			.Parameters.Append .CreateParameter("@Education",3, 1,4, EducationValue)
			.Parameters.Append .CreateParameter("@Occupation",3, 1,4, OccupationValue)
	
			if MgtRespValue = 1 then
				.Parameters.Append .CreateParameter("@MgtResp",129, 1,1, "Y")
			elseif MgtRespValue = 2 then
				.Parameters.Append .CreateParameter("@MgtResp",129, 1,1, "N")
			else
				.Parameters.Append .CreateParameter("@MgtResp",129, 1,1, "")
			end if
			.Parameters.Append .CreateParameter("@UserID",3, 1,4, UserID)
		End With
	
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oCmd.Execute , , 128
		CompanyID = oCmd.Parameters("@CompanyID").value
	
	If oConn.Errors.Count < 1 then
		' If CompanyName has a value then the user either updated 
		' or inserted their company information so set the company cookies
		If CompanyName <> "" then
			Response.Cookies("CompanyID") = CompanyID
			Response.Cookies("CompanyName") = CompanyName
		Else
			ProvinceName = ""
		End If
		Response.Cookies("FirstName") = FirstName
		Response.Cookies("LastName") = LastName
	%>
	
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td valign="top"><img src="images/edit_personal.gif"></td>
			<td valign="top" align="right"><a href="main.asp?res=<%=intResellerID%>"><img src="images/back.gif" alt="" width="73" height="16" /></a></td>		
		</tr>
	</table>
	
	<p>Your information has been updated to the following:</p>
	
	<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
		<tr> 
			<td valign="middle" colspan="2"><span class="headertext2">User Information</span>
			</td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right" width="35%"><strong>First Name:</strong></td>
			<td valign="middle" width="65%"><%=FirstName%></td>
		</tr>
	
		<tr> 
			<td valign="middle" align="right"><strong>Last Name:</strong></td>
			<td valign="middle"><%=LastName%></td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right"><strong>Email Address:</strong></td>
			<td valign="middle"><%=EmailAddress%></td>
		</tr>
	</table>
	
	<!--#Include FILE="Include/divider.asp" -->
	
	<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
		<tr> 
			<td valign="middle" colspan="2"><span class="headertext2"><strong>Organizational Information</strong></span>
			</td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right" width="35%"><strong>Organization Name:</strong></td>
			<td valign="middle" width="65%"><%=CompanyName%></td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right"><strong>Organization Address1:</strong></td>
			<td valign="middle"><%=Address1%></td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right"><strong>Address2:</strong></td>
			<td valign="middle"><%=Address2%></td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right"><strong>City:</strong></td>
			<td valign="middle"><%=City%></td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right"><strong>State:</strong></td>
			<td valign="middle"><%=ProvinceName%></td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right"><strong>Zip Code:</strong></td>
			<td valign="middle"><%=PostalCode%></td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right"><strong>Position:</strong></td>
			<td valign="middle"><%=Postition%></td>
		</tr>
					
		<tr> 
			<td valign="middle" align="right"><strong>Team Name:</strong></td>
			<td valign="middle"><%=TeamName%></td>
		</tr>			
	
		<tr> 
			<td valign="middle" align="right"><strong>Department:</strong></td>
			<td valign="middle"><%=Department%></td>
		</tr>		
	</table>	
	
	
	<!--#Include FILE="Include/divider.asp" -->
	
	<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">	
		<tr> 
			<td valign="middle" colspan="2"><span class="headertext2"><strong>Optional Demographics</strong></span>			
			</td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right" width="35%"><strong>Gender:</strong></td>
			<td valign="middle" width="65%"><%=Gender(GenderValue)%></td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right"><strong>Age:</strong></td>
			<td valign="middle"><%=Age(AgeValue)%></td>
		</tr>
	
		<tr> 
			<td valign="middle" align="right"><strong>Education:</strong></td>
			<td valign="middle"><%=Education(EducationValue)%></td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right"><strong>Occupation:</strong></td>
			<td valign="middle"><%=Occupation(OccupationValue)%></td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right"><strong>Do you have management responsibility for others at work?</strong></td>
			<td valign="middle"><%=MgtResp(MgtRespValue)%></td>
		</tr>
	</table>
	
	<!--#Include FILE="Include/divider.asp" -->
	
	<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="100%">
		<tr> 
			<td valign="top" align="right"><a href="main.asp?res=<%=intResellerID%>"><img src="images/return_home.gif" alt="" width="93" height="16" /></a></td>
		</tr>
	</table>
	
	
	<%	
		
		Response.End
	
	else
	
		  strErrMsg = FormatSQLError(Err.description)
		  Err.Clear
	
	End If
	
	
	End If
	
	
	'If strErrMsg <> "" Then
	
		  'Response.Write "<br>"
		  'Response.Write "<span class='errortext'>" & strErrMsg & "</span>"
		  'Response.Write "<br /><br />"
	
	
	'End If %>
	
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td valign="top"><img src="images/edit_personal.gif">
			</td>
			
			<td valign="top" align="right"><a href="main.asp?res=<%=intResellerID%>"><img src="images/back.gif" alt="" width="73" height="16" /></a>
			</td>		
		</tr>
	</table>
	
	<form name="thisForm" id="thisForm" method="post" action="edituser.asp?res=<%=intResellerID%>">
	<input type="hidden" name="txtCompanyID" id="txtCompanyID" Value="<%=CompanyID%>">
	<input type="hidden" name="txtUserID" id="txtUserID" Value="<%=UserID%>">
	<input type="hidden" name="txtSubmit" id="txtSubmit" value="1">
	
	<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
		
		<tr>
			<td valign="middle">
				<span class="headertext2">User Information</span><br />
				<span class="required">*&nbsp;Required</span>
			</td>
			
			<td valign="middle">
			
				<% If strErrMsg <> "" Then
	
					Response.Write "<span class=""errortext"">" & strErrMsg & "</span>"
				
				Else
				
					Response.Write "&nbsp;"
				
				End If %>
			</td>
		</tr>
	
		<tr> 
			<td valign="middle" align="right" width="35%"><span class="required">*&nbsp;</span><strong>First Name:</strong></td>
			<td valign="middle" width="65%"><input type="text" name="txtFirstName" id="txtFirstName" MaxLength="100" Value="<%=FirstName%>"></td>
		</tr>
	
		<tr> 
			<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong>Last Name:</strong></td>
			<td valign="middle"><input type="text" name="txtLastName" id="txtLastName" MaxLength="100" Value="<%=LastName%>"></td>
		</tr>
	
		<tr> 
			<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong>Email Address:</strong></td>
			<td valign="middle"><input type="text" name="txtEmailAddress" id="txtEmailAddress" MaxLength="100" Size="50" Value="<%=EmailAddress%>"></td>
		</tr> 
	</table>
		
	<!--#Include FILE="Include/divider.asp" -->
	
	<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
		<tr> 
			<td valign="middle" colspan="2">
				<span class="headertext2">Organizational Information</span><br />
				<span class="required">**&nbsp;Required if organization name is entered</span>
			</td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right"><strong>Organization Name:</strong></td>
			<td valign="middle"><input type="text" name="txtCompanyName" id="txtCompanyName" MaxLength="100" Size="50" Value="<%=CompanyName%>"></td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right" width="35%"><span class="required">**&nbsp;</span><strong>Organization Address1:</strong></td>
			<td valign="middle" width="65%"><input type="text" name="txtAddress1" id="txtAddress1" MaxLength="100" Size="50" Value="<%=Address1%>"></td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right"><strong>Address2:</strong></td>
			<td valign="middle">
					<input type="text" name="txtAddress2" id="txtAddress2" MaxLength="100" Size="50" Value="<%=Address2%>">
					<input type="hidden" name="txtAddress3" id="txtAddress3" MaxLength="100" Value="<%=Address3%>">
					<input type="hidden" name="txtAddress4" id="txtAddress4" MaxLength="100" Value="<%=Address4%>"></td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right"><span class="required">**&nbsp;</span><strong>City:</strong></td>
			<td valign="middle"><input type="text" name="txtCity" id="txtCity" MaxLength="100" Value="<%=City%>"></td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right"><span class="required">**&nbsp;</span><strong>State:</strong></td>
			<td valign="middle">
			
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
			
						<select name="txtProvinceID">
			
					<%
					while oRs.EOF = FALSE
							
						If CInt(oRs("ProvinceID")) = CInt(ProvinceID) Then
									
					%>
				
							<option SELECTED value="<%=oRs("ProvinceID") & "," & oRs("PRV_Name")%>"><%=oRs("Prv_Name")%>
						
						<%
						Else %>
				
							<option value="<%=oRs("ProvinceID") & "," & oRs("PRV_Name")%>"><%=oRs("Prv_Name")%>
					
					
						<%
						End If
							
						oRs.MoveNext
						
					wend
	
					End If
	
					Set oConn = Nothing
					Set oCmd = Nothing
					Set oRs = Nothing
	
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
			<td valign="middle"><input type="text" name="txtPostition" id="txtPostition" MaxLength="100" Value="<%=Postition%>"></td>
		</tr>
					
		<tr> 
			<td valign="middle" align="right"><strong>Team Name:</strong></td>
			<td valign="middle"><input type="text" name="txtTeamName" id="txtTeamName" MaxLength="50" Value="<%=TeamName%>"></td>
		</tr>			
	
		<tr> 
			<td valign="middle" align="right"><strong>Department:</strong></td>
			<td valign="middle"><input type="text" name="txtDepartment" id="txtDepartment" MaxLength="50" Value="<%=Department%>"></td>
		</tr>
	</table>
		
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
				
				<% if GenderValue <> 0 then %>
				
					<option value="0">
					
				<%	for nCount = 1 to 2
						if CInt(nCount) = CInt(GenderValue) then %>
							<option value="<%=nCount%>" SELECTED><%=Gender(nCount)%>			
						<%
						else
						%>
							<option value="<%=nCount%>"><%=Gender(nCount)%>	
						<%
						end if 
					
					next
				%>
					
				<%	else %>
				
					<option value="0" SELECTED>
						
				<%	for nCount = 1 to 2 %>
							
					<option value="<%=nCount%>"><%=Gender(nCount)%>	
						
					
				<%	next
								
					end if %>
				
				</select></td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right"><strong>Age:</strong></td>
			<td valign="middle">
			
				<select name="txtAge">
				
				<% if AgeValue <> 0 then %>
				
					<option value="0">
				
				<%	for nCount = 1 to 6
						if CInt(nCount) = CInt(AgeValue) then %>
							<option value="<%=nCount%>" SELECTED><%=Age(nCount)%>			
						<%
						else
						%>
							<option value="<%=nCount%>"><%=Age(nCount)%>	
						<%
						end if 
					
					next
					%>
					
				
				<% else %>
					<option value="0" SELECTED>		
				<%
					for nCount = 1 to 6 %>
							
							<option value="<%=nCount%>"><%=Age(nCount)%>		
					<%
					next
								
					end if %>
				
				</select></td>
		</tr>
	
		<tr> 
			<td valign="middle" align="right"><strong>Education:</strong></td>
			<td valign="middle">
			
				<select name="txtEducation">
				
				<% if EducationValue <> 0 then %>
					
					<option value="0">
					
				<%	for nCount = 1 to 6
						if CInt(nCount) = CInt(EducationValue) then %>
							<option value="<%=nCount%>" SELECTED><%=Education(nCount)%>			
						<%
						else
						%>
							<option value="<%=nCount%>"><%=Education(nCount)%>		
						<%
						end if 
					
					next
					%>
					
				
				<%	else %>
						<option value="0" SELECTED>
						
				
				<%	for nCount = 1 to 6 %>
						<option value="<%=nCount%>"><%=Education(nCount)%>		
						
						
				<%	next
								
				end if %>
				
				</select></td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right"><strong>Occupation:</strong></td>
			<td valign="middle">
			
				<select name="txtOccupation">
				
				<% if OccupationValue <> 0 then %>
				
					<option value="0">
						
				<%	for nCount = 1 to 19
						if CInt(nCount) = CInt(OccupationValue) then %>
							<option value="<%=nCount%>" SELECTED><%=Occupation(nCount)%>			
						<%
						else
						%>
							<option value="<%=nCount%>"><%=Occupation(nCount)%>		
						<%
						end if 
					
					next
					%>
					
				
				<% else %>
				
					<option value="0" SELECTED>
					
				<%	for nCount = 1 to 19 %>
				
					<option value="<%=nCount%>"><%=Occupation(nCount)%>		
						
				<%	next
								
				end if %>
				
				</select></td>
		</tr>
		
		<tr> 
			<td valign="middle" align="right"><strong>Do you have management responsibility for others at work?</strong></td>
			<td valign="middle">
			
				<select name="txtMgtResp">
							
				<% if MgtRespValue <> 0 then %>
				
					<option value="0">
					
				<%	for nCount = 1 to 2
						if CInt(nCount) = CInt(MgtRespValue) then %>
							<option value="<%=nCount%>" SELECTED><%=MgtResp(nCount)%>			
						<%
						else
						%>
							<option value="<%=nCount%>"><%=MgtResp(nCount)%>	
						<%
						end if 
					
					next
				%>
					
				<%	else %>
				
					<option value="0" SELECTED>
						
				<%	for nCount = 1 to 2 %>
							
					<option value="<%=nCount%>"><%=MgtResp(nCount)%>	
						
					
				<%	next
								
					end if %>
				
				</select></td>
		</tr>
	</table>
	
	<!--#Include FILE="Include/divider.asp" -->
	
	<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="100%">
		<tr> 
			<td valign="top">Check our <a href="PrivacyPolicy.asp?res=<%=intResellerID%>">Privacy Policy</a></td>
			<td valign="top" align="right"><input type="submit" border="0" value="Update Information" id="add" name="add"></td>
		</tr>
	</table>
	</form>
	</body>
	</html>
</div>
</body>
</html>
