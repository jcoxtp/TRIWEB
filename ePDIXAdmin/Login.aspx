<%@ Page language="c#" Codebehind="Login.aspx.cs" AutoEventWireup="false" Inherits="ePDIXAdmin.Login" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>ePDIX Administration: Login</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../styles/styles.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body onload="javascript:document.frmLogin.txtUsername.focus();">
		<form id="frmLogin" method="post" runat="server">
			<table class="page-header" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="bottom" align="left" width="130"><asp:image id="imgLogo" ImageUrl="../images/logo.gif" Runat="server"></asp:image></td>
					<td vAlign="bottom" align="left"></td>
					<td align="center"><asp:label id="lblPageTitle" runat="server" CssClass="banner-text">ePDIX Administration Pages</asp:label></td>
					<td vAlign="top" align="right" width="150">
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
			<table style="MARGIN-TOP: 1px" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr style="HEIGHT: 8px">
					<td class="tab-active-footer" vAlign="top" align="right" colSpan="4">&nbsp;</td>
				</tr>
			</table>
			<TABLE id="tblMain" cellSpacing="5" cellPadding="0" width="100%" border="0">
				<TR>
					<TD style="WIDTH: 62px"><asp:label id="Label1" runat="server" CssClass="standard-text">Username:</asp:label></TD>
					<TD><asp:textbox id="txtUsername" runat="server" CssClass="standard-text" Width="136px"></asp:textbox></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 62px"><asp:label id="Label2" runat="server">Password:</asp:label></TD>
					<TD><asp:textbox id="txtPassword" runat="server" CssClass="standard-text" Width="136px" TextMode="Password"></asp:textbox></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 62px"></TD>
					<TD><asp:button id="btnLogin" runat="server" CssClass="standard-text" Text="Login"></asp:button></TD>
					<TD></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
