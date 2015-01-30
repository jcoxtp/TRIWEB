<%@ Page language="c#" Codebehind="BradBackupSuccess.aspx.cs" AutoEventWireup="false" Inherits="Brad.BradBackupSuccess" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>
			<%=SetDocumentTitle()%>
		</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<!-- SPSS applications stylesheet -->
		<LINK href="Shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<script>
		function CloseWindow()
		{
			window.close();
		}
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:Label id="lblSize" style="Z-INDEX: 101; LEFT: 24px; POSITION: absolute; TOP: 192px" runat="server">lblSize</asp:Label>
			<asp:Button id="btnDownload" style="Z-INDEX: 104; LEFT: 24px; POSITION: absolute; TOP: 272px"
				Width="120px" runat="server" Text="btnDownload" tabIndex="2"></asp:Button>
			<asp:Button id="btnOk" style="Z-INDEX: 103; LEFT: 360px; POSITION: absolute; TOP: 272px" runat="server"
				Width="80px" Text="btnOk" tabIndex="1"></asp:Button>
			<asp:Label id="lblMessage" style="Z-INDEX: 102; LEFT: 24px; POSITION: absolute; TOP: 56px"
				runat="server">lblMessage</asp:Label>
			<div id="lblPath" style="LEFT: 24px;  POSITION: absolute;  TOP: 104px;  WORD-WRAP: break-word"
				runat="server">
				lblPath
			</div>
		</form>
	</body>
</HTML>
