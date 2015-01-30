<%@ Page language="c#" Codebehind="Info.aspx.cs" Inherits="ManageUsers.Info" %>
<%@ OutputCache Location="none" %>
<%@ Reference Control="ProjectInfoControl.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN" >
<HTML>
	<HEAD>
		<title>SPSS ManageUsers</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="../shared/spssmrNet.css" type="text/css" rel="STYLESHEET">
		<script language="JavaScript" src="jsinclude.js"></script>
		<script type="text/javascript">
		window.onbeforeunload=function()
		{ 		    
		    if (document.body.offsetWidth-50<event.clientX && event.clientY<0)      
		        window_onunload();  
		}
		
		function unload()
		{
		    window_onunload();  
		}
		
		</script>
	</HEAD>
	<body>
		<form runat="server">
		<br>
		<asp:Panel ID="ItemInfoPanel" Runat="server">
			<asp:PlaceHolder id="phProjectInfo" runat="server"></asp:PlaceHolder><br>
		</asp:Panel>
		<table class="style1" width="100%">
			<tr>
				<td colspan="2">
					<asp:Label ID="lblGeneralLabel" Runat="server"></asp:Label>
				</td>
			</tr>
			<tr>
				<td>
					<asp:Label ID="lblMemberLabel" Runat="server"></asp:Label>
				</td>
				<td align="right">
					<asp:Label ID="lblActionLabel" Runat="server"></asp:Label>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<asp:Table ID="tblRoles" Runat="server" Width="100%"></asp:Table>
				</td>
			</tr>
		</table>
		<!-- This hyperlink here is only used to get the CssClass attribute for 
			 the dynamically  generated hyperlinks on this page. It will never be populated.
			 This allows customization without the need to rebuild the .Net component -->
		<asp:HyperLink ID="hlCssFormat" Runat="server" CssClass="darklinks"></asp:HyperLink>
		</form>
	</body>
</HTML>
