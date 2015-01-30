<%@ Register TagPrefix="uc1" TagName="EditBanner" Src="EditBanner.ascx" %>
<%@ Page language="c#" Codebehind="LeagueManagers.aspx.cs" AutoEventWireup="false" Inherits="TeamSummary.LeagueManagers" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title></title>
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
			<table cellSpacing="1" cellPadding="0" width="100%" border="0" ID="Table1">
				<tr>
					<td><uc1:editbanner id="EditBanner1" runat="server"></uc1:editbanner></td>
				</tr>
			</table>
			<TABLE id="tblMain" cellSpacing="5" cellPadding="0" width="100%" border="0">
				<TR>
					<TD class="style1" colSpan="3">
						League Manager List</TD>
				</TR>
				<TR>
					<TD class="section-divline" colSpan="3">&nbsp;</TD>
				</TR>
				<TR>
					<TD colSpan="3">
						<asp:LinkButton id="btnCreateManager" runat="server">Create New League Manager</asp:LinkButton></TD>
				</TR>
				<TR>
					<TD class="section-divline" colSpan="3">&nbsp;</TD>
				</TR>
				<TR>
					<TD colSpan="3">&nbsp;
						<asp:DataGrid id="dtgManagers" runat="server" DataSource="<%# _managers %>" DataKeyField="ID" AutoGenerateColumns="False">
							<AlternatingItemStyle CssClass="datagrid-alternatingitem"></AlternatingItemStyle>
							<ItemStyle CssClass="datagrid-item"></ItemStyle>
							<HeaderStyle CssClass="datagrid-header"></HeaderStyle>
							<Columns>
								<asp:ButtonColumn DataTextField="UserName" HeaderText="Username"></asp:ButtonColumn>
								<asp:ButtonColumn DataTextField="Name" HeaderText="Manager"></asp:ButtonColumn>
								<asp:ButtonColumn DataTextField="Company" HeaderText="Company"></asp:ButtonColumn>
							</Columns>
						</asp:DataGrid></TD>
				</TR>
				<TR>
					<TD colSpan="3">&nbsp;</TD>
				</TR>
				<TR>
					<TD colSpan="3">
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
