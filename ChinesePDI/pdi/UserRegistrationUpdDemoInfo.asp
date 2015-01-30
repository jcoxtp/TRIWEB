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
'		Response.Write(UserID & "<hr>")
	
		'Form Variables
		Dim GenderValue, AgeValue, EducationValue, OccupationValue, MgtRespValue
	
		'-- Include registration demographic data -----------------------------------
		'- for some reason all the demographic data was hard coded into the asp pages
		'- its still working for the most part so we are waiting to change this until 
		'- it can be incorporated into new feature requests : mg 2/16/2004
		%><!--#INCLUDE FILE="UserRegistration_demographic_data.asp" --><%

	'=========================================================================================
	'  If this is a postback then 
	'		Receive and validate incomming form data
	'	Else this is the first time through 
	'		So, grab info from the db
	'=========================================================================================
		strErrMsg = ""
		If bSubmitted <> "" Then
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

			'-- If the data is good - write to the database -------------------
			If bFilledOutProperly Then
				Set oConn = CreateObject("ADODB.Connection")
				Set oCmd = CreateObject("ADODB.Command")
				With oCmd
					.CommandText = "spRegistrationUpdDemoInfo"
					.CommandType = 4
					.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
					.Parameters.Append .CreateParameter("@UserID",3, 1,4, UserID)
					'-- Demographics ---------------------
					.Parameters.Append .CreateParameter("@Gender",129, 1,1, GenderValue)
					.Parameters.Append .CreateParameter("@Age",3, 1,4, AgeValue)
					.Parameters.Append .CreateParameter("@Education",3, 1,4, EducationValue)
					.Parameters.Append .CreateParameter("@Occupation",3, 1,4, OccupationValue)
					.Parameters.Append .CreateParameter("@MgtResp",129, 1,1, MgtRespValue)
				End With
				oConn.Open strDBaseConnString
				oCmd.ActiveConnection = oConn
				oCmd.Execute , , 128
			
				If oConn.Errors.Count < 1 Then
					Response.Redirect("UserRegistrationInfo.asp?res=" & intResellerID )
				Else
					Dim strError
					strError = FormatSQLError(Err.description)
					strErrMsg = strError
'					Response.Write ("@UserID = " & UserID & "<br>")
'					Response.Write ("@Gender = " & GenderValue & "<br>")
'					Response.Write ("@Age = " & AgeValue & "<br>")
'					Response.Write ("@Education = " & EducationValue & "<br>")
'					Response.Write ("@Occupation = " & OccupationValue & "<br>")
'					Response.Write ("@MgtResp = " & MgtRespValue & "<br>")
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

			GenderValue = 0
				If oRs("Gender") = "M" Then GenderValue = 1
				If oRs("Gender") = "F" Then GenderValue = 2
			AgeValue = oRs("Age") 
			EducationValue = oRs("Education")
			OccupationValue = oRs("Occupation")
			MgtRespValue = 0
				If oRs("MgtResp") = "Y" Then MgtRespValue = 1
				If oRs("MgtResp") = "N" Then MgtRespValue = 2
		
	'=========================================================================================
		End If ' Closes the original--> If bSubmitted <> "" Then
	'=========================================================================================

%>
<form name="thisForm" id="thisForm" method="post" action="UserRegistrationUpdDemoInfo.asp?res=<%=intResellerID%>">
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
