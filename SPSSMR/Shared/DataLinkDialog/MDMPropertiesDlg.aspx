<%@ Page CodeBehind="MDMPropertiesDlg.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="VB.MDMPropertiesDlg" %>
<%@ OutputCache Location="none" %>
<script language="VB" runat="server">
</script>
<html>
	<head>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<title><%=Server.HtmlEncode(VB.Utilities.I18N.GetLanguageLiteral("mdm-properties-dialog-title", Request.QueryString("langres")))%></title>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="spssmrNet.css" />
		<script type="text/javascript" src="datalinkdialog.js"></script>
	</head>
	<body>
		<iframe src="<%=GetIframeSource()%>" 
			frameborder="0" width="100%" height="100%" />
	</body>
</html>
