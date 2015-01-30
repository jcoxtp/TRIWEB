<%@ Page language="c#" Codebehind="BradBackupConfirm.aspx.cs" AutoEventWireup="false" Inherits="Brad.BradBackupConfirm" %>
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
		<script type="text/javascript" src="shared/dialog/dialog.js"></script>
		<!-- SPSS applications stylesheet -->
		<LINK href="Shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<script>
			function CloseWindow()
			{
				window.close();
			}
			
			function OpenAdvancedWindow(variables)
			{				
				var url = 'BradBackupAdvancedOptions.aspx?' + variables;				
				var width = '650px';
				var height = '850px';
				
				var wAdvanced;
				wAdvanced = window.open(url, "", "width=650,height=665,location=no,menubar=no,toolbar=no");
				wAdvanced.focus();
			}
			
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout" text="#b0d0ce">
		<form id="Form1" method="post" runat="server">
			<asp:Button id="btnOk" style="Z-INDEX: 103; LEFT: 272px; POSITION: absolute; TOP: 272px" runat="server"
				Text="btnOk" Width="80px" tabIndex="1"></asp:Button>
			<asp:Button id="btnAdvanced" style="Z-INDEX: 104; LEFT: 24px; POSITION: absolute; TOP: 272px"
				runat="server" Text="btnAdvanced" Width="120px" tabIndex="3"></asp:Button>
			<asp:Button id="btnCancel" style="Z-INDEX: 102; LEFT: 360px; POSITION: absolute; TOP: 272px"
				runat="server" Text="btnCancel" Width="80px" tabIndex="2"></asp:Button>
			<asp:Label id="lblMessage" style="Z-INDEX: 101; LEFT: 32px; POSITION: absolute; TOP: 48px"
				runat="server">lblMessage</asp:Label>
		</form>
	</body>
</HTML>
