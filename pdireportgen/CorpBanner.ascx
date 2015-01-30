<%@ Control Language="c#" AutoEventWireup="false" Codebehind="CorpBanner.ascx.cs" Inherits="ePDICorp.CorpBanner" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table class="page-header" cellSpacing="0" cellPadding="0" width="100%" border="0" ID="Table2">
	<tr>
		<td vAlign="bottom" align="left" width="20%"><img src="../images/logo.gif"></td>
		<td width="60%" align="center"><span class="banner-text">Personal DISCernment&nbsp;Inventory</span></td>
		<td width="20%">&nbsp;</td>
	</tr>
</table>
<table style="MARGIN-TOP: 1px" cellSpacing="0" cellPadding="0" width="100%" border="0"
	ID="Table3">
	<tr>
		<td class="tab-active-footer" vAlign="middle" align="right" colSpan="4">
			<asp:Label style="COLOR:white;BACKGROUND-COLOR:#663333" id="lblLoggedIn" runat="server">Logged In:</asp:Label>
			<asp:LinkButton style="COLOR:white;BACKGROUND-COLOR:#663333" ID="btnLogOut" Runat="server">Log Out</asp:LinkButton>
			&nbsp;
		</td>
	</tr>
</table>
