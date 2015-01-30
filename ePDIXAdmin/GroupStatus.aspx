<%@ Register TagPrefix="uc1" TagName="BannerAndTabs" Src="BannerAndTabs.ascx" %>
<%@ Register TagPrefix="uc1" TagName="GroupEditTabs" Src="GroupEditTabs.ascx" %>
<%@ Register TagPrefix="cr" Namespace="CrystalDecisions.Web" Assembly="CrystalDecisions.Web, Version=11.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" %>
<%@ Page language="c#" Codebehind="GroupStatus.aspx.cs" AutoEventWireup="false" Inherits="ePDIXAdmin.GroupStatus" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>ePDIX Administration: Group Status</title>
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
					<TD class="page-title"><asp:linkbutton id="btnGoToGroupListing" runat="server" CssClass="pagetitle">Group Listing</asp:linkbutton>&nbsp;<span style="FONT-WEIGHT: normal; FONT-FAMILY: webdings">8</span>&nbsp;Group&nbsp;Status</TD>
					<TD></TD>
					<TD></TD>
				</TR>
				<tr>
					<td colSpan="3">&nbsp;Group By:
						<asp:DropDownList id="ddlGroupByField" runat="server" CssClass="standard-text" AutoPostBack="True">
							<asp:ListItem Value="1" Selected="True">Redeemed</asp:ListItem>
							<asp:ListItem Value="2">High Type</asp:ListItem>
							<asp:ListItem Value="3">Rep Pattern</asp:ListItem>
						</asp:DropDownList></td>
				</tr>
				<TR>
					<TD><uc1:groupedittabs id="GroupEditTabs1" runat="server"></uc1:groupedittabs>
						<TABLE class="admin-tan-border" id="tblTabs" cellSpacing="5" cellPadding="0" width="100%"
							border="0">
							<TR>
								<TD></TD>
							</TR>
							<tr>
								<td>&nbsp;
									<CR:CrystalReportViewer id="crvGroupStatusReportViewer" runat="server" AutoDataBind="true" Width="350px"
										Height="50px" HasCrystalLogo="False"></CR:CrystalReportViewer></td>
							</tr>
						</TABLE>
					</TD>
					<TD></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD></TD>
					<TD></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
