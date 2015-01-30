<%@ Language=VBScript %>
<%Option Explicit%>
<!-- #include file="fm.asp" -->
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<script type="text/javascript" src="dialog.js"></script>
		<script type="text/javascript" src="cmdstatus.js"></script>
		<link rel="stylesheet" type="text/css" href="filemgr.css" />
	</head>
	<%
	Dim oFM
	Set oFM = New FileManager
	oFM.SetXML unescape(Session.Value("FMData"))
	%>
	<body topmargin="0" leftmargin="0" class="cmdstatusbody">
		<%=oFM.Transform("cmdstatus.xslt")%>
	</body>
	<%
	Set oFM = Nothing
	%>
</html>
