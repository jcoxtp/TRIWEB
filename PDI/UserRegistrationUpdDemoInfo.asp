<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 42	' Update User Demographic Information Page
%>
<!--#Include File="Include/CheckLogin.asp" -->
<!--#Include File="Include/Common.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
	<!--#Include File="Include/HeadStuff.asp" -->
</head>
<body>
<!--#Include File="Include/TopBanner.asp" -->
    <div id="main">

<div id="maincontent">
<%
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
		%><!--#Include File="UserRegistration_demographic_data.asp" --><%

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
				oConn.Open strDbConnString
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
			oConn.Open strDbConnString
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
<table border="0" cellspacing="0" cellpadding="4" width="100%">
	<tr>
		<td valign="top"><h1><%=strTextUpdateRegistrationInformation%></h1></td>
		<td valign="top" align="right"><!--#Include File="Include/BackLink.asp" --></td>
	</tr>
</table>
<%=strTextPleaseEnterYourInformationInTheFieldsBelow%>
<br><br>
<!--# Include File="Include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="4" width="100%">
<%
		If strErrMsg <> "" Then
			Response.Write("<tr><td valign=""middle"" colspan=""2"">")
			Response.Write("<span class=""errortext"">" & strErrMsg & "</span>")
			Response.Write("</td></tr>")
		End If
	%>
	<tr> 
	  	<td valign="middle" colspan="2">
	  		<span class="headertext2"><strong><%=strTextOptionalDemographicInformation%></strong></span><br />
			<%=strTextDemographicsWillBeUsedForResearchPurposes%>
	  	</td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right" width="35%"><strong><%=strTextGender%>:</strong></td>
	  	<td valign="middle" width="65%">
	  		<select name="txtGender">
<%
				Response.Write("<option value=""0"">")
				For nCount = 1 To 2
					If CInt(nCount) = CInt(GenderValue) Then
						Response.Write("<option value=""" & nCount & """ Selected>" & Gender(nCount) & "</option>")
					Else
						Response.Write("<option value=""" & nCount & """>" & Gender(nCount) & "</option>")
					End If
				Next
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
	  	<td valign="middle" align="right"><strong><%=strTextDoYouHaveManagementResponsibilities%></strong></td>
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
<!--#Include File="Include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="100%">
	<tr>
	  	<td valign="top"><%=strTextViewOur%> <a href="PrivacyPolicy.asp?res=<%=intResellerID%>"><%=Application("strTextPrivacyPolicy" & strLanguageCode)%></a></td>
	  	<td valign="top" align="right"><input type="submit" border="0" value="<%=strTextSaveChanges%>" id="add" name="add"></td>
	</tr>
</table>
</form>
</div>

    </div>
</body>
</html>
