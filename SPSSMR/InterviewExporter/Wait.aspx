<%@ Page language="c#" Codebehind="Wait.aspx.cs" AutoEventWireup="false" Inherits="InterviewExporter.Wait" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>InterviewExporter</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<meta id="metaRefresh" runat="server" />
		<!-- STANDARD SPSS STYLESHEET SETTINGS -->
		<link href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
	</head>
	<body id="body" runat="server">
		<form id="Wait" method="post" runat="server">
			<span id="dialogSize" style="PADDING-RIGHT: 5px; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; WIDTH: 600px; PADDING-TOP: 5px">
				<%=I18N.GetResourceString("wait")%></span>
		</form>
		<iframe style="DISPLAY: none; WIDTH: 0px; HEIGHT: 0px" src="shared/sessionkeepalive.aspx">
		</iframe>
	</body>
</html>
