<%@ Page language="c#" Codebehind="BradDoScan.aspx.cs" AutoEventWireup="false" Inherits="Brad.BradDoScan" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<!-- SPSS applications stylesheet -->
		<LINK href="Shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<script>
			function DoClickEvent()
			{						
				document.getElementById("lnkCallServer").click();
			}
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout" onload='DoClickEvent()'>
		<form id="Form1" method="post" runat="server">
			<asp:LinkButton id="lnkCallServer" style="Z-INDEX: 101; LEFT: 272px; POSITION: absolute; TOP: 280px"
				runat="server"></asp:LinkButton>
			<asp:Label id="lblMessage" style="Z-INDEX: 102; LEFT: 24px; POSITION: absolute; TOP: 48px"
				runat="server">lblMessage</asp:Label>&nbsp;
		</form>
	</body>
</HTML>
