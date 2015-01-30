<%@ Register TagPrefix="uc1" TagName="EditBanner" Src="EditBanner.ascx" %>
<%@ Register TagPrefix="cr" Namespace="CrystalDecisions.Web" Assembly="CrystalDecisions.Web, Version=11.0.3300.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" %>
<%@ Page language="c#" Codebehind="ViewSummary.aspx.cs" AutoEventWireup="false" Inherits="TeamSummary.ViewSummary" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>SummaryInfo</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="styles.css" type="text/css" rel="stylesheet">
		<script src="findDOM.js"></script>
		<script src="CtrlBehavior.js"></script>
	</HEAD>
	<body>
		<form id="Form2" method="post" runat="server">
			<table cellSpacing="1" cellPadding="0" width="100%" border="0">
				<tr>
					<td>
						<uc1:EditBanner id="EditBanner1" runat="server"></uc1:EditBanner>
					</td>
				</tr>
			</table>
			<TABLE id="tblMain" cellSpacing="5" cellPadding="0" width="100%" border="0">
				<TR>
					<TD class="style1" colSpan="3">
						<asp:HyperLink id="linkSummaryInfo" runat="server">Report List</asp:HyperLink>&nbsp;&gt;&gt; 
						Team Summary Report</TD>
				</TR>
				<TR>
					<TD class="section-divline" colSpan="3">&nbsp;</TD>
				</TR>
				<TR>
					<TD colSpan="3">
						<CR:CrystalReportViewer id="crxiTeamSummary" runat="server" AutoDataBind="true" Width="350px" Height="50px"></CR:CrystalReportViewer></TD>
				</TR>
				<TR>
					<TD colSpan="3">
						<asp:DataGrid id="DataGrid1" runat="server"></asp:DataGrid></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
