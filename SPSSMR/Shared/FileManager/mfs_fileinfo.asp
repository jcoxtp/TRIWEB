<%@ Language=VBScript %>
<%Option Explicit%>
<!-- #include file="mfs.asp" -->
<!-- #include file="fmutil.asp" -->
<html>
	<head>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="filemgr.css" />
		<title>
		<%
			Dim oMFS
			Set oMFS = New MultifileSelection
			oMFS.SetXML unescape(Session.Value("MFSData"))
			
			Dim strLiterals
			strLiterals = Server.MapPath( "res/literals" )
			
			Response.Write GetLanguageLiteral("mfs_fileinfo_dialog_title", strLiterals, oMFS.GetLanguage())
		%>
		</title>
		<script language="javascript" src="dialog.js"></script>
		<script language="javascript" src="mfs_fileinfo.js"></script>
		<script language="javascript">
		<!--
		-->
		</script>
	</head>
	<body tabindex="-1">
		<%
			Dim strFileSelected
			strFileSelected = Request.QueryString("selectedfile")
			
			Call oMFS.SetFileAttribute(strFileSelected, "showinfo", "true")
			
			Response.Write(oMFS.Transform("mfs_fileinfo.xslt"))
			Set oMFS = Nothing
		%>
	</body>
</html>
