<%@ Language=VBScript %>
<%Option Explicit%>
<!-- #include file="pfs.asp" -->
<%
	Dim oPFS
	Set oPFS = New ProjectfileSelection
	
	oPFS.SetXML unescape(Session.Value("PFSData"))
	
	Dim strLiterals
	strLiterals = Server.MapPath( "res/literals" )
%>
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<script language="javascript" src="pfs_checkin_gui.js"></script>
		<link rel="stylesheet" type="text/css" href="filemgr.css" />
		<script language="javascript" src="dialog.js"></script>
	</head>
	<body tabindex="-1">
<%
	Response.Write(oPFS.transform("pfs_checkin_gui.xslt"))
	
	Set oPFS = Nothing
%>
	</body>
</html>
