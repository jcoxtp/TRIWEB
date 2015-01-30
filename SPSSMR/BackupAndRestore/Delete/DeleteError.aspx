<%@ Page language="c#" Codebehind="DeleteError.aspx.cs" Inherits="Brad.Delete.DeleteError" %>
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
		<LINK href="../Shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<script>
			function CloseWindow()
			{
				try
				{
					window.opener.refreshLauncher2("../../DimensionNet/default2.aspx");	
				}
				catch(exception)
				{
				}
				window.close();
			}
			function DisableButtons()
			{
				btnOk.disable = true;				
				btnViewLog.disable = true;
			}
			function ViewLogFile()
			{			   
				var url = '..\\BradShowLogFile.aspx';
				var wLogFile;
				wLogFile = window.open(url, "", "width=480,height=480,location=no,menubar=no,toolbar=no");
				wLogFile.focus();
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
			<asp:Label id="lblMessage" style="Z-INDEX: 101; LEFT: 24px; POSITION: absolute; TOP: 24px"
				runat="server">lblMessage</asp:Label>
			<asp:TextBox id="txtErrorMessage" style="Z-INDEX: 104; LEFT: 24px; POSITION: absolute; TOP: 48px"
				runat="server" Width="416px" Height="144px" TextMode="MultiLine"></asp:TextBox>
			<asp:Button id="btnOk" style="Z-INDEX: 103; LEFT: 272px; POSITION: absolute; TOP: 256px" Width="170px"
				runat="server" Text="btnOk" tabIndex="2"></asp:Button>
			<asp:Button id="btnViewLog" style="Z-INDEX: 102; LEFT: 272px; POSITION: absolute; TOP: 224px"
				Width="170px" runat="server" Text="btnViewLog" tabIndex="1"></asp:Button>
		</form>
	</body>
</HTML>
