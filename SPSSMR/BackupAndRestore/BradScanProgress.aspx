<%@ Page language="c#" Codebehind="BradScanProgress.aspx.cs" AutoEventWireup="false" Inherits="Brad.BradScanProgress" %>
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
		function startScan()
		{
			//call a new page on the server to start the scan
			var url;
			url = "BradDoScan.aspx";			
			//window.navigate(url);			
		}
		
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout" onload="startScan()">
		<form id="Form1" method="post" runat="server">
			<asp:Image id="Image1" style="Z-INDEX: 101; LEFT: 176px; POSITION: absolute; TOP: 144px" runat="server"
				ImageUrl="file:///Z:\wwwroot\SPSSMRDEV\Shared\Images\molecules.gif"></asp:Image>
			<asp:Label id="lblMessage" style="Z-INDEX: 102; LEFT: 72px; POSITION: absolute; TOP: 192px"
				runat="server">lblMessage</asp:Label>
		</form>
	</body>
</HTML>
