<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/checklogin.asp" -->
<!--#INCLUDE FILE="include/common.asp" -->
<% pageID = ""%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | User Registration Info</title>
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
		oConn.Open strDBaseConnString
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
		%><!--#INCLUDE FILE="UserRegistration_demographic_data.asp" --><%

%>
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr> 
	  	<td valign="top">
			<h1>User Registration Information</h1>
	  	</td>
		<td valign="top" align="right"><a href="main.asp?res=<%=intResellerID%>"><img src="images/back.gif" alt="" width="73" height="16" /></a></td>
	</tr>
</table>
<!--# INCLUDE FILE="include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr> 
	  	<td valign="middle">
			<span class="headertext2">User Information</span>
		</td>
		<td valign="middle" align="right" width="65%">
			<a href="UserRegistrationUpdPass.asp?res=<%=intResellerID%>">Change Password</a><br>
			<a href="UserRegistrationUpdUserInfo.asp?res=<%=intResellerID%>">Change User Information</a>
		</td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right" ><strong>Username:</strong></td>
	  	<td valign="middle"><%=oRs("UserName")%></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>First Name:</strong></td>
	  	<td valign="middle"><%=oRs("FirstName")%></td>
	</tr>			
	<tr> 
	  	<td valign="middle" align="right"><strong>Last Name:</strong></td>
	  	<td valign="middle"><%=oRs("LastName")%></td>
	</tr>		
	<tr> 
	  	<td valign="middle" align="right"><strong>Email Address:</strong></td>
	  	<td valign="middle"><%=oRs("EmailAddress")%></td>
	</tr>
</table><br>
<%
' mg: 2/19/04 =================================================================
' allowing users to update organizational information creates many business rule 
' scenarios that would need to be addressed the functionality is not used enough
' by users to decide on and implement those business rules at this time.
' =============================================================================
'<!--#INCLUDE FILE="include/divider.asp" -->
%><!--
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr> 
	  	<td valign="middle">
			<span class="headertext2">Organizational Information</span>
		</td>
		<td valign="middle" align="right" width="65%">
			<%'<a href="UserRegistrationUpdOrgInfo.asp?res=<%=intResellerID%><%'">Change Organization Information</a>%>
		</td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right" ><strong>Organization Name:</strong></td>
	  	<td valign="middle"><%=oRs("CompanyName")%></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>Organization Address:</strong></td>
	  	<td valign="middle"><%=oRs("Address1")%></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>Address:</strong></td>
	  	<td valign="middle"><%=oRs("Address2")%></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>City:</strong></td>
	  	<td valign="middle"><%=oRs("City")%></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>State:</strong></td>
	  	<td valign="middle"></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>Zip Code:</strong></td>
	  	<td valign="middle"><%=oRs("PostalCode")%></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>Position:</strong></td>
	  	<td valign="middle"><%=oRs("Postition")%></td><%'mg: I know "postition" is a misspelling but thats how the original dev put it in the table def... :-( %>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>Department:</strong></td>
	  	<td valign="middle"><%=oRs("Department")%></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>Team Name:</strong></td>
	  	<td valign="middle"><%=oRs("TeamName")%></td>
	</tr>
</table><br>
-->
<!--#INCLUDE FILE="include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">	
	<tr> 
	  	<td valign="middle">
	  		<span class="headertext2"><strong>Demographic Information</strong></span><br />
	  	</td>
		<td valign="middle" align="right" width="65%">
			<a href="UserRegistrationUpdDemoInfo.asp?res=<%=intResellerID%>">Change Demographic Information</a>
		</td>
	</tr>
	<tr><td valign="middle" colspan="100%">Demographics will be used for research purposes only and will <strong>not</strong> be used for solicitation.</td></tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>Gender:</strong></td>
	  	<td valign="middle">
			<%
				If oRs("Gender") = "M" Then Response.Write("Male")
				If oRs("Gender") = "F" Then Response.Write("Female")
			%>
		</td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>Age:</strong></td>
	  	<td valign="middle"><%=Age(oRs("Age"))%></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>Education:</strong></td>
	  	<td valign="middle"><%=Education(oRs("Education"))%></td>
	</tr>
	<tr> 
	  	<td valign="middle" align="right"><strong>Occupation:</strong></td>
	  	<td valign="middle"><%=Occupation(oRs("Occupation"))%></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><strong>Do you have management responsibility for others at work?</strong></td>
	  	<td valign="middle">
			<%
				If oRs("MgtResp") = "Y" Then Response.Write("Yes")
				If oRs("MgtResp") = "N" Then Response.Write("No")
			%>
		</td>
	</tr>
</table>
<!--#INCLUDE FILE="include/divider.asp" -->
<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="100%">
	<tr>
		<td valign="top">Check our <a href="PrivacyPolicy.asp?res=<%=intResellerID%>">Privacy Policy</a></td>
	</tr>
</table>
</div>
</body>
</html>
<%
	' Clean up
	Set oConn = Nothing : Set oCmd = Nothing : Set oRs = Nothing
%>
