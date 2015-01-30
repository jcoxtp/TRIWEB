<%@ OutputCache Location="none" %>
<%@ Page language="c#" Codebehind="ChangePswd.aspx.cs" Inherits="Spss.Dimensions.Web.Authentication.ChangePswd" AutoEventWireup="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>SPSS DimensionNet</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="../shared/spssmrNet.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0">
		<form id="frmChangePswd" method="post" runat="server">
			<table height="100%" width="100%" align="center" cellpadding="0" cellspacing="0">
				<tr valign="top" class="logo" height="20">
					<td align="left" colspan="3" class="DarkBlueBackground">
						<img src="images\logo.gif">
					</td>
				</tr>
				<tr vAlign="middle">
					<td width="30%"></td>
					<td vAlign="middle">
						<div align="center">
							<table class="PaleBlueBackground Table" cellpadding="5" width="100%">
								<tr>
									<td colspan="2" align="left">
										<img src="images/chevron_small.gif">&nbsp;<asp:Label ID="lblTitle" Runat="server" CssClass="HeaderText"></asp:Label><br>
										<br>
									</td>
								</tr>
								<asp:Panel ID="panelError" Runat="server" Visible="False">
								<tr>
									<td colSpan="2"><asp:label id="lblError" CssClass="errorText" Runat="server"></asp:label><br>
										<br>
									</td>
								</tr>
								</asp:Panel>
								<tr>
									<td colSpan="2">
										<asp:Label CssClass="LabelText" id="lblEnterDetails" runat="server"></asp:Label>
										<br>
									</td>
								</tr>
								<tr>
									<td><asp:Label CssClass="LabelText" id="lblUserName" runat="server"></asp:Label></td>
									<td align="right"><asp:textbox id="tbUserName" Runat="server" Width="200px"></asp:textbox></td>
								</tr>
								<tr>
									<td><asp:Label CssClass="LabelText" id="lblOldPassword" runat="server"></asp:Label></td>
									<td align="right"><asp:textbox id="tbOldPassword" Runat="server" Width="200px" TextMode="Password"></asp:textbox></td>
								</tr>
								<tr>
									<td><asp:Label CssClass="LabelText" id="lblNewPassword" runat="server"></asp:Label></td>
									<td align="right"><asp:textbox id="tbNewPassword" Runat="server" Width="200px" TextMode="Password"></asp:textbox></td>
								</tr>
								<tr>
									<td><asp:Label CssClass="LabelText" id="lblConfirmNewPassword" runat="server"></asp:Label></td>
									<td align="right"><asp:textbox id="tbConfirmNewPswd" Runat="server" Width="200px" TextMode="Password"></asp:textbox></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><asp:Button ID="btnChanges" Runat="server" Text="Make Changes" OnClick="MakeChanges"></asp:Button></td>
								</tr>
							</table>
						</div>
					</td>
					<td width="30%"></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
