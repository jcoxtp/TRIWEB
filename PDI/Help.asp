<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	On Error Resume Next
	intPageID = 34	' Credit Card Information Collection Page
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
<body onLoad="self.focus()">
<%
Dim strPageID
strPageID = Request.QueryString("pageID")
Dim oConn, oCmd, oRs
Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
Set oRs = CreateObject("ADODB.Recordset")
With oCmd
	.CommandText = "sel_HelpText_PageID"
	.CommandType = 4
	.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	.Parameters.Append .CreateParameter("@pageID", 200, 1, 20, strPageID)
End With
oConn.Open strDbConnString
oCmd.ActiveConnection = oConn
oRs.CursorLocation = 3
oRs.Open oCmd, , 0, 1
If oConn.Errors.Count < 1 Then
%>
	<div align="center">
	<table border="0" cellspacing="0" cellpadding="6" width="98%">
		<tr>
			<td valign="top">
<%
	If oRs.EOF = FALSE then
			Response.Write oRs("helpText") & vbcrlf
			Response.Write "<p><em></em></p>"
		Else
			Response.Write "<br><br><br>" & strTextNoHelpTextFound
	End If
%>
			</td>
		</tr>
		<tr>
			<td valign="top" align="center"><a href="javascript:window.close()"><%=strTextCloseWindow%></a></td>
		</tr>
	</table>
<%
Else
	Dim strError
	strError = FormatSQLError(Err.description)
	Response.Write strError
End If
Set oConn = Nothing
Set oCmd = Nothing
Set oRs = Nothing
%>	
</body>
</html>
