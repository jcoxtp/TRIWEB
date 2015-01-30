<%@ Register TagPrefix="uc1" TagName="EditBanner" Src="EditBanner.ascx" %>
<%@ Page language="c#" Codebehind="SummaryInfo.aspx.cs" AutoEventWireup="false" Inherits="TeamSummary.SummaryInfo" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>SummaryInfo</title>
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
				<TBODY>
					<TR>
						<TD class="style1" colSpan="3">Report List</TD>
					</TR>
					<TR>
						<TD class="section-divline" colSpan="3">&nbsp;</TD>
					</TR>
					<TR>
						<TD colSpan="3">
							<asp:datalist id=listTeams runat="server" DataSource="<%# _teams %>" Width="600px">
								<HeaderTemplate>
									<table border="0" width="100%" cellspacing="0">
										<tr class="datagrid-header">
											<td>Team</td>
											<td>Leader</td>
											<td>Company</td>
										</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr class="datagrid-item">
										<td>
											<a href='ViewSummary.aspx?tID=<%# DataBinder.Eval(Container.DataItem, "ID") %>' target="_blank">
												<%# DataBinder.Eval(Container.DataItem, "Name") %>
											</a>
										</td>
										<td>
											<a href='ViewSummary.aspx?tID=<%# DataBinder.Eval(Container.DataItem, "ID") %>' target="_blank">
												<%# DataBinder.Eval(Container.DataItem, "Leader") %>
											</a>
										</td>
										<td>
											<a href='ViewSummary.aspx?tID=<%# DataBinder.Eval(Container.DataItem, "ID") %>' target="_blank">
												<%# DataBinder.Eval(Container.DataItem, "Company") %>
											</a>
										</td>
									</tr>
								</ItemTemplate>
								<AlternatingItemTemplate>
									<tr class="datagrid-alternatingitem">
										<td>
											<a href='ViewSummary.aspx?tID=<%# DataBinder.Eval(Container.DataItem, "ID") %>' target="_blank">
												<%# DataBinder.Eval(Container.DataItem, "Name") %>
											</a>
										</td>
										<td>
											<a href='ViewSummary.aspx?tID=<%# DataBinder.Eval(Container.DataItem, "ID") %>' target="_blank">
												<%# DataBinder.Eval(Container.DataItem, "Leader") %>
											</a>
										</td>
										<td>
											<a href='ViewSummary.aspx?tID=<%# DataBinder.Eval(Container.DataItem, "ID") %>' target="_blank">
												<%# DataBinder.Eval(Container.DataItem, "Company") %>
											</a>
										</td>
									</tr>
								</AlternatingItemTemplate>
								<FooterTemplate>
									</TABLE>
								</FooterTemplate>
							</asp:datalist>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</form>
	</body>
</HTML>
