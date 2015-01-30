<%@ Reference Control="ProjectInfoControl.ascx" %>
<%@ Page language="c#" Codebehind="Info.aspx.cs" Inherits="ManageAccess.Info" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN" >
<HTML>
	<HEAD>
		<title>SPSS ManageAccess</title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../shared/spssmrNet.css" type="text/css" rel="STYLESHEET">
		<script language="JavaScript" src="jsinclude.js"></script>
		<script src="Shared/Dialog/dialog.js" type="text/javascript"></script>
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
	<body style="MARGIN: 7px">
		<form id="Form1" runat="server">
			<br>
			<asp:placeholder id="phProjectInfo" runat="server"></asp:placeholder><br>
			<table class="style1" width="100%">
				<tr>
					<td colSpan="2"><asp:label id="lblGeneralLabel" Runat="server"></asp:label></td>
				</tr>
				<tr>
					<td vAlign="top"><asp:label id="lblMemberLabel" Runat="server"></asp:label></td>
					<td align="right"><asp:label id="lblActionLabel" Runat="server"></asp:label><br>
						<asp:label id="lblActionLabel2" Runat="server"></asp:label></td>
				</tr>
				<tr>
					<td colSpan="2"><asp:table id="tblRoles" Runat="server" Width="100%"></asp:table></td>
				</tr>
				<tr>
					<td colSpan="2"><asp:table id="tblUsers" Runat="server" Width="100%"></asp:table></td>
				</tr>
			</table>
			<!-- This hyperlink here is only used to get the CssClass attribute for 
			 the dynamically  generated hyperlinks on this page. It will never be populated.
			 This allows customization without the need to rebuild the .Net component -->
			<asp:hyperlink id="hlCssFormat" Runat="server" CssClass="darklinks"></asp:hyperlink></form>
	</body>
</HTML>
