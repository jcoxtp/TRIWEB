<%@ Page language="c#" Codebehind="Login.aspx.cs" AutoEventWireup="false" Inherits="TeamSummary.Login" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Axia Survey Login</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="styles.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body onload="javascript:document.frmLogin.txtUsername.focus();">
		<form id="frmLogin" method="post" runat="server">
			<table cellSpacing="0" cellPadding="0" width="100%" border="0" class="page-header">
				<tr>
					<td vAlign="bottom" align="left" width="130"><asp:image id="imgLogo" Runat="server" ImageUrl="../images/logo.gif"></asp:image></td>
					<td vAlign="bottom" align="left">
					</td>
					<td align="center"><asp:label id="lblPageTitle" runat="server" CssClass="banner-text">Team Summary</asp:label></td>
					<td width="150" align="right" valign="top">
						<table cellSpacing="0" cellPadding="0" border="0">
							<tr>
								<td vAlign="bottom" align="right"></td>
							</tr>
							<TR>
								<TD vAlign="bottom" align="right">&nbsp;&nbsp;</TD>
							</TR>
							<tr>
								<td vAlign="bottom" align="right"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table style="MARGIN-TOP: 1px" cellspacing="0" cellPadding="0" width="100%" border="0">
				<tr style="HEIGHT: 8px">
					<td colspan="4" class="tab-active-footer" vAlign="top" align="right">&nbsp;</td>
				</tr>
			</table>
			<TABLE id="tblMain" cellSpacing="5" cellPadding="0" width="100%" border="0">
				<TR>
					<TD style="WIDTH: 62px">
						<asp:Label id="Label1" runat="server" CssClass="standard-text">Username:</asp:Label></TD>
					<TD>
						<asp:TextBox id="txtUsername" runat="server" CssClass="standard-text" Width="136px"></asp:TextBox></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 62px">
						<asp:Label id="Label2" runat="server">Password:</asp:Label></TD>
					<TD>
						<asp:TextBox id="txtPassword" runat="server" CssClass="standard-text" TextMode="Password" Width="136px"></asp:TextBox></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 62px"></TD>
					<TD>
						<asp:Button id="btnLogin" runat="server" CssClass="standard-text" Text="Login"></asp:Button></TD>
					<TD></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
