<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 32	' PDI Profile Bypass PDI Page 1
	Dim TRUserID
	TRUserID = Request.Cookies("UserID")
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

<div id="maincontent">
<%
	'=============================================================
	'	2/5/04 - MG
	'	Adding the ability for users to get reports without actually taking the PDI profile.
	'	The safest way to do this seems to be to create a fake test entry in the system.
	'=============================================================

	Dim UserID
	UserID = Request.Cookies("UserID")

	'=============================================================
	' Gather incoming data and assign to variables
	'=============================================================
		Dim HP1
		Dim strErrMsg
		Dim bFilledOutProperly	:	bFilledOutProperly = FALSE
		
		HP1 = Request("HP1") 
'		Response.Write("<br>HP1=") : Response.Write(HP1)
'		Response.Write("<hr>")
		
		'=== Validate incoming data ==================================
		HP1 = Trim(HP1)

		strErrMsg = ""
		If HP1 = "" then strErrMsg = strErrMsg & " Please enter a value for - HP1 <br>"

		' Is incoming data good? 
		If strErrMsg = "" then bFilledOutProperly = TRUE

	'====================================================================		
	' If incoming data is good then fake the extra info and write to the db	
	'====================================================================		
	If bFilledOutProperly then

		'=== Write the fake test info to the database ================
			Dim oConn, oCmd
			Set oConn = CreateObject("ADODB.Connection")
			Set oCmd = CreateObject("ADODB.Command")
			With oCmd
				.CommandText = "spPDI_DiamondLane"
				.CommandType = 4
				.Parameters.Append .CreateParameter("@UserID",3, 1, , UserID)
				.Parameters.Append .CreateParameter("@ResellerID",3, 1, , intResellerID)
				.Parameters.Append .CreateParameter("@HP1",129, 1,1, HP1)
			End With
			oConn.Open strDbConnString
			oCmd.ActiveConnection = oConn
			oCmd.Execute , , 128
			
		'=== Check for errors and proceed to the next page ===========
			If oConn.Errors.Count < 1 then
				Response.Write "<BR><BR>Transaction Successful<BR><BR>"
				Dim RedirVal : RedirVal = "purchasetest.asp?res=" & intResellerID
				Response.Redirect(RedirVal)
			else
				  strErrMsg = Err.description
				  Err.Clear
			End If
	'====================================================================		
	End If ' closes If bFilledOutProperly then...
	'====================================================================		
%>
<html>
	<head>
		<title></title>
	</head>
	<body>
		<%
			If strErrMsg <> "" Then
				  Response.Write "<br>"
				  Response.Write strErrMsg
				  Response.Write "<br><br>"
			End If
		%>
	</body>
</html>