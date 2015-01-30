<%@ Page language="c#" Codebehind="BradBackupNoSpaceOnDisk.aspx.cs" AutoEventWireup="false" Inherits="Brad.BradBackupNoSpaceOnDisk" %>
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
			<asp:Label id="lblMessage" style="Z-INDEX: 101; LEFT: 40px; POSITION: absolute; TOP: 40px"
				runat="server">lblMessage</asp:Label>
			<asp:Button id="btnContinue" style="Z-INDEX: 103; LEFT: 32px; POSITION: absolute; TOP: 272px"
				Width="120" runat="server" Text="btnContinue" tabIndex="1"></asp:Button>
			<asp:Button id="btnCancel" style="Z-INDEX: 102; LEFT: 360px; POSITION: absolute; TOP: 272px"
				Width="80" runat="server" Text="btnCancel" tabIndex="2"></asp:Button>
		</form>
	</body>
</HTML>
