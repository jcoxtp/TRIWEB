<%@ Import Namespace="TeamSummary" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="EditBanner.ascx.cs" Inherits="TeamSummary.EditBanner" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table cellSpacing="0" cellPadding="0" width="100%" border="0" class="page-header">
	<tr>
		<td vAlign="bottom" align="left" width="130"><asp:image id="imgLogo" Runat="server" ImageUrl="../images/logo.gif"></asp:image></td>
		<td vAlign="bottom" align="left">
			<asp:datalist id="tabs" runat="server" RepeatDirection="horizontal" EnableViewState="false" CellPadding="0"
				CellSpacing="0" ItemStyle-CssClass="tab-inactive" SelectedItemStyle-CssClass="tab-active">
				<itemtemplate>
					<asp:LinkButton Runat="server" ID="lnkToPage" OnCommand="lnkToPage_Click" CommandName='<%# ((AxiaWebControls.TabItem) Container.DataItem).Name %>' CommandArgument='<%# Global.GetApplicationPath(Request) + "/" 
							+ ((AxiaWebControls.TabItem) Container.DataItem).Path %>'>
						<%# ((AxiaWebControls.TabItem) Container.DataItem).Name %>
					</asp:LinkButton>
				</itemtemplate>
				<selecteditemtemplate>
					<%# ((AxiaWebControls.TabItem) Container.DataItem).Name %>
				</selecteditemtemplate>
			</asp:datalist>
		</td>
		<td><asp:label id="lblPageTitle" Visible="False" runat="server">Axia&nbsp;Team&nbsp;Summary</asp:label></td>
		<td width="150" align="right" valign="bottom"><A id="lnkDocumentation" style="RIGHT:3px;POSITION:absolute;TOP:3px" href="javascript:void('');"
				runat="server"></A> <SPAN style="FONT-WEIGHT: bold; FONT-SIZE: 8pt; COLOR: white; FONT-FAMILY: verdana,helvetica,arial,sans serif">
			</SPAN>&nbsp;
		</td>
	</tr>
</table>
<table style="MARGIN-TOP: 1px" cellspacing="0" cellPadding="0" width="100%" border="0">
	<tr style="HEIGHT: 8px">
		<td colspan="4" class="tab-active-footer" vAlign="top" align="right">
			<asp:linkbutton id="LogOff" Visible="False" runat="server" ForeColor="White" CausesValidation="False"
				Font-Size="8pt">Log Off</asp:linkbutton></td>
	</tr>
</table>
