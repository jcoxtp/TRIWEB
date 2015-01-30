<%@ Page language="c#" Codebehind="BradDoBackup.aspx.cs" AutoEventWireup="false" Inherits="Brad.BradDoBackup" %>
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
			<asp:LinkButton id="lnkCallServer" style="Z-INDEX: 101; LEFT: 240px; POSITION: absolute; TOP: 288px"
				runat="server"></asp:LinkButton>
			<asp:Label id="lblMessage" style="Z-INDEX: 102; LEFT: 40px; POSITION: absolute; TOP: 56px"
				runat="server">lblMessage</asp:Label>&nbsp;
		</form>
	</body>
</HTML>
