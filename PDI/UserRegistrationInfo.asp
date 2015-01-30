<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 39	' User Registration Info Page
%>
<!--#Include file="Include/CheckLogin.asp" -->
<!--#Include file="Include/Common.asp" -->
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
	<!--#Include file="Include/HeadStuff.asp" -->
</head>
<body>
<!--#Include file="Include/TopBanner.asp" -->
    <div id="main">

<div id="maincontent">
<%
	'=========================================================================================
	' Initialize variables
	'=========================================================================================
		'Objects for database operations
		Dim oConn, oCmd, oRs
		
		'Misc Other
		Dim UserID
		UserId = Request.Cookies("UserID")
		'Response.Write("UserID=" & UserID & "<hr>")
		
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
			'Response.Write("I'm Complaining<hr>")
		End If

		'-- Include registration demographic data -----------------------------------
		'- for some reason all the demographic data was hard coded into the asp pages
		'- its still working for the most part so we are waiting to change this until 
		'- it can be incorporated into new feature requests : mg 2/16/2004
		%><!--#Include FILE="UserRegistration_demographic_data.asp" --><%

%>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td valign="top"><h1><%=strTextPageTitle%></h1></td>
		<td valign="top" align="right"></td>
	</tr>
</table>
<!--# Include File="Include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr> 
	  	<td valign="middle">
			<span class="headertext2"><%=strTextUserInformation%></span>
		</td>
		<td valign="middle" align="right" width="65%">
			<a href="UserRegistrationUpdPass.asp?res=<%=intResellerID%>"><%=strTextChangePassword%></a><br>
			<a href="UserRegistrationUpdUserInfo.asp?res=<%=intResellerID%>"><%=strTextChangeUserInformation%></a>
		</td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right" ><strong><%=Application("strTextUsername" & strLanguageCode)%>:</strong></td>
	  	<td valign="middle"><%=oRs("UserName")%></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong><%=strTextFirstName%>:</strong></td>
	  	<td valign="middle"><%=oRs("FirstName")%></td>
	</tr>			
	<tr> 
	  	<td valign="middle" align="right"><strong><%=strTextLastName%>:</strong></td>
	  	<td valign="middle"><%=oRs("LastName")%></td>
	</tr>		
	<tr> 
	  	<td valign="middle" align="right"><strong><%=strTextEmailAddress%>:</strong></td>
	  	<td valign="middle"><%=oRs("EmailAddress")%></td>
	</tr>
</table><br>
<%
' mg: 2/19/04 =================================================================
' allowing users to update organizational information creates many business rule 
' scenarios that would need to be addressed the functionality is not used enough
' by users to decide on and implement those business rules at this time.
' =============================================================================
'<!--#Include FILE="Include/divider.asp" -->
%><!--
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr>
	  	<td valign="middle">
			<span class="headertext2"><%=strTextOrganizationalInformation%></span>
		</td>
		<td valign="middle" align="right" width="65%">
			<%'<a href="UserRegistrationUpdOrgInfo.asp?res=<%=intResellerID%><%'">Change Organization Information</a>%>
		</td>
	</tr>
	<tr>
	  	<td valign="middle" align="right" ><strong><%=strTextOrganization & " " & Application("strTextName" & strLanguageCode)%>:</strong></td>
	  	<td valign="middle"><%=oRs("CompanyName")%></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><strong><%=strTextOrganization & " " & strTextAddress%>:</strong></td>
	  	<td valign="middle"><%=oRs("Address1")%></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><strong><%=strAddress%>:</strong></td>
	  	<td valign="middle"><%=oRs("Address2")%></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><strong><%=strTextCity%>:</strong></td>
	  	<td valign="middle"><%=oRs("City")%></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><strong><%=strTextStateProvince%>:</strong></td>
	  	<td valign="middle"></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><strong><%=strTextZipPostalCode%>:</strong></td>
	  	<td valign="middle"><%=oRs("PostalCode")%></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><strong><%=strTextPosition%>:</strong></td>
	  	<td valign="middle"><%=oRs("Postition")%></td><%'mg: I know "postition" is a misspelling but thats how the original dev put it in the table def... :-( %>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><strong><%=strTextDepartment%>:</strong></td>
	  	<td valign="middle"><%=oRs("Department")%></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><strong><%=strTextTeam & " " & Application("strTextName" & strLanguageCode)%>:</strong></td>
	  	<td valign="middle"><%=oRs("TeamName")%></td>
	</tr>
</table><br>
-->
<!--#Include File="Include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">	
	<tr> 
	  	<td valign="middle">
	  		<span class="headertext2"><strong><%=strTextDemographicInformation%></strong></span><br />
	  	</td>
		<td valign="middle" align="right" width="65%">
			<a href="UserRegistrationUpdDemoInfo.asp?res=<%=intResellerID%>"><%=strTextChangeDemographicInformation%></a>
		</td>
	</tr>
	<tr><td valign="middle" colspan="100%"><%=strTextDemographicsWillBeUsedForResearchPurposes%></td></tr>
	<tr> 
	  	<td valign="middle" align="right"><strong><%=strTextGender%>:</strong></td>
	  	<td valign="middle">
			<%
				If oRs("Gender") = "M" Then Response.Write strTextMale
				If oRs("Gender") = "F" Then Response.Write strTextFemale
			%>
		</td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong><%=strTextAge%>:</strong></td>
	  	<td valign="middle"><%=Age(oRs("Age"))%></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong><%=strTextEducation%>:</strong></td>
	  	<td valign="middle"><%=Education(oRs("Education"))%></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong><%=strTextOccupation%>:</strong></td>
	  	<td valign="middle"><%=Occupation(oRs("Occupation"))%></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><strong><%=strTextDoYouHaveManagementResponsibilities%></strong></td>
	  	<td valign="middle">
			<%
				If oRs("MgtResp") = "Y" Then Response.Write Application("strTextYes" & strLanguageCode)
				If oRs("MgtResp") = "N" Then Response.Write Application("strTextNo" & strLanguageCode)
			%>
		</td>
	</tr>
</table>
</div>
</body>
</html>
<%
	' Clean up
	Set oConn = Nothing : Set oCmd = Nothing : Set oRs = Nothing
%>
