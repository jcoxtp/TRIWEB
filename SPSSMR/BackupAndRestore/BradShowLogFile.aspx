<%@ Page language="c#" Codebehind="BradShowLogFile.aspx.cs" AutoEventWireup="false" Inherits="Brad.BradShowLogFle" %>
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
			<asp:Button id="btnClose" style="Z-INDEX: 101; LEFT: 368px; POSITION: absolute; TOP: 440px"
				runat="server" Width="100px" Text="btnClose" tabIndex="1"></asp:Button>
			<asp:TextBox id="lstLogFile" style="Z-INDEX: 102; LEFT: 24px; POSITION: absolute; TOP: 24px"
				runat="server" Height="400px" Width="440px" TextMode="MultiLine"></asp:TextBox>
		</form>
	</body>
</HTML>
