<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/common.asp" -->
<% pageID = "" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Update Registration Info</title>
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
<div id="maincontent">
<%'=======================================================================================================
on error resume next

	'=========================================================================================
	' Initialize variables
	'=========================================================================================
		'Objects for database operations
		Dim oConn, oCmd, oRS
		
		'Pageflow related data
		Dim bFilledOutProperly : bFilledOutProperly = FALSE
		Dim bSubmitted	: bSubmitted = Request.Form ("txtSubmit")
		Dim strErrMsg
	
		'System data 
		Dim UserID, nCount
		UserId = Request.Cookies("UserID")
		'Response.Write(UserID & "<hr>")
	
		'Form Variables
		Dim CompanyName
		Dim Address1, Address2, City, ProvinceID, PostalCode
		Dim Position, Department, TeamName
	
	'=========================================================================================
	'  If this is a postback then 
	'		Receive and validate incomming form data
	'	Else this is the first time through 
	'		So, grab info from the db
	'=========================================================================================
		strErrMsg = ""
		If bSubmitted <> "" Then
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

			'-- Check for an error message ----------------
			If strErrMsg = "" Then
				bFilledOutProperly = TRUE
			End If

			'-- If the data is good - write to the database -------------------
			If bFilledOutProperly Then
				Set oConn = CreateObject("ADODB.Connection")
				Set oCmd = CreateObject("ADODB.Command")
				With oCmd
					.CommandText = "spRegistrationUpdOrgInfo"
					.CommandType = 4
					.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
					.Parameters.Append .CreateParameter("@UserID",3, 1,4, UserID)
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
				End With
				oConn.Open strDBaseConnString
				oCmd.ActiveConnection = oConn
				oCmd.Execute , , 128
			
				If oConn.Errors.Count < 1 Then
					Response.Cookies("CompanyName") = CompanyName
					Response.Redirect("UserRegistrationInfo.asp?res=" & intResellerID )
				Else
					Dim strError
					strError = FormatSQLError(Err.description)
					strErrMsg = strError
'					Response.Write ("@UserID = " & UserID & "<br>")
'					Response.Write ("@CompanyName = " & CompanyName & "<br>")
'					Response.Write ("@Address1 = " & Address1 & "<br>")
'					Response.Write ("@Address2 = " & Address2 & "<br>")
'					Response.Write ("@City = " & City & "<br>")
'					Response.Write ("@ProvinceID = " & ProvinceID & "<br>")
'					Response.Write ("@PostalCode = " & PostalCode & "<br>")
'					Response.Write ("@Position = " & Position & "<br>")
'					Response.Write ("@Department = " & Department & "<br>")
'					Response.Write ("@TeamName = " & TeamName & "<br>")
					Err.Clear
				End If
				Set oConn = Nothing
				Set oCmd = Nothing
			End If
	'=========================================================================================
		Else ' This is tied to the original--> If bSubmitted <> "" Then
	'=========================================================================================
			'-- Grab the data from the db ------------------------
			Set oConn = CreateObject("ADODB.Connection")
			Set oCmd = CreateObject("ADODB.Command")
			Set oRs = CreateObject("ADODB.Recordset")
			With oCmd
				.CommandText = "spRegistrationGet"
				.CommandType = 4
				.Parameters.Append .CreateParameter("@UserID", 3, 1, 4, UserId)
			End With
			oConn.Open strDBaseConnString
			oCmd.ActiveConnection = oConn
			Set oRs = oCmd.Execute
	
			If oConn.Errors.Count > 0 or oRs.EOF then
				'bad stuff happened - complain
			End If

			CompanyName = oRs("CompanyName")
			Address1 = oRs("Address1") 
			Address2 = oRs("Address2") 
			City = oRs("City") 
			ProvinceID = oRs("ProvinceID") 
			PostalCode = oRs("PostalCode")
			Position = oRs("Postition") 
			Department = oRs("Department") 
			TeamName = oRs("TeamName")

	'=========================================================================================
		End If ' Closes the original--> If bSubmitted <> "" Then
	'=========================================================================================

%>
<form name="thisForm" id="thisForm" method="post" action="UserRegistrationUpdOrgInfo.asp?res=<%=intResellerID%>">
<input type="hidden" name="txtSubmit" id="txtSubmit" value="1">
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr> 
	  	<td valign="top">
			<h1>Update Registration Information</h1>
			Please enter your information in the fields below, and click "Save Changes" at the bottom of this page.
	  	</td>
		<td valign="top" align="right"><!--#INCLUDE FILE="include/back_link.asp" --></td>
	</tr>
	<%
		If strErrMsg <> "" Then
			Response.Write("<tr><td valign=""middle"" colspan=""2"">")
			Response.Write("<span class=""errortext"">" & strErrMsg & "</span>")
			Response.Write("</td></tr>")
		End If 
	%>
</table>
<!--#INCLUDE FILE="include/divider.asp" -->
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
			oConn.Open strDBaseConnString
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
<!--#INCLUDE FILE="include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="100%">
	<tr>
	  	<td valign="top">View our <a href="PrivacyPolicy.asp?res=<%=intResellerID%>">Privacy Policy</a></td>
	  	<td valign="top" align="right"><input type="submit" border="0" value="Save Changes" id="add" name="add"></td>
	</tr>
</table>
</form>
</div>
</body>
</html>
