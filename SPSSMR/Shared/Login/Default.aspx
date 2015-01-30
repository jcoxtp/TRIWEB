<%@ OutputCache Location="none" %>
<%@ Page language="c#" Codebehind="Default.aspx.cs" Inherits="Spss.Dimensions.Web.Authentication.Default" AutoEventWireup="false" EnableViewState="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>SPSS DimensionNet</title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="/SPSSMR/shared/spssmrNet.css" type="text/css" rel="STYLESHEET">
		<script type="text/javascript">
		<!--
			// This will ensure that postbacks will stay in the same window
			// if the page is displayed in a modal dialog in IE
			function setThisWindowAsPostTarget() {
				window.name = "spss.login."+Number(new Date()).toString();
				document.frmInfo.target=window.name;
			}
			setTimeout('setThisWindowAsPostTarget()',50);
			
			function DisableLoginButton()
			{
				document.getElementById("btnLoginHidden").click();
				document.getElementById("btnLogin").disabled=true;
				return false;
			}
		-->
		</script>
	</HEAD>
	<body topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0">
		<form id="frmInfo" method="post" runat="server">
			<table height="100%" width="100%" align="center" cellpadding="0" cellspacing="0">
				<tr valign="top" class="logo" height="20px">
					<td align="left" colspan="3" class="DarkBlueBackground">
						<img src="images\logo.gif">
					</td>
				</tr>
				<tr vAlign="middle">
					<td vAlign="middle">
						<div align="center">
							<table class="PaleBlueBackground Table" cellpadding="5">
								<tr>
									<td colspan="2" align="left">
										<img src="images/chevron_small.gif" width="7" height="11">&nbsp;<asp:Label ID="lblTitle" Runat="server" CssClass="HeaderText"></asp:Label><br><br>
									</td>
								</tr>
								<asp:Panel ID="panelError" Runat="server">
									<TR>
										<TD colSpan="2"><asp:label id="lblError" CssClass="errorText" Runat="server"></asp:label><BR>
										</TD>
									</TR>
								</asp:Panel>
								<asp:Panel ID="panelLogin" Runat="server">
									<TR>
										<TD><asp:Label id="lblUserName" CssClass="LabelText" Runat="server"></asp:Label></TD>
										<TD><asp:textbox id="tbUserName" Runat="server" Width="200px"></asp:textbox></TD>
									</TR>
											<TR>
												<TD>
													<asp:Label id="lblPassword" CssClass="LabelText" Runat="server"></asp:Label></TD>
												<TD>
													<asp:textbox id="tbPassword" Runat="server" Width="200px" TextMode="Password"></asp:textbox></TD>
											</TR>
											<TR>
												<TD colSpan="2">
													<asp:CheckBox id="cbRememberMe" Runat="server" CssClass="LabelText"></asp:CheckBox></TD>
											</TR>
											<TR width="100%">
												<TD align="center" colSpan="2" id="LoginBtnCell"><BR>
														<asp:Button id="btnLogin" Runat="server" cssclass="stdbutton" Text="Login.."></asp:Button>
													</TD>
											</TR>
										</tr>
								</asp:Panel>
							</table>
							<span style="visibility: hidden"><asp:Button id="btnLoginHidden" Runat="server" OnClick="LoginUser" cssclass="stdbutton" Text="Login"></asp:Button></span>
						</div>
					</td>
					
				</tr>
			</table>
		</form>
	</body>
</HTML>
