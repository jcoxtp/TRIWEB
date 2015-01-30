<%@ Page language="c#" Codebehind="Main.aspx.cs" Inherits="ManageUsers.Main" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>SPSS ManageUsers</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="../shared/spssmrNet.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="main" method="post" runat="server">
			<table height="100%" width="100%">
				<tr vAlign="middle" align="center">
					<td>
						<table id="table1" cellSpacing="0" cellPadding="0" border="0" background="shared/images/dimensionnet.gif"
							height="300">
							<tr>
								<td colspan="2" vAlign="top" width="450" height="90"></td>
							</tr>
							<tr>
								<td width="15"></td>
								<td vAlign="top" width="*">
									<table id="table2" cellSpacing="0" width="100%" border="0">
										<tr>
											<td><p><font face="Verdana"><font color="#ff0000" size="3"><b><asp:label id="lblTitle" Runat="server"></asp:label></b></font></p>
												<table width="280">
													<tr>
														<td><font size="2"><asp:label id="lblIntro" Runat="server"></asp:label></font></td>
													</tr>
												</table>
												</FONT>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr valign="bottom">
								<td colspan="2">&nbsp;&nbsp;<asp:HyperLink Target="_blank" CssClass="spsshomepagelink" ID="hlSpssHomePage" name="hlSpssHomePage"
										Runat="server"></asp:HyperLink></td>
							</tr>
							<tr>
								<td colspan="2" height="5"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
