<%@ Page language="c#" Codebehind="mailtest.aspx.cs" AutoEventWireup="false" Inherits="ePDICorp.mailtest" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>mailtest</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:TextBox id="tTo" style="Z-INDEX: 101; LEFT: 96px; POSITION: absolute; TOP: 64px" runat="server"
				Width="240px"></asp:TextBox>
			<asp:Label id="Label1" style="Z-INDEX: 102; LEFT: 24px; POSITION: absolute; TOP: 64px" runat="server">email:</asp:Label>
			<asp:TextBox id="tSubject" style="Z-INDEX: 103; LEFT: 96px; POSITION: absolute; TOP: 104px" runat="server"
				Width="240px"></asp:TextBox>
			<asp:Label id="Label2" style="Z-INDEX: 104; LEFT: 24px; POSITION: absolute; TOP: 104px" runat="server"
				Width="56px" Height="16px">subject:</asp:Label>
			<asp:TextBox id="tBody" style="Z-INDEX: 105; LEFT: 96px; POSITION: absolute; TOP: 152px" runat="server"
				Width="248px" Height="112px"></asp:TextBox>
			<asp:Label id="Label3" style="Z-INDEX: 106; LEFT: 24px; POSITION: absolute; TOP: 168px" runat="server"
				Width="56px" Height="16px">message:</asp:Label>
			<asp:Button id="btnSend" style="Z-INDEX: 107; LEFT: 16px; POSITION: absolute; TOP: 8px" runat="server"
				Width="72px" Text="Send"></asp:Button>
		</form>
	</body>
</HTML>
