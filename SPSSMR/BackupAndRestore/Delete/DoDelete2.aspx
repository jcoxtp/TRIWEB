<%@ Page language="c#" Codebehind="DoDelete2.aspx.cs" Inherits="Brad.Delete.DoDelete2" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title></title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<!-- SPSS applications stylesheet -->
		<LINK href="../Shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<script>
			function DoClickEvent()
			{						
				
				document.getElementById("lnkCallServer").click();
				
			}
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout" onload='DoClickEvent()'>
		<form id="Form1" method="post" runat="server">
			<asp:LinkButton id="lnkCallServer" style="Z-INDEX: 101; LEFT: 128px; POSITION: absolute; TOP: 48px"
				runat="server"></asp:LinkButton>
			<asp:Label id="lblMessage" style="Z-INDEX: 102; LEFT: 24px; POSITION: absolute; TOP: 48px"
				runat="server">lblMessage</asp:Label>&nbsp;
		</form>
	</body>
</HTML>
