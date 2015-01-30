<%@ Page language="c#" Codebehind="ErrorPage.aspx.cs" Inherits="Brad.ErrorPage" %>
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
		
		function IsTargetOk()
		{			
			if(window.top.frames.length > 1)
			{								
				window.Form1.submit();				
			}			
		}
		
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout" onload="JavaScript:IsTargetOk()">
		<form id="Form1" method="post" runat="server" target="_top">
			<asp:Label id="lblTitle" style="Z-INDEX: 101; LEFT: 24px; POSITION: absolute; TOP: 48px" runat="server">lblTitle</asp:Label>
			<asp:Button id="btnClose" style="Z-INDEX: 104; LEFT: 360px; POSITION: absolute; TOP: 272px"
				Width="80px" runat="server" Text="btnClose" tabIndex="1"></asp:Button>
			<asp:Label id="lblStack" style="Z-INDEX: 103; LEFT: 24px; POSITION: absolute; TOP: 136px" runat="server">lblStack</asp:Label>
			<asp:Label id="lblMessage" style="Z-INDEX: 102; LEFT: 24px; POSITION: absolute; TOP: 88px"
				runat="server">lblMessage</asp:Label>
		</form>
	</body>
</HTML>
