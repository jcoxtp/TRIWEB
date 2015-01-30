<%@ Page language="c#" Codebehind="ChangePassword.aspx.cs" Inherits="Launcher.ChangePasswordClass" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>
        <%=SetDocumentTitle()%>
    </title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <link href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <base target="_top" />
  </head>
  <body>
	<base target="_top">
    <form id="ChangePassword" method="post" runat="server">
		<table height="100%" width="100%" align="center" class="style1">
				<tr vAlign="center">
					<td vAlign="center">
						<div align="center">
							<table>
								<tr>
									<td colSpan="2"><asp:label CssClass="errorText" id="lblError" Runat="server"></asp:label><br>
										<br>
									</td>
								</tr>
								<tr>
									<td colSpan="2"><asp:label id="lblInfo" Runat="server"></asp:label><br>
										<br>
									</td>
								</tr>
								<asp:Panel runat="server" id="panelUserDetails">
								<asp:panel runat="server" id="panelUser">
								<tr>
									<td><asp:label id="lblUserNameText" Runat="server"></asp:label></td>
									<td><asp:label id="lblUserName" Runat="server" Width="200px"></asp:label></td>
								</tr>
								<tr>
									<td><asp:label id="lblOldPasswordText" Runat="server"></asp:label></td>
									<td><asp:textbox id="tbOldPassword" Runat="server" Width="200px" TextMode="Password"></asp:textbox></td>
								</tr>
								</asp:panel>
								<asp:panel runat="server" id="panelDpmUser" Visible="false">
								<tr>
									<td><asp:label id="lblUserNameText2" Runat="server"></asp:label></td>
									<td><asp:dropdownlist id="ddlUsers" Runat="server" Width="200px"></asp:dropdownlist></td>
								</tr>
								</asp:panel>
								<tr>
									<td><asp:label id="lblNewPasswordText" Runat="server"></asp:label></td>
									<td><asp:textbox id="tbNewPassword" Runat="server" Width="200px" TextMode="Password"></asp:textbox></td>
								</tr>
								<tr>
									<td><asp:label id="lblConfirmNewPasswordText" Runat="server"></asp:label></td>
									<td><asp:textbox id="tbConfirmNewPswd" Runat="server" Width="200px" TextMode="Password"></asp:textbox></td>
								</tr>
								<tr>
									<td></td>
									<td align="right"><br>
										<INPUT class="stdbutton" style="width: 100px" id="btnCancel" onclick="window.close();" type="button" name="btnCancel" runat="server">&nbsp;
										<asp:Button cssclass="stdbutton" style="width: 100px" ID="btnChanges" Runat="server" OnClick="MakeChanges"></asp:Button></td>
								</tr>
								</asp:Panel>
								<asp:Panel id="panelResults" runat="server" Visible="false">
									<tr>
										<td></td>
										<td align="right"><br>
											<INPUT class="stdbutton" id="btnOK" onclick="window.close();" type="button" name="btnOK" runat="server"></td>
									</tr>
								</asp:Panel>
								<tr height="33%">
									<td colspan="2"></td>
								</tr>
							</table>
							</asp:Panel>
						</div>
					</td>
				</tr>
			</table>
     </form>
	
  </body>
</html>
