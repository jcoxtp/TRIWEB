<%@ Page language="c#" Codebehind="BradBackupProjectNotClosed.aspx.cs" AutoEventWireup="false" Inherits="Brad.BradBackupProjectNotClosed" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>	
		<title><%=SetDocumentTitle()%></title>	
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<base target="_parent">
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
			<asp:Label id="lblMessage" style="Z-INDEX: 101; LEFT: 56px; POSITION: absolute; TOP: 72px"
				runat="server">lblMessage</asp:Label>
			<asp:Button id="btnYes" style="Z-INDEX: 104; LEFT: 24px; POSITION: absolute; TOP: 352px" runat="server"
				Width="80" Text="btnYes"></asp:Button>
			<asp:Button id="btnNo" style="Z-INDEX: 103; LEFT: 124px; POSITION: absolute; TOP: 352px" runat="server"
				Width="80" Text="btnNo"></asp:Button>
			<asp:Button id="btnCancel" style="Z-INDEX: 102; LEFT: 500px; POSITION: absolute; TOP: 352px"
				Width="80" runat="server" Text="btnCancel"></asp:Button>
		</form>
	</body>
</HTML>