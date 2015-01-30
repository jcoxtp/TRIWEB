<%@ Language=VBScript %>
<%Option Explicit%>
<!-- #include file="mfs.asp" -->
<!-- #include file="fmutil.asp" -->
<html>
	<head>
		<meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link rel="stylesheet" type="text/css" href="filemgr.css" />
		<script language="javascript" src="dialog.js"></script>
		<script language="javascript" src="mfs_gui.js"></script>
		<script language="javascript">
		</script>
	</head>
	<body tabindex="-1">
		<%
			Dim oMFS
			Set oMFS = New MultifileSelection
			oMFS.SetXML unescape(Session.Value("MFSData"))
			
			Response.Write(oMFS.Transform("mfs_gui.xslt"))
			Set oMFS = Nothing
		%>
	</body>
</html>
