<%@ Language=VBScript %>
<%Option Explicit%>
<!-- #include file="fm.asp" -->
<!-- #include file="fmutil.asp" -->
<%
	Dim oFM
	Set oFM = New FileManager
	
	oFM.SetXML unescape(Session.Value("FMData"))
%>
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<title>
			<%=GetLanguageLiteral("upload_file_heading", Server.MapPath("res/literals"), oFM.GetLanguage())%>
		</title>
		<script language="javascript" src="dialog.js"></script>
		<script language="javascript" src="dlg_upload.js"></script>
		<script language="javascript">
			msg_upload_confirm_upload = '<%=GetLanguageLiteral("upload_confirm_upload", Server.MapPath("res/literals"), oFM.GetLanguage())%>';
			msg_upload_confirm_to     = '<%=GetLanguageLiteral("upload_confirm_to", Server.MapPath("res/literals"), oFM.GetLanguage())%>';
			msg_please_select_file    = '<%=GetLanguageLiteral("please_select_file", Server.MapPath("res/literals"), oFM.GetLanguage())%>';
			
			strRelDirSelection	= '<%=escape(Request.QueryString("uploadpath"))%>';
			strAliasSelection   = '<%=escape(Request.QueryString("alias"))%>';
		</script>
		<link rel="stylesheet" type="text/css" href="filemgr.css" />
	</head>
	<body style="margin: 5px">
	<%
		Response.Write(oFM.Transform("dlg_upload.xslt"))
		Set oFM = Nothing
	%>
	</body>
</html>
