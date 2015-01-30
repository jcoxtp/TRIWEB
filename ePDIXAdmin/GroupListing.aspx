<%@ Page language="c#" Codebehind="GroupListing.aspx.cs" AutoEventWireup="false" Inherits="ePDIXAdmin.GroupListing" %>
<%@ Register TagPrefix="uc1" TagName="BannerAndTabs" Src="BannerAndTabs.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>ePDIX Administration: </title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../styles/styles.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="frmPDIAdmin" method="post" runat="server">
			<uc1:bannerandtabs id="BannerAndTabs1" runat="server"></uc1:bannerandtabs>
			<TABLE id="tblMain" cellSpacing="5" cellPadding="0" width="100%" border="0">
				<TR>
					<TD class="page-title">Group Listing</TD>
					<TD></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD><asp:linkbutton id="btnNewGroup" runat="server" CssClass="link-button">Create New Group</asp:linkbutton></TD>
					<TD></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
					<TD></TD>
					<TD></TD>
				</TR>
				<tr>
					<td colSpan="3"><asp:datagrid id=dtgGroups runat="server" AutoGenerateColumns="False" DataKeyField="ID" DataSource="<%# _teams %>" AllowSorting="True" BorderWidth="0px" CellPadding="0">
							<HeaderStyle CssClass="datagrid-header"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn HeaderText="Team&amp;nbsp;Name">
									<HeaderStyle Width="300px"></HeaderStyle>
									<ItemTemplate>
										<asp:LinkButton Runat="server" CssClass="link-button" Text='<%# DataBinder.Eval(Container, "DataItem.Name") %>'>
										</asp:LinkButton>
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Name") %>'>
										</asp:TextBox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="Leader">
									<HeaderStyle Width="150px"></HeaderStyle>
									<ItemTemplate>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Leader") %>'>
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Leader") %>'>
										</asp:TextBox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="Company">
									<HeaderStyle Width="150px"></HeaderStyle>
									<ItemTemplate>
										<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Company") %>'>
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Company") %>'>
										</asp:TextBox>
									</EditItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
			</TABLE>
		</form>
	</body>
</HTML>
