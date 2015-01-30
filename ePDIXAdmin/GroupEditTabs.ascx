<%@ Control Language="c#" AutoEventWireup="false" Codebehind="GroupEditTabs.ascx.cs" Inherits="ePDIXAdmin.GroupEditTabs" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Import Namespace="ePDIXAdmin" %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="bottom">
			<asp:datalist ID="tabs" RepeatDirection="horizontal" EnableViewState="false" runat="server" CellPadding="0"
				CellSpacing="0" ItemStyle-CssClass="admin-tab-inactive" SelectedItemStyle-CssClass="admin-tab-active">
				<itemtemplate>
					<asp:LinkButton Runat="server" ID="lnkToPage" CausesValidation="False" OnCommand="lnkToPage_Click" CommandName='<%# ((AxiaWebControls.TabItem) Container.DataItem).Name %>' CommandArgument='<%# Global.GetApplicationPath(Request) + "/" 
							+ ((AxiaWebControls.TabItem) Container.DataItem).Path %>'>
						<%# ((AxiaWebControls.TabItem) Container.DataItem).Name %>
					</asp:LinkButton>
				</itemtemplate>
				<selecteditemtemplate>
					<%# ((AxiaWebControls.TabItem) Container.DataItem).Name %>
				</selecteditemtemplate>
			</asp:datalist>
		</td>
		<TD class="admin-tab-right" vAlign="bottom" width="100%">&nbsp;</TD>
	</tr>
</table>
