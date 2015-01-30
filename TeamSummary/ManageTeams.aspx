<%@ Register TagPrefix="uc1" TagName="EditBanner" Src="EditBanner.ascx" %>
<%@ Page language="c#" Codebehind="ManageTeams.aspx.cs" AutoEventWireup="false" Inherits="TeamSummary.ManageTeams" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>ManageTeams</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="styles.css" type="text/css" rel="stylesheet">
		<script src="findDOM.js"></script>
		<script src="CtrlBehavior.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table cellSpacing="1" cellPadding="0" width="100%" border="0">
				<tr>
					<td><uc1:editbanner id="EditBanner1" runat="server"></uc1:editbanner></td>
				</tr>
			</table>
			<TABLE id="tblMain" cellSpacing="5" cellPadding="0" width="100%" border="0">
				<TR>
					<TD class="style1" colSpan="3">Team List</TD>
				</TR>
				<TR>
					<TD class="section-divline" colSpan="3">&nbsp;</TD>
				</TR>
				<TR>
					<TD colSpan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<asp:linkbutton id="btnCreateTeam" runat="server">Create New Team</asp:linkbutton></TD>
				</TR>
				<TR>
					<TD class="section-divline" colSpan="3">&nbsp;</TD>
				</TR>
				<TR>
					<TD colSpan="3"><asp:datagrid id=dtgTeams runat="server" DataKeyField="ID" DataSource="<%# dtTeams %>" AutoGenerateColumns="False" Width="600px">
							<AlternatingItemStyle CssClass="datagrid-alternatingitem"></AlternatingItemStyle>
							<ItemStyle CssClass="datagrid-item"></ItemStyle>
							<HeaderStyle CssClass="datagrid-header"></HeaderStyle>
							<Columns>
								<asp:ButtonColumn DataTextField="Name" HeaderText="Team" CommandName="GoToTeam"></asp:ButtonColumn>
								<asp:ButtonColumn DataTextField="Leader" HeaderText="Leader" CommandName="GoToTeam">
									<ItemStyle HorizontalAlign="Left"></ItemStyle>
								</asp:ButtonColumn>
								<asp:ButtonColumn DataTextField="Company" HeaderText="Company" CommandName="GoToTeam"></asp:ButtonColumn>
							</Columns>
						</asp:datagrid></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
