<%@ Page language="c#" Codebehind="BradBackupProgress.aspx.cs" AutoEventWireup="false" Inherits="Brad.BradBackupProgress" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>BradBackupProgress</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<!-- SPSS applications stylesheet -->
		<LINK href="Shared/spssmrNet.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:Image id="imgProgress" style="Z-INDEX: 101; LEFT: 240px; POSITION: absolute; TOP: 200px"
				runat="server" ImageAlign="Middle" ImageUrl="file:///Z:\wwwroot\SPSSMRDEV\Shared\Images\molecules.gif"></asp:Image>
			<asp:Button id="Button1" style="Z-INDEX: 103; LEFT: 592px; POSITION: absolute; TOP: 488px" runat="server"
				Text="Continue"></asp:Button>
		</form>
	</body>
</HTML>
