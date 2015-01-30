<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	'On Error Resume Next
	intPageID = 53	' Representative Profile Page 2
	Dim pageTitle, TestCodeID, profileID
	profileID = Request.QueryString("pID")
	TestCodeID = Request.QueryString("TCID")
%>
<!--#Include file="Include/CheckLogin.asp" -->
<!--#Include file="Include/Common.asp" -->
<%
' TODO: Remove this line of code when the German site is complete
If strLanguageCode = "DE" Then
	strLanguageCode = "EN"
	intLanguageID = 1
End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
<!--<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>-->
	<!--#Include file="Include/HeadStuff.asp" -->
</head>
<body>
<!--#Include file="Include/TopBanner.asp" -->
    <div id="main">

<%
Dim bSubmitted
	bSubmitted = Request.Form("Submitted")
	
	'If the form has been submitted, then update the database to
	'reflect the selected profile, and then move to the next page.
	
	If (bSubmitted <> "") Then
		TestCodeID = Request.Form("TCID")
		profileID = Request.Form("pID")
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		With oCmd
			.CommandText = "spTestSummaryProfileIDTCIDUpdate"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			.Parameters.Append .CreateParameter("@ProfileID1",3, 1,4, profileID)
			.Parameters.Append .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)
		End With
		oConn.Open strDbConnString
		oCmd.ActiveConnection = oConn
		oCmd.Execute , , 128
		If oConn.Errors.Count < 1 Then '[SM] Update was successful
			Response.Redirect("PDIProfileCustom.asp?TCID=" & TestCodeID & "&res=" & intResellerID & "&lid=" & intLanguageID)
		Else
			Response.Write "Error updating representative profile. Please try again."
		End If
		Set oConn = Nothing
		Set oCmd = Nothing
	End If
%>
<div id="tabgraphic">
	<img src="images/S4P4<%=strLanguageCode%>.gif" width="692" height="82" alt="" usemap="#tab" />
	<map name="tab">
		<area shape=poly alt="" coords="633,53,672,53,680,59,673,65,632,66,617,59,634,53,637,53" href="PDIProfileRepProfile2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>&lid=<%=intLanguageID%>">
	</map>
</div>
<div id="maincontent_tab">
	
	<form name="form_ProfileDesc" method="post" action="PDIProfileRepProfileDesc.asp" ID="Form1">
		<input type="hidden" name="Submitted" id="Submitted" value="1">
		<input type="hidden" name="TCID" id="TCID" value="<%=TestCodeID%>">
		<input type="hidden" name="pID" id="pID" value=<%= profileID %>
		<input type="hidden" name="st" id="st" value="<%=Site%>">	
		<div style="position:relative;left:170px">
		<input type="submit" name="Submit" value="<%=strTextIfThisIsYourRepresentativeP%>" ID="Submit1"/>
		</div>
	</form>
			
	<!--#Include File = "Include/PDIProfileRepProfileDescBody.asp" -->		
</div>
</div>
</body>
</html>
