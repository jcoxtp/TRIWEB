<%@ Page language="c#" Codebehind="RedirectAfterUsingFrames.aspx.cs" AutoEventWireup="false" Inherits="Brad.RedirectAfterUsingFrames" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title></title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<!-- SPSS applications stylesheet -->
		<LINK href="Shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<script>
			function lnkRedirect_Click()
			{
				document.getElementById("lnkRedirect").click();
			}
		
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout" onload="lnkRedirect_Click()">
		<form id="Form1" method="post" runat="server" target="_parent">
			<asp:LinkButton id="lnkRedirect" style="Z-INDEX: 101; LEFT: 272px; POSITION: absolute; TOP: 352px"
				runat="server"></asp:LinkButton>
		</form>
	</body>
</HTML>
